unit frmWebCatalogFilterEditorDialog;

interface

uses
  Classes, Controls, DialogTitle, Dialogs, ExtCtrls, Forms, Graphics, Messages, SWNBaseUnit, StdCtrls, SysUtils, Variants,
  Windows, cxButtonEdit, cxButtons, cxCheckBox, cxContainer, cxControls, cxDBEdit, cxEdit, cxGraphics,
  cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxTextEdit,

  Vcl.Menus, dxUIAClasses, dxCoreGraphics;

type
  TfrmWebCatalogFilterEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    beFILTERNAME: TcxButtonEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    cbFLG_ENABLED: TcxDBCheckBox;
    cbFLG_OPEN_GROUP: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beFILTERNAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beFILTERNAMEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fCreateNewFilter: Boolean;
    fCatalogID: Integer;
    function CheckInputParams: Boolean;
    procedure SetCreateNewFilter(const Value: Boolean);
    procedure SelectFilter;
    procedure SetCatalogID(const Value: Integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewFilter: Boolean read fCreateNewFilter write SetCreateNewFilter;
    property CatalogID: Integer read fCatalogID write SetCatalogID;
  end;

implementation

uses frmWebFiltersDialog, SWNUtils, SWNConst, DataModuleDB;

{$R *.dfm}
{ TfrmWebCatalogFilterEditorDlg }

procedure TfrmWebCatalogFilterEditorDlg.beFILTERNAMEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
    beFILTERNAMEPropertiesButtonClick(Sender, 0);
end;

procedure TfrmWebCatalogFilterEditorDlg.beFILTERNAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if AButtonIndex = 0 then SelectFilter
  else
  if AButtonIndex = 1 then
  begin

  end;
end;

function TfrmWebCatalogFilterEditorDlg.CheckInputParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('FILTERID').IsNull then
    AddErrorToStr(ErrorStr, 'Filtru!');

  if ErrorStr = '' then
    Result := true
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebCatalogFilterEditorDlg.BindingDataSource;
begin
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  cbFLG_OPEN_GROUP.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebCatalogFilterEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := true;
  end;
end;

procedure TfrmWebCatalogFilterEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewFilter then
    begin
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_OPEN_GROUP').AsInteger := 1;
      fMasterDataSet.FieldByName('CATALOGID').AsInteger := fCatalogID;
    end
    else
    begin
      beFILTERNAME.Text := Format('%s / %s', [fMasterDataSet.FieldByName('FILTERNAME_ROM').AsString,
        fMasterDataSet.FieldByName('FILTERNAME_RUS').AsString]);
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebCatalogFilterEditorDlg.SelectFilter;
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID: Integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
    defaultFilterID := -1;
    if Not fMasterDataSet.FieldByName('FILTERID').IsNull then
      defaultFilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
    if dialog.SelectFilterParam(defaultFilterID) then
    begin
      fMasterDataSet.FieldByName('FILTERID').AsInteger := dialog.FilterID;
      beFILTERNAME.Text := Format('%s / %s', [dialog.FilterNameRom, dialog.FilterNameRus]);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogFilterEditorDlg.SetCatalogID(const Value: Integer);
begin
  fCatalogID := Value;
end;

procedure TfrmWebCatalogFilterEditorDlg.SetCreateNewFilter(const Value: Boolean);
begin
  fCreateNewFilter := Value;
end;

procedure TfrmWebCatalogFilterEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
