unit frmDescriptionTemplateEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle,
  ExtCtrls, StdCtrls, cxDBEdit, Data.DB, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit,
  dxUIAClasses;

type
  TfrmDescriptionTemplateEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE_ROM: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    Label2: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fCreateNewTemplate: Boolean;
    procedure SetCreateNewTemplate(const Value: Boolean);
    function CheckInputParams: Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    ParentID: Integer;
    { Public declarations }
    property CreateNewTemplate: Boolean read fCreateNewTemplate write SetCreateNewTemplate;
  end;

implementation

uses
  SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmDescriptionTemplateEditorDlg }

function TfrmDescriptionTemplateEditorDlg.CheckInputParams: Boolean;
var
  ErrorStr: string;
begin
  Result := false;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('TITLE_ROM').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumirea!');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('TITLE_RUS').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire!');

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmDescriptionTemplateEditorDlg.BindingDataSource;
begin
  edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmDescriptionTemplateEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := false;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end;
end;

procedure TfrmDescriptionTemplateEditorDlg.Prepare;
begin
  if not fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  if fCreateNewTemplate then
  begin
    dtDialogTitle.Text := 'Creare sablon nou';
    fMasterDataSet.Insert;
    fMasterDataSet.FieldByName('PARENTID').AsInteger := ParentID;
  end
  else
  begin
    dtDialogTitle.Text := 'Modificare inregistrare';
    fMasterDataSet.Edit;
  end;
end;

procedure TfrmDescriptionTemplateEditorDlg.SetCreateNewTemplate(const Value: Boolean);
begin
  fCreateNewTemplate := Value;
end;

procedure TfrmDescriptionTemplateEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.

