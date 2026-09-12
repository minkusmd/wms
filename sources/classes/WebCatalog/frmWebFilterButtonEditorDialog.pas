unit frmWebFilterButtonEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls,
  cxButtonEdit, cxMaskEdit, cxDropDownEdit, cxTextEdit, cxDBEdit, ExtCtrls, DialogTitle, cxCheckBox,
  cxGroupBox, cxRadioGroup;

type
  TfrmWebFilterButtonEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edSYS_TITLE: TcxDBTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    edTITLE_ROM: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    Label4: TLabel;
    edNAV_URL: TcxDBTextEdit;
    Label5: TLabel;
    cmbStyle: TcxComboBox;
    Label6: TLabel;
    beCUSTOM_FILTER: TcxButtonEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cbFLG_ACTIVE: TcxDBCheckBox;
    cbFLG_USE_FILTERS: TcxDBCheckBox;
    rgFLG_FILTER_BY_VALUE: TcxDBRadioGroup;
    procedure beCUSTOM_FILTERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewButton: Boolean;
    function CheckInputParams: Boolean;
    procedure SetCreateNewButton(const Value: Boolean);
    procedure ShowSelectCustomFilter;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewButton: Boolean read fCreateNewButton write SetCreateNewButton;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNConst, DB, SWNUtils, frmWebFiltersDialog;

{$R *.dfm}
{ TfrmWebFilterButtonEditorDlg }

procedure TfrmWebFilterButtonEditorDlg.beCUSTOM_FILTERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if (AButtonIndex = 0) then
    ShowSelectCustomFilter
  else if (AButtonIndex = 1) then
  begin
    fMasterDataSet.FieldByName('CUSTOM_FILTERID').Value := NULL;
    beCUSTOM_FILTER.Text := '';
  end;
end;

function TfrmWebFilterButtonEditorDlg.CheckInputParams: Boolean;
var
  Errors: String;
  S: String;
  k: Integer;
begin
  Result := False;
  Errors := '';

  if fMasterDataSet.FieldByName('SYS_TITLE').IsNull or (fMasterDataSet.FieldByName('SYS_TITLE').AsString = '') then
    AddErrorToStr(Errors, 'Denumirea de sistem!');

  if fMasterDataSet.FieldByName('TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('TITLE_ROM').AsString = '') then
    AddErrorToStr(Errors, 'Denumirea butonului in romana!');

  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('TITLE_RUS').AsString = '') then
    AddErrorToStr(Errors, 'Denumirea butonului in rusa!');

  if fMasterDataSet.FieldByName('NAV_URL').IsNull or (fMasterDataSet.FieldByName('NAV_URL').AsString = '') then
    AddErrorToStr(Errors, 'Adresa paginii Web!')
  else
  begin
    // detect absolute url
    S := LowerCase(fMasterDataSet.FieldByName('NAV_URL').AsString);
    k := pos('fantastic.md/', S);
    if (k > 0) then
    begin
      Delete(S, 1, k + 8);
      k := pos('&filters=', S);
      if (k > 0) then
        Delete(S, k, Length(S));
      fMasterDataSet.FieldByName('NAV_URL').AsString := S;
    end;
  end;

  if fMasterDataSet.FieldByName('STYLE_INDEX').IsNull or (fMasterDataSet.FieldByName('STYLE_INDEX').AsInteger = 0) then
    AddErrorToStr(Errors, 'Stilul butonului!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmWebFilterButtonEditorDlg.BindingDataSource;
begin
  fCreateNewButton := False;

  cbFLG_ACTIVE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_USE_FILTERS.DataBinding.DataSource := fMasterDataSource;
  edSYS_TITLE.DataBinding.DataSource := fMasterDataSource;
  edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  edNAV_URL.DataBinding.DataSource := fMasterDataSource;
  rgFLG_FILTER_BY_VALUE.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebFilterButtonEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckInputParams then
  begin
    fMasterDataSet.FieldByName('STYLE_INDEX').AsInteger := cmbStyle.ItemIndex + 1;
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmWebFilterButtonEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewButton then
    begin
      dtDialogTitle.Text := 'Creare buton nou';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_ACTIVE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_USE_FILTERS').AsInteger := 1;
      fMasterDataSet.FieldByName('STYLE_INDEX').AsInteger := 1;
      cmbStyle.ItemIndex := 0;
      beCUSTOM_FILTER.Text := '';
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare date';
      beCUSTOM_FILTER.Text := fMasterDataSet.FieldByName('CUSTOM_FILTER_TITLE_RUS').AsString;
      cmbStyle.ItemIndex := fMasterDataSet.FieldByName('STYLE_INDEX').AsInteger - 1;
      fMasterDataSet.Edit;
    end;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebFilterButtonEditorDlg.SetCreateNewButton(const Value: Boolean);
begin
  fCreateNewButton := Value;
end;

procedure TfrmWebFilterButtonEditorDlg.ShowSelectCustomFilter;
var
  dialog: TfrmWebFiltersDlg;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.SelectMode := True;
    if dialog.SelectFilterParam(fMasterDataSet.FieldByName('CUSTOM_FILTERID').AsInteger) then
    begin
      fMasterDataSet.FieldByName('CUSTOM_FILTERID').AsInteger := dialog.FilterID;
      beCUSTOM_FILTER.Text := dialog.FilterNameRus;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFilterButtonEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
