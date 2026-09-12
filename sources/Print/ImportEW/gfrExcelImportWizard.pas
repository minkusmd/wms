//******************************************************************************
//                                                      (c) corporatia Galaktika
//                                                       http://www.galaktika.by
// Galaktika 8.10 - Rapoarte FastReport 3
// Modul de import din Excel
//******************************************************************************

unit gfrExcelImportWizard;

interface

uses
  Windows
  , Messages
  , SysUtils
  , Variants
  , Graphics
  , Forms
  , XPMan
  , Math
  , CheckLst
  , Buttons
  , ComCtrls
  , StdCtrls
  , Dialogs
  , Controls
  , Classes
  , Printers
  , frxClass
  , frxDsgnIntf
  , frxDesgn
  , frxUtils
  {$ifdef _xlogs_}
  , xLogs
  {$endif}
  ;


////////////////////////////////////////////////////////////////////////////////
type
  TUsedRanges = record
    urRowBegin, urColBegin, urRowEnd, urColEnd : integer;
  end;

  TSheets = record
    selected : boolean;
    name : string;
    index : integer;
    pRowBegin, pColBegin, pRowEnd, pColEnd : integer;       // coordonatele zonei utilizate
    uRowBegin, uColBegin, uRowEnd, uColEnd : integer;       // coordonatele utilizatorului
    usedRange : array of TUsedRanges                        // matricea paginilor
  end;

  TgfrExcelImportForm = class(TForm)
    btnOpen: TButton;
    edFileName: TEdit;
    btnImport: TButton;
    Label1: TLabel;
    gbPages: TGroupBox;
    OpenDialog: TOpenDialog;
    sheetsList: TCheckListBox;
    GroupBox1: TGroupBox;
    rbPrintArea: TRadioButton;
    rbUsedRange: TRadioButton;
    rbManual: TRadioButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    edColStart: TEdit;
    edRowStart: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edColEnd: TEdit;
    Label5: TLabel;
    edRowEnd: TEdit;
    XPManifest1: TXPManifest;
    StatusBar: TStatusBar;
    cbMaxAccuracy: TCheckBox;
    edKoef: TEdit;
    btnCancel: TButton;
    btnCheckAll: TBitBtn;
    btnUncheckAll: TBitBtn;
    cbDivByPages: TCheckBox;
    Label6: TLabel;
    cbFitWidth: TCheckBox;
    procedure btnOpenClick(Sender: TObject);
    procedure disableAllControls;
    procedure enableAllControls;
    procedure fitCells(Page : TfrxReportPage);
    procedure manualRange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure xlUsedRange(address: string; sheetIndex : integer; shName : string);
    procedure sheetsListClickCheck(Sender: TObject);
    procedure sheetsListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbUsedRangeClick(Sender: TObject);
    procedure rbManualClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure rbPrintAreaClick(Sender: TObject);
    procedure ImportPage( fReport     : TfrxReport;
                          StatusBar   : TStatusBar;     //  status bar cu 3 elemente
                          sheet       : integer;        //  numarul foii
                          colStart    : integer;        //  coloana initiala
                          rowStart    : integer;        //  randul initial
                          colEnd      : integer;        //  coloana finala
                          rowEnd      : integer;        //  randul final
                          koef        : extended;       //  coeficient
                          fPageDef    : boolean;        //  flag anulare import
                          fAccuracy   : boolean         //  flag precizie
                        );
    function selectedPagesCount() : integer;
  private
    fCancel: boolean;
    sFileName: string;
  public
    ExcelApp: variant;
    sheets : array of TSheets;

    FDesigner: TfrxCustomDesigner;
    FReport: TfrxReport;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TfrxExcelImportWizard  = class(TfrxCustomWizard)
    class function GetDescription: String; override;
    function Execute: Boolean; override;
  end;

threadvar gfrExcelImportForm: TgfrExcelImportForm;

implementation

uses ComObj;

////////////////////////////////////////////////////////////////////////////////
// preluat din unit Excel2000;
const
  xlManual = $FFFFEFD9;

  // Constants for enum XlBordersIndex
  xlInsideHorizontal = $0000000C;
  xlInsideVertical = $0000000B;
  xlDiagonalDown = $00000005;
  xlDiagonalUp = $00000006;
  xlEdgeBottom = $00000009;
  xlEdgeLeft = $00000007;
  xlEdgeRight = $0000000A;
  xlEdgeTop = $00000008;

  // Constants for enum XlReferenceStyle
  xlA1 = $00000001;
  xlR1C1 = $FFFFEFCA;

  // Constants for enum XlPageOrientation
  xlLandscape = $00000002;
  xlPortrait = $00000001;

  // Constants for enum XlHAlign
  xlHAlignCenter = $FFFFEFF4;
  xlHAlignCenterAcrossSelection = $00000007;
  xlHAlignDistributed = $FFFFEFEB;
  xlHAlignFill = $00000005;
  xlHAlignGeneral = $00000001;
  xlHAlignJustify = $FFFFEFDE;
  xlHAlignLeft = $FFFFEFDD;
  xlHAlignRight = $FFFFEFC8;

  // Constants for enum XlVAlign
  xlVAlignBottom = $FFFFEFF5;
  xlVAlignCenter = $FFFFEFF4;
  xlVAlignDistributed = $FFFFEFEB;
  xlVAlignJustify = $FFFFEFDE;
  xlVAlignTop = $FFFFEFC0;

threadvar
  bmp: Graphics.TBitmap;

Const
  XlsWizardCaption = 'Import forma de raport din Excel';

{$R *.dfm}
{$R *.res}

//==============================================================================
// tratatoare evenimente formular
//==============================================================================

{ TgfrGalaxyParamWizard }
function TfrxExcelImportWizard.Execute: Boolean;
begin
  { interzicem orice desenare in designer }
  Designer.Lock;

  gfrExcelImportForm := TgfrExcelImportForm.Create(Report);
  try
    gfrExcelImportForm.FDesigner := Designer;
    gfrExcelImportForm.FReport := Report;
    gfrExcelImportForm.ShowModal;
  finally
    gfrExcelImportForm.Free;

    Designer.ReloadPages(Report.PagesCount - 1);
    result := true;
  end;
end;

class function TfrxExcelImportWizard.GetDescription: String;
begin
  result := XlsWizardCaption;
end;
{ TGalaxyParamWizardForm }

procedure TgfrExcelImportForm.FormShow(Sender: TObject);
begin
  edFileName.Enabled := true;
  btnOpen.Enabled := true;
  btnImport.Caption := 'Import';
  edFileName.Text := '';
  Caption := XlsWizardCaption;
  sheetsList.Items.Clear;
  sheetsList.Enabled := false;
  disableAllControls;
  btnOpen.Enabled := true;
  edFileName.ReadOnly := true;
end;

constructor TgfrExcelImportForm.Create(AOwner: TComponent);
begin
  {$ifdef _xlogs_} xLog(self, 'begin constructor TgfrExcelImportForm.Create', 1);  {$endif}

  inherited Create(AOwner);
  fCancel := false;
  sFileName := edFileName.Text;

  {$ifdef _xlogs_} xLog(self, 'end constructor TgfrExcelImportForm.Create', -1);  {$endif}
end;

procedure TgfrExcelImportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not VarIsEmpty(ExcelApp) then
  begin
    ExcelApp.DisplayAlerts := False;
    ExcelApp.Quit;
    ExcelApp := Unassigned;
    SetLength(sheets, 0);
  end;
end;

destructor TgfrExcelImportForm.Destroy;
begin
  {$ifdef _xlogs_} xLog(self, 'begin destructor TgfrExcelImportForm.Destroy', 1);  {$endif}

  inherited Destroy;

  {$ifdef _xlogs_} xLog(self, 'end destructor TgfrExcelImportForm.Destroy', -1);  {$endif}
end;
//==============================================================================

function AddrCell(Col, Row: integer): string; // adresa celulei in format alfabetic
var kol, i: integer;
begin
  kol := ord('z') - ord('a') + 1;
  Result := '';
  while col > 0 do
    begin
    i := col mod kol;
    if i = 0 then
      i := 26;
    col := (col-1) div kol;
    Result := chr(ord('a') + i-1) + Result;
    end;
  Result := Result + IntToStr(row);
end;

function DecodeCol(Col: string): integer;  // transforma denumirea alfabetica a coloanei in numar
var kol, i: integer;
begin
  col := trim(LowerCase(Col));
  kol := ord('z') - ord('a') + 1;
  Result := 0;
  for i := 1 to length(col) do
    Result := Result * kol +  ord(col[i]) - ord('a') + 1;
end;

procedure TgfrExcelImportForm.xlUsedRange(address: string; sheetIndex : integer; shName : string);
  var  substr : string;
       isBegin : boolean;
       i, j, len, HBreaksCount, VBreaksCount, Row, Col : integer;
       HBreaks, VBreaks : array of integer;
  begin
    isBegin := true;
    substr := '';
    setLength(sheets, length(sheets)+1);
    len := sheetIndex - 1;
    for i := 2 to length(address) do
    case address[i] of
    'R' : if isBegin then substr := substr;
    'C' : if isBegin then
            begin
              sheets[len].pRowBegin := strToInt(substr);
              sheets[len].uRowBegin := strToInt(substr);
              sheets[len].pRowEnd := 1; //  Pentru cazul unei singure celule
              sheets[len].uRowEnd := 1; //
              sheets[len].pColBegin := 1;
              sheets[len].uColBegin := 1;
              substr := '';
            end
          else
            begin
              sheets[len].pRowEnd := strToInt(substr);
              sheets[len].uRowEnd := strToInt(substr);
              substr := '';
            end;
    ':' : begin
            isBegin := false;
            sheets[len].pColBegin := strToInt(substr);
            sheets[len].uColBegin := strToInt(substr);
            substr := '';
          end;
    else substr := substr + address[i];
    end;
    sheets[len].pColEnd := strToInt(substr);
    sheets[len].uColEnd := strToInt(substr);
    sheets[len].index  := sheetIndex;
    sheets[len].name   := shName;

    if (sheets[len].pColBegin = 0) or (sheets[len].pRowBegin = 0) or     // stergerea foilor goale
       (sheets[len].pRowEnd = 0) or (sheets[len].pColEnd = 0) then
      begin
        SetLength(sheets, length(sheets)-1);
        exit;
      end;

    SetLength(VBreaks, 0);
    SetLength(HBreaks, 0);

    HBreaksCount := ExcelApp.Worksheets[sheetIndex].HPageBreaks.Count;
    VBreaksCount := ExcelApp.Worksheets[sheetIndex].VPageBreaks.Count;

//    if (HBreaksCount = 0) and (VBreaksCount <> 0) then    // daca raportul este "inalt" cu latimea de 1 pagina, a fost un bug
//      dec(VBreaksCount);                                  // asa totul e ok
//    if (VBreaksCount = 0) and (HBreaksCount <> 0) then    // daca raportul este "lat"
//      dec(HBreaksCount);

    for i := 1 to HBreaksCount + 1 do
      if i <> HBreaksCount + 1 then
        try
          SetLength(HBreaks, length(HBreaks)+1);
          substr := trim(varToStr(ExcelApp.Worksheets[sheetIndex].HPageBreaks[i].Location.Address[ReferenceStyle := xlR1C1]));
          substr := copy(substr, 2, pos('C', substr)-2);
          HBreaks[length(HBreaks)-1] := strToInt(substr)-1;
        except
          on EOleException do SetLength(HBreaks, length(HBreaks)-1);
      end
      else
      begin
        SetLength(HBreaks, length(HBreaks)+1);
        HBreaks[length(HBreaks)-1] := sheets[len].pRowEnd;
      end;

    for i := 1 to VBreaksCount + 1 do
      if i <> VBreaksCount + 1 then
        try
          SetLength(VBreaks, length(VBreaks)+1);
          substr := trim(varToStr(ExcelApp.Worksheets[sheetIndex].VPageBreaks[i].Location.Address[ReferenceStyle := xlR1C1]));
          substr := copy(substr, pos('C', substr)+1, length(substr)-pos('C', substr));
          VBreaks[length(VBreaks)-1] := strToInt(substr)-1;
        except
          on EOleException do SetLength(HBreaks, length(HBreaks)-1);
      end
      else
      begin
        SetLength(VBreaks, length(VBreaks)+1);
        VBreaks[length(VBreaks)-1] := sheets[len].pColEnd;
      end;

    for i := 2 to length(HBreaks) do
      if HBreaks[i-1] = HBreaks[i-2]
        then SetLength(HBreaks, length(HBreaks) - 1);

    for i := 0 to length(HBreaks)-1 do
    begin
      if i <> 0 then
        row := HBreaks[i-1] +1
      else
        row := sheets[len].pRowBegin;

      for j := 0 to length(VBreaks)-1 do
      begin
        SetLength(sheets[len].usedRange, length(sheets[len].usedRange)+1);
        if j <> 0 then
          col := VBreaks[j-1] + 1
        else
          col := sheets[len].pColBegin;

        sheets[len].usedRange[length(sheets[len].usedRange)-1].urRowBegin := row;
        sheets[len].usedRange[length(sheets[len].usedRange)-1].urColBegin := col;
        sheets[len].usedRange[length(sheets[len].usedRange)-1].urRowEnd := HBreaks[i];
        sheets[len].usedRange[length(sheets[len].usedRange)-1].urColEnd := VBreaks[j];
      end;
    end;
  end;

function TgfrExcelImportForm.selectedPagesCount() : integer;
var i : integer;
begin
Result := 0;
  for i:=0 to sheetsList.Items.Capacity-1 do
    if sheets[i].selected then
     inc(Result);
end;

// functia de import
procedure TgfrExcelImportForm.ImportPage( fReport     : TfrxReport;
                          StatusBar   : TStatusBar;     //  status bar cu 3 elemente
                          sheet       : integer;        //  numarul foii
                          colStart    : integer;        //  coloana initiala
                          rowStart    : integer;        //  randul initial
                          colEnd      : integer;        //  coloana finala
                          rowEnd      : integer;        //  randul final
                          koef        : extended;       //  coeficient
                          fPageDef    : boolean;        //  flag anulare import
                          fAccuracy   : boolean         //  flag precizie
                        );
var row, Col : integer;
    firstX, firstY, maxHeight, maxWidth : extended;
    adr, txt: string;
    frType: TfrxFrameTypes;
    is4Frame, isColor, fMerge{, isSame {daca celula precedenta = celula curenta}: boolean;
    color : TColor;
    v: TfrxMemoView;
    ProgressBar : TProgressBar;
    Page : TfrxReportPage;
    curRange : variant;

  function GetFrameType: boolean;
  var
    x : integer;
  begin
  frType := [];
  Result := false;
  x := 4;
    if (curRange.MergeArea.Borders[xlEdgeLeft].LineStyle <> -4142) then begin
      frType := frType + [ftLeft];
      dec(x);
    end;

    if (curRange.MergeArea.Borders[xlEdgeTop].LineStyle <> -4142) then begin
      frType := frType + [ftTop];
      dec(x);
    end;

    if (curRange.MergeArea.Borders[xlEdgeRight].LineStyle <> -4142) then begin
      frType := frType + [ftRight];
      dec(x);
    end;

    if (curRange.MergeArea.Borders[xlEdgeBottom].LineStyle <> -4142) then begin
      frType := frType + [ftBottom];
      dec(x);
    end;

    if not fAccuracy then
      Result := (x=0)
    else
      if frType <> [] then
        Result := true;
  end;

  function GetColor: boolean;
  var column, colindex : longint;
  begin
  column := strToInt(VarToStr(curRange.Interior.Color));
  colindex := StrToInt(VarToStr(curRange.Interior.ColorIndex));
  color := clNone;
  Result := false;
  if ((colIndex = -4142) or             //  Const xlColorIndexNone = -4142 (&HFFFFEFD2)
      (colIndex = -4105) or             //  Const xlColorIndexAutomatic = -4105 (&HFFFFEFF7)
      (column = ColorToRGB(clWindow))) then
    color := clNone
  else
    begin
      color := curRange.Interior.Color;
      Result := true;
    end;
  end;

  function getNewCol(adress : string) : integer;
  var substr : string;
      i : integer;
  begin
    i:=Pos(':', adress)+2;
    Substr := '';
      while adress[i] <> '$' do
      begin
        substr := substr + adress[i];
        i:= i + 1;
      end;
    Result := DecodeCol(substr);
  end;

  function CellWidth(isMerge : boolean) : extended;        //  calculeaza latimea celulei
  begin
//  koef := 1.358;
  if isMerge then
    Result := curRange.MergeArea.Width
  else
//    if v.Memo.Text = '' then
      Result := curRange.Width
//    else
//      Result := (v.Font.Size * length(v.Memo.Text)) / koef;

//  if (v.HAlign = haRight) and (not fMerge) and (v.Memo.Text <> '') then
//    v.Left := v.Left - Result {+ curRange.MergeArea.Width*1.242};


 //   if Result <
    //  if v.HAlign <> haRight then                            // trebuie de gasit ceva pentru dimensiunea fontului
//    Result := length(v.Memo.Text)*4
//  else
//    begin
//      Result := length(v.Memo.Text)*4;
//      v.Left := v.Left - Result;// + curRange.MergeArea.Width;
//    end;
  end;

  procedure createPage();
  begin
  // crearea unei pagini noi in raport
  Page := TfrxReportPage.Create(fReport);
  Page.CreateUniqueName;
  Page.SetDefaults;

  if ExcelApp.Worksheets[sheet].PageSetup.Orientation = xlLandscape then      //= 2
    Page.Orientation := poLandscape
  else
    Page.Orientation := poPortrait;
  end;

begin
if not fCancel then
begin
  if StatusBar.Showing then
  begin
    ProgressBar := TProgressBar.Create(StatusBar);
    ProgressBar.Parent := StatusBar;
    ProgressBar.SetBounds(0, 2, StatusBar.Panels[0].Width, StatusBar.Height-2);
    ProgressBar.Max := rowEnd;
    ProgressBar.Min := RowStart;
  end;
  ExcelApp.WorkSheets[sheet].Activate;
  // crearea unei pagini noi
  createPage();

  maxHeight := 0;
  maxWidth  := 0;

  col := colStart;
  row := rowStart;
  adr := AddrCell(Col,row);
  firstX := ExcelApp.Worksheets[sheet].Cells.Range[adr, adr].Left;
  firstY := ExcelApp.Worksheets[sheet].Cells.Range[adr, adr].Top;

  while (col <= colEnd) and (row <= rowEnd) and (not fCancel) do
  begin
    Application.ProcessMessages;
//    isSame := false;
    if StatusBar.Showing then
      ProgressBar.Position := row;
    fMerge := false;
    adr := AddrCell(Col,row);
    curRange := ExcelApp.Cells.Range[adr,adr];
    if curRange.MergeCells then
      fMerge := true;

    if (curRange.MergeArea.Column = Col) and (curRange.MergeArea.Row = Row) then//or
    begin
      txt := curRange.Text;
      if StatusBar.Showing then
      begin
        StatusBar.Panels[1].Text := adr;
        StatusBar.Panels[2].Text := txt;
      end;

      is4Frame := getFrametype;
      isColor := getColor;
{
      if Page.Objects.Count > 0 then
        if (prevV.Frame.Typ = frType) and
           (prevV.Color = color) and
           (prevV.Memo.Text = txt) and (not fMerge) then
          isSame := true;
}
      if ((trim(txt) <> '') or is4Frame or isColor){ and (not isSame) }then
        begin
          v := TfrxMemoView.Create(Page);
          v.CreateUniqueName;
//          v.Name := v.Name + 'Page'+inttostr(sheet)+'_Cell' + adr;
          v.Memo.Text := txt;
{$WARNINGS OFF}
          case curRange.HorizontalAlignment of
            xlHAlignRight                 {-4152}: v.HAlign := haRight;
            xlHAlignCenter                {-4108},
            xlHAlignCenterAcrossSelection     {7}: v.HAlign := haCenter;
          else v.HAlign := haLeft;
          end;
          case curRange.VerticalAlignment of
            xlVAlignBottom                {-4107}: v.VAlign := vaBottom;
            xlVAlignCenter                {-4108},
            xlVAlignJustify               {-4130}: v.VAlign := vaCenter;
          end;
{$WARNINGS ON}
          if fMerge then
            col := getNewCol(varToStr(curRange.MergeArea.Address));
          v.Frame.Typ := frType;
          v.Color := color;
//          v.AutoWidth := not curRange.MergeCells and (trim(txt) <> '');
          try
          if curRange.Text <> '' then
          begin
            if curRange.Font.Name <> Null then
              v.Font.Name := curRange.Font.Name;
            if curRange.Font.Size <> Null then
              v.Font.Size := curRange.Font.Size;
            v.Font.Style := [];
            if curRange.Font.Bold <> Null then
             if curRange.Font.Bold then
              v.Font.Style := v.Font.Style + [fsBold];
//            if ExcelApp.ActiveCell.Font.Underline <> Null then
//             if ExcelApp.ActiveCell.Font.Underline then
//              v.Font.Style := v.Font.Style + [fsUnderline];
            if curRange.Font.Italic <> Null then
             if curRange.Font.Italic then
              v.Font.Style := v.Font.Style + [fsItalic];
          end;
          except
          end;
          v.Left := curRange.Left - firstX;
          v.Top := curRange.Top - firstY;
          v.Width := CellWidth(fMerge);
          v.Height := curRange.MergeArea.Height;
          // incadrare dupa cuvinte
          v.WordWrap := curRange.WrapText;
          // text inclinat
          if curRange.Orientation <> -4128 then
            v.Rotation := curRange.Orientation
          else
            v.Rotation := 0;

          if (koef <> 1) and (koef > 0) then
          begin
            v.Left := v.left * koef;
            v.Top := v.Top * koef;
            v.Width := v.Width * koef;
            v.Height := v.Height * koef;
          end;

          if (v.Top + v.Height > maxHeight) then
            maxHeight := v.Top + v.Height;
//------------------------------------------------------------------------------
          if (not fMerge) and (v.Memo.Text <> '') and (v.Width < length(v.Memo.Text)*8) and     //????
             (v.WordWrap = false) and (v.Rotation = 0) then
          begin
            case v.HAlign of
              haLeft  : v.TagStr := 'r';
              haRight : v.TagStr := 'l';
            end;
          end;
//------------------------------------------------------------------------------
//          prevV := v;
        end
//        else
//          prevV.Width := prevV.Width + cellWidth(fMerge);
      end;
    Inc(Col);

    if Col > colEnd then begin
      Col := ColStart;
      Inc(row);
      if (Page.Objects.Count > 0) then
        if (v.Left + v.Width > maxWidth) then
          maxWidth := v.Left + v.Width;
    end;
  end;

  if Page.Objects.Count = 0 then  // daca pagina nu contine nimic, adica este goala
  begin                           // atunci o stergem
    Page.Free;
    ProgressBar.Free;
    exit;
  end;

  if not fPageDef then
  begin
    if (maxHeight > Page.Height - (Page.TopMargin + Page.BottomMargin) * fr01cm) then
      Page.PaperHeight := maxHeight / fr01cm + Page.BottomMargin + Page.TopMargin + 2;
    if (maxWidth > Page.Width - (Page.RightMargin + Page.LeftMargin) * fr01cm) then
      Page.PaperWidth := maxWidth / fr01cm + Page.RightMargin + Page.LeftMargin + 2;
  end;
  ProgressBar.Free;
  if cbFitWidth.Checked then
    fitCells(Page);
end;
end;

//==============================================================================
// handler-e pentru butoane
//==============================================================================

procedure TgfrExcelImportForm.btnOpenClick(Sender: TObject);
Var i, pagesCount : integer;
    name : string;
    ProgressBar : TProgressBar;
    excelVer : extended;
begin
  SetLength(sheets, 0);

  if Assigned(frxDesignerComp) then
    OpenDialog.InitialDir := frxDesignerComp.OpenDir;

  if Not OpenDialog.Execute then exit;
    edFileName.Text := OpenDialog.FileName;

  if not VarIsEmpty(ExcelApp) then
  begin
    ExcelApp.DisplayAlerts := False;
    ExcelApp.Quit;
    ExcelApp := Unassigned;
  end;

  try
    ExcelApp := CreateOleObject('Excel.Application');
  except
    ExcelApp := Unassigned;

    Application.MessageBox(PChar('Eroare la initializarea Excel.'#13#10'Posibil aplicatia nu este instalata.'),
                                 'Eroare', MB_OK or MB_ICONERROR);
    exit;
  end;

  try
    excelVer := frxStrToFloat(VarToStr(ExcelApp.Version));
  except
    excelVer := 0;
  end;

  if excelVer > 9 then
  begin
    ExcelApp.Workbooks.Open(OpenDialog.FileName, ReadOnly:=true, IgnoreReadOnlyRecommended := true, Editable := false);
// optimization
  //ExcelApp.ScreenUpdating := False;
    ExcelApp.Calculation := xlManual;
    ExcelApp.ErrorCheckingOptions.BackgroundChecking := False;
    ExcelApp.ErrorCheckingOptions.NumberAsText := False;
    ExcelApp.ErrorCheckingOptions.InconsistentFormula := False;

    sheetsList.Items.Clear;
    pagesCount := ExcelApp.Worksheets.Count;

    ProgressBar := TProgressBar.Create(StatusBar);
    ProgressBar.Parent := StatusBar;
    ProgressBar.SetBounds(0, 2, StatusBar.Panels[0].Width, StatusBar.Height-2);
    ProgressBar.Position := 0;
    ProgressBar.Max := pagesCount;

    SetLength(sheets, pagesCount);

    for i:= 1 to pagesCount do
    begin
//    ExcelApp.ActiveWorkbook.Worksheets.Item[i].PageSetup.PrintArea := ExcelApp.ActiveWorkbook.Worksheets.Item[i].PageSetup.PrintArea;
      Application.ProcessMessages;
      ProgressBar.Position := i;
      if strToInt(varToStr(ExcelApp.ActiveWorkbook.Worksheets.Item[i].Visible)) = -1 then
      begin
        name := varToStr(ExcelApp.ActiveWorkbook.Worksheets.Item[i].Name);
        sheetsList.Items.Add(name);
        xlUsedRange(varToStr(ExcelApp.ActiveWorkbook.Worksheets.Item[i].UsedRange.Address[ReferenceStyle := xlR1C1]), i, name);
      end;
    end;
    ProgressBar.Free;
    enableAllControls;
  end
  else
    MessageDlg('Este necesar MS Office versiunea XP sau mai noua!', mtWarning, [mbOK], 0);
end;

procedure TgfrExcelImportForm.btnImportClick(Sender: TObject);
var
  i, k, all, current, sec : integer;
  adr : string;
begin     // Import
if trim(btnImport.Caption) = 'Import' then
begin
  current := 0;
  all := selectedPagesCount();
  disableAllControls;
  fCancel := false;
  SheetsList.Enabled := false;
  btnImport.Enabled := true;
//  fReport.Clear;
//  try
  for i := 0 to length(sheets)-1 do
    if sheets[i].selected then
    begin
      sec := strtoInt(FormatDateTime('ss', Now))+strtoInt(FormatDateTime('nn', Now))*60;
      inc(current);
      btnImport.Caption := 'Stop';
      sheetsList.Selected[i] := true;
      Self.Text := 'Import pagina '+inttostr(current)+' din '+inttostr(all);
      if rbUsedRange.Checked then
      begin
        adr := AddrCell(sheets[i].pColBegin, sheets[i].pRowBegin);
        edRowStart.Text := inttostr(sheets[i].pRowBegin);
        edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
        adr := AddrCell(sheets[i].pColEnd, sheets[i].pRowEnd);
        edRowend.Text := inttostr(sheets[i].pRowEnd);
        edColEnd.Text := copy(adr, 1, length(adr) - length(edRowEnd.Text));
        ImportPage(fReport, StatusBar, sheets[i].index, sheets[i].pColBegin,
                   sheets[i].pRowBegin, sheets[i].pColEnd, sheets[i].pRowEnd,
                   frxStrToFloat(edKoef.Text), false, cbMaxAccuracy.Checked );
      end;
      if rbManual.Checked then
      begin
        adr := AddrCell(sheets[i].uColBegin, sheets[i].uRowBegin);
        edRowStart.Text := inttostr(sheets[i].uRowBegin);
        edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
        adr := AddrCell(sheets[i].uColEnd, sheets[i].uRowEnd);
        edRowend.Text := inttostr(sheets[i].uRowEnd);
        edColEnd.Text := copy(adr, 1, length(adr)-length(edRowEnd.Text));

        ImportPage(fReport, StatusBar, sheets[i].index, sheets[i].uColBegin,
                   sheets[i].uRowBegin, sheets[i].uColEnd, sheets[i].uRowEnd,
                   frxStrToFloat(edKoef.Text), false, cbMaxAccuracy.Checked );
      end;
      if rbPrintArea.Checked then
      begin
        if cbDivByPages.Checked then
        for k := 0 to length(sheets[i].usedRange)-1 do
        begin
          Self.Text := 'Import zona de printare ' +inttostr(k + 1) + ' din ' + inttostr(length(sheets[i].usedRange));
          adr := AddrCell(sheets[i].usedRange[k].urColBegin, sheets[i].usedRange[k].urRowBegin);
          edRowStart.Text := inttostr(sheets[i].usedRange[k].urRowBegin);
          edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
          adr := AddrCell(sheets[i].usedRange[k].urColEnd, sheets[i].usedRange[k].urRowEnd);
          edRowend.Text := inttostr(sheets[i].usedRange[k].urRowEnd);
          edColEnd.Text := copy(adr, 1, length(adr)-length(edRowEnd.Text));

          ImportPage(fReport, StatusBar, sheets[i].index, sheets[i].usedRange[k].urColBegin,
                     sheets[i].usedRange[k].urRowBegin, sheets[i].usedRange[k].urColEnd, sheets[i].usedRange[k].urRowEnd,
                     frxStrToFloat(edKoef.Text), false, cbMaxAccuracy.Checked );
        end
        else
          ImportPage(fReport, StatusBar, sheets[i].index, sheets[i].pColBegin,
                     sheets[i].pRowBegin, sheets[i].pColEnd, sheets[i].pRowEnd,
                     frxStrToFloat(edKoef.Text), false, cbMaxAccuracy.Checked );
      end;

      sec := strtoInt(FormatDateTime('ss', Now)) + strtoInt(FormatDateTime('nn', Now))*60 - sec;
      StatusBar.Panels[2].Text := 'timp de import: ' + inttoStr(sec) + ' sec.';
          {FormatDateTime('hh:nn:ss:zzz', TimeStampToDateTime(MSecsToTimeStamp(t2-t1)));}
    end;
    ExcelApp.DisplayAlerts := false;
//  except
//    showmessage('A aparut o eroare la import');
//  end;
  enableAllControls;

//  if fDesigner.Modified then
//    fDesigner.ReloadReport;
  fDesigner.Refresh;
//  fDesigner.Modified := true;
end
else
  fCancel := true;
  enableAllControls;
  btnImport.Caption := 'Import';
  Self.Text := XlsWizardCaption;
  ModalResult := mrOk;
end;

procedure TgfrExcelImportForm.btnCancelClick(Sender: TObject);
begin
  fCancel := true;
  ModalResult := mrCancel;
end;

procedure TgfrExcelImportForm.btnCheckAllClick(Sender: TObject);
var i : integer;
begin
  sheetsList.SelectAll;  // ?? nu functioneaza
  for i:=0 to sheetsList.Count-1 do
    sheetsList.Checked[i] := true;
  sheetsListClickCheck(Sender);
end;

procedure TgfrExcelImportForm.btnUncheckAllClick(Sender: TObject);
var i : integer;
begin
  for i:=0 to sheetsList.Count-1 do
    sheetsList.Checked[i] := false;
  sheetsListClickCheck(Sender);
end;
//==============================================================================

procedure TgfrExcelImportForm.sheetsListClickCheck(Sender: TObject);
var i : integer;
begin
  for i:=0 to sheetsList.Items.Capacity-1 do
    sheets[i].selected := sheetsList.Checked[i];
end;
//------------------------------------------------------------------------------
procedure TgfrExcelImportForm.fitCells(Page : TfrxReportPage);
var i, j, nearestItem : integer;
    fItem, curItem : TfrxCustomMemoView;
    finded : array of integer;
    k : extended;

  function findNearest(curItNum : integer; isToRight : boolean) : integer; // gaseste elementul cel mai din dreapta sau din stanga
  var min, max : integer;
      crItem, cItem : TfrxCustomMemoView;

    function findMin(minimum : extended): integer;
    var i : integer;
        curMin : extended;
        it : TfrxCustomMemoView;
    begin
      result := -1;
      curMin := MaxExtended;
      for i := 0 to length(finded) - 1  do
      begin
        it := Page.Objects.Items[finded[i]];
        if (it.Left >= minimum) then
          if it.Left < curMin then
          begin
            curMin := it.Left;
            result := i;
          end;
      end;
    end; // findMin

    function findMax(maximum : extended): integer;
    var i : integer;
        curMax : extended;
        it : TfrxCustomMemoView;
    begin
      result := -1;
      curMax := MinExtended;
      for i := 0 to length(finded) - 1  do
      begin
        it := Page.Objects.Items[finded[i]];
        if (it.Left + it.Width <= maximum) then
          if it.Left + it.Width > curMax then
          begin
            curMax := it.Left + it.Width;
            result := i;
          end;
      end;
    end; // findMax

  begin
    result := -1;
    cItem := Page.Objects.Items[curItNum];
    if length(finded) > 0 then
    begin
      min := findMin(cItem.Left);
      max := findMax(cItem.Left + cItem.Width);
    end
    else
    begin
      min := -1;
      max := -1;
    end;

    if isToRight then
    begin
      if (min > -1) then
      begin
        crItem := Page.Objects.Items[finded[min]];
        if cItem.Left < crItem.Left then
          result := finded[min]
      end
      else  // elementul cel mai din dreapta
          result := -1;
    end
    else if (not isToRight) then
      if max > -1 then
      begin
        crItem := Page.Objects.Items[finded[max]];
        if cItem.Left > crItem.Left then
          result := finded[max];
    end
    else
      result := -1;
  end; // findNearest

begin
  for i := 0 to Page.Objects.Count - 1 do
  begin
    curItem := Page.Objects.Items[i];
    SetLength(finded,0);
    if curItem.TagStr <> '' then
    begin
      for j := 0 to Page.Objects.Count - 1 do
      begin
        fItem := Page.Objects.Items[j];
        if curItem.Name <> fItem.Name then
          if (curItem.AbsTop < fItem.AbsTop + fItem.Height - 1e-4) and
             (fItem.AbsTop < curItem.AbsTop + curItem.Height - 1e-4) then
          begin
            SetLength(finded, length(finded) + 1);
            finded[length(finded) - 1] := j;
          end;
      end;

    if curItem.TagStr = 'r' then
    begin
      nearestItem := findNearest(i, true);
      if nearestItem >=0 then
      begin
        fItem := Page.Objects.Items[nearestItem];
        if (fItem.TagStr = '') or (fItem.TagStr = 'r') then
           curItem.Width := fItem.Left - curItem.Left
        else if fItem.TagStr = 'l' then
        begin
          k := length(curItem.Memo.Text) / length(fItem.Memo.Text);
          if k > 1 then
            k := 1 - 1 / (k + 1);
          curItem.Width := (fItem.Left + fItem.Width - curItem.Left) * k;
          fItem.Width := fItem.Left + fItem.Width - curItem.Left - curItem.Width;
          fItem.Left := curItem.Left + curItem.Width;
        end;
        curItem.TagStr := ''
      end
      else
      begin
        curItem.Width := Page.Width - curItem.Left - (Page.RightMargin + Page.LeftMargin) * fr01cm;
        curItem.TagStr := '';
      end;
    end
    else if curItem.TagStr = 'l' then
    begin
      nearestItem := findNearest(i, false);
      if nearestItem >= 0 then
      begin
        fItem := Page.Objects.Items[nearestItem];
        if (fItem.TagStr = '') or (fItem.TagStr = 'l') then
        begin
          curItem.Width := curItem.Width + (curItem.Left - (fItem.Left + fItem.Width));
          curItem.Left := fItem.Left + fItem.Width;
        end;
      end
      else
      begin
        curItem.Width := CurItem.Left + curItem.Width;
        curItem.Left := 0;
        curItem.TagStr := '';
      end;
    end;
  end;
  end;
end;

procedure TgfrExcelImportForm.disableAllControls;
begin
  cbMaxAccuracy.Enabled := false;
  cbDivByPages.Enabled := false;
  btnOpen.Enabled := false;
  btnImport.Enabled := false;
  btnCheckAll.Enabled := false;
  btnUncheckAll.Enabled := false;
  edFileName.Enabled := false;
  edKoef.Enabled := false;
  edColStart.Enabled := false;
  edRowStart.Enabled := false;
  edColEnd.Enabled := false;
  edRowEnd.Enabled := false;
  rbPrintArea.Enabled := false;
  rbUsedRange.Enabled := false;
  rbManual.Enabled := false;
end;

procedure TgfrExcelImportForm.enableAllControls;
begin
  cbMaxAccuracy.Enabled := true;
//  cbDivByPages.Enabled := true;
  btnOpen.Enabled := true;
  btnImport.Enabled := true;
  btnCheckAll.Enabled := true;
  btnUncheckAll.Enabled := true;
//  edFileName.Enabled := true;
  edKoef.Enabled := true;
//  edColStart.Enabled := true;
//  edRowStart.Enabled := true;
//  edColEnd.Enabled := true;
//  edRowEnd.Enabled := true;
  sheetsList.Enabled := true;
  rbPrintArea.Enabled := true;
  rbUsedRange.Enabled := true;
  rbManual.Enabled := true;
end;

procedure TgfrExcelImportForm.manualRange(Sender: TObject);
var i : integer;
begin
for i := 0 to sheetslist.Count-1 do
  if sheetsList.Selected[i] then
  begin
    sheets[i].uColBegin := DecodeCol(edColStart.Text);
    sheets[i].uRowBegin := strToInt(edRowStart.Text);
    sheets[i].uRowEnd   := strToInt(edRowend.Text);
    sheets[i].uColEnd   := DecodeCol(edColend.Text);
    break;
  end;
end;

procedure TgfrExcelImportForm.sheetsListClick(Sender: TObject);
var   i : integer;
    adr : string;
begin

  if rbUsedRange.Enabled or rbPrintArea.Checked then
    for i := 0 to sheetslist.Count-1 do
      if sheetsList.Selected[i] then
      begin
        adr := AddrCell(sheets[i].pColBegin, sheets[i].pRowBegin);
        edRowStart.Text := inttostr(sheets[i].pRowBegin);
        edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
        adr := AddrCell(sheets[i].pColEnd, sheets[i].pRowEnd);
        edRowend.Text := inttostr(sheets[i].pRowEnd);
        edColEnd.Text := copy(adr, 1, length(adr)-length(edRowEnd.Text));
        break;
      end;

  if rbManual.Checked then
    for i := 0 to sheetslist.Count-1 do
      if sheetsList.Selected[i] then
      begin
        adr := AddrCell(sheets[i].uColBegin, sheets[i].uRowBegin);
        edRowStart.Text := inttostr(sheets[i].uRowBegin);
        edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
        adr := AddrCell(sheets[i].uColEnd, sheets[i].uRowEnd);
        edRowend.Text := inttostr(sheets[i].uRowEnd);
        edColEnd.Text := copy(adr, 1, length(adr)-length(edRowEnd.Text));
        break;
      end;

{  if rbPrintArea.Checked then
    for i := 0 to sheetslist.Count-1 do
      if sheetsList.Selected[i] then
      begin
        for k := 0 to length(sheets[i].usedRange) do     //  pe pagini
        begin
          adr := AddrCell(sheets[i].usedRange[k].urColBegin, sheets[i].usedRange[k].urRowBegin);
          edRowStart.Text := inttostr(sheets[i].usedRange[k].urRowBegin);
          edColStart.Text := copy(adr, 1, length(adr)-length(edRowStart.Text));
          adr := AddrCell(sheets[i].usedRange[k].urColEnd, sheets[i].usedRange[k].urRowEnd);
          edRowend.Text := inttostr(sheets[i].usedRange[k].urRowEnd);
          edColEnd.Text := copy(adr, 1, length(adr)-length(edRowEnd.Text));
        end;
      end;
}
end;

procedure TgfrExcelImportForm.rbUsedRangeClick(Sender: TObject);
begin
  edColStart.Enabled    := false;
  edRowStart.Enabled    := false;
  edColend.Enabled      := false;
  edRowEnd.Enabled      := false;
  edColStart.ReadOnly   := true;
  edRowStart.ReadOnly   := true;
  edColEnd.ReadOnly     := true;
  edRowEnd.ReadOnly     := true;
  cbDivByPages.Enabled  := false;
end;

procedure TgfrExcelImportForm.rbManualClick(Sender: TObject);
begin
  edColStart.Enabled    := true;
  edRowStart.Enabled    := true;
  edColEnd.Enabled      := true;
  edRowEnd.Enabled      := true;
  edColStart.ReadOnly   := false;
  edRowStart.ReadOnly   := false;
  edColEnd.ReadOnly     := false;
  edRowEnd.ReadOnly     := false;
  cbDivByPages.Enabled  := false;
end;

procedure TgfrExcelImportForm.rbPrintAreaClick(Sender: TObject);
begin
  cbDivByPages.Enabled  := true;
  edColStart.Enabled    := false;
  edRowStart.Enabled    := false;
  edColEnd.Enabled      := false;
  edRowEnd.Enabled      := false;
  edColStart.ReadOnly   := true;
  edRowStart.ReadOnly   := true;
  edColEnd.ReadOnly     := true;
  edRowEnd.ReadOnly     := true;
end;

initialization
Bmp := TBitmap.Create;
Bmp.LoadFromResourceName(hInstance, 'FR3_EXCEL_BMP');
frxWizards.Register(TfrxExcelImportWizard, Bmp, true);

finalization
frxWizards.Unregister(TfrxExcelImportWizard);
Bmp.Free;
end.
