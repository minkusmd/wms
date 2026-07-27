unit SearchDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, cxCurrencyEdit, StdCtrls,
  cxTextEdit, cxDropDownEdit, ExtCtrls, DialogTitle, cxMRUEdit, cxButtons, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxMaskEdit, cxClasses,
  dxUIAClasses;

type
  TSearchDialogGetCriteriaInfo = procedure(const CriteriaIndex: integer; var outCriteriaIsNumeric: Boolean;
    var outCriteriaDescription: string) of object;

  TfrmSearchDialog = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnButtons: TPanel;
    pnGeneral: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cmbCriteria: TcxComboBox;
    lbCriteriaInfo: TLabel;
    pnGoodsSearchOptions: TPanel;
    cbSearchOption_CurrentGroup: TCheckBox;
    cbSearchOption_Available: TCheckBox;
    cbSearchOption_Defect: TCheckBox;
    cbSearchOption_Admin: TCheckBox;
    cbSearchOption_SumRange: TCheckBox;
    lbPrice: TLabel;
    edSum_Start: TcxCurrencyEdit;
    edSum_End: TcxCurrencyEdit;
    edSearchText: TcxMRUEdit;
    btnCancel: TcxButton;
    btnSearch: TcxButton;
    procedure cmbCriteriaPropertiesChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure cbSearchOption_SumRangeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOnGetCriteriaDescription: TSearchDialogGetCriteriaInfo;
    procedure SetOnGetCriteriaDescription(const Value: TSearchDialogGetCriteriaInfo);
    function GetSelectedItemIndex: integer;
    function GetSelectedSearchText: string;
    procedure SaveSearchStates;
    procedure SavePosStates;
    procedure LoadStates;
    function GetUniqeLookupText(const Text: TStrings): string;
  public
    { Public declarations }
    function ShowModal: integer; override;
    procedure SetCaption(const DialogCaption: string);
    property SelectedItemIndex: integer read GetSelectedItemIndex;
    property SelectedSearchText: string read GetSelectedSearchText;
    property OnGetCriteriaInfo: TSearchDialogGetCriteriaInfo read FOnGetCriteriaDescription write
      SetOnGetCriteriaDescription;
  end;

implementation

uses
  SWNUtils, SWNConst, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmSearchDialog }

procedure TfrmSearchDialog.btnSearchClick(Sender: TObject);
var
  isNumeric: Boolean;
  S, S2: string;
  ok: Boolean;
begin
  S := Trim(edSearchText.Text);
  if S <> '' then
  begin
    ok := True;
    isNumeric := False;
    if Assigned(FOnGetCriteriaDescription) then
      FOnGetCriteriaDescription(integer(cmbCriteria.Properties.Items.Objects[cmbCriteria.ItemIndex]), isNumeric, S2);

    if isNumeric then
    begin
      if (pos('X', S) > 0) or (pos('$', S) > 0) then
        ok := False
      else
        ok := StrToIntDef(S, 0) > 0;
      if not ok then
        ShowErrorDialog(cMSG_GeneralError_Title, S2 + ' Este necesar un cod numeric.');
    end;

    if ok then
    begin
      edSearchText.Properties.LookupItems.Add(edSearchText.Text);
      SaveSearchStates;
      ModalResult := mrOk;
    end;
  end
  else
    ShowErrorDialog(cMSG_SEARCH_EmptyError_Title, cMSG_SEARCH_EmptyError_Text);
end;

procedure TfrmSearchDialog.cbSearchOption_SumRangeClick(Sender: TObject);
var
  f: Boolean;
begin
  f := cbSearchOption_SumRange.Checked;
  lbPrice.Enabled := f;
  edSum_Start.Enabled := f;
  edSum_End.Enabled := f;
end;

procedure TfrmSearchDialog.cmbCriteriaPropertiesChange(Sender: TObject);
var
  S: string;
  isNumeric: Boolean;
begin
  if (cmbCriteria.ItemIndex >= 0) and Assigned(FOnGetCriteriaDescription) then
  begin
    S := '';
    isNumeric := False;
    if Assigned(FOnGetCriteriaDescription) then
      FOnGetCriteriaDescription(integer(cmbCriteria.Properties.Items.Objects[cmbCriteria.ItemIndex]), isNumeric, S);

    lbCriteriaInfo.Caption := S;
  end;
end;

procedure TfrmSearchDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SavePosStates;
end;

procedure TfrmSearchDialog.FormShow(Sender: TObject);
begin
  edSearchText.SetFocus;
end;

function TfrmSearchDialog.GetSelectedItemIndex: integer;
begin
  Result := integer(cmbCriteria.Properties.Items.Objects[cmbCriteria.ItemIndex]);
end;

function TfrmSearchDialog.GetSelectedSearchText: string;
var
  S: string;
begin
  S := UpperCase(edSearchText.Text);
  S := StringReplace(S, '  ', ' ', [rfReplaceAll]);
  S := StringReplace(S, ' AND ', ' ', [rfReplaceAll]);
  Result := Trim(S);
end;

function TfrmSearchDialog.GetUniqeLookupText(const Text: TStrings): string;
var
  List: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  try
    List.Sorted := True;
    List.Duplicates := dupIgnore;
    for i := 0 to Text.Count - 1 do
      List.Add(Text[i]);
    Result := List.Text;
  finally
    List.Free;
  end;
end;

procedure TfrmSearchDialog.LoadStates;
var
  S: string;
  N: integer;
begin
  if (not Assigned(Owner)) or (Owner.Name = '') then
    Exit;

  AppUserConfigStorage.OpenSection(Owner.Name);
  try
    if AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
      Position := poDesigned;
  finally
    AppUserConfigStorage.CloseSection;
  end;

  S := Owner.Name + Self.Name + 'LookupItems';
  edSearchText.Properties.LookupItems.Text := AppUserTempConfigStorage.TextValues.GetValue(S);
  S := Owner.Name + Self.Name + 'LookupItemIndex';
  N := AppUserTempConfigStorage.IntValues.GetValue(S);
  if (N >= 0) and (N < cmbCriteria.Properties.Items.Count) then
    cmbCriteria.ItemIndex := N;
end;

procedure TfrmSearchDialog.SavePosStates;
begin
  if (not Assigned(Owner)) or (Owner.Name = '') then
    Exit;
  AppUserConfigStorage.OpenSection(Owner.Name);
  try
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmSearchDialog.SaveSearchStates;
var
  S: string;
begin
  if (not Assigned(Owner)) or (Owner.Name = '') then
    Exit;

  S := Owner.Name + Self.Name + 'LookupItems';
  AppUserTempConfigStorage.TextValues.SetValue(S, GetUniqeLookupText(edSearchText.Properties.LookupItems));
  S := Owner.Name + Self.Name + 'LookupItemIndex';
  AppUserTempConfigStorage.IntValues.SetValue(S, cmbCriteria.ItemIndex);
end;

procedure TfrmSearchDialog.SetCaption(const DialogCaption: string);
begin
  Caption := DialogCaption;
  dtDialogTitle.Title := DialogCaption;
end;

procedure TfrmSearchDialog.SetOnGetCriteriaDescription(const Value: TSearchDialogGetCriteriaInfo);
begin
  FOnGetCriteriaDescription := Value;
end;

function TfrmSearchDialog.ShowModal: integer;
begin
  LoadStates;
  Result := inherited ShowModal;
end;

end.

