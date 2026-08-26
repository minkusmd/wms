// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://sift-testmev.sfs.md/api/ASV.wsdl
//  >Import : https://sift-testmev.sfs.md/api/ASV.wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (31.01.2022 14:46:46 - - $Rev: 106319 $)
// ************************************************************************ //

unit ASV1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  year                 = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  turnovers            = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field                = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  card                 = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  addServiceReceipt    = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Lit][GblElm] }
  receipt              = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  client               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  card2                = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  addFiscalReceipt     = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Lit][GblElm] }
  field2               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field3               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field4               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  error                = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  globalResponse       = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Lit][GblElm] }
  field5               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field6               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field7               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field8               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field9               = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field10              = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  addReport            = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Lit][GblElm] }
  card3                = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  reports              = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  daily                = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field11              = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  activity             = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  field12              = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  tax                  = class;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }

  introduces = array of field9;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  issues     = array of field8;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  additionally = array of field4;               { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  rates      = array of field6;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  receipts   = array of field;                  { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  errors     = array of error;                  { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  sells      = array of field5;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  commissions = array of field3;                { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  buys       = array of field2;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  drawers    = array of field7;                 { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }


  // ************************************************************************ //
  // XML       : year, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  year = class(TRemotable)
  private
    FA: Double;
    FA_Specified: boolean;
    FB: Double;
    FB_Specified: boolean;
    procedure SetA(Index: Integer; const ADouble: Double);
    function  A_Specified(Index: Integer): boolean;
    procedure SetB(Index: Integer; const ADouble: Double);
    function  B_Specified(Index: Integer): boolean;
  published
    property A: Double  Index (IS_OPTN or IS_UNQL) read FA write SetA stored A_Specified;
    property B: Double  Index (IS_OPTN or IS_UNQL) read FB write SetB stored B_Specified;
  end;



  // ************************************************************************ //
  // XML       : turnovers, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  turnovers = class(TRemotable)
  private
    FA: Double;
    FB: Double;
  published
    property A: Double  Index (IS_UNQL) read FA write FA;
    property B: Double  Index (IS_UNQL) read FB write FB;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field = class(TRemotable)
  private
    Ftype_: Int64;
    Famount: Int64;
  published
    property type_:  Int64  Index (IS_UNQL) read Ftype_ write Ftype_;
    property amount: Int64  Index (IS_UNQL) read Famount write Famount;
  end;



  // ************************************************************************ //
  // XML       : card, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  card = class(TRemotable)
  private
    Ftype_: Int64;
    Ffactory: string;
    Fnumber: string;
    Fmodel: string;
    Fidnx: string;
    Fname_: string;
    Faddress: string;
    Fkey: string;
  published
    property type_:   Int64   Index (IS_UNQL) read Ftype_ write Ftype_;
    property factory: string  Index (IS_UNQL) read Ffactory write Ffactory;
    property number:  string  Index (IS_UNQL) read Fnumber write Fnumber;
    property model:   string  Index (IS_UNQL) read Fmodel write Fmodel;
    property idnx:    string  Index (IS_UNQL) read Fidnx write Fidnx;
    property name_:   string  Index (IS_UNQL) read Fname_ write Fname_;
    property address: string  Index (IS_UNQL) read Faddress write Faddress;
    property key:     string  Index (IS_UNQL) read Fkey write Fkey;
  end;



  // ************************************************************************ //
  // XML       : addServiceReceipt, global, <element>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  addServiceReceipt = class(TRemotable)
  private
    Fid: Int64;
    Freport: Int64;
    Freport_Specified: boolean;
    Fdatetime: TXSDateTime;
    Fcard: card;
    Freceipt: receipt;
    Fextra: string;
    Fextra_Specified: boolean;
    procedure Setreport(Index: Integer; const AInt64: Int64);
    function  report_Specified(Index: Integer): boolean;
    procedure Setextra(Index: Integer; const Astring: string);
    function  extra_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id:       Int64        Index (IS_UNQL) read Fid write Fid;
    property report:   Int64        Index (IS_OPTN or IS_UNQL) read Freport write Setreport stored report_Specified;
    property datetime: TXSDateTime  Index (IS_UNQL) read Fdatetime write Fdatetime;
    property card:     card         Index (IS_UNQL) read Fcard write Fcard;
    property receipt:  receipt      Index (IS_UNQL) read Freceipt write Freceipt;
    property extra:    string       Index (IS_OPTN or IS_UNQL) read Fextra write Setextra stored extra_Specified;
  end;



  // ************************************************************************ //
  // XML       : receipt, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  receipt = class(TRemotable)
  private
    Ftype_: Int64;
    Fname_: string;
    Ftotal: Double;
  published
    property type_: Int64   Index (IS_UNQL) read Ftype_ write Ftype_;
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property total: Double  Index (IS_UNQL) read Ftotal write Ftotal;
  end;



  // ************************************************************************ //
  // XML       : client, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  client = class(TRemotable)
  private
    Fidnx: string;
    Fidnx_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    Faddress: string;
    Faddress_Specified: boolean;
    procedure Setidnx(Index: Integer; const Astring: string);
    function  idnx_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setaddress(Index: Integer; const Astring: string);
    function  address_Specified(Index: Integer): boolean;
  published
    property idnx:    string  Index (IS_OPTN or IS_UNQL) read Fidnx write Setidnx stored idnx_Specified;
    property name_:   string  Index (IS_OPTN or IS_UNQL) read Fname_ write Setname_ stored name__Specified;
    property address: string  Index (IS_OPTN or IS_UNQL) read Faddress write Setaddress stored address_Specified;
  end;



  // ************************************************************************ //
  // XML       : card, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  card2 = class(TRemotable)
  private
    Ftype_: Int64;
    Ffactory: string;
    Fnumber: string;
    Fmodel: string;
    Fidnx: string;
    Fname_: string;
    Faddress: string;
    Fkey: string;
  published
    property type_:   Int64   Index (IS_UNQL) read Ftype_ write Ftype_;
    property factory: string  Index (IS_UNQL) read Ffactory write Ffactory;
    property number:  string  Index (IS_UNQL) read Fnumber write Fnumber;
    property model:   string  Index (IS_UNQL) read Fmodel write Fmodel;
    property idnx:    string  Index (IS_UNQL) read Fidnx write Fidnx;
    property name_:   string  Index (IS_UNQL) read Fname_ write Fname_;
    property address: string  Index (IS_UNQL) read Faddress write Faddress;
    property key:     string  Index (IS_UNQL) read Fkey write Fkey;
  end;



  // ************************************************************************ //
  // XML       : addFiscalReceipt, global, <element>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  addFiscalReceipt = class(TRemotable)
  private
    Fid: Int64;
    Freport: Int64;
    Fdatetime: TXSDateTime;
    Fcard: card2;
    Fclient: client;
    Fclient_Specified: boolean;
    Factivity: activity;
    Fextras: string;
    Fextras_Specified: boolean;
    procedure Setclient(Index: Integer; const Aclient: client);
    function  client_Specified(Index: Integer): boolean;
    procedure Setextras(Index: Integer; const Astring: string);
    function  extras_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id:       Int64        Index (IS_UNQL) read Fid write Fid;
    property report:   Int64        Index (IS_UNQL) read Freport write Freport;
    property datetime: TXSDateTime  Index (IS_UNQL) read Fdatetime write Fdatetime;
    property card:     card2        Index (IS_UNQL) read Fcard write Fcard;
    property client:   client       Index (IS_OPTN or IS_UNQL) read Fclient write Setclient stored client_Specified;
    property activity: activity     Index (IS_UNQL) read Factivity write Factivity;
    property extras:   string       Index (IS_OPTN or IS_UNQL) read Fextras write Setextras stored extras_Specified;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field2 = class(TRemotable)
  private
    Fname_: string;
    Fccy: Double;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property ccy:   Double  Index (IS_UNQL) read Fccy write Fccy;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field3 = class(TRemotable)
  private
    Ftype_: string;
    Fcount: Int64;
    Fcash: Double;
  published
    property type_: string  Index (IS_UNQL) read Ftype_ write Ftype_;
    property count: Int64   Index (IS_UNQL) read Fcount write Fcount;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field4 = class(TRemotable)
  private
    Fname_: string;
    Fcount: Int64;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property count: Int64   Index (IS_UNQL) read Fcount write Fcount;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : error, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  error = class(TRemotable)
  private
    Frow: string;
    Fmessage_: string;
  published
    property row:      string  Index (IS_UNQL) read Frow write Frow;
    property message_: string  Index (IS_UNQL) read Fmessage_ write Fmessage_;
  end;



  // ************************************************************************ //
  // XML       : globalResponse, global, <element>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  globalResponse = class(TRemotable)
  private
    Fid: string;
    Fcode: Int64;
    Fstate: string;
    Fcomment: string;
    Ferrors: errors;
    Ferrors_Specified: boolean;
    procedure Seterrors(Index: Integer; const Aerrors: errors);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id:      string  Index (IS_UNQL) read Fid write Fid;
    property code:    Int64   Index (IS_UNQL) read Fcode write Fcode;
    property state:   string  Index (IS_UNQL) read Fstate write Fstate;
    property comment: string  Index (IS_UNQL) read Fcomment write Fcomment;
    property errors:  errors  Index (IS_OPTN or IS_UNQL) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field5 = class(TRemotable)
  private
    Fname_: string;
    Fccy: Double;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property ccy:   Double  Index (IS_UNQL) read Fccy write Fccy;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field6 = class(TRemotable)
  private
    Fname_: string;
    Frate_C: Double;
    Frate_V: Double;
  published
    property name_:  string  Index (IS_UNQL) read Fname_ write Fname_;
    property rate_C: Double  Index (IS_UNQL) read Frate_C write Frate_C;
    property rate_V: Double  Index (IS_UNQL) read Frate_V write Frate_V;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field7 = class(TRemotable)
  private
    Fname_: string;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field8 = class(TRemotable)
  private
    Fname_: string;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field9 = class(TRemotable)
  private
    Fname_: string;
    Fcash: Double;
  published
    property name_: string  Index (IS_UNQL) read Fname_ write Fname_;
    property cash:  Double  Index (IS_UNQL) read Fcash write Fcash;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field10 = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    Fpercent: Double;
    Fpercent_Specified: boolean;
    Frate: Double;
    Frate_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure Setpercent(Index: Integer; const ADouble: Double);
    function  percent_Specified(Index: Integer): boolean;
    procedure Setrate(Index: Integer; const ADouble: Double);
    function  rate_Specified(Index: Integer): boolean;
  published
    property code:    string  Index (IS_OPTN or IS_UNQL) read Fcode write Setcode stored code_Specified;
    property percent: Double  Index (IS_OPTN or IS_UNQL) read Fpercent write Setpercent stored percent_Specified;
    property rate:    Double  Index (IS_OPTN or IS_UNQL) read Frate write Setrate stored rate_Specified;
  end;



  // ************************************************************************ //
  // XML       : addReport, global, <element>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  addReport = class(TRemotable)
  private
    Fid: Int64;
    Ftype_: Int64;
    Freport: Int64;
    Fmemory: string;
    Fmemory_Specified: boolean;
    Fdatetime: TXSDateTime;
    Fcard: card3;
    Freports: reports;
    Fextras: string;
    Fextras_Specified: boolean;
    procedure Setmemory(Index: Integer; const Astring: string);
    function  memory_Specified(Index: Integer): boolean;
    procedure Setextras(Index: Integer; const Astring: string);
    function  extras_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id:       Int64        Index (IS_UNQL) read Fid write Fid;
    property type_:    Int64        Index (IS_UNQL) read Ftype_ write Ftype_;
    property report:   Int64        Index (IS_UNQL) read Freport write Freport;
    property memory:   string       Index (IS_OPTN or IS_UNQL) read Fmemory write Setmemory stored memory_Specified;
    property datetime: TXSDateTime  Index (IS_UNQL) read Fdatetime write Fdatetime;
    property card:     card3        Index (IS_UNQL) read Fcard write Fcard;
    property reports:  reports      Index (IS_UNQL) read Freports write Freports;
    property extras:   string       Index (IS_OPTN or IS_UNQL) read Fextras write Setextras stored extras_Specified;
  end;



  // ************************************************************************ //
  // XML       : card, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  card3 = class(TRemotable)
  private
    Ftype_: Int64;
    Ffactory: string;
    Fnumber: string;
    Fmodel: string;
    Fidnx: string;
    Fname_: string;
    Faddress: string;
    Fkey: string;
  published
    property type_:   Int64   Index (IS_UNQL) read Ftype_ write Ftype_;
    property factory: string  Index (IS_UNQL) read Ffactory write Ffactory;
    property number:  string  Index (IS_UNQL) read Fnumber write Fnumber;
    property model:   string  Index (IS_UNQL) read Fmodel write Fmodel;
    property idnx:    string  Index (IS_UNQL) read Fidnx write Fidnx;
    property name_:   string  Index (IS_UNQL) read Fname_ write Fname_;
    property address: string  Index (IS_UNQL) read Faddress write Faddress;
    property key:     string  Index (IS_UNQL) read Fkey write Fkey;
  end;



  // ************************************************************************ //
  // XML       : reports, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  reports = class(TRemotable)
  private
    Fdaily: daily;
    Fyear: year;
    Fyear_Specified: boolean;
    procedure Setyear(Index: Integer; const Ayear: year);
    function  year_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property daily: daily  Index (IS_UNQL) read Fdaily write Fdaily;
    property year:  year   Index (IS_OPTN or IS_UNQL) read Fyear write Setyear stored year_Specified;
  end;



  // ************************************************************************ //
  // XML       : daily, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  daily = class(TRemotable)
  private
    Fdrawers: drawers;
    Frates: rates;
    Fturnovers: turnovers;
    Freceipts: receipts;
    Fintroduces: introduces;
    Fissues: issues;
    Fbalance: Double;
    Fbalance_Specified: boolean;
    Fadditionally: additionally;
    Fcommissions: commissions;
    Fcommissions_Specified: boolean;
    Fbuys: buys;
    Fsells: sells;
    procedure Setbalance(Index: Integer; const ADouble: Double);
    function  balance_Specified(Index: Integer): boolean;
    procedure Setcommissions(Index: Integer; const Acommissions: commissions);
    function  commissions_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property drawers:      drawers       Index (IS_UNQL) read Fdrawers write Fdrawers;
    property rates:        rates         Index (IS_UNQL) read Frates write Frates;
    property turnovers:    turnovers     Index (IS_UNQL) read Fturnovers write Fturnovers;
    property receipts:     receipts      Index (IS_UNQL) read Freceipts write Freceipts;
    property introduces:   introduces    Index (IS_UNQL) read Fintroduces write Fintroduces;
    property issues:       issues        Index (IS_UNQL) read Fissues write Fissues;
    property balance:      Double        Index (IS_OPTN or IS_UNQL) read Fbalance write Setbalance stored balance_Specified;
    property additionally: additionally  Index (IS_UNQL) read Fadditionally write Fadditionally;
    property commissions:  commissions   Index (IS_OPTN or IS_UNQL) read Fcommissions write Setcommissions stored commissions_Specified;
    property buys:         buys          Index (IS_UNQL) read Fbuys write Fbuys;
    property sells:        sells         Index (IS_UNQL) read Fsells write Fsells;
  end;

  taxes      = array of field10;                { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }
  payments   = array of field11;                { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }


  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field11 = class(TRemotable)
  private
    Ftype_: string;
  published
    property type_: string  Index (IS_UNQL) read Ftype_ write Ftype_;
  end;

  activities = array of field12;                { "https://sift-testmev.sfs.md/api/ASV/"[Cplx] }


  // ************************************************************************ //
  // XML       : activity, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  activity = class(TRemotable)
  private
    Ftotal: Double;
    Fdeposit: string;
    Fdeposit_Specified: boolean;
    Fpayments: payments;
    Factivities: activities;
    Ftaxes: taxes;
    Ftaxes_Specified: boolean;
    procedure Setdeposit(Index: Integer; const Astring: string);
    function  deposit_Specified(Index: Integer): boolean;
    procedure Settaxes(Index: Integer; const Ataxes: taxes);
    function  taxes_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property total:      Double      Index (IS_UNQL) read Ftotal write Ftotal;
    property deposit:    string      Index (IS_OPTN or IS_UNQL) read Fdeposit write Setdeposit stored deposit_Specified;
    property payments:   payments    Index (IS_UNQL) read Fpayments write Fpayments;
    property activities: activities  Index (IS_UNQL) read Factivities write Factivities;
    property taxes:      taxes       Index (IS_OPTN or IS_UNQL) read Ftaxes write Settaxes stored taxes_Specified;
  end;



  // ************************************************************************ //
  // XML       : field, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  field12 = class(TRemotable)
  private
    Fname_: string;
    Ftype_: Int64;
    Famount: Double;
    Frate: Double;
    Ftotal: Double;
    Fcost: Double;
    Fsurcharge_percent: Double;
    Fsurcharge: Double;
    Fcommission_percent: Double;
    Fcommission: Double;
    Ftax: tax;
  public
    destructor Destroy; override;
  published
    property name_:              string  Index (IS_UNQL) read Fname_ write Fname_;
    property type_:              Int64   Index (IS_UNQL) read Ftype_ write Ftype_;
    property amount:             Double  Index (IS_UNQL) read Famount write Famount;
    property rate:               Double  Index (IS_UNQL) read Frate write Frate;
    property total:              Double  Index (IS_UNQL) read Ftotal write Ftotal;
    property cost:               Double  Index (IS_UNQL) read Fcost write Fcost;
    property surcharge_percent:  Double  Index (IS_UNQL) read Fsurcharge_percent write Fsurcharge_percent;
    property surcharge:          Double  Index (IS_UNQL) read Fsurcharge write Fsurcharge;
    property commission_percent: Double  Index (IS_UNQL) read Fcommission_percent write Fcommission_percent;
    property commission:         Double  Index (IS_UNQL) read Fcommission write Fcommission;
    property tax:                tax     Index (IS_UNQL) read Ftax write Ftax;
  end;



  // ************************************************************************ //
  // XML       : tax, <complexType>
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  tax = class(TRemotable)
  private
    Fcode: string;
    Fpercent: Double;
    Fpercent_Specified: boolean;
    Frate: Double;
    Frate_Specified: boolean;
    procedure Setpercent(Index: Integer; const ADouble: Double);
    function  percent_Specified(Index: Integer): boolean;
    procedure Setrate(Index: Integer; const ADouble: Double);
    function  rate_Specified(Index: Integer): boolean;
  published
    property code:    string  Index (IS_UNQL) read Fcode write Fcode;
    property percent: Double  Index (IS_OPTN or IS_UNQL) read Fpercent write Setpercent stored percent_Specified;
    property rate:    Double  Index (IS_OPTN or IS_UNQL) read Frate write Setrate stored rate_Specified;
  end;


  // ************************************************************************ //
  // Namespace : https://sift-testmev.sfs.md/api/ASV/
  // soapAction: |https://sift-testmev.sfs.md/api/ASV/addServiceReceipt|https://sift-testmev.sfs.md/api/ASV/addFiscalReceipt|https://sift-testmev.sfs.md/api/ASV/addReport|https://sift-testmev.sfs.md/api/ASV/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ASV
  // service   : ASV
  // port      : ASV
  // URL       : https://sift-testmev.sfs.md/api/ASV/
  // ************************************************************************ //
  ASV = interface(IInvokable)
  ['{0F65C7BB-B975-328F-E45A-0B3641CC0A4A}']

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  addServiceReceipt(const parameters: addServiceReceipt): globalResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  addFiscalReceipt(const parameters: addFiscalReceipt): globalResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  addReport(const parameters: addReport): globalResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  exception: globalResponse; stdcall;
  end;

function GetASV(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ASV;


implementation
  uses System.SysUtils;

function GetASV(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ASV;
const
  defWSDL = 'https://sift-testmev.sfs.md/api/ASV.wsdl';
  defURL  = 'https://sift-testmev.sfs.md/api/ASV/';
  defSvc  = 'ASV';
  defPrt  = 'ASV';
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
    Result := (RIO as ASV);
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


procedure year.SetA(Index: Integer; const ADouble: Double);
begin
  FA := ADouble;
  FA_Specified := True;
end;

function year.A_Specified(Index: Integer): boolean;
begin
  Result := FA_Specified;
end;

procedure year.SetB(Index: Integer; const ADouble: Double);
begin
  FB := ADouble;
  FB_Specified := True;
end;

function year.B_Specified(Index: Integer): boolean;
begin
  Result := FB_Specified;
end;

constructor addServiceReceipt.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor addServiceReceipt.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdatetime);
  System.SysUtils.FreeAndNil(Fcard);
  System.SysUtils.FreeAndNil(Freceipt);
  inherited Destroy;
end;

procedure addServiceReceipt.Setreport(Index: Integer; const AInt64: Int64);
begin
  Freport := AInt64;
  Freport_Specified := True;
end;

function addServiceReceipt.report_Specified(Index: Integer): boolean;
begin
  Result := Freport_Specified;
end;

procedure addServiceReceipt.Setextra(Index: Integer; const Astring: string);
begin
  Fextra := Astring;
  Fextra_Specified := True;
end;

function addServiceReceipt.extra_Specified(Index: Integer): boolean;
begin
  Result := Fextra_Specified;
end;

procedure client.Setidnx(Index: Integer; const Astring: string);
begin
  Fidnx := Astring;
  Fidnx_Specified := True;
end;

function client.idnx_Specified(Index: Integer): boolean;
begin
  Result := Fidnx_Specified;
end;

procedure client.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function client.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure client.Setaddress(Index: Integer; const Astring: string);
begin
  Faddress := Astring;
  Faddress_Specified := True;
end;

function client.address_Specified(Index: Integer): boolean;
begin
  Result := Faddress_Specified;
end;

constructor addFiscalReceipt.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor addFiscalReceipt.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdatetime);
  System.SysUtils.FreeAndNil(Fcard);
  System.SysUtils.FreeAndNil(Fclient);
  System.SysUtils.FreeAndNil(Factivity);
  inherited Destroy;
end;

procedure addFiscalReceipt.Setclient(Index: Integer; const Aclient: client);
begin
  Fclient := Aclient;
  Fclient_Specified := True;
end;

function addFiscalReceipt.client_Specified(Index: Integer): boolean;
begin
  Result := Fclient_Specified;
end;

procedure addFiscalReceipt.Setextras(Index: Integer; const Astring: string);
begin
  Fextras := Astring;
  Fextras_Specified := True;
end;

function addFiscalReceipt.extras_Specified(Index: Integer): boolean;
begin
  Result := Fextras_Specified;
end;

constructor globalResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor globalResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Ferrors)-1 do
    System.SysUtils.FreeAndNil(Ferrors[I]);
  System.SetLength(Ferrors, 0);
  inherited Destroy;
end;

procedure globalResponse.Seterrors(Index: Integer; const Aerrors: errors);
begin
  Ferrors := Aerrors;
  Ferrors_Specified := True;
end;

function globalResponse.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

procedure field10.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function field10.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure field10.Setpercent(Index: Integer; const ADouble: Double);
begin
  Fpercent := ADouble;
  Fpercent_Specified := True;
end;

function field10.percent_Specified(Index: Integer): boolean;
begin
  Result := Fpercent_Specified;
end;

procedure field10.Setrate(Index: Integer; const ADouble: Double);
begin
  Frate := ADouble;
  Frate_Specified := True;
end;

function field10.rate_Specified(Index: Integer): boolean;
begin
  Result := Frate_Specified;
end;

constructor addReport.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor addReport.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdatetime);
  System.SysUtils.FreeAndNil(Fcard);
  System.SysUtils.FreeAndNil(Freports);
  inherited Destroy;
end;

procedure addReport.Setmemory(Index: Integer; const Astring: string);
begin
  Fmemory := Astring;
  Fmemory_Specified := True;
end;

function addReport.memory_Specified(Index: Integer): boolean;
begin
  Result := Fmemory_Specified;
end;

procedure addReport.Setextras(Index: Integer; const Astring: string);
begin
  Fextras := Astring;
  Fextras_Specified := True;
end;

function addReport.extras_Specified(Index: Integer): boolean;
begin
  Result := Fextras_Specified;
end;

destructor reports.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdaily);
  System.SysUtils.FreeAndNil(Fyear);
  inherited Destroy;
end;

procedure reports.Setyear(Index: Integer; const Ayear: year);
begin
  Fyear := Ayear;
  Fyear_Specified := True;
end;

function reports.year_Specified(Index: Integer): boolean;
begin
  Result := Fyear_Specified;
end;

destructor daily.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdrawers)-1 do
    System.SysUtils.FreeAndNil(Fdrawers[I]);
  System.SetLength(Fdrawers, 0);
  for I := 0 to System.Length(Frates)-1 do
    System.SysUtils.FreeAndNil(Frates[I]);
  System.SetLength(Frates, 0);
  for I := 0 to System.Length(Freceipts)-1 do
    System.SysUtils.FreeAndNil(Freceipts[I]);
  System.SetLength(Freceipts, 0);
  for I := 0 to System.Length(Fintroduces)-1 do
    System.SysUtils.FreeAndNil(Fintroduces[I]);
  System.SetLength(Fintroduces, 0);
  for I := 0 to System.Length(Fissues)-1 do
    System.SysUtils.FreeAndNil(Fissues[I]);
  System.SetLength(Fissues, 0);
  for I := 0 to System.Length(Fadditionally)-1 do
    System.SysUtils.FreeAndNil(Fadditionally[I]);
  System.SetLength(Fadditionally, 0);
  for I := 0 to System.Length(Fcommissions)-1 do
    System.SysUtils.FreeAndNil(Fcommissions[I]);
  System.SetLength(Fcommissions, 0);
  for I := 0 to System.Length(Fbuys)-1 do
    System.SysUtils.FreeAndNil(Fbuys[I]);
  System.SetLength(Fbuys, 0);
  for I := 0 to System.Length(Fsells)-1 do
    System.SysUtils.FreeAndNil(Fsells[I]);
  System.SetLength(Fsells, 0);
  System.SysUtils.FreeAndNil(Fturnovers);
  inherited Destroy;
end;

procedure daily.Setbalance(Index: Integer; const ADouble: Double);
begin
  Fbalance := ADouble;
  Fbalance_Specified := True;
end;

function daily.balance_Specified(Index: Integer): boolean;
begin
  Result := Fbalance_Specified;
end;

procedure daily.Setcommissions(Index: Integer; const Acommissions: commissions);
begin
  Fcommissions := Acommissions;
  Fcommissions_Specified := True;
end;

function daily.commissions_Specified(Index: Integer): boolean;
begin
  Result := Fcommissions_Specified;
end;

destructor activity.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fpayments)-1 do
    System.SysUtils.FreeAndNil(Fpayments[I]);
  System.SetLength(Fpayments, 0);
  for I := 0 to System.Length(Factivities)-1 do
    System.SysUtils.FreeAndNil(Factivities[I]);
  System.SetLength(Factivities, 0);
  for I := 0 to System.Length(Ftaxes)-1 do
    System.SysUtils.FreeAndNil(Ftaxes[I]);
  System.SetLength(Ftaxes, 0);
  inherited Destroy;
end;

procedure activity.Setdeposit(Index: Integer; const Astring: string);
begin
  Fdeposit := Astring;
  Fdeposit_Specified := True;
end;

function activity.deposit_Specified(Index: Integer): boolean;
begin
  Result := Fdeposit_Specified;
end;

procedure activity.Settaxes(Index: Integer; const Ataxes: taxes);
begin
  Ftaxes := Ataxes;
  Ftaxes_Specified := True;
end;

function activity.taxes_Specified(Index: Integer): boolean;
begin
  Result := Ftaxes_Specified;
end;

destructor field12.Destroy;
begin
  System.SysUtils.FreeAndNil(Ftax);
  inherited Destroy;
end;

procedure tax.Setpercent(Index: Integer; const ADouble: Double);
begin
  Fpercent := ADouble;
  Fpercent_Specified := True;
end;

function tax.percent_Specified(Index: Integer): boolean;
begin
  Result := Fpercent_Specified;
end;

procedure tax.Setrate(Index: Integer; const ADouble: Double);
begin
  Frate := ADouble;
  Frate_Specified := True;
end;

function tax.rate_Specified(Index: Integer): boolean;
begin
  Result := Frate_Specified;
end;

initialization
  { ASV }
  InvRegistry.RegisterInterface(TypeInfo(ASV), 'https://sift-testmev.sfs.md/api/ASV/', 'UTF-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(ASV), '|https://sift-testmev.sfs.md/api/ASV/addServiceReceipt|https://sift-testmev.sfs.md/api/ASV/addFiscalReceipt|https://sift-testmev.sfs.md/api/ASV/addReport|https://sift-testmev.sfs.md/api/ASV/');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ASV), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ASV), ioLiteral);
  RemClassRegistry.RegisterXSInfo(TypeInfo(introduces), 'https://sift-testmev.sfs.md/api/ASV/', 'introduces');
  RemClassRegistry.RegisterXSInfo(TypeInfo(issues), 'https://sift-testmev.sfs.md/api/ASV/', 'issues');
  RemClassRegistry.RegisterXSInfo(TypeInfo(additionally), 'https://sift-testmev.sfs.md/api/ASV/', 'additionally');
  RemClassRegistry.RegisterXSInfo(TypeInfo(rates), 'https://sift-testmev.sfs.md/api/ASV/', 'rates');
  RemClassRegistry.RegisterXSInfo(TypeInfo(receipts), 'https://sift-testmev.sfs.md/api/ASV/', 'receipts');
  RemClassRegistry.RegisterXSInfo(TypeInfo(errors), 'https://sift-testmev.sfs.md/api/ASV/', 'errors');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sells), 'https://sift-testmev.sfs.md/api/ASV/', 'sells');
  RemClassRegistry.RegisterXSInfo(TypeInfo(commissions), 'https://sift-testmev.sfs.md/api/ASV/', 'commissions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(buys), 'https://sift-testmev.sfs.md/api/ASV/', 'buys');
  RemClassRegistry.RegisterXSInfo(TypeInfo(drawers), 'https://sift-testmev.sfs.md/api/ASV/', 'drawers');
  RemClassRegistry.RegisterXSClass(year, 'https://sift-testmev.sfs.md/api/ASV/', 'year');
  RemClassRegistry.RegisterXSClass(turnovers, 'https://sift-testmev.sfs.md/api/ASV/', 'turnovers');
  RemClassRegistry.RegisterXSClass(field, 'https://sift-testmev.sfs.md/api/ASV/', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSClass(card, 'https://sift-testmev.sfs.md/api/ASV/', 'card');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(addServiceReceipt, 'https://sift-testmev.sfs.md/api/ASV/', 'addServiceReceipt');
  RemClassRegistry.RegisterSerializeOptions(addServiceReceipt, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(receipt, 'https://sift-testmev.sfs.md/api/ASV/', 'receipt');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(receipt), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(receipt), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(client, 'https://sift-testmev.sfs.md/api/ASV/', 'client');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(client), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(card2, 'https://sift-testmev.sfs.md/api/ASV/', 'card2', 'card');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card2), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card2), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(addFiscalReceipt, 'https://sift-testmev.sfs.md/api/ASV/', 'addFiscalReceipt');
  RemClassRegistry.RegisterSerializeOptions(addFiscalReceipt, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(field2, 'https://sift-testmev.sfs.md/api/ASV/', 'field2', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field2), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field3, 'https://sift-testmev.sfs.md/api/ASV/', 'field3', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field3), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSClass(field4, 'https://sift-testmev.sfs.md/api/ASV/', 'field4', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field4), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(error, 'https://sift-testmev.sfs.md/api/ASV/', 'error');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(error), 'message_', '[ExtName="message"]');
  RemClassRegistry.RegisterXSClass(globalResponse, 'https://sift-testmev.sfs.md/api/ASV/', 'globalResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(globalResponse), 'errors', '[ArrayItemName="error"]');
  RemClassRegistry.RegisterSerializeOptions(globalResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(field5, 'https://sift-testmev.sfs.md/api/ASV/', 'field5', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field5), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field6, 'https://sift-testmev.sfs.md/api/ASV/', 'field6', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field6), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field7, 'https://sift-testmev.sfs.md/api/ASV/', 'field7', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field7), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field8, 'https://sift-testmev.sfs.md/api/ASV/', 'field8', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field8), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field9, 'https://sift-testmev.sfs.md/api/ASV/', 'field9', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field9), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(field10, 'https://sift-testmev.sfs.md/api/ASV/', 'field10', 'field');
  RemClassRegistry.RegisterXSClass(addReport, 'https://sift-testmev.sfs.md/api/ASV/', 'addReport');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(addReport), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterSerializeOptions(addReport, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(card3, 'https://sift-testmev.sfs.md/api/ASV/', 'card3', 'card');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card3), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(card3), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(reports, 'https://sift-testmev.sfs.md/api/ASV/', 'reports');
  RemClassRegistry.RegisterXSClass(daily, 'https://sift-testmev.sfs.md/api/ASV/', 'daily');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'drawers', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'rates', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'receipts', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'introduces', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'issues', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'additionally', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'commissions', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'buys', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(daily), 'sells', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(taxes), 'https://sift-testmev.sfs.md/api/ASV/', 'taxes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(payments), 'https://sift-testmev.sfs.md/api/ASV/', 'payments');
  RemClassRegistry.RegisterXSClass(field11, 'https://sift-testmev.sfs.md/api/ASV/', 'field11', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field11), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(activities), 'https://sift-testmev.sfs.md/api/ASV/', 'activities');
  RemClassRegistry.RegisterXSClass(activity, 'https://sift-testmev.sfs.md/api/ASV/', 'activity');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(activity), 'payments', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(activity), 'activities', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(activity), 'taxes', '[ArrayItemName="field"]');
  RemClassRegistry.RegisterXSClass(field12, 'https://sift-testmev.sfs.md/api/ASV/', 'field12', 'field');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field12), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(field12), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSClass(tax, 'https://sift-testmev.sfs.md/api/ASV/', 'tax');

end.