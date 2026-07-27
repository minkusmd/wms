unit frmGoodsKitGoodsEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  SWNBaseUnit, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxDropDownEdit, cxCalc, cxDBEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, DialogTitle, cxCheckBox, dxUIAClasses, dxCoreGraphics;

type
  TfrmGoodsKitGoodsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    beGoods: TcxButtonEdit;
    ceQTY: TcxDBCalcEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cbFLG_ACTIVE: TcxDBCheckBox;
    cbFLG_MODIFY_QTY: TcxDBCheckBox;
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    CurrentGoodsID: Integer;
    FCreateNewRecord: Boolean;
    { Private declarations }
    procedure SetupQtyFields;
    function CheckValues: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SelectGoods;
    procedure BurstAddGoods(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer);

  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

{$R *.dfm}

uses
  DB, DataModuleAdditions, SWNValueStorageUnit, SWNConst, SWNUtils, frmGoods, DataModuleDB;

{ TfrmGoodsKitGoodsEditorDlg }

procedure TfrmGoodsKitGoodsEditorDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex:
  Integer);
begin
  SelectGoods;
end;

function TfrmGoodsKitGoodsEditorDlg.CheckValues: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if fMasterDataSet.FieldByName('GOODSID').IsNull or (fMasterDataSet.FieldByName('GOODSID').asInteger
    <= 0) then
    AddErrorToStr(Errors, 'Denumirea!');
  if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').AsFloat < 0) then
    AddErrorToStr(Errors, 'Cantitatea!');

  if (Errors = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmGoodsKitGoodsEditorDlg.BindingDataSource;
begin
  ceQTY.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACTIVE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_MODIFY_QTY.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmGoodsKitGoodsEditorDlg.BurstAddGoods(const GoodsID: Integer;
  const GoodsTitle: string; var Added: Boolean; var Count: Integer);
begin
      try
      if not (MasterDataSet.State in [dsEdit, dsInsert]) then
        MasterDataSet.Append;

      MasterDataSet.FieldByName('QTY').AsFloat := 1;
      MasterDataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
      MasterDataSet.FieldByName('FLG_GROUP').AsInteger := 0;
      MasterDataSet.FieldByName('FLG_MODIFY_QTY').AsInteger := 1;
      MasterDataSet.FieldByName('PARENTGOODS_ID').AsInteger := MasterDataSet.MasterSource.DataSet.FieldByName('GOODSID').AsInteger;
      MasterDataSet.FieldByName('UMID').AsInteger := 1;
      MasterDataSet.FieldByName('GOODSID').asInteger := GoodsID;
      MasterDataSet.FieldByName('GOODS_TITLE').AsString := GoodsTitle;

//      MasterDataSet.FieldByName('USERID').AsInteger := dmdb.CurrentUserID;
      MasterDataSet.Post;
      Added := True;
      Count := 1;
      except on e: Exception do
      begin
        Added := false;
        raise
      end;

      end;
end;

function TfrmGoodsKitGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    Result := True;
  end;
end;

procedure TfrmGoodsKitGoodsEditorDlg.Prepare;
begin
  SetupQtyFields;

  try
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrarea noua';
      CurrentGoodsID := MasterDataSet.FieldByName('GOODSID').asInteger;
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('QTY').AsFloat := 1;
      fMasterDataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_MODIFY_QTY').AsInteger := 1;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      fMasterDataSet.Edit;
      Self.ActiveControl := beGoods;
    end;
    beGoods.Text := fMasterDataSet.FieldByName('GOODS_TITLE').AsString;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    raise;
  end;
end;


procedure TfrmGoodsKitGoodsEditorDlg.SelectGoods;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.BurstMode := True;
    dialog.OnBurstAddGoods := BurstAddGoods;
    if dialog.SelectGoods(MasterDataSet.FieldByName('GOODSID').asInteger, false, 0, 'Alege produsul') then
    begin
      beGoods.Text := dialog.GoodsTitle;
      beGoods.Tag := dialog.GoodsID;
      fMasterDataSet.FieldByName('GOODSID').AsInteger := dialog.GoodsID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitGoodsEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmGoodsKitGoodsEditorDlg.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,
    cAppDefault_QtyDigits);
     // Товарные позиции: Кол-во
  TcxCalcEditProperties(ceQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmGoodsKitGoodsEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.

