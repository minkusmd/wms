unit ZFPCOMLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 17252 $
// File generated on 27.02.2009 9:55:13 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\ZekaFP\3.0\bin\zfpcom.dll (1)
// LIBID: {B1F547D6-DFAD-47C0-BDE6-407702E27360}
// LCID: 0
// Helpfile: 
// HelpString: zfpcom 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Hint: Parameter 'type' of IZekaFP.Payment changed to 'type_'
//   Hint: Parameter 'type' of IZekaFP.OfficialSums changed to 'type_'
//   Hint: Parameter 'type' of IZekaFP.SetPayType changed to 'type_'
//   Hint: Parameter 'end' of IZekaFP.ReportFiscalByDate changed to 'end_'
//   Hint: Parameter 'type' of IZekaFP.SetPayTypeEU changed to 'type_'
//   Hint: Parameter 'type' of IZekaFP.PaymentEU changed to 'type_'
//   Hint: Parameter 'type' of IZekaFP.PaymentEx changed to 'type_'
//   Hint: Parameter 'type' of IZekaFP.OfficialSumsEx changed to 'type_'
//   Error creating palette bitmap of (TZekaFP) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TGetCurrentBonInfoRes) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TTaxNumbers) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TPayTypes) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TZFPParameters) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TOperatorInfo) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TArticleInfo) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TDailySums) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TFiscalReportData) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TDailyReport) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TZFPStatus) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
//   Error creating palette bitmap of (TInvoiceNumbers) : Server C:\PROGRA~2\ZekaFP\3.0\bin\zfpcom.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ZFPCOMLibMajorVersion = 1;
  ZFPCOMLibMinorVersion = 0;

  LIBID_ZFPCOMLib: TGUID = '{B1F547D6-DFAD-47C0-BDE6-407702E27360}';

  DIID__IZekaFPEvents: TGUID = '{1CF92986-79B9-418F-9D84-F8052A9C6286}';
  IID_IGetCurrentBonInfoRes: TGUID = '{15F4A466-C600-48AD-9138-AE4E5734ED8B}';
  IID_ITaxNumbers: TGUID = '{C58962A1-28FB-422A-B3BB-2435C4CB559F}';
  IID_IPayTypes: TGUID = '{29F4A8DC-786A-4274-A771-4B5C05003536}';
  IID_IZFPParameters: TGUID = '{71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}';
  IID_IOperatorInfo: TGUID = '{72495AB9-215A-4C8F-AE1F-BC88FD92B788}';
  IID_IArticleInfo: TGUID = '{96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}';
  IID_IDailySums: TGUID = '{9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}';
  IID_IFiscalReportData: TGUID = '{C80831C3-069A-4D31-A042-CD5A2D1BF43B}';
  IID_IDailyReport: TGUID = '{79B6621A-0804-4742-859A-333D1CB3EFBD}';
  IID_IZFPStatus: TGUID = '{6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}';
  IID_IInvoiceNumbers: TGUID = '{6591F815-2562-43F2-888C-6E5653B00284}';
  IID_IZekaFP: TGUID = '{955B3931-1A9C-4E6D-8343-000BEF1E4C27}';
  CLASS_ZekaFP: TGUID = '{2394FFB1-BB5E-4454-9B40-6F75006D27AA}';
  CLASS_GetCurrentBonInfoRes: TGUID = '{A52D1058-A873-4BE7-A94C-1A5DF6E6D345}';
  CLASS_TaxNumbers: TGUID = '{5C5335AF-6042-4246-94CE-4343FD3F7872}';
  CLASS_PayTypes: TGUID = '{5F26D9CE-4B61-43B6-900F-ABB48F5AA6A6}';
  CLASS_ZFPParameters: TGUID = '{75E2C498-0DAE-4CFC-BD3F-20CBEC338EA7}';
  CLASS_OperatorInfo: TGUID = '{97866887-9FF8-4D60-A7EE-132E46587FA5}';
  CLASS_ArticleInfo: TGUID = '{4B2E1B2E-4C07-471E-BC18-7497D0104348}';
  CLASS_DailySums: TGUID = '{52F50CD0-B861-457C-9F2C-6D1295060DC3}';
  CLASS_FiscalReportData: TGUID = '{DDFA7C5F-E120-4293-97D6-2467DBED2B9B}';
  CLASS_DailyReport: TGUID = '{1B381FCB-9A9E-456B-87D8-D5883007620C}';
  CLASS_ZFPStatus: TGUID = '{046BF363-4057-4489-B9C6-5C28D48DAF8D}';
  CLASS_InvoiceNumbers: TGUID = '{BEBD9667-9A17-44A0-B568-E1A9232619C5}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _IZekaFPEvents = dispinterface;
  IGetCurrentBonInfoRes = interface;
  IGetCurrentBonInfoResDisp = dispinterface;
  ITaxNumbers = interface;
  ITaxNumbersDisp = dispinterface;
  IPayTypes = interface;
  IPayTypesDisp = dispinterface;
  IZFPParameters = interface;
  IZFPParametersDisp = dispinterface;
  IOperatorInfo = interface;
  IOperatorInfoDisp = dispinterface;
  IArticleInfo = interface;
  IArticleInfoDisp = dispinterface;
  IDailySums = interface;
  IDailySumsDisp = dispinterface;
  IFiscalReportData = interface;
  IFiscalReportDataDisp = dispinterface;
  IDailyReport = interface;
  IDailyReportDisp = dispinterface;
  IZFPStatus = interface;
  IZFPStatusDisp = dispinterface;
  IInvoiceNumbers = interface;
  IInvoiceNumbersDisp = dispinterface;
  IZekaFP = interface;
  IZekaFPDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ZekaFP = IZekaFP;
  GetCurrentBonInfoRes = IGetCurrentBonInfoRes;
  TaxNumbers = ITaxNumbers;
  PayTypes = IPayTypes;
  ZFPParameters = IZFPParameters;
  OperatorInfo = IOperatorInfo;
  ArticleInfo = IArticleInfo;
  DailySums = IDailySums;
  FiscalReportData = IFiscalReportData;
  DailyReport = IDailyReport;
  ZFPStatus = IZFPStatus;
  InvoiceNumbers = IInvoiceNumbers;


// *********************************************************************//
// DispIntf:  _IZekaFPEvents
// Flags:     (4096) Dispatchable
// GUID:      {1CF92986-79B9-418F-9D84-F8052A9C6286}
// *********************************************************************//
  _IZekaFPEvents = dispinterface
    ['{1CF92986-79B9-418F-9D84-F8052A9C6286}']
  end;

// *********************************************************************//
// Interface: IGetCurrentBonInfoRes
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {15F4A466-C600-48AD-9138-AE4E5734ED8B}
// *********************************************************************//
  IGetCurrentBonInfoRes = interface(IDispatch)
    ['{15F4A466-C600-48AD-9138-AE4E5734ED8B}']
    function Get_flags: Integer; safecall;
    procedure Set_flags(pVal: Integer); safecall;
    function Get_purchases: Integer; safecall;
    procedure Set_purchases(pVal: Integer); safecall;
    function Get_taxgrp1: Double; safecall;
    procedure Set_taxgrp1(pVal: Double); safecall;
    function Get_taxgrp2: Double; safecall;
    procedure Set_taxgrp2(pVal: Double); safecall;
    function Get_taxgrp3: Double; safecall;
    procedure Set_taxgrp3(pVal: Double); safecall;
    function Get_novoid: Integer; safecall;
    procedure Set_novoid(pVal: Integer); safecall;
    function Get_dds: Integer; safecall;
    procedure Set_dds(pVal: Integer); safecall;
    function Get_detailed: Integer; safecall;
    procedure Set_detailed(pVal: Integer); safecall;
    function Get_paystarted: Integer; safecall;
    procedure Set_paystarted(pVal: Integer); safecall;
    function Get_paid: Integer; safecall;
    procedure Set_paid(pVal: Integer); safecall;
    function Get_taxgrp4: Double; safecall;
    procedure Set_taxgrp4(pVal: Double); safecall;
    function Get_taxgrp5: Double; safecall;
    procedure Set_taxgrp5(pVal: Double); safecall;
    function Get_powerdown: Integer; safecall;
    procedure Set_powerdown(pVal: Integer); safecall;
    function Get_invoice: Integer; safecall;
    procedure Set_invoice(pVal: Integer); safecall;
    function Get_taxgrp6: Double; safecall;
    procedure Set_taxgrp6(pVal: Double); safecall;
    function Get_taxgrp7: Double; safecall;
    procedure Set_taxgrp7(pVal: Double); safecall;
    function Get_taxgrp8: Double; safecall;
    procedure Set_taxgrp8(pVal: Double); safecall;
    function Get_change: Double; safecall;
    procedure Set_change(pVal: Double); safecall;
    function Get_changeType: Smallint; safecall;
    procedure Set_changeType(pVal: Smallint); safecall;
    property flags: Integer read Get_flags write Set_flags;
    property purchases: Integer read Get_purchases write Set_purchases;
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property novoid: Integer read Get_novoid write Set_novoid;
    property dds: Integer read Get_dds write Set_dds;
    property detailed: Integer read Get_detailed write Set_detailed;
    property paystarted: Integer read Get_paystarted write Set_paystarted;
    property paid: Integer read Get_paid write Set_paid;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property powerdown: Integer read Get_powerdown write Set_powerdown;
    property invoice: Integer read Get_invoice write Set_invoice;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
    property change: Double read Get_change write Set_change;
    property changeType: Smallint read Get_changeType write Set_changeType;
  end;

// *********************************************************************//
// DispIntf:  IGetCurrentBonInfoResDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {15F4A466-C600-48AD-9138-AE4E5734ED8B}
// *********************************************************************//
  IGetCurrentBonInfoResDisp = dispinterface
    ['{15F4A466-C600-48AD-9138-AE4E5734ED8B}']
    property flags: Integer dispid 1;
    property purchases: Integer dispid 2;
    property taxgrp1: Double dispid 3;
    property taxgrp2: Double dispid 4;
    property taxgrp3: Double dispid 5;
    property novoid: Integer dispid 6;
    property dds: Integer dispid 7;
    property detailed: Integer dispid 8;
    property paystarted: Integer dispid 9;
    property paid: Integer dispid 10;
    property taxgrp4: Double dispid 11;
    property taxgrp5: Double dispid 12;
    property powerdown: Integer dispid 13;
    property invoice: Integer dispid 14;
    property taxgrp6: Double dispid 15;
    property taxgrp7: Double dispid 16;
    property taxgrp8: Double dispid 17;
    property change: Double dispid 18;
    property changeType: Smallint dispid 19;
  end;

// *********************************************************************//
// Interface: ITaxNumbers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C58962A1-28FB-422A-B3BB-2435C4CB559F}
// *********************************************************************//
  ITaxNumbers = interface(IDispatch)
    ['{C58962A1-28FB-422A-B3BB-2435C4CB559F}']
    function Get_taxgrp1: Double; safecall;
    procedure Set_taxgrp1(pVal: Double); safecall;
    function Get_taxgrp2: Double; safecall;
    procedure Set_taxgrp2(pVal: Double); safecall;
    function Get_taxgrp3: Double; safecall;
    procedure Set_taxgrp3(pVal: Double); safecall;
    function Get_taxgrp4: Double; safecall;
    procedure Set_taxgrp4(pVal: Double); safecall;
    function Get_taxgrp5: Double; safecall;
    procedure Set_taxgrp5(pVal: Double); safecall;
    function Get_taxgrp6: Double; safecall;
    procedure Set_taxgrp6(pVal: Double); safecall;
    function Get_taxgrp7: Double; safecall;
    procedure Set_taxgrp7(pVal: Double); safecall;
    function Get_taxgrp8: Double; safecall;
    procedure Set_taxgrp8(pVal: Double); safecall;
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
  end;

// *********************************************************************//
// DispIntf:  ITaxNumbersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C58962A1-28FB-422A-B3BB-2435C4CB559F}
// *********************************************************************//
  ITaxNumbersDisp = dispinterface
    ['{C58962A1-28FB-422A-B3BB-2435C4CB559F}']
    property taxgrp1: Double dispid 1;
    property taxgrp2: Double dispid 2;
    property taxgrp3: Double dispid 3;
    property taxgrp4: Double dispid 4;
    property taxgrp5: Double dispid 5;
    property taxgrp6: Double dispid 6;
    property taxgrp7: Double dispid 7;
    property taxgrp8: Double dispid 8;
  end;

// *********************************************************************//
// Interface: IPayTypes
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {29F4A8DC-786A-4274-A771-4B5C05003536}
// *********************************************************************//
  IPayTypes = interface(IDispatch)
    ['{29F4A8DC-786A-4274-A771-4B5C05003536}']
    function Get_paytype1: WideString; safecall;
    procedure Set_paytype1(const pVal: WideString); safecall;
    function Get_paytype2: WideString; safecall;
    procedure Set_paytype2(const pVal: WideString); safecall;
    function Get_paytype3: WideString; safecall;
    procedure Set_paytype3(const pVal: WideString); safecall;
    function Get_paytype4: WideString; safecall;
    procedure Set_paytype4(const pVal: WideString); safecall;
    function Get_paytype0: WideString; safecall;
    procedure Set_paytype0(const pVal: WideString); safecall;
    function Get_paytype1sum: Double; safecall;
    procedure Set_paytype1sum(pVal: Double); safecall;
    function Get_paytype2sum: Double; safecall;
    procedure Set_paytype2sum(pVal: Double); safecall;
    function Get_paytype3sum: Double; safecall;
    procedure Set_paytype3sum(pVal: Double); safecall;
    function Get_paytype4sum: Double; safecall;
    procedure Set_paytype4sum(pVal: Double); safecall;
    function Get_paytype0sum: Double; safecall;
    procedure Set_paytype0sum(pVal: Double); safecall;
    function Get_operations: Integer; safecall;
    procedure Set_operations(pVal: Integer); safecall;
    function Get_exchRate: Double; safecall;
    procedure Set_exchRate(pVal: Double); safecall;
    property paytype1: WideString read Get_paytype1 write Set_paytype1;
    property paytype2: WideString read Get_paytype2 write Set_paytype2;
    property paytype3: WideString read Get_paytype3 write Set_paytype3;
    property paytype4: WideString read Get_paytype4 write Set_paytype4;
    property paytype0: WideString read Get_paytype0 write Set_paytype0;
    property paytype1sum: Double read Get_paytype1sum write Set_paytype1sum;
    property paytype2sum: Double read Get_paytype2sum write Set_paytype2sum;
    property paytype3sum: Double read Get_paytype3sum write Set_paytype3sum;
    property paytype4sum: Double read Get_paytype4sum write Set_paytype4sum;
    property paytype0sum: Double read Get_paytype0sum write Set_paytype0sum;
    property operations: Integer read Get_operations write Set_operations;
    property exchRate: Double read Get_exchRate write Set_exchRate;
  end;

// *********************************************************************//
// DispIntf:  IPayTypesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {29F4A8DC-786A-4274-A771-4B5C05003536}
// *********************************************************************//
  IPayTypesDisp = dispinterface
    ['{29F4A8DC-786A-4274-A771-4B5C05003536}']
    property paytype1: WideString dispid 1;
    property paytype2: WideString dispid 2;
    property paytype3: WideString dispid 3;
    property paytype4: WideString dispid 4;
    property paytype0: WideString dispid 5;
    property paytype1sum: Double dispid 6;
    property paytype2sum: Double dispid 7;
    property paytype3sum: Double dispid 8;
    property paytype4sum: Double dispid 9;
    property paytype0sum: Double dispid 10;
    property operations: Integer dispid 11;
    property exchRate: Double dispid 12;
  end;

// *********************************************************************//
// Interface: IZFPParameters
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}
// *********************************************************************//
  IZFPParameters = interface(IDispatch)
    ['{71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}']
    function Get_fpnum: Integer; safecall;
    procedure Set_fpnum(pVal: Integer); safecall;
    function Get_logo: Integer; safecall;
    procedure Set_logo(pVal: Integer); safecall;
    function Get_till: Integer; safecall;
    procedure Set_till(pVal: Integer); safecall;
    function Get_autocut: Integer; safecall;
    procedure Set_autocut(pVal: Integer); safecall;
    function Get_transparent: Integer; safecall;
    procedure Set_transparent(pVal: Integer); safecall;
    function Get_shortEJ: Integer; safecall;
    procedure Set_shortEJ(pVal: Integer); safecall;
    function Get_currency: Integer; safecall;
    procedure Set_currency(pVal: Integer); safecall;
    property fpnum: Integer read Get_fpnum write Set_fpnum;
    property logo: Integer read Get_logo write Set_logo;
    property till: Integer read Get_till write Set_till;
    property autocut: Integer read Get_autocut write Set_autocut;
    property transparent: Integer read Get_transparent write Set_transparent;
    property shortEJ: Integer read Get_shortEJ write Set_shortEJ;
    property currency: Integer read Get_currency write Set_currency;
  end;

// *********************************************************************//
// DispIntf:  IZFPParametersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}
// *********************************************************************//
  IZFPParametersDisp = dispinterface
    ['{71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}']
    property fpnum: Integer dispid 1;
    property logo: Integer dispid 2;
    property till: Integer dispid 3;
    property autocut: Integer dispid 4;
    property transparent: Integer dispid 5;
    property shortEJ: Integer dispid 6;
    property currency: Integer dispid 7;
  end;

// *********************************************************************//
// Interface: IOperatorInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72495AB9-215A-4C8F-AE1F-BC88FD92B788}
// *********************************************************************//
  IOperatorInfo = interface(IDispatch)
    ['{72495AB9-215A-4C8F-AE1F-BC88FD92B788}']
    function Get_name: WideString; safecall;
    procedure Set_name(const pVal: WideString); safecall;
    function Get_passwd: WideString; safecall;
    procedure Set_passwd(const pVal: WideString); safecall;
    property name: WideString read Get_name write Set_name;
    property passwd: WideString read Get_passwd write Set_passwd;
  end;

// *********************************************************************//
// DispIntf:  IOperatorInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72495AB9-215A-4C8F-AE1F-BC88FD92B788}
// *********************************************************************//
  IOperatorInfoDisp = dispinterface
    ['{72495AB9-215A-4C8F-AE1F-BC88FD92B788}']
    property name: WideString dispid 1;
    property passwd: WideString dispid 2;
  end;

// *********************************************************************//
// Interface: IArticleInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}
// *********************************************************************//
  IArticleInfo = interface(IDispatch)
    ['{96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}']
    function Get_name: WideString; safecall;
    procedure Set_name(const pVal: WideString); safecall;
    function Get_price: Double; safecall;
    procedure Set_price(pVal: Double); safecall;
    function Get_taxgroup: Smallint; safecall;
    procedure Set_taxgroup(pVal: Smallint); safecall;
    function Get_turnover: Double; safecall;
    procedure Set_turnover(pVal: Double); safecall;
    function Get_sells: Double; safecall;
    procedure Set_sells(pVal: Double); safecall;
    function Get_counter: Integer; safecall;
    procedure Set_counter(pVal: Integer); safecall;
    function Get_reportdate: TDateTime; safecall;
    procedure Set_reportdate(pVal: TDateTime); safecall;
    function Get_department: Smallint; safecall;
    procedure Set_department(pVal: Smallint); safecall;
    function Get_quantity: Double; safecall;
    procedure Set_quantity(pVal: Double); safecall;
    property name: WideString read Get_name write Set_name;
    property price: Double read Get_price write Set_price;
    property taxgroup: Smallint read Get_taxgroup write Set_taxgroup;
    property turnover: Double read Get_turnover write Set_turnover;
    property sells: Double read Get_sells write Set_sells;
    property counter: Integer read Get_counter write Set_counter;
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property department: Smallint read Get_department write Set_department;
    property quantity: Double read Get_quantity write Set_quantity;
  end;

// *********************************************************************//
// DispIntf:  IArticleInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}
// *********************************************************************//
  IArticleInfoDisp = dispinterface
    ['{96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}']
    property name: WideString dispid 1;
    property price: Double dispid 2;
    property taxgroup: Smallint dispid 3;
    property turnover: Double dispid 4;
    property sells: Double dispid 5;
    property counter: Integer dispid 6;
    property reportdate: TDateTime dispid 7;
    property department: Smallint dispid 8;
    property quantity: Double dispid 9;
  end;

// *********************************************************************//
// Interface: IDailySums
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}
// *********************************************************************//
  IDailySums = interface(IDispatch)
    ['{9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}']
    function Get_clients: Integer; safecall;
    procedure Set_clients(pVal: Integer); safecall;
    function Get_discounts: Integer; safecall;
    procedure Set_discounts(pVal: Integer); safecall;
    function Get_sumdiscount: Double; safecall;
    procedure Set_sumdiscount(pVal: Double); safecall;
    function Get_adding: Integer; safecall;
    procedure Set_adding(pVal: Integer); safecall;
    function Get_sumadding: Double; safecall;
    procedure Set_sumadding(pVal: Double); safecall;
    function Get_voids: Integer; safecall;
    procedure Set_voids(pVal: Integer); safecall;
    function Get_sumvoids: Double; safecall;
    procedure Set_sumvoids(pVal: Double); safecall;
    property clients: Integer read Get_clients write Set_clients;
    property discounts: Integer read Get_discounts write Set_discounts;
    property sumdiscount: Double read Get_sumdiscount write Set_sumdiscount;
    property adding: Integer read Get_adding write Set_adding;
    property sumadding: Double read Get_sumadding write Set_sumadding;
    property voids: Integer read Get_voids write Set_voids;
    property sumvoids: Double read Get_sumvoids write Set_sumvoids;
  end;

// *********************************************************************//
// DispIntf:  IDailySumsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}
// *********************************************************************//
  IDailySumsDisp = dispinterface
    ['{9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}']
    property clients: Integer dispid 1;
    property discounts: Integer dispid 2;
    property sumdiscount: Double dispid 3;
    property adding: Integer dispid 4;
    property sumadding: Double dispid 5;
    property voids: Integer dispid 6;
    property sumvoids: Double dispid 7;
  end;

// *********************************************************************//
// Interface: IFiscalReportData
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C80831C3-069A-4D31-A042-CD5A2D1BF43B}
// *********************************************************************//
  IFiscalReportData = interface(IDispatch)
    ['{C80831C3-069A-4D31-A042-CD5A2D1BF43B}']
    function Get_reportdate: TDateTime; safecall;
    procedure Set_reportdate(pVal: TDateTime); safecall;
    function Get_lastreport: Integer; safecall;
    procedure Set_lastreport(pVal: Integer); safecall;
    function Get_lastzeroram: Integer; safecall;
    procedure Set_lastzeroram(pVal: Integer); safecall;
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property lastzeroram: Integer read Get_lastzeroram write Set_lastzeroram;
  end;

// *********************************************************************//
// DispIntf:  IFiscalReportDataDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C80831C3-069A-4D31-A042-CD5A2D1BF43B}
// *********************************************************************//
  IFiscalReportDataDisp = dispinterface
    ['{C80831C3-069A-4D31-A042-CD5A2D1BF43B}']
    property reportdate: TDateTime dispid 1;
    property lastreport: Integer dispid 2;
    property lastzeroram: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: IDailyReport
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {79B6621A-0804-4742-859A-333D1CB3EFBD}
// *********************************************************************//
  IDailyReport = interface(IDispatch)
    ['{79B6621A-0804-4742-859A-333D1CB3EFBD}']
    function Get_counter: Integer; safecall;
    procedure Set_counter(pVal: Integer); safecall;
    function Get_lastreport: Integer; safecall;
    procedure Set_lastreport(pVal: Integer); safecall;
    function Get_ecl: Integer; safecall;
    procedure Set_ecl(pVal: Integer); safecall;
    function Get_datetime: TDateTime; safecall;
    procedure Set_datetime(pVal: TDateTime); safecall;
    property counter: Integer read Get_counter write Set_counter;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property ecl: Integer read Get_ecl write Set_ecl;
    property datetime: TDateTime read Get_datetime write Set_datetime;
  end;

// *********************************************************************//
// DispIntf:  IDailyReportDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {79B6621A-0804-4742-859A-333D1CB3EFBD}
// *********************************************************************//
  IDailyReportDisp = dispinterface
    ['{79B6621A-0804-4742-859A-333D1CB3EFBD}']
    property counter: Integer dispid 1;
    property lastreport: Integer dispid 2;
    property ecl: Integer dispid 3;
    property datetime: TDateTime dispid 4;
  end;

// *********************************************************************//
// Interface: IZFPStatus
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}
// *********************************************************************//
  IZFPStatus = interface(IDispatch)
    ['{6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}']
    function Get_ST0: Byte; safecall;
    procedure Set_ST0(pVal: Byte); safecall;
    function Get_ST1: Byte; safecall;
    procedure Set_ST1(pVal: Byte); safecall;
    function Get_ST2: Byte; safecall;
    procedure Set_ST2(pVal: Byte); safecall;
    function Get_ST3: Byte; safecall;
    procedure Set_ST3(pVal: Byte); safecall;
    function Get_ST4: Byte; safecall;
    procedure Set_ST4(pVal: Byte); safecall;
    function Get_wrongTimer: Integer; safecall;
    function Get_wrongDate: Integer; safecall;
    function Get_wrongRAM: Integer; safecall;
    function Get_clockHardwareError: Integer; safecall;
    function Get_paperOutPrinterError: Integer; safecall;
    function Get_reportSumOverflow: Integer; safecall;
    function Get_printLogo: Integer; safecall;
    function Get_nonzeroDailyReport: Integer; safecall;
    function Get_nonzeroArticleReport: Integer; safecall;
    function Get_nonzeroOperatorReport: Integer; safecall;
    function Get_duplicateNotPrinted: Integer; safecall;
    function Get_openOfficialBon: Integer; safecall;
    function Get_OpenFiscalBon: Integer; safecall;
    function Get_detailedInfo: Integer; safecall;
    function Get_VATinfo: Integer; safecall;
    function Get_missingFiscalMemory: Integer; safecall;
    function Get_wrongFiscalMemory: Integer; safecall;
    function Get_fullFiscalMemory: Integer; safecall;
    function Get_fiscalMemoryLimitNear: Integer; safecall;
    function Get_hasDecimalPoint: Integer; safecall;
    function Get_isFiscal: Integer; safecall;
    function Get_hasFiscalAndFactoryNum: Integer; safecall;
    function Get_autoCutter: Integer; safecall;
    function Get_hasTransparentDisplay: Integer; safecall;
    function Get_baud9600: Integer; safecall;
    function Get_autoTillOpen: Integer; safecall;
    function Get_readOnlyFM: Integer; safecall;
    function Get_powerdown: Integer; safecall;
    function Get_printerOverheat: Integer; safecall;
    function Get_Blocked24HoursReport: Integer; safecall;
    function Get_missingDisplay: Integer; safecall;
    function Get_shortEJMode: Integer; safecall;
    function Get_EJLimitNear: Integer; safecall;
    function Get_fullEJ: Integer; safecall;
    function Get_printCurrency: Integer; safecall;
    property ST0: Byte read Get_ST0 write Set_ST0;
    property ST1: Byte read Get_ST1 write Set_ST1;
    property ST2: Byte read Get_ST2 write Set_ST2;
    property ST3: Byte read Get_ST3 write Set_ST3;
    property ST4: Byte read Get_ST4 write Set_ST4;
    property wrongTimer: Integer read Get_wrongTimer;
    property wrongDate: Integer read Get_wrongDate;
    property wrongRAM: Integer read Get_wrongRAM;
    property clockHardwareError: Integer read Get_clockHardwareError;
    property paperOutPrinterError: Integer read Get_paperOutPrinterError;
    property reportSumOverflow: Integer read Get_reportSumOverflow;
    property printLogo: Integer read Get_printLogo;
    property nonzeroDailyReport: Integer read Get_nonzeroDailyReport;
    property nonzeroArticleReport: Integer read Get_nonzeroArticleReport;
    property nonzeroOperatorReport: Integer read Get_nonzeroOperatorReport;
    property duplicateNotPrinted: Integer read Get_duplicateNotPrinted;
    property openOfficialBon: Integer read Get_openOfficialBon;
    property OpenFiscalBon: Integer read Get_OpenFiscalBon;
    property detailedInfo: Integer read Get_detailedInfo;
    property VATinfo: Integer read Get_VATinfo;
    property missingFiscalMemory: Integer read Get_missingFiscalMemory;
    property wrongFiscalMemory: Integer read Get_wrongFiscalMemory;
    property fullFiscalMemory: Integer read Get_fullFiscalMemory;
    property fiscalMemoryLimitNear: Integer read Get_fiscalMemoryLimitNear;
    property hasDecimalPoint: Integer read Get_hasDecimalPoint;
    property isFiscal: Integer read Get_isFiscal;
    property hasFiscalAndFactoryNum: Integer read Get_hasFiscalAndFactoryNum;
    property autoCutter: Integer read Get_autoCutter;
    property hasTransparentDisplay: Integer read Get_hasTransparentDisplay;
    property baud9600: Integer read Get_baud9600;
    property autoTillOpen: Integer read Get_autoTillOpen;
    property readOnlyFM: Integer read Get_readOnlyFM;
    property powerdown: Integer read Get_powerdown;
    property printerOverheat: Integer read Get_printerOverheat;
    property Blocked24HoursReport: Integer read Get_Blocked24HoursReport;
    property missingDisplay: Integer read Get_missingDisplay;
    property shortEJMode: Integer read Get_shortEJMode;
    property EJLimitNear: Integer read Get_EJLimitNear;
    property fullEJ: Integer read Get_fullEJ;
    property printCurrency: Integer read Get_printCurrency;
  end;

// *********************************************************************//
// DispIntf:  IZFPStatusDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}
// *********************************************************************//
  IZFPStatusDisp = dispinterface
    ['{6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}']
    property ST0: Byte dispid 1;
    property ST1: Byte dispid 2;
    property ST2: Byte dispid 3;
    property ST3: Byte dispid 4;
    property ST4: Byte dispid 5;
    property wrongTimer: Integer readonly dispid 6;
    property wrongDate: Integer readonly dispid 7;
    property wrongRAM: Integer readonly dispid 8;
    property clockHardwareError: Integer readonly dispid 9;
    property paperOutPrinterError: Integer readonly dispid 10;
    property reportSumOverflow: Integer readonly dispid 11;
    property printLogo: Integer readonly dispid 12;
    property nonzeroDailyReport: Integer readonly dispid 13;
    property nonzeroArticleReport: Integer readonly dispid 14;
    property nonzeroOperatorReport: Integer readonly dispid 15;
    property duplicateNotPrinted: Integer readonly dispid 16;
    property openOfficialBon: Integer readonly dispid 17;
    property OpenFiscalBon: Integer readonly dispid 18;
    property detailedInfo: Integer readonly dispid 19;
    property VATinfo: Integer readonly dispid 20;
    property missingFiscalMemory: Integer readonly dispid 21;
    property wrongFiscalMemory: Integer readonly dispid 22;
    property fullFiscalMemory: Integer readonly dispid 23;
    property fiscalMemoryLimitNear: Integer readonly dispid 24;
    property hasDecimalPoint: Integer readonly dispid 25;
    property isFiscal: Integer readonly dispid 26;
    property hasFiscalAndFactoryNum: Integer readonly dispid 27;
    property autoCutter: Integer readonly dispid 28;
    property hasTransparentDisplay: Integer readonly dispid 29;
    property baud9600: Integer readonly dispid 30;
    property autoTillOpen: Integer readonly dispid 31;
    property readOnlyFM: Integer readonly dispid 32;
    property powerdown: Integer readonly dispid 33;
    property printerOverheat: Integer readonly dispid 34;
    property Blocked24HoursReport: Integer readonly dispid 35;
    property missingDisplay: Integer readonly dispid 36;
    property shortEJMode: Integer readonly dispid 37;
    property EJLimitNear: Integer readonly dispid 38;
    property fullEJ: Integer readonly dispid 39;
    property printCurrency: Integer readonly dispid 40;
  end;

// *********************************************************************//
// Interface: IInvoiceNumbers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6591F815-2562-43F2-888C-6E5653B00284}
// *********************************************************************//
  IInvoiceNumbers = interface(IDispatch)
    ['{6591F815-2562-43F2-888C-6E5653B00284}']
    function Get_nextNum: WideString; safecall;
    procedure Set_nextNum(const pVal: WideString); safecall;
    function Get_lastNum: WideString; safecall;
    procedure Set_lastNum(const pVal: WideString); safecall;
    property nextNum: WideString read Get_nextNum write Set_nextNum;
    property lastNum: WideString read Get_lastNum write Set_lastNum;
  end;

// *********************************************************************//
// DispIntf:  IInvoiceNumbersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6591F815-2562-43F2-888C-6E5653B00284}
// *********************************************************************//
  IInvoiceNumbersDisp = dispinterface
    ['{6591F815-2562-43F2-888C-6E5653B00284}']
    property nextNum: WideString dispid 1;
    property lastNum: WideString dispid 2;
  end;

// *********************************************************************//
// Interface: IZekaFP
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {955B3931-1A9C-4E6D-8343-000BEF1E4C27}
// *********************************************************************//
  IZekaFP = interface(IDispatch)
    ['{955B3931-1A9C-4E6D-8343-000BEF1E4C27}']
    function GetCurrentBonInfo: IDispatch; safecall;
    procedure Setup(wCom: Word; baud: LongWord; retries: Word; retryWait: LongWord); safecall;
    function Get_errorCode: Integer; safecall;
    function Diagnostic: Integer; safecall;
    function DisplayClear: Integer; safecall;
    function DisplayDateTime: Integer; safecall;
    function OpenTill: Integer; safecall;
    function LineFeed: Integer; safecall;
    function printLogo: Integer; safecall;
    function CloseBon: Integer; safecall;
    function CloseFiscalBon: Integer; safecall;
    function PrintDuplicate: Integer; safecall;
    function SetLocalDateTime: Integer; safecall;
    function GetTaxNumber: WideString; safecall;
    function GetDecimalPoint: Integer; safecall;
    function GetClicheLine(num: Byte): WideString; safecall;
    function OpenBon(oper: Byte; const passwd: WideString): Integer; safecall;
    function OpenFiscalBon(oper: Byte; const passwd: WideString; defPass: Byte; dds: Byte): Integer; safecall;
    function SellFree(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                      discount: Double): Integer; safecall;
    function Payment(sum: Double; type_: Byte; noRest: Integer): Integer; safecall;
    function OfficialSums(num: Byte; const passwd: WideString; type_: Byte; sum: Double): Integer; safecall;
    function GetBonNumber: Integer; safecall;
    function SetPayType(type_: Byte; const line: WideString): Integer; safecall;
    function SetParameters(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                           transparent: Integer): Integer; safecall;
    function SetClicheLine(num: Byte; const text: WideString): Integer; safecall;
    function SetOperatorUserPass(oper: Byte; const name: WideString; const passwd: WideString): Integer; safecall;
    function SetArticleInfo(num: Word; const name: WideString; price: Double; taxgrp: Byte): Integer; safecall;
    function SetLogoFile(const filename: WideString): Integer; safecall;
    function GetFactoryNumber: WideString; safecall;
    function GetFiscalNumber: WideString; safecall;
    function SellDB(isVoid: Integer; number: Word; quantity: Double; discount: Double): Integer; safecall;
    function GetTaxPercents: IDispatch; safecall;
    function GetPayTypes: IDispatch; safecall;
    function GetParameters: IDispatch; safecall;
    function GetOperatorUserPass(oper: Byte): IDispatch; safecall;
    function GetDailySums: IDispatch; safecall;
    function GetArticleInfo(number: Word): IDispatch; safecall;
    function GetDailyInfo: IDispatch; safecall;
    function GetOperatorInfo(oper: Byte): IDispatch; safecall;
    function GetOperatorReceives(oper: Byte): IDispatch; safecall;
    function GetDateTime: TDateTime; safecall;
    function Display(const line: WideString): Integer; safecall;
    function DisplayLine1(const line: WideString): Integer; safecall;
    function DisplayLine2(const line: WideString): Integer; safecall;
    function GetVersion: WideString; safecall;
    function GetInputBuffer: WideString; safecall;
    function GetResponseBuffer: WideString; safecall;
    function GetInputHexFormated: WideString; safecall;
    function GetResponseHexFormated: WideString; safecall;
    function GetErrorString(error: SYSINT; lang: SYSINT): WideString; safecall;
    function GetOperatorIncomes(oper: Byte): IDispatch; safecall;
    function GetOperatorExpenses(oper: Byte): IDispatch; safecall;
    function GetDailyPayments: IDispatch; safecall;
    function GetDailyIncomes: IDispatch; safecall;
    function GetDailyOfficialIncomes: IDispatch; safecall;
    function GetDailyOfficialExpenses: IDispatch; safecall;
    function CalcIntermediateSum(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                 discount: Double): Double; safecall;
    function GetLastFiscalReportData: IDispatch; safecall;
    function ReportSpecialFiscal: Integer; safecall;
    function ReportFiscalByBlock(detailed: Integer; startNumber: Word; endNumber: Word): Integer; safecall;
    function ReportDaily(zero: Integer; extended: Integer): Integer; safecall;
    function ReportArticles(zero: Integer): Integer; safecall;
    function SetDateTime(datetime: TDateTime): Integer; safecall;
    function ReportFiscalByDate(detailed: Integer; start: TDateTime; end_: TDateTime): Integer; safecall;
    function ReportOperator(zero: Integer; oper: Byte): Integer; safecall;
    function PrintText(const text: WideString; align: SYSINT): Integer; safecall;
    function GetDailyReport: IDispatch; safecall;
    function GetOperatorCounter(oper: Byte): IDispatch; safecall;
    function SetExternalDisplayFile(const password: WideString; const filename: WideString): Integer; safecall;
    function ReadFiscalMemory(const filename: WideString): Integer; safecall;
    function FindFirstFPCOM: LongWord; safecall;
    function PaperCut: Integer; safecall;
    function GetStatus: IDispatch; safecall;
    function GetFreeFiscalSpace: Integer; safecall;
    function Get_zfpType: Integer; safecall;
    procedure Set_zfpType(pVal: Integer); safecall;
    function OpenInvoice(oper: Byte; const passwd: WideString; const client: WideString; 
                         const receiver: WideString; const vatNum: WideString; 
                         const identNum: WideString; const address: WideString): Integer; safecall;
    function BusyWait(timeout: LongWord): Integer; safecall;
    procedure SetAutoBusyWait(timeout: LongWord); safecall;
    function SetSerialNumber(const password: WideString; const manifactureNum: WideString; 
                             const fiscalNum: WideString; const controlSum: WideString): Integer; safecall;
    function SetTaxNumber(const password: WideString; const taxNum: WideString; 
                          const fiscalNum: WideString): Integer; safecall;
    function MakeFiscal(const password: WideString): Integer; safecall;
    function SetTaxPercents(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                            tgr4: Double): Integer; safecall;
    function SetDecimalPoint(const password: WideString; point: SYSINT): Integer; safecall;
    function GetEJMode: Integer; safecall;
    function SetEJMode(bShort: Integer): Integer; safecall;
    function ReportEJ: Integer; safecall;
    function SellDepartment(const name: WideString; depNum: Word; price: Double; quantity: Double; 
                            discount: Double): Integer; safecall;
    function SetDepartment(number: Word; const name: WideString; taxgrp: Byte): Integer; safecall;
    function GetDepartment(number: Word): IDispatch; safecall;
    function SetArticleInfoEx(num: Word; const name: WideString; price: Double; taxgrp: Byte; 
                              department: Word): Integer; safecall;
    function CalcIntermediateSum2(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                  discount: Double; taxgrp: Smallint): Double; safecall;
    function ReportEJ2(num: Word): Integer; safecall;
    function SetTaxPercentsEU(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                              tgr4: Double; tgr5: Double; tgr6: Double; tgr7: Double; tgr8: Double): Integer; safecall;
    function SetPayTypeEU(type_: Byte; const line: WideString; exchRate: Double): Integer; safecall;
    function GetOperatorChangeEU(oper: Byte): IDispatch; safecall;
    function SetInvoiceNumbersRangeEU(const startNum: WideString; const lastNum: WideString): Integer; safecall;
    function PaymentEU(sum: Double; type_: Byte; noChange: Integer; changeType: Byte): Integer; safecall;
    function SetParametersEU(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                             transparent: Integer; shortEJ: Integer; currency: Integer): Integer; safecall;
    function SendCommandDirect(const cmd: WideString): WideString; safecall;
    function GetDailyChangeEU: IDispatch; safecall;
    function UpdateClicheKE(mode: Byte; const password: WideString): Integer; safecall;
    procedure Setup2(wCom: Byte; baud: Integer; retries: Integer; retryWait: Integer); safecall;
    function OpenBonWithEJ(oper: Byte; const passwd: WideString; hasEJ: Integer): Integer; safecall;
    function Get_zfplibVersion: Integer; safecall;
    function GetInvoiceNextNumberEU: IDispatch; safecall;
    function SetLogo(logo: Shortint): Integer; safecall;
    function GetLogoInfo: WideString; safecall;
    function FindFirstFPCOMEx: LongWord; safecall;
    function SetLogoFileEx(logo_id: Shortint; const filename: WideString): Integer; safecall;
    function PrintLogoEx(logo_id: Shortint): Integer; safecall;
    function CloseBonInCash: Integer; safecall;
    function PaymentEx(sum: Double; type_: Byte; noChange: Integer; changeType: Byte; 
                       fPaidExactSum: Integer): Integer; safecall;
    function GetVersionGS: WideString; safecall;
    function EnableCommGS(__MIDL_0015: Shortint; device_no: Word): Integer; safecall;
    function SetSpeedGS(speed: Shortint): Integer; safecall;
    function LoadScaleProtocolGS(const protocol: WideString): Integer; safecall;
    function SellDepartmentEx(const name: WideString; depNum: Word; price: Double; 
                              quantity: Double; discount: Double; flag: Shortint): Integer; safecall;
    function SellFreeEx(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                        discount: Double; flag: Shortint): Integer; safecall;
    function SellDBEx(isVoid: Integer; number: LongWord; quantity: Double; discount: Double; 
                      flag: Shortint): Integer; safecall;
    function GetArticleInfoEx(number: LongWord): IDispatch; safecall;
    function SetArticleInfo2(num: LongWord; const name: WideString; price: Double; taxgrp: Byte; 
                             department: Word): Integer; safecall;
    function ReportDepartments(zero: Integer): Integer; safecall;
    function OfficialSumsEx(num: Byte; const passwd: WideString; type_: Byte; sum: Double; 
                            const note: WideString): Integer; safecall;
    function EnableBarcode(__MIDL_0016: Shortint): Integer; safecall;
    function FormatBarcode(const __MIDL_0017: WideString): Integer; safecall;
    function PrintBarcode(const __MIDL_0018: WideString; __MIDL_0019: Byte): Integer; safecall;
    function SetLineWidth(__MIDL_0020: SYSINT): Integer; safecall;
    function SetPrintMode(__MIDL_0021: LongWord): Integer; safecall;
    function OpenTillEx(__MIDL_0022: Shortint): Integer; safecall;
    function OpenSerialPort: Integer; safecall;
    function CloseSerialPort: Integer; safecall;
    function Storno(const name: WideString; taxgrp: Byte; price: Double; quantity: Double): Integer; safecall;
    function SellFreeDiv(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                         discount: Double; flag: Shortint; divider: LongWord): Integer; safecall;
    function TerminateBon(__MIDL_0023: Integer): Integer; safecall;
    property errorCode: Integer read Get_errorCode;
    property zfpType: Integer read Get_zfpType write Set_zfpType;
    property zfplibVersion: Integer read Get_zfplibVersion;
  end;

// *********************************************************************//
// DispIntf:  IZekaFPDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {955B3931-1A9C-4E6D-8343-000BEF1E4C27}
// *********************************************************************//
  IZekaFPDisp = dispinterface
    ['{955B3931-1A9C-4E6D-8343-000BEF1E4C27}']
    function GetCurrentBonInfo: IDispatch; dispid 1;
    procedure Setup(wCom: {??Word}OleVariant; baud: LongWord; retries: {??Word}OleVariant; 
                    retryWait: LongWord); dispid 2;
    property errorCode: Integer readonly dispid 3;
    function Diagnostic: Integer; dispid 4;
    function DisplayClear: Integer; dispid 5;
    function DisplayDateTime: Integer; dispid 6;
    function OpenTill: Integer; dispid 7;
    function LineFeed: Integer; dispid 8;
    function printLogo: Integer; dispid 9;
    function CloseBon: Integer; dispid 10;
    function CloseFiscalBon: Integer; dispid 12;
    function PrintDuplicate: Integer; dispid 13;
    function SetLocalDateTime: Integer; dispid 14;
    function GetTaxNumber: WideString; dispid 15;
    function GetDecimalPoint: Integer; dispid 16;
    function GetClicheLine(num: Byte): WideString; dispid 17;
    function OpenBon(oper: Byte; const passwd: WideString): Integer; dispid 18;
    function OpenFiscalBon(oper: Byte; const passwd: WideString; defPass: Byte; dds: Byte): Integer; dispid 19;
    function SellFree(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                      discount: Double): Integer; dispid 20;
    function Payment(sum: Double; type_: Byte; noRest: Integer): Integer; dispid 21;
    function OfficialSums(num: Byte; const passwd: WideString; type_: Byte; sum: Double): Integer; dispid 22;
    function GetBonNumber: Integer; dispid 23;
    function SetPayType(type_: Byte; const line: WideString): Integer; dispid 24;
    function SetParameters(fpnum: {??Word}OleVariant; logo: Integer; till: Integer; 
                           autocut: Integer; transparent: Integer): Integer; dispid 25;
    function SetClicheLine(num: Byte; const text: WideString): Integer; dispid 26;
    function SetOperatorUserPass(oper: Byte; const name: WideString; const passwd: WideString): Integer; dispid 27;
    function SetArticleInfo(num: {??Word}OleVariant; const name: WideString; price: Double; 
                            taxgrp: Byte): Integer; dispid 28;
    function SetLogoFile(const filename: WideString): Integer; dispid 29;
    function GetFactoryNumber: WideString; dispid 30;
    function GetFiscalNumber: WideString; dispid 31;
    function SellDB(isVoid: Integer; number: {??Word}OleVariant; quantity: Double; discount: Double): Integer; dispid 32;
    function GetTaxPercents: IDispatch; dispid 33;
    function GetPayTypes: IDispatch; dispid 34;
    function GetParameters: IDispatch; dispid 35;
    function GetOperatorUserPass(oper: Byte): IDispatch; dispid 36;
    function GetDailySums: IDispatch; dispid 37;
    function GetArticleInfo(number: {??Word}OleVariant): IDispatch; dispid 38;
    function GetDailyInfo: IDispatch; dispid 39;
    function GetOperatorInfo(oper: Byte): IDispatch; dispid 40;
    function GetOperatorReceives(oper: Byte): IDispatch; dispid 41;
    function GetDateTime: TDateTime; dispid 42;
    function Display(const line: WideString): Integer; dispid 43;
    function DisplayLine1(const line: WideString): Integer; dispid 44;
    function DisplayLine2(const line: WideString): Integer; dispid 45;
    function GetVersion: WideString; dispid 46;
    function GetInputBuffer: WideString; dispid 47;
    function GetResponseBuffer: WideString; dispid 48;
    function GetInputHexFormated: WideString; dispid 49;
    function GetResponseHexFormated: WideString; dispid 50;
    function GetErrorString(error: SYSINT; lang: SYSINT): WideString; dispid 51;
    function GetOperatorIncomes(oper: Byte): IDispatch; dispid 52;
    function GetOperatorExpenses(oper: Byte): IDispatch; dispid 53;
    function GetDailyPayments: IDispatch; dispid 54;
    function GetDailyIncomes: IDispatch; dispid 55;
    function GetDailyOfficialIncomes: IDispatch; dispid 56;
    function GetDailyOfficialExpenses: IDispatch; dispid 57;
    function CalcIntermediateSum(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                 discount: Double): Double; dispid 58;
    function GetLastFiscalReportData: IDispatch; dispid 59;
    function ReportSpecialFiscal: Integer; dispid 60;
    function ReportFiscalByBlock(detailed: Integer; startNumber: {??Word}OleVariant; 
                                 endNumber: {??Word}OleVariant): Integer; dispid 61;
    function ReportDaily(zero: Integer; extended: Integer): Integer; dispid 62;
    function ReportArticles(zero: Integer): Integer; dispid 63;
    function SetDateTime(datetime: TDateTime): Integer; dispid 64;
    function ReportFiscalByDate(detailed: Integer; start: TDateTime; end_: TDateTime): Integer; dispid 65;
    function ReportOperator(zero: Integer; oper: Byte): Integer; dispid 66;
    function PrintText(const text: WideString; align: SYSINT): Integer; dispid 67;
    function GetDailyReport: IDispatch; dispid 68;
    function GetOperatorCounter(oper: Byte): IDispatch; dispid 69;
    function SetExternalDisplayFile(const password: WideString; const filename: WideString): Integer; dispid 70;
    function ReadFiscalMemory(const filename: WideString): Integer; dispid 71;
    function FindFirstFPCOM: LongWord; dispid 72;
    function PaperCut: Integer; dispid 73;
    function GetStatus: IDispatch; dispid 74;
    function GetFreeFiscalSpace: Integer; dispid 75;
    property zfpType: Integer dispid 76;
    function OpenInvoice(oper: Byte; const passwd: WideString; const client: WideString; 
                         const receiver: WideString; const vatNum: WideString; 
                         const identNum: WideString; const address: WideString): Integer; dispid 77;
    function BusyWait(timeout: LongWord): Integer; dispid 78;
    procedure SetAutoBusyWait(timeout: LongWord); dispid 79;
    function SetSerialNumber(const password: WideString; const manifactureNum: WideString; 
                             const fiscalNum: WideString; const controlSum: WideString): Integer; dispid 80;
    function SetTaxNumber(const password: WideString; const taxNum: WideString; 
                          const fiscalNum: WideString): Integer; dispid 81;
    function MakeFiscal(const password: WideString): Integer; dispid 82;
    function SetTaxPercents(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                            tgr4: Double): Integer; dispid 83;
    function SetDecimalPoint(const password: WideString; point: SYSINT): Integer; dispid 84;
    function GetEJMode: Integer; dispid 85;
    function SetEJMode(bShort: Integer): Integer; dispid 86;
    function ReportEJ: Integer; dispid 87;
    function SellDepartment(const name: WideString; depNum: {??Word}OleVariant; price: Double; 
                            quantity: Double; discount: Double): Integer; dispid 88;
    function SetDepartment(number: {??Word}OleVariant; const name: WideString; taxgrp: Byte): Integer; dispid 89;
    function GetDepartment(number: {??Word}OleVariant): IDispatch; dispid 90;
    function SetArticleInfoEx(num: {??Word}OleVariant; const name: WideString; price: Double; 
                              taxgrp: Byte; department: {??Word}OleVariant): Integer; dispid 91;
    function CalcIntermediateSum2(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                  discount: Double; taxgrp: Smallint): Double; dispid 92;
    function ReportEJ2(num: {??Word}OleVariant): Integer; dispid 93;
    function SetTaxPercentsEU(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                              tgr4: Double; tgr5: Double; tgr6: Double; tgr7: Double; tgr8: Double): Integer; dispid 94;
    function SetPayTypeEU(type_: Byte; const line: WideString; exchRate: Double): Integer; dispid 95;
    function GetOperatorChangeEU(oper: Byte): IDispatch; dispid 96;
    function SetInvoiceNumbersRangeEU(const startNum: WideString; const lastNum: WideString): Integer; dispid 97;
    function PaymentEU(sum: Double; type_: Byte; noChange: Integer; changeType: Byte): Integer; dispid 98;
    function SetParametersEU(fpnum: {??Word}OleVariant; logo: Integer; till: Integer; 
                             autocut: Integer; transparent: Integer; shortEJ: Integer; 
                             currency: Integer): Integer; dispid 99;
    function SendCommandDirect(const cmd: WideString): WideString; dispid 101;
    function GetDailyChangeEU: IDispatch; dispid 103;
    function UpdateClicheKE(mode: Byte; const password: WideString): Integer; dispid 104;
    procedure Setup2(wCom: Byte; baud: Integer; retries: Integer; retryWait: Integer); dispid 105;
    function OpenBonWithEJ(oper: Byte; const passwd: WideString; hasEJ: Integer): Integer; dispid 106;
    property zfplibVersion: Integer readonly dispid 107;
    function GetInvoiceNextNumberEU: IDispatch; dispid 108;
    function SetLogo(logo: {??Shortint}OleVariant): Integer; dispid 109;
    function GetLogoInfo: WideString; dispid 110;
    function FindFirstFPCOMEx: LongWord; dispid 111;
    function SetLogoFileEx(logo_id: {??Shortint}OleVariant; const filename: WideString): Integer; dispid 112;
    function PrintLogoEx(logo_id: {??Shortint}OleVariant): Integer; dispid 113;
    function CloseBonInCash: Integer; dispid 114;
    function PaymentEx(sum: Double; type_: Byte; noChange: Integer; changeType: Byte; 
                       fPaidExactSum: Integer): Integer; dispid 115;
    function GetVersionGS: WideString; dispid 116;
    function EnableCommGS(__MIDL_0015: {??Shortint}OleVariant; device_no: {??Word}OleVariant): Integer; dispid 117;
    function SetSpeedGS(speed: {??Shortint}OleVariant): Integer; dispid 118;
    function LoadScaleProtocolGS(const protocol: WideString): Integer; dispid 119;
    function SellDepartmentEx(const name: WideString; depNum: {??Word}OleVariant; price: Double; 
                              quantity: Double; discount: Double; flag: {??Shortint}OleVariant): Integer; dispid 120;
    function SellFreeEx(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                        discount: Double; flag: {??Shortint}OleVariant): Integer; dispid 121;
    function SellDBEx(isVoid: Integer; number: LongWord; quantity: Double; discount: Double; 
                      flag: {??Shortint}OleVariant): Integer; dispid 122;
    function GetArticleInfoEx(number: LongWord): IDispatch; dispid 123;
    function SetArticleInfo2(num: LongWord; const name: WideString; price: Double; taxgrp: Byte; 
                             department: {??Word}OleVariant): Integer; dispid 124;
    function ReportDepartments(zero: Integer): Integer; dispid 125;
    function OfficialSumsEx(num: Byte; const passwd: WideString; type_: Byte; sum: Double; 
                            const note: WideString): Integer; dispid 126;
    function EnableBarcode(__MIDL_0016: {??Shortint}OleVariant): Integer; dispid 127;
    function FormatBarcode(const __MIDL_0017: WideString): Integer; dispid 128;
    function PrintBarcode(const __MIDL_0018: WideString; __MIDL_0019: Byte): Integer; dispid 129;
    function SetLineWidth(__MIDL_0020: SYSINT): Integer; dispid 130;
    function SetPrintMode(__MIDL_0021: LongWord): Integer; dispid 131;
    function OpenTillEx(__MIDL_0022: {??Shortint}OleVariant): Integer; dispid 132;
    function OpenSerialPort: Integer; dispid 133;
    function CloseSerialPort: Integer; dispid 134;
    function Storno(const name: WideString; taxgrp: Byte; price: Double; quantity: Double): Integer; dispid 135;
    function SellFreeDiv(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                         discount: Double; flag: {??Shortint}OleVariant; divider: LongWord): Integer; dispid 136;
    function TerminateBon(__MIDL_0023: Integer): Integer; dispid 137;
  end;

// *********************************************************************//
// The Class CoZekaFP provides a Create and CreateRemote method to          
// create instances of the default interface IZekaFP exposed by              
// the CoClass ZekaFP. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoZekaFP = class
    class function Create: IZekaFP;
    class function CreateRemote(const MachineName: string): IZekaFP;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TZekaFP
// Help String      : ZekaFP Class
// Default Interface: IZekaFP
// Def. Intf. DISP? : No
// Event   Interface: _IZekaFPEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TZekaFPProperties= class;
{$ENDIF}
  TZekaFP = class(TOleServer)
  private
    FIntf: IZekaFP;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TZekaFPProperties;
    function GetServerProperties: TZekaFPProperties;
{$ENDIF}
    function GetDefaultInterface: IZekaFP;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_errorCode: Integer;
    function Get_zfpType: Integer;
    procedure Set_zfpType(pVal: Integer);
    function Get_zfplibVersion: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IZekaFP);
    procedure Disconnect; override;
    function GetCurrentBonInfo: IDispatch;
    procedure Setup(wCom: Word; baud: LongWord; retries: Word; retryWait: LongWord);
    function Diagnostic: Integer;
    function DisplayClear: Integer;
    function DisplayDateTime: Integer;
    function OpenTill: Integer;
    function LineFeed: Integer;
    function printLogo: Integer;
    function CloseBon: Integer;
    function CloseFiscalBon: Integer;
    function PrintDuplicate: Integer;
    function SetLocalDateTime: Integer;
    function GetTaxNumber: WideString;
    function GetDecimalPoint: Integer;
    function GetClicheLine(num: Byte): WideString;
    function OpenBon(oper: Byte; const passwd: WideString): Integer;
    function OpenFiscalBon(oper: Byte; const passwd: WideString; defPass: Byte; dds: Byte): Integer;
    function SellFree(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                      discount: Double): Integer;
    function Payment(sum: Double; type_: Byte; noRest: Integer): Integer;
    function OfficialSums(num: Byte; const passwd: WideString; type_: Byte; sum: Double): Integer;
    function GetBonNumber: Integer;
    function SetPayType(type_: Byte; const line: WideString): Integer;
    function SetParameters(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                           transparent: Integer): Integer;
    function SetClicheLine(num: Byte; const text: WideString): Integer;
    function SetOperatorUserPass(oper: Byte; const name: WideString; const passwd: WideString): Integer;
    function SetArticleInfo(num: Word; const name: WideString; price: Double; taxgrp: Byte): Integer;
    function SetLogoFile(const filename: WideString): Integer;
    function GetFactoryNumber: WideString;
    function GetFiscalNumber: WideString;
    function SellDB(isVoid: Integer; number: Word; quantity: Double; discount: Double): Integer;
    function GetTaxPercents: IDispatch;
    function GetPayTypes: IDispatch;
    function GetParameters: IDispatch;
    function GetOperatorUserPass(oper: Byte): IDispatch;
    function GetDailySums: IDispatch;
    function GetArticleInfo(number: Word): IDispatch;
    function GetDailyInfo: IDispatch;
    function GetOperatorInfo(oper: Byte): IDispatch;
    function GetOperatorReceives(oper: Byte): IDispatch;
    function GetDateTime: TDateTime;
    function Display(const line: WideString): Integer;
    function DisplayLine1(const line: WideString): Integer;
    function DisplayLine2(const line: WideString): Integer;
    function GetVersion: WideString;
    function GetInputBuffer: WideString;
    function GetResponseBuffer: WideString;
    function GetInputHexFormated: WideString;
    function GetResponseHexFormated: WideString;
    function GetErrorString(error: SYSINT; lang: SYSINT): WideString;
    function GetOperatorIncomes(oper: Byte): IDispatch;
    function GetOperatorExpenses(oper: Byte): IDispatch;
    function GetDailyPayments: IDispatch;
    function GetDailyIncomes: IDispatch;
    function GetDailyOfficialIncomes: IDispatch;
    function GetDailyOfficialExpenses: IDispatch;
    function CalcIntermediateSum(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                 discount: Double): Double;
    function GetLastFiscalReportData: IDispatch;
    function ReportSpecialFiscal: Integer;
    function ReportFiscalByBlock(detailed: Integer; startNumber: Word; endNumber: Word): Integer;
    function ReportDaily(zero: Integer; extended: Integer): Integer;
    function ReportArticles(zero: Integer): Integer;
    function SetDateTime(datetime: TDateTime): Integer;
    function ReportFiscalByDate(detailed: Integer; start: TDateTime; end_: TDateTime): Integer;
    function ReportOperator(zero: Integer; oper: Byte): Integer;
    function PrintText(const text: WideString; align: SYSINT): Integer;
    function GetDailyReport: IDispatch;
    function GetOperatorCounter(oper: Byte): IDispatch;
    function SetExternalDisplayFile(const password: WideString; const filename: WideString): Integer;
    function ReadFiscalMemory(const filename: WideString): Integer;
    function FindFirstFPCOM: LongWord;
    function PaperCut: Integer;
    function GetStatus: IDispatch;
    function GetFreeFiscalSpace: Integer;
    function OpenInvoice(oper: Byte; const passwd: WideString; const client: WideString; 
                         const receiver: WideString; const vatNum: WideString; 
                         const identNum: WideString; const address: WideString): Integer;
    function BusyWait(timeout: LongWord): Integer;
    procedure SetAutoBusyWait(timeout: LongWord);
    function SetSerialNumber(const password: WideString; const manifactureNum: WideString; 
                             const fiscalNum: WideString; const controlSum: WideString): Integer;
    function SetTaxNumber(const password: WideString; const taxNum: WideString; 
                          const fiscalNum: WideString): Integer;
    function MakeFiscal(const password: WideString): Integer;
    function SetTaxPercents(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                            tgr4: Double): Integer;
    function SetDecimalPoint(const password: WideString; point: SYSINT): Integer;
    function GetEJMode: Integer;
    function SetEJMode(bShort: Integer): Integer;
    function ReportEJ: Integer;
    function SellDepartment(const name: WideString; depNum: Word; price: Double; quantity: Double; 
                            discount: Double): Integer;
    function SetDepartment(number: Word; const name: WideString; taxgrp: Byte): Integer;
    function GetDepartment(number: Word): IDispatch;
    function SetArticleInfoEx(num: Word; const name: WideString; price: Double; taxgrp: Byte; 
                              department: Word): Integer;
    function CalcIntermediateSum2(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                  discount: Double; taxgrp: Smallint): Double;
    function ReportEJ2(num: Word): Integer;
    function SetTaxPercentsEU(const password: WideString; tgr1: Double; tgr2: Double; tgr3: Double; 
                              tgr4: Double; tgr5: Double; tgr6: Double; tgr7: Double; tgr8: Double): Integer;
    function SetPayTypeEU(type_: Byte; const line: WideString; exchRate: Double): Integer;
    function GetOperatorChangeEU(oper: Byte): IDispatch;
    function SetInvoiceNumbersRangeEU(const startNum: WideString; const lastNum: WideString): Integer;
    function PaymentEU(sum: Double; type_: Byte; noChange: Integer; changeType: Byte): Integer;
    function SetParametersEU(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                             transparent: Integer; shortEJ: Integer; currency: Integer): Integer;
    function SendCommandDirect(const cmd: WideString): WideString;
    function GetDailyChangeEU: IDispatch;
    function UpdateClicheKE(mode: Byte; const password: WideString): Integer;
    procedure Setup2(wCom: Byte; baud: Integer; retries: Integer; retryWait: Integer);
    function OpenBonWithEJ(oper: Byte; const passwd: WideString; hasEJ: Integer): Integer;
    function GetInvoiceNextNumberEU: IDispatch;
    function SetLogo(logo: Shortint): Integer;
    function GetLogoInfo: WideString;
    function FindFirstFPCOMEx: LongWord;
    function SetLogoFileEx(logo_id: Shortint; const filename: WideString): Integer;
    function PrintLogoEx(logo_id: Shortint): Integer;
    function CloseBonInCash: Integer;
    function PaymentEx(sum: Double; type_: Byte; noChange: Integer; changeType: Byte; 
                       fPaidExactSum: Integer): Integer;
    function GetVersionGS: WideString;
    function EnableCommGS(__MIDL_0015: Shortint; device_no: Word): Integer;
    function SetSpeedGS(speed: Shortint): Integer;
    function LoadScaleProtocolGS(const protocol: WideString): Integer;
    function SellDepartmentEx(const name: WideString; depNum: Word; price: Double; 
                              quantity: Double; discount: Double; flag: Shortint): Integer;
    function SellFreeEx(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                        discount: Double; flag: Shortint): Integer;
    function SellDBEx(isVoid: Integer; number: LongWord; quantity: Double; discount: Double; 
                      flag: Shortint): Integer;
    function GetArticleInfoEx(number: LongWord): IDispatch;
    function SetArticleInfo2(num: LongWord; const name: WideString; price: Double; taxgrp: Byte; 
                             department: Word): Integer;
    function ReportDepartments(zero: Integer): Integer;
    function OfficialSumsEx(num: Byte; const passwd: WideString; type_: Byte; sum: Double; 
                            const note: WideString): Integer;
    function EnableBarcode(__MIDL_0016: Shortint): Integer;
    function FormatBarcode(const __MIDL_0017: WideString): Integer;
    function PrintBarcode(const __MIDL_0018: WideString; __MIDL_0019: Byte): Integer;
    function SetLineWidth(__MIDL_0020: SYSINT): Integer;
    function SetPrintMode(__MIDL_0021: LongWord): Integer;
    function OpenTillEx(__MIDL_0022: Shortint): Integer;
    function OpenSerialPort: Integer;
    function CloseSerialPort: Integer;
    function Storno(const name: WideString; taxgrp: Byte; price: Double; quantity: Double): Integer;
    function SellFreeDiv(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                         discount: Double; flag: Shortint; divider: LongWord): Integer;
    function TerminateBon(__MIDL_0023: Integer): Integer;
    property DefaultInterface: IZekaFP read GetDefaultInterface;
    property errorCode: Integer read Get_errorCode;
    property zfplibVersion: Integer read Get_zfplibVersion;
    property zfpType: Integer read Get_zfpType write Set_zfpType;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TZekaFPProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TZekaFP
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TZekaFPProperties = class(TPersistent)
  private
    FServer:    TZekaFP;
    function    GetDefaultInterface: IZekaFP;
    constructor Create(AServer: TZekaFP);
  protected
    function Get_errorCode: Integer;
    function Get_zfpType: Integer;
    procedure Set_zfpType(pVal: Integer);
    function Get_zfplibVersion: Integer;
  public
    property DefaultInterface: IZekaFP read GetDefaultInterface;
  published
    property zfpType: Integer read Get_zfpType write Set_zfpType;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoGetCurrentBonInfoRes provides a Create and CreateRemote method to          
// create instances of the default interface IGetCurrentBonInfoRes exposed by              
// the CoClass GetCurrentBonInfoRes. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetCurrentBonInfoRes = class
    class function Create: IGetCurrentBonInfoRes;
    class function CreateRemote(const MachineName: string): IGetCurrentBonInfoRes;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetCurrentBonInfoRes
// Help String      : GetCurrentBonInfoRes Class
// Default Interface: IGetCurrentBonInfoRes
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TGetCurrentBonInfoResProperties= class;
{$ENDIF}
  TGetCurrentBonInfoRes = class(TOleServer)
  private
    FIntf: IGetCurrentBonInfoRes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TGetCurrentBonInfoResProperties;
    function GetServerProperties: TGetCurrentBonInfoResProperties;
{$ENDIF}
    function GetDefaultInterface: IGetCurrentBonInfoRes;
  protected
    procedure InitServerData; override;
    function Get_flags: Integer;
    procedure Set_flags(pVal: Integer);
    function Get_purchases: Integer;
    procedure Set_purchases(pVal: Integer);
    function Get_taxgrp1: Double;
    procedure Set_taxgrp1(pVal: Double);
    function Get_taxgrp2: Double;
    procedure Set_taxgrp2(pVal: Double);
    function Get_taxgrp3: Double;
    procedure Set_taxgrp3(pVal: Double);
    function Get_novoid: Integer;
    procedure Set_novoid(pVal: Integer);
    function Get_dds: Integer;
    procedure Set_dds(pVal: Integer);
    function Get_detailed: Integer;
    procedure Set_detailed(pVal: Integer);
    function Get_paystarted: Integer;
    procedure Set_paystarted(pVal: Integer);
    function Get_paid: Integer;
    procedure Set_paid(pVal: Integer);
    function Get_taxgrp4: Double;
    procedure Set_taxgrp4(pVal: Double);
    function Get_taxgrp5: Double;
    procedure Set_taxgrp5(pVal: Double);
    function Get_powerdown: Integer;
    procedure Set_powerdown(pVal: Integer);
    function Get_invoice: Integer;
    procedure Set_invoice(pVal: Integer);
    function Get_taxgrp6: Double;
    procedure Set_taxgrp6(pVal: Double);
    function Get_taxgrp7: Double;
    procedure Set_taxgrp7(pVal: Double);
    function Get_taxgrp8: Double;
    procedure Set_taxgrp8(pVal: Double);
    function Get_change: Double;
    procedure Set_change(pVal: Double);
    function Get_changeType: Smallint;
    procedure Set_changeType(pVal: Smallint);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IGetCurrentBonInfoRes);
    procedure Disconnect; override;
    property DefaultInterface: IGetCurrentBonInfoRes read GetDefaultInterface;
    property flags: Integer read Get_flags write Set_flags;
    property purchases: Integer read Get_purchases write Set_purchases;
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property novoid: Integer read Get_novoid write Set_novoid;
    property dds: Integer read Get_dds write Set_dds;
    property detailed: Integer read Get_detailed write Set_detailed;
    property paystarted: Integer read Get_paystarted write Set_paystarted;
    property paid: Integer read Get_paid write Set_paid;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property powerdown: Integer read Get_powerdown write Set_powerdown;
    property invoice: Integer read Get_invoice write Set_invoice;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
    property change: Double read Get_change write Set_change;
    property changeType: Smallint read Get_changeType write Set_changeType;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TGetCurrentBonInfoResProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TGetCurrentBonInfoRes
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TGetCurrentBonInfoResProperties = class(TPersistent)
  private
    FServer:    TGetCurrentBonInfoRes;
    function    GetDefaultInterface: IGetCurrentBonInfoRes;
    constructor Create(AServer: TGetCurrentBonInfoRes);
  protected
    function Get_flags: Integer;
    procedure Set_flags(pVal: Integer);
    function Get_purchases: Integer;
    procedure Set_purchases(pVal: Integer);
    function Get_taxgrp1: Double;
    procedure Set_taxgrp1(pVal: Double);
    function Get_taxgrp2: Double;
    procedure Set_taxgrp2(pVal: Double);
    function Get_taxgrp3: Double;
    procedure Set_taxgrp3(pVal: Double);
    function Get_novoid: Integer;
    procedure Set_novoid(pVal: Integer);
    function Get_dds: Integer;
    procedure Set_dds(pVal: Integer);
    function Get_detailed: Integer;
    procedure Set_detailed(pVal: Integer);
    function Get_paystarted: Integer;
    procedure Set_paystarted(pVal: Integer);
    function Get_paid: Integer;
    procedure Set_paid(pVal: Integer);
    function Get_taxgrp4: Double;
    procedure Set_taxgrp4(pVal: Double);
    function Get_taxgrp5: Double;
    procedure Set_taxgrp5(pVal: Double);
    function Get_powerdown: Integer;
    procedure Set_powerdown(pVal: Integer);
    function Get_invoice: Integer;
    procedure Set_invoice(pVal: Integer);
    function Get_taxgrp6: Double;
    procedure Set_taxgrp6(pVal: Double);
    function Get_taxgrp7: Double;
    procedure Set_taxgrp7(pVal: Double);
    function Get_taxgrp8: Double;
    procedure Set_taxgrp8(pVal: Double);
    function Get_change: Double;
    procedure Set_change(pVal: Double);
    function Get_changeType: Smallint;
    procedure Set_changeType(pVal: Smallint);
  public
    property DefaultInterface: IGetCurrentBonInfoRes read GetDefaultInterface;
  published
    property flags: Integer read Get_flags write Set_flags;
    property purchases: Integer read Get_purchases write Set_purchases;
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property novoid: Integer read Get_novoid write Set_novoid;
    property dds: Integer read Get_dds write Set_dds;
    property detailed: Integer read Get_detailed write Set_detailed;
    property paystarted: Integer read Get_paystarted write Set_paystarted;
    property paid: Integer read Get_paid write Set_paid;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property powerdown: Integer read Get_powerdown write Set_powerdown;
    property invoice: Integer read Get_invoice write Set_invoice;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
    property change: Double read Get_change write Set_change;
    property changeType: Smallint read Get_changeType write Set_changeType;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTaxNumbers provides a Create and CreateRemote method to          
// create instances of the default interface ITaxNumbers exposed by              
// the CoClass TaxNumbers. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTaxNumbers = class
    class function Create: ITaxNumbers;
    class function CreateRemote(const MachineName: string): ITaxNumbers;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTaxNumbers
// Help String      : TaxNumbers Class
// Default Interface: ITaxNumbers
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTaxNumbersProperties= class;
{$ENDIF}
  TTaxNumbers = class(TOleServer)
  private
    FIntf: ITaxNumbers;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TTaxNumbersProperties;
    function GetServerProperties: TTaxNumbersProperties;
{$ENDIF}
    function GetDefaultInterface: ITaxNumbers;
  protected
    procedure InitServerData; override;
    function Get_taxgrp1: Double;
    procedure Set_taxgrp1(pVal: Double);
    function Get_taxgrp2: Double;
    procedure Set_taxgrp2(pVal: Double);
    function Get_taxgrp3: Double;
    procedure Set_taxgrp3(pVal: Double);
    function Get_taxgrp4: Double;
    procedure Set_taxgrp4(pVal: Double);
    function Get_taxgrp5: Double;
    procedure Set_taxgrp5(pVal: Double);
    function Get_taxgrp6: Double;
    procedure Set_taxgrp6(pVal: Double);
    function Get_taxgrp7: Double;
    procedure Set_taxgrp7(pVal: Double);
    function Get_taxgrp8: Double;
    procedure Set_taxgrp8(pVal: Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ITaxNumbers);
    procedure Disconnect; override;
    property DefaultInterface: ITaxNumbers read GetDefaultInterface;
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTaxNumbersProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTaxNumbers
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTaxNumbersProperties = class(TPersistent)
  private
    FServer:    TTaxNumbers;
    function    GetDefaultInterface: ITaxNumbers;
    constructor Create(AServer: TTaxNumbers);
  protected
    function Get_taxgrp1: Double;
    procedure Set_taxgrp1(pVal: Double);
    function Get_taxgrp2: Double;
    procedure Set_taxgrp2(pVal: Double);
    function Get_taxgrp3: Double;
    procedure Set_taxgrp3(pVal: Double);
    function Get_taxgrp4: Double;
    procedure Set_taxgrp4(pVal: Double);
    function Get_taxgrp5: Double;
    procedure Set_taxgrp5(pVal: Double);
    function Get_taxgrp6: Double;
    procedure Set_taxgrp6(pVal: Double);
    function Get_taxgrp7: Double;
    procedure Set_taxgrp7(pVal: Double);
    function Get_taxgrp8: Double;
    procedure Set_taxgrp8(pVal: Double);
  public
    property DefaultInterface: ITaxNumbers read GetDefaultInterface;
  published
    property taxgrp1: Double read Get_taxgrp1 write Set_taxgrp1;
    property taxgrp2: Double read Get_taxgrp2 write Set_taxgrp2;
    property taxgrp3: Double read Get_taxgrp3 write Set_taxgrp3;
    property taxgrp4: Double read Get_taxgrp4 write Set_taxgrp4;
    property taxgrp5: Double read Get_taxgrp5 write Set_taxgrp5;
    property taxgrp6: Double read Get_taxgrp6 write Set_taxgrp6;
    property taxgrp7: Double read Get_taxgrp7 write Set_taxgrp7;
    property taxgrp8: Double read Get_taxgrp8 write Set_taxgrp8;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPayTypes provides a Create and CreateRemote method to          
// create instances of the default interface IPayTypes exposed by              
// the CoClass PayTypes. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPayTypes = class
    class function Create: IPayTypes;
    class function CreateRemote(const MachineName: string): IPayTypes;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPayTypes
// Help String      : PayTypes Class
// Default Interface: IPayTypes
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPayTypesProperties= class;
{$ENDIF}
  TPayTypes = class(TOleServer)
  private
    FIntf: IPayTypes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TPayTypesProperties;
    function GetServerProperties: TPayTypesProperties;
{$ENDIF}
    function GetDefaultInterface: IPayTypes;
  protected
    procedure InitServerData; override;
    function Get_paytype1: WideString;
    procedure Set_paytype1(const pVal: WideString);
    function Get_paytype2: WideString;
    procedure Set_paytype2(const pVal: WideString);
    function Get_paytype3: WideString;
    procedure Set_paytype3(const pVal: WideString);
    function Get_paytype4: WideString;
    procedure Set_paytype4(const pVal: WideString);
    function Get_paytype0: WideString;
    procedure Set_paytype0(const pVal: WideString);
    function Get_paytype1sum: Double;
    procedure Set_paytype1sum(pVal: Double);
    function Get_paytype2sum: Double;
    procedure Set_paytype2sum(pVal: Double);
    function Get_paytype3sum: Double;
    procedure Set_paytype3sum(pVal: Double);
    function Get_paytype4sum: Double;
    procedure Set_paytype4sum(pVal: Double);
    function Get_paytype0sum: Double;
    procedure Set_paytype0sum(pVal: Double);
    function Get_operations: Integer;
    procedure Set_operations(pVal: Integer);
    function Get_exchRate: Double;
    procedure Set_exchRate(pVal: Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IPayTypes);
    procedure Disconnect; override;
    property DefaultInterface: IPayTypes read GetDefaultInterface;
    property paytype1: WideString read Get_paytype1 write Set_paytype1;
    property paytype2: WideString read Get_paytype2 write Set_paytype2;
    property paytype3: WideString read Get_paytype3 write Set_paytype3;
    property paytype4: WideString read Get_paytype4 write Set_paytype4;
    property paytype0: WideString read Get_paytype0 write Set_paytype0;
    property paytype1sum: Double read Get_paytype1sum write Set_paytype1sum;
    property paytype2sum: Double read Get_paytype2sum write Set_paytype2sum;
    property paytype3sum: Double read Get_paytype3sum write Set_paytype3sum;
    property paytype4sum: Double read Get_paytype4sum write Set_paytype4sum;
    property paytype0sum: Double read Get_paytype0sum write Set_paytype0sum;
    property operations: Integer read Get_operations write Set_operations;
    property exchRate: Double read Get_exchRate write Set_exchRate;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPayTypesProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPayTypes
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPayTypesProperties = class(TPersistent)
  private
    FServer:    TPayTypes;
    function    GetDefaultInterface: IPayTypes;
    constructor Create(AServer: TPayTypes);
  protected
    function Get_paytype1: WideString;
    procedure Set_paytype1(const pVal: WideString);
    function Get_paytype2: WideString;
    procedure Set_paytype2(const pVal: WideString);
    function Get_paytype3: WideString;
    procedure Set_paytype3(const pVal: WideString);
    function Get_paytype4: WideString;
    procedure Set_paytype4(const pVal: WideString);
    function Get_paytype0: WideString;
    procedure Set_paytype0(const pVal: WideString);
    function Get_paytype1sum: Double;
    procedure Set_paytype1sum(pVal: Double);
    function Get_paytype2sum: Double;
    procedure Set_paytype2sum(pVal: Double);
    function Get_paytype3sum: Double;
    procedure Set_paytype3sum(pVal: Double);
    function Get_paytype4sum: Double;
    procedure Set_paytype4sum(pVal: Double);
    function Get_paytype0sum: Double;
    procedure Set_paytype0sum(pVal: Double);
    function Get_operations: Integer;
    procedure Set_operations(pVal: Integer);
    function Get_exchRate: Double;
    procedure Set_exchRate(pVal: Double);
  public
    property DefaultInterface: IPayTypes read GetDefaultInterface;
  published
    property paytype1: WideString read Get_paytype1 write Set_paytype1;
    property paytype2: WideString read Get_paytype2 write Set_paytype2;
    property paytype3: WideString read Get_paytype3 write Set_paytype3;
    property paytype4: WideString read Get_paytype4 write Set_paytype4;
    property paytype0: WideString read Get_paytype0 write Set_paytype0;
    property paytype1sum: Double read Get_paytype1sum write Set_paytype1sum;
    property paytype2sum: Double read Get_paytype2sum write Set_paytype2sum;
    property paytype3sum: Double read Get_paytype3sum write Set_paytype3sum;
    property paytype4sum: Double read Get_paytype4sum write Set_paytype4sum;
    property paytype0sum: Double read Get_paytype0sum write Set_paytype0sum;
    property operations: Integer read Get_operations write Set_operations;
    property exchRate: Double read Get_exchRate write Set_exchRate;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoZFPParameters provides a Create and CreateRemote method to          
// create instances of the default interface IZFPParameters exposed by              
// the CoClass ZFPParameters. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoZFPParameters = class
    class function Create: IZFPParameters;
    class function CreateRemote(const MachineName: string): IZFPParameters;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TZFPParameters
// Help String      : ZFPParameters Class
// Default Interface: IZFPParameters
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TZFPParametersProperties= class;
{$ENDIF}
  TZFPParameters = class(TOleServer)
  private
    FIntf: IZFPParameters;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TZFPParametersProperties;
    function GetServerProperties: TZFPParametersProperties;
{$ENDIF}
    function GetDefaultInterface: IZFPParameters;
  protected
    procedure InitServerData; override;
    function Get_fpnum: Integer;
    procedure Set_fpnum(pVal: Integer);
    function Get_logo: Integer;
    procedure Set_logo(pVal: Integer);
    function Get_till: Integer;
    procedure Set_till(pVal: Integer);
    function Get_autocut: Integer;
    procedure Set_autocut(pVal: Integer);
    function Get_transparent: Integer;
    procedure Set_transparent(pVal: Integer);
    function Get_shortEJ: Integer;
    procedure Set_shortEJ(pVal: Integer);
    function Get_currency: Integer;
    procedure Set_currency(pVal: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IZFPParameters);
    procedure Disconnect; override;
    property DefaultInterface: IZFPParameters read GetDefaultInterface;
    property fpnum: Integer read Get_fpnum write Set_fpnum;
    property logo: Integer read Get_logo write Set_logo;
    property till: Integer read Get_till write Set_till;
    property autocut: Integer read Get_autocut write Set_autocut;
    property transparent: Integer read Get_transparent write Set_transparent;
    property shortEJ: Integer read Get_shortEJ write Set_shortEJ;
    property currency: Integer read Get_currency write Set_currency;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TZFPParametersProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TZFPParameters
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TZFPParametersProperties = class(TPersistent)
  private
    FServer:    TZFPParameters;
    function    GetDefaultInterface: IZFPParameters;
    constructor Create(AServer: TZFPParameters);
  protected
    function Get_fpnum: Integer;
    procedure Set_fpnum(pVal: Integer);
    function Get_logo: Integer;
    procedure Set_logo(pVal: Integer);
    function Get_till: Integer;
    procedure Set_till(pVal: Integer);
    function Get_autocut: Integer;
    procedure Set_autocut(pVal: Integer);
    function Get_transparent: Integer;
    procedure Set_transparent(pVal: Integer);
    function Get_shortEJ: Integer;
    procedure Set_shortEJ(pVal: Integer);
    function Get_currency: Integer;
    procedure Set_currency(pVal: Integer);
  public
    property DefaultInterface: IZFPParameters read GetDefaultInterface;
  published
    property fpnum: Integer read Get_fpnum write Set_fpnum;
    property logo: Integer read Get_logo write Set_logo;
    property till: Integer read Get_till write Set_till;
    property autocut: Integer read Get_autocut write Set_autocut;
    property transparent: Integer read Get_transparent write Set_transparent;
    property shortEJ: Integer read Get_shortEJ write Set_shortEJ;
    property currency: Integer read Get_currency write Set_currency;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoOperatorInfo provides a Create and CreateRemote method to          
// create instances of the default interface IOperatorInfo exposed by              
// the CoClass OperatorInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOperatorInfo = class
    class function Create: IOperatorInfo;
    class function CreateRemote(const MachineName: string): IOperatorInfo;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TOperatorInfo
// Help String      : OperatorInfo Class
// Default Interface: IOperatorInfo
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TOperatorInfoProperties= class;
{$ENDIF}
  TOperatorInfo = class(TOleServer)
  private
    FIntf: IOperatorInfo;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TOperatorInfoProperties;
    function GetServerProperties: TOperatorInfoProperties;
{$ENDIF}
    function GetDefaultInterface: IOperatorInfo;
  protected
    procedure InitServerData; override;
    function Get_name: WideString;
    procedure Set_name(const pVal: WideString);
    function Get_passwd: WideString;
    procedure Set_passwd(const pVal: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IOperatorInfo);
    procedure Disconnect; override;
    property DefaultInterface: IOperatorInfo read GetDefaultInterface;
    property name: WideString read Get_name write Set_name;
    property passwd: WideString read Get_passwd write Set_passwd;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TOperatorInfoProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TOperatorInfo
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TOperatorInfoProperties = class(TPersistent)
  private
    FServer:    TOperatorInfo;
    function    GetDefaultInterface: IOperatorInfo;
    constructor Create(AServer: TOperatorInfo);
  protected
    function Get_name: WideString;
    procedure Set_name(const pVal: WideString);
    function Get_passwd: WideString;
    procedure Set_passwd(const pVal: WideString);
  public
    property DefaultInterface: IOperatorInfo read GetDefaultInterface;
  published
    property name: WideString read Get_name write Set_name;
    property passwd: WideString read Get_passwd write Set_passwd;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoArticleInfo provides a Create and CreateRemote method to          
// create instances of the default interface IArticleInfo exposed by              
// the CoClass ArticleInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoArticleInfo = class
    class function Create: IArticleInfo;
    class function CreateRemote(const MachineName: string): IArticleInfo;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TArticleInfo
// Help String      : ArticleInfo Class
// Default Interface: IArticleInfo
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TArticleInfoProperties= class;
{$ENDIF}
  TArticleInfo = class(TOleServer)
  private
    FIntf: IArticleInfo;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TArticleInfoProperties;
    function GetServerProperties: TArticleInfoProperties;
{$ENDIF}
    function GetDefaultInterface: IArticleInfo;
  protected
    procedure InitServerData; override;
    function Get_name: WideString;
    procedure Set_name(const pVal: WideString);
    function Get_price: Double;
    procedure Set_price(pVal: Double);
    function Get_taxgroup: Smallint;
    procedure Set_taxgroup(pVal: Smallint);
    function Get_turnover: Double;
    procedure Set_turnover(pVal: Double);
    function Get_sells: Double;
    procedure Set_sells(pVal: Double);
    function Get_counter: Integer;
    procedure Set_counter(pVal: Integer);
    function Get_reportdate: TDateTime;
    procedure Set_reportdate(pVal: TDateTime);
    function Get_department: Smallint;
    procedure Set_department(pVal: Smallint);
    function Get_quantity: Double;
    procedure Set_quantity(pVal: Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IArticleInfo);
    procedure Disconnect; override;
    property DefaultInterface: IArticleInfo read GetDefaultInterface;
    property name: WideString read Get_name write Set_name;
    property price: Double read Get_price write Set_price;
    property taxgroup: Smallint read Get_taxgroup write Set_taxgroup;
    property turnover: Double read Get_turnover write Set_turnover;
    property sells: Double read Get_sells write Set_sells;
    property counter: Integer read Get_counter write Set_counter;
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property department: Smallint read Get_department write Set_department;
    property quantity: Double read Get_quantity write Set_quantity;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TArticleInfoProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TArticleInfo
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TArticleInfoProperties = class(TPersistent)
  private
    FServer:    TArticleInfo;
    function    GetDefaultInterface: IArticleInfo;
    constructor Create(AServer: TArticleInfo);
  protected
    function Get_name: WideString;
    procedure Set_name(const pVal: WideString);
    function Get_price: Double;
    procedure Set_price(pVal: Double);
    function Get_taxgroup: Smallint;
    procedure Set_taxgroup(pVal: Smallint);
    function Get_turnover: Double;
    procedure Set_turnover(pVal: Double);
    function Get_sells: Double;
    procedure Set_sells(pVal: Double);
    function Get_counter: Integer;
    procedure Set_counter(pVal: Integer);
    function Get_reportdate: TDateTime;
    procedure Set_reportdate(pVal: TDateTime);
    function Get_department: Smallint;
    procedure Set_department(pVal: Smallint);
    function Get_quantity: Double;
    procedure Set_quantity(pVal: Double);
  public
    property DefaultInterface: IArticleInfo read GetDefaultInterface;
  published
    property name: WideString read Get_name write Set_name;
    property price: Double read Get_price write Set_price;
    property taxgroup: Smallint read Get_taxgroup write Set_taxgroup;
    property turnover: Double read Get_turnover write Set_turnover;
    property sells: Double read Get_sells write Set_sells;
    property counter: Integer read Get_counter write Set_counter;
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property department: Smallint read Get_department write Set_department;
    property quantity: Double read Get_quantity write Set_quantity;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDailySums provides a Create and CreateRemote method to          
// create instances of the default interface IDailySums exposed by              
// the CoClass DailySums. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDailySums = class
    class function Create: IDailySums;
    class function CreateRemote(const MachineName: string): IDailySums;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDailySums
// Help String      : DailySums Class
// Default Interface: IDailySums
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDailySumsProperties= class;
{$ENDIF}
  TDailySums = class(TOleServer)
  private
    FIntf: IDailySums;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDailySumsProperties;
    function GetServerProperties: TDailySumsProperties;
{$ENDIF}
    function GetDefaultInterface: IDailySums;
  protected
    procedure InitServerData; override;
    function Get_clients: Integer;
    procedure Set_clients(pVal: Integer);
    function Get_discounts: Integer;
    procedure Set_discounts(pVal: Integer);
    function Get_sumdiscount: Double;
    procedure Set_sumdiscount(pVal: Double);
    function Get_adding: Integer;
    procedure Set_adding(pVal: Integer);
    function Get_sumadding: Double;
    procedure Set_sumadding(pVal: Double);
    function Get_voids: Integer;
    procedure Set_voids(pVal: Integer);
    function Get_sumvoids: Double;
    procedure Set_sumvoids(pVal: Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDailySums);
    procedure Disconnect; override;
    property DefaultInterface: IDailySums read GetDefaultInterface;
    property clients: Integer read Get_clients write Set_clients;
    property discounts: Integer read Get_discounts write Set_discounts;
    property sumdiscount: Double read Get_sumdiscount write Set_sumdiscount;
    property adding: Integer read Get_adding write Set_adding;
    property sumadding: Double read Get_sumadding write Set_sumadding;
    property voids: Integer read Get_voids write Set_voids;
    property sumvoids: Double read Get_sumvoids write Set_sumvoids;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDailySumsProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDailySums
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDailySumsProperties = class(TPersistent)
  private
    FServer:    TDailySums;
    function    GetDefaultInterface: IDailySums;
    constructor Create(AServer: TDailySums);
  protected
    function Get_clients: Integer;
    procedure Set_clients(pVal: Integer);
    function Get_discounts: Integer;
    procedure Set_discounts(pVal: Integer);
    function Get_sumdiscount: Double;
    procedure Set_sumdiscount(pVal: Double);
    function Get_adding: Integer;
    procedure Set_adding(pVal: Integer);
    function Get_sumadding: Double;
    procedure Set_sumadding(pVal: Double);
    function Get_voids: Integer;
    procedure Set_voids(pVal: Integer);
    function Get_sumvoids: Double;
    procedure Set_sumvoids(pVal: Double);
  public
    property DefaultInterface: IDailySums read GetDefaultInterface;
  published
    property clients: Integer read Get_clients write Set_clients;
    property discounts: Integer read Get_discounts write Set_discounts;
    property sumdiscount: Double read Get_sumdiscount write Set_sumdiscount;
    property adding: Integer read Get_adding write Set_adding;
    property sumadding: Double read Get_sumadding write Set_sumadding;
    property voids: Integer read Get_voids write Set_voids;
    property sumvoids: Double read Get_sumvoids write Set_sumvoids;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoFiscalReportData provides a Create and CreateRemote method to          
// create instances of the default interface IFiscalReportData exposed by              
// the CoClass FiscalReportData. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFiscalReportData = class
    class function Create: IFiscalReportData;
    class function CreateRemote(const MachineName: string): IFiscalReportData;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TFiscalReportData
// Help String      : FiscalReportData Class
// Default Interface: IFiscalReportData
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFiscalReportDataProperties= class;
{$ENDIF}
  TFiscalReportData = class(TOleServer)
  private
    FIntf: IFiscalReportData;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TFiscalReportDataProperties;
    function GetServerProperties: TFiscalReportDataProperties;
{$ENDIF}
    function GetDefaultInterface: IFiscalReportData;
  protected
    procedure InitServerData; override;
    function Get_reportdate: TDateTime;
    procedure Set_reportdate(pVal: TDateTime);
    function Get_lastreport: Integer;
    procedure Set_lastreport(pVal: Integer);
    function Get_lastzeroram: Integer;
    procedure Set_lastzeroram(pVal: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IFiscalReportData);
    procedure Disconnect; override;
    property DefaultInterface: IFiscalReportData read GetDefaultInterface;
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property lastzeroram: Integer read Get_lastzeroram write Set_lastzeroram;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFiscalReportDataProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TFiscalReportData
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TFiscalReportDataProperties = class(TPersistent)
  private
    FServer:    TFiscalReportData;
    function    GetDefaultInterface: IFiscalReportData;
    constructor Create(AServer: TFiscalReportData);
  protected
    function Get_reportdate: TDateTime;
    procedure Set_reportdate(pVal: TDateTime);
    function Get_lastreport: Integer;
    procedure Set_lastreport(pVal: Integer);
    function Get_lastzeroram: Integer;
    procedure Set_lastzeroram(pVal: Integer);
  public
    property DefaultInterface: IFiscalReportData read GetDefaultInterface;
  published
    property reportdate: TDateTime read Get_reportdate write Set_reportdate;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property lastzeroram: Integer read Get_lastzeroram write Set_lastzeroram;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDailyReport provides a Create and CreateRemote method to          
// create instances of the default interface IDailyReport exposed by              
// the CoClass DailyReport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDailyReport = class
    class function Create: IDailyReport;
    class function CreateRemote(const MachineName: string): IDailyReport;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDailyReport
// Help String      : DailyReport Class
// Default Interface: IDailyReport
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDailyReportProperties= class;
{$ENDIF}
  TDailyReport = class(TOleServer)
  private
    FIntf: IDailyReport;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDailyReportProperties;
    function GetServerProperties: TDailyReportProperties;
{$ENDIF}
    function GetDefaultInterface: IDailyReport;
  protected
    procedure InitServerData; override;
    function Get_counter: Integer;
    procedure Set_counter(pVal: Integer);
    function Get_lastreport: Integer;
    procedure Set_lastreport(pVal: Integer);
    function Get_ecl: Integer;
    procedure Set_ecl(pVal: Integer);
    function Get_datetime: TDateTime;
    procedure Set_datetime(pVal: TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDailyReport);
    procedure Disconnect; override;
    property DefaultInterface: IDailyReport read GetDefaultInterface;
    property counter: Integer read Get_counter write Set_counter;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property ecl: Integer read Get_ecl write Set_ecl;
    property datetime: TDateTime read Get_datetime write Set_datetime;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDailyReportProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDailyReport
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDailyReportProperties = class(TPersistent)
  private
    FServer:    TDailyReport;
    function    GetDefaultInterface: IDailyReport;
    constructor Create(AServer: TDailyReport);
  protected
    function Get_counter: Integer;
    procedure Set_counter(pVal: Integer);
    function Get_lastreport: Integer;
    procedure Set_lastreport(pVal: Integer);
    function Get_ecl: Integer;
    procedure Set_ecl(pVal: Integer);
    function Get_datetime: TDateTime;
    procedure Set_datetime(pVal: TDateTime);
  public
    property DefaultInterface: IDailyReport read GetDefaultInterface;
  published
    property counter: Integer read Get_counter write Set_counter;
    property lastreport: Integer read Get_lastreport write Set_lastreport;
    property ecl: Integer read Get_ecl write Set_ecl;
    property datetime: TDateTime read Get_datetime write Set_datetime;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoZFPStatus provides a Create and CreateRemote method to          
// create instances of the default interface IZFPStatus exposed by              
// the CoClass ZFPStatus. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoZFPStatus = class
    class function Create: IZFPStatus;
    class function CreateRemote(const MachineName: string): IZFPStatus;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TZFPStatus
// Help String      : ZFPStatus Class
// Default Interface: IZFPStatus
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TZFPStatusProperties= class;
{$ENDIF}
  TZFPStatus = class(TOleServer)
  private
    FIntf: IZFPStatus;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TZFPStatusProperties;
    function GetServerProperties: TZFPStatusProperties;
{$ENDIF}
    function GetDefaultInterface: IZFPStatus;
  protected
    procedure InitServerData; override;
    function Get_ST0: Byte;
    procedure Set_ST0(pVal: Byte);
    function Get_ST1: Byte;
    procedure Set_ST1(pVal: Byte);
    function Get_ST2: Byte;
    procedure Set_ST2(pVal: Byte);
    function Get_ST3: Byte;
    procedure Set_ST3(pVal: Byte);
    function Get_ST4: Byte;
    procedure Set_ST4(pVal: Byte);
    function Get_wrongTimer: Integer;
    function Get_wrongDate: Integer;
    function Get_wrongRAM: Integer;
    function Get_clockHardwareError: Integer;
    function Get_paperOutPrinterError: Integer;
    function Get_reportSumOverflow: Integer;
    function Get_printLogo: Integer;
    function Get_nonzeroDailyReport: Integer;
    function Get_nonzeroArticleReport: Integer;
    function Get_nonzeroOperatorReport: Integer;
    function Get_duplicateNotPrinted: Integer;
    function Get_openOfficialBon: Integer;
    function Get_OpenFiscalBon: Integer;
    function Get_detailedInfo: Integer;
    function Get_VATinfo: Integer;
    function Get_missingFiscalMemory: Integer;
    function Get_wrongFiscalMemory: Integer;
    function Get_fullFiscalMemory: Integer;
    function Get_fiscalMemoryLimitNear: Integer;
    function Get_hasDecimalPoint: Integer;
    function Get_isFiscal: Integer;
    function Get_hasFiscalAndFactoryNum: Integer;
    function Get_autoCutter: Integer;
    function Get_hasTransparentDisplay: Integer;
    function Get_baud9600: Integer;
    function Get_autoTillOpen: Integer;
    function Get_readOnlyFM: Integer;
    function Get_powerdown: Integer;
    function Get_printerOverheat: Integer;
    function Get_Blocked24HoursReport: Integer;
    function Get_missingDisplay: Integer;
    function Get_shortEJMode: Integer;
    function Get_EJLimitNear: Integer;
    function Get_fullEJ: Integer;
    function Get_printCurrency: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IZFPStatus);
    procedure Disconnect; override;
    property DefaultInterface: IZFPStatus read GetDefaultInterface;
    property wrongTimer: Integer read Get_wrongTimer;
    property wrongDate: Integer read Get_wrongDate;
    property wrongRAM: Integer read Get_wrongRAM;
    property clockHardwareError: Integer read Get_clockHardwareError;
    property paperOutPrinterError: Integer read Get_paperOutPrinterError;
    property reportSumOverflow: Integer read Get_reportSumOverflow;
    property printLogo: Integer read Get_printLogo;
    property nonzeroDailyReport: Integer read Get_nonzeroDailyReport;
    property nonzeroArticleReport: Integer read Get_nonzeroArticleReport;
    property nonzeroOperatorReport: Integer read Get_nonzeroOperatorReport;
    property duplicateNotPrinted: Integer read Get_duplicateNotPrinted;
    property openOfficialBon: Integer read Get_openOfficialBon;
    property OpenFiscalBon: Integer read Get_OpenFiscalBon;
    property detailedInfo: Integer read Get_detailedInfo;
    property VATinfo: Integer read Get_VATinfo;
    property missingFiscalMemory: Integer read Get_missingFiscalMemory;
    property wrongFiscalMemory: Integer read Get_wrongFiscalMemory;
    property fullFiscalMemory: Integer read Get_fullFiscalMemory;
    property fiscalMemoryLimitNear: Integer read Get_fiscalMemoryLimitNear;
    property hasDecimalPoint: Integer read Get_hasDecimalPoint;
    property isFiscal: Integer read Get_isFiscal;
    property hasFiscalAndFactoryNum: Integer read Get_hasFiscalAndFactoryNum;
    property autoCutter: Integer read Get_autoCutter;
    property hasTransparentDisplay: Integer read Get_hasTransparentDisplay;
    property baud9600: Integer read Get_baud9600;
    property autoTillOpen: Integer read Get_autoTillOpen;
    property readOnlyFM: Integer read Get_readOnlyFM;
    property powerdown: Integer read Get_powerdown;
    property printerOverheat: Integer read Get_printerOverheat;
    property Blocked24HoursReport: Integer read Get_Blocked24HoursReport;
    property missingDisplay: Integer read Get_missingDisplay;
    property shortEJMode: Integer read Get_shortEJMode;
    property EJLimitNear: Integer read Get_EJLimitNear;
    property fullEJ: Integer read Get_fullEJ;
    property printCurrency: Integer read Get_printCurrency;
    property ST0: Byte read Get_ST0 write Set_ST0;
    property ST1: Byte read Get_ST1 write Set_ST1;
    property ST2: Byte read Get_ST2 write Set_ST2;
    property ST3: Byte read Get_ST3 write Set_ST3;
    property ST4: Byte read Get_ST4 write Set_ST4;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TZFPStatusProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TZFPStatus
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TZFPStatusProperties = class(TPersistent)
  private
    FServer:    TZFPStatus;
    function    GetDefaultInterface: IZFPStatus;
    constructor Create(AServer: TZFPStatus);
  protected
    function Get_ST0: Byte;
    procedure Set_ST0(pVal: Byte);
    function Get_ST1: Byte;
    procedure Set_ST1(pVal: Byte);
    function Get_ST2: Byte;
    procedure Set_ST2(pVal: Byte);
    function Get_ST3: Byte;
    procedure Set_ST3(pVal: Byte);
    function Get_ST4: Byte;
    procedure Set_ST4(pVal: Byte);
    function Get_wrongTimer: Integer;
    function Get_wrongDate: Integer;
    function Get_wrongRAM: Integer;
    function Get_clockHardwareError: Integer;
    function Get_paperOutPrinterError: Integer;
    function Get_reportSumOverflow: Integer;
    function Get_printLogo: Integer;
    function Get_nonzeroDailyReport: Integer;
    function Get_nonzeroArticleReport: Integer;
    function Get_nonzeroOperatorReport: Integer;
    function Get_duplicateNotPrinted: Integer;
    function Get_openOfficialBon: Integer;
    function Get_OpenFiscalBon: Integer;
    function Get_detailedInfo: Integer;
    function Get_VATinfo: Integer;
    function Get_missingFiscalMemory: Integer;
    function Get_wrongFiscalMemory: Integer;
    function Get_fullFiscalMemory: Integer;
    function Get_fiscalMemoryLimitNear: Integer;
    function Get_hasDecimalPoint: Integer;
    function Get_isFiscal: Integer;
    function Get_hasFiscalAndFactoryNum: Integer;
    function Get_autoCutter: Integer;
    function Get_hasTransparentDisplay: Integer;
    function Get_baud9600: Integer;
    function Get_autoTillOpen: Integer;
    function Get_readOnlyFM: Integer;
    function Get_powerdown: Integer;
    function Get_printerOverheat: Integer;
    function Get_Blocked24HoursReport: Integer;
    function Get_missingDisplay: Integer;
    function Get_shortEJMode: Integer;
    function Get_EJLimitNear: Integer;
    function Get_fullEJ: Integer;
    function Get_printCurrency: Integer;
  public
    property DefaultInterface: IZFPStatus read GetDefaultInterface;
  published
    property ST0: Byte read Get_ST0 write Set_ST0;
    property ST1: Byte read Get_ST1 write Set_ST1;
    property ST2: Byte read Get_ST2 write Set_ST2;
    property ST3: Byte read Get_ST3 write Set_ST3;
    property ST4: Byte read Get_ST4 write Set_ST4;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoInvoiceNumbers provides a Create and CreateRemote method to          
// create instances of the default interface IInvoiceNumbers exposed by              
// the CoClass InvoiceNumbers. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoInvoiceNumbers = class
    class function Create: IInvoiceNumbers;
    class function CreateRemote(const MachineName: string): IInvoiceNumbers;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TInvoiceNumbers
// Help String      : InvoiceNumbers Class
// Default Interface: IInvoiceNumbers
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TInvoiceNumbersProperties= class;
{$ENDIF}
  TInvoiceNumbers = class(TOleServer)
  private
    FIntf: IInvoiceNumbers;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TInvoiceNumbersProperties;
    function GetServerProperties: TInvoiceNumbersProperties;
{$ENDIF}
    function GetDefaultInterface: IInvoiceNumbers;
  protected
    procedure InitServerData; override;
    function Get_nextNum: WideString;
    procedure Set_nextNum(const pVal: WideString);
    function Get_lastNum: WideString;
    procedure Set_lastNum(const pVal: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IInvoiceNumbers);
    procedure Disconnect; override;
    property DefaultInterface: IInvoiceNumbers read GetDefaultInterface;
    property nextNum: WideString read Get_nextNum write Set_nextNum;
    property lastNum: WideString read Get_lastNum write Set_lastNum;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TInvoiceNumbersProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TInvoiceNumbers
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TInvoiceNumbersProperties = class(TPersistent)
  private
    FServer:    TInvoiceNumbers;
    function    GetDefaultInterface: IInvoiceNumbers;
    constructor Create(AServer: TInvoiceNumbers);
  protected
    function Get_nextNum: WideString;
    procedure Set_nextNum(const pVal: WideString);
    function Get_lastNum: WideString;
    procedure Set_lastNum(const pVal: WideString);
  public
    property DefaultInterface: IInvoiceNumbers read GetDefaultInterface;
  published
    property nextNum: WideString read Get_nextNum write Set_nextNum;
    property lastNum: WideString read Get_lastNum write Set_lastNum;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'Zeka';

  dtlOcxPage = 'Zeka';

implementation

uses ComObj;

class function CoZekaFP.Create: IZekaFP;
begin
  Result := CreateComObject(CLASS_ZekaFP) as IZekaFP;
end;

class function CoZekaFP.CreateRemote(const MachineName: string): IZekaFP;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ZekaFP) as IZekaFP;
end;

procedure TZekaFP.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2394FFB1-BB5E-4454-9B40-6F75006D27AA}';
    IntfIID:   '{955B3931-1A9C-4E6D-8343-000BEF1E4C27}';
    EventIID:  '{1CF92986-79B9-418F-9D84-F8052A9C6286}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TZekaFP.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IZekaFP;
  end;
end;

procedure TZekaFP.ConnectTo(svrIntf: IZekaFP);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TZekaFP.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TZekaFP.GetDefaultInterface: IZekaFP;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TZekaFP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TZekaFPProperties.Create(Self);
{$ENDIF}
end;

destructor TZekaFP.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TZekaFP.GetServerProperties: TZekaFPProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TZekaFP.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
  end; {case DispID}
end;

function TZekaFP.Get_errorCode: Integer;
begin
    Result := DefaultInterface.errorCode;
end;

function TZekaFP.Get_zfpType: Integer;
begin
    Result := DefaultInterface.zfpType;
end;

procedure TZekaFP.Set_zfpType(pVal: Integer);
begin
  DefaultInterface.Set_zfpType(pVal);
end;

function TZekaFP.Get_zfplibVersion: Integer;
begin
    Result := DefaultInterface.zfplibVersion;
end;

function TZekaFP.GetCurrentBonInfo: IDispatch;
begin
  Result := DefaultInterface.GetCurrentBonInfo;
end;

procedure TZekaFP.Setup(wCom: Word; baud: LongWord; retries: Word; retryWait: LongWord);
begin
  DefaultInterface.Setup(wCom, baud, retries, retryWait);
end;

function TZekaFP.Diagnostic: Integer;
begin
  Result := DefaultInterface.Diagnostic;
end;

function TZekaFP.DisplayClear: Integer;
begin
  Result := DefaultInterface.DisplayClear;
end;

function TZekaFP.DisplayDateTime: Integer;
begin
  Result := DefaultInterface.DisplayDateTime;
end;

function TZekaFP.OpenTill: Integer;
begin
  Result := DefaultInterface.OpenTill;
end;

function TZekaFP.LineFeed: Integer;
begin
  Result := DefaultInterface.LineFeed;
end;

function TZekaFP.printLogo: Integer;
begin
  Result := DefaultInterface.printLogo;
end;

function TZekaFP.CloseBon: Integer;
begin
  Result := DefaultInterface.CloseBon;
end;

function TZekaFP.CloseFiscalBon: Integer;
begin
  Result := DefaultInterface.CloseFiscalBon;
end;

function TZekaFP.PrintDuplicate: Integer;
begin
  Result := DefaultInterface.PrintDuplicate;
end;

function TZekaFP.SetLocalDateTime: Integer;
begin
  Result := DefaultInterface.SetLocalDateTime;
end;

function TZekaFP.GetTaxNumber: WideString;
begin
  Result := DefaultInterface.GetTaxNumber;
end;

function TZekaFP.GetDecimalPoint: Integer;
begin
  Result := DefaultInterface.GetDecimalPoint;
end;

function TZekaFP.GetClicheLine(num: Byte): WideString;
begin
  Result := DefaultInterface.GetClicheLine(num);
end;

function TZekaFP.OpenBon(oper: Byte; const passwd: WideString): Integer;
begin
  Result := DefaultInterface.OpenBon(oper, passwd);
end;

function TZekaFP.OpenFiscalBon(oper: Byte; const passwd: WideString; defPass: Byte; dds: Byte): Integer;
begin
  Result := DefaultInterface.OpenFiscalBon(oper, passwd, defPass, dds);
end;

function TZekaFP.SellFree(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                          discount: Double): Integer;
begin
  Result := DefaultInterface.SellFree(name, taxgrp, price, quantity, discount);
end;

function TZekaFP.Payment(sum: Double; type_: Byte; noRest: Integer): Integer;
begin
  Result := DefaultInterface.Payment(sum, type_, noRest);
end;

function TZekaFP.OfficialSums(num: Byte; const passwd: WideString; type_: Byte; sum: Double): Integer;
begin
  Result := DefaultInterface.OfficialSums(num, passwd, type_, sum);
end;

function TZekaFP.GetBonNumber: Integer;
begin
  Result := DefaultInterface.GetBonNumber;
end;

function TZekaFP.SetPayType(type_: Byte; const line: WideString): Integer;
begin
  Result := DefaultInterface.SetPayType(type_, line);
end;

function TZekaFP.SetParameters(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                               transparent: Integer): Integer;
begin
  Result := DefaultInterface.SetParameters(fpnum, logo, till, autocut, transparent);
end;

function TZekaFP.SetClicheLine(num: Byte; const text: WideString): Integer;
begin
  Result := DefaultInterface.SetClicheLine(num, text);
end;

function TZekaFP.SetOperatorUserPass(oper: Byte; const name: WideString; const passwd: WideString): Integer;
begin
  Result := DefaultInterface.SetOperatorUserPass(oper, name, passwd);
end;

function TZekaFP.SetArticleInfo(num: Word; const name: WideString; price: Double; taxgrp: Byte): Integer;
begin
  Result := DefaultInterface.SetArticleInfo(num, name, price, taxgrp);
end;

function TZekaFP.SetLogoFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SetLogoFile(filename);
end;

function TZekaFP.GetFactoryNumber: WideString;
begin
  Result := DefaultInterface.GetFactoryNumber;
end;

function TZekaFP.GetFiscalNumber: WideString;
begin
  Result := DefaultInterface.GetFiscalNumber;
end;

function TZekaFP.SellDB(isVoid: Integer; number: Word; quantity: Double; discount: Double): Integer;
begin
  Result := DefaultInterface.SellDB(isVoid, number, quantity, discount);
end;

function TZekaFP.GetTaxPercents: IDispatch;
begin
  Result := DefaultInterface.GetTaxPercents;
end;

function TZekaFP.GetPayTypes: IDispatch;
begin
  Result := DefaultInterface.GetPayTypes;
end;

function TZekaFP.GetParameters: IDispatch;
begin
  Result := DefaultInterface.GetParameters;
end;

function TZekaFP.GetOperatorUserPass(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorUserPass(oper);
end;

function TZekaFP.GetDailySums: IDispatch;
begin
  Result := DefaultInterface.GetDailySums;
end;

function TZekaFP.GetArticleInfo(number: Word): IDispatch;
begin
  Result := DefaultInterface.GetArticleInfo(number);
end;

function TZekaFP.GetDailyInfo: IDispatch;
begin
  Result := DefaultInterface.GetDailyInfo;
end;

function TZekaFP.GetOperatorInfo(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorInfo(oper);
end;

function TZekaFP.GetOperatorReceives(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorReceives(oper);
end;

function TZekaFP.GetDateTime: TDateTime;
begin
  Result := DefaultInterface.GetDateTime;
end;

function TZekaFP.Display(const line: WideString): Integer;
begin
  Result := DefaultInterface.Display(line);
end;

function TZekaFP.DisplayLine1(const line: WideString): Integer;
begin
  Result := DefaultInterface.DisplayLine1(line);
end;

function TZekaFP.DisplayLine2(const line: WideString): Integer;
begin
  Result := DefaultInterface.DisplayLine2(line);
end;

function TZekaFP.GetVersion: WideString;
begin
  Result := DefaultInterface.GetVersion;
end;

function TZekaFP.GetInputBuffer: WideString;
begin
  Result := DefaultInterface.GetInputBuffer;
end;

function TZekaFP.GetResponseBuffer: WideString;
begin
  Result := DefaultInterface.GetResponseBuffer;
end;

function TZekaFP.GetInputHexFormated: WideString;
begin
  Result := DefaultInterface.GetInputHexFormated;
end;

function TZekaFP.GetResponseHexFormated: WideString;
begin
  Result := DefaultInterface.GetResponseHexFormated;
end;

function TZekaFP.GetErrorString(error: SYSINT; lang: SYSINT): WideString;
begin
  Result := DefaultInterface.GetErrorString(error, lang);
end;

function TZekaFP.GetOperatorIncomes(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorIncomes(oper);
end;

function TZekaFP.GetOperatorExpenses(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorExpenses(oper);
end;

function TZekaFP.GetDailyPayments: IDispatch;
begin
  Result := DefaultInterface.GetDailyPayments;
end;

function TZekaFP.GetDailyIncomes: IDispatch;
begin
  Result := DefaultInterface.GetDailyIncomes;
end;

function TZekaFP.GetDailyOfficialIncomes: IDispatch;
begin
  Result := DefaultInterface.GetDailyOfficialIncomes;
end;

function TZekaFP.GetDailyOfficialExpenses: IDispatch;
begin
  Result := DefaultInterface.GetDailyOfficialExpenses;
end;

function TZekaFP.CalcIntermediateSum(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                     discount: Double): Double;
begin
  Result := DefaultInterface.CalcIntermediateSum(doprint, dodisplay, dopercents, discount);
end;

function TZekaFP.GetLastFiscalReportData: IDispatch;
begin
  Result := DefaultInterface.GetLastFiscalReportData;
end;

function TZekaFP.ReportSpecialFiscal: Integer;
begin
  Result := DefaultInterface.ReportSpecialFiscal;
end;

function TZekaFP.ReportFiscalByBlock(detailed: Integer; startNumber: Word; endNumber: Word): Integer;
begin
  Result := DefaultInterface.ReportFiscalByBlock(detailed, startNumber, endNumber);
end;

function TZekaFP.ReportDaily(zero: Integer; extended: Integer): Integer;
begin
  Result := DefaultInterface.ReportDaily(zero, extended);
end;

function TZekaFP.ReportArticles(zero: Integer): Integer;
begin
  Result := DefaultInterface.ReportArticles(zero);
end;

function TZekaFP.SetDateTime(datetime: TDateTime): Integer;
begin
  Result := DefaultInterface.SetDateTime(datetime);
end;

function TZekaFP.ReportFiscalByDate(detailed: Integer; start: TDateTime; end_: TDateTime): Integer;
begin
  Result := DefaultInterface.ReportFiscalByDate(detailed, start, end_);
end;

function TZekaFP.ReportOperator(zero: Integer; oper: Byte): Integer;
begin
  Result := DefaultInterface.ReportOperator(zero, oper);
end;

function TZekaFP.PrintText(const text: WideString; align: SYSINT): Integer;
begin
  Result := DefaultInterface.PrintText(text, align);
end;

function TZekaFP.GetDailyReport: IDispatch;
begin
  Result := DefaultInterface.GetDailyReport;
end;

function TZekaFP.GetOperatorCounter(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorCounter(oper);
end;

function TZekaFP.SetExternalDisplayFile(const password: WideString; const filename: WideString): Integer;
begin
  Result := DefaultInterface.SetExternalDisplayFile(password, filename);
end;

function TZekaFP.ReadFiscalMemory(const filename: WideString): Integer;
begin
  Result := DefaultInterface.ReadFiscalMemory(filename);
end;

function TZekaFP.FindFirstFPCOM: LongWord;
begin
  Result := DefaultInterface.FindFirstFPCOM;
end;

function TZekaFP.PaperCut: Integer;
begin
  Result := DefaultInterface.PaperCut;
end;

function TZekaFP.GetStatus: IDispatch;
begin
  Result := DefaultInterface.GetStatus;
end;

function TZekaFP.GetFreeFiscalSpace: Integer;
begin
  Result := DefaultInterface.GetFreeFiscalSpace;
end;

function TZekaFP.OpenInvoice(oper: Byte; const passwd: WideString; const client: WideString; 
                             const receiver: WideString; const vatNum: WideString; 
                             const identNum: WideString; const address: WideString): Integer;
begin
  Result := DefaultInterface.OpenInvoice(oper, passwd, client, receiver, vatNum, identNum, address);
end;

function TZekaFP.BusyWait(timeout: LongWord): Integer;
begin
  Result := DefaultInterface.BusyWait(timeout);
end;

procedure TZekaFP.SetAutoBusyWait(timeout: LongWord);
begin
  DefaultInterface.SetAutoBusyWait(timeout);
end;

function TZekaFP.SetSerialNumber(const password: WideString; const manifactureNum: WideString; 
                                 const fiscalNum: WideString; const controlSum: WideString): Integer;
begin
  Result := DefaultInterface.SetSerialNumber(password, manifactureNum, fiscalNum, controlSum);
end;

function TZekaFP.SetTaxNumber(const password: WideString; const taxNum: WideString; 
                              const fiscalNum: WideString): Integer;
begin
  Result := DefaultInterface.SetTaxNumber(password, taxNum, fiscalNum);
end;

function TZekaFP.MakeFiscal(const password: WideString): Integer;
begin
  Result := DefaultInterface.MakeFiscal(password);
end;

function TZekaFP.SetTaxPercents(const password: WideString; tgr1: Double; tgr2: Double; 
                                tgr3: Double; tgr4: Double): Integer;
begin
  Result := DefaultInterface.SetTaxPercents(password, tgr1, tgr2, tgr3, tgr4);
end;

function TZekaFP.SetDecimalPoint(const password: WideString; point: SYSINT): Integer;
begin
  Result := DefaultInterface.SetDecimalPoint(password, point);
end;

function TZekaFP.GetEJMode: Integer;
begin
  Result := DefaultInterface.GetEJMode;
end;

function TZekaFP.SetEJMode(bShort: Integer): Integer;
begin
  Result := DefaultInterface.SetEJMode(bShort);
end;

function TZekaFP.ReportEJ: Integer;
begin
  Result := DefaultInterface.ReportEJ;
end;

function TZekaFP.SellDepartment(const name: WideString; depNum: Word; price: Double; 
                                quantity: Double; discount: Double): Integer;
begin
  Result := DefaultInterface.SellDepartment(name, depNum, price, quantity, discount);
end;

function TZekaFP.SetDepartment(number: Word; const name: WideString; taxgrp: Byte): Integer;
begin
  Result := DefaultInterface.SetDepartment(number, name, taxgrp);
end;

function TZekaFP.GetDepartment(number: Word): IDispatch;
begin
  Result := DefaultInterface.GetDepartment(number);
end;

function TZekaFP.SetArticleInfoEx(num: Word; const name: WideString; price: Double; taxgrp: Byte; 
                                  department: Word): Integer;
begin
  Result := DefaultInterface.SetArticleInfoEx(num, name, price, taxgrp, department);
end;

function TZekaFP.CalcIntermediateSum2(doprint: Integer; dodisplay: Integer; dopercents: Integer; 
                                      discount: Double; taxgrp: Smallint): Double;
begin
  Result := DefaultInterface.CalcIntermediateSum2(doprint, dodisplay, dopercents, discount, taxgrp);
end;

function TZekaFP.ReportEJ2(num: Word): Integer;
begin
  Result := DefaultInterface.ReportEJ2(num);
end;

function TZekaFP.SetTaxPercentsEU(const password: WideString; tgr1: Double; tgr2: Double; 
                                  tgr3: Double; tgr4: Double; tgr5: Double; tgr6: Double; 
                                  tgr7: Double; tgr8: Double): Integer;
begin
  Result := DefaultInterface.SetTaxPercentsEU(password, tgr1, tgr2, tgr3, tgr4, tgr5, tgr6, tgr7, 
                                              tgr8);
end;

function TZekaFP.SetPayTypeEU(type_: Byte; const line: WideString; exchRate: Double): Integer;
begin
  Result := DefaultInterface.SetPayTypeEU(type_, line, exchRate);
end;

function TZekaFP.GetOperatorChangeEU(oper: Byte): IDispatch;
begin
  Result := DefaultInterface.GetOperatorChangeEU(oper);
end;

function TZekaFP.SetInvoiceNumbersRangeEU(const startNum: WideString; const lastNum: WideString): Integer;
begin
  Result := DefaultInterface.SetInvoiceNumbersRangeEU(startNum, lastNum);
end;

function TZekaFP.PaymentEU(sum: Double; type_: Byte; noChange: Integer; changeType: Byte): Integer;
begin
  Result := DefaultInterface.PaymentEU(sum, type_, noChange, changeType);
end;

function TZekaFP.SetParametersEU(fpnum: Word; logo: Integer; till: Integer; autocut: Integer; 
                                 transparent: Integer; shortEJ: Integer; currency: Integer): Integer;
begin
  Result := DefaultInterface.SetParametersEU(fpnum, logo, till, autocut, transparent, shortEJ, 
                                             currency);
end;

function TZekaFP.SendCommandDirect(const cmd: WideString): WideString;
begin
  Result := DefaultInterface.SendCommandDirect(cmd);
end;

function TZekaFP.GetDailyChangeEU: IDispatch;
begin
  Result := DefaultInterface.GetDailyChangeEU;
end;

function TZekaFP.UpdateClicheKE(mode: Byte; const password: WideString): Integer;
begin
  Result := DefaultInterface.UpdateClicheKE(mode, password);
end;

procedure TZekaFP.Setup2(wCom: Byte; baud: Integer; retries: Integer; retryWait: Integer);
begin
  DefaultInterface.Setup2(wCom, baud, retries, retryWait);
end;

function TZekaFP.OpenBonWithEJ(oper: Byte; const passwd: WideString; hasEJ: Integer): Integer;
begin
  Result := DefaultInterface.OpenBonWithEJ(oper, passwd, hasEJ);
end;

function TZekaFP.GetInvoiceNextNumberEU: IDispatch;
begin
  Result := DefaultInterface.GetInvoiceNextNumberEU;
end;

function TZekaFP.SetLogo(logo: Shortint): Integer;
begin
  Result := DefaultInterface.SetLogo(logo);
end;

function TZekaFP.GetLogoInfo: WideString;
begin
  Result := DefaultInterface.GetLogoInfo;
end;

function TZekaFP.FindFirstFPCOMEx: LongWord;
begin
  Result := DefaultInterface.FindFirstFPCOMEx;
end;

function TZekaFP.SetLogoFileEx(logo_id: Shortint; const filename: WideString): Integer;
begin
  Result := DefaultInterface.SetLogoFileEx(logo_id, filename);
end;

function TZekaFP.PrintLogoEx(logo_id: Shortint): Integer;
begin
  Result := DefaultInterface.PrintLogoEx(logo_id);
end;

function TZekaFP.CloseBonInCash: Integer;
begin
  Result := DefaultInterface.CloseBonInCash;
end;

function TZekaFP.PaymentEx(sum: Double; type_: Byte; noChange: Integer; changeType: Byte; 
                           fPaidExactSum: Integer): Integer;
begin
  Result := DefaultInterface.PaymentEx(sum, type_, noChange, changeType, fPaidExactSum);
end;

function TZekaFP.GetVersionGS: WideString;
begin
  Result := DefaultInterface.GetVersionGS;
end;

function TZekaFP.EnableCommGS(__MIDL_0015: Shortint; device_no: Word): Integer;
begin
  Result := DefaultInterface.EnableCommGS(__MIDL_0015, device_no);
end;

function TZekaFP.SetSpeedGS(speed: Shortint): Integer;
begin
  Result := DefaultInterface.SetSpeedGS(speed);
end;

function TZekaFP.LoadScaleProtocolGS(const protocol: WideString): Integer;
begin
  Result := DefaultInterface.LoadScaleProtocolGS(protocol);
end;

function TZekaFP.SellDepartmentEx(const name: WideString; depNum: Word; price: Double; 
                                  quantity: Double; discount: Double; flag: Shortint): Integer;
begin
  Result := DefaultInterface.SellDepartmentEx(name, depNum, price, quantity, discount, flag);
end;

function TZekaFP.SellFreeEx(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                            discount: Double; flag: Shortint): Integer;
begin
  Result := DefaultInterface.SellFreeEx(name, taxgrp, price, quantity, discount, flag);
end;

function TZekaFP.SellDBEx(isVoid: Integer; number: LongWord; quantity: Double; discount: Double; 
                          flag: Shortint): Integer;
begin
  Result := DefaultInterface.SellDBEx(isVoid, number, quantity, discount, flag);
end;

function TZekaFP.GetArticleInfoEx(number: LongWord): IDispatch;
begin
  Result := DefaultInterface.GetArticleInfoEx(number);
end;

function TZekaFP.SetArticleInfo2(num: LongWord; const name: WideString; price: Double; 
                                 taxgrp: Byte; department: Word): Integer;
begin
  Result := DefaultInterface.SetArticleInfo2(num, name, price, taxgrp, department);
end;

function TZekaFP.ReportDepartments(zero: Integer): Integer;
begin
  Result := DefaultInterface.ReportDepartments(zero);
end;

function TZekaFP.OfficialSumsEx(num: Byte; const passwd: WideString; type_: Byte; sum: Double; 
                                const note: WideString): Integer;
begin
  Result := DefaultInterface.OfficialSumsEx(num, passwd, type_, sum, note);
end;

function TZekaFP.EnableBarcode(__MIDL_0016: Shortint): Integer;
begin
  Result := DefaultInterface.EnableBarcode(__MIDL_0016);
end;

function TZekaFP.FormatBarcode(const __MIDL_0017: WideString): Integer;
begin
  Result := DefaultInterface.FormatBarcode(__MIDL_0017);
end;

function TZekaFP.PrintBarcode(const __MIDL_0018: WideString; __MIDL_0019: Byte): Integer;
begin
  Result := DefaultInterface.PrintBarcode(__MIDL_0018, __MIDL_0019);
end;

function TZekaFP.SetLineWidth(__MIDL_0020: SYSINT): Integer;
begin
  Result := DefaultInterface.SetLineWidth(__MIDL_0020);
end;

function TZekaFP.SetPrintMode(__MIDL_0021: LongWord): Integer;
begin
  Result := DefaultInterface.SetPrintMode(__MIDL_0021);
end;

function TZekaFP.OpenTillEx(__MIDL_0022: Shortint): Integer;
begin
  Result := DefaultInterface.OpenTillEx(__MIDL_0022);
end;

function TZekaFP.OpenSerialPort: Integer;
begin
  Result := DefaultInterface.OpenSerialPort;
end;

function TZekaFP.CloseSerialPort: Integer;
begin
  Result := DefaultInterface.CloseSerialPort;
end;

function TZekaFP.Storno(const name: WideString; taxgrp: Byte; price: Double; quantity: Double): Integer;
begin
  Result := DefaultInterface.Storno(name, taxgrp, price, quantity);
end;

function TZekaFP.SellFreeDiv(const name: WideString; taxgrp: Byte; price: Double; quantity: Double; 
                             discount: Double; flag: Shortint; divider: LongWord): Integer;
begin
  Result := DefaultInterface.SellFreeDiv(name, taxgrp, price, quantity, discount, flag, divider);
end;

function TZekaFP.TerminateBon(__MIDL_0023: Integer): Integer;
begin
  Result := DefaultInterface.TerminateBon(__MIDL_0023);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TZekaFPProperties.Create(AServer: TZekaFP);
begin
  inherited Create;
  FServer := AServer;
end;

function TZekaFPProperties.GetDefaultInterface: IZekaFP;
begin
  Result := FServer.DefaultInterface;
end;

function TZekaFPProperties.Get_errorCode: Integer;
begin
    Result := DefaultInterface.errorCode;
end;

function TZekaFPProperties.Get_zfpType: Integer;
begin
    Result := DefaultInterface.zfpType;
end;

procedure TZekaFPProperties.Set_zfpType(pVal: Integer);
begin
  DefaultInterface.Set_zfpType(pVal);
end;

function TZekaFPProperties.Get_zfplibVersion: Integer;
begin
    Result := DefaultInterface.zfplibVersion;
end;

{$ENDIF}

class function CoGetCurrentBonInfoRes.Create: IGetCurrentBonInfoRes;
begin
  Result := CreateComObject(CLASS_GetCurrentBonInfoRes) as IGetCurrentBonInfoRes;
end;

class function CoGetCurrentBonInfoRes.CreateRemote(const MachineName: string): IGetCurrentBonInfoRes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetCurrentBonInfoRes) as IGetCurrentBonInfoRes;
end;

procedure TGetCurrentBonInfoRes.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A52D1058-A873-4BE7-A94C-1A5DF6E6D345}';
    IntfIID:   '{15F4A466-C600-48AD-9138-AE4E5734ED8B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetCurrentBonInfoRes.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IGetCurrentBonInfoRes;
  end;
end;

procedure TGetCurrentBonInfoRes.ConnectTo(svrIntf: IGetCurrentBonInfoRes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetCurrentBonInfoRes.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetCurrentBonInfoRes.GetDefaultInterface: IGetCurrentBonInfoRes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetCurrentBonInfoRes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TGetCurrentBonInfoResProperties.Create(Self);
{$ENDIF}
end;

destructor TGetCurrentBonInfoRes.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TGetCurrentBonInfoRes.GetServerProperties: TGetCurrentBonInfoResProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TGetCurrentBonInfoRes.Get_flags: Integer;
begin
    Result := DefaultInterface.flags;
end;

procedure TGetCurrentBonInfoRes.Set_flags(pVal: Integer);
begin
  DefaultInterface.Set_flags(pVal);
end;

function TGetCurrentBonInfoRes.Get_purchases: Integer;
begin
    Result := DefaultInterface.purchases;
end;

procedure TGetCurrentBonInfoRes.Set_purchases(pVal: Integer);
begin
  DefaultInterface.Set_purchases(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp1: Double;
begin
    Result := DefaultInterface.taxgrp1;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp1(pVal: Double);
begin
  DefaultInterface.Set_taxgrp1(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp2: Double;
begin
    Result := DefaultInterface.taxgrp2;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp2(pVal: Double);
begin
  DefaultInterface.Set_taxgrp2(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp3: Double;
begin
    Result := DefaultInterface.taxgrp3;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp3(pVal: Double);
begin
  DefaultInterface.Set_taxgrp3(pVal);
end;

function TGetCurrentBonInfoRes.Get_novoid: Integer;
begin
    Result := DefaultInterface.novoid;
end;

procedure TGetCurrentBonInfoRes.Set_novoid(pVal: Integer);
begin
  DefaultInterface.Set_novoid(pVal);
end;

function TGetCurrentBonInfoRes.Get_dds: Integer;
begin
    Result := DefaultInterface.dds;
end;

procedure TGetCurrentBonInfoRes.Set_dds(pVal: Integer);
begin
  DefaultInterface.Set_dds(pVal);
end;

function TGetCurrentBonInfoRes.Get_detailed: Integer;
begin
    Result := DefaultInterface.detailed;
end;

procedure TGetCurrentBonInfoRes.Set_detailed(pVal: Integer);
begin
  DefaultInterface.Set_detailed(pVal);
end;

function TGetCurrentBonInfoRes.Get_paystarted: Integer;
begin
    Result := DefaultInterface.paystarted;
end;

procedure TGetCurrentBonInfoRes.Set_paystarted(pVal: Integer);
begin
  DefaultInterface.Set_paystarted(pVal);
end;

function TGetCurrentBonInfoRes.Get_paid: Integer;
begin
    Result := DefaultInterface.paid;
end;

procedure TGetCurrentBonInfoRes.Set_paid(pVal: Integer);
begin
  DefaultInterface.Set_paid(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp4: Double;
begin
    Result := DefaultInterface.taxgrp4;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp4(pVal: Double);
begin
  DefaultInterface.Set_taxgrp4(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp5: Double;
begin
    Result := DefaultInterface.taxgrp5;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp5(pVal: Double);
begin
  DefaultInterface.Set_taxgrp5(pVal);
end;

function TGetCurrentBonInfoRes.Get_powerdown: Integer;
begin
    Result := DefaultInterface.powerdown;
end;

procedure TGetCurrentBonInfoRes.Set_powerdown(pVal: Integer);
begin
  DefaultInterface.Set_powerdown(pVal);
end;

function TGetCurrentBonInfoRes.Get_invoice: Integer;
begin
    Result := DefaultInterface.invoice;
end;

procedure TGetCurrentBonInfoRes.Set_invoice(pVal: Integer);
begin
  DefaultInterface.Set_invoice(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp6: Double;
begin
    Result := DefaultInterface.taxgrp6;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp6(pVal: Double);
begin
  DefaultInterface.Set_taxgrp6(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp7: Double;
begin
    Result := DefaultInterface.taxgrp7;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp7(pVal: Double);
begin
  DefaultInterface.Set_taxgrp7(pVal);
end;

function TGetCurrentBonInfoRes.Get_taxgrp8: Double;
begin
    Result := DefaultInterface.taxgrp8;
end;

procedure TGetCurrentBonInfoRes.Set_taxgrp8(pVal: Double);
begin
  DefaultInterface.Set_taxgrp8(pVal);
end;

function TGetCurrentBonInfoRes.Get_change: Double;
begin
    Result := DefaultInterface.change;
end;

procedure TGetCurrentBonInfoRes.Set_change(pVal: Double);
begin
  DefaultInterface.Set_change(pVal);
end;

function TGetCurrentBonInfoRes.Get_changeType: Smallint;
begin
    Result := DefaultInterface.changeType;
end;

procedure TGetCurrentBonInfoRes.Set_changeType(pVal: Smallint);
begin
  DefaultInterface.Set_changeType(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TGetCurrentBonInfoResProperties.Create(AServer: TGetCurrentBonInfoRes);
begin
  inherited Create;
  FServer := AServer;
end;

function TGetCurrentBonInfoResProperties.GetDefaultInterface: IGetCurrentBonInfoRes;
begin
  Result := FServer.DefaultInterface;
end;

function TGetCurrentBonInfoResProperties.Get_flags: Integer;
begin
    Result := DefaultInterface.flags;
end;

procedure TGetCurrentBonInfoResProperties.Set_flags(pVal: Integer);
begin
  DefaultInterface.Set_flags(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_purchases: Integer;
begin
    Result := DefaultInterface.purchases;
end;

procedure TGetCurrentBonInfoResProperties.Set_purchases(pVal: Integer);
begin
  DefaultInterface.Set_purchases(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp1: Double;
begin
    Result := DefaultInterface.taxgrp1;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp1(pVal: Double);
begin
  DefaultInterface.Set_taxgrp1(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp2: Double;
begin
    Result := DefaultInterface.taxgrp2;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp2(pVal: Double);
begin
  DefaultInterface.Set_taxgrp2(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp3: Double;
begin
    Result := DefaultInterface.taxgrp3;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp3(pVal: Double);
begin
  DefaultInterface.Set_taxgrp3(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_novoid: Integer;
begin
    Result := DefaultInterface.novoid;
end;

procedure TGetCurrentBonInfoResProperties.Set_novoid(pVal: Integer);
begin
  DefaultInterface.Set_novoid(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_dds: Integer;
begin
    Result := DefaultInterface.dds;
end;

procedure TGetCurrentBonInfoResProperties.Set_dds(pVal: Integer);
begin
  DefaultInterface.Set_dds(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_detailed: Integer;
begin
    Result := DefaultInterface.detailed;
end;

procedure TGetCurrentBonInfoResProperties.Set_detailed(pVal: Integer);
begin
  DefaultInterface.Set_detailed(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_paystarted: Integer;
begin
    Result := DefaultInterface.paystarted;
end;

procedure TGetCurrentBonInfoResProperties.Set_paystarted(pVal: Integer);
begin
  DefaultInterface.Set_paystarted(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_paid: Integer;
begin
    Result := DefaultInterface.paid;
end;

procedure TGetCurrentBonInfoResProperties.Set_paid(pVal: Integer);
begin
  DefaultInterface.Set_paid(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp4: Double;
begin
    Result := DefaultInterface.taxgrp4;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp4(pVal: Double);
begin
  DefaultInterface.Set_taxgrp4(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp5: Double;
begin
    Result := DefaultInterface.taxgrp5;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp5(pVal: Double);
begin
  DefaultInterface.Set_taxgrp5(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_powerdown: Integer;
begin
    Result := DefaultInterface.powerdown;
end;

procedure TGetCurrentBonInfoResProperties.Set_powerdown(pVal: Integer);
begin
  DefaultInterface.Set_powerdown(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_invoice: Integer;
begin
    Result := DefaultInterface.invoice;
end;

procedure TGetCurrentBonInfoResProperties.Set_invoice(pVal: Integer);
begin
  DefaultInterface.Set_invoice(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp6: Double;
begin
    Result := DefaultInterface.taxgrp6;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp6(pVal: Double);
begin
  DefaultInterface.Set_taxgrp6(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp7: Double;
begin
    Result := DefaultInterface.taxgrp7;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp7(pVal: Double);
begin
  DefaultInterface.Set_taxgrp7(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_taxgrp8: Double;
begin
    Result := DefaultInterface.taxgrp8;
end;

procedure TGetCurrentBonInfoResProperties.Set_taxgrp8(pVal: Double);
begin
  DefaultInterface.Set_taxgrp8(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_change: Double;
begin
    Result := DefaultInterface.change;
end;

procedure TGetCurrentBonInfoResProperties.Set_change(pVal: Double);
begin
  DefaultInterface.Set_change(pVal);
end;

function TGetCurrentBonInfoResProperties.Get_changeType: Smallint;
begin
    Result := DefaultInterface.changeType;
end;

procedure TGetCurrentBonInfoResProperties.Set_changeType(pVal: Smallint);
begin
  DefaultInterface.Set_changeType(pVal);
end;

{$ENDIF}

class function CoTaxNumbers.Create: ITaxNumbers;
begin
  Result := CreateComObject(CLASS_TaxNumbers) as ITaxNumbers;
end;

class function CoTaxNumbers.CreateRemote(const MachineName: string): ITaxNumbers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TaxNumbers) as ITaxNumbers;
end;

procedure TTaxNumbers.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5C5335AF-6042-4246-94CE-4343FD3F7872}';
    IntfIID:   '{C58962A1-28FB-422A-B3BB-2435C4CB559F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTaxNumbers.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ITaxNumbers;
  end;
end;

procedure TTaxNumbers.ConnectTo(svrIntf: ITaxNumbers);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTaxNumbers.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTaxNumbers.GetDefaultInterface: ITaxNumbers;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TTaxNumbers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTaxNumbersProperties.Create(Self);
{$ENDIF}
end;

destructor TTaxNumbers.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTaxNumbers.GetServerProperties: TTaxNumbersProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TTaxNumbers.Get_taxgrp1: Double;
begin
    Result := DefaultInterface.taxgrp1;
end;

procedure TTaxNumbers.Set_taxgrp1(pVal: Double);
begin
  DefaultInterface.Set_taxgrp1(pVal);
end;

function TTaxNumbers.Get_taxgrp2: Double;
begin
    Result := DefaultInterface.taxgrp2;
end;

procedure TTaxNumbers.Set_taxgrp2(pVal: Double);
begin
  DefaultInterface.Set_taxgrp2(pVal);
end;

function TTaxNumbers.Get_taxgrp3: Double;
begin
    Result := DefaultInterface.taxgrp3;
end;

procedure TTaxNumbers.Set_taxgrp3(pVal: Double);
begin
  DefaultInterface.Set_taxgrp3(pVal);
end;

function TTaxNumbers.Get_taxgrp4: Double;
begin
    Result := DefaultInterface.taxgrp4;
end;

procedure TTaxNumbers.Set_taxgrp4(pVal: Double);
begin
  DefaultInterface.Set_taxgrp4(pVal);
end;

function TTaxNumbers.Get_taxgrp5: Double;
begin
    Result := DefaultInterface.taxgrp5;
end;

procedure TTaxNumbers.Set_taxgrp5(pVal: Double);
begin
  DefaultInterface.Set_taxgrp5(pVal);
end;

function TTaxNumbers.Get_taxgrp6: Double;
begin
    Result := DefaultInterface.taxgrp6;
end;

procedure TTaxNumbers.Set_taxgrp6(pVal: Double);
begin
  DefaultInterface.Set_taxgrp6(pVal);
end;

function TTaxNumbers.Get_taxgrp7: Double;
begin
    Result := DefaultInterface.taxgrp7;
end;

procedure TTaxNumbers.Set_taxgrp7(pVal: Double);
begin
  DefaultInterface.Set_taxgrp7(pVal);
end;

function TTaxNumbers.Get_taxgrp8: Double;
begin
    Result := DefaultInterface.taxgrp8;
end;

procedure TTaxNumbers.Set_taxgrp8(pVal: Double);
begin
  DefaultInterface.Set_taxgrp8(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTaxNumbersProperties.Create(AServer: TTaxNumbers);
begin
  inherited Create;
  FServer := AServer;
end;

function TTaxNumbersProperties.GetDefaultInterface: ITaxNumbers;
begin
  Result := FServer.DefaultInterface;
end;

function TTaxNumbersProperties.Get_taxgrp1: Double;
begin
    Result := DefaultInterface.taxgrp1;
end;

procedure TTaxNumbersProperties.Set_taxgrp1(pVal: Double);
begin
  DefaultInterface.Set_taxgrp1(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp2: Double;
begin
    Result := DefaultInterface.taxgrp2;
end;

procedure TTaxNumbersProperties.Set_taxgrp2(pVal: Double);
begin
  DefaultInterface.Set_taxgrp2(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp3: Double;
begin
    Result := DefaultInterface.taxgrp3;
end;

procedure TTaxNumbersProperties.Set_taxgrp3(pVal: Double);
begin
  DefaultInterface.Set_taxgrp3(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp4: Double;
begin
    Result := DefaultInterface.taxgrp4;
end;

procedure TTaxNumbersProperties.Set_taxgrp4(pVal: Double);
begin
  DefaultInterface.Set_taxgrp4(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp5: Double;
begin
    Result := DefaultInterface.taxgrp5;
end;

procedure TTaxNumbersProperties.Set_taxgrp5(pVal: Double);
begin
  DefaultInterface.Set_taxgrp5(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp6: Double;
begin
    Result := DefaultInterface.taxgrp6;
end;

procedure TTaxNumbersProperties.Set_taxgrp6(pVal: Double);
begin
  DefaultInterface.Set_taxgrp6(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp7: Double;
begin
    Result := DefaultInterface.taxgrp7;
end;

procedure TTaxNumbersProperties.Set_taxgrp7(pVal: Double);
begin
  DefaultInterface.Set_taxgrp7(pVal);
end;

function TTaxNumbersProperties.Get_taxgrp8: Double;
begin
    Result := DefaultInterface.taxgrp8;
end;

procedure TTaxNumbersProperties.Set_taxgrp8(pVal: Double);
begin
  DefaultInterface.Set_taxgrp8(pVal);
end;

{$ENDIF}

class function CoPayTypes.Create: IPayTypes;
begin
  Result := CreateComObject(CLASS_PayTypes) as IPayTypes;
end;

class function CoPayTypes.CreateRemote(const MachineName: string): IPayTypes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PayTypes) as IPayTypes;
end;

procedure TPayTypes.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5F26D9CE-4B61-43B6-900F-ABB48F5AA6A6}';
    IntfIID:   '{29F4A8DC-786A-4274-A771-4B5C05003536}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPayTypes.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IPayTypes;
  end;
end;

procedure TPayTypes.ConnectTo(svrIntf: IPayTypes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPayTypes.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPayTypes.GetDefaultInterface: IPayTypes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TPayTypes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPayTypesProperties.Create(Self);
{$ENDIF}
end;

destructor TPayTypes.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPayTypes.GetServerProperties: TPayTypesProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TPayTypes.Get_paytype1: WideString;
begin
    Result := DefaultInterface.paytype1;
end;

procedure TPayTypes.Set_paytype1(const pVal: WideString);
  { Warning: The property paytype1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype1 := pVal;
end;

function TPayTypes.Get_paytype2: WideString;
begin
    Result := DefaultInterface.paytype2;
end;

procedure TPayTypes.Set_paytype2(const pVal: WideString);
  { Warning: The property paytype2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype2 := pVal;
end;

function TPayTypes.Get_paytype3: WideString;
begin
    Result := DefaultInterface.paytype3;
end;

procedure TPayTypes.Set_paytype3(const pVal: WideString);
  { Warning: The property paytype3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype3 := pVal;
end;

function TPayTypes.Get_paytype4: WideString;
begin
    Result := DefaultInterface.paytype4;
end;

procedure TPayTypes.Set_paytype4(const pVal: WideString);
  { Warning: The property paytype4 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype4 := pVal;
end;

function TPayTypes.Get_paytype0: WideString;
begin
    Result := DefaultInterface.paytype0;
end;

procedure TPayTypes.Set_paytype0(const pVal: WideString);
  { Warning: The property paytype0 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype0 := pVal;
end;

function TPayTypes.Get_paytype1sum: Double;
begin
    Result := DefaultInterface.paytype1sum;
end;

procedure TPayTypes.Set_paytype1sum(pVal: Double);
begin
  DefaultInterface.Set_paytype1sum(pVal);
end;

function TPayTypes.Get_paytype2sum: Double;
begin
    Result := DefaultInterface.paytype2sum;
end;

procedure TPayTypes.Set_paytype2sum(pVal: Double);
begin
  DefaultInterface.Set_paytype2sum(pVal);
end;

function TPayTypes.Get_paytype3sum: Double;
begin
    Result := DefaultInterface.paytype3sum;
end;

procedure TPayTypes.Set_paytype3sum(pVal: Double);
begin
  DefaultInterface.Set_paytype3sum(pVal);
end;

function TPayTypes.Get_paytype4sum: Double;
begin
    Result := DefaultInterface.paytype4sum;
end;

procedure TPayTypes.Set_paytype4sum(pVal: Double);
begin
  DefaultInterface.Set_paytype4sum(pVal);
end;

function TPayTypes.Get_paytype0sum: Double;
begin
    Result := DefaultInterface.paytype0sum;
end;

procedure TPayTypes.Set_paytype0sum(pVal: Double);
begin
  DefaultInterface.Set_paytype0sum(pVal);
end;

function TPayTypes.Get_operations: Integer;
begin
    Result := DefaultInterface.operations;
end;

procedure TPayTypes.Set_operations(pVal: Integer);
begin
  DefaultInterface.Set_operations(pVal);
end;

function TPayTypes.Get_exchRate: Double;
begin
    Result := DefaultInterface.exchRate;
end;

procedure TPayTypes.Set_exchRate(pVal: Double);
begin
  DefaultInterface.Set_exchRate(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPayTypesProperties.Create(AServer: TPayTypes);
begin
  inherited Create;
  FServer := AServer;
end;

function TPayTypesProperties.GetDefaultInterface: IPayTypes;
begin
  Result := FServer.DefaultInterface;
end;

function TPayTypesProperties.Get_paytype1: WideString;
begin
    Result := DefaultInterface.paytype1;
end;

procedure TPayTypesProperties.Set_paytype1(const pVal: WideString);
  { Warning: The property paytype1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype1 := pVal;
end;

function TPayTypesProperties.Get_paytype2: WideString;
begin
    Result := DefaultInterface.paytype2;
end;

procedure TPayTypesProperties.Set_paytype2(const pVal: WideString);
  { Warning: The property paytype2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype2 := pVal;
end;

function TPayTypesProperties.Get_paytype3: WideString;
begin
    Result := DefaultInterface.paytype3;
end;

procedure TPayTypesProperties.Set_paytype3(const pVal: WideString);
  { Warning: The property paytype3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype3 := pVal;
end;

function TPayTypesProperties.Get_paytype4: WideString;
begin
    Result := DefaultInterface.paytype4;
end;

procedure TPayTypesProperties.Set_paytype4(const pVal: WideString);
  { Warning: The property paytype4 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype4 := pVal;
end;

function TPayTypesProperties.Get_paytype0: WideString;
begin
    Result := DefaultInterface.paytype0;
end;

procedure TPayTypesProperties.Set_paytype0(const pVal: WideString);
  { Warning: The property paytype0 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.paytype0 := pVal;
end;

function TPayTypesProperties.Get_paytype1sum: Double;
begin
    Result := DefaultInterface.paytype1sum;
end;

procedure TPayTypesProperties.Set_paytype1sum(pVal: Double);
begin
  DefaultInterface.Set_paytype1sum(pVal);
end;

function TPayTypesProperties.Get_paytype2sum: Double;
begin
    Result := DefaultInterface.paytype2sum;
end;

procedure TPayTypesProperties.Set_paytype2sum(pVal: Double);
begin
  DefaultInterface.Set_paytype2sum(pVal);
end;

function TPayTypesProperties.Get_paytype3sum: Double;
begin
    Result := DefaultInterface.paytype3sum;
end;

procedure TPayTypesProperties.Set_paytype3sum(pVal: Double);
begin
  DefaultInterface.Set_paytype3sum(pVal);
end;

function TPayTypesProperties.Get_paytype4sum: Double;
begin
    Result := DefaultInterface.paytype4sum;
end;

procedure TPayTypesProperties.Set_paytype4sum(pVal: Double);
begin
  DefaultInterface.Set_paytype4sum(pVal);
end;

function TPayTypesProperties.Get_paytype0sum: Double;
begin
    Result := DefaultInterface.paytype0sum;
end;

procedure TPayTypesProperties.Set_paytype0sum(pVal: Double);
begin
  DefaultInterface.Set_paytype0sum(pVal);
end;

function TPayTypesProperties.Get_operations: Integer;
begin
    Result := DefaultInterface.operations;
end;

procedure TPayTypesProperties.Set_operations(pVal: Integer);
begin
  DefaultInterface.Set_operations(pVal);
end;

function TPayTypesProperties.Get_exchRate: Double;
begin
    Result := DefaultInterface.exchRate;
end;

procedure TPayTypesProperties.Set_exchRate(pVal: Double);
begin
  DefaultInterface.Set_exchRate(pVal);
end;

{$ENDIF}

class function CoZFPParameters.Create: IZFPParameters;
begin
  Result := CreateComObject(CLASS_ZFPParameters) as IZFPParameters;
end;

class function CoZFPParameters.CreateRemote(const MachineName: string): IZFPParameters;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ZFPParameters) as IZFPParameters;
end;

procedure TZFPParameters.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{75E2C498-0DAE-4CFC-BD3F-20CBEC338EA7}';
    IntfIID:   '{71FD4FFE-545C-4CE3-B3CF-8F2A7DEA8277}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TZFPParameters.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IZFPParameters;
  end;
end;

procedure TZFPParameters.ConnectTo(svrIntf: IZFPParameters);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TZFPParameters.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TZFPParameters.GetDefaultInterface: IZFPParameters;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TZFPParameters.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TZFPParametersProperties.Create(Self);
{$ENDIF}
end;

destructor TZFPParameters.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TZFPParameters.GetServerProperties: TZFPParametersProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TZFPParameters.Get_fpnum: Integer;
begin
    Result := DefaultInterface.fpnum;
end;

procedure TZFPParameters.Set_fpnum(pVal: Integer);
begin
  DefaultInterface.Set_fpnum(pVal);
end;

function TZFPParameters.Get_logo: Integer;
begin
    Result := DefaultInterface.logo;
end;

procedure TZFPParameters.Set_logo(pVal: Integer);
begin
  DefaultInterface.Set_logo(pVal);
end;

function TZFPParameters.Get_till: Integer;
begin
    Result := DefaultInterface.till;
end;

procedure TZFPParameters.Set_till(pVal: Integer);
begin
  DefaultInterface.Set_till(pVal);
end;

function TZFPParameters.Get_autocut: Integer;
begin
    Result := DefaultInterface.autocut;
end;

procedure TZFPParameters.Set_autocut(pVal: Integer);
begin
  DefaultInterface.Set_autocut(pVal);
end;

function TZFPParameters.Get_transparent: Integer;
begin
    Result := DefaultInterface.transparent;
end;

procedure TZFPParameters.Set_transparent(pVal: Integer);
begin
  DefaultInterface.Set_transparent(pVal);
end;

function TZFPParameters.Get_shortEJ: Integer;
begin
    Result := DefaultInterface.shortEJ;
end;

procedure TZFPParameters.Set_shortEJ(pVal: Integer);
begin
  DefaultInterface.Set_shortEJ(pVal);
end;

function TZFPParameters.Get_currency: Integer;
begin
    Result := DefaultInterface.currency;
end;

procedure TZFPParameters.Set_currency(pVal: Integer);
begin
  DefaultInterface.Set_currency(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TZFPParametersProperties.Create(AServer: TZFPParameters);
begin
  inherited Create;
  FServer := AServer;
end;

function TZFPParametersProperties.GetDefaultInterface: IZFPParameters;
begin
  Result := FServer.DefaultInterface;
end;

function TZFPParametersProperties.Get_fpnum: Integer;
begin
    Result := DefaultInterface.fpnum;
end;

procedure TZFPParametersProperties.Set_fpnum(pVal: Integer);
begin
  DefaultInterface.Set_fpnum(pVal);
end;

function TZFPParametersProperties.Get_logo: Integer;
begin
    Result := DefaultInterface.logo;
end;

procedure TZFPParametersProperties.Set_logo(pVal: Integer);
begin
  DefaultInterface.Set_logo(pVal);
end;

function TZFPParametersProperties.Get_till: Integer;
begin
    Result := DefaultInterface.till;
end;

procedure TZFPParametersProperties.Set_till(pVal: Integer);
begin
  DefaultInterface.Set_till(pVal);
end;

function TZFPParametersProperties.Get_autocut: Integer;
begin
    Result := DefaultInterface.autocut;
end;

procedure TZFPParametersProperties.Set_autocut(pVal: Integer);
begin
  DefaultInterface.Set_autocut(pVal);
end;

function TZFPParametersProperties.Get_transparent: Integer;
begin
    Result := DefaultInterface.transparent;
end;

procedure TZFPParametersProperties.Set_transparent(pVal: Integer);
begin
  DefaultInterface.Set_transparent(pVal);
end;

function TZFPParametersProperties.Get_shortEJ: Integer;
begin
    Result := DefaultInterface.shortEJ;
end;

procedure TZFPParametersProperties.Set_shortEJ(pVal: Integer);
begin
  DefaultInterface.Set_shortEJ(pVal);
end;

function TZFPParametersProperties.Get_currency: Integer;
begin
    Result := DefaultInterface.currency;
end;

procedure TZFPParametersProperties.Set_currency(pVal: Integer);
begin
  DefaultInterface.Set_currency(pVal);
end;

{$ENDIF}

class function CoOperatorInfo.Create: IOperatorInfo;
begin
  Result := CreateComObject(CLASS_OperatorInfo) as IOperatorInfo;
end;

class function CoOperatorInfo.CreateRemote(const MachineName: string): IOperatorInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OperatorInfo) as IOperatorInfo;
end;

procedure TOperatorInfo.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{97866887-9FF8-4D60-A7EE-132E46587FA5}';
    IntfIID:   '{72495AB9-215A-4C8F-AE1F-BC88FD92B788}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TOperatorInfo.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IOperatorInfo;
  end;
end;

procedure TOperatorInfo.ConnectTo(svrIntf: IOperatorInfo);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TOperatorInfo.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TOperatorInfo.GetDefaultInterface: IOperatorInfo;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TOperatorInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TOperatorInfoProperties.Create(Self);
{$ENDIF}
end;

destructor TOperatorInfo.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TOperatorInfo.GetServerProperties: TOperatorInfoProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TOperatorInfo.Get_name: WideString;
begin
    Result := DefaultInterface.name;
end;

procedure TOperatorInfo.Set_name(const pVal: WideString);
  { Warning: The property name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.name := pVal;
end;

function TOperatorInfo.Get_passwd: WideString;
begin
    Result := DefaultInterface.passwd;
end;

procedure TOperatorInfo.Set_passwd(const pVal: WideString);
  { Warning: The property passwd has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.passwd := pVal;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TOperatorInfoProperties.Create(AServer: TOperatorInfo);
begin
  inherited Create;
  FServer := AServer;
end;

function TOperatorInfoProperties.GetDefaultInterface: IOperatorInfo;
begin
  Result := FServer.DefaultInterface;
end;

function TOperatorInfoProperties.Get_name: WideString;
begin
    Result := DefaultInterface.name;
end;

procedure TOperatorInfoProperties.Set_name(const pVal: WideString);
  { Warning: The property name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.name := pVal;
end;

function TOperatorInfoProperties.Get_passwd: WideString;
begin
    Result := DefaultInterface.passwd;
end;

procedure TOperatorInfoProperties.Set_passwd(const pVal: WideString);
  { Warning: The property passwd has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.passwd := pVal;
end;

{$ENDIF}

class function CoArticleInfo.Create: IArticleInfo;
begin
  Result := CreateComObject(CLASS_ArticleInfo) as IArticleInfo;
end;

class function CoArticleInfo.CreateRemote(const MachineName: string): IArticleInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ArticleInfo) as IArticleInfo;
end;

procedure TArticleInfo.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{4B2E1B2E-4C07-471E-BC18-7497D0104348}';
    IntfIID:   '{96CAD3E3-70CD-4BED-AB8B-ADDD77D301D3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TArticleInfo.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IArticleInfo;
  end;
end;

procedure TArticleInfo.ConnectTo(svrIntf: IArticleInfo);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TArticleInfo.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TArticleInfo.GetDefaultInterface: IArticleInfo;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TArticleInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TArticleInfoProperties.Create(Self);
{$ENDIF}
end;

destructor TArticleInfo.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TArticleInfo.GetServerProperties: TArticleInfoProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TArticleInfo.Get_name: WideString;
begin
    Result := DefaultInterface.name;
end;

procedure TArticleInfo.Set_name(const pVal: WideString);
  { Warning: The property name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.name := pVal;
end;

function TArticleInfo.Get_price: Double;
begin
    Result := DefaultInterface.price;
end;

procedure TArticleInfo.Set_price(pVal: Double);
begin
  DefaultInterface.Set_price(pVal);
end;

function TArticleInfo.Get_taxgroup: Smallint;
begin
    Result := DefaultInterface.taxgroup;
end;

procedure TArticleInfo.Set_taxgroup(pVal: Smallint);
begin
  DefaultInterface.Set_taxgroup(pVal);
end;

function TArticleInfo.Get_turnover: Double;
begin
    Result := DefaultInterface.turnover;
end;

procedure TArticleInfo.Set_turnover(pVal: Double);
begin
  DefaultInterface.Set_turnover(pVal);
end;

function TArticleInfo.Get_sells: Double;
begin
    Result := DefaultInterface.sells;
end;

procedure TArticleInfo.Set_sells(pVal: Double);
begin
  DefaultInterface.Set_sells(pVal);
end;

function TArticleInfo.Get_counter: Integer;
begin
    Result := DefaultInterface.counter;
end;

procedure TArticleInfo.Set_counter(pVal: Integer);
begin
  DefaultInterface.Set_counter(pVal);
end;

function TArticleInfo.Get_reportdate: TDateTime;
begin
    Result := DefaultInterface.reportdate;
end;

procedure TArticleInfo.Set_reportdate(pVal: TDateTime);
begin
  DefaultInterface.Set_reportdate(pVal);
end;

function TArticleInfo.Get_department: Smallint;
begin
    Result := DefaultInterface.department;
end;

procedure TArticleInfo.Set_department(pVal: Smallint);
begin
  DefaultInterface.Set_department(pVal);
end;

function TArticleInfo.Get_quantity: Double;
begin
    Result := DefaultInterface.quantity;
end;

procedure TArticleInfo.Set_quantity(pVal: Double);
begin
  DefaultInterface.Set_quantity(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TArticleInfoProperties.Create(AServer: TArticleInfo);
begin
  inherited Create;
  FServer := AServer;
end;

function TArticleInfoProperties.GetDefaultInterface: IArticleInfo;
begin
  Result := FServer.DefaultInterface;
end;

function TArticleInfoProperties.Get_name: WideString;
begin
    Result := DefaultInterface.name;
end;

procedure TArticleInfoProperties.Set_name(const pVal: WideString);
  { Warning: The property name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.name := pVal;
end;

function TArticleInfoProperties.Get_price: Double;
begin
    Result := DefaultInterface.price;
end;

procedure TArticleInfoProperties.Set_price(pVal: Double);
begin
  DefaultInterface.Set_price(pVal);
end;

function TArticleInfoProperties.Get_taxgroup: Smallint;
begin
    Result := DefaultInterface.taxgroup;
end;

procedure TArticleInfoProperties.Set_taxgroup(pVal: Smallint);
begin
  DefaultInterface.Set_taxgroup(pVal);
end;

function TArticleInfoProperties.Get_turnover: Double;
begin
    Result := DefaultInterface.turnover;
end;

procedure TArticleInfoProperties.Set_turnover(pVal: Double);
begin
  DefaultInterface.Set_turnover(pVal);
end;

function TArticleInfoProperties.Get_sells: Double;
begin
    Result := DefaultInterface.sells;
end;

procedure TArticleInfoProperties.Set_sells(pVal: Double);
begin
  DefaultInterface.Set_sells(pVal);
end;

function TArticleInfoProperties.Get_counter: Integer;
begin
    Result := DefaultInterface.counter;
end;

procedure TArticleInfoProperties.Set_counter(pVal: Integer);
begin
  DefaultInterface.Set_counter(pVal);
end;

function TArticleInfoProperties.Get_reportdate: TDateTime;
begin
    Result := DefaultInterface.reportdate;
end;

procedure TArticleInfoProperties.Set_reportdate(pVal: TDateTime);
begin
  DefaultInterface.Set_reportdate(pVal);
end;

function TArticleInfoProperties.Get_department: Smallint;
begin
    Result := DefaultInterface.department;
end;

procedure TArticleInfoProperties.Set_department(pVal: Smallint);
begin
  DefaultInterface.Set_department(pVal);
end;

function TArticleInfoProperties.Get_quantity: Double;
begin
    Result := DefaultInterface.quantity;
end;

procedure TArticleInfoProperties.Set_quantity(pVal: Double);
begin
  DefaultInterface.Set_quantity(pVal);
end;

{$ENDIF}

class function CoDailySums.Create: IDailySums;
begin
  Result := CreateComObject(CLASS_DailySums) as IDailySums;
end;

class function CoDailySums.CreateRemote(const MachineName: string): IDailySums;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DailySums) as IDailySums;
end;

procedure TDailySums.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{52F50CD0-B861-457C-9F2C-6D1295060DC3}';
    IntfIID:   '{9DF5E8A6-B16D-4F5E-92BC-70E2670E2AFB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDailySums.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDailySums;
  end;
end;

procedure TDailySums.ConnectTo(svrIntf: IDailySums);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDailySums.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDailySums.GetDefaultInterface: IDailySums;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TDailySums.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDailySumsProperties.Create(Self);
{$ENDIF}
end;

destructor TDailySums.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDailySums.GetServerProperties: TDailySumsProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TDailySums.Get_clients: Integer;
begin
    Result := DefaultInterface.clients;
end;

procedure TDailySums.Set_clients(pVal: Integer);
begin
  DefaultInterface.Set_clients(pVal);
end;

function TDailySums.Get_discounts: Integer;
begin
    Result := DefaultInterface.discounts;
end;

procedure TDailySums.Set_discounts(pVal: Integer);
begin
  DefaultInterface.Set_discounts(pVal);
end;

function TDailySums.Get_sumdiscount: Double;
begin
    Result := DefaultInterface.sumdiscount;
end;

procedure TDailySums.Set_sumdiscount(pVal: Double);
begin
  DefaultInterface.Set_sumdiscount(pVal);
end;

function TDailySums.Get_adding: Integer;
begin
    Result := DefaultInterface.adding;
end;

procedure TDailySums.Set_adding(pVal: Integer);
begin
  DefaultInterface.Set_adding(pVal);
end;

function TDailySums.Get_sumadding: Double;
begin
    Result := DefaultInterface.sumadding;
end;

procedure TDailySums.Set_sumadding(pVal: Double);
begin
  DefaultInterface.Set_sumadding(pVal);
end;

function TDailySums.Get_voids: Integer;
begin
    Result := DefaultInterface.voids;
end;

procedure TDailySums.Set_voids(pVal: Integer);
begin
  DefaultInterface.Set_voids(pVal);
end;

function TDailySums.Get_sumvoids: Double;
begin
    Result := DefaultInterface.sumvoids;
end;

procedure TDailySums.Set_sumvoids(pVal: Double);
begin
  DefaultInterface.Set_sumvoids(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDailySumsProperties.Create(AServer: TDailySums);
begin
  inherited Create;
  FServer := AServer;
end;

function TDailySumsProperties.GetDefaultInterface: IDailySums;
begin
  Result := FServer.DefaultInterface;
end;

function TDailySumsProperties.Get_clients: Integer;
begin
    Result := DefaultInterface.clients;
end;

procedure TDailySumsProperties.Set_clients(pVal: Integer);
begin
  DefaultInterface.Set_clients(pVal);
end;

function TDailySumsProperties.Get_discounts: Integer;
begin
    Result := DefaultInterface.discounts;
end;

procedure TDailySumsProperties.Set_discounts(pVal: Integer);
begin
  DefaultInterface.Set_discounts(pVal);
end;

function TDailySumsProperties.Get_sumdiscount: Double;
begin
    Result := DefaultInterface.sumdiscount;
end;

procedure TDailySumsProperties.Set_sumdiscount(pVal: Double);
begin
  DefaultInterface.Set_sumdiscount(pVal);
end;

function TDailySumsProperties.Get_adding: Integer;
begin
    Result := DefaultInterface.adding;
end;

procedure TDailySumsProperties.Set_adding(pVal: Integer);
begin
  DefaultInterface.Set_adding(pVal);
end;

function TDailySumsProperties.Get_sumadding: Double;
begin
    Result := DefaultInterface.sumadding;
end;

procedure TDailySumsProperties.Set_sumadding(pVal: Double);
begin
  DefaultInterface.Set_sumadding(pVal);
end;

function TDailySumsProperties.Get_voids: Integer;
begin
    Result := DefaultInterface.voids;
end;

procedure TDailySumsProperties.Set_voids(pVal: Integer);
begin
  DefaultInterface.Set_voids(pVal);
end;

function TDailySumsProperties.Get_sumvoids: Double;
begin
    Result := DefaultInterface.sumvoids;
end;

procedure TDailySumsProperties.Set_sumvoids(pVal: Double);
begin
  DefaultInterface.Set_sumvoids(pVal);
end;

{$ENDIF}

class function CoFiscalReportData.Create: IFiscalReportData;
begin
  Result := CreateComObject(CLASS_FiscalReportData) as IFiscalReportData;
end;

class function CoFiscalReportData.CreateRemote(const MachineName: string): IFiscalReportData;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FiscalReportData) as IFiscalReportData;
end;

procedure TFiscalReportData.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{DDFA7C5F-E120-4293-97D6-2467DBED2B9B}';
    IntfIID:   '{C80831C3-069A-4D31-A042-CD5A2D1BF43B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFiscalReportData.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IFiscalReportData;
  end;
end;

procedure TFiscalReportData.ConnectTo(svrIntf: IFiscalReportData);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TFiscalReportData.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TFiscalReportData.GetDefaultInterface: IFiscalReportData;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TFiscalReportData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFiscalReportDataProperties.Create(Self);
{$ENDIF}
end;

destructor TFiscalReportData.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFiscalReportData.GetServerProperties: TFiscalReportDataProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TFiscalReportData.Get_reportdate: TDateTime;
begin
    Result := DefaultInterface.reportdate;
end;

procedure TFiscalReportData.Set_reportdate(pVal: TDateTime);
begin
  DefaultInterface.Set_reportdate(pVal);
end;

function TFiscalReportData.Get_lastreport: Integer;
begin
    Result := DefaultInterface.lastreport;
end;

procedure TFiscalReportData.Set_lastreport(pVal: Integer);
begin
  DefaultInterface.Set_lastreport(pVal);
end;

function TFiscalReportData.Get_lastzeroram: Integer;
begin
    Result := DefaultInterface.lastzeroram;
end;

procedure TFiscalReportData.Set_lastzeroram(pVal: Integer);
begin
  DefaultInterface.Set_lastzeroram(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFiscalReportDataProperties.Create(AServer: TFiscalReportData);
begin
  inherited Create;
  FServer := AServer;
end;

function TFiscalReportDataProperties.GetDefaultInterface: IFiscalReportData;
begin
  Result := FServer.DefaultInterface;
end;

function TFiscalReportDataProperties.Get_reportdate: TDateTime;
begin
    Result := DefaultInterface.reportdate;
end;

procedure TFiscalReportDataProperties.Set_reportdate(pVal: TDateTime);
begin
  DefaultInterface.Set_reportdate(pVal);
end;

function TFiscalReportDataProperties.Get_lastreport: Integer;
begin
    Result := DefaultInterface.lastreport;
end;

procedure TFiscalReportDataProperties.Set_lastreport(pVal: Integer);
begin
  DefaultInterface.Set_lastreport(pVal);
end;

function TFiscalReportDataProperties.Get_lastzeroram: Integer;
begin
    Result := DefaultInterface.lastzeroram;
end;

procedure TFiscalReportDataProperties.Set_lastzeroram(pVal: Integer);
begin
  DefaultInterface.Set_lastzeroram(pVal);
end;

{$ENDIF}

class function CoDailyReport.Create: IDailyReport;
begin
  Result := CreateComObject(CLASS_DailyReport) as IDailyReport;
end;

class function CoDailyReport.CreateRemote(const MachineName: string): IDailyReport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DailyReport) as IDailyReport;
end;

procedure TDailyReport.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1B381FCB-9A9E-456B-87D8-D5883007620C}';
    IntfIID:   '{79B6621A-0804-4742-859A-333D1CB3EFBD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDailyReport.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDailyReport;
  end;
end;

procedure TDailyReport.ConnectTo(svrIntf: IDailyReport);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDailyReport.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDailyReport.GetDefaultInterface: IDailyReport;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TDailyReport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDailyReportProperties.Create(Self);
{$ENDIF}
end;

destructor TDailyReport.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDailyReport.GetServerProperties: TDailyReportProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TDailyReport.Get_counter: Integer;
begin
    Result := DefaultInterface.counter;
end;

procedure TDailyReport.Set_counter(pVal: Integer);
begin
  DefaultInterface.Set_counter(pVal);
end;

function TDailyReport.Get_lastreport: Integer;
begin
    Result := DefaultInterface.lastreport;
end;

procedure TDailyReport.Set_lastreport(pVal: Integer);
begin
  DefaultInterface.Set_lastreport(pVal);
end;

function TDailyReport.Get_ecl: Integer;
begin
    Result := DefaultInterface.ecl;
end;

procedure TDailyReport.Set_ecl(pVal: Integer);
begin
  DefaultInterface.Set_ecl(pVal);
end;

function TDailyReport.Get_datetime: TDateTime;
begin
    Result := DefaultInterface.datetime;
end;

procedure TDailyReport.Set_datetime(pVal: TDateTime);
begin
  DefaultInterface.Set_datetime(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDailyReportProperties.Create(AServer: TDailyReport);
begin
  inherited Create;
  FServer := AServer;
end;

function TDailyReportProperties.GetDefaultInterface: IDailyReport;
begin
  Result := FServer.DefaultInterface;
end;

function TDailyReportProperties.Get_counter: Integer;
begin
    Result := DefaultInterface.counter;
end;

procedure TDailyReportProperties.Set_counter(pVal: Integer);
begin
  DefaultInterface.Set_counter(pVal);
end;

function TDailyReportProperties.Get_lastreport: Integer;
begin
    Result := DefaultInterface.lastreport;
end;

procedure TDailyReportProperties.Set_lastreport(pVal: Integer);
begin
  DefaultInterface.Set_lastreport(pVal);
end;

function TDailyReportProperties.Get_ecl: Integer;
begin
    Result := DefaultInterface.ecl;
end;

procedure TDailyReportProperties.Set_ecl(pVal: Integer);
begin
  DefaultInterface.Set_ecl(pVal);
end;

function TDailyReportProperties.Get_datetime: TDateTime;
begin
    Result := DefaultInterface.datetime;
end;

procedure TDailyReportProperties.Set_datetime(pVal: TDateTime);
begin
  DefaultInterface.Set_datetime(pVal);
end;

{$ENDIF}

class function CoZFPStatus.Create: IZFPStatus;
begin
  Result := CreateComObject(CLASS_ZFPStatus) as IZFPStatus;
end;

class function CoZFPStatus.CreateRemote(const MachineName: string): IZFPStatus;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ZFPStatus) as IZFPStatus;
end;

procedure TZFPStatus.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{046BF363-4057-4489-B9C6-5C28D48DAF8D}';
    IntfIID:   '{6C75FC08-31BD-4B9E-B5E0-BBF69AA9F041}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TZFPStatus.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IZFPStatus;
  end;
end;

procedure TZFPStatus.ConnectTo(svrIntf: IZFPStatus);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TZFPStatus.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TZFPStatus.GetDefaultInterface: IZFPStatus;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TZFPStatus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TZFPStatusProperties.Create(Self);
{$ENDIF}
end;

destructor TZFPStatus.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TZFPStatus.GetServerProperties: TZFPStatusProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TZFPStatus.Get_ST0: Byte;
begin
    Result := DefaultInterface.ST0;
end;

procedure TZFPStatus.Set_ST0(pVal: Byte);
begin
  DefaultInterface.Set_ST0(pVal);
end;

function TZFPStatus.Get_ST1: Byte;
begin
    Result := DefaultInterface.ST1;
end;

procedure TZFPStatus.Set_ST1(pVal: Byte);
begin
  DefaultInterface.Set_ST1(pVal);
end;

function TZFPStatus.Get_ST2: Byte;
begin
    Result := DefaultInterface.ST2;
end;

procedure TZFPStatus.Set_ST2(pVal: Byte);
begin
  DefaultInterface.Set_ST2(pVal);
end;

function TZFPStatus.Get_ST3: Byte;
begin
    Result := DefaultInterface.ST3;
end;

procedure TZFPStatus.Set_ST3(pVal: Byte);
begin
  DefaultInterface.Set_ST3(pVal);
end;

function TZFPStatus.Get_ST4: Byte;
begin
    Result := DefaultInterface.ST4;
end;

procedure TZFPStatus.Set_ST4(pVal: Byte);
begin
  DefaultInterface.Set_ST4(pVal);
end;

function TZFPStatus.Get_wrongTimer: Integer;
begin
    Result := DefaultInterface.wrongTimer;
end;

function TZFPStatus.Get_wrongDate: Integer;
begin
    Result := DefaultInterface.wrongDate;
end;

function TZFPStatus.Get_wrongRAM: Integer;
begin
    Result := DefaultInterface.wrongRAM;
end;

function TZFPStatus.Get_clockHardwareError: Integer;
begin
    Result := DefaultInterface.clockHardwareError;
end;

function TZFPStatus.Get_paperOutPrinterError: Integer;
begin
    Result := DefaultInterface.paperOutPrinterError;
end;

function TZFPStatus.Get_reportSumOverflow: Integer;
begin
    Result := DefaultInterface.reportSumOverflow;
end;

function TZFPStatus.Get_printLogo: Integer;
begin
    Result := DefaultInterface.printLogo;
end;

function TZFPStatus.Get_nonzeroDailyReport: Integer;
begin
    Result := DefaultInterface.nonzeroDailyReport;
end;

function TZFPStatus.Get_nonzeroArticleReport: Integer;
begin
    Result := DefaultInterface.nonzeroArticleReport;
end;

function TZFPStatus.Get_nonzeroOperatorReport: Integer;
begin
    Result := DefaultInterface.nonzeroOperatorReport;
end;

function TZFPStatus.Get_duplicateNotPrinted: Integer;
begin
    Result := DefaultInterface.duplicateNotPrinted;
end;

function TZFPStatus.Get_openOfficialBon: Integer;
begin
    Result := DefaultInterface.openOfficialBon;
end;

function TZFPStatus.Get_OpenFiscalBon: Integer;
begin
    Result := DefaultInterface.OpenFiscalBon;
end;

function TZFPStatus.Get_detailedInfo: Integer;
begin
    Result := DefaultInterface.detailedInfo;
end;

function TZFPStatus.Get_VATinfo: Integer;
begin
    Result := DefaultInterface.VATinfo;
end;

function TZFPStatus.Get_missingFiscalMemory: Integer;
begin
    Result := DefaultInterface.missingFiscalMemory;
end;

function TZFPStatus.Get_wrongFiscalMemory: Integer;
begin
    Result := DefaultInterface.wrongFiscalMemory;
end;

function TZFPStatus.Get_fullFiscalMemory: Integer;
begin
    Result := DefaultInterface.fullFiscalMemory;
end;

function TZFPStatus.Get_fiscalMemoryLimitNear: Integer;
begin
    Result := DefaultInterface.fiscalMemoryLimitNear;
end;

function TZFPStatus.Get_hasDecimalPoint: Integer;
begin
    Result := DefaultInterface.hasDecimalPoint;
end;

function TZFPStatus.Get_isFiscal: Integer;
begin
    Result := DefaultInterface.isFiscal;
end;

function TZFPStatus.Get_hasFiscalAndFactoryNum: Integer;
begin
    Result := DefaultInterface.hasFiscalAndFactoryNum;
end;

function TZFPStatus.Get_autoCutter: Integer;
begin
    Result := DefaultInterface.autoCutter;
end;

function TZFPStatus.Get_hasTransparentDisplay: Integer;
begin
    Result := DefaultInterface.hasTransparentDisplay;
end;

function TZFPStatus.Get_baud9600: Integer;
begin
    Result := DefaultInterface.baud9600;
end;

function TZFPStatus.Get_autoTillOpen: Integer;
begin
    Result := DefaultInterface.autoTillOpen;
end;

function TZFPStatus.Get_readOnlyFM: Integer;
begin
    Result := DefaultInterface.readOnlyFM;
end;

function TZFPStatus.Get_powerdown: Integer;
begin
    Result := DefaultInterface.powerdown;
end;

function TZFPStatus.Get_printerOverheat: Integer;
begin
    Result := DefaultInterface.printerOverheat;
end;

function TZFPStatus.Get_Blocked24HoursReport: Integer;
begin
    Result := DefaultInterface.Blocked24HoursReport;
end;

function TZFPStatus.Get_missingDisplay: Integer;
begin
    Result := DefaultInterface.missingDisplay;
end;

function TZFPStatus.Get_shortEJMode: Integer;
begin
    Result := DefaultInterface.shortEJMode;
end;

function TZFPStatus.Get_EJLimitNear: Integer;
begin
    Result := DefaultInterface.EJLimitNear;
end;

function TZFPStatus.Get_fullEJ: Integer;
begin
    Result := DefaultInterface.fullEJ;
end;

function TZFPStatus.Get_printCurrency: Integer;
begin
    Result := DefaultInterface.printCurrency;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TZFPStatusProperties.Create(AServer: TZFPStatus);
begin
  inherited Create;
  FServer := AServer;
end;

function TZFPStatusProperties.GetDefaultInterface: IZFPStatus;
begin
  Result := FServer.DefaultInterface;
end;

function TZFPStatusProperties.Get_ST0: Byte;
begin
    Result := DefaultInterface.ST0;
end;

procedure TZFPStatusProperties.Set_ST0(pVal: Byte);
begin
  DefaultInterface.Set_ST0(pVal);
end;

function TZFPStatusProperties.Get_ST1: Byte;
begin
    Result := DefaultInterface.ST1;
end;

procedure TZFPStatusProperties.Set_ST1(pVal: Byte);
begin
  DefaultInterface.Set_ST1(pVal);
end;

function TZFPStatusProperties.Get_ST2: Byte;
begin
    Result := DefaultInterface.ST2;
end;

procedure TZFPStatusProperties.Set_ST2(pVal: Byte);
begin
  DefaultInterface.Set_ST2(pVal);
end;

function TZFPStatusProperties.Get_ST3: Byte;
begin
    Result := DefaultInterface.ST3;
end;

procedure TZFPStatusProperties.Set_ST3(pVal: Byte);
begin
  DefaultInterface.Set_ST3(pVal);
end;

function TZFPStatusProperties.Get_ST4: Byte;
begin
    Result := DefaultInterface.ST4;
end;

procedure TZFPStatusProperties.Set_ST4(pVal: Byte);
begin
  DefaultInterface.Set_ST4(pVal);
end;

function TZFPStatusProperties.Get_wrongTimer: Integer;
begin
    Result := DefaultInterface.wrongTimer;
end;

function TZFPStatusProperties.Get_wrongDate: Integer;
begin
    Result := DefaultInterface.wrongDate;
end;

function TZFPStatusProperties.Get_wrongRAM: Integer;
begin
    Result := DefaultInterface.wrongRAM;
end;

function TZFPStatusProperties.Get_clockHardwareError: Integer;
begin
    Result := DefaultInterface.clockHardwareError;
end;

function TZFPStatusProperties.Get_paperOutPrinterError: Integer;
begin
    Result := DefaultInterface.paperOutPrinterError;
end;

function TZFPStatusProperties.Get_reportSumOverflow: Integer;
begin
    Result := DefaultInterface.reportSumOverflow;
end;

function TZFPStatusProperties.Get_printLogo: Integer;
begin
    Result := DefaultInterface.printLogo;
end;

function TZFPStatusProperties.Get_nonzeroDailyReport: Integer;
begin
    Result := DefaultInterface.nonzeroDailyReport;
end;

function TZFPStatusProperties.Get_nonzeroArticleReport: Integer;
begin
    Result := DefaultInterface.nonzeroArticleReport;
end;

function TZFPStatusProperties.Get_nonzeroOperatorReport: Integer;
begin
    Result := DefaultInterface.nonzeroOperatorReport;
end;

function TZFPStatusProperties.Get_duplicateNotPrinted: Integer;
begin
    Result := DefaultInterface.duplicateNotPrinted;
end;

function TZFPStatusProperties.Get_openOfficialBon: Integer;
begin
    Result := DefaultInterface.openOfficialBon;
end;

function TZFPStatusProperties.Get_OpenFiscalBon: Integer;
begin
    Result := DefaultInterface.OpenFiscalBon;
end;

function TZFPStatusProperties.Get_detailedInfo: Integer;
begin
    Result := DefaultInterface.detailedInfo;
end;

function TZFPStatusProperties.Get_VATinfo: Integer;
begin
    Result := DefaultInterface.VATinfo;
end;

function TZFPStatusProperties.Get_missingFiscalMemory: Integer;
begin
    Result := DefaultInterface.missingFiscalMemory;
end;

function TZFPStatusProperties.Get_wrongFiscalMemory: Integer;
begin
    Result := DefaultInterface.wrongFiscalMemory;
end;

function TZFPStatusProperties.Get_fullFiscalMemory: Integer;
begin
    Result := DefaultInterface.fullFiscalMemory;
end;

function TZFPStatusProperties.Get_fiscalMemoryLimitNear: Integer;
begin
    Result := DefaultInterface.fiscalMemoryLimitNear;
end;

function TZFPStatusProperties.Get_hasDecimalPoint: Integer;
begin
    Result := DefaultInterface.hasDecimalPoint;
end;

function TZFPStatusProperties.Get_isFiscal: Integer;
begin
    Result := DefaultInterface.isFiscal;
end;

function TZFPStatusProperties.Get_hasFiscalAndFactoryNum: Integer;
begin
    Result := DefaultInterface.hasFiscalAndFactoryNum;
end;

function TZFPStatusProperties.Get_autoCutter: Integer;
begin
    Result := DefaultInterface.autoCutter;
end;

function TZFPStatusProperties.Get_hasTransparentDisplay: Integer;
begin
    Result := DefaultInterface.hasTransparentDisplay;
end;

function TZFPStatusProperties.Get_baud9600: Integer;
begin
    Result := DefaultInterface.baud9600;
end;

function TZFPStatusProperties.Get_autoTillOpen: Integer;
begin
    Result := DefaultInterface.autoTillOpen;
end;

function TZFPStatusProperties.Get_readOnlyFM: Integer;
begin
    Result := DefaultInterface.readOnlyFM;
end;

function TZFPStatusProperties.Get_powerdown: Integer;
begin
    Result := DefaultInterface.powerdown;
end;

function TZFPStatusProperties.Get_printerOverheat: Integer;
begin
    Result := DefaultInterface.printerOverheat;
end;

function TZFPStatusProperties.Get_Blocked24HoursReport: Integer;
begin
    Result := DefaultInterface.Blocked24HoursReport;
end;

function TZFPStatusProperties.Get_missingDisplay: Integer;
begin
    Result := DefaultInterface.missingDisplay;
end;

function TZFPStatusProperties.Get_shortEJMode: Integer;
begin
    Result := DefaultInterface.shortEJMode;
end;

function TZFPStatusProperties.Get_EJLimitNear: Integer;
begin
    Result := DefaultInterface.EJLimitNear;
end;

function TZFPStatusProperties.Get_fullEJ: Integer;
begin
    Result := DefaultInterface.fullEJ;
end;

function TZFPStatusProperties.Get_printCurrency: Integer;
begin
    Result := DefaultInterface.printCurrency;
end;

{$ENDIF}

class function CoInvoiceNumbers.Create: IInvoiceNumbers;
begin
  Result := CreateComObject(CLASS_InvoiceNumbers) as IInvoiceNumbers;
end;

class function CoInvoiceNumbers.CreateRemote(const MachineName: string): IInvoiceNumbers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_InvoiceNumbers) as IInvoiceNumbers;
end;

procedure TInvoiceNumbers.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BEBD9667-9A17-44A0-B568-E1A9232619C5}';
    IntfIID:   '{6591F815-2562-43F2-888C-6E5653B00284}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TInvoiceNumbers.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IInvoiceNumbers;
  end;
end;

procedure TInvoiceNumbers.ConnectTo(svrIntf: IInvoiceNumbers);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TInvoiceNumbers.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TInvoiceNumbers.GetDefaultInterface: IInvoiceNumbers;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TInvoiceNumbers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TInvoiceNumbersProperties.Create(Self);
{$ENDIF}
end;

destructor TInvoiceNumbers.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TInvoiceNumbers.GetServerProperties: TInvoiceNumbersProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TInvoiceNumbers.Get_nextNum: WideString;
begin
    Result := DefaultInterface.nextNum;
end;

procedure TInvoiceNumbers.Set_nextNum(const pVal: WideString);
  { Warning: The property nextNum has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.nextNum := pVal;
end;

function TInvoiceNumbers.Get_lastNum: WideString;
begin
    Result := DefaultInterface.lastNum;
end;

procedure TInvoiceNumbers.Set_lastNum(const pVal: WideString);
  { Warning: The property lastNum has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.lastNum := pVal;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TInvoiceNumbersProperties.Create(AServer: TInvoiceNumbers);
begin
  inherited Create;
  FServer := AServer;
end;

function TInvoiceNumbersProperties.GetDefaultInterface: IInvoiceNumbers;
begin
  Result := FServer.DefaultInterface;
end;

function TInvoiceNumbersProperties.Get_nextNum: WideString;
begin
    Result := DefaultInterface.nextNum;
end;

procedure TInvoiceNumbersProperties.Set_nextNum(const pVal: WideString);
  { Warning: The property nextNum has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.nextNum := pVal;
end;

function TInvoiceNumbersProperties.Get_lastNum: WideString;
begin
    Result := DefaultInterface.lastNum;
end;

procedure TInvoiceNumbersProperties.Set_lastNum(const pVal: WideString);
  { Warning: The property lastNum has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.lastNum := pVal;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TZekaFP, TGetCurrentBonInfoRes, TTaxNumbers, TPayTypes, 
    TZFPParameters, TOperatorInfo, TArticleInfo, TDailySums, TFiscalReportData, 
    TDailyReport, TZFPStatus, TInvoiceNumbers]);
end;

end.
