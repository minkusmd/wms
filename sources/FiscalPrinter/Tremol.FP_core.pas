{ Tremol fiscal device core library }

unit Tremol.FP_core;

interface

uses
  Classes,
  Variants,
  SysUtils,
  DateUtils,
  IdGlobal,
  IdHTTP,
  IdCoderMIME,
  TypInfo,
  StrUtils,
  XMLDoc,
  XMLIntf;

type
  TBytes = array of byte;
  DummyCoreObject = class(TPersistent)
  private
    FValue: Variant;
  published
    Property Value: Variant read FValue write FValue;
  end;

  ResEnum = class(TPersistent)
    public procedure Init(nam: Variant; val: string); virtual; abstract;
  end;

  SErrorType = (OK = 0,
    ServMismatchBetweenDefinitionAndFPResult = 9,
    ServDefMissing = 10,
    ServArgDefMissing = 11,
    ServCreateCmdString = 12,
    ServUndefined = 19,
    ServSockConnectionFailed = 30,
    ServTCPAuth = 31,
    ServWrongTcpConnSettings = 32,
    ServWrongSerialPortConnSettings = 33,
    ServWaitOtherClientCmdProcessingTimeOut = 34,
    ServDisconnectOtherClientErr = 35,

    FPException = 40,

    ClientArgDefMissing = 50,
    ClientAttrDefMissing = 51,
    ClientArgValueWrongFormat = 52,
    ClientSettingsNotInitialized = 53,

    ClientInvalidGetFormat = 62,
    ClientInvalidPostFormat = 63,

    ServerAddressNotSet = 100,
    ServerConnectionError = 101,
    ServerResponseMissing = 102,
    ServerResponseError = 103,
    ServerDefsMismatch = 104,

    ClientXMLCanNotParse = 105,
    ClientCanNotParseResponseXML = 106,

    ServerErr = 1000
  );

  XMode = (useArtificialXml, useGetRequest, useRawXml);

  SException = class(Exception)
    private
      err_tp:  SErrorType;
      msg_internal, inner_ex_msg, ErrTypeString: string;
      in_ex: Exception;
      fSTE1, fSTE2, fFPLibErrorCode: integer;

    public
      constructor Create(err_type: SErrorType; ErrorTypeString: string; message_internal: string; inner_ex: Exception); overload;
      property ErrType: SErrorType read err_tp write err_tp;
      property STE1: integer read fSTE1 write fSTE1;
      property STE2: integer read fSTE2 write fSTE2;
      property FPLibErrorCode: integer read fFPLibErrorCode write fFPLibErrorCode;
      function IsFiscalPrinterError(): boolean;
      function GetMessage: string;
  end;

  FP_Core = class
  private
    Faddress: string;
    fXmode: XMode;
    timestamp: double;
    _coreVer: string;
    _emptyEnum: integer;
    _emptyDouble: double;
    _definitionsAlreadySent: Boolean;
    
    class procedure Init;
    class procedure Close;

    procedure CheckVersion(res: IXMLDocument);
    function sendGETRequest(request: String): IXMLDocument;
    function sendPOSTRequest(address: String; xml: IXMLDocument) : IXMLDocument;
    function concatGetMethodStr(commandName: string; data: array of Variant): string;
    function fillXMLwithParamValues(commandName: string; data: array of Variant): IXMLDocument;
    function valToString(val: Variant): WideString;
    function escapeXmlChars(val: string): string;
    function var2date(p: string; format: TFormatSettings): TDateTime;

    procedure throwOnServerError(doc: IXMLDocument);

  protected
    property VersionDefs: double write timestamp;
    procedure SendDefinitions(defs: IXMLDocument);

  public    
    constructor Create(); overload;
    property CoreVer: string read _coreVer;
    property EmptyEnum: integer read _emptyEnum;
    property EmptyDouble: double read _emptyDouble;
    property ServerAddress: string read Faddress write Faddress;
    property VersionDef: double read timestamp;

    function Execute(commandName: string; data: array of Variant): IXMLDocument;
    function CreateRes(cls: TClass; resp_xml: IXMLDocument): TObject;

    function ServerGetSettings: string;
    function ServerFindDevice: TStringList;
    procedure ServerSetDeviceSerialPortSettings(serialPort: string; baudRate: integer);
    procedure ServerSetDeviceTcpSettings( ip: string; tcpPort: integer; password: string);
    procedure ServerSetLog(enable: boolean);
    function ServerGetLog: string;
    function ServerGetClients: string;
    procedure ServerCloseDeviceConnection;
    procedure ServerRestart;
    procedure ServerRemoveAllClients;
    function getFormat(): TFormatSettings;
    function SendRAWRequest(xml: IXMLDocument): IXMLDocument;

end;

implementation
var
  lHTTP: TIdHTTP;
  IdEncMIME: TIdEncoderMIME;
  IdDecMIME: TIdDecoderMIME;
  fpFormat: TFormatSettings;
{PUBLIC METHODS}

{Executes command}
function FP_Core.Execute(commandName: string; data: array of Variant): IXMLDocument;
var
  xml, res: IXMLDocument;
  getRequestStr: string;
begin
   if Length(ServerAddress) = 0 then
    begin
    raise SException.Create(ServerAddressNotSet, 'ServerAddressNotSet', 'Server Address Not Defined', nil)
    end;

    xml := fillXMLwithParamValues(commandName, data);
    Result := sendPOSTrequest(ServerAddress, xml);
end;

procedure FP_Core.ThrowOnServerError(doc: IXMLDocument);
var
  code, st1, st2, FPLibErrorCode : integer;
  msg, typeErrStr: string;
  msgNode, errNode: IXMLNode;
  sxc:SException;
  errType : SErrorType;
begin
    try
      code := strtoint(doc.DocumentElement.Attributes['Code']);
      if code <> 0 then
        begin
          if code = integer(FPException) then
            begin
              errNode :=   doc.DocumentElement.ChildNodes.First;
              TryStrToInt('$' + errNode.Attributes['STE1'], st1);
              TryStrToInt('$' + errNode.Attributes['STE2'], st2);
              TryStrToInt('$' + errNode.Attributes['FPLibErrorCode'], FPLibErrorCode);
            end;

          msgNode :=  doc.DocumentElement.ChildNodes.First;
          if msgnode <> nil then
          msg := msgnode.ChildNodes.First.Text;
          typeErrStr :=  msgNode.Attributes['Type']
        end;
    except
      on ex : Exception do
        begin
          raise SException.Create(ServerResponseError, 'ServerResponseError', 'Server response error', ex);
        end;
    end;

    if code <> integer(OK) then
    begin
      errType := SErrorType(code);
      if inttostr(ord(errType)) <> '' then
      begin
        begin
          sxc := SException.Create(errType, typeErrStr, msg, nil);
          sxc.STE1 := st1;
          sxc.STE2 := st2;
          sxc.FPLibErrorCode := FPLibErrorCode;
        raise sxc;
        end;
      end
      else
        raise SException.Create(ServerErr, 'ServerErr', msg, nil);
      end;
end;

{Creates result values corresponding of the result class}
function FP_Core.CreateRes(cls: TClass; resp_xml: IXMLDocument): TObject;
var
  docList: IXMlNodeList;
  AObject: TObject;
  enum: ResEnum;
  DT : TDateTime;
  enumclass: TPersistentClass;
  I, u: integer;
  ival: int64;
  bs64, nameStr, nameStrEnum, val, typeStr: WideString;
  ba: array of byte;
begin
  AObject := cls.NewInstance;
  docList := resp_xml.DocumentElement.ChildNodes;
  try
    for I := 0 to docList.Count - 1 do
    begin
      nameStr := docList[I].Attributes['Name'];
      nameStrEnum := nameStr;
      if cls = DummyCoreObject then
      begin
        nameStr := 'Value';
      end;
      val := docList[I].Attributes['Value'];
      typeStr := docList[I].Attributes['Type'];
      case AnsiIndexText(typeStr, ['DateTime','Flags','Decimal_plus_80h', 'Decimal_with_format', 'Decimal', 'Base64', 'Text', 'Status', 'Option', 'OptionHardcoded' ] ) of
                0: SetPropValue(AObject, nameStr, var2date(val, fpFormat));// VarToDateTime(val));
                   //SetPropValue(AObject, nameStr, DT); //STR2DT(val));//DateTime
                1, // Flags
                6: SetPropValue(AObject, nameStr, val); // Text
                2, 3, 4: SetPropValue(AObject, nameStr, StrToFloat(val, fpFormat)); //Decimal_plus_80h //'Decimal_with_format', //'Decimal'
                5: begin
                       bs64:= IdDecMIME.DecodeString(val);
                       SetLength(ba, Length(bs64));
                       for u := 0 to Length(bs64) - 1 do
                          ba[u] := ord(bs64[u + 1]);
                       SetVariantProp(AObject, nameStr, ba); //'Base64'
                   end;
                
                7: SetPropValue(AObject, nameStr, (val='1')); //Status
                8: begin
                     enumclass := GetClass(nameStrEnum + '_ResEnum');
                     enum :=  enumclass.Create as ResEnum;
                     ival := 0;
                     for u := 1 to length(val) do
                     begin
                        ival := ival + (Ord(val[u]) shr ((u-1)*16));
                     end;
                     enum.Init(ival, val);
                     SetObjectProp(AObject, nameStr, enum);
                   end;
                9: continue; //SetWideStrProp(AObject, nameStr, val); // OptionHardcoded
      end;
    end;
    Result:= AObject;
  except
    on ex : Exception do
      raise SException.Create(ClientCanNotParseResponseXML, 'ClientCanNotParseResponseXML', 'Unable to create result objects', nil)
  end;
end;

{Gets device serial port and TCP/IP communication settings}
function FP_Core.ServerGetSettings(): string;
begin
  Result := sendGETRequest('settings()').XML.Text;
end;

{Finds first device on serial port}
function FP_Core.ServerFindDevice(): TStringList;
var
  res: IXMLDocument;
  device: IXMLNode;
begin
   res:= sendGETRequest('finddevice()');
   device := res.DocumentElement.ChildNodes.First;
   Result := TStringList.Create;
   Result.Add(device.ChildNodes[0].Text);
   Result.Add(device.ChildNodes[1].Text);
end;

{Sets Device serial port communication settings}
procedure FP_Core.ServerSetDeviceSerialPortSettings(serialPort: string; baudRate: integer);
var
  res: IXMLDocument;
begin
  res:= sendGETRequest('settings(com=' + serialPort + ',baud=' + intToStr(baudRate) + ',tcp=0)');
  CheckVersion(res);
end;

{Sets Device TCP/IP communication settings}
procedure FP_Core.ServerSetDeviceTcpSettings( ip: string; tcpPort: integer; password: string);
var
  res: IXMLDocument;
begin
  res:= sendGETRequest('settings(ip=' + ip + ',port=' + intToStr(tcpPort)+ ',password=' + password + ',tcp=1)');
  CheckVersion(res);
end;

{Disconnects from device - this method must be invoked when closing the app or when stop working with the server!}
procedure FP_Core.ServerCloseDeviceConnection;
begin
  sendGETRequest('clientremove(who=me)');
end;

{Remote server restart}
procedure FP_Core.ServerRestart;
begin
  sendGETRequest('restart()');
end;

{Set Log on or off, by default is ON}
procedure FP_Core.ServerSetLog(enable: boolean);
var
  enbl: string;
begin
  if enable then
    enbl := '1'
  else
    enbl := '0';
  sendGETRequest('log(on=' + enbl + ')');
end;

{Returns client log}
function FP_Core.ServerGetLog: string;
begin
  Result := sendGETRequest('log()').XML.Text;
end;

{Returns all clients connected to the server}
function FP_Core.ServerGetClients: string;
begin
  Result := sendGETRequest('clients()').XML.Text;
end;

{Disconnect all clients connected to the server}
procedure FP_Core.ServerRemoveAllClients;
begin
  sendGETRequest('clientremove(who=all)');
end;

{Send xml directly to ZFP server}
function FP_Core.SendRAWRequest(xml: IXMLDocument): IXMLDocument;
begin
  try
    Result := sendPOSTRequest(ServerAddress, xml);
  except
  on ex : Exception do
    raise Exception.Create(ex.Message);
  end;
end;

{Send Client Definitions to ZFP server}
procedure FP_Core.SendDefinitions(defs: IXMLDocument);
    begin
         if not(_definitionsAlreadySent) then begin
                   SendRAWRequest(defs);
                   _definitionsAlreadySent := true;
           end;
    end;



{PRIVATE METHODS}

function FP_Core.sendPOSTRequest(address: String; xml: IXMLDocument): IXMLDocument;
var
  mXML: IXMLDocument;
  stream: TMemoryStream; //Stream: TStringStream;
  response_stream: TMemoryStream;
  //res: string;
begin
  try
    try
      //stream := TStringStream.Create(xml_text);
      stream := TMemoryStream.Create;
      response_stream := TMemoryStream.Create;
      mXML := TXMLDocument.Create(nil);
      xml.SaveToStream(stream);
      // res := lHTTP.Post(address, stream);
      // mXML := LoadXMLData(res);
      lHTTP.Post(address, stream, response_stream);
      mXML.LoadFromStream(response_stream, xetUTF_8);
    except
    on ex : Exception do
      raise SException.Create(ServerConnectionError, 'ServerConnectionError','Server Connection error', ex);
    end;
    if mXML = nil then raise SException.Create(ServerResponseMissing, 'ServerResponseMissing','Server response missing', nil);
    ThrowOnServerError(mXML);
    Result := mXML;
  finally
    stream.Free;
    response_stream.Free;
  end;
end;

function FP_Core.sendGETRequest(request: String): IXMLDocument;
var
  mXML: IXMLDocument;
  res: string;
begin
  try
    res := lHTTP.Get(ServerAddress + request);
    mXML := LoadXmlData(res);
  except
  on ex : Exception do
    raise SException.Create(ServerConnectionError, 'ServerConnectionError','Server Connection error', ex);
  end;
  if mXML = nil then raise SException.Create(ServerResponseMissing, 'ServerResponseMissing','Server response missing', nil);
  ThrowOnServerError(mXML);
  Result := mXML;
end;

procedure FP_Core.CheckVersion(res: IXMLDocument);
var
   defs: string;
begin
     defs := res.DocumentElement.ChildNodes.First.ChildNodes['defVer'].Text;
    if strtofloat(defs) < timestamp then
      begin
        raise SException.Create(ServerDefsMismatch, 'ServerDefsMismatch', 'Server definitions are older than yours', nil);
      end
    else if strtofloat(defs) > timestamp then
      begin
        raise SException.Create(ServerDefsMismatch, 'ServerDefsMismatch', 'Server definitions are newer than yours', nil);
      end;
    end;

function FP_Core.valToString(val: Variant): WideString;
var
  vtype: TVarType;
  p: TBytes;
  ival, mask: int64;
  i, x: integer;
  st: string;
begin
  Result := '';
  vtype := VarType(val);
  case vtype of
       varString: Result := VarToWideStr(val);
       varOleStr: Result := VarToWideStr(val);
       varcurrency: Result := VarToWideStr(val);
       varbyte, varword, varlongword, varint64: //enum
         if val = EmptyEnum then
         begin
         Result := EmptyWideStr;
         end
         else begin
             ival := val;
             for i := 0 to sizeof(ival) - 1 do
               begin
                 mask := $FFFF shl (i*16);
                 if (ival and mask) = 0 then Exit;
                 Result := Result + widechar((ival and mask) shr (i*16));
               end;
          end;
       vardate: Result := FormatDateTime(fpFormat.LongDateFormat + ' ' + fpFormat.LongTimeFormat, val); //date
       vardouble: if val = EmptyDouble  //double (8 bytes)
                  then begin Result := EmptyWideStr; end
                  else begin Result := VarToWideStr(val); end;
       varsingle: Result := VarToWideStr(val); //double (4 bytes)

       varshortint: Result := VarToWideStr(val); //int
       varinteger: Result := VarToWideStr(val); //int
       vararray + varbyte:
          begin
            p := val;
            SetString(st, PAnsiChar(@p[0]), Length(p));
            Result := IdEncMIME.EncodeString(st);
          end;
       varvariant: Result := VarToWideStr(val); //?
       else Result := VarToWideStr(val);
  end;
end;

function FP_Core.fillXMLwithParamValues(commandName: string; data: array of Variant): IXMLDocument;
var
  i, len : Integer;
  v1, v2: Variant;
  s1 : string;
  mXML: IXMLDocument;
  CmdNode, Args, Arg : IXMLNode;
begin
  len := Round(Length(data)/2);
  mXML := NewXMLDocument;
  mXML.Options := [doNodeAutoIndent];
  mXML.Encoding := 'utf-8';
  CmdNode := mXML.AddChild('Command');
  CmdNode.Attributes['Name'] := commandName;
  Args := CmdNode.AddChild('Args');
  for i := 0 to len - 1 do
  begin
    v1:= data[i*2];
    v2:= data[i*2+1];
    s1 := valToString(v2);
    if s1 <> EmptyWideStr then
     begin
      Arg := Args.AddChild('Arg');
      Arg.Attributes['Name'] := VarToStr(v1);
      //Arg.XML := '<Arg Name="' + VarToStr(v1)+ '" Value="' + escapeXmlChars(valToString(v2)) + '" />';
      Arg.Attributes['Value'] := s1//escapeXmlChars(valToString(v2));
     end;
  end;
//  mXML.XML.Text := FormatXMLData(mXML.XML.Text);
  Result := mXml;
end;

function FP_Core.escapeXmlChars(val: string): string;
begin
   Result := val;
   Result := StringReplace(Result, '&', '&amp;',[rfReplaceAll]);
   Result := StringReplace(Result, '<', '&lt;',[rfReplaceAll]);
   Result := StringReplace(Result, '>', '&gt;',[rfReplaceAll]);
   Result := StringReplace(Result, char(10), '&#10;',[rfReplaceAll]);
   Result := StringReplace(Result, char(13), '&#13;',[rfReplaceAll]);
end;

function FP_Core.concatGetMethodStr(commandName: string; data: array of Variant): string;
var
  i, len : Integer;
  v1, v2: Variant;
  res, dataStr: string;

begin
  res := commandName + '(';
  len := Round(Length(data)/2);
  for i := 0 to len - 1 do
  begin
    v1:= data[i*2];
    v2:= data[i*2+1];
    dataStr := dataStr + VarToStr(v1) + '=' + valToString(v2);
    if i = len - 1 then
      begin
        dataStr := dataStr + ')';
      end
    else
      begin
        dataStr := dataStr + ',';
      end;
  end;
  Result := res + dataStr;
end;


function FP_Core.var2date(p: string; format: TFormatSettings): TDateTime;
var
  f: string;
  y, m, d, h, n, s: integer;
  yIx, mIx, dIx, hIx, nIx, sIx: integer;
begin
  f := format.LongDateFormat + ' ' + format.LongTimeFormat;
  y := 0;
  m := 0;
  d := 0;
  h := 0;
  n := 0;
  s := 0;
  yIx := ansipos('yyyy', f);
  mIx := ansipos('mm', f);
  dIx := ansipos('dd', f);
  hIx := ansipos('hh', f);
  nIx := ansipos('nn', f);
  sIx := ansipos('ss', f);

  if(yIx <> 0) then
    begin
      y := strtoint(copy(p, yIx, 4));
    end
  else
    begin
      yIx := ansipos('yy', f);
      if(yIx <> 0) then
        y := strtoint(copy(p, yIx, 2));
  end;
  if(mIx <> 0) then
    m := strtoint(copy(p, mIx, 2));
  if(dIx <> 0) then
    d := strtoint(copy(p, dIx, 2));
  if(hIx <> 0) then
    h := strtoint(copy(p, hIx, 2));
  if(nIx <> 0) then
    n := strtoint(copy(p, nIx, 2));
  if(sIx <> 0) then
    s := strtoint(copy(p, sIx, 2));
  Result := EncodeDateTime(y, m, d, h, n, s, 0);
end;

function FP_Core.getFormat(): TFormatSettings;
begin
  Result := fpFormat
end;

constructor FP_Core.Create();
begin
  self._coreVer := '1.2.1';
  self._emptyEnum := 0;
  self._emptyDouble := -999999989.431666;
end;

class procedure FP_Core.Close();
begin
  lHTTP.Free;
  IdEncMIME.Free;
  IdDecMIME.Free;
end;

class procedure FP_Core.Init;
begin
  IdEncMIME := TIdEncoderMIME.Create(nil);
  IdDecMIME := TidDecoderMIME.Create(nil);
  lHTTP := TIdHTTP.Create(nil);
  lHTTP.Request.ContentType := 'application/xml';
  //lHTTP.Response.ContentType := 'text/xml';
  lHTTP.Request.ContentEncoding := 'utf-8';
  // SWN: serverul ZFPLab poate fi pe alt calculator din retea. Fara timeout-uri Indy
  // asteapta la infinit si aplicatia se blocheaza cind acel calculator este oprit.
  // ReadTimeout este mare pentru ca raportul Z poate dura zeci de secunde.
  lHTTP.ConnectTimeout := 4000;
  lHTTP.ReadTimeout := 60000;
  fpFormat.DateSeparator := '-';
  fpFormat.TimeSeparator := ':';
  fpFormat.LongDateFormat:='dd-mm-yyyy';
  fpFormat.ShortDateFormat := 'dd-mm-yy';
  fpFormat.LongTimeFormat := 'hh:nn:ss';
  fpFormat.ShortTimeFormat := 'hh:nn:ss';
  fpFormat.DecimalSeparator  := '.';
  fpFormat.CurrencyDecimals  := 3;
  fpFormat.ThousandSeparator := ' ';
end;

constructor SException.Create(err_type: SErrorType; ErrorTypeString: string; message_internal: string; inner_ex: Exception);
begin
  self.ErrType :=  err_type;
  self.msg_internal := message_internal;
  self.ErrTypeString := ErrorTypeString;

  if inner_ex <> nil then
    self.in_ex := inner_ex;
end;

function SException.IsFiscalPrinterError(): boolean;
begin
  Result := (self.ErrType = FPException);
end;

function SException.GetMessage: string;
begin
  if in_ex <> nil then
    begin
      inner_ex_msg := in_ex.Message;
    end
  else
    begin
      inner_ex_msg := '' ;
    end;
  if ErrTypeString <> '' then
    begin
      ErrTypeString :=  ' - ' + ErrTypeString;
    end;
  Result := 'ErrCode: ' +  inttostr(ord(errType)) + ErrTypeString + #13#10 + msg_internal + #13#10 + inner_ex_msg;
end;

initialization
  FP_Core.Init;

finalization
  FP_Core.Close;

end.


