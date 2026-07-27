unit frmDescriptionLinkButtonEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, DB, DBAccess, IBC, MemDS, dxUIAClasses;

type
  TfrmDescriptionLinkButtonEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    cmbFILTER_BUTTON_ID: TcxDBLookupComboBox;
    IBCQueryButtons: TIBCQuery;
    IBCDataSourceButtons: TIBCDataSource;
  private
    { Private declarations }
    fCreateNewButton: Boolean;
    FTemplateID: integer;
    FStructID: integer;
    procedure SetCreateNewButton(const Value: Boolean);
    function CheckInputParams: Boolean;
    procedure SetStructID(const Value: integer);
    procedure SetTemplateID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewButton: Boolean read fCreateNewButton write SetCreateNewButton;
    property TemplateID: integer read FTemplateID write SetTemplateID;
    property StructID: integer read FStructID write SetStructID;
  end;

implementation

uses DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmDescriptionLinkButtonEditorDlg }

function TfrmDescriptionLinkButtonEditorDlg.CheckInputParams: Boolean;
var
  Errors: String;
begin
  Result := False;
  Errors := '';

  if fMasterDataSet.FieldByName('FILTER_BUTTON_ID').IsNull then
    AddErrorToStr(Errors, 'Кнопка!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmDescriptionLinkButtonEditorDlg.BindingDataSource;
begin
  cmbFILTER_BUTTON_ID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmDescriptionLinkButtonEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end;
end;

procedure TfrmDescriptionLinkButtonEditorDlg.Prepare;
begin
  if fCreateNewButton then
  begin
    dtDialogTitle.Text := 'Добавление новой кнопки';
    fMasterDataSet.Insert;
    fMasterDataSet.FieldByName('TEMPLATEID').AsInteger := FTemplateID;
    fMasterDataSet.FieldByName('STRUCTID').AsInteger := FStructID;
  end
  else
  begin
    dtDialogTitle.Text := 'Изменение информации';
    fMasterDataSet.Edit;
  end;
  IBCQueryButtons.Active := True;
end;

procedure TfrmDescriptionLinkButtonEditorDlg.SetCreateNewButton(const Value: Boolean);
begin
  fCreateNewButton := Value;
end;

procedure TfrmDescriptionLinkButtonEditorDlg.SetStructID(const Value: integer);
begin
  FStructID := Value;
end;

procedure TfrmDescriptionLinkButtonEditorDlg.SetTemplateID(const Value: integer);
begin
  FTemplateID := Value;
end;

procedure TfrmDescriptionLinkButtonEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.
