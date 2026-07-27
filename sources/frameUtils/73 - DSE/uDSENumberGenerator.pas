unit uDSENumberGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxButtons, cxMemo, cxCheckBox, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, Vcl.ExtCtrls,
  SWNUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxLabel, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid, dxDateRanges, dxScrollbarAnnotations;

type

  TOnAddSerialNumber = procedure(const SerialNumber: String; var Added: Boolean) of object;


  TfrmDSENumberGenerator = class(TSWNCustomForm)
    pnGenerator: TPanel;
    cxLabel5: TLabel;
    cxLabel6: TLabel;
    cxLabel7: TLabel;
    cxLabel8: TLabel;
    edSerialPrefix: TcxMaskEdit;
    edSerialStartMask: TcxMaskEdit;
    edSearialSuffix: TcxMaskEdit;
    edSerialGenerateCount: TcxMaskEdit;
    btnGenerate: TButton;
    cbClearList: TcxCheckBox;
    btnOK: TcxButton;
    cxButton2: TcxButton;
    cxGridSerials: TcxGrid;
    cxGridSerialsTable: TcxGridTableView;
    cxGridSerialsTable_ENABLED: TcxGridColumn;
    cxGridSerialsTable_NO: TcxGridColumn;
    cxGridSerialsTable_SERIAL: TcxGridColumn;
    cxGridSerialsLevel: TcxGridLevel;
    lbInfo: TLabel;
    btnPaste: TcxButton;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
  private
    { Private declarations }
    fDataSet: TIBCQuery;
    fDataSource : TIBCDataSource;
    fRequiredCount: integer;

    fOnBeginToAddSerials: TNotifyEvent;
    fOnEndToAddSearials: TNotifyEvent;
    FOnAddSerialNumber: TOnAddSerialNumber;
    procedure SetOnAddSerialNumber(const Value: TOnAddSerialNumber);
    procedure SetOnBeginToAddSerials(const Value: TNotifyEvent);
    procedure SetOnEndToAddSearials(const Value: TNotifyEvent);
    procedure SetRequiredCount(const Value: integer);

  protected
    procedure Prepare; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;

  public
    { Public declarations }

    function CheckGenerateParams: Boolean;
    procedure GenerateSerialNumbers;
    function CheckParams: Boolean;
    function DoAddSerialNumbers: Boolean;
    procedure ShowInfoForUser;
    procedure PasteDSE;

    property OnBeginToAddSearials: TNotifyEvent read fOnBeginToAddSerials write SetOnBeginToAddSerials;
    property OnAddSerialNumber: TOnAddSerialNumber read FOnAddSerialNumber write SetOnAddSerialNumber;
    property OnEndToAddSearials: TNotifyEvent read fOnEndToAddSearials write SetOnEndToAddSearials;
    property RequiredCount: integer write SetRequiredCount;


  end;

var
  frmDSENumberGenerator: TfrmDSENumberGenerator;

implementation

uses SWNConst, Clipbrd;

{$R *.dfm}

{ TForm2 }

function TfrmDSENumberGenerator.DoAddSerialNumbers: Boolean;
var
  i: integer;
  Added: Boolean;
  toContinue: Boolean;
  S: String;
  hasError: Boolean;
begin
  hasError := False;
  if Assigned(FOnAddSerialNumber) then
  begin
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
          FOnAddSerialNumber(S, Added);
          if Added then
          begin
            cxGridSerialsTable.DataController.DeleteRecord(i);
            Dec(i);
          end
          else
          begin
            toContinue := False;
            hasError := True;
            ShowInfoDialogVerification('Eroare la adaugare', 'Eroare la adaugarea seriei' + #13#10 + S, 'Sa continui?',
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

function TfrmDSENumberGenerator.CheckParams: Boolean;
var
  ErrorStr: String;
  N: integer;
begin
  Result := False;
  ErrorStr := '';

  if (cxGridSerialsTable.DataController.RecordCount = 0) then
    AddErrorToStr(ErrorStr, 'Nu sunt serii generate!');


  if ErrorStr = '' then
    Result := True
  else
  ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmDSENumberGenerator.btnOKClick(Sender: TObject);
begin
 if CheckParams then
  begin
    if DoAddSerialNumbers then
      ModalResult := mrOk;
  end;
end;

procedure TfrmDSENumberGenerator.btnPasteClick(Sender: TObject);
begin
  PasteDSE;
end;

function TfrmDSENumberGenerator.CheckGenerateParams: Boolean;
var
  ErrorStr, S: String;
  N, Count: integer;
begin
  Result := False;
  ErrorStr := '';

  Count := 0;
  if edSerialGenerateCount.Text = '' then
    AddErrorToStr(ErrorStr, 'Setati numarul seriilor!')
  else
  begin
    Count := StrToIntDef(edSerialGenerateCount.Text, 0);
    if Count <= 0 then
      AddErrorToStr(ErrorStr, 'Cantitate incorecta a numarului de serii!')
  end;

  if edSerialPrefix.Text = '' then
    AddErrorToStr(ErrorStr, 'Prefix!');
  if edSerialStartMask.Text = '' then
    AddErrorToStr(ErrorStr, 'Serie pentru generare!')
  else
  begin
    N := StrToIntDef(edSerialGenerateCount.Text, 0);
    if N <= 0 then
      AddErrorToStr(ErrorStr, 'Numar pentru generare incorect!')
    else if Count > 0 then
    begin
      N := Length(edSerialStartMask.Text);
      S := '%' + IntToStr(N) + '.' + IntToStr(N) + 'd';
      N := StrToInt(edSerialStartMask.Text) + Count;
      S := Format(S, [N]);
      if Length(S) > Length(edSerialStartMask.Text) then
        AddErrorToStr(ErrorStr, 'Seria generata nu se asociaza cu masca setata!')
    end;
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog('Eroare la generare', 'Nu sunt setate corect parametri generatorului.', ErrorStr);
end;

procedure TfrmDSENumberGenerator.GenerateSerialNumbers;
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

procedure TfrmDSENumberGenerator.btnGenerateClick(Sender: TObject);
begin
  if CheckGenerateParams then
    GenerateSerialNumbers;
end;

procedure TfrmDSENumberGenerator.PasteDSE;
var
  Mask: String;
  N, Count: integer;
  StartNumber: integer;
  List: TStringList;
begin
  List := TStringList.Create;
  try
  list.Text := clipboard.AsText;

  StartNumber := 0;
  Count := List.Count - 1;

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
      N := cxGridSerialsTable.DataController.AppendRecord;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_ENABLED.Index] := True;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_NO.Index] := cxGridSerialsTable.DataController.RecordCount;
      cxGridSerialsTable.DataController.Values[N, cxGridSerialsTable_SERIAL.Index] := List[StartNumber];

      Inc(StartNumber);
    end;
  finally
    cxGridSerialsTable.DataController.EndFullUpdate;
  end;
  finally
    list.Free;
  end;
end;

procedure TfrmDSENumberGenerator.Prepare;
begin
  inherited;
  edSerialGenerateCount.Text := IntToStr(fRequiredCount);
end;

procedure TfrmDSENumberGenerator.SetOnAddSerialNumber(const Value: TOnAddSerialNumber);
begin
  FOnAddSerialNumber := Value;
end;

procedure TfrmDSENumberGenerator.SetOnBeginToAddSerials(const Value: TNotifyEvent);
begin
  fOnBeginToAddSerials := Value;
end;

procedure TfrmDSENumberGenerator.SetOnEndToAddSearials(const Value: TNotifyEvent);
begin
  fOnEndToAddSearials := Value;
end;

procedure TfrmDSENumberGenerator.SetRequiredCount(const Value: integer);
begin
  fRequiredCount := Value;
end;

procedure TfrmDSENumberGenerator.SetupSecurityItems;
begin
  inherited;
end;

procedure TfrmDSENumberGenerator.WhenCancelForm;
begin
  inherited;
end;

procedure TfrmDSENumberGenerator.ShowInfoForUser;
var
  N: integer;
begin
  N := cxGridSerialsTable.DataController.RecordCount;

  if (fRequiredCount = 0) then
  begin
    lbInfo.Caption := 'Не нужно больше серийных номеров!';
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
