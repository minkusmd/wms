unit frmAttributeEditorDialog;

{ Editor pentru un atribut (TS_ATTRIBUTE): NAME_RO / NAME_RU + flag-uri + ORDERNO.
  Editeaza inregistrarea curenta a grilei de atribute din editorul de tip produs.
  Valorile atributului se gestioneaza separat (grila-detaliu in editorul de tip),
  cu exceptia atributelor bifate "Valoare libera" (FLG_FREE_VALUE): acolo nu exista
  dictionar, valoarea se introduce manual pe fiecare produs. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls,
  cxDBEdit, ExtCtrls, DialogTitle, Data.DB, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxCheckBox, cxMaskEdit, cxSpinEdit;

type
  TfrmAttributeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edNAME_RO: TcxDBTextEdit;
    edNAME_RU: TcxDBTextEdit;
    edORDERNO: TcxDBSpinEdit;
    edUOM_RO: TcxDBTextEdit;
    edUOM_RU: TcxDBTextEdit;
    chkFILTERABLE: TcxDBCheckBox;
    chkVARIATION: TcxDBCheckBox;
    chkIN_NAME: TcxDBCheckBox;
    chkRECOMMENDED: TcxDBCheckBox;
    chkMULTI: TcxDBCheckBox;
    chkFREE_VALUE: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    FCreateNewItem: Boolean;
    FGoodsTypeID: Integer;
    function CheckParams: Boolean;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmAttributeEditorDlg }

function TfrmAttributeEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;
  with fMasterDataSet do
  begin
    if FieldByName('NAME_RO').IsNull or (Trim(FieldByName('NAME_RO').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Denumire RO!');
    if FieldByName('NAME_RU').IsNull or (Trim(FieldByName('NAME_RU').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Denumire RU!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmAttributeEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewItem := False;
  FGoodsTypeID := 0;
  edNAME_RO.DataBinding.DataSource := fMasterDataSource;
  edNAME_RU.DataBinding.DataSource := fMasterDataSource;
  edORDERNO.DataBinding.DataSource := fMasterDataSource;
  edUOM_RO.DataBinding.DataSource := fMasterDataSource;
  edUOM_RU.DataBinding.DataSource := fMasterDataSource;
  chkFILTERABLE.DataBinding.DataSource := fMasterDataSource;
  chkVARIATION.DataBinding.DataSource := fMasterDataSource;
  chkIN_NAME.DataBinding.DataSource := fMasterDataSource;
  chkRECOMMENDED.DataBinding.DataSource := fMasterDataSource;
  chkMULTI.DataBinding.DataSource := fMasterDataSource;
  chkFREE_VALUE.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmAttributeEditorDlg.Prepare;
begin
  if FCreateNewItem then
  begin
    dtDialogTitle.Text := 'Atribut nou';
    var RecCnt := fMasterDataSet.RecordCount;
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger := FGoodsTypeID;
    fMasterDataSet.FieldByName('FLG_FILTERABLE').AsInteger := 1;
    fMasterDataSet.FieldByName('FLG_VARIATION').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_IN_NAME').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_RECOMMENDED').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_MULTI').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_FREE_VALUE').AsInteger := 0;
    fMasterDataSet.FieldByName('ORDERNO').AsInteger := RecCnt + 1; { trigger aloca ordinea }
  end
  else
  begin
    dtDialogTitle.Text := 'Modifica atributul';
    fMasterDataSet.Edit;
  end;
end;

function TfrmAttributeEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmAttributeEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.
