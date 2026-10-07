unit frmECCReconcileDialog;

(* Reconciliere ECC - raportul din WMS (faza 8). Compara, pe o casa si o perioada,
   bonurile din ECC Fiscal Partner cu jurnalul TFP_ECC_TRANSACTION si cu
   TDB_DOCS_RECEIPT (ECCReconcileUnit). Acelasi calcul il face noaptea job-ul
   @ECC_RECONCILE din SWNService.

   Ruleaza pe un fir de lucru cu conexiune proprie la baza; lista se poate
   exporta in CSV. *)

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, SWNBaseUnit, ECCReconcileUnit;

type
  TfrmECCReconcileDlg = class(TSWNCustomForm)
    pnTop: TPanel;
    lblApiCode: TLabel;
    cmbApiCode: TComboBox;
    lblFrom: TLabel;
    dtFrom: TDateTimePicker;
    lblTo: TLabel;
    dtTo: TDateTimePicker;
    chkAutoFix: TCheckBox;
    btnRun: TButton;
    btnExport: TButton;
    lblSummary: TLabel;
    lvRows: TListView;
    pnBottom: TPanel;
    btnClose: TButton;
    procedure btnRunClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure lvRowsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fBusy: Boolean;
    fPreferredApiCode: string;
    fResult: TECCReconcileResult;
    procedure SetBusy(const ABusy: Boolean);
    procedure ShowResult;
  protected
    procedure Prepare; override;
  public
    class procedure Execute(AOwner: TComponent; const AApiCode: string = '');
  end;

implementation

uses
  System.UITypes, System.DateUtils, IBC, DataModuleDB, ECCApiClient, ECCConfigUnit, ECCTransactionStore;

{$R *.dfm}

class procedure TfrmECCReconcileDlg.Execute(AOwner: TComponent; const AApiCode: string);
var
  Dlg: TfrmECCReconcileDlg;
begin
  Dlg := TfrmECCReconcileDlg.Create(AOwner);
  try
    Dlg.fPreferredApiCode := UpperCase(Trim(AApiCode));
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmECCReconcileDlg.Prepare;
var
  Code: string;
  Col: TListColumn;

  procedure AddCol(const ACaption: string; const AWidth: Integer; const ARight: Boolean = False);
  begin
    Col := lvRows.Columns.Add;
    Col.Caption := ACaption;
    Col.Width := AWidth;
    if ARight then
      Col.Alignment := taRightJustify;
  end;

begin
  inherited;
  cmbApiCode.Items.Clear;
  for Code in ListECCApiCodes(dmDB.IBCConnection) do
    if Code <> 'ECC_ONLINE' then
      cmbApiCode.Items.Add(Code);
  cmbApiCode.ItemIndex := cmbApiCode.Items.IndexOf(fPreferredApiCode);
  if (cmbApiCode.ItemIndex < 0) and (cmbApiCode.Items.Count > 0) then
    cmbApiCode.ItemIndex := 0;

  dtFrom.Date := IncDay(Date, -1);
  dtTo.Date := Date;

  lvRows.Columns.Clear;
  AddCol('Rezultat', 130);
  AddCol('Data', 115);
  AddCol('Nr. bon', 60, True);
  AddCol('Z', 45, True);
  AddCol('Suma ECC', 80, True);
  AddCol('Suma WMS', 80, True);
  AddCol('Document', 75, True);
  AddCol('Sursa', 80);
  AddCol('Nota', 420);
  AddCol('Id ECC', 260);
  lblSummary.Caption := 'Alegeti casa si perioada, apoi "Reconciliaza".';
end;

procedure TfrmECCReconcileDlg.SetBusy(const ABusy: Boolean);
begin
  fBusy := ABusy;
  btnRun.Enabled := not ABusy;
  btnExport.Enabled := not ABusy;
  btnClose.Enabled := not ABusy;
  cmbApiCode.Enabled := not ABusy;
  if ABusy then
    Screen.Cursor := crAppStart
  else
    Screen.Cursor := crDefault;
end;

procedure TfrmECCReconcileDlg.btnRunClick(Sender: TObject);
var
  Code: string;
  FromDT, ToDT: TDateTime;
  AutoFix: Boolean;
  Conn: TIBCConnection;
begin
  if fBusy then
    Exit;
  Code := cmbApiCode.Text;
  if Code = '' then
  begin
    MessageDlg('Nu e aleasa casa ECC (Setari > Configurari API).', mtWarning, [mbOK], 0);
    Exit;
  end;
  FromDT := DateOf(dtFrom.Date);
  ToDT := IncDay(DateOf(dtTo.Date), 1);   // ziua "pina la" inclusiv
  if ToDT <= FromDT then
  begin
    MessageDlg('Perioada nu e corecta.', mtWarning, [mbOK], 0);
    Exit;
  end;
  AutoFix := chkAutoFix.Checked;

  // conexiune proprie: firul de lucru nu atinge dmDB
  Conn := TECCTransactionStore.CreateOwnConnection(dmDB.IBCConnection, UserID);
  SetBusy(True);
  lvRows.Items.Clear;
  lblSummary.Caption := 'Se citesc bonurile din ECC si jurnalul WMS...';

  TThread.CreateAnonymousThread(
    procedure
    var
      Res: TECCReconcileResult;
      Err: string;
    begin
      Err := '';
      try
        try
          Res := ECCReconcile(Conn, Code, FromDT, ToDT, AutoFix);
        except
          on E: Exception do
            Err := E.Message;
        end;
      finally
        Conn.Free;
      end;
      TThread.Queue(nil,
        procedure
        begin
          SetBusy(False);
          if Err <> '' then
          begin
            lblSummary.Caption := 'Reconcilierea a esuat: ' + Err;
            MessageDlg(lblSummary.Caption, mtError, [mbOK], 0);
            Exit;
          end;
          fResult := Res;
          ShowResult;
        end);
    end).Start;
end;

procedure TfrmECCReconcileDlg.ShowResult;
var
  Row: TECCReconcileRow;
  Item: TListItem;

  function DocText(const ADocID: Integer): string;
  begin
    if ADocID > 0 then
      Result := IntToStr(ADocID)
    else
      Result := '';
  end;

  function NumText(const AValue: Integer): string;
  begin
    if AValue > 0 then
      Result := IntToStr(AValue)
    else
      Result := '';
  end;

begin
  lvRows.Items.BeginUpdate;
  try
    lvRows.Items.Clear;
    for Row in fResult.Rows do
    begin
      Item := lvRows.Items.Add;
      Item.Caption := ECCReconcileKindName(Row.Kind);
      Item.Data := Pointer(Ord(Row.Kind));
      if Row.DateTime > 0 then
        Item.SubItems.Add(FormatDateTime('dd.mm.yyyy hh:nn', Row.DateTime))
      else
        Item.SubItems.Add('');
      Item.SubItems.Add(NumText(Row.ReceiptNumber));
      Item.SubItems.Add(NumText(Row.ZNumber));
      Item.SubItems.Add(ECCMoneyText(Row.EccTotal));
      Item.SubItems.Add(ECCMoneyText(Row.WmsTotal));
      Item.SubItems.Add(DocText(Row.DocID));
      Item.SubItems.Add(ECCSourceTypeName(Row.SourceType));
      Item.SubItems.Add(Row.Note);
      Item.SubItems.Add(Row.TransId);
    end;
  finally
    lvRows.Items.EndUpdate;
  end;
  lblSummary.Caption := fResult.Summary;
  if fResult.ProblemCount > 0 then
    lblSummary.Font.Color := clRed
  else
    lblSummary.Font.Color := clGreen;
end;

procedure TfrmECCReconcileDlg.lvRowsCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  case TECCReconcileKind(NativeInt(Item.Data)) of
    erkOk: Sender.Canvas.Font.Color := clWindowText;
    erkFixed: Sender.Canvas.Font.Color := clBlue;
    erkInfo: Sender.Canvas.Font.Color := clGray;
  else
    Sender.Canvas.Font.Color := clRed;
  end;
  DefaultDraw := True;
end;

procedure TfrmECCReconcileDlg.btnExportClick(Sender: TObject);
var
  Dlg: TSaveDialog;
  L: TStringList;
  I, J: Integer;
  Line: string;

  function Csv(const S: string): string;
  begin
    Result := '"' + StringReplace(S, '"', '""', [rfReplaceAll]) + '"';
  end;

begin
  if lvRows.Items.Count = 0 then
  begin
    MessageDlg('Nu e nimic de exportat; rulati intii reconcilierea.', mtInformation, [mbOK], 0);
    Exit;
  end;
  Dlg := TSaveDialog.Create(Self);
  L := TStringList.Create;
  try
    Dlg.Filter := 'CSV (*.csv)|*.csv';
    Dlg.DefaultExt := 'csv';
    Dlg.FileName := Format('reconciliere_%s_%s.csv', [cmbApiCode.Text, FormatDateTime('yyyymmdd', dtFrom.Date)]);
    if not Dlg.Execute then
      Exit;
    L.Add(Csv(fResult.Summary));
    Line := '';
    for J := 0 to lvRows.Columns.Count - 1 do
      Line := Line + Csv(lvRows.Columns[J].Caption) + ';';
    L.Add(Line);
    for I := 0 to lvRows.Items.Count - 1 do
    begin
      Line := Csv(lvRows.Items[I].Caption) + ';';
      for J := 0 to lvRows.Items[I].SubItems.Count - 1 do
        Line := Line + Csv(lvRows.Items[I].SubItems[J]) + ';';
      L.Add(Line);
    end;
    L.SaveToFile(Dlg.FileName, TEncoding.UTF8);
  finally
    L.Free;
    Dlg.Free;
  end;
end;

procedure TfrmECCReconcileDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not fBusy;
end;

end.
