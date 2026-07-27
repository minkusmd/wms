unit frmPromoGoodsAddGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  StdCtrls, DB, IBC, MemDS, cxButtonEdit,
  cxDBEdit, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxImage;

type
  TfrmPromoGoodsAddGoodsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    imgGoodsImage: TcxDBImage;
    cxLabel1: TLabel;
    edGOODSID: TcxDBTextEdit;
    cxLabel2: TLabel;
    deDATA_START: TcxDBDateEdit;
    deDATA_END: TcxDBDateEdit;
    IBCQueryImage: TIBCQuery;
    beGOODS_NAME: TcxButtonEdit;
    IBCDataSourceImage: TIBCDataSource;
    cbMakeDefault: TCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure deGOODS_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fHasDefault: Boolean;
    fDefaultDateStart: TDate;
    fDefaultDateEnd: TDate;
    fLastGoodsID: integer;
    fCreateNewRecord: Boolean;
    function CheckParams:Boolean;
    procedure ShowSelectGoodsDialog;
    procedure LoadImageForGoods;
  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewRecord:Boolean read fCreateNewRecord write fCreateNewRecord;

    property HasDefault:Boolean read fHasDefault;
    property DefaultDateStart:TDate read fDefaultDateStart write fDefaultDateStart;
    property DefaultDateEnd:TDate read fDefaultDateEnd write fDefaultDateEnd;
    property LastGoodsID:integer read fLastGoodsID write fLastGoodsID;
  end;


implementation

uses SWNUtils, SWNConst, frmGoods;

{$R *.dfm}

{ TfrmPromoGoodsAddGoodsDlg }

function TfrmPromoGoodsAddGoodsDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('GOODSID').IsNull then AddErrorToStr(ErrorStr,'Товар не выбран!');
     if fMasterDataSet.FieldByName('DATA_START').IsNull or fMasterDataSet.FieldByName('DATA_END').IsNull then AddErrorToStr(ErrorStr,'Интервал для промо акции!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmPromoGoodsAddGoodsDlg.deGOODS_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     ShowSelectGoodsDialog;
end;

procedure TfrmPromoGoodsAddGoodsDlg.BindingDataSource;
begin
     inherited;

     fCreateNewRecord:=False;

     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     deDATA_START.DataBinding.DataSource:=fMasterDataSource;
     deDATA_END.DataBinding.DataSource:=fMasterDataSource;

     IBCQueryImage.Connection:=fIBCConnection;
     IBCQueryImage.MasterSource:=fMasterDataSource;

     fHasDefault:=False;
     fDefaultDateStart:=0;
     fDefaultDateEnd:=0;
     fLastGoodsID:=-1;
end;

function TfrmPromoGoodsAddGoodsDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          if fMasterDataSet.State in dsEditModes then fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          fLastGoodsID:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
          if cbMakeDefault.Checked then
          begin
               fHasDefault:=True;
               fDefaultDateStart:=fMasterDataSet.FieldByName('DATA_START').AsDateTime;
               fDefaultDateEnd:=fMasterDataSet.FieldByName('DATA_END').AsDateTime;
          end;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmPromoGoodsAddGoodsDlg.LoadImageForGoods;
begin
     IBCQueryImage.Close;
     IBCQueryImage.Open;
end;

procedure TfrmPromoGoodsAddGoodsDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             fMasterDataSet.Append;

             if (fDefaultDateStart=0) or (fDefaultDateEnd=0) then
             begin
                  fMasterDataSet.FieldByName('DATA_START').AsDateTime:=NOW;
                  fMasterDataSet.FieldByName('DATA_END').AsDateTime:=NOW+14;
             end
             else
             begin
                  fMasterDataSet.FieldByName('DATA_START').AsDateTime:=fDefaultDateStart;
                  fMasterDataSet.FieldByName('DATA_END').AsDateTime:=fDefaultDateEnd;
             end;
        end
        else
        begin
             beGOODS_NAME.Text:=fMasterDataSet.FieldByName('GOODS_NAME').AsString;
             LoadImageForGoods;
             fMasterDataSet.Edit;
        end;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmPromoGoodsAddGoodsDlg.ShowSelectGoodsDialog;
var dialog:TfrmGoodsBrowser;
    N:integer;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        N:=-1;
        if (Not fMasterDataSet.FieldByName('GOODSID').IsNull)
         then N:=fMasterDataSet.FieldByName('GOODSID').AsInteger
         else if fLastGoodsID<>-1 then N:=fLastGoodsID;

        if dialog.SelectGoods(N,False,0,'Выбор товара для промо акции') then
        begin
             fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
             beGOODS_NAME.Text:=dialog.GoodsTitle;
             LoadImageForGoods;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmPromoGoodsAddGoodsDlg.WhenCancelForm;
begin
     if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
