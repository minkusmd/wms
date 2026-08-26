unit frmGoodsAcntEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls,
  cxDBEdit, ExtCtrls, DialogTitle,
  Data.DB,
  IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  cxCurrencyEdit, cxTextEdit, dxCoreGraphics, cxMaskEdit, cxButtonEdit;

type
  TfrmGoodsAcntEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edNAMEACNT: TcxDBTextEdit;
    Label1: TLabel;
    cePRICE_ACNT: TcxDBCurrencyEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Label2: TLabel;
    cxButtonEdit1: TcxButtonEdit;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewItem: Boolean;
    FParentID: integer;
    procedure SetCreateNewItem(const Value: Boolean);
    procedure SetParentID(const Value: integer);
    function CheckParams:Boolean;
    function GetGoodsTypeTitle(const AGoodsTypeID: integer): string;
    procedure ShowGoodsTypeInfo;
    procedure ClearGoodsType;
  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    procedure SelectGoodsCategoryDlg;
    { Public declarations }
    property ParentID:integer read FParentID write SetParentID;
    property CreateNewItem:Boolean read FCreateNewItem write SetCreateNewItem;
  end;


implementation

uses
  DataModuleDB, frmGoodsTypeDialog, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsAcntEditorDlg }

function TfrmGoodsAcntEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     with fMasterDataSet do
     begin
          if FieldByName('NAMEACNT').IsNull or (FieldByName('NAMEACNT').AsString='') then AddErrorToStr(ErrorStr,'Denumire!');
          if FieldByName('PRICE_ACNT').IsNull or (FieldByName('PRICE_ACNT').AsInteger<0) then AddErrorToStr(ErrorStr,'Pret de evidenta, lei!');
     end;
     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsAcntEditorDlg.ClearGoodsType;
begin
     if not (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Edit;
     fMasterDataSet.FieldByName('GOODS_TYPEID').Clear;
     ShowGoodsTypeInfo;
end;

procedure TfrmGoodsAcntEditorDlg.cxButtonEdit1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if AButtonIndex = 1 then ClearGoodsType
  else SelectGoodsCategoryDlg;
end;

function TfrmGoodsAcntEditorDlg.GetGoodsTypeTitle(const AGoodsTypeID: integer): string;
var q: TIBCQuery;
begin
     Result:='';
     if AGoodsTypeID<=0 then Exit;

     q:=TIBCQuery.Create(nil);
     try
        q.Connection:=dmDB.IBCConnection;
        q.Transaction:=dmDB.IBCTrDefaultSelect;
        q.SQL.Text:='SELECT TITLE FROM TS_GOODS_TYPE WHERE GOODSTYPEID = :GOODSTYPEID';
        q.ParamByName('GOODSTYPEID').AsInteger:=AGoodsTypeID;
        q.Open;
        if not q.Eof then Result:=q.Fields[0].AsString;
     finally
        q.Free;
     end;
end;

procedure TfrmGoodsAcntEditorDlg.ShowGoodsTypeInfo;
var GoodsTypeID: integer;
    F: TField;
begin
     F:=fMasterDataSet.FindField('GOODS_TYPEID');
     if (F=nil) or F.IsNull then
     begin
          cxButtonEdit1.Text:='';
          Exit;
     end;

     GoodsTypeID:=F.AsInteger;
     cxButtonEdit1.Text:=GetGoodsTypeTitle(GoodsTypeID);
     if cxButtonEdit1.Text='' then cxButtonEdit1.Text:=IntToStr(GoodsTypeID);
end;

procedure TfrmGoodsAcntEditorDlg.BindingDataSource;
begin
     inherited;
     FParentID := 0;
     FCreateNewItem := False;
     edNAMEACNT.DataBinding.DataSource:=fMasterDataSource;
     cePRICE_ACNT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsAcntEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmGoodsAcntEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewItem then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('PARENTID').AsInteger:=FParentID;
             fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=0;
             fMasterDataSet.FieldByName('PRICE_ACNT').AsInteger:=0;
             fMasterDataSet.FieldByName('PERCENT_BOUNDS').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;
        end;
        ShowGoodsTypeInfo;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmGoodsAcntEditorDlg.SelectGoodsCategoryDlg;
var d: TfrmGoodsTypeDlg;
    DefaultGoodsTypeID: integer;
    F: TField;
begin
     DefaultGoodsTypeID:=-1;
     F:=fMasterDataSet.FindField('GOODS_TYPEID');
     if (F<>nil) and (not F.IsNull) then DefaultGoodsTypeID:=F.AsInteger;

     d:=TfrmGoodsTypeDlg.Create(Self);
     try
        if d.SelectGoodsType(DefaultGoodsTypeID) and (d.GoodsTypeID>0) then
        begin
             if not (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Edit;
             fMasterDataSet.FieldByName('GOODS_TYPEID').AsInteger:=d.GoodsTypeID;
             ShowGoodsTypeInfo;
        end;
     finally
        d.Free;
     end;
end;

procedure TfrmGoodsAcntEditorDlg.SetCreateNewItem(const Value: Boolean);
begin
     FCreateNewItem := Value;
end;

procedure TfrmGoodsAcntEditorDlg.SetParentID(const Value: integer);
begin
     FParentID := Value;
end;

procedure TfrmGoodsAcntEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
