program WmsShot;

{ Capturi ale formelor WMS pentru instructiune: incarca .dfm-ul cu componentele reale,
  leaga interogarile la baza izolata de test (doar SELECT) si salveaza PNG pe fiecare fila. }

{$APPTYPE CONSOLE}

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.DateUtils, Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Graphics, Vcl.Imaging.pngimage, Data.DB, cxButtons, cxLabel, cxGrid, cxGridLevel,
  cxGridTableView, cxGridDBTableView, cxTextEdit, cxButtonEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupComboBox,
  cxCheckBox, cxRadioGroup, cxMemo, cxCalendar, cxCurrencyEdit, cxSpinEdit, cxImageComboBox, cxPC, cxVGrid,
  cxDBVGrid, cxGridCustomView, DialogTitle, IBC, DBAccess;

type
  THandler = class
    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure FindMethod(Reader: TReader; const MethodName: string; var Address: Pointer; var Error: Boolean);
  end;

var
  Conn: TIBCConnection;
  OutDir: string;

procedure THandler.ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  Writeln('DFM: ', Message);
  Handled := True;
end;

procedure THandler.FindMethod(Reader: TReader; const MethodName: string; var Address: Pointer; var Error: Boolean);
begin
  Error := False;
end;

function LoadDfm(const AFile: string; ARoot: TComponent): TComponent;
var
  H: THandler;
  Src, Bin: TMemoryStream;
  R: TReader;
begin
  H := THandler.Create;
  Src := TMemoryStream.Create;
  Bin := TMemoryStream.Create;
  try
    Src.LoadFromFile(AFile);
    ObjectTextToBinary(Src, Bin);
    Bin.Position := 0;
    R := TReader.Create(Bin, 4096);
    try
      R.OnError := H.ReaderError;
      R.OnFindMethod := H.FindMethod;
      R.ReadRootComponent(ARoot);
    finally
      R.Free;
    end;
  finally
    Src.Free;
    Bin.Free;
    H.Free;
  end;
  Result := ARoot;
end;

procedure DumpControls(F: TForm; const AFile: string);
var
  L: TStringList;
  I: Integer;
  C: TControl;
  P: TPoint;
begin
  L := TStringList.Create;
  try
    for I := 0 to F.ComponentCount - 1 do
      if F.Components[I] is TControl then
      begin
        C := TControl(F.Components[I]);
        if not C.Visible or (C.Parent = nil) then
          Continue;
        if (C.Parent is TWinControl) and not TWinControl(C.Parent).Showing then
          Continue;
        P := F.ScreenToClient(C.Parent.ClientToScreen(Point(C.Left, C.Top)));
        L.Add(Format('%s=%d,%d,%d,%d', [C.Name, P.X, P.Y, C.Width, C.Height]));
      end;
    L.SaveToFile(AFile);
  finally
    L.Free;
  end;
end;

procedure SavePng(F: TForm; const AName: string);
var
  Bmp: TBitmap;
  Png: TPngImage;
begin
  Application.ProcessMessages;
  F.Repaint;
  Application.ProcessMessages;
  Bmp := TBitmap.Create;
  Png := TPngImage.Create;
  try
    Bmp.SetSize(F.ClientWidth, F.ClientHeight);
    Bmp.Canvas.Brush.Color := clBtnFace;
    Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
    F.PaintTo(Bmp.Canvas, 0, 0);
    Png.Assign(Bmp);
    Png.SaveToFile(OutDir + AName + '.png');
    DumpControls(F, OutDir + AName + '.txt');
    Writeln('png ', AName, ' ', Bmp.Width, 'x', Bmp.Height);
  finally
    Png.Free;
    Bmp.Free;
  end;
end;

function Scalar(const ASql: string): Variant;
var
  Q: TIBCQuery;
begin
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text := ASql;
    Q.Open;
    if Q.IsEmpty then
      Result := Null
    else
      Result := Q.Fields[0].Value;
  finally
    Q.Free;
  end;
end;

procedure OpenAll(F: TComponent; AFirma, APlan: Integer; ADate: TDate);
var
  I, Pass: Integer;
  Q: TIBCQuery;
begin
  for I := 0 to F.ComponentCount - 1 do
    if F.Components[I] is TIBCQuery then
      TIBCQuery(F.Components[I]).Connection := Conn;
  for Pass := 0 to 1 do  // detaliile (MasterSource) dupa master
    for I := 0 to F.ComponentCount - 1 do
      if F.Components[I] is TIBCQuery then
      begin
        Q := TIBCQuery(F.Components[I]);
        if (Q.MasterSource <> nil) <> (Pass = 1) then
          Continue;
        if Q.SQL.Text = '' then
          Continue;
        if Q.Params.FindParam('FIRMAID') <> nil then
          Q.ParamByName('FIRMAID').AsInteger := AFirma;
        if Q.Params.FindParam('DATA') <> nil then
          Q.ParamByName('DATA').AsDate := ADate;
        if Q.Params.FindParam('PLANID') <> nil then
          Q.ParamByName('PLANID').AsInteger := APlan;
        try
          Q.Open;
          Writeln(Q.Name, ': ', Q.RecordCount);
        except
          on E: Exception do
            Writeln(Q.Name, ': EROARE ', E.Message);
        end;
      end;
end;

function Comp(F: TComponent; const AName: string): TComponent;
begin
  Result := F.FindComponent(AName);
  if Result = nil then
    raise Exception.Create('lipseste ' + AName);
end;

procedure ShowForm(F: TForm);
begin
  if F.WindowState = wsMaximized then
  begin
    F.WindowState := wsNormal;
    F.Width := 1500;
    F.Height := 560;
  end;
  F.Position := poDesigned;
  F.Left := 20;
  F.Top := 20;
  F.Show;
  Application.ProcessMessages;
end;

procedure DoDispatch(const ADfm, APrefix: string; AFirma: Integer; ADate: TDate; ACourier: Integer;
  const ATab: string; AFocus: Integer);
var
  F: TForm;
  PlanID, State, Ver: Integer;
  V: Variant;
  Pc: TcxPageControl;
  I: Integer;
  Q: TIBCQuery;
  procedure Cap(const ATs, AFmt: string; const AQ: string);
  begin
    TcxTabSheet(Comp(F, ATs)).Caption := Format(AFmt, [TIBCQuery(Comp(F, AQ)).RecordCount]);
  end;
begin
  F := TForm.CreateNew(nil);
  LoadDfm(ADfm, F);
  TDialogTitle(Comp(F, 'dtDialogTitle')).Text := 'Ridicari de la furnizori si livrari catre clienti - Magazin Exemplu SRL';
  V := Scalar(Format('SELECT PLANID FROM TDB_DISPATCH_PLAN WHERE FIRMAID = %d AND PLAN_DATE = ''%s''',
    [AFirma, FormatDateTime('yyyy-mm-dd', ADate)]));
  if VarIsNull(V) then
  begin
    PlanID := -1;
    TLabel(Comp(F, 'lbPlanState')).Caption := 'Planul zilei nu exista inca (se creeaza la prima atribuire)';
  end
  else
  begin
    PlanID := V;
    State := Scalar(Format('SELECT STATEID FROM TDB_DISPATCH_PLAN WHERE PLANID = %d', [PlanID]));
    Ver := Scalar(Format('SELECT VERSIONNO FROM TDB_DISPATCH_PLAN WHERE PLANID = %d', [PlanID]));
    case State of
      0: TLabel(Comp(F, 'lbPlanState')).Caption := 'Plan: CIORNA - soferii nu il vad pana la publicare';
      1: TLabel(Comp(F, 'lbPlanState')).Caption := Format('Plan: PUBLICAT (versiunea %d, %s)', [Ver,
           FormatDateTime('dd.mm hh:nn', Scalar(Format('SELECT PUBLISHED_AT FROM TDB_DISPATCH_PLAN WHERE PLANID = %d', [PlanID])))]);
      2: TLabel(Comp(F, 'lbPlanState')).Caption := Format('Plan: IN EXECUTARE (versiunea %d)', [Ver]);
    else
      TLabel(Comp(F, 'lbPlanState')).Caption := 'Plan: INCHIS';
    end;
    if State = 0 then
      TcxButton(Comp(F, 'btnPublish')).Caption := 'Publica planul'
    else
      TcxButton(Comp(F, 'btnPublish')).Caption := 'Republica planul';
  end;
  TcxDateEdit(Comp(F, 'deDate')).Date := ADate;
  OpenAll(F, AFirma, PlanID, ADate);
  Cap('tsPickups', 'Achizitii (%d)', 'qPickups');
  Cap('tsReturns', 'Retururi (%d)', 'qReturns');
  Cap('tsDeliveries', 'Livrari (%d)', 'qDeliveries');
  Cap('tsRoutes', 'Trasee (%d)', 'qRoutes');
  Cap('tsProblems', 'Probleme (%d)', 'qProblems');
  if ACourier > 0 then
    TcxLookupComboBox(Comp(F, 'lcbCourier')).EditValue := ACourier;
  Q := TIBCQuery(Comp(F, 'qZones'));
  if Q.Active and not Q.IsEmpty then
    TcxLookupComboBox(Comp(F, 'lcbZone')).EditValue := Q.FieldByName('ZONEID').Value;
  ShowForm(F);
  Pc := TcxPageControl(Comp(F, 'pcMain'));
  for I := 0 to Pc.PageCount - 1 do
  begin
    if (ATab <> 'all') and (Pc.Pages[I].Name <> ATab) then
      Continue;
    Pc.ActivePageIndex := I;
    Application.ProcessMessages;
    SavePng(F, APrefix + '_' + Pc.Pages[I].Name);
  end;
  F.Free;
end;

procedure DoSimple(const ADfm, AName, ATitle: string; AFirma: Integer);
var
  F: TForm;
begin
  F := TForm.CreateNew(nil);
  LoadDfm(ADfm, F);
  if F.FindComponent('dtDialogTitle') <> nil then
    if ATitle <> '' then
      TDialogTitle(F.FindComponent('dtDialogTitle')).Text := ATitle;
  OpenAll(F, AFirma, -1, Date);
  if AName = 'w_curieri' then
  begin
    TLabel(Comp(F, 'lbBaseStock')).Caption := 'Depozitul de baza (Magazin Exemplu SRL):';
    TcxLookupComboBox(Comp(F, 'lcbBaseStock')).EditValue :=
      Scalar(Format('SELECT BASE_STOCKID FROM TS_DISPATCH_SETTINGS WHERE FIRMAID = %d', [AFirma]));
    TcxLookupComboBox(Comp(F, 'lcbWebUser')).EditValue :=
      Scalar(Format('SELECT WEB_USERID FROM TS_DISPATCH_SETTINGS WHERE FIRMAID = %d', [AFirma]));
  end;
  ShowForm(F);
  SavePng(F, AName);
  F.Free;
end;

procedure DoPickupList(const ADfm: string);
var
  F: TForm;
  Q: TIBCQuery;
begin
  F := TForm.CreateNew(nil);
  LoadDfm(ADfm, F);
  TDialogTitle(Comp(F, 'dtDialogTitle')).Text := 'Marfa de ridicat de la furnizori pentru comenzile clientilor';
  TcxButton(Comp(F, 'btnNewPickup')).Visible := False;
  Q := TIBCQuery(Comp(F, 'IBCQueryPickups'));
  Q.SQL.Text := 'SELECT * FROM VW_TDB_SUPPLIER_PICKUP WHERE STATEID IN (0, 1) OR CREATED_AT >= DATEADD(-60 DAY TO CURRENT_DATE) ' +
    'ORDER BY PLAN_DATE, PICKUP_SUPPLIER_NAME, PICKUPID';
  TcxCheckBox(Comp(F, 'chkOnlyActive')).Checked := False;
  OpenAll(F, 0, -1, Date);
  ShowForm(F);
  SavePng(F, ParamStr(5) + '_ridicari_lista');
  F.Free;
end;

procedure DoPickupConfirm(const ADfm: string);
var
  F: TForm;
begin
  F := TForm.CreateNew(nil);
  LoadDfm(ADfm, F);
  F.Caption := 'Ridicare marfa de la furnizor';
  TDialogTitle(Comp(F, 'dtDialogTitle')).Text := 'Confirmati furnizorul prin care comandam, locul ridicarii si cantitatea';
  TLabel(Comp(F, 'lbGoods')).Caption := 'Aspirator vertical  [cod furnizor: ASP-1]';
  TcxButtonEdit(Comp(F, 'beStockSupplier')).Text := 'Furnizor Sursa SRL';
  TcxButtonEdit(Comp(F, 'beOrderSupplier')).Text := 'Furnizor Intermediar SRL';
  TLabel(Comp(F, 'lbRuleInfo')).Caption := 'Valori implicite din regula furnizorului (se pot modifica).';
  TcxRadioGroup(Comp(F, 'rgPickupFrom')).ItemIndex := 0;
  TcxSpinEdit(Comp(F, 'seQty')).Value := 1;
  TLabel(Comp(F, 'lbQtyInfo')).Caption := 'din comanda: 1';
  TcxDateEdit(Comp(F, 'dePlanDate')).Date := Date;
  TcxTextEdit(Comp(F, 'edNote')).Text := 'Clientul asteapta pina la ora 17';
  TLabel(Comp(F, 'lbState')).Caption := '';
  ShowForm(F);
  SavePng(F, 'w_ridicare_confirmare');
  F.Free;
end;

procedure DoDeliveryFrame(const ADfm: string);
var
  F: TForm;
  Fr: TFrame;
  Q: TIBCQuery;
begin
  F := TForm.CreateNew(nil);
  F.Caption := 'Livrare';
  F.ClientWidth := 476;
  F.ClientHeight := 280;
  Fr := TFrame.Create(F);
  LoadDfm(ADfm, Fr);
  Fr.Parent := F;
  Fr.Align := alClient;
  TLabel(Comp(Fr, 'lbEmptyHint')).Visible := False;
  Q := TIBCQuery(Comp(Fr, 'IBCQueryDelivery'));
  Q.Connection := Conn;
  Q.SQL.Text := 'SELECT 7001 AS DOCID, CAST(NULL AS INTEGER) AS COURIERID, CAST(''Livrare proprie'' AS VARCHAR(100)) AS COURIER_NAME, ' +
    'CAST(''Durlesti, str. Cartusa 12, ap. 4, et. 2'' AS VARCHAR(250)) AS DELIVERY_ADDRESS, CAST(''14:00-16:00'' AS VARCHAR(50)) AS DELIVERY_TIME, ' +
    'CURRENT_DATE AS DELIVERY_DATE, 1 AS FLG_CASHONDELIVERY, 0 AS FLG_INVOICE_ONDELIVERY, 0 AS TRANSMIS_CURIER, ' +
    'CAST(NULL AS VARCHAR(50)) AS AWB FROM RDB$DATABASE';
  Q.Open;
  ShowForm(F);
  SavePng(F, 'w_livrare_document');
  F.Free;
end;

var
  Mode, Src: string;
  Firma: Integer;
  Day: TDate;
begin
  RegisterClasses([TPanel, TLabel, TSplitter, TcxButton, TcxLabel, TcxGrid, TcxGridLevel, TcxGridDBTableView,
    TcxGridDBColumn, TcxTextEdit, TcxButtonEdit, TcxComboBox, TcxLookupComboBox, TcxCheckBox, TcxRadioGroup, TcxMemo,
    TcxDateEdit, TcxCurrencyEdit, TcxSpinEdit, TcxPageControl, TcxTabSheet, TcxDBVerticalGrid, TcxDBEditorRow,
    TcxCategoryRow, TcxDBMultiEditorRow, TDialogTitle, TIBCQuery, TIBCDataSource, TIBCTransaction]);
  Application.Initialize;
  try
    Mode := ParamStr(1);
    Src := ParamStr(2);
    OutDir := IncludeTrailingPathDelimiter(ParamStr(3));
    Firma := StrToIntDef(ParamStr(4), 0);
    Conn := TIBCConnection.Create(nil);
    Conn.Server := '127.0.0.1';
    Conn.Port := '3052';
    Conn.Database := '/var/lib/firebird/data/curieri_test.fdb';
    Conn.Username := 'SYSDBA';
    Conn.Password := GetEnvironmentVariable('FBDOC_PW');
    Conn.ClientLibrary := 'C:\Windows\SysWOW64\fbclient.dll';
    Conn.Options.Charset := 'UTF8';
    Conn.Options.UseUnicode := True;
    Conn.LoginPrompt := False;
    Conn.Connect;
    Day := Date + StrToIntDef(ParamStr(8), 0);
    if Mode = 'dispatch' then
      DoDispatch(Src, ParamStr(5), Firma, Day, StrToIntDef(ParamStr(6), 0), ParamStr(7), 0)
    else if Mode = 'couriers' then
      DoSimple(Src, 'w_curieri', 'Colaboratorii care fac ridicari si livrari, depozitul masinii si contul aplicatiei', Firma)
    else if Mode = 'zones' then
      DoSimple(Src, 'w_zone', '', Firma)
    else if Mode = 'rules' then
      DoSimple(Src, 'w_reguli_intermediar', '', Firma)
    else if Mode = 'pickuplist' then
      DoPickupList(Src)
    else if Mode = 'pickupconfirm' then
      DoPickupConfirm(Src)
    else if Mode = 'delivery' then
      DoDeliveryFrame(Src);
    Conn.Free;
  except
    on E: Exception do
      Writeln('EXCEPTION ', E.ClassName, ': ', E.Message);
  end;
  Flush(Output);
end.
