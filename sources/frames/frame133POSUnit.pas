unit frame133POSUnit;

{
  POS (Point of Sale) - vinzari din magazin cu casa
  DocTypeID = nodul din TS_DOCTYPES cu TABSHEETINDEX = 133
  Frame Index = 133

  Stare: fazele 1-4 din plan (casa + cos + ture + incasare cu bon fiscal).
  Logica fara interfata: classes\POS\POSSaleUnit.pas
  Schema: DB Model\pos.sql. Plan: Documents\pos-plan-2026-09-20.md

  Taste: Enter = cauta/adauga, F2 = cimpul de cautare, F4 = cantitate, F5 = reducere,
         F9 = incasare, F10 = tura, + / - = cantitate, Del = sterge linia, Esc = goleste bonul
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls,
  ComCtrls, SWNDataFiltering, SWNBaseFrameUnit, POSSaleUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGrid, cxCurrencyEdit, dxUIAClasses;

type
  Tframe133POS = class(TSWNBaseFrame)
    pnlTop: TPanel;
    lblTerminal: TLabel;
    lblShift: TLabel;
    pnlRight: TPanel;
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    lblDiscount: TLabel;
    lblLines: TLabel;
    btnPay: TButton;
    btnQtyPlus: TButton;
    btnQtyMinus: TButton;
    btnQty: TButton;
    btnDiscount: TButton;
    btnDeleteLine: TButton;
    btnClear: TButton;
    btnShift: TButton;
    btnCashIn: TButton;
    btnCashOut: TButton;
    pnlLeft: TPanel;
    pnlSearch: TPanel;
    edSearch: TEdit;
    btnSearch: TButton;
    pnlResults: TPanel;
    lblResults: TLabel;
    lvResults: TListView;
    lblMessage: TLabel;
    gridCart: TcxGrid;
    gridCartView: TcxGridTableView;
    colNo: TcxGridColumn;
    colTitle: TcxGridColumn;
    colSerial: TcxGridColumn;
    colQty: TcxGridColumn;
    colPrice: TcxGridColumn;
    colDiscount: TcxGridColumn;
    colSuma: TcxGridColumn;
    gridCartLevel: TcxGridLevel;
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure lvResultsDblClick(Sender: TObject);
    procedure lvResultsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridCartViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnQtyPlusClick(Sender: TObject);
    procedure btnQtyMinusClick(Sender: TObject);
    procedure btnQtyClick(Sender: TObject);
    procedure btnDiscountClick(Sender: TObject);
    procedure btnDeleteLineClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnShiftClick(Sender: TObject);
    procedure btnCashInClick(Sender: TObject);
    procedure btnCashOutClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
  private
    { Private declarations }
    fTerminal: TPOSTerminal;
    fShift: TPOSShift;
    fCart: TPOSCart;
    fResults: TPOSFoundGoodsArray;
    fLastSearchText: string;
    procedure LoadTerminal;
    procedure UpdateHeader;
    procedure UpdateTotals;
    procedure UpdateButtons;
    procedure WhenCartChanged(Sender: TObject);
    procedure ShowMessageLine(const Text: string; const IsError: Boolean);
    procedure DoSearch;
    procedure ShowResults;
    procedure HideResults;
    procedure AddFoundGoods(const Goods: TPOSFoundGoods);
    procedure AddSelectedResult;
    function FocusedLine: Integer;
    procedure FocusLine(const Index: Integer);
    procedure FocusSearch;
    function HandleCommonKey(var Key: Word; Shift: TShiftState): Boolean;
    procedure AskQty;
    procedure AskDiscount;
    procedure DeleteFocusedLine;
    procedure ClearCart;
    procedure OpenOrCloseShift;
    procedure CashMove(const IsIncome: Boolean);
    procedure PaySale;
    procedure WarnPendingJournal;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    function GetFrameButtons: TFrameButtons; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  Dialogs, System.UITypes, SWNUtils, frmPOSShiftDialog, frmPOSPaymentDialog, POSCheckoutUnit;

{$R *.dfm}

const
  cMoneyFormat = '#,##0.00';

{ Tframe133POS }

constructor Tframe133POS.Create(AOwner: TComponent);
begin
  inherited;
  fTerminal.Clear;
  fShift.Clear;
  fCart := TPOSCart.Create;
  fCart.OnChange := WhenCartChanged;
end;

destructor Tframe133POS.Destroy;
begin
  fCart.Free;
  inherited;
end;

procedure Tframe133POS.DoFrameHide;
begin
  CloseExternalData;
  inherited;
end;

procedure Tframe133POS.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  OpenExternalData(FrameDataFilterInfo);
  // cosul nefinalizat se pastreaza cit timp frame-ul exista; casa se determina o singura data
  if not fTerminal.IsValid then
    LoadTerminal;
  UpdateHeader;
  WhenCartChanged(nil);
end;

function Tframe133POS.GetCurrentSearchContext: TSearchContextValue;
begin
  result := inherited;
end;

function Tframe133POS.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  result := [];
end;

function Tframe133POS.GetFrameButtons: TFrameButtons;
begin
  result := [fbtREFRESH];
end;

function Tframe133POS.InitFrameID: integer;
begin
  result := 133;
end;

procedure Tframe133POS.ReadFrameStates;
begin
end;

procedure Tframe133POS.RefreshData;
begin
  inherited;
  // Refresh = reciteste casa si tura (dupa ce a fost configurata casa, de exemplu)
  LoadTerminal;
  UpdateHeader;
  UpdateButtons;
end;

procedure Tframe133POS.SaveFrameStates;
begin
end;

procedure Tframe133POS.SetupDefaultFocus;
begin
  FocusSearch;
end;

procedure Tframe133POS.SetupSecurityItems;
begin
end;

{ casa si tura }

procedure Tframe133POS.LoadTerminal;
var
  ErrorText: string;
begin
  fShift.Clear;
  if POSDetectTerminal(fTerminal, ErrorText) then
  begin
    fCart.MaxDiscountP := fTerminal.MaxDiscountP;
    try
      POSGetOpenShift(fTerminal.PosID, fShift);
    except
      on E: Exception do
        ShowMessageLine('Tura nu poate fi citita: ' + E.Message, True);
    end;
  end
  else
    ShowMessageLine(ErrorText, True);
  WarnPendingJournal;
end;

procedure Tframe133POS.WarnPendingJournal;
var
  FileName: string;
begin
  if not fTerminal.IsValid then
    Exit;
  FileName := POSPendingJournalFile(fTerminal.PosID);
  if FileExists(FileName) then
    ShowMessageLine('ATENTIE: exista un bon tiparit si neinregistrat in baza: ' + FileName, True);
end;

procedure Tframe133POS.UpdateHeader;
begin
  if fTerminal.IsValid then
    lblTerminal.Caption := Format('%s  (casa %d, depozit %d)', [fTerminal.Title, fTerminal.PosID, fTerminal.StockID])
  else
    lblTerminal.Caption := 'Casa neconfigurata';

  if fShift.IsOpen then
    lblShift.Caption := Format('Tura %d, deschisa %s', [fShift.ShiftID, FormatDateTime('dd.mm.yyyy hh:nn', fShift.OpenedAt)])
  else
    lblShift.Caption := 'Tura inchisa';
end;

{ bonul }

procedure Tframe133POS.WhenCartChanged(Sender: TObject);
var
  I, Focused: Integer;
  Line: TPOSCartLine;
  DC: TcxCustomDataController;
begin
  Focused := FocusedLine;
  DC := gridCartView.DataController;
  DC.BeginUpdate;
  try
    DC.RecordCount := fCart.Count;
    for I := 0 to fCart.Count - 1 do
    begin
      Line := fCart[I];
      DC.Values[I, colNo.Index] := I + 1;
      DC.Values[I, colTitle.Index] := Line.Title;
      DC.Values[I, colSerial.Index] := Line.Serial;
      DC.Values[I, colQty.Index] := Line.Qty;
      DC.Values[I, colPrice.Index] := Line.Price;
      DC.Values[I, colDiscount.Index] := Line.DiscountP;
      DC.Values[I, colSuma.Index] := Line.Suma;
    end;
  finally
    DC.EndUpdate;
  end;
  if fCart.Count > 0 then
  begin
    if (Focused < 0) or (Focused >= fCart.Count) then
      Focused := fCart.Count - 1;
    FocusLine(Focused);
  end;
  UpdateTotals;
  UpdateButtons;
end;

procedure Tframe133POS.UpdateTotals;
begin
  lblTotal.Caption := FormatFloat(cMoneyFormat, fCart.Total);
  if fCart.TotalDiscount > 0 then
    lblDiscount.Caption := 'Reducere: ' + FormatFloat(cMoneyFormat, fCart.TotalDiscount)
  else
    lblDiscount.Caption := '';
  lblLines.Caption := Format('Pozitii: %d    Bucati: %s', [fCart.Count, FloatToStr(fCart.TotalQty)]);
end;

procedure Tframe133POS.UpdateButtons;
var
  HasLine: Boolean;
begin
  HasLine := FocusedLine >= 0;
  // fara tura deschisa nu se vinde
  edSearch.Enabled := fTerminal.IsValid and fShift.IsOpen;
  btnSearch.Enabled := edSearch.Enabled;
  btnShift.Enabled := fTerminal.IsValid;
  if fShift.IsOpen then
    btnShift.Caption := 'Inchide tura F10'
  else
    btnShift.Caption := 'Deschide tura F10';
  btnCashIn.Enabled := fShift.IsOpen;
  btnCashOut.Enabled := fShift.IsOpen;
  btnQtyPlus.Enabled := HasLine;
  btnQtyMinus.Enabled := HasLine;
  btnQty.Enabled := HasLine;
  btnDiscount.Enabled := HasLine and (fTerminal.MaxDiscountP > 0);
  btnDeleteLine.Enabled := HasLine;
  btnClear.Enabled := not fCart.IsEmpty;
  btnPay.Enabled := fShift.IsOpen and not fCart.IsEmpty;
end;

procedure Tframe133POS.ShowMessageLine(const Text: string; const IsError: Boolean);
begin
  lblMessage.Caption := Text;
  if IsError then
    lblMessage.Font.Color := clRed
  else
    lblMessage.Font.Color := clGreen;
end;

function Tframe133POS.FocusedLine: Integer;
begin
  Result := gridCartView.DataController.FocusedRecordIndex;
  if Result >= fCart.Count then
    Result := -1;
end;

procedure Tframe133POS.FocusLine(const Index: Integer);
begin
  if (Index >= 0) and (Index < gridCartView.DataController.RecordCount) then
    gridCartView.DataController.FocusedRecordIndex := Index;
end;

procedure Tframe133POS.FocusSearch;
begin
  if edSearch.CanFocus then
  begin
    edSearch.SetFocus;
    edSearch.SelectAll;
  end;
end;

{ cautare }

procedure Tframe133POS.DoSearch;
var
  Text: string;
begin
  Text := Trim(edSearch.Text);
  if (Text = '') or not fTerminal.IsValid then
    Exit;
  if not fShift.IsOpen then
  begin
    ShowMessageLine('Tura este inchisa. Deschideti tura (F10) inainte de a vinde.', True);
    Exit;
  end;
  HideResults;
  fLastSearchText := Text;
  try
    fResults := POSFindGoods(Text, fTerminal.PosID);
  except
    on E: Exception do
    begin
      ShowMessageLine('Cautarea a esuat: ' + E.Message, True);
      Exit;
    end;
  end;

  case Length(fResults) of
    0:
      begin
        ShowMessageLine(Format('Nimic gasit pentru "%s".', [Text]), True);
        FocusSearch;
      end;
    1:
      AddFoundGoods(fResults[0]);
  else
    ShowResults;
  end;
end;

procedure Tframe133POS.ShowResults;
var
  I: Integer;
  Item: TListItem;
begin
  lvResults.Items.BeginUpdate;
  try
    lvResults.Items.Clear;
    for I := 0 to High(fResults) do
    begin
      Item := lvResults.Items.Add;
      Item.Caption := fResults[I].Title;
      Item.SubItems.Add(fResults[I].Code);
      Item.SubItems.Add(FormatFloat(cMoneyFormat, fResults[I].Price));
      Item.SubItems.Add(FloatToStr(fResults[I].StockQty));
      Item.Data := Pointer(I);
    end;
  finally
    lvResults.Items.EndUpdate;
  end;
  lblResults.Caption := Format('%d potriviri - Enter = adauga, Esc = renunta', [Length(fResults)]);
  pnlResults.Visible := True;
  ShowMessageLine('', False);
  if lvResults.Items.Count > 0 then
  begin
    lvResults.ItemIndex := 0;
    lvResults.Items[0].Focused := True;
  end;
  if lvResults.CanFocus then
    lvResults.SetFocus;
end;

procedure Tframe133POS.HideResults;
begin
  pnlResults.Visible := False;
  lvResults.Items.Clear;
end;

procedure Tframe133POS.AddSelectedResult;
var
  Index: Integer;
begin
  if lvResults.Selected = nil then
    Exit;
  Index := Integer(lvResults.Selected.Data);
  if (Index < 0) or (Index > High(fResults)) then
    Exit;
  AddFoundGoods(fResults[Index]);
end;

procedure Tframe133POS.AddFoundGoods(const Goods: TPOSFoundGoods);
var
  Serial: string;
  Line: Integer;
  TypedCode: string;
begin
  Serial := '';
  if Goods.NeedsSerial then
    if not InputQuery('Numar de serie', Goods.Title, Serial) or (Trim(Serial) = '') then
    begin
      ShowMessageLine('Produsul nu a fost adaugat: lipseste numarul de serie.', True);
      FocusSearch;
      Exit;
    end;

  TypedCode := '';
  if Goods.MatchKind in [cPOS_Match_OwnBarcode, cPOS_Match_SupplierBarcode] then
    TypedCode := fLastSearchText;

  try
    Line := fCart.AddGoods(Goods, 1, Serial, TypedCode);
  except
    on E: EPOSCartError do
    begin
      ShowMessageLine(E.Message, True);
      FocusSearch;
      Exit;
    end;
  end;

  HideResults;
  FocusLine(Line);
  ShowMessageLine(Format('%s  -  %s', [Goods.Title, FormatFloat(cMoneyFormat, Goods.Price)]), False);
  edSearch.Text := '';
  FocusSearch;
end;

{ actiuni pe linie }

procedure Tframe133POS.AskQty;
var
  Value: string;
  Qty: Double;
  Index: Integer;
begin
  Index := FocusedLine;
  if Index < 0 then
    Exit;
  Value := FloatToStr(fCart[Index].Qty);
  if not InputQuery('Cantitate', fCart[Index].Title, Value) then
    Exit;
  Value := StringReplace(Trim(Value), ',', FormatSettings.DecimalSeparator, []);
  Value := StringReplace(Value, '.', FormatSettings.DecimalSeparator, []);
  if not TryStrToFloat(Value, Qty) then
  begin
    ShowMessageLine('Cantitate invalida.', True);
    Exit;
  end;
  try
    fCart.SetQty(Index, Qty);
    ShowMessageLine('', False);
  except
    on E: EPOSCartError do
      ShowMessageLine(E.Message, True);
  end;
  FocusSearch;
end;

procedure Tframe133POS.AskDiscount;
var
  Value: string;
  Percent, Index: Integer;
begin
  Index := FocusedLine;
  if Index < 0 then
    Exit;
  Value := IntToStr(fCart[Index].DiscountP);
  if not InputQuery('Reducere, %', Format('%s (maxim %d%%)', [fCart[Index].Title, fTerminal.MaxDiscountP]), Value) then
    Exit;
  if not TryStrToInt(Trim(Value), Percent) then
  begin
    ShowMessageLine('Reducere invalida.', True);
    Exit;
  end;
  try
    fCart.SetDiscountP(Index, Percent);
    ShowMessageLine('', False);
  except
    on E: EPOSCartError do
      ShowMessageLine(E.Message, True);
  end;
  FocusSearch;
end;

procedure Tframe133POS.DeleteFocusedLine;
var
  Index: Integer;
begin
  Index := FocusedLine;
  if Index < 0 then
    Exit;
  fCart.Delete(Index);
  ShowMessageLine('', False);
  FocusSearch;
end;

procedure Tframe133POS.ClearCart;
begin
  if fCart.IsEmpty then
    Exit;
  if MessageDlg('Goliti bonul curent?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  fCart.Clear;
  ShowMessageLine('', False);
  FocusSearch;
end;

{ tura }

procedure Tframe133POS.OpenOrCloseShift;
var
  Done: Boolean;
begin
  if not fTerminal.IsValid then
    Exit;
  if fShift.IsOpen then
  begin
    if not fCart.IsEmpty then
    begin
      ShowMessageLine('Bonul curent nu este gol: incasati-l sau goliti-l inainte de a inchide tura.', True);
      Exit;
    end;
    Done := TfrmPOSShiftDlg.Execute(Self, psmClose, fTerminal, fShift);
    if Done then
      ShowMessageLine('Tura a fost inchisa.', False);
  end
  else
  begin
    Done := TfrmPOSShiftDlg.Execute(Self, psmOpen, fTerminal, fShift);
    if Done then
      ShowMessageLine('Tura a fost deschisa.', False);
  end;
  if Done then
  begin
    UpdateHeader;
    UpdateButtons;
  end;
  FocusSearch;
end;

procedure Tframe133POS.CashMove(const IsIncome: Boolean);
var
  Mode: TPOSShiftDialogMode;
begin
  if not fShift.IsOpen then
    Exit;
  if IsIncome then
    Mode := psmCashIn
  else
    Mode := psmCashOut;
  if TfrmPOSShiftDlg.Execute(Self, Mode, fTerminal, fShift) then
    ShowMessageLine('Miscarea de numerar a fost inregistrata.', False);
  FocusSearch;
end;

{ incasare }

procedure Tframe133POS.PaySale;
var
  Payments: TPOSPaymentArray;
  R: TPOSCheckoutResult;
  Change: Currency;
  I: Integer;
begin
  if fCart.IsEmpty or not fShift.IsOpen then
    Exit;
  if not TfrmPOSPaymentDlg.Execute(Self, fCart.Total, Payments) then
  begin
    FocusSearch;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    R := POSCheckout(fTerminal, fShift, fCart, fTerminal.DefaultCustomerID, Payments,
      function: Integer
      var
        Value: string;
      begin
        Value := '';
        if InputQuery('Numarul bonului fiscal',
          'Bonul a fost tiparit, dar numarul nu a putut fi citit de pe aparat.' + sLineBreak +
          'Introduceti numarul bonului de pe hirtie:', Value) then
          Result := StrToIntDef(Trim(Value), 0)
        else
          Result := 0;
      end);
  finally
    Screen.Cursor := crDefault;
  end;

  case R.Outcome of
    pcoDone:
      begin
        Change := 0;
        for I := 0 to High(Payments) do
          Change := Change + Payments[I].Change;
        fCart.Clear;
        if Change > 0 then
          ShowMessageLine(Format('Bon fiscal %d incasat (document %d). REST PENTRU CLIENT: %s lei',
            [R.NumarBon, R.RashodDocID, FormatFloat(cMoneyFormat, Change)]), False)
        else
          ShowMessageLine(Format('Bon fiscal %d incasat (document %d).', [R.NumarBon, R.RashodDocID]), False);
      end;
    pcoFailedClean:
      begin
        // nimic tiparit, nimic in baza: bonul ramine in cos si se poate reincerca
        ShowMessageLine('Incasarea nu s-a facut: ' + R.ErrorText, True);
        MessageDlg('Incasarea nu s-a facut. Nu s-a tiparit nimic si in baza nu a ramas nimic.' + sLineBreak +
          sLineBreak + R.ErrorText, mtError, [mbOK], 0);
      end;
    pcoPrintedNotSaved:
      begin
        // clientul a platit si are bonul: cosul se goleste ca sa nu fie incasat a doua oara
        fCart.Clear;
        ShowMessageLine('ATENTIE: bon tiparit, dar NEINREGISTRAT in baza: ' + R.JournalFile, True);
        MessageDlg('Bonul fiscal A FOST TIPARIT, dar documentele NU au fost salvate in baza.' + sLineBreak +
          sLineBreak + R.ErrorText + sLineBreak + sLineBreak +
          'Detaliile bonului sint in fisierul:' + sLineBreak + R.JournalFile + sLineBreak + sLineBreak +
          'Anuntati administratorul. Pina la rezolvare casa nu mai incaseaza alte bonuri.', mtError, [mbOK], 0);
      end;
  end;
  FocusSearch;
end;

{ taste si butoane }

function Tframe133POS.HandleCommonKey(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := True;
  case Key of
    VK_F2: FocusSearch;
    VK_F4: AskQty;
    VK_F5: if btnDiscount.Enabled then AskDiscount;
    VK_F9: if btnPay.Enabled then PaySale;
    VK_F10: OpenOrCloseShift;
  else
    Result := False;
  end;
  if Result then
    Key := 0;
end;

procedure Tframe133POS.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if HandleCommonKey(Key, Shift) then
    Exit;
  case Key of
    VK_RETURN:
      begin
        Key := 0;
        DoSearch;
      end;
    VK_DOWN:
      begin
        Key := 0;
        if pnlResults.Visible and lvResults.CanFocus then
          lvResults.SetFocus
        else if gridCart.CanFocus then
          gridCart.SetFocus;
      end;
    VK_ESCAPE:
      begin
        Key := 0;
        if pnlResults.Visible then
          HideResults
        else if edSearch.Text <> '' then
          edSearch.Text := ''
        else
          ClearCart;
      end;
  end;
end;

procedure Tframe133POS.lvResultsDblClick(Sender: TObject);
begin
  AddSelectedResult;
end;

procedure Tframe133POS.lvResultsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        Key := 0;
        AddSelectedResult;
      end;
    VK_ESCAPE:
      begin
        Key := 0;
        HideResults;
        FocusSearch;
      end;
  end;
end;

procedure Tframe133POS.gridCartViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if HandleCommonKey(Key, Shift) then
    Exit;
  case Key of
    VK_ADD, VK_OEM_PLUS:
      begin
        Key := 0;
        btnQtyPlusClick(nil);
      end;
    VK_SUBTRACT, VK_OEM_MINUS:
      begin
        Key := 0;
        btnQtyMinusClick(nil);
      end;
    VK_DELETE:
      begin
        Key := 0;
        DeleteFocusedLine;
      end;
    VK_ESCAPE:
      begin
        Key := 0;
        FocusSearch;
      end;
  end;
end;

procedure Tframe133POS.btnSearchClick(Sender: TObject);
begin
  DoSearch;
end;

procedure Tframe133POS.btnQtyPlusClick(Sender: TObject);
begin
  if FocusedLine < 0 then
    Exit;
  try
    fCart.ChangeQty(FocusedLine, 1);
    ShowMessageLine('', False);
  except
    on E: EPOSCartError do
      ShowMessageLine(E.Message, True);
  end;
end;

procedure Tframe133POS.btnQtyMinusClick(Sender: TObject);
begin
  if FocusedLine < 0 then
    Exit;
  try
    fCart.ChangeQty(FocusedLine, -1);
    ShowMessageLine('', False);
  except
    on E: EPOSCartError do
      ShowMessageLine(E.Message, True);
  end;
end;

procedure Tframe133POS.btnQtyClick(Sender: TObject);
begin
  AskQty;
end;

procedure Tframe133POS.btnDiscountClick(Sender: TObject);
begin
  AskDiscount;
end;

procedure Tframe133POS.btnDeleteLineClick(Sender: TObject);
begin
  DeleteFocusedLine;
end;

procedure Tframe133POS.btnClearClick(Sender: TObject);
begin
  ClearCart;
end;

procedure Tframe133POS.btnPayClick(Sender: TObject);
begin
  PaySale;
end;

procedure Tframe133POS.btnShiftClick(Sender: TObject);
begin
  OpenOrCloseShift;
end;

procedure Tframe133POS.btnCashInClick(Sender: TObject);
begin
  CashMove(True);
end;

procedure Tframe133POS.btnCashOutClick(Sender: TObject);
begin
  CashMove(False);
end;

end.
