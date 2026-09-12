unit frmSerialScannerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxStyles, cxCustomData, cxCheckBox, StdCtrls,
  ExtCtrls, cxTextEdit, cxMaskEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxButtonEdit, Vcl.Menus,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxContainer, cxClasses, cxGridCustomView;

type

  TOnAddSerialNumber = procedure(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
    var Added: Boolean) of object;

  TfrmSerialScannerDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridSerials: TcxGrid;
    cxGridSerialsTable: TcxGridTableView;
    cxGridSerialsTable_ENABLED: TcxGridColumn;
    cxGridSerialsTable_NO: TcxGridColumn;
    cxGridSerialsTable_SERIAL: TcxGridColumn;
    cxGridSerialsLevel: TcxGridLevel;
    pnGeneralInfo: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    edVendorWarranty: TcxMaskEdit;
    edOwnWarranty: TcxMaskEdit;
    edSelectionCount: TcxTextEdit;
    edRequiredCount: TcxTextEdit;
    lbActionInfo: TLabel;
    lbInfo: TLabel;
    pnGenerator: TPanel;
    cxLabel5: TLabel;
    cxLabel6: TLabel;
    cxLabel7: TLabel;
    cxLabel8: TLabel;
    edSerialPrefix: TcxMaskEdit;
    edSerialStartMask: TcxMaskEdit;
    edSearialSuffix: TcxMaskEdit;
    edSerialGenerateCount: TcxMaskEdit;
    cbClearList: TcxCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    beCountryID: TcxButtonEdit;
    beVendorID: TcxButtonEdit;
    pm1: TPopupMenu;
    N1: TMenuItem;
    btnGenerate: TcxButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edVendorWarrantyEnter(Sender: TObject);
    procedure edVendorWarrantyExit(Sender: TObject);
    procedure cxGridSerialsTable_ENABLEDPropertiesEditValueChanged(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure cxGridSerialsTableDataControllerDataChanged(Sender: TObject);
    procedure beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure cxGridSerialsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    fInputBuffer: String;
    fEndFlag1: Boolean;
    fAllowCapture: Boolean;
    fRequiredCount: integer;
    FOnAddSerialNumber: TOnAddSerialNumber;
    fOnBeginToAddSerials: TNotifyEvent;
    fOnEndToAddSearials: TNotifyEvent;
    FAllowZeroWarranty: Boolean;
    fCountryID: integer;
    fVendorID: integer;
    FGoodsID: integer;
    procedure ResetInputBuffer;
    procedure RegisterSerialNumber(const SerialNumber: String);
    procedure ShowInfo(const Text: String; const TextColor: TColor = clWindowText);
    function CheckParams: Boolean;
    procedure SetDefaultVendorWarranty(const Value: integer);
    procedure SelectedSerialCountChanged;
    procedure SetDefaultOwnWarranty(const Value: integer);
    procedure SetRequiredCount(const Value: integer);
    procedure SetOnAddSerialNumber(const Value: TOnAddSerialNumber);
    function DoAddSerialNumbers: Boolean;
    function CheckGenerateParams: Boolean;
    procedure GenerateSerialNumbers;
    procedure SetOnBeginToAddSerials(const Value: TNotifyEvent);
    procedure SetOnEndToAddSearials(const Value: TNotifyEvent);
    procedure SetAllowZeroWarranty(const Value: Boolean);

    procedure ShowInfoForUser;

    procedure SelectCountry;
    procedure SelectVendor;
    procedure SetGoodsID(const Value: integer);

  protected
    { protected declarations }
    procedure Prepare; override;

  public
    { Public declarations }
    property DefaultVendorWarranty: integer write SetDefaultVendorWarranty;
    property DefaultOwnWarranty: integer write SetDefaultOwnWarranty;
    property RequiredCount: integer write SetRequiredCount;
    property AllowZeroWarranty: Boolean read FAllowZeroWarranty write SetAllowZeroWarranty;
    property GoodsID: integer read FGoodsID write SetGoodsID;

    property OnBeginToAddSearials: TNotifyEvent read fOnBeginToAddSerials write SetOnBeginToAddSerials;
    property OnAddSerialNumber: TOnAddSerialNumber read FOnAddSerialNumber write SetOnAddSerialNumber;
    property OnEndToAddSearials: TNotifyEvent read fOnEndToAddSearials write SetOnEndToAddSearials;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst, frmSyssEditorWindow, DataModuleDB, Vcl.Clipbrd;

{$R *.dfm}

procedure TfrmSerialScannerDlg.beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectCountry;
end;

procedure TfrmSerialScannerDlg.beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectVendor;
end;

procedure TfrmSerialScannerDlg.btnGenerateClick(Sender: TObject);
begin
  if CheckGenerateParams then
    GenerateSerialNumbers;
end;

procedure TfrmSerialScannerDlg.btnOkClick(Sender: TObject);
begin
  if CheckParams then
  begin
    if DoAddSerialNumbers then
      ModalResult := mrOk;
  end;
end;

function TfrmSerialScannerDlg.CheckGenerateParams: Boolean;
var
  ErrorStr, S: String;
  N, Count: integer;
begin
  Result := False;
  ErrorStr := '';

  Count := 0;
  if edSerialGenerateCount.Text = '' then
    AddErrorToStr(ErrorStr, 'Setati cantitatea numerilor de serie!')
  else
  begin
    Count := StrToIntDef(edSerialGenerateCount.Text, 0);
    if Count <= 0 then
      AddErrorToStr(ErrorStr, 'Cantitatea numerilor de serie gresita!')
  end;

  if edSerialPrefix.Text = '' then
    AddErrorToStr(ErrorStr, 'Prefix!');
  if edSerialStartMask.Text = '' then
    AddErrorToStr(ErrorStr, 'Numarul pentru generare!')
  else
  begin
    N := StrToIntDef(edSerialGenerateCount.Text, 0);
    if N <= 0 then
      AddErrorToStr(ErrorStr, 'Numarul cu care incepe generarea!')
    else if Count > 0 then
    begin
      N := Length(edSerialStartMask.Text);
      S := '%' + IntToStr(N) + '.' + IntToStr(N) + 'd';
      N := StrToInt(edSerialStartMask.Text) + Count;
      S := Format(S, [N]);
      if Length(S) > Length(edSerialStartMask.Text) then
        AddErrorToStr(ErrorStr, 'Numarul final nu corespunde cu mask-a finala!')
    end;
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog('Eroare', 'Parametri incorecti pentru generare!', ErrorStr);
end;

function TfrmSerialScannerDlg.CheckParams: Boolean;
var
  ErrorStr: String;
  N: integer;
begin
  Result := False;
  ErrorStr := '';

  if (cxGridSerialsTable.DataController.RecordCount = 0) then
    AddErrorToStr(ErrorStr, 'Nu sunt serii pentru adaugare!');

  if Not FAllowZeroWarranty then
  begin
    N := StrToIntDef(edVendorWarranty.Text, 0);
    if (N < 0) then
      AddErrorToStr(ErrorStr, 'Garantia producatorului!');

    N := StrToIntDef(edOwnWarranty.Text, 0);
    if (N < 0) then
      AddErrorToStr(ErrorStr, 'Garantia vinzatorului!');
  end;

  if fCountryID < 0 then
    AddErrorToStr(ErrorStr, 'Tara de origine!');
  if fVendorID < 0 then
    AddErrorToStr(ErrorStr, 'Producator!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmSerialScannerDlg.cxGridSerialsTableDataControllerDataChanged(Sender: TObject);
begin
  ShowInfoForUser;
end;

procedure TfrmSerialScannerDlg.cxGridSerialsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridSerialsTable_ENABLED.Index] = False then
    AStyle := dmAdditions.cxStyle_SerialDisabled;
end;

procedure TfrmSerialScannerDlg.cxGridSerialsTable_ENABLEDPropertiesEditValueChanged(Sender: TObject);
begin
  SelectedSerialCountChanged;
end;

function TfrmSerialScannerDlg.DoAddSerialNumbers: Boolean;
var
  i: integer;
  Added: Boolean;
  toContinue: Boolean;
  S: String;
  hasError: Boolean;
  ow, vw: integer;
begin
  hasError := False;
  if Assigned(FOnAddSerialNumber) then
  begin
    vw := StrToInt(edVendorWarranty.Text);
    ow := StrToInt(edOwnWarranty.Text);

    if Assigned(fOnBeginToAddSerials) then
      fOnBeginToAddSerials(Self);

    cxGridSerialsTable.DataController.BeginFullUpdate;
    try
      i := 0;
      toContinue := True;
      while (i < cxGridSerialsTable.DataController.RecordCount) and toContinue do
      begin
        // add only checked items
        if cxGridSerialsTable.DataController.Values[i, cxGridSerialsTable_ENABLED.Index] = True then
        begin
          Added := False;
          S := cxGridSerialsTable.DataController.Values[i, cxGridSerialsTable_SERIAL.Index];
          FOnAddSerialNumber(S, vw, ow, fCountryID, fVendorID, Added);
          if Added then
          begin
            cxGridSerialsTable.DataController.DeleteRecord(i);
            Dec(i);
          end
          else
          begin
            toContinue := False;
            hasError := True;
            ShowInfoDialogVerification('Eroare', 'Eroare la inserarea numarului de serie' + #13#10 + S, 'Continua inserarea?',
              toContinue);
          end;
        end;
        // next record
        Inc(i);
      end;
    finally
      cxGridSerialsTable.DataController.EndFullUpdate;

      if Assigned(fOnEndToAddSearials) then
        fOnEndToAddSearials(Self);
    end;
  end;
  Result := Not hasError;
end;

procedure TfrmSerialScannerDlg.edVendorWarrantyEnter(Sender: TObject);
begin
  fAllowCapture := False;
end;

procedure TfrmSerialScannerDlg.edVendorWarrantyExit(Sender: TObject);
begin
  fAllowCapture := True;
end;

procedure TfrmSerialScannerDlg.FormCreate(Sender: TObject);
begin
  fInputBuffer := '';
  fAllowCapture := True;
  fRequiredCount := 0;
  FOnAddSerialNumber := nil;
end;

procedure TfrmSerialScannerDlg.FormKeyPress(Sender: TObject; var Key: Char);
var
  C: Char;
begin
  if fAllowCapture then
  begin
    C := UpCase(Key);
    if CharInSet(C, ['0' .. '9', 'A' .. 'Z', '-']) then
    begin
      cxGridSerialsTable_SERIAL.Selected := True;
      cxGridSerialsTable_SERIAL.Focused := True;

      ShowInfo('');
      fInputBuffer := fInputBuffer + Key;
    end
    else if (Key = #13) and (Length(fInputBuffer) > 0) then
    begin
      RegisterSerialNumber(fInputBuffer);
      ResetInputBuffer;
    end
    else
    begin
      // ShowInfo('Serie incorecta!',clRed);
      ResetInputBuffer;
    end;
  end
  else
    ResetInputBuffer;
end;

procedure TfrmSerialScannerDlg.GenerateSerialNumbers;
var
  Mask: String;
  N, Count: integer;
  StartNumber: integer;
  Serial: String;
begin
  StartNumber := StrToInt(edSerialStartMask.Text);
  Count := StrToInt(edSerialGenerateCount.Text) + StartNumber;
  N := Length(edSerialStartMask.Text);
  Mask := Format('%%%d.%dd', [N, N]);

  cxGridSerialsTable.DataController.BeginFullUpdate;
  try
    if cbClearList.Checked then
    begin
      // delete all
      for N := cxGridSerialsTable.DataController.RecordCount - 1 downto 0 do
        cxGridSerialsTable.DataController.DeleteRecord(N);
    end;

    while StartNumber < Count do
    begin
      Serial := Format('%s' + Mask + '%s', [edSerialPrefix.Text, StartNumber, edSearialSuffix.Text]);

      N := cxGridSerialsTable.DataController.AppendRecord;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_ENABLED.Index] := True;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_NO.Index] := cxGridSerialsTable.DataController.RecordCount;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_SERIAL.Index] := Serial;

      Inc(StartNumber);
    end;
  finally
    cxGridSerialsTable.DataController.EndFullUpdate;
  end;
end;

procedure TfrmSerialScannerDlg.N1Click(Sender: TObject);
var
  snlist : TStringList;
  i: Integer;
begin
  snlist := TStringList.Create;
  try
    snlist.Text := Clipboard.AsText;
    for I := 0 to snlist.Count-1 do
      RegisterSerialNumber(snlist[i]);
  finally
    snlist.Free;
  end;
end;

procedure TfrmSerialScannerDlg.Prepare;
var
  info: TGoodsInfo_VendorAndCountry;
begin
  inherited;

  fCountryID := -1;
  fVendorID := -1;
  FAllowZeroWarranty := False;
  KeyPreview := True;
  ActiveControl := cxGridSerials;

  info := dmDB.GetGoodsInfo_SN_VendorCountry(FGoodsID);
  if Assigned(info) then
  begin
    fCountryID := info.CountryID;
    beCountryID.Text := info.CountryTitle;
    fVendorID := info.VendorID;
    beVendorID.Text := info.VendorTitle;

    info.Free;
  end;
end;

procedure TfrmSerialScannerDlg.RegisterSerialNumber(const SerialNumber: String);
var
  N, i: integer;
  found: Boolean;
begin
  found := False;
  N := -1;
  // check if value was not registered already
  for i := 0 to cxGridSerialsTable.DataController.RecordCount - 1 do
    if cxGridSerialsTable.DataController.Values[i, cxGridSerialsTable_SERIAL.Index] = SerialNumber then
    begin
      N := i;
      found := True;
      break;
    end;

  if found then
  begin
    cxGridSerialsTable_SERIAL.Selected := True;
    cxGridSerialsTable_SERIAL.Focused := True;
    cxGridSerialsTable.ViewData.Rows[N].Focused := True;
    ShowInfo('Numarul de serie ' + SerialNumber + ' deja este in lista!', clRed);
  end
  else
  begin
    N := cxGridSerialsTable.DataController.AppendRecord;
    cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_ENABLED.Index] := True;
    cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_NO.Index] := cxGridSerialsTable.DataController.RecordCount;
    cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_SERIAL.Index] := SerialNumber;
    cxGridSerialsTable.ViewData.Rows[N].Focused := True;
    ShowInfo('Numar de serie adaugat!', clGreen);
    cxGridSerials.SetFocus;
    cxGridSerialsTable_SERIAL.Selected := True;
    cxGridSerialsTable_SERIAL.Focused := True;

    SelectedSerialCountChanged;
  end;
end;

procedure TfrmSerialScannerDlg.ResetInputBuffer;
begin
  fEndFlag1 := False;
  fInputBuffer := '';
end;

procedure TfrmSerialScannerDlg.SelectCountry;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(Self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(27);
    dialog.SYSSID := fCountryID;
    if dialog.ShowModal = mrOk then
    begin
      fCountryID := dialog.SYSSID;
      beCountryID.Text := dialog.SyssTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialScannerDlg.SelectedSerialCountChanged;
var
  i, N: integer;
begin
  N := 0;
  for i := 0 to cxGridSerialsTable.DataController.RecordCount - 1 do
    if cxGridSerialsTable.DataController.Values[i, cxGridSerialsTable_ENABLED.Index] = True then
      Inc(N);
  edSelectionCount.Text := IntToStr(N);
end;

procedure TfrmSerialScannerDlg.SelectVendor;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(Self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(1);
    dialog.SYSSID := fVendorID;
    if dialog.ShowModal = mrOk then
    begin
      fVendorID := dialog.SYSSID;
      beVendorID.Text := dialog.SyssTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialScannerDlg.SetAllowZeroWarranty(const Value: Boolean);
begin
  FAllowZeroWarranty := Value;
  edVendorWarranty.Enabled := Not Value;
  edOwnWarranty.Enabled := Not Value;
end;

procedure TfrmSerialScannerDlg.SetDefaultOwnWarranty(const Value: integer);
begin
  edOwnWarranty.Text := IntToStr(Value);
end;

procedure TfrmSerialScannerDlg.SetDefaultVendorWarranty(const Value: integer);
begin
  edVendorWarranty.Text := IntToStr(Value);
end;

procedure TfrmSerialScannerDlg.SetGoodsID(const Value: integer);
begin
  FGoodsID := Value;
end;

procedure TfrmSerialScannerDlg.SetOnAddSerialNumber(const Value: TOnAddSerialNumber);
begin
  FOnAddSerialNumber := Value;
end;

procedure TfrmSerialScannerDlg.SetOnBeginToAddSerials(const Value: TNotifyEvent);
begin
  fOnBeginToAddSerials := Value;
end;

procedure TfrmSerialScannerDlg.SetOnEndToAddSearials(const Value: TNotifyEvent);
begin
  fOnEndToAddSearials := Value;
end;

procedure TfrmSerialScannerDlg.SetRequiredCount(const Value: integer);
begin
  fRequiredCount := Value;
  edRequiredCount.Text := IntToStr(fRequiredCount);
  edSerialGenerateCount.Text := IntToStr(fRequiredCount);
  ShowInfoForUser;
end;

procedure TfrmSerialScannerDlg.ShowInfo(const Text: String; const TextColor: TColor);
begin
  lbActionInfo.Caption := Text;
  lbActionInfo.Font.Color := TextColor;
end;

procedure TfrmSerialScannerDlg.ShowInfoForUser;
var
  N: integer;
begin
  N := cxGridSerialsTable.DataController.RecordCount;

  if (fRequiredCount = 0) then
  begin
    lbInfo.Caption := 'Nu mai trebuie numere de serie!';
    lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
  end
  else if N = fRequiredCount then
  begin
    lbInfo.Caption := cMSG_SN_CountIsOk;
    lbInfo.Color := cCOLOR_PARTNO_CountIsOk;
  end
  else if N < fRequiredCount then
  begin
    lbInfo.Caption := cMSG_SN_CountIsLess;
    lbInfo.Color := cCOLOR_PARTNO_CountIsLess;
  end
  else
  begin
    lbInfo.Caption := cMSG_SN_CountIsBigger;
    lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
  end;

end;

end.
