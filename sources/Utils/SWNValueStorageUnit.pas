unit SWNValueStorageUnit;

interface
Uses Classes, Forms, cxGridTableView;

const
     cSETTINGS_AppAutoStart        = 'AutoStart';
     cSETTINGS_AppSaveLastLogin    = 'SaveLastLogin';
     cSETTINGS_AppLastLogin        = 'LastLogin';
     cSETTINGS_AppFiscalPrinterComPort = 'FP_ComPort';
     cSETTINGS_AppFiscalPrinterBoundRate = 'FP_BoundRate';

     cSETTINGS_AppFiscalPrinterComPortV2 = 'FP_ComPortV2';
     cSETTINGS_AppFiscalPrinterBoundRateV2 = 'FP_BoundRateV2';

     cSETTINGS_AppPriceIsFloat     = 'PRICE_IS_FLOAT';
     cSETTINGS_AppQtyDigits        = 'QTY_DIGITS';
     cSETTINGS_FacturaFiscalaReportID = 'FACTURA_FISCALA_REPORT_ID';

     cSETTINGS_UserFontSize        = '\FontSize';
     cSETTINGS_UserSaveFormPos     = '\SaveFormPos';
     cSETTINGS_UserSaveGridColumns = '\SaveGridColumns';
     cSETTINGS_GoodsFilters        = 'GoodsFilters';
     cSETTINGS_UserSaveMonitorPosition = '\SaveMonitorPos';
     cSETTINGS_MonitorLeftPos = '\MonitorLeftPos';
     cSETTINGS_MonitorTopPos = '\MonitorTopPos';
     cSETTINGS_MonitorWidth = '\MonitorWidth';
     cSETTINGS_MonitorHeight = '\MonitorHeight';

     cSETTINGS_CHAT_State = '\ChatState';
     cSETTINGS_CHAT_Align = '\ChatAlign';
     cSETTINGS_CHAT_Width = '\ChatWidth';
     cSETTINGS_CHAT_Splitter = '\ChatSplitter';
     cSETTINGS_CHAT_DockIndex = '\ChatDockIndex';
     cSETTINGS_CHAT_Visible = '\ChatVisible';

     cSETTINGS_SERVICE_DefaultUserForNewTask = 'Service:DefaultUserForNewTask';
type

  TCustomValueStorage = class
  private
    { private declarations }
    FOnChanged: TNotifyEvent;
    function GetCount: integer;
    procedure SetOnChanged(const Value: TNotifyEvent);
  protected
    { protected declarations }
    fList:TList;
    fCustomPath:String;
    function GetFullKey(const Key:String):String;
    procedure Changed;

    property OnChanged:TNotifyEvent read FOnChanged write SetOnChanged;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    procedure Clear;virtual;abstract;

    property Count:integer read GetCount;

  end;


  // DateTime Storage ----------------------------------------------------------------------------------------------

  TDateTimeValueStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):Pointer;
  public
    { public declarations }
    procedure Clear;override;
    procedure SetValue(const Key: String; const Value: TDateTime);
    function GetValue(const Key: String; const DefaultValue:TDateTime): TDateTime;
    function KeyExists(const Key: String):Boolean;
  end;


  // Int Storage ----------------------------------------------------------------------------------------------

  TIntValueStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):Pointer;
  public
    { public declarations }
    procedure Clear;override;
    procedure SetValue(const Key: String; const Value: Integer);
    function GetValue(const Key: String; const DefaultValue:Integer=0): Integer;

    procedure SetValueAsPercent(const Key: String; const MaxValue,CurrentValue: Integer);
    function GetValueAsPercent(const Key: String; const MaxValue:integer; const DefaultPercentValue:Integer=0): Integer;

  end;


  // Boolean Storage ----------------------------------------------------------------------------------------------

  TBoolValueStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):Pointer;
  public
    { public declarations }
    procedure Clear;override;
    procedure SetValue(const Key: String; const Value: Boolean);
    function GetValue(const Key: String; const DefaultValue:Boolean=False): Boolean;
    procedure DeleteValue(const Key: String);
    function KeyExists(const Key: String):Boolean;
  end;


  // Text Storage ----------------------------------------------------------------------------------------------

  TTextValueStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):Pointer;
  public
    { public declarations }
    procedure Clear;override;
    procedure SetValue(const Key: String; const Value: String);
    function GetValue(const Key: String; const DefaultValue:String=''): String;
    function KeyExists(const Key: String):Boolean;
  end;


  // FormPos Storage ----------------------------------------------------------------------------------------------

  TFormPosStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):Pointer;
  public
    { public declarations }
    procedure Clear;override;
    procedure SaveFormPos(const Form:TForm);
    function ReadFormPos(const Form:TForm; const ApplyNewPosition:Boolean=True):Boolean;
  end;

  // Grid Columns Storage ----------------------------------------------------------------------------------------------

  TGridColumnItem = class
  protected
    { protected declarations }
    fColName:String;
    fIndex:integer;
    fVisible:Boolean;
    fWidth:Integer;
    fGroupIndex:Integer;
  end;

  TGridColumnsClass = class
  protected
    { protected declarations }
    fKey:String;
    fColumns:TList;
  public
    { public declarations }
    constructor Create(const Key:String = '');
    destructor Destroy;override;

    procedure Clear;
  end;


  TGridColumnsStorage = class(TCustomValueStorage)
  private
    { private declarations }
  protected
    { protected declarations }
    procedure SaveToStream(const Stream:TStream);
    procedure LoadFromStream(const Stream:TStream);
    function GetItem(const Key:String):TGridColumnsClass;
  public
    { public declarations }
    procedure Clear;override;
    procedure SaveGridStructure(const Grid:TcxGridTableView);
    procedure ReadGridStructure(const Grid:TcxGridTableView);
  end;


  // App Main Storage ----------------------------------------------------------------------------------------------

  TAppInternalDataStorage = class
  private
    { private declarations }
    fTextValues: TTextValueStorage;
    fIntValues: TIntValueStorage;
    fBooleanValues: TBoolValueStorage;
    FAutoSave: Boolean;
    procedure SetAutoSave(const Value: Boolean);
  protected
    { protected declarations }
    fChanged:Boolean;
    fSourceFilePathName:String;
    procedure SaveHeader(const TargetStream:TStream; const DataStream:TMemoryStream);
    function CheckHeader(const SourceStream:TStream; const DataStream:TMemoryStream):Boolean;
    procedure WhenValuesChanged(Sender:TObject);
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Changed:Boolean read fChanged;

    property BooleanValues:TBoolValueStorage read fBooleanValues;
    property IntValues:TIntValueStorage read fIntValues;
    property TextValues:TTextValueStorage read fTextValues;

    property AutoSave:Boolean read FAutoSave write SetAutoSave;

    procedure Clear;

    procedure SaveToFile(const FileName:String);
    procedure LoadFromFile(const FileName:String);
    procedure DeleteSettingsFile;
  end;

  // App User Main Storage ----------------------------------------------------------------------------------------------

  TAppUserInternalDataStorage = class
  private
    { private declarations }
    fFormPositions: TFormPosStorage;
    fTextValues: TTextValueStorage;
    fIntValues: TIntValueStorage;
    fBooleanValues: TBoolValueStorage;
    fGridColumns:TGridColumnsStorage;
    FAutoSave: Boolean;
    fConfirmations: TBoolValueStorage;
    fDateTimeValues: TDateTimeValueStorage;
    procedure SetAutoSave(const Value: Boolean);
  protected
    { protected declarations }
    fOpenSectionCount:integer;
    fOpenSectionPath:String;
    fChanged:Boolean;
    fSourceFilePathName:String;
    procedure SaveHeader(const TargetStream:TStream; const DataStream,CompressedDataStream:TMemoryStream);
    function CheckHeader(const SourceStream:TStream; const DataStream:TMemoryStream):Boolean;
    procedure ApplySectionPath;
    procedure WhenValuesChanged(Sender:TObject);
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Changed:Boolean read fChanged;

    property BooleanValues:TBoolValueStorage read fBooleanValues;
    property IntValues:TIntValueStorage read fIntValues;
    property TextValues:TTextValueStorage read fTextValues;
    property FormPositions:TFormPosStorage read fFormPositions;
    property GridColumns:TGridColumnsStorage read fGridColumns;
    property Confirmations:TBoolValueStorage read fConfirmations;
    property DateTimeValues:TDateTimeValueStorage read fDateTimeValues;

    property AutoSave:Boolean read FAutoSave write SetAutoSave;

    procedure Clear;

    procedure SaveToFile(const FileName:String);
    procedure LoadFromFile(const FileName:String);

    procedure OpenSection(const SectionTitle:String);
    procedure CloseSection;
  end;


var
   // noi aven nevoie de 2 storage-uri:
   // 1. Optiunile generale ale programului care nu tin de user-ul current
   // 2. Optiunile personale ale user-ului

  // 1.
  globalPATH_LOCAL_APPDATA:String;

  AppConfigStorage:TAppInternalDataStorage; // parametrii globali independent de utilizatorul curent

  AppUserConfigStorage:TAppUserInternalDataStorage; // parametri utilizatorului curent
  AppUserTempConfigStorage:TAppUserInternalDataStorage; // parametri utilizatorului curent in sesiunea curenta




implementation
uses Windows, SysUtils, SZCRC32, SWNUtils;

const
     cHeaderTextApp = 'SWN configuration file';
     cHeaderTextUser = 'SWN user configuration file';

type

  PIntValueItem = ^TIntValueItem;
  TIntValueItem = record
    Key:String;
    Value:integer;
  end;

  PBoolValueItem = ^TBoolValueItem;
  TBoolValueItem = record
    Key:String;
    Value:Boolean;
  end;

  PTextValueItem = ^TTextValueItem;
  TTextValueItem = record
    Key:String;
    Value:String;
  end;

  PFormValueItem = ^TFormValueItem;
  TFormValueItem = record
    Key:String;
    Left,Top,Width,Height:integer;
  end;

  PDateTimeValueItem = ^TDateTimeValueItem;
  TDateTimeValueItem = record
    Key:String;
    Value:TDateTime;
  end;


  TFileHeaderRec=record
    Text:String[30];
    IsCompressed:Boolean;
    DataSize:Cardinal;
    ExpandedDataSize:cardinal;
    CRC32:DWORD;
  end;


{ TIntValueStorage }

procedure TIntValueStorage.Clear;
var i:integer;
    Item:PIntValueItem;
begin
     if fCustomPath='' then
     begin
          // stergem tot continutul
          for i := 0 to fList.Count - 1 do
          begin
               Item:=fList[i];
               Dispose(Item);
          end;
          fList.Clear;
     end
     else
     begin
          // stergem numai continutul mapei curente
          for i := fList.Count-1 downto 0 do
          begin
               Item:=fList[i];
               if (Pos(fCustomPath,Item^.Key)=1) then
               begin
                    Dispose(Item);
                    fList.Delete(i);
               end;
          end;
     end;
end;

function TIntValueStorage.GetItem(const Key: String): Pointer;
var i:integer;
    Item:PIntValueItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

function TIntValueStorage.GetValue(const Key: String; const DefaultValue: Integer): Integer;
var Item:PIntValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item)
      then Result:=Item^.Value
      else Result:=DefaultValue;
end;

function TIntValueStorage.GetValueAsPercent(const Key: String; const MaxValue, DefaultPercentValue: Integer): Integer;
var Val:integer;
begin
     Val:=GetValue(Key,DefaultPercentValue);
     Result:=Round(MaxValue*Val/100);
end;

procedure TIntValueStorage.LoadFromStream(const Stream: TStream);
var i,N:integer;
    Item:PIntValueItem;
    K:integer;
begin
     Clear;

     Stream.Read(N,SizeOf(Integer)); // read COUNT
     for i := 1 to N do
     begin
          New(Item);
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(Item^.Key,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Key[1],K); // read Key
          Stream.Read(Item^.Value,SizeOf(Integer)); // read Value
          fList.Add(Item);
     end;
end;

procedure TIntValueStorage.SaveToStream(const Stream: TStream);
var i,N:integer;
    Item:PIntValueItem;
    K:integer;
begin
     N:=fList.Count;
     Stream.Write(N,SizeOf(Integer)); // write COUNT
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          K:=SizeOf(Char)*Length(Item^.Key);
          Stream.Write(K,SizeOf(Integer)); // write Key length
          if K>0 then Stream.Write(Item^.Key[1],K); // write Key
          Stream.Write(Item^.Value,SizeOf(Integer)); // write Value
     end;
end;

procedure TIntValueStorage.SetValue(const Key: String; const Value: Integer);
var Item:PIntValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item) then Item^.Value:=Value
     else
     begin
          New(Item);
          Item^.Key:=GetFullKey(Key);
          Item^.Value:=Value;
          fList.Add(Item);
     end;
     Changed;
end;

procedure TIntValueStorage.SetValueAsPercent(const Key: String; const MaxValue, CurrentValue: Integer);
var N:integer;
begin
     N:=Round(CurrentValue*100/MaxValue);
     SetValue(Key,N);
end;

{ TCustomeValueStorage }

procedure TCustomValueStorage.Changed;
begin
     if Assigned(FOnChanged) then FOnChanged(Self);
end;

constructor TCustomValueStorage.Create;
begin
     fList:=TList.Create;
     fCustomPath:='';
     FOnChanged := nil;
end;

destructor TCustomValueStorage.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TCustomValueStorage.GetCount: integer;
begin
     Result:=fList.Count;
end;

function TCustomValueStorage.GetFullKey(const Key: String): String;
begin
     if (fCustomPath='') or (Pos('\',Key)=1)
      then Result:=Key
      else Result:=fCustomPath+'\'+Key;
end;

procedure TCustomValueStorage.SetOnChanged(const Value: TNotifyEvent);
begin
     FOnChanged := Value;
end;

{ TBoolValueStorage }

procedure TBoolValueStorage.Clear;
var i:integer;
    Item:PBoolValueItem;
begin
     if fCustomPath='' then
     begin
          // stergem tot continutul
          for i := 0 to fList.Count - 1 do
          begin
               Item:=fList[i];
               Dispose(Item);
          end;
          fList.Clear;
     end
     else
     begin
          // stergem numai continutul mapei curente
          for i := fList.Count-1 downto 0 do
          begin
               Item:=fList[i];
               if (Pos(fCustomPath,Item^.Key)=1) then
               begin
                    Dispose(Item);
                    fList.Delete(i);
               end;
          end;
     end;
end;

procedure TBoolValueStorage.DeleteValue(const Key: String);
var Item:PBoolValueItem;
    i:integer;
begin
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               fList.Delete(i);
               Break;
          end;
     end;
end;

function TBoolValueStorage.GetItem(const Key: String): Pointer;
var i:integer;
    Item:PBoolValueItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

function TBoolValueStorage.GetValue(const Key: String; const DefaultValue: Boolean): Boolean;
var Item:PBoolValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item)
      then Result:=Item^.Value
      else Result:=DefaultValue;
end;

function TBoolValueStorage.KeyExists(const Key: String): Boolean;
begin
     Result:=Assigned(GetItem(GetFullKey(Key)));
end;

procedure TBoolValueStorage.LoadFromStream(const Stream: TStream);
var i,N:integer;
    Item:PBoolValueItem;
    K:integer;
begin
     Clear;

     Stream.Read(N,SizeOf(Integer)); // read COUNT
     for i := 1 to N do
     begin
          New(Item);
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(Item^.Key,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Key[1],K); // read Key
          Stream.Read(Item^.Value,SizeOf(Boolean)); // read Value
          fList.Add(Item);
     end;
end;

procedure TBoolValueStorage.SaveToStream(const Stream: TStream);
var i,N:integer;
    Item:PBoolValueItem;
    K:integer;
begin
     N:=fList.Count;
     Stream.Write(N,SizeOf(Integer)); // write COUNT
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          K:=SizeOf(Char)*Length(Item^.Key);
          Stream.Write(K,SizeOf(Integer)); // write Key length
          if K>0 then Stream.Write(Item^.Key[1],K); // write Key
          Stream.Write(Item^.Value,SizeOf(Boolean)); // write Value
     end;
end;

procedure TBoolValueStorage.SetValue(const Key: String; const Value: Boolean);
var Item:PBoolValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item) then Item^.Value:=Value
     else
     begin
          New(Item);
          Item^.Key:=GetFullKey(Key);
          Item^.Value:=Value;
          fList.Add(Item);
     end;
     Changed;
end;

{ TTextValueStorage }

procedure TTextValueStorage.Clear;
var i:integer;
    Item:PTextValueItem;
begin
     if fCustomPath='' then
     begin
          // stergem tot continutul
          for i := 0 to fList.Count - 1 do
          begin
               Item:=fList[i];
               Dispose(Item);
          end;
          fList.Clear;
     end
     else
     begin
          // stergem numai continutul mapei curente
          for i := fList.Count-1 downto 0 do
          begin
               Item:=fList[i];
               if (Pos(fCustomPath,Item^.Key)=1) then
               begin
                    Dispose(Item);
                    fList.Delete(i);
               end;
          end;
     end;
end;

function TTextValueStorage.GetItem(const Key: String): Pointer;
var i:integer;
    Item:PTextValueItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

function TTextValueStorage.GetValue(const Key, DefaultValue: String): String;
var Item:PTextValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item)
      then Result:=Item^.Value
      else Result:=DefaultValue;
end;

function TTextValueStorage.KeyExists(const Key: String): Boolean;
begin
     Result:=Assigned(GetItem(GetFullKey(Key)));
end;

procedure TTextValueStorage.LoadFromStream(const Stream: TStream);
var i,N:integer;
    Item:PTextValueItem;
    K:integer;
begin
     Clear;

     Stream.Read(N,SizeOf(Integer)); // read COUNT
     for i := 1 to N do
     begin
          New(Item);
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(Item^.Key,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Key[1],K); // read Key

          Stream.Read(K,SizeOf(Integer)); // read Value length
          SetLength(Item^.Value,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Value[1],K); // read Key

          fList.Add(Item);
     end;
end;

procedure TTextValueStorage.SaveToStream(const Stream: TStream);
var i,N:integer;
    Item:PTextValueItem;
    K:integer;
begin
     N:=fList.Count;
     Stream.Write(N,SizeOf(Integer)); // write COUNT
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          K:=SizeOf(Char)*Length(Item^.Key);
          Stream.Write(K,SizeOf(Integer)); // write Key length
          if K>0 then Stream.Write(Item^.Key[1],K); // write Key

          K:=SizeOf(Char)*Length(Item^.Value);
          Stream.Write(K,SizeOf(Integer)); // write Value length
          if K>0 then Stream.Write(Item^.Value[1],K); // write Value
     end;
end;

procedure TTextValueStorage.SetValue(const Key, Value: String);
var Item:PTextValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item) then Item^.Value:=Value
     else
     begin
          New(Item);
          Item^.Key:=GetFullKey(Key);
          Item^.Value:=Value;
          fList.Add(Item);
     end;
     Changed;
end;

{ TFormPosStorage }

procedure TFormPosStorage.Clear;
var i:integer;
    Item:PFormValueItem;
begin
     if fCustomPath='' then
     begin
          // stergem tot continutul
          for i := 0 to fList.Count - 1 do
          begin
               Item:=fList[i];
               Dispose(Item);
          end;
          fList.Clear;
     end
     else
     begin
          // stergem numai continutul mapei curente
          for i := fList.Count-1 downto 0 do
          begin
               Item:=fList[i];
               if (Pos(fCustomPath,Item^.Key)=1) then
               begin
                    Dispose(Item);
                    fList.Delete(i);
               end;
          end;
     end;
end;

function TFormPosStorage.GetItem(const Key: String): Pointer;
var i:integer;
    Item:PFormValueItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

procedure TFormPosStorage.LoadFromStream(const Stream: TStream);
var i,N:integer;
    Item:PFormValueItem;
    K:integer;
begin
     Clear;

     Stream.Read(N,SizeOf(Integer)); // read COUNT
     for i := 1 to N do
     begin
          New(Item);
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(Item^.Key,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Key[1],K); // read Key

          Stream.Read(Item^.Left,SizeOf(Integer)); // read Left
          Stream.Read(Item^.Top,SizeOf(Integer)); // read Top
          Stream.Read(Item^.Width,SizeOf(Integer)); // read Width
          Stream.Read(Item^.Height,SizeOf(Integer)); // read Height

          fList.Add(Item);
     end;
end;

function TFormPosStorage.ReadFormPos(const Form: TForm; const ApplyNewPosition:Boolean=True):Boolean;
var Item:PFormValueItem;
    L,T,W,H:integer;
begin
     Result:=False;
     Item:=GetItem(GetFullKey(Form.Name));
     if Assigned(Item) then
     begin
          L:=Item^.Left;
          T:=Item^.Top;
          if Item^.Width>0 then W:=Item^.Width else W:=Form.Width;
          if Item^.Height>0 then H:=Item^.Height else H:=Form.Height;

          // adjust screen coords
          if (L+W)>Screen.DesktopWidth then L:=Screen.DesktopWidth-W;
          if (T+H+48)>Screen.DesktopHeight then T:=(Screen.DesktopHeight-48)-H;

          if L<0 then L:=0;
          if T<0 then T:=0;

          if (L+W)>Screen.DesktopWidth then W:=Screen.DesktopWidth-L;
          if (T+H+48)>Screen.DesktopHeight then H:=(Screen.DesktopHeight-48)-T;

          Form.Left:=L;
          Form.Top:=T;
          if Item^.Width>0 then Form.Width:=W;
          if Item^.Height>0 then Form.Height:=H;

          if ApplyNewPosition then Form.Position:=poDesigned;

          Result:=True;
     end;
end;

procedure TFormPosStorage.SaveFormPos(const Form: TForm);
var Item:PFormValueItem;
begin
     Item:=GetItem(GetFullKey(Form.Name));
     if Not Assigned(Item) then
     begin
          New(Item);
          Item^.Key:=GetFullKey(Form.Name);
          fList.Add(Item);
     end;
     Item^.Left:=Form.Left;
     Item^.Top:=Form.Top;
     if Form.BorderStyle=bsDialog then
     begin
          Item^.Width:=0;
          Item^.Height:=0;
     end
     else
     begin
          Item^.Width:=Form.Width;
          Item^.Height:=Form.Height;
     end;
     Changed;
end;

procedure TFormPosStorage.SaveToStream(const Stream: TStream);
var i,N:integer;
    Item:PFormValueItem;
    K:integer;
begin
     N:=fList.Count;
     Stream.Write(N,SizeOf(Integer)); // write COUNT
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          K:=SizeOf(Char)*Length(Item^.Key);
          Stream.Write(K,SizeOf(Integer)); // write Key length
          if K>0 then Stream.Write(Item^.Key[1],K); // write Key

          Stream.Write(Item^.Left,SizeOf(Integer)); // write Left
          Stream.Write(Item^.Top,SizeOf(Integer)); // write Top
          Stream.Write(Item^.Width,SizeOf(Integer)); // write Width
          Stream.Write(Item^.Height,SizeOf(Integer)); // write Height
     end;
end;

{ TAppInternalDataStorage }

procedure TAppUserInternalDataStorage.ApplySectionPath;
begin
     fIntValues.fCustomPath:=fOpenSectionPath;
     fBooleanValues.fCustomPath:=fOpenSectionPath;
     fTextValues.fCustomPath:=fOpenSectionPath;
     fFormPositions.fCustomPath:=fOpenSectionPath;
     fGridColumns.fCustomPath:=fOpenSectionPath;
     fConfirmations.fCustomPath:=fOpenSectionPath;
end;

function TAppUserInternalDataStorage.CheckHeader(const SourceStream: TStream; const DataStream: TMemoryStream): Boolean;
var header:TFileHeaderRec;
    MS:TMemoryStream;
begin
     Result:=False;

     SourceStream.Read(header,SizeOf(header));
     if header.Text=cHeaderTextUser then
     begin
          if header.IsCompressed then
          begin
               MS:=TMemoryStream.Create;
               try
                  MS.CopyFrom(SourceStream,SourceStream.Size-SourceStream.Position);
                  MS.Position:=0;
                  if (header.DataSize=MS.Size) and (SZCRC32FullStream(MS)=header.CRC32) then
                  begin
                       DataStream.Size:=header.ExpandedDataSize;
                       UnCompressStream(MS,DataStream);
                       Result:=True;
                  end;
               finally
                  MS.Free;
               end;
          end
          else
          begin
               DataStream.CopyFrom(SourceStream,SourceStream.Size-SourceStream.Position);
               DataStream.Position:=0;
               Result:=(header.DataSize=DataStream.Size) and (SZCRC32FullStream(DataStream)=header.CRC32);
          end;
     end;
end;

procedure TAppUserInternalDataStorage.Clear;
begin
     fIntValues.Clear;
     fBooleanValues.Clear;
     fTextValues.Clear;
     fFormPositions.Clear;
     fGridColumns.Clear;
end;

procedure TAppUserInternalDataStorage.CloseSection;
var N:integer;
begin
     if fOpenSectionCount>0 then
     begin
          Dec(fOpenSectionCount);
          if fOpenSectionCount=0 then fOpenSectionPath:=''
          else
          begin
               N:=Length(fOpenSectionPath);
               while (N>0) and (fOpenSectionPath[N]<>'\') do Dec(N);
               Delete(fOpenSectionPath,N,Length(fOpenSectionPath));
          end;
          ApplySectionPath;
     end
     else raise Exception.Create('Too many "CloseSection" calls!');
end;

constructor TAppUserInternalDataStorage.Create;
begin
     fChanged:=False;
     fOpenSectionCount:=0;
     fOpenSectionPath:='';
     FAutoSave := False;
     fSourceFilePathName := '';

     fFormPositions:=TFormPosStorage.Create;
     fFormPositions.OnChanged:=WhenValuesChanged;

     fTextValues:=TTextValueStorage.Create;
     fTextValues.OnChanged:=WhenValuesChanged;

     fIntValues:=TIntValueStorage.Create;
     fIntValues.OnChanged:=WhenValuesChanged;

     fBooleanValues:=TBoolValueStorage.Create;
     fBooleanValues.OnChanged:=WhenValuesChanged;

     fGridColumns:=TGridColumnsStorage.Create;
     fGridColumns.OnChanged:=WhenValuesChanged;

     fConfirmations:=TBoolValueStorage.Create;
     fConfirmations.OnChanged:=WhenValuesChanged;

     fDateTimeValues:=TDateTimeValueStorage.Create;
     fDateTimeValues.OnChanged:=WhenValuesChanged;

     ApplySectionPath;
end;

destructor TAppUserInternalDataStorage.Destroy;
begin
     try
        if FAutoSave and (fSourceFilePathName<>'') and fChanged then SaveToFile(fSourceFilePathName);
     finally
        fIntValues.Free;
        fBooleanValues.Free;
        fTextValues.Free;
        fFormPositions.Free;
        fGridColumns.Free;
        fConfirmations.Free;
        fDateTimeValues.Free;

        inherited;
     end;
end;

procedure TAppUserInternalDataStorage.LoadFromFile(const FileName: String);
var F:TFileStream;
    MS:TMemoryStream;
begin
     Clear;

     fSourceFilePathName:=FileName;

     if Not FileExists(FileName) then Exit;

     F:=TFileStream.Create(FileName,fmOpenRead);
     MS:=TMemoryStream.Create;
     try
        if CheckHeader(F,MS) then
        begin
             MS.Position:=0;
             fIntValues.LoadFromStream(MS);
             fBooleanValues.LoadFromStream(MS);
             fTextValues.LoadFromStream(MS);
             fFormPositions.LoadFromStream(MS);
             fGridColumns.LoadFromStream(MS);
             fConfirmations.LoadFromStream(MS);
             // fisierele salvate de versiuni mai vechi nu contin sectiunea DateTime
             if MS.Position<MS.Size then
                fDateTimeValues.LoadFromStream(MS);
        end;
     finally
        MS.Free;
        F.Free;
     end;
     fChanged:=False;
end;

procedure TAppUserInternalDataStorage.WhenValuesChanged(Sender: TObject);
begin
     fChanged:=True;
end;

procedure TAppUserInternalDataStorage.OpenSection(const SectionTitle: String);
begin
     Inc(fOpenSectionCount);
     fOpenSectionPath:=fOpenSectionPath+'\'+SectionTitle;
     ApplySectionPath;
end;

procedure TAppUserInternalDataStorage.SaveHeader(const TargetStream: TStream; const DataStream,CompressedDataStream: TMemoryStream);
var header:TFileHeaderRec;
    tmpStream:TMemoryStream;
begin
     // prepare header
     ZeroMemory(@header,Sizeof(TFileHeaderRec));
     header.Text:=cHeaderTextUser;
     header.DataSize:=DataStream.Size;
     tmpStream:=DataStream;
     // compression
     if Assigned(CompressedDataStream) and (CompressedDataStream.Size>0) then
     begin
          header.IsCompressed:=True;
          header.DataSize:=CompressedDataStream.Size;
          header.ExpandedDataSize:=DataStream.Size;
          tmpStream:=CompressedDataStream;
     end;
     // calc CRC32
     tmpStream.Position:=0;
     header.CRC32:=SZCRC32FullStream(tmpStream);
     // save header
     TargetStream.Write(header,SizeOf(header));
end;

procedure TAppUserInternalDataStorage.SaveToFile(const FileName: String);
var F:TFileStream;
    MS:TMemoryStream;
    MS2:TMemoryStream;
begin
     F:=TFileStream.Create(FileName,fmCreate);
     MS:=TMemoryStream.Create;
     MS2:=TMemoryStream.Create;
     try
        fIntValues.SaveToStream(MS);
        fBooleanValues.SaveToStream(MS);
        fTextValues.SaveToStream(MS);
        fFormPositions.SaveToStream(MS);
        fGridColumns.SaveToStream(MS);
        fConfirmations.SaveToStream(MS);
        fDateTimeValues.SaveToStream(MS);

        CompressStream(MS,MS2);

        SaveHeader(F,MS,MS2);
        MS2.Position:=0;
        F.CopyFrom(MS2,MS2.Size);
        fChanged:=False;
     finally
        MS2.Free;
        MS.Free;
        F.Free;
     end;
end;

procedure TAppUserInternalDataStorage.SetAutoSave(const Value: Boolean);
begin
     FAutoSave := Value;
end;


//=============================================================================

{ TAppInternalDataStorage }

function TAppInternalDataStorage.CheckHeader(const SourceStream: TStream; const DataStream: TMemoryStream): Boolean;
var header:TFileHeaderRec;
begin
     Result:=False;

     SourceStream.Read(header,SizeOf(header));
     if header.Text=cHeaderTextApp then
     begin
          DataStream.CopyFrom(SourceStream,SourceStream.Size-SourceStream.Position);
          DataStream.Position:=0;
          Result:=(header.DataSize=DataStream.Size) and (SZCRC32FullStream(DataStream)=header.CRC32);
     end;
end;

procedure TAppInternalDataStorage.Clear;
begin
     fIntValues.Clear;
     fBooleanValues.Clear;
     fTextValues.Clear;
end;

constructor TAppInternalDataStorage.Create;
begin
     fChanged:=False;
     FAutoSave := False;
     fSourceFilePathName := '';

     fTextValues:=TTextValueStorage.Create;
     fTextValues.OnChanged:=WhenValuesChanged;

     fIntValues:=TIntValueStorage.Create;
     fIntValues.OnChanged:=WhenValuesChanged;

     fBooleanValues:=TBoolValueStorage.Create;
     fBooleanValues.OnChanged:=WhenValuesChanged;
end;

procedure TAppInternalDataStorage.DeleteSettingsFile;
begin
    DeleteFile(fSourceFilePathName);
end;

destructor TAppInternalDataStorage.Destroy;
begin
     try
        if FAutoSave and (fSourceFilePathName<>'') and fChanged then SaveToFile(fSourceFilePathName);
     finally
        fIntValues.Free;
        fBooleanValues.Free;
        fTextValues.Free;

        inherited;
     end;
end;

procedure TAppInternalDataStorage.LoadFromFile(const FileName: String);
var F:TFileStream;
    MS:TMemoryStream;
begin
     Clear;

     fSourceFilePathName:=FileName;

     if Not FileExists(FileName) then Exit;

     F:=TFileStream.Create(FileName,fmOpenRead);
     MS:=TMemoryStream.Create;
     try
        if CheckHeader(F,MS) then
        begin
             MS.Position:=0;
             fIntValues.LoadFromStream(MS);
             fBooleanValues.LoadFromStream(MS);
             fTextValues.LoadFromStream(MS);
        end;
     finally
        MS.Free;
        F.Free;
     end;
     fChanged:=False;
end;

procedure TAppInternalDataStorage.SaveHeader(const TargetStream: TStream; const DataStream: TMemoryStream);
var header:TFileHeaderRec;
begin
     // prepare header
     ZeroMemory(@header,Sizeof(TFileHeaderRec));
     header.Text:=cHeaderTextApp;
     header.DataSize:=DataStream.Size;
     DataStream.Position:=0;
     header.CRC32:=SZCRC32FullStream(DataStream);
     // save header
     TargetStream.Write(header,SizeOf(header));
end;

procedure TAppInternalDataStorage.SaveToFile(const FileName: String);
var F:TFileStream;
    MS:TMemoryStream;
begin
     F:=TFileStream.Create(FileName,fmCreate);
     MS:=TMemoryStream.Create;
     try
        fIntValues.SaveToStream(MS);
        fBooleanValues.SaveToStream(MS);
        fTextValues.SaveToStream(MS);

        SaveHeader(F,MS);
        MS.Position:=0;
        F.CopyFrom(MS,MS.Size);
        fChanged:=False;
     finally
        MS.Free;
        F.Free;
     end;
end;

procedure TAppInternalDataStorage.SetAutoSave(const Value: Boolean);
begin
     FAutoSave := Value;
end;

procedure TAppInternalDataStorage.WhenValuesChanged(Sender: TObject);
begin
     fChanged:=True;
end;

{ TGridColumnsStorage }

procedure TGridColumnsStorage.Clear;
var i:integer;
    Item:TGridColumnsClass;
begin
     for i := 0 to fList.Count - 1 do
     begin
          Item:=TGridColumnsClass(fList[i]);
          Item.Free;
     end;
     fList.Clear;
end;

function TGridColumnsStorage.GetItem(const Key: String): TGridColumnsClass;
var i:integer;
    Item:TGridColumnsClass;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=TGridColumnsClass(fList[i]);
          if SameText(Item.fKey,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

procedure TGridColumnsStorage.LoadFromStream(const Stream: TStream);
var N,N2,i,j,K:Integer;
    Item:TGridColumnsClass;
    Col:TGridColumnItem;
    S:String;
begin
     Clear;

     // item count
     Stream.Read(N,SizeOf(Integer));

     for i := 0 to N - 1 do
     begin
          Item:=TGridColumnsClass.Create;
          // key
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(S,K div SizeOf(Char));
          if K>0 then Stream.Read(S[1],K); // read Key
          Item.fKey:=S;

          // columns count
          Stream.Read(N2,SizeOf(Integer));
          // columns
          for j := 0 to N2 - 1 do
          begin
               Col:=TGridColumnItem.Create;

               Stream.Read(K,SizeOf(Integer)); // write column name length
               SetLength(S,K div SizeOf(Char));
               if K>0 then Stream.Read(S[1],K); // write column name
               Col.fColName:=S;

               Stream.Read(Col.fIndex,SizeOf(Integer));
               Stream.Read(Col.fVisible,SizeOf(Boolean));
               Stream.Read(Col.fWidth,SizeOf(Integer));
               Stream.Read(Col.fGroupIndex,SizeOf(Integer));

               Item.fColumns.Add(Col);
          end;

          fList.Add(Item);
     end;
end;

procedure TGridColumnsStorage.ReadGridStructure(const Grid: TcxGridTableView);
var Item:TGridColumnsClass;
    i,j:integer;
    GridCol:TcxGridColumn;
    Col:TGridColumnItem;
begin
     Item:=GetItem(GetFullKey(Grid.Name));
     if Not Assigned(Item) then Exit;

     Grid.BeginUpdate;
     try
        for j := 0 to Item.fColumns.Count-1 do
        begin
             Col:=Item.fColumns[j];
             for i := 0 to Grid.ColumnCount-1 do
             begin
                  GridCol:=Grid.Columns[i];
                  if SameText(Col.fColName,GridCol.Name) then
                  begin
                       // column found, get values
                       GridCol.Index:=Col.fIndex;
                       GridCol.Visible:=Col.fVisible;
                       // restore width only for non fixed columns
                       if GridCol.Options.HorzSizing then GridCol.Width:=Col.fWidth;
                       GridCol.GroupIndex:=Col.fGroupIndex;
                       Break;
                  end;
             end;
        end;
     finally
        Grid.EndUpdate;
     end;
end;

procedure TGridColumnsStorage.SaveGridStructure(const Grid: TcxGridTableView);
var Item:TGridColumnsClass;
    i:integer;
    GridCol:TcxGridColumn;
    Col:TGridColumnItem;
begin
     Item:=GetItem(GetFullKey(Grid.Name));
     if Not Assigned(Item) then
     begin
          Item:=TGridColumnsClass.Create(GetFullKey(Grid.Name));
          fList.Add(Item);
     end;
     Item.Clear;

     // save values
     for i := 0 to Grid.ColumnCount-1 do
     begin
          GridCol:=Grid.Columns[i];
          //if GridCol.VisibleForCustomization then
          begin
               Col:=TGridColumnItem.Create;

               Col.fColName:=GridCol.Name;
               Col.fIndex:=GridCol.Index;
               Col.fVisible:=GridCol.Visible;
               Col.fWidth:=GridCol.Width;
               Col.fGroupIndex:=GridCol.GroupIndex;

               Item.fColumns.Add(Col);
          end;
     end;
end;

procedure TGridColumnsStorage.SaveToStream(const Stream: TStream);
var N,N2,i,j,K:Integer;
    Item:TGridColumnsClass;
    Col:TGridColumnItem;
    S:String;
    Width: Integer;
begin
     // item count
     N:=fList.Count;
     Stream.Write(N,SizeOf(Integer));

     for i := 0 to N - 1 do
     begin
          Item:=TGridColumnsClass(fList[i]);
          // key
          K:=SizeOf(Char)*Length(Item.fKey);
          Stream.Write(K,SizeOf(Integer)); // write Key length
          if K>0 then Stream.Write(Item.fKey[1],K); // write Key
          // columns count
          N2:=Item.fColumns.Count;
          Stream.Write(N2,SizeOf(Integer));
          // columns
          for j := 0 to N2-1 do
          begin
               Col:=Item.fColumns[j];
               S:=Col.fColName;
               K:=SizeOf(Char)*Length(S);
               Stream.Write(K,SizeOf(Integer)); // write column name length
               if K>0 then Stream.Write(S[1],K); // write column name

            Stream.Write(Col.fIndex, SizeOf(Integer));
            Stream.Write(Col.fVisible, SizeOf(Boolean));
            Width:= Col.fWidth;
            Stream.Write(Width, SizeOf(Integer));
            Stream.Write(Col.fGroupIndex, SizeOf(Integer));
          end;
     end;
end;

{ TGridColumnsClass }

procedure TGridColumnsClass.Clear;
var i:integer;
    Col:TGridColumnItem;
begin
     for i := 0 to fColumns.Count - 1 do
     begin
          Col:=TGridColumnItem(fColumns[i]);
          Col.Free;
     end;
     fColumns.Clear;
end;

constructor TGridColumnsClass.Create(const Key: String);
begin
     fColumns:=TList.Create;
     fKey:=Key;
end;

destructor TGridColumnsClass.Destroy;
begin
     Clear;
     inherited;
end;

{ TDateTimeValueStorage }

procedure TDateTimeValueStorage.Clear;
var i:integer;
    Item:PDateTimeValueItem;
begin
     if fCustomPath='' then
     begin
          // stergem tot continutul
          for i := 0 to fList.Count - 1 do
          begin
               Item:=fList[i];
               Dispose(Item);
          end;
          fList.Clear;
     end
     else
     begin
          // stergem numai continutul mapei curente
          for i := fList.Count-1 downto 0 do
          begin
               Item:=fList[i];
               if (Pos(fCustomPath,Item^.Key)=1) then
               begin
                    Dispose(Item);
                    fList.Delete(i);
               end;
          end;
     end;
end;

function TDateTimeValueStorage.GetItem(const Key: String): Pointer;
var i:integer;
    Item:PDateTimeValueItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          Item:=fList[i];
          if SameText(Item^.Key,Key) then
          begin
               Result:=Item;
               Break;
          end;
     end;
end;

function TDateTimeValueStorage.GetValue(const Key: String; const DefaultValue: TDateTime): TDateTime;
var Item:PDateTimeValueItem;
begin
     Item:=GetItem(GetFullKey(Key));
     if Assigned(Item)
      then Result:=Item^.Value
      else Result:=DefaultValue;
end;

function TDateTimeValueStorage.KeyExists(const Key: String): Boolean;
begin
     Result:=Assigned(GetItem(GetFullKey(Key)));
end;

procedure TDateTimeValueStorage.LoadFromStream(const Stream: TStream);
var i,N:integer;
    Item:PDateTimeValueItem;
    K:integer;
begin
     Clear;

     Stream.Read(N,SizeOf(Integer)); // read COUNT
     for i := 1 to N do
     begin
          New(Item);
          Stream.Read(K,SizeOf(Integer)); // read Key length
          SetLength(Item^.Key,K div SizeOf(Char));
          if K>0 then Stream.Read(Item^.Key[1],K); // read Key
          Stream.Read(Item^.Value,SizeOf(TDateTime)); // read Value
          fList.Add(Item);
     end;
end;

procedure TDateTimeValueStorage.SaveToStream(const Stream: TStream);
var i,N:integer;
    Item:PDateTimeValueItem;
    K:integer;
begin
    N := fList.Count;
    Stream.Write(N, SizeOf(Integer)); // write COUNT
    for i := 0 to fList.Count - 1 do
    begin
        Item := fList[i];
        K := SizeOf(Char) * Length(Item^.Key);
        Stream.Write(K, SizeOf(Integer)); // write Key length
        if K > 0 then
            Stream.Write(Item^.Key[1], K); // write Key
        Stream.Write(Item^.Value, SizeOf(TDateTime)); // write Value
    end;
end;

procedure TDateTimeValueStorage.SetValue(const Key: String; const Value: TDateTime);
var Item:PDateTimeValueItem;
begin
    Item := GetItem(GetFullKey(Key));
    if Assigned(Item) then
        Item^.Value := Value
    else
    begin
        New(Item);
        Item^.Key := GetFullKey(Key);
        Item^.Value := Value;
        fList.Add(Item);
    end;
    Changed;
end;

initialization

 AppConfigStorage:=TAppInternalDataStorage.Create;
 AppUserConfigStorage:=nil;
 AppUserTempConfigStorage:=nil;

finalization

 AppConfigStorage.Free;


end.
