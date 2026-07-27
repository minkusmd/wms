unit uCreditePromoGoodsEditorDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxCalendar, cxDBEdit, cxDropDownEdit, cxCalc, cxTextEdit, cxMaskEdit, cxButtonEdit, cxLabel,
  Vcl.ExtCtrls, SWNValueStorageUnit;

type
  TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent = procedure(const GoodsID: Integer; var Exists: Boolean) of object;

  TfrmCreditePromoGoodsEditorDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    beGoodsName: TcxButtonEdit;
    cxLabel2: TcxLabel;
    ceSuma: TcxDBCalcEdit;
    deData1: TcxDBDateEdit;
    cxLabel3: TcxLabel;
    deData2: TcxDBDateEdit;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    lbExistsError: TcxLabel;
    procedure beGoodsNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FIsNewRecord: Boolean;
    FOnVerifyGoodsExists: TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent;
    FUID: Integer;
    function GetOnVerifyGoodsExists: TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent;
    procedure SetIsNewRecord(const Value: Boolean);
    procedure SetOnVerifyGoodsExists(const Value: TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent);
    procedure SetUID(const Value: Integer);
    { Private declarations }
  protected
    function CheckParams: Boolean;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    property UID: Integer read FUID write SetUID;
    property OnVerifyGoodsExists: TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent read GetOnVerifyGoodsExists
      write SetOnVerifyGoodsExists;

    { Public declarations }
  end;

implementation

uses
  DB, frmGoods, SWNUtils;

{$R *.dfm}

procedure TfrmCreditePromoGoodsEditorDlg.beGoodsNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var dialog:TfrmGoodsBrowser;
    exists:Boolean;
    N: Integer;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);

        if not fMasterDataSet.FieldByName('GOODSID').IsNull then
        N := fMasterDataSet.FieldByName('GOODSID').AsInteger;

        if dialog.SelectGoods(N,true,0,'') then
        begin
             fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
             fMasterDataSet.FieldByName('GOODSNAME').AsString:=dialog.GoodsTitle;
             beGoodsName.Text:=dialog.GoodsTitle;
             exists:=False;
             if Assigned(FOnVerifyGoodsExists) then FOnVerifyGoodsExists(dialog.GoodsID,exists);
             lbExistsError.Visible:=exists;
             btnOk.Enabled:=Not exists;
        end;
     finally

     end;
end;

function TfrmCreditePromoGoodsEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;

  if fMasterDataSet.FieldByName('GOODSID').IsNull or (fMasterDataSet.FieldByName('GOODSID').AsFloat <= 0) then
    AddErrorToStr(ErrorStr, 'Alegeti produsul pentru actiune!');


  if fMasterDataSet.FieldByName('PREPAY_AMOUNT').IsNull or (fMasterDataSet.FieldByName('PREPAY_AMOUNT').AsFloat < 0) then
    AddErrorToStr(ErrorStr, 'Suma trebuie sa fie mai mare ca ZERO!');

  if fMasterDataSet.FieldByName('DATA1').IsNull or (fMasterDataSet.FieldByName('DATA1').AsDateTime < Date) then
    AddErrorToStr(ErrorStr, 'Data inceput actiune trebuie sa fie mai mare decit data curenta!');
  if fMasterDataSet.FieldByName('DATA2').IsNull or (fMasterDataSet.FieldByName('DATA2').AsDateTime < Date) then
    AddErrorToStr(ErrorStr, 'Data sfirsit actiune trebuie sa fie mai mare decit data curenta!');

end;

function TfrmCreditePromoGoodsEditorDlg.GetOnVerifyGoodsExists: TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent;
begin
  Result := FOnVerifyGoodsExists;
end;

function TfrmCreditePromoGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  try
    if fMasterDataSet.State in [dsEdit, dsinsert] then
      fMasterDataSet.Post;

    AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', fMasterDataSet.FieldByName('GOODSID').asInteger);
    AppUserTempConfigStorage.DateTimeValues.SetValue(Owner.Name + '_LastData2', deData2.Date);

  except on e: Exception do
  begin
    Result := False;
    fMasterDataSet.Cancel;
    beGoodsName.Text := '';
    beGoodsName.Tag := 0;
    raise;
  end;

  end;
end;

procedure TfrmCreditePromoGoodsEditorDlg.prepare;
var
  Data2: TDateTime;
begin
  if FIsNewRecord then
  begin
    fMasterDataSet.Append;
    beGoodsName.Text := '';
    beGoodsName.Tag := -1;
    Data2 := AppUserTempConfigStorage.DateTimeValues.GetValue(Owner.Name + '_LastData2', Date + 14);

    with fMasterDataSet do
    begin
      FieldByName('UID').AsInteger := UID;
      FieldByName('DATA1').AsDateTime := Date;
      FieldByName('DATA2').AsDateTime := Data2;
      FieldByName('PREPAY_AMOUNT').AsFloat := 0;
    end;
  end
  else
  begin
    fMasterDataSet.Edit;
    beGoodsName.Text := fMasterDataSet.FieldByName('GOODSNAME').AsString;
    beGoodsName.Tag := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  end;

  ceSuma.DataBinding.DataSource := fMasterDataSource;
  ceSuma.DataBinding.DataField := 'PREPAY_AMOUNT';

  deData1.DataBinding.DataSource := fMasterDataSource;
  deData1.DataBinding.DataField := 'DATA1';

  deData2.DataBinding.DataSource := fMasterDataSource;
  deData2.DataBinding.DataField := 'DATA2';

end;

procedure TfrmCreditePromoGoodsEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmCreditePromoGoodsEditorDlg.SetOnVerifyGoodsExists(const Value:
  TfrmCreditePromoGoodsEditorDlg_VerifyGoodsExistsEvent);
begin
   FOnVerifyGoodsExists := Value;
end;

procedure TfrmCreditePromoGoodsEditorDlg.SetUID(const Value: Integer);
begin
  FUID := Value;
end;

procedure TfrmCreditePromoGoodsEditorDlg.WhenCancelForm;
begin
  inherited;
  if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Cancel;
end;

end.

