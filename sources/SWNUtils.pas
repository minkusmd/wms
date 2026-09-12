unit SWNUtils;

interface

uses
    Classes, SWNDocumentFilters, SWNValueStorageUnit, Windows, cxCustomData,
    cxDBData, cxFilter, cxGrid, cxGridCustomView, cxGridDBTableView,
    cxGridDBBandedTableView, cxGridTableView, System.Types, System.Variants, IBC,
    cxGridCustomTableView, System.Generics.Defaults, madZip, Vcl.Graphics,
    SysUtils, System.RegularExpressions;

type
    TGoodsWebName = record
        WebNameRo: string;
        WebNameRu: string;
    end;

    TRGBArray = array[Word] of TRGBTriple;

    pRGBArray = ^TRGBArray;

    TArrayOperations = class
    public
        class function Contain<T>(const Array1: TArray<T>; const Value: T): Boolean; overload; static;
        class function Contain<T>(const Array1: TArray<T>; const Value: T; const Comparer: IComparer<T>): Boolean; overload; static;
    end;

type
    TGoodsPropertySelectionData = record
        Change_WebGoodsTypeID: Boolean;
        Value_WebGoodsTypeID: integer;
        Change_VendorID: Boolean;
        Value_VendorID: integer;
        Change_BaseParam: Boolean;
        Value_BaseParam: string;
        Change_Waranty: Boolean;
        Value_Waranty: string;
        Change_GoodsACNT: Boolean;
        Value_GoodsACNT: integer;
        Change_GoodsTypeID: Boolean;
        Value_GoodsTypeID: integer;
        Change_TipEvidenta: Boolean;
        Value_TipEvidenta: integer;
        Change_UM: Boolean;
        Value_UM: integer;
        Change_PrefixName: Boolean;
        Value_PrefixName: string;

        Change_FilterID: Boolean;
        Value_FilterID: integer;
        Value_FilterParamID: integer;

    end;

    TDelayThread = class(TThread)
    private
        fDelay: integer;
        fCallProc: TNotifyEvent;
        procedure CallUserProc;
    public
        procedure Execute; override;
        constructor Create(const Delay: integer; const CallProc: TNotifyEvent); reintroduce;
    end;

    TTimerTickEvent = procedure(const RemainingTime: cardinal) of object;

    TTimerEndTimevent = procedure of object;

    TTimerThread = class(TThread)
    private { private declarations }
        FOnTick: TTimerTickEvent;
        FInterval: cardinal;
        FTickInterval: cardinal;
        FOnEndTime: TTimerEndTimevent;
        procedure SetInterval(const Value: cardinal);
        procedure SetOnTick(const Value: TTimerTickEvent);
        procedure SetTickInterval(const Value: cardinal);
        procedure SetOnEndTime(const Value: TTimerEndTimevent);
    protected { protected declarations }
        fTotalTime: cardinal;
        procedure CallTickProc;
        procedure CallEndTimeProc;
    public { public declarations }
        constructor Create; reintroduce;
        property Interval: cardinal read FInterval write SetInterval;
        property TickInterval: cardinal read FTickInterval write SetTickInterval;
        property OnTick: TTimerTickEvent read FOnTick write SetOnTick;
        property OnEndTime: TTimerEndTimevent read FOnEndTime write SetOnEndTime;
        procedure Execute; override;
    end;

procedure AddErrorToStr(var ErrorStr: string; const ErrorText: string);

procedure ShowErrorDialog(const Title: string; const Text: string = ''; const ExpandedText: string = ''; const FooterText: string = '');

function ShowAskDialog(const Title, Text: string; const InfoText: string = ''): integer;

function ShowAskDialogVerification(const Title, Text, VerificationText, InfoText: string; var VerificationResult: Boolean): integer;

procedure ShowWarningDialog(const Title, Text: string);

procedure ShowInfoDialog(const Title, Text: string);

procedure ShowInfoDialogVerification(const Title, Text, VerificationText: string; var VerificationResult: Boolean);

function GetDocumentFrameFilterByDate(const Date: TDateTime): TFrameDocumentDateFilter;

function GetDocumentFrameFilterDateValues(const Filter: TFrameDocumentDateFilter; var DateStart, DateEnd: TDateTime): Boolean;

function IsDateRangeQuarter(const DateStart, DateEnd: TDateTime; var QuarterIndex, QuarterYear: integer; var FlagFromYearStart: Boolean): Boolean;

function IsDateRangeMonth(const DateStart, DateEnd: TDateTime; var MonthIndex, MonthYear: integer; var FlagFromQuarterStart: Boolean): Boolean;

function IsDateRangeDay(const DateStart, DateEnd: TDateTime; var FlagFromMonthStart: Boolean): Boolean;

function ValidateTextForSerial(const SerialText: string): Boolean;

function ValidateTextForPartNo(const PartNoText: string): Boolean;

procedure CompressStream(const SourceStream, TargetStream: TMemoryStream);

procedure UnCompressStream(const SourceStream, TargetStream: TMemoryStream);

function Get_LOCAL_APPDATA_Folder(out FolderPath: string): Boolean;

function ReplaceFileExt(const FileName, NewExt: string): string;

function CreatePartNoTemplate(const DocID, GoodsID: integer): string;

function CreatePartNoStartingNumber(const StartingNumber: integer): string;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;

function StringListToCommaText(const StringList: TStringList): string;

function iif(const Condition: Boolean; Value1, Value2: Variant): Variant;

function Q_PosStr(const FindString, SourceString: string; StartPos: integer): integer;

procedure SplitStr(const SubStr, AStr: string; Split: TStrings);

function FirstOfCurrentMonth: TDateTime;

function LastOfCurrentMonth: TDateTime;

function UrlDecode(const EncodedStr: string): string;

function HexToInt(HexStr: string): Int64;

function StringToPAnsiChar(stringVar: string): PAnsiChar;

function TranslitRus2Lat(const Str: string): string;

function Split(const s: string; Separator: char): TStringDynArray;

procedure ApplySearchFilter(Controller: TcxDBDataController; Fields: string; Text: string);

procedure SplitDelimitedString(AStrings: TStrings; AText, ADelimiter: string);

procedure CopyColumn(cxGrid: TcxGrid);

procedure CopyCellToClipboard(cxGrid: TcxGrid);

function GetCurrencyID(CurrencyName: string): string;

function IsStrANumber(const s: string): Boolean;

procedure ShowCopyGridContent(const AOwner: TComponent; const Grid: TcxGridTableView);

function ProcessCommonKeys(const AOwner: TComponent; const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState; AOnlyCellValue: boolean = False): Boolean;

function ProcessCommonKeysBandedTableView(const AOwner: TComponent; const Grid: TcxGridDBBandedTableView; var Key: Word; Shift: TShiftState): Boolean;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: integer): Boolean; overload;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBBandedTableView; var GoodsID: integer): Boolean; overload;

procedure ShowForeignGoodsCodesDialog(GoodsID: integer);

procedure ShowPricingRulesDialog(const AOwner: TComponent; const Connection: TIBCConnection; GoodsID: integer);

procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView; AOnlyCellValue: Boolean = false); overload;

procedure CopyGridCellTextToClipboard(const Grid: TcxGridDBBandedTableView); overload;

procedure ShowGoodsBrowser(const AOwner: TComponent; const GoodsID: integer);

function CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: integer): Boolean; overload;

function CheckGridForCustomerFields(const Grid: TcxGridDBBandedTableView; var DT, CT: integer): Boolean; overload;

procedure ShowCustomersBrowser(const AOwner: TComponent; const CustomerID: integer);

procedure ShowQuickInfoDialog(const AOwner: TComponent; const GoodsID: integer);

procedure ShowQuickInfoCustomers(const AOwner: TComponent; const DT, CT: integer);

function CheckGridForDocIDValue(const Grid: TcxGridDBTableView; var DocID: integer): Boolean; overload;

function CheckGridForDocIDValue(const Grid: TcxGridDBBandedTableView; var DocID: integer): Boolean; overload;

procedure ShowDocumentExplorer(const AOwner: TComponent; const DocID: integer);

function CheckGridForCTField(const Grid: TcxGridDBTableView; var CT: integer): Boolean; overload;

function CheckGridForCTField(const Grid: TcxGridDBBandedTableView; var CT: integer): Boolean; overload;

function GetBitValue(const aValue: cardinal; const Bit: Byte): Boolean;

function SetBitValue(const aValue: cardinal; const Bit: Byte; Value: Byte): cardinal;

function Clear_a_Bit(const aValue: cardinal; const Bit: Byte): cardinal;

function Enable_a_Bit(const aValue: cardinal; const Bit: Byte; const Flag: Boolean): cardinal;

function ToUrlSlug(Value: string): string;

function BestFit(const AInput: AnsiString): AnsiString;

function StripUnwantedText(Text: string): string;

procedure SmoothResize(Src, Dst: TBitmap);

function swnTrim(s: string): string;

function DeleteRepeatedSpaces(const s: string): string;

function KillTask(ExeFileName: string): Integer;

function ConvertWebPToPng(const WebPFileName, PngFileName: string): boolean;

function ShowMergeGoodsDialog(GoodsID: integer): boolean;

function ExtractNumbers(const S: string): string;

function DecodeEscapedUnicode(const AText: string): string;
function GenerateSlug(s: string): string;
procedure AddDelivery2Jurnal(AGoodsID: Integer);

implementation

uses
  ActiveX, ClipBrd, Controls, DataModuleDB, DateUtils, MSHTML, MainForm, SWNCommonDialogs, SWNConst, SWNMessageDialog,
  SWNSecurity, SWNSecurityFlags, ShlObj, frmBSToolsCopyGridClipboardDialog, frmCustomersDlg, frmDocumentInspectorDialog,
  frmGoods, frmGoodsForeignCodeDialog, frmGoodsQuickInfoDialog, frmMergeGoodsDialog, frmPriceTypesUnit,
  frmQuickCustomerInfoDialog,
  System.Character,
  Vcl.WebpImage,
  Winapi.ShellAPI,
  Winapi.TlHelp32;

function StringListToCommaText(const StringList: TStringList): string;
begin
    Result := StringReplace(Trim(StringList.Text), sLineBreak, ',', [rfReplaceAll]);
end;

function GetDocumentFrameFilterByDate(const Date: TDateTime): TFrameDocumentDateFilter;
var
    i: TFrameDocumentDateFilter;
    d1, d2: TDateTime;
begin
    Result := fdfNone;
    for i := TFrameDocumentDateFilter(Low(TFrameDocumentDateFilter)) to TFrameDocumentDateFilter(High(TFrameDocumentDateFilter)) do
        if (i in cDocumentAllFiltersWithFilter) then
        begin
            if (GetDocumentFrameFilterDateValues(i, d1, d2)) and (DateOf(Date) >= d1) and (DateOf(Date) <= d2) then
            begin
                Result := i;
                break;
            end;
        end;

  // daca nu s-a gasit nimic, intoarcem indexul elementului "Toate"
    if (Result = fdfNone) then
        Result := fdfAll;
end;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
    l: integer;
begin
    if ws = '' then
        Result := ''
    else
    begin
        l := WideCharToMultiByte(codePage, WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR, @ws[1], -1, nil, 0, nil, nil);
        SetLength(Result, l - 1);
        if l > 1 then
            WideCharToMultiByte(codePage, WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR, @ws[1], -1, @Result[1], l - 1, nil, nil);
    end;
end;

function CreatePartNoStartingNumber(const StartingNumber: integer): string;
begin
    Result := Format('%5.5d', [StartingNumber]);
end;

function CreatePartNoTemplate(const DocID, GoodsID: integer): string;
begin
    Result := Format('%5.5d/%d-', [DocID, GoodsID]);
end;

function ReplaceFileExt(const FileName, NewExt: string): string;
var
    k: integer;
begin
    k := Length(FileName);
    while (k > 0) and (FileName[k] <> '.') do
        Dec(k);
    if k > 0 then
        Result := Copy(FileName, 1, k - 1) + NewExt
    else
        Result := FileName + NewExt;
end;

function Get_LOCAL_APPDATA_Folder(out FolderPath: string): Boolean;
var
    Allocator: IMalloc;
    SpecialDir: PItemIdList;
    FBuf: array[0..MAX_PATH] of WideChar;
begin
    Result := False;
    if SHGetMalloc(Allocator) = NOERROR then
    begin
        if SHGetSpecialFolderLocation(0, CSIDL_LOCAL_APPDATA, SpecialDir) = S_OK then
        begin
            if SHGetPathFromIDList(SpecialDir, @FBuf[0]) then
            begin
                Allocator.Free(SpecialDir);
                FolderPath := IncludeTrailingPathDelimiter(string(FBuf));
                Result := true;
            end;
        end;
    end;
end;

procedure UnCompressStream(const SourceStream, TargetStream: TMemoryStream);
begin
    Uncompress(SourceStream.Memory, TargetStream.Memory, SourceStream.Size, TargetStream.Size);
end;

procedure CompressStream(const SourceStream, TargetStream: TMemoryStream);
var
    temp: pointer;
    len: Int64;
begin
    TargetStream.Clear;
    len := SourceStream.Size;
    GetMem(temp, len * 11 div 10 + 12);
    try
        len := Compress(SourceStream.Memory, temp, len, len * 11 div 10 + 12);
        TargetStream.WriteBuffer(temp^, len);
    finally
        FreeMem(temp);
    end;
end;

function ValidateTextForPartNo(const PartNoText: string): Boolean;
begin
    Result := true;
end;

function ValidateTextForSerial(const SerialText: string): Boolean;
begin
    if Length(SerialText) < cSerialNumber_MinLength then
        Result := False
    else
        Result := true;
end;

function GetDocumentFrameFilterDateValues(const Filter: TFrameDocumentDateFilter; var DateStart, DateEnd: TDateTime): Boolean;
begin
    Result := true;
    case Filter of
    // Astazi
        fdfToday:
            begin
                DateStart := DateOf(NOW);
                DateEnd := DateOf(IncYear(NOW, 0));
            end;
    // Cu 2 zile inainte
        fdfLast2days:
            begin
                DateEnd := DateOf(NOW);
                DateStart := DateOf(DateEnd - 1);
            end;
    // Ultimele 7 zile
        fdfLast7days:
            begin
                DateEnd := DateOf(NOW);
                DateStart := DateOf(DateEnd - 6);
            end;
    // Saptamana curenta
        fdfCurrentWeek:
            begin
                DateEnd := DateOf(NOW);
                DateStart := DateOf(NOW - DayOfTheWeek(NOW) + 1);
            end;
    // 2 saptamani
        fdfLast2weeks:
            begin
                DateEnd := DateOf(NOW);
                DateStart := DateOf(NOW - DayOfTheWeek(NOW) + 1 - 7);
            end;
    // Luna curenta
        fdfCurrentMonth:
            begin
                DateEnd := DateOf(NOW);
                DateStart := DateOf(DateEnd - DayOfTheMonth(DateEnd) + 1);
            end;
    // Trimestrul I
        fdfIQuarter:
            begin
                DateStart := EncodeDate(YearOf(NOW), 1, 1);
                DateEnd := EncodeDate(YearOf(NOW), 3, 31);
            end;
    // Trimestrul II
        fdfIIQuarter:
            begin
                DateStart := EncodeDate(YearOf(NOW), 4, 1);
                DateEnd := EncodeDate(YearOf(NOW), 6, 30);
            end;
    // Trimestrul III
        fdfIIIQuarter:
            begin
                DateStart := EncodeDate(YearOf(NOW), 7, 1);
                DateEnd := EncodeDate(YearOf(NOW), 9, 30);
            end;
    // Trimestrul IV
        fdfIVQuarter:
            begin
                DateStart := EncodeDate(YearOf(NOW), 10, 1);
                DateEnd := EncodeDate(YearOf(NOW), 12, 31);
            end;
    // Semestrul I
        fdfFirstHalfYear:
            begin
                DateStart := EncodeDate(YearOf(NOW), 1, 1);
                DateEnd := EncodeDate(YearOf(NOW), 6, 30);
            end;
    // Semestrul II
        fdfSecondHalfYear:
            begin
                DateStart := EncodeDate(YearOf(NOW), 7, 1);
                DateEnd := EncodeDate(YearOf(NOW), 12, 31);
            end;
    // An
        fdfCurrentYear:
            begin
                DateStart := EncodeDate(YearOf(NOW), 1, 1);
                DateEnd := EncodeDate(YearOf(NOW), 12, 31);
            end;
    // Toate
        fdfAll:
            begin
                DateStart := 0;
                DateEnd := 0;
                Result := False;
            end;
    end;
end;

function IsDateRangeQuarter(const DateStart, DateEnd: TDateTime; var QuarterIndex, QuarterYear: integer; var FlagFromYearStart: Boolean): Boolean;
var
    y1, y2, m1, m2, d1, d2: Word;
begin
    Result := False;
    FlagFromYearStart := False;
    DecodeDate(DateStart, y1, m1, d1);
    DecodeDate(DateEnd, y2, m2, d2);
    if (y1 = y2) and (d1 = 1) and (DayOfTheMonth(DateEnd) = DaysInMonth(DateEnd)) then
    begin
    // verificam fiecare trimestru in parte
    // I
        if (m1 = 1) and (m2 = 3) then // 01.01 - 31.03
        begin
            Result := true;
            QuarterIndex := 1;
        end
        else
      // II
            if (m1 = 4) and (m2 = 6) then // 01.04 - 30.06
        begin
            Result := true;
            QuarterIndex := 2;
        end
        else
        // III
            if (m1 = 7) and (m2 = 9) then // 01.04 - 30.06
        begin
            Result := true;
            QuarterIndex := 3;
        end
        else
          // IV
            if (m1 = 10) and (m2 = 12) then // 01.04 - 30.06
        begin
            Result := true;
            QuarterIndex := 4;
        end;

        if not Result then
        begin
      // De la inceputul anului
            if (m1 = 1) and (m2 in [3, 6, 9, 12]) then
            begin
                QuarterIndex := m2 div 3;
                FlagFromYearStart := true;
                Result := true;
            end;
        end;
    end;
    if Result then
        QuarterYear := y1;
end;

function IsDateRangeMonth(const DateStart, DateEnd: TDateTime; var MonthIndex, MonthYear: integer; var FlagFromQuarterStart: Boolean): Boolean;
var
    y1, y2, m1, m2, d1, d2: Word;
    n: integer;
begin
    Result := False;
    FlagFromQuarterStart := False;
    DecodeDate(DateStart, y1, m1, d1);
    DecodeDate(DateEnd, y2, m2, d2);
    if (y1 = y2) and (d1 = 1) then
    begin
        if (m1 = m2) and (d2 = DaysInMonth(DateStart)) then
        begin
            Result := true;
        end
        else
        begin
      // De la inceputul trimestrului
            n := m2 div 3;
            if (m2 mod 3) > 0 then
                Inc(n);
            n := (n - 1) * 3 + 1;
            if (m1 = n) then
            begin
                Result := true;
                FlagFromQuarterStart := true;
            end;
        end;
    end;

    if Result then
    begin
        MonthIndex := m2;
        MonthYear := y2;
    end;
end;

function IsDateRangeDay(const DateStart, DateEnd: TDateTime; var FlagFromMonthStart: Boolean): Boolean;
var
    y1, y2, m1, m2, d1, d2: Word;
begin
    Result := False;
    FlagFromMonthStart := False;

    if DateOf(DateStart) = DateOf(DateEnd) then
        Result := true
    else
    begin
        DecodeDate(DateStart, y1, m1, d1);
        DecodeDate(DateEnd, y2, m2, d2);
    // De la inceputul lunii
        if (y1 = y2) and (m1 = m2) and (d1 = 1) and (d2 > d1) then
        begin
            Result := true;
            FlagFromMonthStart := true;
        end;
    end;
end;

procedure AddErrorToStr(var ErrorStr: string; const ErrorText: string);
begin
    if ErrorStr <> '' then
        ErrorStr := ErrorStr + sLineBreak;

    ErrorStr := ErrorStr + ErrorText;
end;

function GetApplicationVersion: DWORD;
begin
    Result := 0;
end;

function ShowAskDialogVerification(const Title, Text, VerificationText, InfoText: string; var VerificationResult: Boolean): integer;
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Result := Dialog.ShowAskDialogWithVerification(Title, Text, VerificationText, InfoText, VerificationResult);
        VerificationResult := Dialog.VerificationFlag;
    finally
        Dialog.Free;
    end;
end;

function ShowAskDialog(const Title, Text, InfoText: string): integer;
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Result := Dialog.ShowAskDialog(Title, Text, InfoText);
    finally
        Dialog.Free;
    end;
end;

procedure ShowInfoDialog(const Title, Text: string);
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Dialog.ShowInfoDialog(Title, Text);
    finally
        Dialog.Free;
    end;
end;

procedure ShowInfoDialogVerification(const Title, Text, VerificationText: string; var VerificationResult: Boolean);
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Dialog.ShowInfoDialog(Title, Text, VerificationText);
        VerificationResult := Dialog.VerificationFlag;
    finally
        Dialog.Free;
    end;
end;

procedure ShowWarningDialog(const Title, Text: string);
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Dialog.ShowWarningDialog(Title, Text);
    finally
        Dialog.Free;
    end;
end;

procedure ShowErrorDialog(const Title, Text, ExpandedText, FooterText: string);
var
    Dialog: TSWNMessageDialog;
begin
    Dialog := TSWNMessageDialog.Create;
    try
        Dialog.ShowErrorDlg(Title, Text, ExpandedText, FooterText);
    finally
        Dialog.Free;
    end;
end;

function iif(const Condition: Boolean; Value1, Value2: Variant): Variant;
begin
    if Condition then
        Result := Value1
    else
        Result := Value2;
end;

{ TDelayThread }

procedure TDelayThread.CallUserProc;
begin
    if Assigned(fCallProc) then
        fCallProc(Self);
end;

constructor TDelayThread.Create(const Delay: integer; const CallProc: TNotifyEvent);
begin
    inherited Create(true);
    fDelay := Delay;
    fCallProc := CallProc;
    FreeOnTerminate := true;
end;

procedure TDelayThread.Execute;
var
    n: integer;
begin
    n := 0;
    while (not Terminated) and (n <= fDelay) do
    begin
        Sleep(50);
        Inc(n, 50);
    end;
    if (not Terminated) then
        Synchronize(CallUserProc);
end;

{ TTimerThread }

procedure TTimerThread.CallEndTimeProc;
begin
    if Assigned(FOnEndTime) then
        FOnEndTime;
end;

procedure TTimerThread.CallTickProc;
begin
    if Assigned(FOnTick) then
        FOnTick(fTotalTime);
end;

constructor TTimerThread.Create;
begin
    inherited Create(true);
    FreeOnTerminate := true;

    fTotalTime := 0;
    FInterval := 0;
    FTickInterval := 0;
    FOnTick := nil;
    FOnEndTime := nil;
end;

procedure TTimerThread.Execute;
var
    LeftTicks: cardinal;
begin
    if (FInterval > 0) and (FTickInterval > 0) and (FTickInterval < FInterval) then
    begin
        fTotalTime := FInterval;
        while (not Terminated) and (fTotalTime > 0) do
        begin
            if (fTotalTime - FTickInterval) > 0 then
                LeftTicks := FTickInterval
            else
                LeftTicks := fTotalTime;

            Sleep(LeftTicks);
            Dec(fTotalTime, LeftTicks);
            Synchronize(CallTickProc);
        end;
        if (not Terminated) then
            Synchronize(CallEndTimeProc);
    end;
end;

procedure TTimerThread.SetInterval(const Value: cardinal);
begin
    FInterval := Value;
end;

procedure TTimerThread.SetOnEndTime(const Value: TTimerEndTimevent);
begin
    FOnEndTime := Value;
end;

procedure TTimerThread.SetOnTick(const Value: TTimerTickEvent);
begin
    FOnTick := Value;
end;

procedure TTimerThread.SetTickInterval(const Value: cardinal);
begin
    FTickInterval := Value;
end;

procedure SplitStr(const SubStr, AStr: string; Split: TStrings);
var
    CurrentPosition: integer;
    PositionEndSubStr: integer;
begin
    CurrentPosition := 1;
    Split.Clear;
    while CurrentPosition <= Length(AStr) do
    begin
        PositionEndSubStr := Q_PosStr(SubStr, AStr, CurrentPosition);
        case PositionEndSubStr of
            0:
                begin
                    Split.Add(Copy(AStr, CurrentPosition, Length(AStr) - CurrentPosition + 1));
                    CurrentPosition := Length(AStr) + 1;
                end;
            1:
                begin
                    CurrentPosition := Length(SubStr) + 1;
                    Continue;
                end;
        else
            Split.Add(Copy(AStr, CurrentPosition, PositionEndSubStr - CurrentPosition));
            CurrentPosition := PositionEndSubStr + Length(SubStr);
        end;
    end;
end;

function Q_PosStr(const FindString, SourceString: string; StartPos: integer): integer;
asm
        PUSH    ESI
        PUSH    EDI
        PUSH    EBX
        PUSH    EDX
        TEST    EAX, EAX
        JE      @@qt
        TEST    EDX, EDX
        JE      @@qt0
        MOV     ESI, EAX
        MOV     EDI, EDX
        MOV     EAX, [EAX - 4]
        MOV     EDX, [EDX - 4]
        DEC     EAX
        SUB     EDX, EAX
        DEC     ECX
        SUB     EDX, ECX
        JNG     @@qt0
        XCHG    EAX, EDX
        ADD     EDI, ECX
        MOV     ECX, EAX
        JMP     @@nx

@@fr:   INC     EDI
        DEC     ECX
        JE      @@qt0

@@nx:   MOV     EBX, EDX
        MOV     AL, BYTE PTR[ESI]

@@lp1:  CMP     AL, BYTE PTR[EDI]
        JE      @@uu
        INC     EDI
        DEC     ECX
        JE      @@qt0
        CMP     AL, BYTE PTR[EDI]
        JE      @@uu
        INC     EDI
        DEC     ECX
        JE      @@qt0
        CMP     AL, BYTE PTR[EDI]
        JE      @@uu
        INC     EDI
        DEC     ECX
        JE      @@qt0
        CMP     AL, BYTE PTR[EDI]
        JE      @@uu
        INC     EDI
        DEC     ECX
        JNE     @@lp1

@@qt0:  XOR     EAX, EAX

@@qt:   POP     ECX
        POP     EBX
        POP     EDI
        POP     ESI
        RET

@@uu:   TEST    EDX, EDX
        JE      @@fd

@@lp2:  MOV     AL, BYTE PTR[ESI + EBX]
        CMP     AL, BYTE PTR[EDI + EBX]
        JNE     @@fr
        DEC     EBX
        JE      @@fd
        MOV     AL, BYTE PTR[ESI + EBX]
        CMP     AL, BYTE PTR[EDI + EBX]
        JNE     @@fr
        DEC     EBX
        JE      @@fd
        MOV     AL, BYTE PTR[ESI + EBX]
        CMP     AL, BYTE PTR[EDI + EBX]
        JNE     @@fr
        DEC     EBX
        JE      @@fd
        MOV     AL, BYTE PTR[ESI + EBX]
        CMP     AL, BYTE PTR[EDI + EBX]
        JNE     @@fr
        DEC     EBX
        JNE     @@lp2

@@fd:   LEA     EAX, [EDI + 1]
        SUB     EAX, [ESP]
        POP     ECX
        POP     EBX
        POP     EDI
        POP     ESI
end;

function FirstOfCurrentMonth: TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(Date, Year, Month, Day);
    FirstOfCurrentMonth := EncodeDate(Year, Month, 1);
end;

function LastOfCurrentMonth: TDateTime;
var
    Year, Month, Day: Word;
    DerivedFirstNextMonth: TDateTime;
begin
    DecodeDate(Date, Year, Month, Day);
    if Month = 12 then
        LastOfCurrentMonth := EncodeDate(Year, 12, 31)
    else
    begin
        DerivedFirstNextMonth := EncodeDate(Year, Month + 1, 1);
        LastOfCurrentMonth := DerivedFirstNextMonth - 1;
    end;
end;

function UrlDecode(const EncodedStr: string): string;
var
    i: integer;
begin
    Result := '';
    if Length(EncodedStr) > 0 then
    begin
        i := 1;
        while i <= Length(EncodedStr) do
        begin
            if EncodedStr[i] = '%' then
            begin
                Result := Result + Chr(HexToInt(EncodedStr[i + 1] + EncodedStr[i + 2]));
                i := Succ(Succ(i));
            end
            else if EncodedStr[i] = '+' then
                Result := Result + ' '
            else
                Result := Result + EncodedStr[i];

            i := Succ(i);
        end;
    end;
end;

function HexToInt(HexStr: string): Int64;
var
    RetVar: Int64;
    i: Byte;
begin
    HexStr := UpperCase(HexStr);
    if HexStr[Length(HexStr)] = 'H' then
        Delete(HexStr, Length(HexStr), 1);
    RetVar := 0;

    for i := 1 to Length(HexStr) do
    begin
        RetVar := RetVar shl 4;

        if SysUtils.CharInSet(HexStr[i], ['0'..'9']) then
            RetVar := RetVar + (Byte(HexStr[i]) - 48)
        else if CharInSet(HexStr[i], ['A'..'F']) then
            RetVar := RetVar + (Byte(HexStr[i]) - 55)
        else
        begin
            RetVar := 0;
            break;
        end;
    end;

    Result := RetVar;
end;

function StringToPAnsiChar(stringVar: string): PAnsiChar;
var
    AnsString: AnsiString;
    InternalError: Boolean;
begin
    InternalError := False;
    Result := '';
    try
        if stringVar <> '' then
        begin
            AnsString := AnsiString(stringVar);
            Result := PAnsiChar(PAnsiString(AnsString));
        end;
    except
        InternalError := true;
    end;
    if InternalError or (string(Result) <> stringVar) then
    begin
        raise Exception.Create('Conversion from string to PAnsiChar failed!');
    end;
end;

function TranslitRus2Lat(const Str: string): string;
const
    RArrayL = 'абвгдеёжзийклмнопрстуфхцчшщьыъэюя';
    RArrayU = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
    colChar = 33;
    arr: array[1..2, 1..colChar] of string = (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya'), ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya'));
var
    i: integer;
    LenS: integer;
    p: integer;
    d: Byte;
begin
    Result := '';
    LenS := Length(Str);
    for i := 1 to LenS do
    begin
        d := 1;
        p := pos(Str[i], RArrayL);
        if p = 0 then
        begin
            p := pos(Str[i], RArrayU);
            d := 2
        end;
        if p <> 0 then
            Result := Result + arr[d, p]
        else
            Result := Result + Str[i]; // daca nu e litera rusa, o luam pe cea originala
    end;
end;

function Split(const s: string; Separator: char): TStringDynArray;
var
    i, ItemIndex: integer;
    len: integer;
    SeparatorCount: integer;
    Start: integer;
begin
    len := Length(s);
    if len = 0 then
    begin
        Result := nil;
        exit;
    end;

    SeparatorCount := 0;
    for i := 1 to len do
    begin
        if s[i] = Separator then
        begin
            Inc(SeparatorCount);
        end;
    end;

    SetLength(Result, SeparatorCount + 1);
    ItemIndex := 0;
    Start := 1;
    for i := 1 to len do
    begin
        if s[i] = Separator then
        begin
            Result[ItemIndex] := Copy(s, Start, i - Start);
            Inc(ItemIndex);
            Start := i + 1;
        end;
    end;
    Result[ItemIndex] := Copy(s, Start, len - Start + 1);
end;

// Setare filtru pentru campurile lookup, cu separare pe cuvinte si campuri
procedure ApplySearchFilter(Controller: TcxDBDataController; Fields: string; Text: string);
var
    i, j: integer;
    ItemLink: TObject;
    Filter: TcxDataFilterCriteria;
    FL: TcxFilterCriteriaItemList;
    FieldList, TextWords: TStrings;
begin
    TextWords := TStringList.Create;
    FieldList := TStringList.Create;
    try
        Filter := Controller.Filter;
        Filter.BeginUpdate;
        try
            Filter.Active := False;
            Filter.Clear;
            Filter.Options := Filter.Options + [fcoCaseInsensitive];
            Filter.Root.BoolOperatorKind := fboOr;
            SplitDelimitedString(FieldList, Fields, ';');
            SplitDelimitedString(TextWords, Text, ' ');
            for i := 0 to FieldList.Count - 1 do
                if FieldList[i] <> '' then
                begin
                    FL := Filter.Root.AddItemList(fboAnd);
                    ItemLink := Controller.GetItemByFieldName(FieldList[i]);
                    if Assigned(ItemLink) then
                        for j := 0 to TextWords.Count - 1 do
                            if TextWords[j] <> '' then
                                FL.AddItem(ItemLink, foLike, '%' + TextWords[j] + '%', TextWords[j]);
                end;
            Filter.Active := true;
        finally
            Filter.EndUpdate;
        end;
    finally
        TextWords.Free;
        FieldList.Free;
    end;
end;

// Separare sir pe cuvinte
procedure SplitDelimitedString(AStrings: TStrings; AText, ADelimiter: string);
var
    p, n: integer;
    Text: PChar;
begin
    Text := PChar(AText);
    AStrings.Clear;
    n := Length(ADelimiter);
    while Assigned(Text) do
    begin
        p := pos(ADelimiter, Text) - 1;
        if p < 0 then
            break;
        AStrings.Add(Copy(Text, 1, p));
        Inc(Text, p + n);
    end;
    if Assigned(Text) and (Length(Text) > 0) then
        AStrings.Add(Text);
end;

function GetActiveView(cxGrid: TcxGrid): TcxGridDBTableView;
begin
    Result := TcxGridDBTableView(cxGrid.FocusedView);
end;

procedure CopyCellToClipboard(cxGrid: TcxGrid);
begin
    with TcxGridDBTableView(cxGrid.FocusedView), TcxGridDBTableView(cxGrid.FocusedView).Controller do
        if OptionsSelection.CellSelect then
            Clipboard.AsText := FocusedRow.Values[FocusedColumn.Index];
end;

procedure CopyColumn(cxGrid: TcxGrid);
var
    LView: TcxGridDBTableView;
    LSelectColumn: TcxGridColumn;
    i, LRecordCount: integer;
    LValues: string;
    LMultiselect: Boolean;
begin

    LView := GetActiveView(cxGrid);
    LMultiselect := False;

    if Assigned(LView) then
    begin

        if LView.OptionsSelection.CellSelect then
        begin

            LView.BeginUpdate;
            try

                Clipboard.Clear;
                LMultiselect := LView.OptionsSelection.MultiSelect;
                LView.OptionsSelection.MultiSelect := true;

                LSelectColumn := LView.Controller.FocusedColumn;
                if Assigned(LSelectColumn) then
                begin

                    LView.Controller.SelectCells(LSelectColumn, LSelectColumn, 0, Pred(LView.DataController.RecordCount));

                    LValues := LSelectColumn.Caption + sLineBreak;
                    LRecordCount := LView.Controller.SelectedRecordCount;
                    for i := 0 to Pred(LView.Controller.SelectedRecordCount) do
                    begin

                        LValues := LValues + VarToStrDef(LView.DataController.Values[i, LSelectColumn.Index], EmptyStr);

                        if LRecordCount > 1 then
                            LValues := LValues + sLineBreak;

                        Dec(LRecordCount);

                    end;

                    Clipboard.AsText := LValues;

                end;

            finally
                LView.OptionsSelection.MultiSelect := LMultiselect;
                LView.Controller.ClearSelection;
                LView.EndUpdate;
            end;

        end;

    end;

end;

function GetCurrencyID(CurrencyName: string): string;
begin
    Result := '-1';

    if UpperCase(CurrencyName) = 'EUR' then
    begin
        Result := '976';
    end
    else if UpperCase(CurrencyName) = 'USD' then
    begin
        Result := '840';
    end
    else if UpperCase(CurrencyName) = 'MDL' then
    begin
        Result := '498';
    end;
end;

function IsStrANumber(const s: string): Boolean;
var
    p: PChar;
begin
    p := PChar(s);
    Result := False;
    while p^ <> #0 do
    begin
        if not (CharInSet(p^, ['0'..'9'])) then
            exit;
        Inc(p);
    end;
    Result := true;
end;

// TSWNBaseFrame
procedure ShowCopyGridContent(const AOwner: TComponent; const Grid: TcxGridTableView);
var
    Dialog: TfrmBSToolsCopyGridClipboardDlg;
begin
    Dialog := TfrmBSToolsCopyGridClipboardDlg.Create(AOwner);
    try
        Dialog.Grid := Grid;
        Dialog.ShowModal;
    finally
        Dialog.Free;
    end;
end;

function ProcessCommonKeys(const AOwner: TComponent; const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState; AOnlyCellValue: boolean = False): Boolean;
var
    GoodsID: integer;
    DT, CT, DocID: integer;
    QtyDisplayFormat: string;
    qtyDigitsMode: integer;
    QtyReplaceMask: string;
begin
    Result := False;

    qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
    QtyDisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
    QtyReplaceMask := Format(cQTY_DigitsMask2[qtyDigitsMode], [FormatSettings.DecimalSeparator]);

  // Ctrl+Z
    if ((Key = 122) or (Key = 90)) and (Shift = [ssCtrl]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowForeignGoodsCodesDialog(GoodsID);

            Key := 0;
            Shift := [];
            Result := true;
        end;

    end;

  // Alt+P - Politica de preturi
    if (Key = 112) and (Shift = [ssAlt]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Politica_de_preturi) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowPricingRulesDialog(AOwner, TIBCQuery(Grid.DataController.DataSet).Connection, GoodsID);
            Key := 0;
            Shift := [];
            Result := true;
        end;
    end;

  // Ctrl+Alt+C - Copy grid to buffer
    if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
    begin
        ShowCopyGridContent(AOwner, Grid);
    end;

  // Ctrl+C
    if (Key = 67) and (Shift = [ssCtrl]) then
    begin
    // copy cell content in clipboard
//    CopyGridCellTextToClipboard(Grid);
        CopyGridCellTextToClipboard(Grid, AOnlyCellValue);
        Key := 0;
        Shift := [];
        Result := true;
    end;

  // Ctrl+Shift+T
    if (Key = 84) and (Shift = [ssCtrl, ssShift]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowGoodsBrowser(AOwner, GoodsID);
        end;
    end;

  // Ctrl+Shift+K
    if (Key = 75) and (Shift = [ssCtrl, ssShift]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты) then
        begin
            if CheckGridForCustomerFields(Grid, DT, CT) then
            begin
                if CT <> -1 then
                    ShowCustomersBrowser(AOwner, CT)
                else
                    ShowCustomersBrowser(AOwner, DT);
            end;
        end;
    end;

  // F1
    if (Key = 112) and (Shift = []) then
    begin
        if CheckGridForGoodsIDValue(Grid, GoodsID) then
            ShowQuickInfoDialog(AOwner, GoodsID)
        else if CheckGridForCustomerFields(Grid, DT, CT) then
            ShowQuickInfoCustomers(AOwner, DT, CT);
    end;

  // F12 - Document Inspector
    if (Key = 123) and (Shift = []) then
    begin
        if CheckGridForDocIDValue(Grid, DocID) then
            ShowDocumentExplorer(AOwner, DocID);
    end;

  // TEST ONLY
  // Ctrl+Shift+Q
    if (Key = 81) and (Shift = [ssCtrl, ssShift]) then
    begin
        ShowInfoDialog('QTY Display Format', Format('Format: %s' + sLineBreak + 'Number of digits: %d', [QtyDisplayFormat, AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, -1)]));
    end;

  // Ctrl+D
    if (((Key = Ord('d')) or (Key = Ord('D'))) and (Shift = [ssCtrl])) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента) then
        begin
            if CheckGridForCTField(Grid, CT) then
                TSWNCommonDialogs.CustomerDebts(CT);
        end;
    end;

end;

function ProcessCommonKeysBandedTableView(const AOwner: TComponent; const Grid: TcxGridDBBandedTableView; var Key: Word; Shift: TShiftState): Boolean;
var
    GoodsID: integer;
    DT, CT, DocID: integer;
    QtyDisplayFormat: string;
    qtyDigitsMode: integer;
    QtyReplaceMask: string;
begin
    Result := False;

    qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
    QtyDisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
    QtyReplaceMask := Format(cQTY_DigitsMask2[qtyDigitsMode], [FormatSettings.DecimalSeparator]);

  // Ctrl+Z
    if ((Key = 122) or (Key = 90)) and (Shift = [ssCtrl]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowForeignGoodsCodesDialog(GoodsID);

            Key := 0;
            Shift := [];
            Result := true;
        end;
    end;

  // Alt+P - Politica de preturi
    if (Key = 112) and (Shift = [ssAlt]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Politica_de_preturi) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowPricingRulesDialog(AOwner, TIBCQuery(Grid.DataController.DataSet).Connection, GoodsID);
            Key := 0;
            Shift := [];
            Result := true;
        end;
    end;
  //
  // Ctrl+Alt+C - Copy grid to buffer
    if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
    begin
        ShowCopyGridContent(AOwner, Grid);
    end
    else

    // Ctrl+C
        if (Key = 67) and (Shift = [ssCtrl]) then
    begin
      // copy cell content in clipboard
        CopyGridCellTextToClipboard(Grid);
        Key := 0;
        Shift := [];
        Result := true;
    end
    else
      // Ctrl+Shift+T
        if (Key = 84) and (Shift = [ssCtrl, ssShift]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары) then
        begin
            if CheckGridForGoodsIDValue(Grid, GoodsID) then
                ShowGoodsBrowser(AOwner, GoodsID);
        end;
    end
    else
        // Ctrl+Shift+K
        if (Key = 75) and (Shift = [ssCtrl, ssShift]) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты) then
        begin
            if CheckGridForCustomerFields(Grid, DT, CT) then
            begin
                if CT <> -1 then
                    ShowCustomersBrowser(AOwner, CT)
                else
                    ShowCustomersBrowser(AOwner, DT);
            end;
        end;
    end
    else
          // F1
        if (Key = 112) and (Shift = []) then
    begin
        if CheckGridForGoodsIDValue(Grid, GoodsID) then
            ShowQuickInfoDialog(AOwner, GoodsID)
        else if CheckGridForCustomerFields(Grid, DT, CT) then
            ShowQuickInfoCustomers(AOwner, DT, CT);
    end
    else
            // F12 - Document Inspector
        if (Key = 123) and (Shift = []) then
    begin
        if CheckGridForDocIDValue(Grid, DocID) then
            ShowDocumentExplorer(AOwner, DocID);
    end
    else
              // TEST ONLY
              // Ctrl+Shift+Q
        if (Key = 81) and (Shift = [ssCtrl, ssShift]) then
    begin
        ShowInfoDialog('QTY Display Format', Format('Format: %s' + sLineBreak + 'Number of digits: %d', [QtyDisplayFormat, AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, -1)]));
    end
    else
                // Ctrl+D Datoriile contragentului
        if (((Key = Ord('d')) or (Key = Ord('D'))) and (Shift = [ssCtrl])) then
    begin
        if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента) then
        begin
            if CheckGridForCTField(Grid, CT) then
                TSWNCommonDialogs.CustomerDebts(CT);
        end;
    end
    else if (Key = Ord('q')) or (Key = Ord('Q')) then
    begin

    end;

end;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: integer): Boolean;
var
    i: integer;
    col: TcxGridDBColumn;
begin
    GoodsID := -1;
    Result := False;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        col := Grid.Columns[i];
        if (col.DataBinding.FieldName.ToUpper = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index]) then
        begin
            GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
            Result := true;
            break;
        end;
    end;
end;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBBandedTableView; var GoodsID: integer): Boolean;
var
    i: integer;
    col: TcxGridDBBandedColumn;
begin
    GoodsID := -1;
    Result := False;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        col := Grid.Columns[i];
        if (col.DataBinding.FieldName = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index]) then
        begin
            GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
            Result := true;
            break;
        end;
    end;
end;

procedure ShowForeignGoodsCodesDialog(GoodsID: integer);
var
    Dialog: TfrmGoodsForeignCodeDlg;
begin
    Dialog := TfrmGoodsForeignCodeDlg.Create(nil);
    try
        Dialog.GoodsID := GoodsID;
        Dialog.ShowModal;

    finally
        Dialog.Free;
    end;
end;

procedure ShowPricingRulesDialog(const AOwner: TComponent; const Connection: TIBCConnection; GoodsID: integer);
var
    Dialog: TfrmPriceTypesDlg;
begin
    Dialog := TfrmPriceTypesDlg.Create(AOwner, Connection);
    try
        Dialog.GoodsID := GoodsID;
        Dialog.ShowModal;
    finally
        Dialog.Free;
    end;
end;

procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView; AOnlyCellValue: Boolean = false);
var
    RecordIndex: integer;
    i, j: integer;
    MS: TStringList;
    s: string;
    AColumn: TcxGridDBColumn;
    GoodsID: integer;
    GoodsQTY: Double;
  // UM_NAME: string;
begin
    MS := TStringList.Create;
    try
        for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
        begin
      // multiple cells selected
            GoodsID := -1;

            RecordIndex := Grid.Controller.SelectedRecords[i].RecordIndex;

            if (TcxGridDBColumn(Grid.Controller.FocusedColumn).DataBinding.FieldName = 'GOODS_NAME') then
            begin
                for j := 0 to Grid.ColumnCount - 1 do
                begin
                    AColumn := TcxGridDBTableView(Grid).Columns[j];
                    if AColumn.DataBinding.Field.FieldName = 'GOODSID' then
                    begin
                        GoodsID := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).toInteger;
                    end;
                    if AColumn.DataBinding.Field.FieldName = 'QTY' then
                    begin
                        GoodsQTY := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).ToDouble;
                        break;
                    end;
                end;
            end;

            if GoodsID > -1 then
            begin
                s := GoodsQTY.ToString + ' #' + GoodsID.ToString + '- ' + Copy(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index), 1, 48);
            end
            else
                s := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
            if s <> '' then
                MS.Add(s); // append to collection formated row
        end;

        Clipboard.AsText := Trim(MS.Text);
    finally
        MS.Free;
    end;
end;

procedure CopyGridCellTextToClipboard(const Grid: TcxGridDBBandedTableView);
var
    RecordIndex: integer;
    i, j: integer;
    MS: TStringList;
    s: string;
    AColumn: TcxGridDBColumn;
    GoodsID: integer;
    GoodsQTY: Double;
  // UM_NAME: string;
begin
    MS := TStringList.Create;
    try
        for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
        begin
      // multiple cells selected
            GoodsID := -1;

            RecordIndex := Grid.Controller.SelectedRecords[i].RecordIndex;

            if (TcxGridDBColumn(Grid.Controller.FocusedColumn).DataBinding.FieldName = 'GOODS_NAME') then
            begin
                for j := 0 to Grid.ColumnCount - 1 do
                begin
                    AColumn := TcxGridDBTableView(Grid).Columns[j];
                    if AColumn.DataBinding.Field.FieldName = 'GOODSID' then
                    begin
                        GoodsID := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).toInteger;
                    end;
                    if AColumn.DataBinding.Field.FieldName = 'QTY' then
                    begin
                        GoodsQTY := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).ToDouble;
                        break;
                    end;
                end;
            end;

            if GoodsID > -1 then
            begin
                s := GoodsQTY.ToString + ' #' + GoodsID.ToString + '- ' + Copy(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index), 1, 48);
            end
            else
                s := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
            if s <> '' then
                MS.Add(s); // append to collection formated row
        end;

        Clipboard.AsText := Trim(MS.Text);
    finally
        MS.Free;
    end;
end;

procedure ShowGoodsBrowser(const AOwner: TComponent; const GoodsID: integer);
var
    Dialog: TfrmGoodsBrowser;
begin
    Dialog := TfrmGoodsBrowser.Create(AOwner);
    try
        Dialog.GoodsID := GoodsID;
        Dialog.ShowModal;
    finally
        Dialog.Free;
    end;
end;

function CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: Integer): Boolean;
var
    i: Integer;
    col: TcxGridDBColumn;
    currentValue: Variant;
    focusedRecordIndex: Integer;
begin
    DT := -1;
    CT := -1;
    focusedRecordIndex := Grid.DataController.FocusedRecordIndex;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        if Grid.Columns[i] is TcxGridDBColumn then
        begin
            col := TcxGridDBColumn(Grid.Columns[i]);
            currentValue := Grid.DataController.Values[focusedRecordIndex, col.Index];

            if VarIsNumeric(currentValue) then
            begin
                if col.DataBinding.FieldName = 'DT' then
                    DT := currentValue
                else if (col.DataBinding.FieldName = 'CT') or (col.DataBinding.FieldName = 'CUSTOMERID') then
                    CT := currentValue;
            end;
        end;
    end;

    Result := (DT <> -1) or (CT <> -1);
end;
{
old version
function CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: integer): Boolean;
var
  i: integer;
  col: TcxGridDBColumn;
begin
  DT := -1;
  CT := -1;

  for i := 0 to Grid.ColumnCount - 1 do
    if Grid.Columns[i] is TcxGridDBColumn then
    begin
      col := Grid.Columns[i];
      if col.DataBinding.FieldName = 'DT' then
      begin
        if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
          DT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
      end
      else if (col.DataBinding.FieldName = 'CT') or (col.DataBinding.FieldName = 'CUSTOMERID') then
      begin
        if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
          CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
      end;
    end;
  Result := (DT <> -1) or (CT <> -1)
end;
}
{//************ Optimize Code ***************
To optimize the provided Delphi code for the function `CheckGridForCustomerFields`, we can make several improvements focused on reducing redundancy, increasing readability, and enhancing performance. The main areas we'll focus on are minimizing repetitive calls and making use of local variables efficiently.

Here's an optimized version of your function:

```delphi
function CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: Integer): Boolean;
var
  i: Integer;
  col: TcxGridDBColumn;
  currentValue: Variant;
  focusedRecordIndex: Integer;
begin
  DT := -1;
  CT := -1;
  focusedRecordIndex := Grid.DataController.FocusedRecordIndex;

  for i := 0 to Grid.ColumnCount - 1 do
  begin
    if Grid.Columns[i] is TcxGridDBColumn then
    begin
      col := TcxGridDBColumn(Grid.Columns[i]);
      currentValue := Grid.DataController.Values[focusedRecordIndex, col.Index];

      if VarIsNumeric(currentValue) then
      begin
        if col.DataBinding.FieldName = 'DT' then
          DT := currentValue
        else if (col.DataBinding.FieldName = 'CT') or (col.DataBinding.FieldName = 'CUSTOMERID') then
          CT := currentValue;
      end;
    end;
  end;

  Result := (DT <> -1) or (CT <> -1);
end;
```

### Key Improvements:
1. **Minimized Redundant Lookups**:
   - Store `Grid.DataController.FocusedRecordIndex` in a local variable `focusedRecordIndex`. This avoids multiple calls to the property in the loop.

2. **Cached `currentValue`**:
   - Instead of calling `Grid.DataController.Values[focusedRecordIndex, col.Index]` multiple times, we fetch it once per iteration, which can improve performance especially if the number of columns is large.

3. **Increased Readability**:
   - Used clearer conditional checks to assign values to `DT` and `CT`, making it easier to understand the logic flow.

4. **Direct Type Casting**:
   - Instead of referencing `Grid.Columns[i]` each time, we cast it once and reuse it.

This optimized approach increases efficiency while retaining clarity, making the function both faster and easier to maintain.
}

function CheckGridForCustomerFields(const Grid: TcxGridDBBandedTableView; var DT, CT: integer): Boolean;
var
    i: integer;
    col: TcxGridDBBandedColumn;
begin
    DT := -1;
    CT := -1;

    for i := 0 to Grid.ColumnCount - 1 do
        if Grid.Columns[i] is TcxGridDBBandedColumn then
        begin
            col := Grid.Columns[i];
            if col.DataBinding.FieldName = 'DT' then
            begin
                if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
                    DT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
            end
            else if col.DataBinding.FieldName = 'CT' then
            begin
                if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
                    CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
            end;
        end;
    Result := (DT <> -1) or (CT <> -1)
end;

procedure ShowCustomersBrowser(const AOwner: TComponent; const CustomerID: integer);
var
    Dialog: TfrmCustomersDlg;
begin
    Dialog := TfrmCustomersDlg.Create(AOwner);
    try
        Dialog.CustomerID := CustomerID;
        Dialog.ShowModal;
    finally
        Dialog.Free;
    end;
end;

procedure ShowQuickInfoDialog(const AOwner: TComponent; const GoodsID: integer);
var
    Dialog: TfrmGoodsQuickInfoDlg;
begin
    Dialog := TfrmGoodsQuickInfoDlg.Create(AOwner);
    try
        Dialog.GoodsID := GoodsID;
        Dialog.ShowModal;
    finally
        Dialog.Free;
    end;
end;

procedure ShowQuickInfoCustomers(const AOwner: TComponent; const DT, CT: integer);
var
    Dialog: TfrmQuickCustomerInfoDlg;
begin
    Dialog := TfrmQuickCustomerInfoDlg.Create(AOwner);
    try
        Dialog.DT := DT;
        Dialog.CT := CT;
        if Dialog.ShowModal = mrOk then
            ShowCustomersBrowser(AOwner, Dialog.CustomerIDToOpen);
    finally
        Dialog.Free;
    end;
end;

function CheckGridForDocIDValue(const Grid: TcxGridDBTableView; var DocID: integer): Boolean;
var
    i: integer;
    col: TcxGridDBColumn;
begin
    DocID := -1;
    Result := False;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        col := Grid.Columns[i];
        if (col.DataBinding.FieldName = 'DOCID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index]) then
        begin
            DocID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
            Result := true;
            break;
        end;
    end;
end;

function CheckGridForDocIDValue(const Grid: TcxGridDBBandedTableView; var DocID: integer): Boolean;
var
    i: integer;
    col: TcxGridDBBandedColumn;
begin
    DocID := -1;
    Result := False;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        col := Grid.Columns[i];
        if (col.DataBinding.FieldName = 'DOCID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index]) then
        begin
            DocID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
            Result := true;
            break;
        end;
    end;
end;

procedure ShowDocumentExplorer(const AOwner: TComponent; const DocID: integer);
var
    Dialog: TfrmDocumentInspectorDlg;
begin
    Dialog := TfrmDocumentInspectorDlg.Create(AOwner);
    try
        Dialog.DocID := DocID;
        if Dialog.ShowModal = mrYes then
            frmMainForm.GotoDocument(Dialog.GotoDocID, Dialog.DocumentTarget);
    finally
        Dialog.Free;
    end;
end;

function CheckGridForCTField(const Grid: TcxGridDBTableView; var CT: integer): Boolean;
var
    i: integer;
    col: TcxGridDBColumn;
begin
    CT := -1;

    for i := 0 to Grid.ColumnCount - 1 do
        if Grid.Columns[i] is TcxGridDBColumn then
        begin
            col := Grid.Columns[i];
            if col.DataBinding.FieldName = 'CT' then
            begin
                if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
                    CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
            end;
        end;

    Result := (CT <> -1)
end;

function CheckGridForCTField(const Grid: TcxGridDBBandedTableView; var CT: integer): Boolean;
var
    i: integer;
    col: TcxGridDBBandedColumn;
begin
    CT := -1;

    for i := 0 to Grid.ColumnCount - 1 do
        if Grid.Columns[i] is TcxGridDBBandedColumn then
        begin
            col := Grid.Columns[i];
            if col.DataBinding.FieldName = 'CT' then
            begin
                if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
                    CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
            end;
        end;

    Result := (CT <> -1)
end;

// TArrayOperations declaration
class function TArrayOperations.Contain<T>(const Array1: TArray<T>; const Value: T; const Comparer: IComparer<T>): Boolean;
var
    MyElem: T;
begin
    for MyElem in Array1 do
        if Comparer.Compare(MyElem, Value) = 0 then
            exit(true);
    exit(False);
end;

class function TArrayOperations.Contain<T>(const Array1: TArray<T>; const Value: T): Boolean;
var
    IComp: IComparer<T>;
begin
    IComp := TComparer<T>.Default;
    Result := Contain<T>(Array1, Value, IComp);
end;

{//************ Explanation ***************
The provided code snippet defines a generic method `Contain` within a class `TArrayOperations`. This method checks whether a specific value is present in an array of items of a generic type `T`.

Here's a detailed breakdown of the code:

### Code Breakdown

1. **Class Declaration**:
   - `class function TArrayOperations.Contain<T>`: This indicates that `Contain` is a class function (meaning it can be called without an instance of `TArrayOperations`) and it's a generic function that can operate on any type `T`.

2. **Parameters**:
   - `const Array1: TArray<T>`: This parameter is an array (of type `T`) that the method will search through for the specified value. The `const` keyword suggests that the array will not be modified within the function.
   - `const Value: T`: This parameter represents the value that the method will search for within `Array1`.

3. **Variable Declaration**:
   - `var IComp: IComparer<T>`: This line declares a variable `IComp` of type `IComparer<T>`, which is an interface that allows for custom comparison logic between instances of type `T`.

4. **Default Comparer**:
   - `IComp := TComparer<T>.Default;`: This initializes `IComp` with the default comparer for type `T`. `TComparer<T>.Default` provides a way to compare instances of `T` using standard comparison logic (e.g., for basic types like integers or strings).

5. **Calling Overloaded Method**:
   - `Result := Contain<T>(Array1, Value, IComp);`: This line calls another version of the `Contain` method that takes the array, the value to search for, and the comparer interface. The result of this method call is assigned to the function's result (`Result`), which will return `True` if the value is found in the array and `False` otherwise.

### Summary
The `Contain` function is used to determine if an array of generic type `T` contains a specific value of type `T`. It uses a default comparison mechanism for the type `T` to perform the search. This function showcases the use of generics in object-oriented programming, allowing the function to work with any data type.

### Usage Example
If `TArrayOperations` was instantiated or invoked, and you had an array of integers and wanted to check for the existence of a specific integer, you could simply call this method with the array and the integer value. The method would return `True` if the integer is found and `False` otherwise.
}
// get if a particular bit is 1
function GetBitValue(const aValue: cardinal; const Bit: Byte): Boolean;
begin
    Result := (aValue and (1 shl Bit)) <> 0;
end;

// set a particular bit as Value (0, 1)
function SetBitValue(const aValue: cardinal; const Bit: Byte; Value: Byte): cardinal;
begin
    Result := aValue or (Value shl Bit);
end;

// set a particular bit as 0
function Clear_a_Bit(const aValue: cardinal; const Bit: Byte): cardinal;
begin
    Result := aValue and not (1 shl Bit);
end;

// Enable o disable a bit
function Enable_a_Bit(const aValue: cardinal; const Bit: Byte; const Flag: Boolean): cardinal;
begin
    Result := ((aValue or (1 shl Bit)) xor (cardinal(not Flag) shl Bit));
end;

function GetGoodsCpu(GoodsID: integer): TGoodsWebName;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select WEBTITLE_ROM, WEBTITLE_RUS from WEB_GET_GOODS_MIN_INFO(:GoodsID)';
        q.ParamByName('GoodsID').AsINteger := GoodsID;
        q.Open;
        Result.WebNameRo := StringReplace(q.FieldByName('WEBTITLE_ROM').AsString, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
        Result.WebNameRu := TranslitRus2Lat(StringReplace(q.FieldByName('WEBTITLE_RUS').AsString, ' ', '-', [rfReplaceAll, rfIgnoreCase]));
    finally
        q.Free;
    end;

end;

function ToUrlSlug(Value: string): string;
begin

  // First to lower case
    Value := Value.ToLowerInvariant;

  // Remove all accents
    var bytes := TEncoding.GetEncoding('Cyrillic').GetBytes(Value);

    Value := TEncoding.ASCII.GetString(bytes);

  // Replace spaces
    Value := TRegex.Replace(Value, '@s', '-', [roCompiled]);

  // Remove invalid chars
    Value := TRegex.Replace(Value, '@[^wsp{Pd}]', '', [roCompiled]);

  // Trim dashes from end
    Value := Value.Trim(['-', '_']);

  // Replace double occurences of - or _
    Value := TRegex.Replace(Value, '([-_:;+*~]){2,}', '$1', [roCompiled]);

    Result := Value;
end;

function BestFit(const AInput: AnsiString): AnsiString;
const
    codePage = 20127; // 20127 = us-ascii
var
    ws: WideString;
begin
    ws := WideString(AInput);
    SetLength(Result, WideCharToMultiByte(codePage, 0, PWideChar(ws), Length(ws), nil, 0, nil, nil));
    WideCharToMultiByte(codePage, 0, PWideChar(ws), Length(ws), PAnsiChar(Result), Length(Result), nil, nil);
end;

function StripUnwantedText(Text: string): string;
const
    CR = #13;
    LF = #10;
    CRLF = CR + LF;
begin
    Result := StringReplace(Text, CRLF, '', [rfReplaceAll]);
end;

procedure SmoothResize(Src, Dst: TBitmap);
var
    x, y: integer;
    xP, yP: integer;
    xP2, yP2: integer;
    SrcLine1, SrcLine2: pRGBArray;
    t3: integer;
    z, z2, iz2: integer;
    DstLine: pRGBArray;
    DstGap: integer;
    w1, w2, w3, w4: integer;
begin
    Src.PixelFormat := pf24Bit;
    Dst.PixelFormat := pf24Bit;

    if (Src.Width = Dst.Width) and (Src.Height = Dst.Height) then
        Dst.Assign(Src)
    else
    begin
        DstLine := Dst.ScanLine[0];
        DstGap := integer(Dst.ScanLine[1]) - integer(DstLine);

        xP2 := MulDiv(Pred(Src.Width), $10000, Dst.Width);
        yP2 := MulDiv(Pred(Src.Height), $10000, Dst.Height);
        yP := 0;

        for y := 0 to Pred(Dst.Height) do
        begin
            xP := 0;

            SrcLine1 := Src.ScanLine[yP shr 16];

            if (yP shr 16 < Pred(Src.Height)) then
                SrcLine2 := Src.ScanLine[Succ(yP shr 16)]
            else
                SrcLine2 := Src.ScanLine[yP shr 16];

            z2 := Succ(yP and $FFFF);
            iz2 := Succ((not yP) and $FFFF);
            for x := 0 to Pred(Dst.Width) do
            begin
                t3 := xP shr 16;
                z := xP and $FFFF;
                w2 := MulDiv(z, iz2, $10000);
                w1 := iz2 - w2;
                w4 := MulDiv(z, z2, $10000);
                w3 := z2 - w4;
                DstLine[x].rgbtRed := (SrcLine1[t3].rgbtRed * w1 + SrcLine1[t3 + 1].rgbtRed * w2 + SrcLine2[t3].rgbtRed * w3 + SrcLine2[t3 + 1].rgbtRed * w4) shr 16;
                DstLine[x].rgbtGreen := (SrcLine1[t3].rgbtGreen * w1 + SrcLine1[t3 + 1].rgbtGreen * w2 + SrcLine2[t3].rgbtGreen * w3 + SrcLine2[t3 + 1].rgbtGreen * w4) shr 16;
                DstLine[x].rgbtBlue := (SrcLine1[t3].rgbtBlue * w1 + SrcLine1[t3 + 1].rgbtBlue * w2 + SrcLine2[t3].rgbtBlue * w3 + SrcLine2[t3 + 1].rgbtBlue * w4) shr 16;
                Inc(xP, xP2);
            end; { for }
            Inc(yP, yP2);
            DstLine := pRGBArray(integer(DstLine) + DstGap);
        end; { for }
    end; { if }
end; { SmoothResize }

function swnTrim(s: string): string;
begin
  // trim the trailing whitespace
    s := Trim(s);
    while SysUtils.CharInSet(s[Length(s)], [#10, #13]) do
        System.Delete(s, Length(s), 1);

  // then do the rest
    for var i := Length(s) downto 1 do
        if (s[i] = #13) and (s[i - 1] = #10) then
            System.Delete(s, i, 2);
    Result := s;
end;

function DeleteRepeatedSpaces(const s: string): string;
var
    i: Integer;
    wasSpace: Boolean;
begin
    SetLength(Result, 0); // Start with empty result
    wasSpace := False;

    for i := 1 to Length(s) do
    begin
        if s[i] = ' ' then
        begin
            if not wasSpace then
            begin
                Result := Result + ' '; // Add a single space
                wasSpace := True; // Remember that we added a space
            end;
        end
        else
        begin
            Result := Result + s[i]; // Add non-space character
            wasSpace := False; // Reset space flag
        end;
    end;
end;

//  Old version of DeleteRepeatedSpaces
//function DeleteRepeatedSpaces(const s: string): string;
//var
//  i, j, State: integer;
//begin
//  SetLength(Result, Length(s));
//  j := 0;
//  State := 0;
//  for i := 1 to Length(s) do
//  begin
//    if s[i] = ' ' then
//      Inc(State)
//    else
//      State := 0;
//
//    if State < 2 then
//      Result[i - j] := s[i]
//    else
//      Inc(j);
//  end;
//  if j > 0 then
//    SetLength(Result, Length(s) - j);
//end;
{//************ Optimize Code ***************
The given Delphi code for `DeleteRepeatedSpaces` function removes consecutive spaces from a string,
retaining only a single space where such repetitions occur. Although the original code is quite functional,
it can be optimized for clarity, performance, and to avoid unnecessary length adjustments on the result string.

Here's a more optimized version of the function:

```delphi
function DeleteRepeatedSpaces(const s: string): string;
var
  i: Integer;
  wasSpace: Boolean;
begin
  SetLength(Result, 0); // Start with empty result
  wasSpace := False;

  for i := 1 to Length(s) do
  begin
    if s[i] = ' ' then
    begin
      if not wasSpace then
      begin
        Result := Result + ' '; // Add a single space
        wasSpace := True; // Remember that we added a space
      end;
    end
    else
    begin
      Result := Result + s[i]; // Add non-space character
      wasSpace := False; // Reset space flag
    end;
  end;
end;
```

### Key Changes and Justifications

1. **Dynamic String Append**: Instead of preallocating a fixed length and adjusting it afterward, we start with an empty result string and build it dynamically. This simplifies the logic and eliminates needing to keep track of indices.

2. **Boolean Flag for Spaces**: Instead of counting consecutive spaces, we use a boolean flag `wasSpace` to remember if the last character added to the result was a space. This makes the code easier to read and maintain.

3. **Direct Concatenation**: Using `Result := Result + ' '` allows for straightforward appending. Using `SetLength` to array our results can lead to complex index management, which is avoided here.

This optimized version of the function is more straightforward and, while still preserving performance for typical usages, tends to be cleaner and easier to understand. Depending on the use case, it may also allow Delphi's internal optimizations for string handling to take place, which can further improve performance in real-world scenarios.
}

function KillTask(ExeFileName: string): Integer;
const
    PROCESS_TERMINATE = $0001;
var
    ContinueLoop: Boolean;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
begin
    Result := 0;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

    while Integer(ContinueLoop) <> 0 do
    begin
        if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
            Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
        ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);

    ShellExecute(0, 'open', PWideChar('c:\Program Files (x86)\Microsoft\Microsoft Collaboration Manager\collabman.exe'), nil, nil, SW_HIDE);
end;

function ConvertWebPToPng(const WebPFileName, PngFileName: string): boolean;
var
    WebPImage: TWebPImage;
    Bitmap: TBitmap;
begin
    Result := False;
//  WebPImage := TWebPImage.Create;
    Bitmap := TBitmap.Create;
    try
        try
      // Load the WebP file into TWebPImage
            WebPImage.LoadFromFile(WebPFileName);

      // Convert the WebP image to a bitmap
            Bitmap.Assign(WebPImage);

      // Save the bitmap as a PNG file
            Bitmap.SaveToFile(PngFileName);

      // If no exceptions were raised, the conversion succeeded
            Result := True;
        except
            on E: Exception do
                raise Exception.Create('Error converting WebP to PNG: ' + E.Message);
        end;
    finally
        WebPImage.Free;
        Bitmap.Free;
    end;
end;

function ShowMergeGoodsDialog(GoodsID: integer): boolean;
var
    dialog: TfrmMergeGoodsDlg;
begin
    dialog := TfrmMergeGoodsDlg.Create(nil);
    try
        dialog.SourceGoodsID := GoodsID;
        result := (dialog.ShowModal = mrOk);
    finally
        dialog.Free;
    end;
end;

function ExtractNumbers(const S: string): string;
var
    I: Integer;
begin
    Result := '';
    for I := 1 to Length(S) do
        if S[I] in ['0'..'9'] then
            Result := Result + S[I];
end;


function DecodeEscapedUnicode(const AText: string): string;
var
  i: Integer;
  HexValue: string;
  CodePoint: Integer;
begin
  Result := '';
  i := 1;

  while i <= Length(AText) do
  begin
    if (AText[i] = '\') and (i < Length(AText)) then
    begin
      Inc(i);
      case AText[i] of
        'u':  // Unicode sequence \uXXXX
          begin
            if i + 4 <= Length(AText) then
            begin
              HexValue := Copy(AText, i + 1, 4);
              CodePoint := StrToIntDef('$' + HexValue, -1);
              if CodePoint <> -1 then
              begin
                Result := Result + Chr(CodePoint);
                Inc(i, 4);
              end;
            end;
          end;
        'n': Result := Result + #10;  // New line
        't': Result := Result + #9;   // Tab
        'r': Result := Result + #13;  // Carriage return
        '/': Result := Result + '/';  // Slash
        '\': Result := Result + '\';  // Backslash
        '"': Result := Result + '"';  // Quote
        else
          Result := Result + '\' + AText[i]; // Dacă nu e recunoscut, îl păstrează ca atare
      end;
    end
    else
      Result := Result + AText[i];

    Inc(i);
  end;
end;

function GenerateSlug(s: string): string;
var
  i: Integer;
  c: Char;
  PrevDash: Boolean;
  tmp: string;
begin

  // 1) Înlocuim diacriticele româneşti cu echivalentele ASCII
  tmp := S;
  tmp := StringReplace(tmp, 'Ă', 'A', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'ă', 'a', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Â', 'A', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'â', 'a', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Î', 'I', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'î', 'i', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Ș', 'S', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'ș', 's', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Ş', 'S', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'ş', 's', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Ț', 'T', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'ț', 't', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'Ţ', 'T', [rfReplaceAll]);
  tmp := StringReplace(tmp, 'ţ', 't', [rfReplaceAll]);

  // 2) Parcurgem caracterele şi construim slug-ul
  Result := '';
  PrevDash := False;
  for i := 1 to Length(tmp) do
  begin
    c := tmp[i];
    if TCharacter.IsLetterOrDigit(c) then
    begin
      // Caracter alfanumeric → adăugăm litera (lowercase)
      Result := Result + LowerCase(c);
      PrevDash := False;
    end
    else if c in [' ', '_', '-'] then
    begin
      // Spaţiu, underscore sau cratimă → transformăm în cratimă,
      // dar evităm cratime consecutive şi nu punem cratimă la început.
      if (not PrevDash) and (Result <> '') then
      begin
        Result := Result + '-';
        PrevDash := True;
      end;
    end;
    // orice alt caracter (semne de punctuaţie, diacritice rămase etc.) → îl sărim
  end;

  // 3) Eliminăm cratima de la final, dacă există
  if (Length(Result) > 0) and (Result[Length(Result)] = '-') then
    SetLength(Result, Length(Result) - 1);
end;

procedure AddDelivery2Jurnal(AGoodsID: Integer);
begin
  if not dmdb.IBCTrDefaultUpdate.Active then
    dmdb.IBCTrDefaultUpdate.StartTransaction;
  try
    dmdb.ExecuteQuery('execute procedure add_goods2jurnal(:docid, :goodscomplectid, :goodsid)',
    [dmdb.IBCQueryDocs.FieldByName
      ('DOCID').AsInteger, -1, AGoodsID]);
    dmdb.IBCQueryJurnal.Edit;
    dmdb.IBCQueryJurnal.Post;
    dmdb.IBCTrDefaultUpdate.Commit;
    dmdb.IBCQueryDocs.RefreshRecord;
    dmdb.IBCQueryJurnal.Refresh;
  except
    begin
      dmdb.IBCTrDefaultUpdate.Rollback;
      raise;
    end;
  end;
end;

end.

