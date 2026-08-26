// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl
//  >Import : https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl>0
//  >Import : https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl>1
// Encoding : UTF-8
// Version  : 1.0
// (29.09.2020 13:20:00 - - $Rev: 90173 $)
// ************************************************************************ //

unit b2b;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_ATTR = $0010;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Ultra_B2B_Response             = class;                 { "http://ultra.b2b.md"[GblCplx] }
  UltraOrder                     = class;                 { "http://ultra.b2b.md"[GblCplx] }

  ArrayOfUltra_b2b_Response = array Of Ultra_B2B_Response;

  {$SCOPEDENUMS ON}
  {$SCOPEDENUMS OFF}



  // ************************************************************************ //
  // XML       : Ultra_B2B_Response, global, <complexType>
  // Namespace : http://ultra.b2b.md
  // ************************************************************************ //
  Ultra_B2B_Response = class(TRemotable)
  private
    Fdata: string;
    Fdata_Specified: boolean;
    Fmessage_: string;
    Fmessage__Specified: boolean;
    procedure Setdata(Index: Integer; const Astring: string);
    function  data_Specified(Index: Integer): boolean;
    procedure Setmessage_(Index: Integer; const Astring: string);
    function  message__Specified(Index: Integer): boolean;
  published
    property data:     string  Index (IS_OPTN or IS_NLBL) read Fdata write Setdata stored data_Specified;
    property message_: string  Index (IS_OPTN or IS_NLBL) read Fmessage_ write Setmessage_ stored message__Specified;
  end;

  orderList  = array of UltraOrder;                  { "http://ultra.b2b.md"[GblCplx] }


  // ************************************************************************ //
  // XML       : UltraOrder, global, <complexType>
  // Namespace : http://ultra.b2b.md
  // ************************************************************************ //
  UltraOrder = class(TRemotable)
  private
    FUUIDLine: string;
    Fclient: string;
    Fdate: TXSDateTime;
    Fnomenclature: string;
    Fcharacteristic: string;
    Fcharacteristic_Specified: boolean;
    Fquantity: Single;
    Fprice: Single;
    Fsum: Single;
    Fsum_Specified: boolean;
    FUUIDOrder: string;
    FUUIDOrder_Specified: boolean;
    Freserve: Boolean;
    Freserve_Specified: boolean;
    Fconfirmed: Boolean;
    Fconfirmed_Specified: boolean;
    Fshipped: Boolean;
    Fshipped_Specified: boolean;
    Ftext: string;
    Ftext_Specified: boolean;
    Fcanceled: Boolean;
    Fdelivery: Boolean;
    Fdelivery_Specified: boolean;
    FplannedDate: TXSDateTime;
    FplannedDate_Specified: boolean;
    FreserveDate: TXSDateTime;
    FreserveDate_Specified: boolean;
    procedure Setcharacteristic(Index: Integer; const Astring: string);
    function  characteristic_Specified(Index: Integer): boolean;
    procedure Setsum(Index: Integer; const ASingle: Single);
    function  sum_Specified(Index: Integer): boolean;
    procedure SetUUIDOrder(Index: Integer; const Astring: string);
    function  UUIDOrder_Specified(Index: Integer): boolean;
    procedure Setreserve(Index: Integer; const ABoolean: Boolean);
    function  reserve_Specified(Index: Integer): boolean;
    procedure Setconfirmed(Index: Integer; const ABoolean: Boolean);
    function  confirmed_Specified(Index: Integer): boolean;
    procedure Setshipped(Index: Integer; const ABoolean: Boolean);
    function  shipped_Specified(Index: Integer): boolean;
    procedure Settext(Index: Integer; const Astring: string);
    function  text_Specified(Index: Integer): boolean;
    procedure Setdelivery(Index: Integer; const ABoolean: Boolean);
    function  delivery_Specified(Index: Integer): boolean;
    procedure SetplannedDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  plannedDate_Specified(Index: Integer): boolean;
    procedure SetreserveDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  reserveDate_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property UUIDLine:       string       read FUUIDLine write FUUIDLine;
    property client:         string       Index (IS_NLBL) read Fclient write Fclient;
    property date:           TXSDateTime  read Fdate write Fdate;
    property nomenclature:   string       read Fnomenclature write Fnomenclature;
    property characteristic: string       Index (IS_OPTN or IS_NLBL) read Fcharacteristic write Setcharacteristic stored characteristic_Specified;
    property quantity:       Single       read Fquantity write Fquantity;
    property price:          Single       read Fprice write Fprice;
    property sum:            Single       Index (IS_OPTN or IS_NLBL) read Fsum write Setsum stored sum_Specified;
    property UUIDOrder:      string       Index (IS_OPTN or IS_NLBL) read FUUIDOrder write SetUUIDOrder stored UUIDOrder_Specified;
    property reserve:        Boolean      Index (IS_OPTN) read Freserve write Setreserve stored reserve_Specified;
    property confirmed:      Boolean      Index (IS_OPTN) read Fconfirmed write Setconfirmed stored confirmed_Specified;
    property shipped:        Boolean      Index (IS_OPTN or IS_NLBL) read Fshipped write Setshipped stored shipped_Specified;
    property text:           string       Index (IS_OPTN or IS_NLBL) read Ftext write Settext stored text_Specified;
    property canceled:       Boolean      read Fcanceled write Fcanceled;
    property delivery:       Boolean      Index (IS_OPTN or IS_NLBL) read Fdelivery write Setdelivery stored delivery_Specified;
    property plannedDate:    TXSDateTime  Index (IS_OPTN or IS_NLBL) read FplannedDate write SetplannedDate stored plannedDate_Specified;
    property reserveDate:    TXSDateTime  Index (IS_OPTN or IS_NLBL) read FreserveDate write SetreserveDate stored reserveDate_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://ultra.b2b.md
  // soapAction: http://ultra.b2b.md#b2b:%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : b2bSoapBinding
  // service   : b2b
  // port      : b2bSoap
  // URL       : https://web1c.it-ultra.com/b2b/ws/b2b.1cws
  // ************************************************************************ //
  b2bPortType = interface(IInvokable)
  ['{CDF850DB-89B4-83B9-C4A4-4B11EBC4EEEC}']
    function  requestData(const Service: string; const all: Boolean; const additionalParameters: string; const compress: Boolean): string; stdcall;
    function  putData(const Service: string; const data: string): Ultra_B2B_Response; stdcall;
    function  CommitReceivingData(const Service: string): Boolean; stdcall;
    function  testService: string; stdcall;
    function  putOrder(const orderList: orderList): Boolean; stdcall;
    function  getDataByID(const ID: string): Ultra_B2B_Response; stdcall;
    function  isReady(const ID: string): Boolean; stdcall;
  end;

function Getb2bPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): b2bPortType;


implementation
  uses System.SysUtils;

function Getb2bPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): b2bPortType;
const
  defWSDL = 'https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl';
  defURL  = 'https://web1c.it-ultra.com/b2b/ws/b2b.1cws';
  defSvc  = 'b2b';
  defPrt  = 'b2bSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as b2bPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure Ultra_B2B_Response.Setdata(Index: Integer; const Astring: string);
begin
  Fdata := Astring;
  Fdata_Specified := True;
end;

function Ultra_B2B_Response.data_Specified(Index: Integer): boolean;
begin
  Result := Fdata_Specified;
end;

procedure Ultra_B2B_Response.Setmessage_(Index: Integer; const Astring: string);
begin
  Fmessage_ := Astring;
  Fmessage__Specified := True;
end;

function Ultra_B2B_Response.message__Specified(Index: Integer): boolean;
begin
  Result := Fmessage__Specified;
end;

destructor UltraOrder.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdate);
  System.SysUtils.FreeAndNil(FplannedDate);
  System.SysUtils.FreeAndNil(FreserveDate);
  inherited Destroy;
end;

procedure UltraOrder.Setcharacteristic(Index: Integer; const Astring: string);
begin
  Fcharacteristic := Astring;
  Fcharacteristic_Specified := True;
end;

function UltraOrder.characteristic_Specified(Index: Integer): boolean;
begin
  Result := Fcharacteristic_Specified;
end;

procedure UltraOrder.Setsum(Index: Integer; const ASingle: Single);
begin
  Fsum := ASingle;
  Fsum_Specified := True;
end;

function UltraOrder.sum_Specified(Index: Integer): boolean;
begin
  Result := Fsum_Specified;
end;

procedure UltraOrder.SetUUIDOrder(Index: Integer; const Astring: string);
begin
  FUUIDOrder := Astring;
  FUUIDOrder_Specified := True;
end;

function UltraOrder.UUIDOrder_Specified(Index: Integer): boolean;
begin
  Result := FUUIDOrder_Specified;
end;

procedure UltraOrder.Setreserve(Index: Integer; const ABoolean: Boolean);
begin
  Freserve := ABoolean;
  Freserve_Specified := True;
end;

function UltraOrder.reserve_Specified(Index: Integer): boolean;
begin
  Result := Freserve_Specified;
end;

procedure UltraOrder.Setconfirmed(Index: Integer; const ABoolean: Boolean);
begin
  Fconfirmed := ABoolean;
  Fconfirmed_Specified := True;
end;

function UltraOrder.confirmed_Specified(Index: Integer): boolean;
begin
  Result := Fconfirmed_Specified;
end;

procedure UltraOrder.Setshipped(Index: Integer; const ABoolean: Boolean);
begin
  Fshipped := ABoolean;
  Fshipped_Specified := True;
end;

function UltraOrder.shipped_Specified(Index: Integer): boolean;
begin
  Result := Fshipped_Specified;
end;

procedure UltraOrder.Settext(Index: Integer; const Astring: string);
begin
  Ftext := Astring;
  Ftext_Specified := True;
end;

function UltraOrder.text_Specified(Index: Integer): boolean;
begin
  Result := Ftext_Specified;
end;

procedure UltraOrder.Setdelivery(Index: Integer; const ABoolean: Boolean);
begin
  Fdelivery := ABoolean;
  Fdelivery_Specified := True;
end;

function UltraOrder.delivery_Specified(Index: Integer): boolean;
begin
  Result := Fdelivery_Specified;
end;

procedure UltraOrder.SetplannedDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FplannedDate := ATXSDateTime;
  FplannedDate_Specified := True;
end;

function UltraOrder.plannedDate_Specified(Index: Integer): boolean;
begin
  Result := FplannedDate_Specified;
end;

procedure UltraOrder.SetreserveDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FreserveDate := ATXSDateTime;
  FreserveDate_Specified := True;
end;

function UltraOrder.reserveDate_Specified(Index: Integer): boolean;
begin
  Result := FreserveDate_Specified;
end;

initialization
  { b2bPortType }
  InvRegistry.RegisterInterface(TypeInfo(b2bPortType), 'http://ultra.b2b.md', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(b2bPortType), 'http://ultra.b2b.md#b2b:%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(b2bPortType), ioDocument);
  { b2bPortType.requestData }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'requestData', '',
                                 '[ReturnName="return"]');
  InvRegistry.RegisterParamInfo(TypeInfo(b2bPortType), 'requestData', 'all', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(b2bPortType), 'requestData', 'additionalParameters', '',
                                '', IS_NLBL);
  { b2bPortType.putData }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'putData', '',
                                 '[ReturnName="return"]');
  { b2bPortType.CommitReceivingData }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'CommitReceivingData', '',
                                 '[ReturnName="return"]');
  { b2bPortType.testService }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'testService', '',
                                 '[ReturnName="return"]', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(b2bPortType), 'testService', 'return', '',
                                '', IS_NLBL);
  { b2bPortType.putOrder }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'putOrder', '',
                                 '[ReturnName="return"]');
  InvRegistry.RegisterParamInfo(TypeInfo(b2bPortType), 'putOrder', 'orderList', '',
                                '[ArrayItemName="UltraOrder"]');
  { b2bPortType.getDataByID }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'getDataByID', '',
                                 '[ReturnName="return"]');
  { b2bPortType.isReady }
  InvRegistry.RegisterMethodInfo(TypeInfo(b2bPortType), 'isReady', '',
                                 '[ReturnName="return"]');
  RemClassRegistry.RegisterXSClass(Ultra_B2B_Response, 'http://ultra.b2b.md', 'Ultra_B2B_Response');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Ultra_B2B_Response), 'message_', '[ExtName="message"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(orderList), 'http://ultra.b2b.md', 'orderList');
  RemClassRegistry.RegisterXSClass(UltraOrder, 'http://ultra.b2b.md', 'UltraOrder');

end.