unit frmAttributeValueEditorDialog;

{ Editor pentru o valoare de atribut (TS_ATTRIBUTE_VALUE): VALUE_RO / VALUE_RU.
  Editeaza inregistrarea curenta a grilei de valori din frmAttributeEditorDialog. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls,
  cxDBEdit, ExtCtrls, DialogTitle, Data.DB, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit;

type
  TfrmAttributeValueEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edVALUE_RO: TcxDBTextEdit;
    edVALUE_RU: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure edVALUE_ROExit(Sender: TObject);
  private
    FCreateNewItem: Boolean;
    FAttrID: Integer;
    function CheckParams: Boolean;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property AttrID: Integer read FAttrID write FAttrID;
    property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmAttributeValueEditorDlg }

function TfrmAttributeValueEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;
  with fMasterDataSet do
  begin
    if FieldByName('VALUE_RO').IsNull or (Trim(FieldByName('VALUE_RO').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Valoare RO!');
    if FieldByName('VALUE_RU').IsNull or (Trim(FieldByName('VALUE_RU').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Valoare RU!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmAttributeValueEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewItem := False;
  FAttrID := 0;
  edVALUE_RO.DataBinding.DataSource := fMasterDataSource;
  edVALUE_RU.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmAttributeValueEditorDlg.Prepare;
begin
  if FCreateNewItem then
  begin
    dtDialogTitle.Text := 'Valoare noua';
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('ATTRID').AsInteger := FAttrID;
  end
  else
  begin
    dtDialogTitle.Text := 'Modifica valoarea';
    fMasterDataSet.Edit;
  end;
end;

function TfrmAttributeValueEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmAttributeValueEditorDlg.edVALUE_ROExit(Sender: TObject);
begin
  { daca valoarea RU e goala, se preia automat textul din RO }
  if (Trim(edVALUE_RU.Text) = '') and (Trim(edVALUE_RO.Text) <> '') then
  begin
    if not (fMasterDataSet.State in dsEditModes) then
      fMasterDataSet.Edit;
    fMasterDataSet.FieldByName('VALUE_RU').AsString := edVALUE_RO.Text;
  end;
end;

procedure TfrmAttributeValueEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.
