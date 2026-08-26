{ Tremol fiscal printer library }
unit Tremol.FP;

interface

uses
  Classes,
  SysUtils,
  XMLDoc,
  XMLIntf,
  Tremol.FP_Core;

type
  TByteArray = array of byte;
  {$MinEnumSize 1}
  OptionServiceModeEnum = (sm_Sales_mode = 48 {0}, sm_Service_mode = 49 {1});
  OptionActivationRSEnum = (ars_No = 48 {0}, ars_Yes = 49 {1});
  OptionReceiptTypeEnum = (rt_Sale = 49 {1}, rt_Storno = 48 {0});
  OptionPrintTypeEnum = (pt_Postponed_printing = 50 {2}, pt_Step_by_step_printing = 48 {0});
  OptionPaymentTypeEnum = (pt_Card = 49 {1}, pt_Cash = 48 {0}, pt_Credit = 51 {3}, pt_Currency = 52 {4}, pt_Voucher = 50 {2});
  OptionChangeEnum = (c_With_Change = 48 {0}, c_Without_Change = 49 {1});
  OptionChangeTypeEnum = (ct_Empty = 0, ct_Change_In_Cash = 48 {0}, ct_Change_In_Currency = 50 {2}, ct_Same_As_The_payment = 49 {1});
  OptionZeroingEnum = (z_Without_zeroing = 88 {X}, z_Zeroing = 90 {Z});
  OptionCodeTypeEnum = (ct_CODABAR = 54 {6}, ct_CODE_128 = 73 {I}, ct_CODE_39 = 52 {4}, ct_CODE_93 = 72 {H}, ct_EAN_13 = 50 {2}, ct_EAN_8 = 51 {3}, ct_ITF = 53 {5}, ct_UPC_A = 48 {0}, ct_UPC_E = 49 {1});
  OptionDecimalPointPositionEnum = (dpp_Fractions = 50 {2}, dpp_Whole_numbers = 48 {0});
  OptionVATClassEnum = (vatc_VAT_Class_0 = 1040 {А}, vatc_VAT_Class_1 = 1041 {Б}, vatc_VAT_Class_2 = 1042 {В}, vatc_VAT_Class_3 = 1043 {Г});
  OptionFooterLineEnum = (fl_Footer_1 = 3211334 {F1}, fl_Footer_2 = 3276870 {F2}, fl_Footer_3 = 3342406 {F3});
  OptionHeaderLineEnum = (hl_Header_1 = 49 {1}, hl_Header_2 = 50 {2}, hl_Header_3 = 51 {3}, hl_Header_4 = 52 {4}, hl_Header_5 = 53 {5}, hl_Header_6 = 54 {6}, hl_ID_number = 55 {7}, hl_VAT_number = 56 {8});
  OptionPrintLogoEnum = (pl_No = 48 {0}, pl_Yes = 49 {1});
  OptionAutoOpenDrawerEnum = (aod_No = 48 {0}, aod_Yes = 49 {1});
  OptionAutoCutEnum = (ac_No = 48 {0}, ac_Yes = 49 {1});
  OptionExternalDispManagementEnum = (edm_Auto = 48 {0}, edm_Manual = 49 {1});
  OptionReceiptSendEnum = (rs_Automatic_sending = 49 {1}, rs_Without_sending = 48 {0});
  OptionEnableCurrencyEnum = (ec_No = 48 {0}, ec_Yes = 49 {1});
  OptionWorkOperatorCountEnum = (woc_More = 48 {0}, woc_One = 49 {1});
  OptionPaymentNumEnum = (pn_Payment_1 = 49 {1}, pn_Payment_2 = 50 {2}, pn_Payment_3 = 51 {3}, pn_Payment_4 = 52 {4});
  OptionPriceEnum = (p_Free_price_is_disable_valid_only_programmed_price = 48 {0}, p_Free_price_is_enable = 49 {1}, p_Limited_price = 50 {2});
  OptionQuantityTypeEnum = (qt_Availability_of_PLU_stock_is_not_monitored = 48 {0}, qt_Disable_negative_quantity = 49 {1}, qt_Enable_negative_quantity = 50 {2});
  OptionBTstatusEnum = (bt_Disabled = 48 {0}, bt_Enabled = 49 {1});
  OptionIsReceiptOpenedEnum = (iro_No = 48 {0}, iro_Yes = 49 {1});
  OptionInitiatedPaymentEnum = (ip_initiated_payment = 49 {1}, ip_not_initiated_payment = 48 {0});
  OptionFinalizedPaymentEnum = (fp_finalized_payment = 49 {1}, fp_not_finalized_payment = 48 {0});
  OptionPowerDownInReceiptEnum = (pdir_No = 48 {0}, pdir_Yes = 49 {1});
  OptionLANEnum = (lan_No = 48 {0}, lan_Yes = 49 {1});
  OptionWiFiEnum = (wf_No = 48 {0}, wf_Yes = 49 {1});
  OptionGPRSEnum = (gprs_No = 48 {0}, gprs_Yes = 49 {1});
  OptionBTEnum = (bt_No = 48 {0}, bt_Yes = 49 {1});
  OptionDhcpStatusEnum = (ds_Disabled = 48 {0}, ds_Enabled = 49 {1});
  OptionExternalTypeEnum = (et_Others = 48 {0}, et_Tremol_display = 49 {1});
  OptionAddressTypeEnum = (at_DNS_address = 53 {5}, at_Gateway_address = 52 {4}, at_IP_address = 50 {2}, at_Subnet_Mask = 51 {3});
  OptionTCPAutoStartEnum = (tcpas_No = 48 {0}, tcpas_Yes = 49 {1});
  OptionUsedModuleEnum = (um_LAN = 49 {1}, um_WiFi = 50 {2});
  OptionDeviceTypeEnum = (dt_ECR = 49 {1}, dt_FPr = 50 {2});
  OptionExternalDisplayEnum = (ed_Others = 48 {0}, ed_Tremol_display = 49 {1});
  OptionGoodsTypeEnum = (gt_importation = 48 {0}, gt_macedonian_goods = 49 {1});
  OptionSignEnum = (s_Sale = 43 {+});
  OptionDHCPEnabledEnum = (dhcpe_Disabled = 48 {0}, dhcpe_Enabled = 49 {1});
  OptionPrintingEnum = (p_No = 48 {0}, p_Yes = 49 {1});
  OptionDisplayEnum = (d_No = 48 {0}, d_Yes = 49 {1});


  OptionServiceMode_ResEnum = class(ResEnum)
  public
    Name : OptionServiceModeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionActivationRS_ResEnum = class(ResEnum)
  public
    Name : OptionActivationRSEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionReceiptType_ResEnum = class(ResEnum)
  public
    Name : OptionReceiptTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionChangeType_ResEnum = class(ResEnum)
  public
    Name : OptionChangeTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionDecimalPointPosition_ResEnum = class(ResEnum)
  public
    Name : OptionDecimalPointPositionEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionVATClass_ResEnum = class(ResEnum)
  public
    Name : OptionVATClassEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionFooterLine_ResEnum = class(ResEnum)
  public
    Name : OptionFooterLineEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionHeaderLine_ResEnum = class(ResEnum)
  public
    Name : OptionHeaderLineEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionPrintLogo_ResEnum = class(ResEnum)
  public
    Name : OptionPrintLogoEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionAutoOpenDrawer_ResEnum = class(ResEnum)
  public
    Name : OptionAutoOpenDrawerEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionAutoCut_ResEnum = class(ResEnum)
  public
    Name : OptionAutoCutEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionExternalDispManagement_ResEnum = class(ResEnum)
  public
    Name : OptionExternalDispManagementEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionReceiptSend_ResEnum = class(ResEnum)
  public
    Name : OptionReceiptSendEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionEnableCurrency_ResEnum = class(ResEnum)
  public
    Name : OptionEnableCurrencyEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionWorkOperatorCount_ResEnum = class(ResEnum)
  public
    Name : OptionWorkOperatorCountEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionPrice_ResEnum = class(ResEnum)
  public
    Name : OptionPriceEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionQuantityType_ResEnum = class(ResEnum)
  public
    Name : OptionQuantityTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionBTstatus_ResEnum = class(ResEnum)
  public
    Name : OptionBTstatusEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionIsReceiptOpened_ResEnum = class(ResEnum)
  public
    Name : OptionIsReceiptOpenedEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionInitiatedPayment_ResEnum = class(ResEnum)
  public
    Name : OptionInitiatedPaymentEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionFinalizedPayment_ResEnum = class(ResEnum)
  public
    Name : OptionFinalizedPaymentEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionPowerDownInReceipt_ResEnum = class(ResEnum)
  public
    Name : OptionPowerDownInReceiptEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionLAN_ResEnum = class(ResEnum)
  public
    Name : OptionLANEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionWiFi_ResEnum = class(ResEnum)
  public
    Name : OptionWiFiEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionGPRS_ResEnum = class(ResEnum)
  public
    Name : OptionGPRSEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionBT_ResEnum = class(ResEnum)
  public
    Name : OptionBTEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionDhcpStatus_ResEnum = class(ResEnum)
  public
    Name : OptionDhcpStatusEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionExternalType_ResEnum = class(ResEnum)
  public
    Name : OptionExternalTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionAddressType_ResEnum = class(ResEnum)
  public
    Name : OptionAddressTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionTCPAutoStart_ResEnum = class(ResEnum)
  public
    Name : OptionTCPAutoStartEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionUsedModule_ResEnum = class(ResEnum)
  public
    Name : OptionUsedModuleEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionDeviceType_ResEnum = class(ResEnum)
  public
    Name : OptionDeviceTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  Bluetooth_PasswordRes = class(TPersistent)
  private
    FPassLength: double;
    FPassword: WideString;
  published
    {(Length) Up to 3 symbols for the BT password length}
    Property PassLength: double read FPassLength write FPassLength;
    {Up to 100 symbols for the BT password}
    Property Password: WideString read FPassword write FPassword;
  end;

  CurrentRecInfoRes = class(TPersistent)
  private
    FOptionIsReceiptOpened: OptionIsReceiptOpened_ResEnum;
    FOptionReceiptType: OptionReceiptType_ResEnum;
    FSalesNumber: WideString;
    FMacSubtotalVATG0: WideString;
    FMacSubtotalVATG1: WideString;
    FMacSubtotalVATG2: WideString;
    FMacSubtotalVATG3: WideString;
    FImpSubtotalVATG0: WideString;
    FImpSubtotalVATG1: WideString;
    FImpSubtotalVATG2: WideString;
    FImpSubtotalVATG3: WideString;
    FOptionInitiatedPayment: OptionInitiatedPayment_ResEnum;
    FOptionFinalizedPayment: OptionFinalizedPayment_ResEnum;
    FOptionPowerDownInReceipt: OptionPowerDownInReceipt_ResEnum;
    FChangeAmount: double;
    FOptionChangeType: OptionChangeType_ResEnum;
  published
    {1 symbol with value:     
 - '0' - No     
 - '1' - Yes}
    Property OptionIsReceiptOpened: OptionIsReceiptOpened_ResEnum read FOptionIsReceiptOpened write FOptionIsReceiptOpened;
    {1 symbol with value:     
 - '1' - Sale      
 - '0' - Storno}
    Property OptionReceiptType: OptionReceiptType_ResEnum read FOptionReceiptType write FOptionReceiptType;
    {3 symbols for number of sales}
    Property SalesNumber: WideString read FSalesNumber write FSalesNumber;
    {11 symbols for subtotal from Macedonian goods by VAT groups}
    Property MacSubtotalVATG0: WideString read FMacSubtotalVATG0 write FMacSubtotalVATG0;
    {11 symbols for subtotal from Macedonian goods by VAT groups}
    Property MacSubtotalVATG1: WideString read FMacSubtotalVATG1 write FMacSubtotalVATG1;
    {11 symbols for subtotal from Macedonian goods by VAT groups}
    Property MacSubtotalVATG2: WideString read FMacSubtotalVATG2 write FMacSubtotalVATG2;
    {11 symbols for subtotal from Macedonian goods by VAT groups}
    Property MacSubtotalVATG3: WideString read FMacSubtotalVATG3 write FMacSubtotalVATG3;
    {11 symbols for subtotal from imported goods by VAT groups}
    Property ImpSubtotalVATG0: WideString read FImpSubtotalVATG0 write FImpSubtotalVATG0;
    {11 symbols for subtotal from imported goods by VAT groups}
    Property ImpSubtotalVATG1: WideString read FImpSubtotalVATG1 write FImpSubtotalVATG1;
    {11 symbols for subtotal from imported goods by VAT groups}
    Property ImpSubtotalVATG2: WideString read FImpSubtotalVATG2 write FImpSubtotalVATG2;
    {11 symbols for subtotal from imported goods by VAT groups}
    Property ImpSubtotalVATG3: WideString read FImpSubtotalVATG3 write FImpSubtotalVATG3;
    {1 symbol with value:     
 - '1' - initiated payment     
 - '0' - not initiated payment}
    Property OptionInitiatedPayment: OptionInitiatedPayment_ResEnum read FOptionInitiatedPayment write FOptionInitiatedPayment;
    {1 symbol with value:     
 - '1' - finalized payment     
 - '0' - not finalized payment}
    Property OptionFinalizedPayment: OptionFinalizedPayment_ResEnum read FOptionFinalizedPayment write FOptionFinalizedPayment;
    {1 symbol with value:     
- '0' - No     
- '1' - Yes}
    Property OptionPowerDownInReceipt: OptionPowerDownInReceipt_ResEnum read FOptionPowerDownInReceipt write FOptionPowerDownInReceipt;
    {Up to 11 symbols the amount of the due change in the stated payment     
type}
    Property ChangeAmount: double read FChangeAmount write FChangeAmount;
    {1 symbols with value:     
 - '0' - Change In Cash     
 - '1' - Same As The payment     
 - '2' - Change In Currency}
    Property OptionChangeType: OptionChangeType_ResEnum read FOptionChangeType write FOptionChangeType;
  end;

  DailyCountersRes = class(TPersistent)
  private
    FTotalReciepts: double;
    FTotalStorno: double;
    FNumLastFMBlock: double;
    FNumEJ: double;
    FDateTime: TDateTime;
  published
    {5 symbols for total number of fiscal receipts}
    Property TotalReciepts: double read FTotalReciepts write FTotalReciepts;
    {5 symbols for total number of Storno receipts}
    Property TotalStorno: double read FTotalStorno write FTotalStorno;
    {Up to 5 symbols for number of the last FM report}
    Property NumLastFMBlock: double read FNumLastFMBlock write FNumLastFMBlock;
    {Up to 5 symbols for number of EJ}
    Property NumEJ: double read FNumEJ write FNumEJ;
    {16 symbols for date and time of the last block storage in FM in format     
"DD-MM-YYYY HH:MM"}
    Property DateTime: TDateTime read FDateTime write FDateTime;
  end;

  DailyCountersByOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FWorkOperatorsCounter: double;
    FLastOperatorReportDateTime: TDateTime;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 5 symbols for number of the work operators}
    Property WorkOperatorsCounter: double read FWorkOperatorsCounter write FWorkOperatorsCounter;
    {16 symbols for date and time of the last operator's report in     
format DD-MM-YYYY HH:MM}
    Property LastOperatorReportDateTime: TDateTime read FLastOperatorReportDateTime write FLastOperatorReportDateTime;
  end;

  DailyGeneralRegistersByOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FFiscalReciept: double;
    FStornoReciept: double;
    FDiscountsNum: double;
    FDiscountsAmount: double;
    FAdditionsNum: double;
    FAdditionsAmount: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 5 symbols for daily number of fiscal receipts}
    Property FiscalReciept: double read FFiscalReciept write FFiscalReciept;
    {Up to 5 symbols for daily number of Storno receipts}
    Property StornoReciept: double read FStornoReciept write FStornoReciept;
    {Up to 5 symbols for number of discounts}
    Property DiscountsNum: double read FDiscountsNum write FDiscountsNum;
    {Up to 11 symbols for accumulated amount of discounts}
    Property DiscountsAmount: double read FDiscountsAmount write FDiscountsAmount;
    {Up to 5 symbols for number of additions}
    Property AdditionsNum: double read FAdditionsNum write FAdditionsNum;
    {Up to 11 symbols for accumulated amount of additions}
    Property AdditionsAmount: double read FAdditionsAmount write FAdditionsAmount;
  end;

  DailyPORes = class(TPersistent)
  private
    FAmountPayment: double;
    FNumPO: double;
  published
    {Up to 11 symbols for PO amount by type of payment}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 5 symbols for the total number of operations}
    Property NumPO: double read FNumPO write FNumPO;
  end;

  DailyPObyOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FAmountPO_Payments: double;
    FNumPO: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 11 symbols for the PO by type of payment}
    Property AmountPO_Payments: double read FAmountPO_Payments write FAmountPO_Payments;
    {Up to 5 symbols for the total number of operations}
    Property NumPO: double read FNumPO write FNumPO;
  end;

  DailyRARes = class(TPersistent)
  private
    FAmountPayment: double;
    FNumRA: double;
  published
    {Up to 11 symbols for RA amounts}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 5 symbols for the total number of operations}
    Property NumRA: double read FNumRA write FNumRA;
  end;

  DailyRAbyOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FAmountRA_Payments: double;
    FNumRA: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 11 symbols for the RA by type of payment}
    Property AmountRA_Payments: double read FAmountRA_Payments write FAmountRA_Payments;
    {Up to 5 symbols for the total number of operations}
    Property NumRA: double read FNumRA write FNumRA;
  end;

  DailyReceivedSalesAmountsRes = class(TPersistent)
  private
    FAmountPayment: double;
    FAmountPaymentOthers: double;
  published
    {Up to 11 symbols for amount received from sales or Storno change by     
cash}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 11 symbols for amount received from sales or Storno change by     
others payment}
    Property AmountPaymentOthers: double read FAmountPaymentOthers write FAmountPaymentOthers;
  end;

  DailyReceivedSalesAmountsByOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FAmountPayment: double;
    FAmountPaymentOthers: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 11 symbols for amount received from sales or Storno change by     
cash}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 11 symbols for amount received from sales or Storno change by     
others payment}
    Property AmountPaymentOthers: double read FAmountPaymentOthers write FAmountPaymentOthers;
  end;

  DailyReturnedRes = class(TPersistent)
  private
    FAmountPayment: double;
    FAmountPaymentOthers: double;
  published
    {Up to 11 symbols for amount received from sales or Storno     
change by cash}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 11 symbols for amount received from sales or Storno     
change by others payment}
    Property AmountPaymentOthers: double read FAmountPaymentOthers write FAmountPaymentOthers;
  end;

  DailyReturnedAmountsRes = class(TPersistent)
  private
    FOperNum: double;
    FAmountPayment: double;
    FAmountPaymentOthers: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 11 symbols for amount received from sales or Storno change by     
cash}
    Property AmountPayment: double read FAmountPayment write FAmountPayment;
    {Up to 11 symbols for amount received from sales or Storno change by     
others payment}
    Property AmountPaymentOthers: double read FAmountPaymentOthers write FAmountPaymentOthers;
  end;

  DailySaleAndStornoAmountsByVATRes = class(TPersistent)
  private
    FSalesAmountVATGr0: WideString;
    FSalesAmountVATGr1: WideString;
    FSalesAmountVATGr2: WideString;
    FSalesAmountVATGr3: WideString;
    FSalesMacAmountVATGr0: WideString;
    FSalesMacAmountVATGr1: WideString;
    FSalesMacAmountVATGr2: WideString;
    FSalesMacAmountVATGr3: WideString;
    FStornoAmountVATGr0: WideString;
    FStornoAmountVATGr1: WideString;
    FStornoAmountVATGr2: WideString;
    FStornoAmountVATGr3: WideString;
    FStornoMacAmountVATGr0: WideString;
    FStornoMacAmountVATGr1: WideString;
    FStornoMacAmountVATGr2: WideString;
    FStornoMacAmountVATGr3: WideString;
  published
    {Up to 11 symbols for the amount accumulated from sales by VAT     
group А}
    Property SalesAmountVATGr0: WideString read FSalesAmountVATGr0 write FSalesAmountVATGr0;
    {Up to 11 symbols for the amount accumulated from sales by VAT     
group Б}
    Property SalesAmountVATGr1: WideString read FSalesAmountVATGr1 write FSalesAmountVATGr1;
    {Up to 11 symbols for the amount accumulated from sales by VAT     
group В}
    Property SalesAmountVATGr2: WideString read FSalesAmountVATGr2 write FSalesAmountVATGr2;
    {Up to 11 symbols for the amount accumulated from sales by VAT     
group Г}
    Property SalesAmountVATGr3: WideString read FSalesAmountVATGr3 write FSalesAmountVATGr3;
    {Up to 11 symbols for the mac amount accumulated from sales by}
    Property SalesMacAmountVATGr0: WideString read FSalesMacAmountVATGr0 write FSalesMacAmountVATGr0;
    {Up to 11 symbols for the mac amount accumulated from sales by}
    Property SalesMacAmountVATGr1: WideString read FSalesMacAmountVATGr1 write FSalesMacAmountVATGr1;
    {Up to 11 symbols for the mac amount accumulated from sales by}
    Property SalesMacAmountVATGr2: WideString read FSalesMacAmountVATGr2 write FSalesMacAmountVATGr2;
    {Up to 11 symbols for the mac amount accumulated from sales by}
    Property SalesMacAmountVATGr3: WideString read FSalesMacAmountVATGr3 write FSalesMacAmountVATGr3;
    {Up to 11 symbols for the amount accumulated from Storno by VAT     
group А}
    Property StornoAmountVATGr0: WideString read FStornoAmountVATGr0 write FStornoAmountVATGr0;
    {Up to 11 symbols for the amount accumulated from Storno by VAT     
group Б}
    Property StornoAmountVATGr1: WideString read FStornoAmountVATGr1 write FStornoAmountVATGr1;
    {Up to 11 symbols for the amount accumulated from Storno by VAT     
group В}
    Property StornoAmountVATGr2: WideString read FStornoAmountVATGr2 write FStornoAmountVATGr2;
    {Up to 11 symbols for the amount accumulated from Storno by VAT     
group Г}
    Property StornoAmountVATGr3: WideString read FStornoAmountVATGr3 write FStornoAmountVATGr3;
    {Up to 11 symbols for the amount accumulated from Mac Storno by}
    Property StornoMacAmountVATGr0: WideString read FStornoMacAmountVATGr0 write FStornoMacAmountVATGr0;
    {Up to 11 symbols for the amount accumulated from Mac Storno by}
    Property StornoMacAmountVATGr1: WideString read FStornoMacAmountVATGr1 write FStornoMacAmountVATGr1;
    {Up to 11 symbols for the amount accumulated from Mac Storno by}
    Property StornoMacAmountVATGr2: WideString read FStornoMacAmountVATGr2 write FStornoMacAmountVATGr2;
    {Up to 11 symbols for the amount accumulated from Mac Storno by}
    Property StornoMacAmountVATGr3: WideString read FStornoMacAmountVATGr3 write FStornoMacAmountVATGr3;
  end;

  DepartmentRes = class(TPersistent)
  private
    FDepNum: double;
    FDepName: WideString;
    FOptionVATClass: OptionVATClass_ResEnum;
    FPrice: double;
    FFlagsPrice: WideString;
    FTurnover: double;
    FSoldQuantity: double;
    FTurnoverMac: double;
    FSoldQuantityMac: double;
    FTurnoverSt: double;
    FSoldQuantitySt: double;
    FTurnoverStMac: double;
    FSoldQuantityStMac: double;
    FLastZReportNumber: double;
    FLastZReportDate: TDateTime;
  published
    {2 symbols for department number in format ##}
    Property DepNum: double read FDepNum write FDepNum;
    {34 symbols for department name}
    Property DepName: WideString read FDepName write FDepName;
    {1 character for VAT class attachment of the department:     
 - 'А' - VAT Class 0     
 - 'Б' - VAT Class 1     
 - 'В' - VAT Class 2     
 - 'Г' - VAT Class 3}
    Property OptionVATClass: OptionVATClass_ResEnum read FOptionVATClass write FOptionVATClass;
    {1..11 symbols for Department price}
    Property Price: double read FPrice write FPrice;
    {(Setting price, signle transaction, type of goods) 1 symbol with value:     
Flags.7=1     
Flags.6=0     
Flags.5=0     
Flags.4=1 Yes, Flags.4=0 No (Macedonian goods)     
Flags.3=0     
Flags.2=1 Yes, Flags.2=0 No (Single Transaction)     
Flags.1=1 Yes, Flags.1=0 No (Free price limited)     
Flags.0=1 Yes, Flags.0=0 No (Free price enabled)}
    Property FlagsPrice: WideString read FFlagsPrice write FFlagsPrice;
    {Up to 11 symbols for accumulated turnover of the department}
    Property Turnover: double read FTurnover write FTurnover;
    {Up to 11 symbols for sold quantity of the department}
    Property SoldQuantity: double read FSoldQuantity write FSoldQuantity;
    {Up to 11 symbols for maced. turnover of the department}
    Property TurnoverMac: double read FTurnoverMac write FTurnoverMac;
    {Up to 11 symbols for maced. sold quantity of the department}
    Property SoldQuantityMac: double read FSoldQuantityMac write FSoldQuantityMac;
    {Up to 11 symbols for Storno turnover of the department}
    Property TurnoverSt: double read FTurnoverSt write FTurnoverSt;
    {Up to 11 symbols for Storno}
    Property SoldQuantitySt: double read FSoldQuantitySt write FSoldQuantitySt;
    {Up to 11 symbols for Storno maced.turnover by this department}
    Property TurnoverStMac: double read FTurnoverStMac write FTurnoverStMac;
    {Up to 11 symbols for Storno maced quantity}
    Property SoldQuantityStMac: double read FSoldQuantityStMac write FSoldQuantityStMac;
    {Up to 5 symbols for the number of last Z report in format #####}
    Property LastZReportNumber: double read FLastZReportNumber write FLastZReportNumber;
    {16 symbols for the date and hour in last Z report}
    Property LastZReportDate: TDateTime read FLastZReportDate write FLastZReportDate;
  end;

  DeviceModuleSupportRes = class(TPersistent)
  private
    FOptionLAN: OptionLAN_ResEnum;
    FOptionWiFi: OptionWiFi_ResEnum;
    FOptionGPRS: OptionGPRS_ResEnum;
    FOptionBT: OptionBT_ResEnum;
  published
    {1 symbol for LAN suppor     
- '0' - No     
 - '1' - Yes}
    Property OptionLAN: OptionLAN_ResEnum read FOptionLAN write FOptionLAN;
    {1 symbol for WiFi support     
- '0' - No     
 - '1' - Yes}
    Property OptionWiFi: OptionWiFi_ResEnum read FOptionWiFi write FOptionWiFi;
    {1 symbol for GPRS support     
- '0' - No     
 - '1' - Yes     
BT (Bluetooth) 1 symbol for Bluetooth support     
- '0' - No     
 - '1' - Yes}
    Property OptionGPRS: OptionGPRS_ResEnum read FOptionGPRS write FOptionGPRS;
    {(Bluetooth) 1 symbol for Bluetooth support     
- '0' - No     
 - '1' - Yes}
    Property OptionBT: OptionBT_ResEnum read FOptionBT write FOptionBT;
  end;

  DeviceModuleSupportByFirmwareRes = class(TPersistent)
  private
    FOptionLAN: OptionLAN_ResEnum;
    FOptionWiFi: OptionWiFi_ResEnum;
    FOptionGPRS: OptionGPRS_ResEnum;
    FOptionBT: OptionBT_ResEnum;
  published
    {1 symbol for LAN suppor     
- '0' - No     
 - '1' - Yes}
    Property OptionLAN: OptionLAN_ResEnum read FOptionLAN write FOptionLAN;
    {1 symbol for WiFi support     
- '0' - No     
 - '1' - Yes}
    Property OptionWiFi: OptionWiFi_ResEnum read FOptionWiFi write FOptionWiFi;
    {1 symbol for GPRS support     
- '0' - No     
 - '1' - Yes     
BT (Bluetooth) 1 symbol for Bluetooth support     
- '0' - No     
 - '1' - Yes}
    Property OptionGPRS: OptionGPRS_ResEnum read FOptionGPRS write FOptionGPRS;
    {(Bluetooth) 1 symbol for Bluetooth support     
- '0' - No     
 - '1' - Yes}
    Property OptionBT: OptionBT_ResEnum read FOptionBT write FOptionBT;
  end;

  FooterRes = class(TPersistent)
  private
    FOptionFooterLine: OptionFooterLine_ResEnum;
    FFooterText: WideString;
  published
    {(Line Number)1 symbol with value:     
 - 'F1' - Footer 1     
 - 'F2' - Footer 2     
 - 'F3' - Footer 3}
    Property OptionFooterLine: OptionFooterLine_ResEnum read FOptionFooterLine write FOptionFooterLine;
    {TextLength symbols for footer line}
    Property FooterText: WideString read FFooterText write FFooterText;
  end;

  GeneralDailyRegistersRes = class(TPersistent)
  private
    FFiscalReciept: double;
    FStornoReciept: double;
    FDiscountsNum: double;
    FDiscountsAmount: double;
    FAdditionsNum: double;
    FAdditionsAmount: double;
  published
    {1..5 symbols for daily number of fiscal receipts}
    Property FiscalReciept: double read FFiscalReciept write FFiscalReciept;
    {1..5 symbols for daily number of Storno receipts}
    Property StornoReciept: double read FStornoReciept write FStornoReciept;
    {Up to 5 symbols for number of discounts}
    Property DiscountsNum: double read FDiscountsNum write FDiscountsNum;
    {Up to 11 symbols for accumulated amount of discounts}
    Property DiscountsAmount: double read FDiscountsAmount write FDiscountsAmount;
    {Up to 5 symbols for number of additions}
    Property AdditionsNum: double read FAdditionsNum write FAdditionsNum;
    {Up to 11 symbols for accumulated amount of additions}
    Property AdditionsAmount: double read FAdditionsAmount write FAdditionsAmount;
  end;

  GPRS_APNRes = class(TPersistent)
  private
    FGPRS_APN_Len: double;
    FAPN: WideString;
  published
    {(Length) Up to 3 symbols for the APN length}
    Property GPRS_APN_Len: double read FGPRS_APN_Len write FGPRS_APN_Len;
    {Up to 100 symbols for the device's GPRS APN}
    Property APN: WideString read FAPN write FAPN;
  end;

  GPRS_PasswordRes = class(TPersistent)
  private
    FPassLength: double;
    FPassword: WideString;
  published
    {(Length) Up to 3 symbols for the GPRS password length}
    Property PassLength: double read FPassLength write FPassLength;
    {Up to 100 symbols for the device's GPRS password}
    Property Password: WideString read FPassword write FPassword;
  end;

  GPRS_UsernameRes = class(TPersistent)
  private
    FGPRS_User_Len: double;
    FUsername: WideString;
  published
    {(Length) Up to 3 symbols for the GPRS username length}
    Property GPRS_User_Len: double read FGPRS_User_Len write FGPRS_User_Len;
    {Up to 100 symbols for the device's GPRS username}
    Property Username: WideString read FUsername write FUsername;
  end;

  HeaderRes = class(TPersistent)
  private
    FOptionHeaderLine: OptionHeaderLine_ResEnum;
    FHeaderText: WideString;
  published
    {(Line Number)1 byte with value:     
 - '1' - Header 1     
 - '2' - Header 2     
 - '3' - Header 3     
 - '4' - Header 4     
 - '5' - Header 5     
 - '6' - Header 6     
 - '7' - ID number     
 - '8' - VAT number}
    Property OptionHeaderLine: OptionHeaderLine_ResEnum read FOptionHeaderLine write FOptionHeaderLine;
    {TextLength symbols}
    Property HeaderText: WideString read FHeaderText write FHeaderText;
  end;

  KeyServerAddressRes = class(TPersistent)
  private
    FParamLength: double;
    FAddress: WideString;
  published
    {Up to 3 symbols for parameter length}
    Property ParamLength: double read FParamLength write FParamLength;
    {60 symbols for address}
    Property Address: WideString read FAddress write FAddress;
  end;

  LastDailyReportInfoRes = class(TPersistent)
  private
    FLastZDailyReportDate: TDateTime;
    FLastZDailyReportNum: double;
    FLastRAMResetNum: double;
  published
    {10 symbols for last Z-report date in DD-MM-YYYY format}
    Property LastZDailyReportDate: TDateTime read FLastZDailyReportDate write FLastZDailyReportDate;
    {Up to 4 symbols for the number of the last daily report}
    Property LastZDailyReportNum: double read FLastZDailyReportNum write FLastZDailyReportNum;
    {Up to 4 symbols for the number of the last RAM reset}
    Property LastRAMResetNum: double read FLastRAMResetNum write FLastRAMResetNum;
  end;

  LastReceiptNumRes = class(TPersistent)
  private
    FLastReceiptNum: double;
    FLastStornoNum: double;
  published
    {Up to 4 symbols in format #### for the number of last issued fiscal receipt}
    Property LastReceiptNum: double read FLastReceiptNum write FLastReceiptNum;
    {Up to 4 symbols in format #### for the number of last issued Storno receipt}
    Property LastStornoNum: double read FLastStornoNum write FLastStornoNum;
  end;

  OperatorNamePasswordRes = class(TPersistent)
  private
    FNumber: double;
    FName: WideString;
    FPassword: WideString;
  published
    {Symbol from 1 to 20 corresponding to the number of operator}
    Property Number: double read FNumber write FNumber;
    {20 symbols for operator's name}
    Property Name: WideString read FName write FName;
    {4 symbols for operator's password}
    Property Password: WideString read FPassword write FPassword;
  end;

  ParametersRes = class(TPersistent)
  private
    FPOSNum: double;
    FOptionPrintLogo: OptionPrintLogo_ResEnum;
    FOptionAutoOpenDrawer: OptionAutoOpenDrawer_ResEnum;
    FOptionAutoCut: OptionAutoCut_ResEnum;
    FOptionExternalDispManagement: OptionExternalDispManagement_ResEnum;
    FOptionReceiptSend: OptionReceiptSend_ResEnum;
    FOptionEnableCurrency: OptionEnableCurrency_ResEnum;
    FOptionWorkOperatorCount: OptionWorkOperatorCount_ResEnum;
  published
    {(POS Number) 4 symbols for number of POS in format ####}
    Property POSNum: double read FPOSNum write FPOSNum;
    {(Print Logo) 1 symbol of value:     
 - '1' - Yes     
 - '0' - No}
    Property OptionPrintLogo: OptionPrintLogo_ResEnum read FOptionPrintLogo write FOptionPrintLogo;
    {(Auto Open Drawer) 1 symbol of value:     
 - '1' - Yes     
 - '0' - No}
    Property OptionAutoOpenDrawer: OptionAutoOpenDrawer_ResEnum read FOptionAutoOpenDrawer write FOptionAutoOpenDrawer;
    {(Auto Cut) 1 symbol of value:     
 - '1' - Yes     
 - '0' - No}
    Property OptionAutoCut: OptionAutoCut_ResEnum read FOptionAutoCut write FOptionAutoCut;
    {(External Display Management) 1 symbol of value:     
 - '1' - Manual     
 - '0' - Auto}
    Property OptionExternalDispManagement: OptionExternalDispManagement_ResEnum read FOptionExternalDispManagement write FOptionExternalDispManagement;
    {1 symbol of value:     
- '1' - Automatic sending     
- '0' - Without sending}
    Property OptionReceiptSend: OptionReceiptSend_ResEnum read FOptionReceiptSend write FOptionReceiptSend;
    {(Enable Currency) 1 symbol of value:     
 - '1' - Yes     
 - '0' - No}
    Property OptionEnableCurrency: OptionEnableCurrency_ResEnum read FOptionEnableCurrency write FOptionEnableCurrency;
    {(Work Operator Count) 1 symbol of value:     
 - '1' - One     
 - '0' - More}
    Property OptionWorkOperatorCount: OptionWorkOperatorCount_ResEnum read FOptionWorkOperatorCount write FOptionWorkOperatorCount;
  end;

  PaymentsRes = class(TPersistent)
  private
    FNamePaym0: WideString;
    FNamePaym1: WideString;
    FNamePaym2: WideString;
    FNamePaym3: WideString;
    FNamePaym4: WideString;
    FExchangeRate: double;
  published
    {10 symbols for type 0 of payment name}
    Property NamePaym0: WideString read FNamePaym0 write FNamePaym0;
    {10 symbols for type 1 of payment name}
    Property NamePaym1: WideString read FNamePaym1 write FNamePaym1;
    {10 symbols for type 2 of payment name}
    Property NamePaym2: WideString read FNamePaym2 write FNamePaym2;
    {10 symbols for type 3 of payment name}
    Property NamePaym3: WideString read FNamePaym3 write FNamePaym3;
    {10 symbols for type 4 of payment name}
    Property NamePaym4: WideString read FNamePaym4 write FNamePaym4;
    {10 symbols for exchange rate of payment type 4 in format: ####.#####}
    Property ExchangeRate: double read FExchangeRate write FExchangeRate;
  end;

  PLUbarcodeRes = class(TPersistent)
  private
    FPLUNum: double;
    FBarcode: WideString;
  published
    {5 symbols for article number with leading zeroes in format #####}
    Property PLUNum: double read FPLUNum write FPLUNum;
    {13 symbols for article barcode}
    Property Barcode: WideString read FBarcode write FBarcode;
  end;

  PLUgeneralRes = class(TPersistent)
  private
    FPLUNum: double;
    FPLUName: WideString;
    FPrice: double;
    FFlagsPriceQty: WideString;
    FBelongToDepNumber: double;
    FAvailableQuantity: WideString;
    FBarcode: WideString;
    FTurnoverAmount: WideString;
    FSoldQuantity: WideString;
    FStornoTurnover: WideString;
    FStornoQuantity: WideString;
    FLastZReportNumber: double;
    FLastZReportDate: TDateTime;
  published
    {5 symbols for article number with leading zeroes in format: #####}
    Property PLUNum: double read FPLUNum write FPLUNum;
    {32 symbols for article name}
    Property PLUName: WideString read FPLUName write FPLUName;
    {1..10 symbols for article price}
    Property Price: double read FPrice write FPrice;
    {(Setting price, quantity, type of goods) 1 symbols with value:     
Flags.7=1     
Flags.6=0     
Flags.5=0     
Flags.4=1 Yes, Flags.4=0 No (Macedonian goods)     
Flags.3=1 Yes, Flags.3=0 No (Allow negative)     
Flags.2=1 Yes, Flags.2=0 No (Monitoring quantity in stock)     
Flags.1=1 Yes, Flags.1=0 No (Free price limited)     
Flags.0=1 Yes, Flags.0=0 No (Free price enabled)}
    Property FlagsPriceQty: WideString read FFlagsPriceQty write FFlagsPriceQty;
    {BelongToDepNo + 80h, 1 symbol for PLU department = 0x80 … 0x93}
    Property BelongToDepNumber: double read FBelongToDepNumber write FBelongToDepNumber;
    {Up to11 symbols for quantity in stock}
    Property AvailableQuantity: WideString read FAvailableQuantity write FAvailableQuantity;
    {13 symbols for article barcode}
    Property Barcode: WideString read FBarcode write FBarcode;
    {Up to 11symbols for PLU accumulated turnover}
    Property TurnoverAmount: WideString read FTurnoverAmount write FTurnoverAmount;
    {Up to 11 symbols for Sales quantity of the article}
    Property SoldQuantity: WideString read FSoldQuantity write FSoldQuantity;
    {Up to 11 symbols for accumulated Storno turnover}
    Property StornoTurnover: WideString read FStornoTurnover write FStornoTurnover;
    {Up to 11 symbols for accumulated Storno quantiy}
    Property StornoQuantity: WideString read FStornoQuantity write FStornoQuantity;
    {Up to 5 symbols for the number of the last article report with zeroing}
    Property LastZReportNumber: double read FLastZReportNumber write FLastZReportNumber;
    {16 symbols for the date and time of the last article report with zeroing     
in format DD-MM-YYYY HH:MM}
    Property LastZReportDate: TDateTime read FLastZReportDate write FLastZReportDate;
  end;

  PLUpriceRes = class(TPersistent)
  private
    FPLUNum: double;
    FPrice: double;
    FOptionPrice: OptionPrice_ResEnum;
  published
    {5 symbols for article number with leading zeroes in format #####}
    Property PLUNum: double read FPLUNum write FPLUNum;
    {1..10 symbols for article price}
    Property Price: double read FPrice write FPrice;
    {1 byte for Price flag with next value:     
 - '0'- Free price is disable valid only programmed price     
 - '1'- Free price is enable     
 - '2'- Limited price}
    Property OptionPrice: OptionPrice_ResEnum read FOptionPrice write FOptionPrice;
  end;

  PLUqtyRes = class(TPersistent)
  private
    FPLUNum: double;
    FAvailableQuantity: double;
    FOptionQuantityType: OptionQuantityType_ResEnum;
  published
    {5 symbols for article number with leading zeroes in format #####}
    Property PLUNum: double read FPLUNum write FPLUNum;
    {Up to13 symbols for quantity in stock}
    Property AvailableQuantity: double read FAvailableQuantity write FAvailableQuantity;
    {1 symbol for Quantity flag with next value:      
- '0'- Availability of PLU stock is not monitored      
- '1'- Disable negative quantity      
- '2'- Enable negative quantity}
    Property OptionQuantityType: OptionQuantityType_ResEnum read FOptionQuantityType write FOptionQuantityType;
  end;

  RegisterServerAddressRes = class(TPersistent)
  private
    FParamLength: double;
    FAddress: WideString;
  published
    {Up to 3 symbols for parameter length}
    Property ParamLength: double read FParamLength write FParamLength;
    {60 symbols for address}
    Property Address: WideString read FAddress write FAddress;
  end;

  RegistrationInfoRes = class(TPersistent)
  private
    FIDNum: WideString;
    FVATNum: WideString;
    FRegistrationNumber: WideString;
    FRegistrationDate: TDateTime;
  published
    {13 symbols owner's ID number (ЕДБ)}
    Property IDNum: WideString read FIDNum write FIDNum;
    {15 symbols for owner's VAT registration number (ДДВ)}
    Property VATNum: WideString read FVATNum write FVATNum;
    {Register number on the Fiscal device by registration}
    Property RegistrationNumber: WideString read FRegistrationNumber write FRegistrationNumber;
    {Date of registration}
    Property RegistrationDate: TDateTime read FRegistrationDate write FRegistrationDate;
  end;

  SerialAndFiscalNumsRes = class(TPersistent)
  private
    FSerialNumber: WideString;
    FFMNumber: WideString;
    FECR_UniqueNum: WideString;
  published
    {11 symbols for individual number of the fiscal device}
    Property SerialNumber: WideString read FSerialNumber write FSerialNumber;
    {11 symbols for individual number of the fiscal memory}
    Property FMNumber: WideString read FFMNumber write FFMNumber;
    {24 symbols for ECR unique number}
    Property ECR_UniqueNum: WideString read FECR_UniqueNum write FECR_UniqueNum;
  end;

  ServerAddressRes = class(TPersistent)
  private
    FParamLength: double;
    FAddress: WideString;
  published
    {Up to 3 symbols for parameter length}
    Property ParamLength: double read FParamLength write FParamLength;
    {60 symbols for address}
    Property Address: WideString read FAddress write FAddress;
  end;

  StatusRes = class(TPersistent)
  private
    FFM_Read_only: boolean;
    FPower_down_in_opened_fiscal_receipt: boolean;
    FPrinter_not_ready_overheat: boolean;
    FDateTime_not_set: boolean;
    FDateTime_wrong: boolean;
    FRAM_reset: boolean;
    FHardware_clock_error: boolean;
    FPrinter_not_ready_no_paper: boolean;
    FReports_registers_Overflow: boolean;
    FBlocking_after_24_hours_without_report: boolean;
    FDaily_report_is_not_zeroed: boolean;
    FArticle_report_is_not_zeroed: boolean;
    FOperator_report_is_not_zeroed: boolean;
    FNon_printed_copy: boolean;
    FOpened_Non_fiscal_Receipt: boolean;
    FOpened_Fiscal_Receipt: boolean;
    Ffiscal_receipt_type_1: boolean;
    Ffiscal_receipt_type_2: boolean;
    Ffiscal_receipt_type_3: boolean;
    FSD_card_near_full: boolean;
    FSD_card_full: boolean;
    FNo_FM_module: boolean;
    FFM_error: boolean;
    FFM_full: boolean;
    FFM_near_full: boolean;
    FDecimal_point: boolean;
    FFM_fiscalized: boolean;
    FFM_produced: boolean;
    FPrinter_automatic_cutting: boolean;
    FExternal_display_transparent_display: boolean;
    FMissing_display: boolean;
    FDrawer_automatic_opening: boolean;
    FCustomer_logo_included_in_the_receipt: boolean;
    FBlocking_after_10_days_without_communication: boolean;
    FWrong_SIM_card: boolean;
    FWrong_SD_card: boolean;
    FNo_SIM_card: boolean;
    FNo_GPRS_Modem: boolean;
    FNo_mobile_operator: boolean;
    FNo_GPRS_service: boolean;
    FNear_end_of_paper: boolean;
  published
    {FM Read only}
    Property FM_Read_only: boolean read FFM_Read_only write FFM_Read_only;
    {Power down in opened fiscal receipt}
    Property Power_down_in_opened_fiscal_receipt: boolean read FPower_down_in_opened_fiscal_receipt write FPower_down_in_opened_fiscal_receipt;
    {Printer not ready - overheat}
    Property Printer_not_ready_overheat: boolean read FPrinter_not_ready_overheat write FPrinter_not_ready_overheat;
    {DateTime not set}
    Property DateTime_not_set: boolean read FDateTime_not_set write FDateTime_not_set;
    {DateTime wrong}
    Property DateTime_wrong: boolean read FDateTime_wrong write FDateTime_wrong;
    {RAM reset}
    Property RAM_reset: boolean read FRAM_reset write FRAM_reset;
    {Hardware clock error}
    Property Hardware_clock_error: boolean read FHardware_clock_error write FHardware_clock_error;
    {Printer not ready - no paper}
    Property Printer_not_ready_no_paper: boolean read FPrinter_not_ready_no_paper write FPrinter_not_ready_no_paper;
    {Reports registers Overflow}
    Property Reports_registers_Overflow: boolean read FReports_registers_Overflow write FReports_registers_Overflow;
    {Blocking after 24 hours without report}
    Property Blocking_after_24_hours_without_report: boolean read FBlocking_after_24_hours_without_report write FBlocking_after_24_hours_without_report;
    {Daily report is not zeroed}
    Property Daily_report_is_not_zeroed: boolean read FDaily_report_is_not_zeroed write FDaily_report_is_not_zeroed;
    {Article report is not zeroed}
    Property Article_report_is_not_zeroed: boolean read FArticle_report_is_not_zeroed write FArticle_report_is_not_zeroed;
    {Operator report is not zeroed}
    Property Operator_report_is_not_zeroed: boolean read FOperator_report_is_not_zeroed write FOperator_report_is_not_zeroed;
    {Non-printed copy}
    Property Non_printed_copy: boolean read FNon_printed_copy write FNon_printed_copy;
    {Opened Non-fiscal Receipt}
    Property Opened_Non_fiscal_Receipt: boolean read FOpened_Non_fiscal_Receipt write FOpened_Non_fiscal_Receipt;
    {Opened Fiscal Receipt}
    Property Opened_Fiscal_Receipt: boolean read FOpened_Fiscal_Receipt write FOpened_Fiscal_Receipt;
    {fiscal receipt type 1}
    Property fiscal_receipt_type_1: boolean read Ffiscal_receipt_type_1 write Ffiscal_receipt_type_1;
    {fiscal receipt type 2}
    Property fiscal_receipt_type_2: boolean read Ffiscal_receipt_type_2 write Ffiscal_receipt_type_2;
    {fiscal receipt type 3}
    Property fiscal_receipt_type_3: boolean read Ffiscal_receipt_type_3 write Ffiscal_receipt_type_3;
    {SD card near full}
    Property SD_card_near_full: boolean read FSD_card_near_full write FSD_card_near_full;
    {SD card full}
    Property SD_card_full: boolean read FSD_card_full write FSD_card_full;
    {No FM module}
    Property No_FM_module: boolean read FNo_FM_module write FNo_FM_module;
    {FM error}
    Property FM_error: boolean read FFM_error write FFM_error;
    {FM full}
    Property FM_full: boolean read FFM_full write FFM_full;
    {FM near full}
    Property FM_near_full: boolean read FFM_near_full write FFM_near_full;
    {Decimal point (1=fract, 0=whole)}
    Property Decimal_point: boolean read FDecimal_point write FDecimal_point;
    {FM fiscalized}
    Property FM_fiscalized: boolean read FFM_fiscalized write FFM_fiscalized;
    {FM produced}
    Property FM_produced: boolean read FFM_produced write FFM_produced;
    {Printer: automatic cutting}
    Property Printer_automatic_cutting: boolean read FPrinter_automatic_cutting write FPrinter_automatic_cutting;
    {External display: transparent display}
    Property External_display_transparent_display: boolean read FExternal_display_transparent_display write FExternal_display_transparent_display;
    {Missing display}
    Property Missing_display: boolean read FMissing_display write FMissing_display;
    {Drawer: automatic opening}
    Property Drawer_automatic_opening: boolean read FDrawer_automatic_opening write FDrawer_automatic_opening;
    {Customer logo included in the receipt}
    Property Customer_logo_included_in_the_receipt: boolean read FCustomer_logo_included_in_the_receipt write FCustomer_logo_included_in_the_receipt;
    {Blocking after 10 days without communication}
    Property Blocking_after_10_days_without_communication: boolean read FBlocking_after_10_days_without_communication write FBlocking_after_10_days_without_communication;
    {Wrong SIM card}
    Property Wrong_SIM_card: boolean read FWrong_SIM_card write FWrong_SIM_card;
    {Wrong SD card}
    Property Wrong_SD_card: boolean read FWrong_SD_card write FWrong_SD_card;
    {No SIM card}
    Property No_SIM_card: boolean read FNo_SIM_card write FNo_SIM_card;
    {No GPRS Modem}
    Property No_GPRS_Modem: boolean read FNo_GPRS_Modem write FNo_GPRS_Modem;
    {No mobile operator}
    Property No_mobile_operator: boolean read FNo_mobile_operator write FNo_mobile_operator;
    {No GPRS service}
    Property No_GPRS_service: boolean read FNo_GPRS_service write FNo_GPRS_service;
    {Near end of paper}
    Property Near_end_of_paper: boolean read FNear_end_of_paper write FNear_end_of_paper;
  end;

  TCP_AddressesRes = class(TPersistent)
  private
    FOptionAddressType: OptionAddressType_ResEnum;
    FDeviceAddress: WideString;
  published
    {(Address) 1 symbol with value:     
 - '2' - IP address     
 - '3' - Subnet Mask     
 - '4' - Gateway address     
 - '5' - DNS address}
    Property OptionAddressType: OptionAddressType_ResEnum read FOptionAddressType write FOptionAddressType;
    {15 symbols for the device's addresses}
    Property DeviceAddress: WideString read FDeviceAddress write FDeviceAddress;
  end;

  TCP_PasswordRes = class(TPersistent)
  private
    FPassLength: double;
    FPassword: WideString;
  published
    {(Length) Up to 3 symbols for the password length}
    Property PassLength: double read FPassLength write FPassLength;
    {Up to 100 symbols for the TCP password}
    Property Password: WideString read FPassword write FPassword;
  end;

  TotalFiscalSumsRes = class(TPersistent)
  private
    FSumSalesTurnover: WideString;
    FSumStornoTurnover: WideString;
    FSumSalesVAT: WideString;
    FSumStornoVAT: WideString;
    FSumMacSalesTurnover: WideString;
    FSumMacStornoTurnover: WideString;
    FSumMacSalesVAT: WideString;
    FSumMacStornoVAT: WideString;
  published
    {14 s. for total grand sum of sales turnover from fiscal registration}
    Property SumSalesTurnover: WideString read FSumSalesTurnover write FSumSalesTurnover;
    {14 s. for total sum of Storno turnover from fiscal registration}
    Property SumStornoTurnover: WideString read FSumStornoTurnover write FSumStornoTurnover;
    {14 s. for total VAT sum of sales from fiscal registration}
    Property SumSalesVAT: WideString read FSumSalesVAT write FSumSalesVAT;
    {14 s. for total VAT sum of Storno from fiscal registration}
    Property SumStornoVAT: WideString read FSumStornoVAT write FSumStornoVAT;
    {14 s. for total grand sum of maced. sales turnover from fiscal     
registration}
    Property SumMacSalesTurnover: WideString read FSumMacSalesTurnover write FSumMacSalesTurnover;
    {14 s. for total sum of maced.Storno turnover from fiscal     
registration}
    Property SumMacStornoTurnover: WideString read FSumMacStornoTurnover write FSumMacStornoTurnover;
    {14 s. for total VAT sum of maced.sales from fiscal registration}
    Property SumMacSalesVAT: WideString read FSumMacSalesVAT write FSumMacSalesVAT;
    {14 s. for total VAT sum of maced.Storno from fiscal registration}
    Property SumMacStornoVAT: WideString read FSumMacStornoVAT write FSumMacStornoVAT;
  end;

  VATratesRes = class(TPersistent)
  private
    FVATrate0: double;
    FVATrate1: double;
    FVATrate2: double;
    FVATrate3: double;
  published
    {Value of VAT rate А from 7 symbols in format ##.##%}
    Property VATrate0: double read FVATrate0 write FVATrate0;
    {Value of VAT rate Б from 7 symbols in format ##.##%}
    Property VATrate1: double read FVATrate1 write FVATrate1;
    {Value of VAT rate В from 7 symbols in format ##.##%}
    Property VATrate2: double read FVATrate2 write FVATrate2;
    {Value of VAT rate Г from 7 symbols in format ##.##%}
    Property VATrate3: double read FVATrate3 write FVATrate3;
  end;

  VersionRes = class(TPersistent)
  private
    FOptionDeviceType: OptionDeviceType_ResEnum;
    FModel: WideString;
    FVersion: WideString;
  published
    {1 symbol for type of fiscal device:     
- '1'- ECR     
- '2'- FPr}
    Property OptionDeviceType: OptionDeviceType_ResEnum read FOptionDeviceType write FOptionDeviceType;
    {Up to 50 symbols for Model name}
    Property Model: WideString read FModel write FModel;
    {Up to 20 symbols for Version name and Check sum}
    Property Version: WideString read FVersion write FVersion;
  end;

  WiFi_NetworkNameRes = class(TPersistent)
  private
    FWiFiNameLength: double;
    FWiFiNetworkName: WideString;
  published
    {(Length) Up to 3 symbols for the WiFi name length}
    Property WiFiNameLength: double read FWiFiNameLength write FWiFiNameLength;
    {(Name) Up to 100 symbols for the device's WiFi network name}
    Property WiFiNetworkName: WideString read FWiFiNetworkName write FWiFiNetworkName;
  end;

  WiFi_PasswordRes = class(TPersistent)
  private
    FPassLength: double;
    FPassword: WideString;
  published
    {(Length) Up to 3 symbols for the WiFi password length}
    Property PassLength: double read FPassLength write FPassLength;
    {Up to 100 symbols for the device's WiFi password}
    Property Password: WideString read FPassword write FPassword;
  end;

  FP = class(FP_Core)
  public
    constructor Create(); overload;
    {Opens the cash drawer.}
    procedure CashDrawerOpen();

    {Paying the exact amount in cash and close the fiscal receipt.}
    procedure CashPayCloseReceipt();

    {Clears the external display.}
    procedure ClearDisplay();

    {Closes the non-fiscal receipt.}
    procedure CloseNonFiscReceipt();

    {Close the fiscal receipt (Fiscal receipt, Storno receipt, or Non-fical receipt). When the payment is finished.}
    procedure CloseReceipt();

    {Confirm storing VAT and ID numbers into the operative memory.}
    procedure ConfirmIDNumandVATnum(Password: WideString);

    {Start paper cutter. The command works only in fiscal printer devices.}
    procedure CutPaper();

    {Executes the direct command .}
    function DirectCommand(Input: WideString): WideString;
    {Shows the current date and time on the external display.}
    procedure DisplayDateTime();

    {Shows a 20-symbols text in the upper external display line.}
    procedure DisplayTextLine1(Text: WideString);

    {Shows a 20-symbols text in the lower external display line.}
    procedure DisplayTextLine2(Text: WideString);

    {Shows a 20-symbols text in the first line and last 20-symbols text in the second line of the external display lines.}
    procedure DisplayTextLines1and2(Text: WideString);

    {Enter Service mode}
    procedure EnterServiceMode(OptionServiceMode: OptionServiceModeEnum; ServicePassword: WideString);

    {Temporary enable/disable detailed receipts info sending}
    procedure ManageDetailedReceiptInfoSending(OptionActivationRS: OptionActivationRSEnum);

    {Temporary enable/disable short receipts sending}
    procedure ManageShortReceiptSending(OptionActivationRS: OptionActivationRSEnum);

    {Opens a non-fiscal receipt assigned to the specified operator}
    procedure OpenNonFiscalReceipt(OperNum: double; OperPass: WideString);

    {Opens a fiscal receipt assigned to the specified operator}
    procedure OpenReceiptOrStorno(OperNum: double; OperPass: WideString; OptionReceiptType: OptionReceiptTypeEnum; OptionPrintType: OptionPrintTypeEnum);

    {Feeds one line of paper.}
    procedure PaperFeed();

    {Register the payment in the receipt with specified type of payment and exact amount received.}
    procedure PayExactSum(OptionPaymentType: OptionPaymentTypeEnum);

    {Registers the payment in the receipt with specified type of payment and amount received.}
    procedure Payment(OptionPaymentType: OptionPaymentTypeEnum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);

    {Prints QR 2D code}
    procedure Print2DBarcode(Scale: WideString; CodeData: WideString);

    {Prints an article report with or without zeroing ('Z' or 'X').}
    procedure PrintArticleReport(OptionZeroing: OptionZeroingEnum);

    {Prints barcode from type stated by CodeType and CodeLen and with data stated in CodeData field.}
    procedure PrintBarcode(OptionCodeType: OptionCodeTypeEnum; CodeLen: double; CodeData: WideString);

    {Print a brief FM report by initial and end date.}
    procedure PrintBriefFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);

    {Print a brief FM report by initial and end FM report number.}
    procedure PrintBriefFMReportByNum(StartNum: double; EndNum: double);

    {Depending on the parameter prints:  − daily fiscal report with zeroing and fiscal memory record, preceded by Electronic Journal report print ('Z'); − daily fiscal report without zeroing ('X');}
    procedure PrintDailyReport(OptionZeroing: OptionZeroingEnum);

    {Print a department report with or without zeroing ('Z' or 'X').}
    procedure PrintDepartmentReport(OptionZeroing: OptionZeroingEnum);

    {Prints a detailed FM report by initial and end date.}
    procedure PrintDetailedFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);

    {Print a detailed FM report by initial and end FM report number.}
    procedure PrintDetailedFMReportByNum(StartNum: double; EndNum: double);

    {Prints out a diagnostic receipt.}
    procedure PrintDiagnostics();

    {Print or store Electronic Journal report with all documents.}
    procedure PrintEJ();

    {Printing Electronic Journal Report from Report initial date to report Final date.}
    procedure PrintEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Printing Electronic Journal Report from receipt number to receipt number.}
    procedure PrintEJByReceiptNumFromZrep(ZrepNum: double; StartReceiptNum: double; EndReceiptNum: double);

    {Printing Electronic Journal Report from receipt number to receipt number.}
    procedure PrintEJByStornoNumFromZrep(ZrepNum: WideString; StartReceiptNum: WideString; EndReceiptNum: WideString);

    {Print or store Electronic Journal Report from by number of Z report blocks.}
    procedure PrintEJByZBlocks(StartZNum: double; EndZNum: double);

    {Prints the programmed graphical logo with the stated number.}
    procedure PrintLogo(Number: double);

    {Prints an operator's report for a specified operator (0 = all operators) with or without zeroing ('Z' or 'X'). When a 'Z' value is specified the report should include all operators.}
    procedure PrintOperatorReport(OptionZeroing: OptionZeroingEnum; Number: double);

    {Print whole special FM events report.}
    procedure PrintSpecialEventsFMreport();

    {Print a free text. The command can be executed only if receipt is opened (Fiscal receipt, Storno receipt or Non-fical receipt). In the beginning and in the end of line symbol '#' is printed.}
    procedure PrintText(Text: WideString);

    {Stores a block containing the number format into the fiscal memory. Print the current status on the printer.}
    procedure ProgDecimalPointPosition(Password: WideString; OptionDecimalPointPosition: OptionDecimalPointPositionEnum);

    {Set data for the state department number from the internal FD database.}
    procedure ProgDepartment(Number: double; Name: WideString; OptionVATClass: OptionVATClassEnum; Price: double; FlagsPrice: WideString);

    {Program the contents of a Display Greeting message.}
    procedure ProgDisplayGreetingMessage(DisplayGreetingText: WideString);

    {Programs the external display.}
    procedure ProgExtDisplay(Password: WideString);

    {Program the contents of a footer lines.}
    procedure ProgFooter(OptionFooterLine: OptionFooterLineEnum; FooterText: WideString);

    {Program the contents of a header lines.}
    procedure ProgHeader(OptionHeaderLine: OptionHeaderLineEnum; HeaderText: WideString);

    {Programs the operator's name and password.}
    procedure ProgOperator(Number: double; Name: WideString; Password: WideString);

    {Programs the number of POS, printing of logo, cash drawer opening, cutting permission, external display management mode, article report type, enable or disable currency in receipt and working operators counter.}
    procedure ProgParameters(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionReceiptSend: OptionReceiptSendEnum; OptionEnableCurrency: OptionEnableCurrencyEnum; OptionWorkOperatorCount: OptionWorkOperatorCountEnum);

    {Program the name of the payment types.}
    procedure ProgPayment(OptionPaymentNum: OptionPaymentNumEnum; Name: WideString; Rate: double);

    {Program the Barcode number for a certain article (item) from the internal database.}
    procedure ProgPLUbarcode(PLUNum: double; Barcode: WideString);

    {Programs the general data for a certain article in the internal FD database. The price may have variable length, while the name field is fixed.}
    procedure ProgPLUgeneral(PLUNum: WideString; PLUName: WideString; Price: double; FlagsPriceQty: WideString; BelongToDepNum: double; AvailableQuantity: double; Barcode: WideString);

    {Program the price for a certain article from the internal database.}
    procedure ProgPLUprice(PLUNum: double; Price: double; OptionPrice: OptionPriceEnum);

    {Programs available quantity and quantiy type for a certain article in the internal database.}
    procedure ProgPLUqty(PLUNum: double; AvailableQuantity: double; OptionQuantityType: OptionQuantityTypeEnum);

    {Stores a block containing the values of the VAT rates into the fiscal memory. Print the values on the printer.}
    procedure ProgVATrates(Password: WideString; VATrate1: double; VATrate2: double; VATrate3: double; VATrate4: double);

    { Reads raw bytes from FP.}
    function RawRead(Count: double; EndChar: WideString): TByteArray;
    { Writes raw bytes to FP }
    procedure RawWrite(Bytes: TByteArray);

    {Provides information about device's Bluetooth password.}
    function ReadBluetooth_Password(): Bluetooth_PasswordRes;
    {Providing information about if the device's Bluetooth module is enabled or disabled.}
    function ReadBluetooth_Status(): OptionBTstatusEnum;
    {Read the current status of the receipt.}
    function ReadCurrentRecInfo(): CurrentRecInfoRes;
    {Provides information about the total fiscal counters and last Z- report date and time.}
    function ReadDailyCounters(): DailyCountersRes;
    {Read the last operator's report number and date and time.}
    function ReadDailyCountersByOperator(OperNum: double): DailyCountersByOperatorRes;
    {Read the total number of customers, discounts, additions, corrections and accumulated amounts by specified operator.}
    function ReadDailyGeneralRegistersByOperator(OperNum: double): DailyGeneralRegistersByOperatorRes;
    {Provides information about the PO amounts by type of payment and the total number of operations.}
    function ReadDailyPO(): DailyPORes;
    {Provides information about the PO and the total number of operations by specified operator.}
    function ReadDailyPObyOperator(OperNum: double): DailyPObyOperatorRes;
    {Provides information about the RA amounts by type of payment and the total number of operations.}
    function ReadDailyRA(): DailyRARes;
    {Provides information about the RA and the total number of operations by specified operator.}
    function ReadDailyRAbyOperator(OperNum: double): DailyRAbyOperatorRes;
    {Provides information about the amounts received from sales and Storno change.}
    function ReadDailyReceivedSalesAmounts(): DailyReceivedSalesAmountsRes;
    {Read the amounts received from sales by type of payment and specified operator.}
    function ReadDailyReceivedSalesAmountsByOperator(OperNum: double): DailyReceivedSalesAmountsByOperatorRes;
    {Provides information about the amounts returned as Storno or sales change.}
    function ReadDailyReturned(): DailyReturnedRes;
    {Read information about the amounts returned}
    function ReadDailyReturnedAmounts(OperNum: double): DailyReturnedAmountsRes;
    {Provides information about the accumulated amount by VAT group.}
    function ReadDailySaleAndStornoAmountsByVAT(): DailySaleAndStornoAmountsByVATRes;
    {Provides information about the current date and time.}
    function ReadDateTime(): TDateTime;
    {Provides information about the current (the last value stored into the FM) decimal point format.}
    function ReadDecimalPoint(): OptionDecimalPointPositionEnum;
    {Provides information for the programmed data, the turnover from the stated department number}
    function ReadDepartment(DepNum: double): DepartmentRes;
    {Read info for enable/disable detailed receipts}
    function ReadDetailedReceiptInfoSending(): OptionActivationRSEnum;
    {Provide an information about modules supported by the device}
    function ReadDeviceModuleSupport(): DeviceModuleSupportRes;
    {Provide an information about modules supported by device's firmware}
    function ReadDeviceModuleSupportByFirmware(): DeviceModuleSupportByFirmwareRes;
    {Provides information about device's DHCP status}
    function ReadDHCP_Status(): OptionDhcpStatusEnum;
    {Provide information about the display greeting message.}
    function ReadDisplayGreetingMessage(): WideString;
    {Read Electronic Journal report with all documents.}
    procedure ReadEJ();

    {Read Electronic Journal Report from Report initial date to report Final date.}
    procedure ReadEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Read Electronic Journal Report from receipt number to receipt number.}
    procedure ReadEJByReceiptNumFromZrep(ZrepNum: double; StartReceiptNum: double; EndReceiptNum: double);

    {Read Electronic Journal Report from receipt number to receipt number.}
    procedure ReadEJByStornoNumFromZrep(ZrepNum: WideString; StartReceiptNum: WideString; EndReceiptNum: WideString);

    {Read Electronic Journal Report from by number of Z report blocks.}
    procedure ReadEJByZBlocks(StartZNum: double; EndZNum: double);

    {Select type of display}
    function ReadExternalDisplay(): OptionExternalTypeEnum;
    {Provides consequently information about every single block stored in the FM starting with Acknowledgements and ending with end message.}
    procedure ReadFMcontent();

    {Read the number of the remaining free records for Z-report in the Fiscal Memory.}
    function ReadFMfreeRecords(): WideString;
    {Provides the content of the footer lines.}
    function ReadFooter(OptionFooterLine: OptionFooterLineEnum): FooterRes;
    {Provides information about the number of customers (number of fiscal receipt issued), number of discounts, additions and corrections made and the accumulated amounts.}
    function ReadGeneralDailyRegisters(): GeneralDailyRegistersRes;
    {Provides information about device's GRPS APN.}
    function ReadGPRS_APN(): GPRS_APNRes;
    {Provides information about device's GPRS password.}
    function ReadGPRS_Password(): GPRS_PasswordRes;
    {Provides information about device's GPRS signal.}
    function ReadGPRS_Signal(): WideString;
    {Provides information about device's GPRS username.}
    function ReadGPRS_Username(): GPRS_UsernameRes;
    {Provides the content of the header lines.}
    function ReadHeader(OptionHeaderLine: OptionHeaderLineEnum): HeaderRes;
    {Provides key for server address.}
    function ReadKeyServerAddress(): KeyServerAddressRes;
    {Read date and number of last Z-report and last RAM reset event.}
    function ReadLastDailyReportInfo(): LastDailyReportInfoRes;
    {Provides information about the number of the last issued receipt.}
    function ReadLastReceiptNum(): LastReceiptNumRes;
    {Provides information about an operator's name and password.}
    function ReadOperatorNamePassword(Number: double): OperatorNamePasswordRes;
    {Provides information about the programmed number of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt.}
    function ReadParameters(): ParametersRes;
    {Provides information about all programmed payment types, currency name and exchange rate.}
    function ReadPayments(): PaymentsRes;
    {Provides information about the barcode of the specified article.}
    function ReadPLUbarcode(PLUNum: double): PLUbarcodeRes;
    {Provides information about the general registers of the specified.}
    function ReadPLUgeneral(PLUNum: double): PLUgeneralRes;
    {Provides information about the price and price type of the specified article.}
    function ReadPLUprice(PLUNum: double): PLUpriceRes;
    {Provides information about the quantity registers of the specified article.}
    function ReadPLUqty(PLUNum: double): PLUqtyRes;
    {Provides information about register server address.}
    function ReadRegisterServerAddress(): RegisterServerAddressRes;
    {Provides information about the owner's numbers and registration date time.}
    function ReadRegistrationInfo(): RegistrationInfoRes;
    {Provides information about the manufacturing number of the fiscal device, FM number and ECR Unique number.}
    function ReadSerialAndFiscalNums(): SerialAndFiscalNumsRes;
    {Provides information about server address.}
    function ReadServerAddress(): ServerAddressRes;
    {Read Service mode status}
    function ReadServiceMode(): OptionServiceModeEnum;
    {Read info for enable/disable short receipts}
    function ReadShortReceiptSending(): OptionActivationRSEnum;
    {Provides detailed 7-byte information about the current status of the fiscal device.}
    function ReadStatus(): StatusRes;
    {Provides information about device's IP address, subnet mask, gateway address, DNS address.}
    function ReadTCP_Addresses(OptionAddressType: OptionAddressTypeEnum): TCP_AddressesRes;
    {Read device TCP Auto Start status}
    function ReadTCP_AutoStartStatus(): OptionTCPAutoStartEnum;
    {Provides information about device's TCP password.}
    function ReadTCP_Password(): TCP_PasswordRes;
    {Read the used TCP module for communication - Lan or WiFi}
    function ReadTCP_UsedModule(): OptionUsedModuleEnum;
    {Provides information about the total fiscal accumulative sums from sales and Storno}
    function ReadTotalFiscalSums(): TotalFiscalSumsRes;
    {Provides information about the current VAT rates which are the last values stored into the FM.}
    function ReadVATrates(): VATratesRes;
    {Provides information about the device type, model name and version.}
    function ReadVersion(): VersionRes;
    {Read device's connected WiFi network name}
    function ReadWiFi_NetworkName(): WiFi_NetworkNameRes;
    {Read device's connected WiFi network password}
    function ReadWiFi_Password(): WiFi_PasswordRes;
    {Provides information about device's idle timeout. This timeout is seconds in which the connection will be closed when there is an inactivity. This information is available if the device has LAN or WiFi. Maximal value - 7200, minimal value 0. 0 is for never close the connection.}
    function Read_IdleTimeout(): double;
    {Registers cash received on account or paid out.}
    procedure ReceivedOnAccount_PaidOut(OperNum: double; OperPass: WideString; Amount: double);

    {After every change on Idle timeout, LAN/WiFi/GPRS usage, LAN/WiFi/TCP/GPRS password or TCP auto start networks settings this Save command needs to be execute.}
    procedure SaveNetworkSettings();

    {Scan and print all available WiFi networks}
    procedure ScanAndPrintWiFiNetworks();

    {Select type of display}
    procedure SelectExternalDisplay(OptionExternalDisplay: OptionExternalDisplayEnum);

    {Register the sell of department. Correction is forbidden!}
    procedure SellPLUfromDep(NamePLU: WideString; DepNum: double; Price: double; OptionGoodsType: OptionGoodsTypeEnum; Quantity: double; DiscAddP: double; DiscAddV: double);

    {Register the sell with specified quantity of article from the internal FD database. Correction is forbidden!}
    procedure SellPLUFromFD_DB(OptionSign: OptionSignEnum; PLUNum: double; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double);

    {Register the sell of article with specified name, price, quantity, VAT class and/or discount/addition on the transaction. Correction is forbidden!}
    procedure SellPLUwithSpecifiedVAT(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; OptionGoodsType: OptionGoodsTypeEnum; Quantity: double; DiscAddP: double; DiscAddV: double);

    {Stores in the memory the graphic file under stated number. Prints information about loaded in the printer graphic files.}
    procedure SetActiveLogo(LogoNumber: WideString);

    {Program device's Bluetooth password. To apply use - SaveNetworkSettings()}
    procedure SetBluetooth_Password(PassLength: double; Password: WideString);

    {Program device's Bluetooth module to be enabled or disabled. To apply use -SaveNetworkSettings()}
    procedure SetBluetooth_Status(OptionBTstatus: OptionBTstatusEnum);

    {Sets the date and time and prints out the current values.}
    procedure SetDateTime(DateTime: TDateTime);

    {Program device's network IP address, subnet mask, gateway address, DNS address. To apply use -SaveNetworkSettings()}
    procedure SetDeviceTCP_Addresses(OptionAddressType: OptionAddressTypeEnum; DeviceAddress: WideString);

    {Program device's TCP network DHCP enabled or disabled. To apply use -SaveNetworkSettings()}
    procedure SetDHCP_Enabled(OptionDHCPEnabled: OptionDHCPEnabledEnum);

    {Programs key of server address.}
    procedure SetFiscalServerAddress(ParamLength: double; Address: WideString);

    {Program device's GPRS APN. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_APN(GPRS_APN_Len: double; APN: WideString);

    {Program device's GPRS password. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_Password(PassLength: double; Password: WideString);

    {Program device's GPRS user name. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_Username(GPRS_Username_Len: double; Username: WideString);

    {Stores the VAT and ID numbers into the operative memory.}
    procedure SetIDandVATnum(Password: WideString; IDNum: WideString; VATNum: WideString);

    {Sets device's idle timeout setting. Set timeout for closing the connection if there is an inactivity. Maximal value - 7200, minimal value 0. 0 is for never close the connection. This option can be used only if the device has LAN or WiFi. To apply use - SaveNetworkSettings()}
    procedure SetIdle_Timeout(IdleTimeout: double);

    {Programs register server address.}
    procedure SetRegisterServerAddress(ParamLength: double; Address: WideString);

    {Provides information about server address.}
    procedure SetServerAddress(ParamLength: double; Address: WideString);

    {Program device's TCP password. To apply use - SaveNetworkSettings()}
    procedure SetTCPpassword(PassLength: double; Password: WideString);

    {Sets the used TCP module for communication - Lan or WiFi. To apply use -SaveNetworkSettings()}
    procedure SetTCP_ActiveModule(OptionUsedModule: OptionUsedModuleEnum);

    {Set device's TCP autostart . To apply use -SaveNetworkSettings()}
    procedure SetTCP_AutoStart(OptionTCPAutoStart: OptionTCPAutoStartEnum);

    {Program device's WiFi network name where it will connect. To apply use -SaveNetworkSettings()}
    procedure SetWiFi_NetworkName(WiFiNameLength: double; WiFiNetworkName: WideString);

    {Program device's WiFi network password where it will connect. To apply use -SaveNetworkSettings()}
    procedure SetWiFi_Password(PassLength: double; Password: WideString);

    {Start Bluetooth test on the device and print out the result}
    procedure StartTest_Bluetooth();

    {Start GPRS test on the device and print out the result}
    procedure StartTest_GPRS();

    {Start LAN test on the device and print out the result}
    procedure StartTest_Lan();

    {Start WiFi test on the device and print out the result}
    procedure StartTest_WiFi();

    {Calculate the subtotal amount with printing and display visualization options. Provide information about values of the calculated amounts. If a percent or value discount/addition has been specified the subtotal and the discount/addition value will be printed regardless the parameter for printing.}
    function Subtotal(OptionPrinting: OptionPrintingEnum; OptionDisplay: OptionDisplayEnum; DiscAddV: double; DiscAddP: double): double;
    {Removes all paired devices. To apply use -SaveNetworkSettings()}
    procedure UnpairAllDevices();

    { Sends client definitions to the server for compatibility. }
    procedure ApplyClientLibraryDefinitions();
  end;

implementation
procedure OptionServiceMode_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionServiceModeEnum(nam);
  self.Value := val;
end;

procedure OptionActivationRS_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionActivationRSEnum(nam);
  self.Value := val;
end;

procedure OptionReceiptType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionReceiptTypeEnum(nam);
  self.Value := val;
end;

procedure OptionChangeType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionChangeTypeEnum(nam);
  self.Value := val;
end;

procedure OptionDecimalPointPosition_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionDecimalPointPositionEnum(nam);
  self.Value := val;
end;

procedure OptionVATClass_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionVATClassEnum(nam);
  self.Value := val;
end;

procedure OptionFooterLine_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionFooterLineEnum(nam);
  self.Value := val;
end;

procedure OptionHeaderLine_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionHeaderLineEnum(nam);
  self.Value := val;
end;

procedure OptionPrintLogo_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionPrintLogoEnum(nam);
  self.Value := val;
end;

procedure OptionAutoOpenDrawer_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionAutoOpenDrawerEnum(nam);
  self.Value := val;
end;

procedure OptionAutoCut_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionAutoCutEnum(nam);
  self.Value := val;
end;

procedure OptionExternalDispManagement_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionExternalDispManagementEnum(nam);
  self.Value := val;
end;

procedure OptionReceiptSend_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionReceiptSendEnum(nam);
  self.Value := val;
end;

procedure OptionEnableCurrency_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionEnableCurrencyEnum(nam);
  self.Value := val;
end;

procedure OptionWorkOperatorCount_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionWorkOperatorCountEnum(nam);
  self.Value := val;
end;

procedure OptionPrice_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionPriceEnum(nam);
  self.Value := val;
end;

procedure OptionQuantityType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionQuantityTypeEnum(nam);
  self.Value := val;
end;

procedure OptionBTstatus_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionBTstatusEnum(nam);
  self.Value := val;
end;

procedure OptionIsReceiptOpened_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionIsReceiptOpenedEnum(nam);
  self.Value := val;
end;

procedure OptionInitiatedPayment_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionInitiatedPaymentEnum(nam);
  self.Value := val;
end;

procedure OptionFinalizedPayment_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionFinalizedPaymentEnum(nam);
  self.Value := val;
end;

procedure OptionPowerDownInReceipt_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionPowerDownInReceiptEnum(nam);
  self.Value := val;
end;

procedure OptionLAN_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionLANEnum(nam);
  self.Value := val;
end;

procedure OptionWiFi_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionWiFiEnum(nam);
  self.Value := val;
end;

procedure OptionGPRS_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionGPRSEnum(nam);
  self.Value := val;
end;

procedure OptionBT_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionBTEnum(nam);
  self.Value := val;
end;

procedure OptionDhcpStatus_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionDhcpStatusEnum(nam);
  self.Value := val;
end;

procedure OptionExternalType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionExternalTypeEnum(nam);
  self.Value := val;
end;

procedure OptionAddressType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionAddressTypeEnum(nam);
  self.Value := val;
end;

procedure OptionTCPAutoStart_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionTCPAutoStartEnum(nam);
  self.Value := val;
end;

procedure OptionUsedModule_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionUsedModuleEnum(nam);
  self.Value := val;
end;

procedure OptionDeviceType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionDeviceTypeEnum(nam);
  self.Value := val;
end;


procedure FP.CashDrawerOpen();
begin
  Execute('CashDrawerOpen',[]);
end;

procedure FP.CashPayCloseReceipt();
begin
  Execute('CashPayCloseReceipt',[]);
end;

procedure FP.ClearDisplay();
begin
  Execute('ClearDisplay',[]);
end;

procedure FP.CloseNonFiscReceipt();
begin
  Execute('CloseNonFiscReceipt',[]);
end;

procedure FP.CloseReceipt();
begin
  Execute('CloseReceipt',[]);
end;

procedure FP.ConfirmIDNumandVATnum(Password: WideString);
begin
  Execute('ConfirmIDNumandVATnum',['Password',Password]);
end;

procedure FP.CutPaper();
begin
  Execute('CutPaper',[]);
end;

function FP.DirectCommand(Input: WideString): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('DirectCommand',['Input',Input])) as DummyCoreObject).Value;
end;

procedure FP.DisplayDateTime();
begin
  Execute('DisplayDateTime',[]);
end;

procedure FP.DisplayTextLine1(Text: WideString);
begin
  Execute('DisplayTextLine1',['Text',Text]);
end;

procedure FP.DisplayTextLine2(Text: WideString);
begin
  Execute('DisplayTextLine2',['Text',Text]);
end;

procedure FP.DisplayTextLines1and2(Text: WideString);
begin
  Execute('DisplayTextLines1and2',['Text',Text]);
end;

procedure FP.EnterServiceMode(OptionServiceMode: OptionServiceModeEnum; ServicePassword: WideString);
begin
  Execute('EnterServiceMode',['OptionServiceMode',OptionServiceMode, 'ServicePassword',ServicePassword]);
end;

procedure FP.ManageDetailedReceiptInfoSending(OptionActivationRS: OptionActivationRSEnum);
begin
  Execute('ManageDetailedReceiptInfoSending',['OptionActivationRS',OptionActivationRS]);
end;

procedure FP.ManageShortReceiptSending(OptionActivationRS: OptionActivationRSEnum);
begin
  Execute('ManageShortReceiptSending',['OptionActivationRS',OptionActivationRS]);
end;

procedure FP.OpenNonFiscalReceipt(OperNum: double; OperPass: WideString);
begin
  Execute('OpenNonFiscalReceipt',['OperNum',OperNum, 'OperPass',OperPass]);
end;

procedure FP.OpenReceiptOrStorno(OperNum: double; OperPass: WideString; OptionReceiptType: OptionReceiptTypeEnum; OptionPrintType: OptionPrintTypeEnum);
begin
  Execute('OpenReceiptOrStorno',['OperNum',OperNum, 'OperPass',OperPass, 'OptionReceiptType',OptionReceiptType, 'OptionPrintType',OptionPrintType]);
end;

procedure FP.PaperFeed();
begin
  Execute('PaperFeed',[]);
end;

procedure FP.PayExactSum(OptionPaymentType: OptionPaymentTypeEnum);
begin
  Execute('PayExactSum',['OptionPaymentType',OptionPaymentType]);
end;

procedure FP.Payment(OptionPaymentType: OptionPaymentTypeEnum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);
begin
  Execute('Payment',['OptionPaymentType',OptionPaymentType, 'OptionChange',OptionChange, 'Amount',Amount, 'OptionChangeType',OptionChangeType]);
end;

procedure FP.Print2DBarcode(Scale: WideString; CodeData: WideString);
begin
  Execute('Print2DBarcode',['Scale',Scale, 'CodeData',CodeData]);
end;

procedure FP.PrintArticleReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintArticleReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintBarcode(OptionCodeType: OptionCodeTypeEnum; CodeLen: double; CodeData: WideString);
begin
  Execute('PrintBarcode',['OptionCodeType',OptionCodeType, 'CodeLen',CodeLen, 'CodeData',CodeData]);
end;

procedure FP.PrintBriefFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);
begin
  Execute('PrintBriefFMReportByDate',['StartDate',StartDate, 'EndDate',EndDate]);
end;

procedure FP.PrintBriefFMReportByNum(StartNum: double; EndNum: double);
begin
  Execute('PrintBriefFMReportByNum',['StartNum',StartNum, 'EndNum',EndNum]);
end;

procedure FP.PrintDailyReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintDailyReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintDepartmentReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintDepartmentReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintDetailedFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);
begin
  Execute('PrintDetailedFMReportByDate',['StartDate',StartDate, 'EndDate',EndDate]);
end;

procedure FP.PrintDetailedFMReportByNum(StartNum: double; EndNum: double);
begin
  Execute('PrintDetailedFMReportByNum',['StartNum',StartNum, 'EndNum',EndNum]);
end;

procedure FP.PrintDiagnostics();
begin
  Execute('PrintDiagnostics',[]);
end;

procedure FP.PrintEJ();
begin
  Execute('PrintEJ',[]);
end;

procedure FP.PrintEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('PrintEJByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.PrintEJByReceiptNumFromZrep(ZrepNum: double; StartReceiptNum: double; EndReceiptNum: double);
begin
  Execute('PrintEJByReceiptNumFromZrep',['ZrepNum',ZrepNum, 'StartReceiptNum',StartReceiptNum, 'EndReceiptNum',EndReceiptNum]);
end;

procedure FP.PrintEJByStornoNumFromZrep(ZrepNum: WideString; StartReceiptNum: WideString; EndReceiptNum: WideString);
begin
  Execute('PrintEJByStornoNumFromZrep',['ZrepNum',ZrepNum, 'StartReceiptNum',StartReceiptNum, 'EndReceiptNum',EndReceiptNum]);
end;

procedure FP.PrintEJByZBlocks(StartZNum: double; EndZNum: double);
begin
  Execute('PrintEJByZBlocks',['StartZNum',StartZNum, 'EndZNum',EndZNum]);
end;

procedure FP.PrintLogo(Number: double);
begin
  Execute('PrintLogo',['Number',Number]);
end;

procedure FP.PrintOperatorReport(OptionZeroing: OptionZeroingEnum; Number: double);
begin
  Execute('PrintOperatorReport',['OptionZeroing',OptionZeroing, 'Number',Number]);
end;

procedure FP.PrintSpecialEventsFMreport();
begin
  Execute('PrintSpecialEventsFMreport',[]);
end;

procedure FP.PrintText(Text: WideString);
begin
  Execute('PrintText',['Text',Text]);
end;

procedure FP.ProgDecimalPointPosition(Password: WideString; OptionDecimalPointPosition: OptionDecimalPointPositionEnum);
begin
  Execute('ProgDecimalPointPosition',['Password',Password, 'OptionDecimalPointPosition',OptionDecimalPointPosition]);
end;

procedure FP.ProgDepartment(Number: double; Name: WideString; OptionVATClass: OptionVATClassEnum; Price: double; FlagsPrice: WideString);
begin
  Execute('ProgDepartment',['Number',Number, 'Name',Name, 'OptionVATClass',OptionVATClass, 'Price',Price, 'FlagsPrice',FlagsPrice]);
end;

procedure FP.ProgDisplayGreetingMessage(DisplayGreetingText: WideString);
begin
  Execute('ProgDisplayGreetingMessage',['DisplayGreetingText',DisplayGreetingText]);
end;

procedure FP.ProgExtDisplay(Password: WideString);
begin
  Execute('ProgExtDisplay',['Password',Password]);
end;

procedure FP.ProgFooter(OptionFooterLine: OptionFooterLineEnum; FooterText: WideString);
begin
  Execute('ProgFooter',['OptionFooterLine',OptionFooterLine, 'FooterText',FooterText]);
end;

procedure FP.ProgHeader(OptionHeaderLine: OptionHeaderLineEnum; HeaderText: WideString);
begin
  Execute('ProgHeader',['OptionHeaderLine',OptionHeaderLine, 'HeaderText',HeaderText]);
end;

procedure FP.ProgOperator(Number: double; Name: WideString; Password: WideString);
begin
  Execute('ProgOperator',['Number',Number, 'Name',Name, 'Password',Password]);
end;

procedure FP.ProgParameters(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionReceiptSend: OptionReceiptSendEnum; OptionEnableCurrency: OptionEnableCurrencyEnum; OptionWorkOperatorCount: OptionWorkOperatorCountEnum);
begin
  Execute('ProgParameters',['POSNum',POSNum, 'OptionPrintLogo',OptionPrintLogo, 'OptionAutoOpenDrawer',OptionAutoOpenDrawer, 'OptionAutoCut',OptionAutoCut, 'OptionExternalDispManagement',OptionExternalDispManagement, 'OptionReceiptSend',OptionReceiptSend, 'OptionEnableCurrency',OptionEnableCurrency, 'OptionWorkOperatorCount',OptionWorkOperatorCount]);
end;

procedure FP.ProgPayment(OptionPaymentNum: OptionPaymentNumEnum; Name: WideString; Rate: double);
begin
  Execute('ProgPayment',['OptionPaymentNum',OptionPaymentNum, 'Name',Name, 'Rate',Rate]);
end;

procedure FP.ProgPLUbarcode(PLUNum: double; Barcode: WideString);
begin
  Execute('ProgPLUbarcode',['PLUNum',PLUNum, 'Barcode',Barcode]);
end;

procedure FP.ProgPLUgeneral(PLUNum: WideString; PLUName: WideString; Price: double; FlagsPriceQty: WideString; BelongToDepNum: double; AvailableQuantity: double; Barcode: WideString);
begin
  Execute('ProgPLUgeneral',['PLUNum',PLUNum, 'PLUName',PLUName, 'Price',Price, 'FlagsPriceQty',FlagsPriceQty, 'BelongToDepNum',BelongToDepNum, 'AvailableQuantity',AvailableQuantity, 'Barcode',Barcode]);
end;

procedure FP.ProgPLUprice(PLUNum: double; Price: double; OptionPrice: OptionPriceEnum);
begin
  Execute('ProgPLUprice',['PLUNum',PLUNum, 'Price',Price, 'OptionPrice',OptionPrice]);
end;

procedure FP.ProgPLUqty(PLUNum: double; AvailableQuantity: double; OptionQuantityType: OptionQuantityTypeEnum);
begin
  Execute('ProgPLUqty',['PLUNum',PLUNum, 'AvailableQuantity',AvailableQuantity, 'OptionQuantityType',OptionQuantityType]);
end;

procedure FP.ProgVATrates(Password: WideString; VATrate1: double; VATrate2: double; VATrate3: double; VATrate4: double);
begin
  Execute('ProgVATrates',['Password',Password, 'VATrate1',VATrate1, 'VATrate2',VATrate2, 'VATrate3',VATrate3, 'VATrate4',VATrate4]);
end;

function FP.RawRead(Count: double; EndChar: WideString): TByteArray;
begin
  Result := (createRes(DummyCoreObject, Execute('RawRead',['Count',Count, 'EndChar',EndChar])) as DummyCoreObject).Value;
end;

procedure FP.RawWrite(Bytes: TByteArray);
begin
  Execute('RawWrite',['Bytes',Bytes]);
end;

function FP.ReadBluetooth_Password(): Bluetooth_PasswordRes;
begin
  Result := createRes(Bluetooth_PasswordRes, Execute('ReadBluetooth_Password',[])) as Bluetooth_PasswordRes;
end;

function FP.ReadBluetooth_Status(): OptionBTstatusEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadBluetooth_Status',[])) as DummyCoreObject).Value;
end;

function FP.ReadCurrentRecInfo(): CurrentRecInfoRes;
begin
  Result := createRes(CurrentRecInfoRes, Execute('ReadCurrentRecInfo',[])) as CurrentRecInfoRes;
end;

function FP.ReadDailyCounters(): DailyCountersRes;
begin
  Result := createRes(DailyCountersRes, Execute('ReadDailyCounters',[])) as DailyCountersRes;
end;

function FP.ReadDailyCountersByOperator(OperNum: double): DailyCountersByOperatorRes;
begin
  Result := createRes(DailyCountersByOperatorRes, Execute('ReadDailyCountersByOperator',['OperNum',OperNum])) as DailyCountersByOperatorRes;
end;

function FP.ReadDailyGeneralRegistersByOperator(OperNum: double): DailyGeneralRegistersByOperatorRes;
begin
  Result := createRes(DailyGeneralRegistersByOperatorRes, Execute('ReadDailyGeneralRegistersByOperator',['OperNum',OperNum])) as DailyGeneralRegistersByOperatorRes;
end;

function FP.ReadDailyPO(): DailyPORes;
begin
  Result := createRes(DailyPORes, Execute('ReadDailyPO',[])) as DailyPORes;
end;

function FP.ReadDailyPObyOperator(OperNum: double): DailyPObyOperatorRes;
begin
  Result := createRes(DailyPObyOperatorRes, Execute('ReadDailyPObyOperator',['OperNum',OperNum])) as DailyPObyOperatorRes;
end;

function FP.ReadDailyRA(): DailyRARes;
begin
  Result := createRes(DailyRARes, Execute('ReadDailyRA',[])) as DailyRARes;
end;

function FP.ReadDailyRAbyOperator(OperNum: double): DailyRAbyOperatorRes;
begin
  Result := createRes(DailyRAbyOperatorRes, Execute('ReadDailyRAbyOperator',['OperNum',OperNum])) as DailyRAbyOperatorRes;
end;

function FP.ReadDailyReceivedSalesAmounts(): DailyReceivedSalesAmountsRes;
begin
  Result := createRes(DailyReceivedSalesAmountsRes, Execute('ReadDailyReceivedSalesAmounts',[])) as DailyReceivedSalesAmountsRes;
end;

function FP.ReadDailyReceivedSalesAmountsByOperator(OperNum: double): DailyReceivedSalesAmountsByOperatorRes;
begin
  Result := createRes(DailyReceivedSalesAmountsByOperatorRes, Execute('ReadDailyReceivedSalesAmountsByOperator',['OperNum',OperNum])) as DailyReceivedSalesAmountsByOperatorRes;
end;

function FP.ReadDailyReturned(): DailyReturnedRes;
begin
  Result := createRes(DailyReturnedRes, Execute('ReadDailyReturned',[])) as DailyReturnedRes;
end;

function FP.ReadDailyReturnedAmounts(OperNum: double): DailyReturnedAmountsRes;
begin
  Result := createRes(DailyReturnedAmountsRes, Execute('ReadDailyReturnedAmounts',['OperNum',OperNum])) as DailyReturnedAmountsRes;
end;

function FP.ReadDailySaleAndStornoAmountsByVAT(): DailySaleAndStornoAmountsByVATRes;
begin
  Result := createRes(DailySaleAndStornoAmountsByVATRes, Execute('ReadDailySaleAndStornoAmountsByVAT',[])) as DailySaleAndStornoAmountsByVATRes;
end;

function FP.ReadDateTime(): TDateTime;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDateTime',[])) as DummyCoreObject).Value;
end;

function FP.ReadDecimalPoint(): OptionDecimalPointPositionEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDecimalPoint',[])) as DummyCoreObject).Value;
end;

function FP.ReadDepartment(DepNum: double): DepartmentRes;
begin
  Result := createRes(DepartmentRes, Execute('ReadDepartment',['DepNum',DepNum])) as DepartmentRes;
end;

function FP.ReadDetailedReceiptInfoSending(): OptionActivationRSEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDetailedReceiptInfoSending',[])) as DummyCoreObject).Value;
end;

function FP.ReadDeviceModuleSupport(): DeviceModuleSupportRes;
begin
  Result := createRes(DeviceModuleSupportRes, Execute('ReadDeviceModuleSupport',[])) as DeviceModuleSupportRes;
end;

function FP.ReadDeviceModuleSupportByFirmware(): DeviceModuleSupportByFirmwareRes;
begin
  Result := createRes(DeviceModuleSupportByFirmwareRes, Execute('ReadDeviceModuleSupportByFirmware',[])) as DeviceModuleSupportByFirmwareRes;
end;

function FP.ReadDHCP_Status(): OptionDhcpStatusEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDHCP_Status',[])) as DummyCoreObject).Value;
end;

function FP.ReadDisplayGreetingMessage(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDisplayGreetingMessage',[])) as DummyCoreObject).Value;
end;

procedure FP.ReadEJ();
begin
  Execute('ReadEJ',[]);
end;

procedure FP.ReadEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('ReadEJByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.ReadEJByReceiptNumFromZrep(ZrepNum: double; StartReceiptNum: double; EndReceiptNum: double);
begin
  Execute('ReadEJByReceiptNumFromZrep',['ZrepNum',ZrepNum, 'StartReceiptNum',StartReceiptNum, 'EndReceiptNum',EndReceiptNum]);
end;

procedure FP.ReadEJByStornoNumFromZrep(ZrepNum: WideString; StartReceiptNum: WideString; EndReceiptNum: WideString);
begin
  Execute('ReadEJByStornoNumFromZrep',['ZrepNum',ZrepNum, 'StartReceiptNum',StartReceiptNum, 'EndReceiptNum',EndReceiptNum]);
end;

procedure FP.ReadEJByZBlocks(StartZNum: double; EndZNum: double);
begin
  Execute('ReadEJByZBlocks',['StartZNum',StartZNum, 'EndZNum',EndZNum]);
end;

function FP.ReadExternalDisplay(): OptionExternalTypeEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadExternalDisplay',[])) as DummyCoreObject).Value;
end;

procedure FP.ReadFMcontent();
begin
  Execute('ReadFMcontent',[]);
end;

function FP.ReadFMfreeRecords(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadFMfreeRecords',[])) as DummyCoreObject).Value;
end;

function FP.ReadFooter(OptionFooterLine: OptionFooterLineEnum): FooterRes;
begin
  Result := createRes(FooterRes, Execute('ReadFooter',['OptionFooterLine',OptionFooterLine])) as FooterRes;
end;

function FP.ReadGeneralDailyRegisters(): GeneralDailyRegistersRes;
begin
  Result := createRes(GeneralDailyRegistersRes, Execute('ReadGeneralDailyRegisters',[])) as GeneralDailyRegistersRes;
end;

function FP.ReadGPRS_APN(): GPRS_APNRes;
begin
  Result := createRes(GPRS_APNRes, Execute('ReadGPRS_APN',[])) as GPRS_APNRes;
end;

function FP.ReadGPRS_Password(): GPRS_PasswordRes;
begin
  Result := createRes(GPRS_PasswordRes, Execute('ReadGPRS_Password',[])) as GPRS_PasswordRes;
end;

function FP.ReadGPRS_Signal(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadGPRS_Signal',[])) as DummyCoreObject).Value;
end;

function FP.ReadGPRS_Username(): GPRS_UsernameRes;
begin
  Result := createRes(GPRS_UsernameRes, Execute('ReadGPRS_Username',[])) as GPRS_UsernameRes;
end;

function FP.ReadHeader(OptionHeaderLine: OptionHeaderLineEnum): HeaderRes;
begin
  Result := createRes(HeaderRes, Execute('ReadHeader',['OptionHeaderLine',OptionHeaderLine])) as HeaderRes;
end;

function FP.ReadKeyServerAddress(): KeyServerAddressRes;
begin
  Result := createRes(KeyServerAddressRes, Execute('ReadKeyServerAddress',[])) as KeyServerAddressRes;
end;

function FP.ReadLastDailyReportInfo(): LastDailyReportInfoRes;
begin
  Result := createRes(LastDailyReportInfoRes, Execute('ReadLastDailyReportInfo',[])) as LastDailyReportInfoRes;
end;

function FP.ReadLastReceiptNum(): LastReceiptNumRes;
begin
  Result := createRes(LastReceiptNumRes, Execute('ReadLastReceiptNum',[])) as LastReceiptNumRes;
end;

function FP.ReadOperatorNamePassword(Number: double): OperatorNamePasswordRes;
begin
  Result := createRes(OperatorNamePasswordRes, Execute('ReadOperatorNamePassword',['Number',Number])) as OperatorNamePasswordRes;
end;

function FP.ReadParameters(): ParametersRes;
begin
  Result := createRes(ParametersRes, Execute('ReadParameters',[])) as ParametersRes;
end;

function FP.ReadPayments(): PaymentsRes;
begin
  Result := createRes(PaymentsRes, Execute('ReadPayments',[])) as PaymentsRes;
end;

function FP.ReadPLUbarcode(PLUNum: double): PLUbarcodeRes;
begin
  Result := createRes(PLUbarcodeRes, Execute('ReadPLUbarcode',['PLUNum',PLUNum])) as PLUbarcodeRes;
end;

function FP.ReadPLUgeneral(PLUNum: double): PLUgeneralRes;
begin
  Result := createRes(PLUgeneralRes, Execute('ReadPLUgeneral',['PLUNum',PLUNum])) as PLUgeneralRes;
end;

function FP.ReadPLUprice(PLUNum: double): PLUpriceRes;
begin
  Result := createRes(PLUpriceRes, Execute('ReadPLUprice',['PLUNum',PLUNum])) as PLUpriceRes;
end;

function FP.ReadPLUqty(PLUNum: double): PLUqtyRes;
begin
  Result := createRes(PLUqtyRes, Execute('ReadPLUqty',['PLUNum',PLUNum])) as PLUqtyRes;
end;

function FP.ReadRegisterServerAddress(): RegisterServerAddressRes;
begin
  Result := createRes(RegisterServerAddressRes, Execute('ReadRegisterServerAddress',[])) as RegisterServerAddressRes;
end;

function FP.ReadRegistrationInfo(): RegistrationInfoRes;
begin
  Result := createRes(RegistrationInfoRes, Execute('ReadRegistrationInfo',[])) as RegistrationInfoRes;
end;

function FP.ReadSerialAndFiscalNums(): SerialAndFiscalNumsRes;
begin
  Result := createRes(SerialAndFiscalNumsRes, Execute('ReadSerialAndFiscalNums',[])) as SerialAndFiscalNumsRes;
end;

function FP.ReadServerAddress(): ServerAddressRes;
begin
  Result := createRes(ServerAddressRes, Execute('ReadServerAddress',[])) as ServerAddressRes;
end;

function FP.ReadServiceMode(): OptionServiceModeEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadServiceMode',[])) as DummyCoreObject).Value;
end;

function FP.ReadShortReceiptSending(): OptionActivationRSEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadShortReceiptSending',[])) as DummyCoreObject).Value;
end;

function FP.ReadStatus(): StatusRes;
begin
  Result := createRes(StatusRes, Execute('ReadStatus',[])) as StatusRes;
end;

function FP.ReadTCP_Addresses(OptionAddressType: OptionAddressTypeEnum): TCP_AddressesRes;
begin
  Result := createRes(TCP_AddressesRes, Execute('ReadTCP_Addresses',['OptionAddressType',OptionAddressType])) as TCP_AddressesRes;
end;

function FP.ReadTCP_AutoStartStatus(): OptionTCPAutoStartEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadTCP_AutoStartStatus',[])) as DummyCoreObject).Value;
end;

function FP.ReadTCP_Password(): TCP_PasswordRes;
begin
  Result := createRes(TCP_PasswordRes, Execute('ReadTCP_Password',[])) as TCP_PasswordRes;
end;

function FP.ReadTCP_UsedModule(): OptionUsedModuleEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadTCP_UsedModule',[])) as DummyCoreObject).Value;
end;

function FP.ReadTotalFiscalSums(): TotalFiscalSumsRes;
begin
  Result := createRes(TotalFiscalSumsRes, Execute('ReadTotalFiscalSums',[])) as TotalFiscalSumsRes;
end;

function FP.ReadVATrates(): VATratesRes;
begin
  Result := createRes(VATratesRes, Execute('ReadVATrates',[])) as VATratesRes;
end;

function FP.ReadVersion(): VersionRes;
begin
  Result := createRes(VersionRes, Execute('ReadVersion',[])) as VersionRes;
end;

function FP.ReadWiFi_NetworkName(): WiFi_NetworkNameRes;
begin
  Result := createRes(WiFi_NetworkNameRes, Execute('ReadWiFi_NetworkName',[])) as WiFi_NetworkNameRes;
end;

function FP.ReadWiFi_Password(): WiFi_PasswordRes;
begin
  Result := createRes(WiFi_PasswordRes, Execute('ReadWiFi_Password',[])) as WiFi_PasswordRes;
end;

function FP.Read_IdleTimeout(): double;
begin
  Result := (createRes(DummyCoreObject, Execute('Read_IdleTimeout',[])) as DummyCoreObject).Value;
end;

procedure FP.ReceivedOnAccount_PaidOut(OperNum: double; OperPass: WideString; Amount: double);
begin
  Execute('ReceivedOnAccount_PaidOut',['OperNum',OperNum, 'OperPass',OperPass, 'Amount',Amount]);
end;

procedure FP.SaveNetworkSettings();
begin
  Execute('SaveNetworkSettings',[]);
end;

procedure FP.ScanAndPrintWiFiNetworks();
begin
  Execute('ScanAndPrintWiFiNetworks',[]);
end;

procedure FP.SelectExternalDisplay(OptionExternalDisplay: OptionExternalDisplayEnum);
begin
  Execute('SelectExternalDisplay',['OptionExternalDisplay',OptionExternalDisplay]);
end;

procedure FP.SellPLUfromDep(NamePLU: WideString; DepNum: double; Price: double; OptionGoodsType: OptionGoodsTypeEnum; Quantity: double; DiscAddP: double; DiscAddV: double);
begin
  Execute('SellPLUfromDep',['NamePLU',NamePLU, 'DepNum',DepNum, 'Price',Price, 'OptionGoodsType',OptionGoodsType, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV]);
end;

procedure FP.SellPLUFromFD_DB(OptionSign: OptionSignEnum; PLUNum: double; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double);
begin
  Execute('SellPLUFromFD_DB',['OptionSign',OptionSign, 'PLUNum',PLUNum, 'Price',Price, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV]);
end;

procedure FP.SellPLUwithSpecifiedVAT(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; OptionGoodsType: OptionGoodsTypeEnum; Quantity: double; DiscAddP: double; DiscAddV: double);
begin
  Execute('SellPLUwithSpecifiedVAT',['NamePLU',NamePLU, 'OptionVATClass',OptionVATClass, 'Price',Price, 'OptionGoodsType',OptionGoodsType, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV]);
end;

procedure FP.SetActiveLogo(LogoNumber: WideString);
begin
  Execute('SetActiveLogo',['LogoNumber',LogoNumber]);
end;

procedure FP.SetBluetooth_Password(PassLength: double; Password: WideString);
begin
  Execute('SetBluetooth_Password',['PassLength',PassLength, 'Password',Password]);
end;

procedure FP.SetBluetooth_Status(OptionBTstatus: OptionBTstatusEnum);
begin
  Execute('SetBluetooth_Status',['OptionBTstatus',OptionBTstatus]);
end;

procedure FP.SetDateTime(DateTime: TDateTime);
begin
  Execute('SetDateTime',['DateTime',DateTime]);
end;

procedure FP.SetDeviceTCP_Addresses(OptionAddressType: OptionAddressTypeEnum; DeviceAddress: WideString);
begin
  Execute('SetDeviceTCP_Addresses',['OptionAddressType',OptionAddressType, 'DeviceAddress',DeviceAddress]);
end;

procedure FP.SetDHCP_Enabled(OptionDHCPEnabled: OptionDHCPEnabledEnum);
begin
  Execute('SetDHCP_Enabled',['OptionDHCPEnabled',OptionDHCPEnabled]);
end;

procedure FP.SetFiscalServerAddress(ParamLength: double; Address: WideString);
begin
  Execute('SetFiscalServerAddress',['ParamLength',ParamLength, 'Address',Address]);
end;

procedure FP.SetGPRS_APN(GPRS_APN_Len: double; APN: WideString);
begin
  Execute('SetGPRS_APN',['GPRS_APN_Len',GPRS_APN_Len, 'APN',APN]);
end;

procedure FP.SetGPRS_Password(PassLength: double; Password: WideString);
begin
  Execute('SetGPRS_Password',['PassLength',PassLength, 'Password',Password]);
end;

procedure FP.SetGPRS_Username(GPRS_Username_Len: double; Username: WideString);
begin
  Execute('SetGPRS_Username',['GPRS_Username_Len',GPRS_Username_Len, 'Username',Username]);
end;

procedure FP.SetIDandVATnum(Password: WideString; IDNum: WideString; VATNum: WideString);
begin
  Execute('SetIDandVATnum',['Password',Password, 'IDNum',IDNum, 'VATNum',VATNum]);
end;

procedure FP.SetIdle_Timeout(IdleTimeout: double);
begin
  Execute('SetIdle_Timeout',['IdleTimeout',IdleTimeout]);
end;

procedure FP.SetRegisterServerAddress(ParamLength: double; Address: WideString);
begin
  Execute('SetRegisterServerAddress',['ParamLength',ParamLength, 'Address',Address]);
end;

procedure FP.SetServerAddress(ParamLength: double; Address: WideString);
begin
  Execute('SetServerAddress',['ParamLength',ParamLength, 'Address',Address]);
end;

procedure FP.SetTCPpassword(PassLength: double; Password: WideString);
begin
  Execute('SetTCPpassword',['PassLength',PassLength, 'Password',Password]);
end;

procedure FP.SetTCP_ActiveModule(OptionUsedModule: OptionUsedModuleEnum);
begin
  Execute('SetTCP_ActiveModule',['OptionUsedModule',OptionUsedModule]);
end;

procedure FP.SetTCP_AutoStart(OptionTCPAutoStart: OptionTCPAutoStartEnum);
begin
  Execute('SetTCP_AutoStart',['OptionTCPAutoStart',OptionTCPAutoStart]);
end;

procedure FP.SetWiFi_NetworkName(WiFiNameLength: double; WiFiNetworkName: WideString);
begin
  Execute('SetWiFi_NetworkName',['WiFiNameLength',WiFiNameLength, 'WiFiNetworkName',WiFiNetworkName]);
end;

procedure FP.SetWiFi_Password(PassLength: double; Password: WideString);
begin
  Execute('SetWiFi_Password',['PassLength',PassLength, 'Password',Password]);
end;

procedure FP.StartTest_Bluetooth();
begin
  Execute('StartTest_Bluetooth',[]);
end;

procedure FP.StartTest_GPRS();
begin
  Execute('StartTest_GPRS',[]);
end;

procedure FP.StartTest_Lan();
begin
  Execute('StartTest_Lan',[]);
end;

procedure FP.StartTest_WiFi();
begin
  Execute('StartTest_WiFi',[]);
end;

function FP.Subtotal(OptionPrinting: OptionPrintingEnum; OptionDisplay: OptionDisplayEnum; DiscAddV: double; DiscAddP: double): double;
begin
  Result := (createRes(DummyCoreObject, Execute('Subtotal',['OptionPrinting',OptionPrinting, 'OptionDisplay',OptionDisplay, 'DiscAddV',DiscAddV, 'DiscAddP',DiscAddP])) as DummyCoreObject).Value;
end;

procedure FP.UnpairAllDevices();
begin
  Execute('UnpairAllDevices',[]);
end;

procedure FP.ApplyClientLibraryDefinitions();
  var mXML: IXMLDocument;
      sXX: WideString;
begin
sXX := '<Defs><ServerStartupSettings>  <Encoding CodePage="1251" EncodingName="Cyrillic (Windows)" />  <GenerationTimeStamp>2407311630</GenerationTimeStamp>  <SignalFD>0</SignalFD>  <SilentFindDevice>0</SilentFindDevice>  <EM>0</EM> </ServerStartupSettings><Comma'+
'nd Name="CashDrawerOpen" CmdByte="0x2A"><FPOperation>Opens the cash drawer.</FPOperation></Command><Command Name="CashPayCloseReceipt" CmdByte="0x36"><FPOperation>Paying the exact amount in cash and close the fiscal receipt.</FPOperation></Command><Comman'+
'd Name="ClearDisplay" CmdByte="0x24"><FPOperation>Clears the external display.</FPOperation></Command><Command Name="CloseNonFiscReceipt" CmdByte="0x2F"><FPOperation>Closes the non-fiscal receipt.</FPOperation></Command><Command Name="CloseReceipt" CmdByt'+
'e="0x38"><FPOperation>Close the fiscal receipt (Fiscal receipt, Storno receipt, or Non-fical receipt). When the payment is finished.</FPOperation></Command><Command Name="ConfirmIDNumandVATnum" CmdByte="0x41"><FPOperation>Confirm storing VAT and ID number'+
's into the operative memory.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols string</Desc></Arg><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Password[6]> <;> <''2''> ]]></Args'+
'FormatRaw></Args></Command><Command Name="CutPaper" CmdByte="0x29"><FPOperation>Start paper cutter. The command works only in fiscal printer devices.</FPOperation></Command><Command Name="DirectCommand" CmdByte="0xF1"><FPOperation>Executes the direct comm'+
'and .</FPOperation><Args><Arg Name="Input" Value="" Type="Text" MaxLen="200"><Desc>Raw request to FP</Desc></Arg></Args><Response ACK="false"><Res Name="Output" Value="" Type="Text" MaxLen="200"><Desc>FP raw response</Desc></Res></Response></Command><Comm'+
'and Name="DisplayDateTime" CmdByte="0x28"><FPOperation>Shows the current date and time on the external display.</FPOperation></Command><Command Name="DisplayTextLine1" CmdByte="0x25"><FPOperation>Shows a 20-symbols text in the upper external display line.'+
'</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="20"><Desc>20 symbols text</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="DisplayTextLine2" CmdByte="0x26"><FPOperation>Shows a 20-symbols'+
' text in the lower external display line.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="20"><Desc>20 symbols text</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="DisplayTextLines1and2" '+
'CmdByte="0x27"><FPOperation>Shows a 20-symbols text in the first line and last 20-symbols text in the second line of the external display lines.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="40"><Desc>40 symbols text</Desc></Arg><ArgsFo'+
'rmatRaw><![CDATA[ <Text[40]> ]]></ArgsFormatRaw></Args></Command><Command Name="EnterServiceMode" CmdByte="0x5A"><FPOperation>Enter Service mode</FPOperation><Args><Arg Name="Option" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="'+
'W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionServiceMode" Value="" Type="Option" MaxLen="1"><Options><Option Name="Sales mode" Value="0" /><Option Name="Service mode" Value="1" /></Options><Desc>1 symbol:  -''1'' - Service mode -''0'' - Sales m'+
'ode</Desc></Arg><Arg Name="ServicePassword" Value="" Type="Text" MaxLen="8"><Desc>8 ASCII symbols</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option[''S'']> <;> <Option[''W'']> <;><ServiceMode[1]><;> <ServicePassword[8]> ]]></ArgsFormatRaw></Args></Command><Com'+
'mand Name="ManageDetailedReceiptInfoSending" CmdByte="0x5A"><FPOperation>Temporary enable/disable detailed receipts info sending</FPOperation><Args><Arg Name="Option1" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="W" Type="Optio'+
'nHardcoded" MaxLen="1" /><Arg Name="OptionActivationRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value - ''1'' - Yes - ''0'' - No</Desc></Arg><ArgsFormatRaw><![CDAT'+
'A[ <Option1[''D'']> <;> <Option2[''W'']> <;> <ActivationRS[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ManageShortReceiptSending" CmdByte="0x5A"><FPOperation>Temporary enable/disable short receipts sending</FPOperation><Args><Arg Name="Option1"'+
' Value="F" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionActivationRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Optio'+
'ns><Desc>1 symbol with value : - ''1'' - Yes - ''0'' - No</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option1[''F'']> <;> <Option2[''W'']> <;> <ActivationRS[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="OpenNonFiscalReceipt" CmdByte="0x2E"><FPOperation'+
'>Opens a non-fiscal receipt assigned to the specified operator</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from ''1'' to ''20'' corresponding to operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type='+
'"Text" MaxLen="4"><Desc>4 symbols for operator''s password</Desc></Arg><ArgsFormatRaw><![CDATA[ < OperNum[1..2]> <;> < OperPass[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="OpenReceiptOrStorno" CmdByte="0x30"><FPOperation>Opens a fiscal receipt '+
'assigned to the specified operator</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type="Text" MaxLen="4"><Desc>4 symbols for'+
' operator''s password</Desc></Arg><Arg Name="OptionReceiptType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Sale" Value="1" /><Option Name="Storno" Value="0" /></Options><Desc>1 symbol with value:  - ''1'' - Sale  - ''0'' - Storno</Desc></Arg'+
'><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionPrintType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Postponed printing" Value="2" /><Option Name="Step by step printing" Value="0" /></Options><Desc>1 sym'+
'bol with value  - ''0'' - Step by step printing  - ''2'' - Postponed printing</Desc></Arg><ArgsFormatRaw><![CDATA[ <OperNum[1..2]> <;> <OperPass[4]> <;> < ReceiptType[1]> <;> <reserved[''0'']> <;> <PrintType[1]> ]]></ArgsFormatRaw></Args></Command><Comman'+
'd Name="PaperFeed" CmdByte="0x2B"><FPOperation>Feeds one line of paper.</FPOperation></Command><Command Name="PayExactSum" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and exact amount received.</FPOperati'+
'on><Args><Arg Name="OptionPaymentType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Card" Value="1" /><Option Name="Cash" Value="0" /><Option Name="Credit" Value="3" /><Option Name="Currency" Value="4" /><Option Name="Voucher" Value="2" /></Op'+
'tions><Desc>1 symbol with values  - ''0'' - Cash  - ''1'' - Card  - ''2'' - Voucher  - ''3'' - Credit  - ''4'' - Currency</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="reserved" Value="&quot;" Type="OptionHardco'+
'ded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PaymentType[1]> <;> <reserved[''0'']> <;><reserved[''"'']> ]]></ArgsFormatRaw></Args></Command><Command Name="Payment" CmdByte="0x35"><FPOperation>Registers the payment in the receipt with specified type of paym'+
'ent and amount received.</FPOperation><Args><Arg Name="OptionPaymentType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Card" Value="1" /><Option Name="Cash" Value="0" /><Option Name="Credit" Value="3" /><Option Name="Currency" Value="4" /><Opt'+
'ion Name="Voucher" Value="2" /></Options><Desc>1 symbol with values  - ''0'' - Cash  - ''1'' - Card  - ''2'' - Voucher  - ''3'' - Credit  - ''4'' - Currency</Desc></Arg><Arg Name="OptionChange" Value="" Type="Option" MaxLen="1"><Options><Option Name="With'+
' Change" Value="0" /><Option Name="Without Change" Value="1" /></Options><Desc>Default value is 0, 1 symbol with value:  - ''0 - With Change  - ''1'' - Without Change</Desc></Arg><Arg Name="Amount" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 charac'+
'ters for received amount</Desc></Arg><Arg Name="OptionChangeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name="Change In Currency" Value="2" /><Option Name="Same As The payment" Value="1" /></Options><'+
'Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The payment  - ''2'' - Change In Currency</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><ArgsFormatRaw><![CDATA[ <PaymentType[1]> <;> <OptionChange[1]> <'+
';> <Amount[1..10]> { <*> <OptionChangeType[1]> } ]]></ArgsFormatRaw></Args></Command><Command Name="Print2DBarcode" CmdByte="0x51"><FPOperation>Prints QR 2D code</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Scal'+
'e" Value="" Type="Text" MaxLen="1"><Desc>1 symbol for scale</Desc></Arg><Arg Name="CodeData" Value="" Type="Text" MaxLen="200"><Desc>From 0 to 200 bytes</Desc></Arg><ArgsFormatRaw><![CDATA[ <''R''> <;> <Scale[1]> <;> <CodeData[200]> ]]></ArgsFormatRaw></A'+
'rgs></Command><Command Name="PrintArticleReport" CmdByte="0x7E"><FPOperation>Prints an article report with or without zeroing (''Z'' or ''X'').</FPOperation><Args><Arg Name="OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Option Name="Without z'+
'eroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>with following values:  - ''Z'' - Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBar'+
'code" CmdByte="0x51"><FPOperation>Prints barcode from type stated by CodeType and CodeLen and with data stated in CodeData field.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionCodeType" Value="" Type="Optio'+
'n" MaxLen="1"><Options><Option Name="CODABAR" Value="6" /><Option Name="CODE 128" Value="I" /><Option Name="CODE 39" Value="4" /><Option Name="CODE 93" Value="H" /><Option Name="EAN 13" Value="2" /><Option Name="EAN 8" Value="3" /><Option Name="ITF" Value'+
'="5" /><Option Name="UPC A" Value="0" /><Option Name="UPC E" Value="1" /></Options><Desc>1 symbol with possible values:  - ''0'' - UPC A  - ''1'' - UPC E  - ''2'' - EAN 13  - ''3'' - EAN 8  - ''4'' - CODE 39  - ''5'' - ITF  - ''6'' - CODABAR  - ''H'' - CO'+
'DE 93  - ''I'' - CODE 128</Desc></Arg><Arg Name="CodeLen" Value="" Type="Decimal" MaxLen="2"><Desc>1..2 bytes for number of bytes according to the table</Desc></Arg><Arg Name="CodeData" Value="" Type="Text" MaxLen="100"><Desc>From 0 to 255 bytes data in r'+
'ange according to the table</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''> <;> <CodeType[1]> <;> <CodeLen[1..2]> <;> <CodeData[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBriefFMReportByDate" CmdByte="0x7B"><FPOperation>Print a brief FM re'+
'port by initial and end date.</FPOperation><Args><Arg Name="StartDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndDate" Value="" Type="DateTime" MaxLen="10" Format="'+
'ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartDate "DDMMYY"><;><EndDate "DDMMYY"> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBriefFMReportByNum" CmdByte="0x79"><FPOperation>Print a brie'+
'f FM report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial FM report number included in report, format ####</Desc></Arg><Arg Name="E'+
'ndNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final FM report number included in report, format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartNum[4]><;><EndNum[4]> ]]></ArgsFormatRaw></Args></Command><Comman'+
'd Name="PrintDailyReport" CmdByte="0x7C"><FPOperation>Depending on the parameter prints: − daily fiscal report with zeroing and fiscal memory record, preceded by Electronic Journal report print (''Z''); − daily fiscal report without zeroing (''X'');</FPOp'+
'eration><Args><Arg Name="OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>1 character with following values:  - ''Z'' - Zeroing  - ''X'' - Without zeroi'+
'ng</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDepartmentReport" CmdByte="0x76"><FPOperation>Print a department report with or without zeroing (''Z'' or ''X'').</FPOperation><Args><Arg Na'+
'me="OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>1 symbol with value:  - ''Z'' - Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsFormatRaw><![CD'+
'ATA[ <OptionZeroing[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDetailedFMReportByDate" CmdByte="0x7A"><FPOperation>Prints a detailed FM report by initial and end date.</FPOperation><Args><Arg Name="StartDate" Value="" Type="DateTime" MaxL'+
'en="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[ <St'+
'artDate "DDMMYY"><;><EndDate "DDMMYY"> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDetailedFMReportByNum" CmdByte="0x78"><FPOperation>Print a detailed FM report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNum" Value'+
'="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial report number included in report, format ####</Desc></Arg><Arg Name="EndNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final'+
' report number included in report, format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartNum[4]><;><EndNum[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDiagnostics" CmdByte="0x22"><FPOperation>Prints out a diagnostic receipt.</FPOperation>'+
'</Command><Command Name="PrintEJ" CmdByte="0x7C"><FPOperation>Print or store Electronic Journal report with all documents.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen='+
'"1" /><ArgsFormatRaw><![CDATA[ <''J1''> <;> <''*''> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByDate" CmdByte="0x7C"><FPOperation>Printing Electronic Journal Report from Report initial date to report Final date.</FPOperation><Args><Arg Nam'+
'e="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></'+
'Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[<''J1''> <;> <''D''> <;> <StartRepFromDate"DDMMYY"> <;> <EndRepFromDate"DDMMYY"> ]]'+
'></ArgsFormatRaw></Args></Command><Command Name="PrintEJByReceiptNumFromZrep" CmdByte="0x7C"><FPOperation>Printing Electronic Journal Report from receipt number to receipt number.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2'+
'" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ZrepNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for Z report number in format ####</Desc></Arg><Arg Name="StartReceiptNum" Value="" Type="Decim'+
'al_with_format" MaxLen="6" Format="000000"><Desc>6 symbols for initial receipt number in format ######</Desc></Arg><Arg Name="EndReceiptNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000"><Desc>6 symbols for final receipt number in format '+
'######</Desc></Arg><ArgsFormatRaw><![CDATA[<''J1''><;><''N''><;><ZrepNum[4]><;> <StartReceiptNum[6]><;><EndReceiptNum[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByStornoNumFromZrep" CmdByte="0x7C"><FPOperation>Printing Electronic Journa'+
'l Report from receipt number to receipt number.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="n" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ZrepNum" Value="" Type="Text" MaxLen="4"><Desc>4 symbols f'+
'or Z report number</Desc></Arg><Arg Name="StartReceiptNum" Value="" Type="Text" MaxLen="6"><Desc>5 symbols for initial daily Storno receipt number</Desc></Arg><Arg Name="EndReceiptNum" Value="" Type="Text" MaxLen="6"><Desc>5 symbols for final daily Storno'+
' receipt number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''J1''><;><''n''><;><ZrepNum[4]><;><StartReceiptNum[6]> <;><EndReceiptNum[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByZBlocks" CmdByte="0x7C"><FPOperation>Print or store Electronic '+
'Journal Report from by number of Z report blocks.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4'+
'" Format="0000"><Desc>4 symbols for initial number report in format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number report in format ####</Desc></Arg><ArgsFormatRaw><![CDAT'+
'A[ <''J1''> <;> <''Z''> <;> <StartZNum[4]> <;> <EndZNum[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintLogo" CmdByte="0x6C"><FPOperation>Prints the programmed graphical logo with the stated number.</FPOperation><Args><Arg Name="Number" Value='+
'"" Type="Decimal" MaxLen="2"><Desc>Number of logo to be printed. If missing prints logo with number 0</Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[1..2]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintOperatorReport" CmdByte="0x7D"><FPOperation>P'+
'rints an operator''s report for a specified operator (0 = all operators) with or without zeroing (''Z'' or ''X''). When a ''Z'' value is specified the report should include all operators.</FPOperation><Args><Arg Name="OptionZeroing" Value="" Type="Option"'+
' MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>with following values:  - ''Z'' - Zeroing  - ''X'' - Without zeroing</Desc></Arg><Arg Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc'+
'>Symbols from 0 to 20corresponding to operator''s number ,0 for all operators</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> <;> <Number[1..2]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintSpecialEventsFMreport" CmdByte="0x77"><FPOpera'+
'tion>Print whole special FM events report.</FPOperation></Command><Command Name="PrintText" CmdByte="0x37"><FPOperation>Print a free text. The command can be executed only if receipt is opened (Fiscal receipt, Storno receipt or Non-fical receipt). In the '+
'beginning and in the end of line symbol ''#'' is printed.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="64"><Desc>TextLength-2 symbols</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[TextLength-2]> ]]></ArgsFormatRaw></Args></Command><Comman'+
'd Name="ProgDecimalPointPosition" CmdByte="0x43"><FPOperation>Stores a block containing the number format into the fiscal memory. Print the current status on the printer.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6-symb'+
'ols string</Desc></Arg><Arg Name="OptionDecimalPointPosition" Value="" Type="Option" MaxLen="1"><Options><Option Name="Fractions" Value="2" /><Option Name="Whole numbers" Value="0" /></Options><Desc>1 symbol with values:  - ''0''- Whole numbers  - ''2'' -'+
' Fractions</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]> <;> <DecimalPointPosition[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgDepartment" CmdByte="0x47"><FPOperation>Set data for the state department number from the internal FD databa'+
'se.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols department number in format ##</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="23"><Desc>23 characters department name</Desc></A'+
'rg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Option Name="VAT Class 0" Value="А" /><Option Name="VAT Class 1" Value="Б" /><Option Name="VAT Class 2" Value="В" /><Option Name="VAT Class 3" Value="Г" /></Options><Desc>1 characte'+
'r for VAT class:  - ''А'' - VAT Class 0  - ''Б'' - VAT Class 1  - ''В'' - VAT Class 2  - ''Г'' - VAT Class 3</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for department price</Desc></Arg><Arg Name="FlagsPrice" V'+
'alue="" Type="Flags" MaxLen="1"><Desc>1 symbol with value: Flags.7=1 Flags.6=0 Flags.5=0 Flags.4=1 Yes, Flags.4=0 No (Macedonian goods) Flags.3=0 Flags.2=1 Yes, Flags.2=0 No (Single Transaction) Flags.1=1 Yes, Flags.1=0 No (Free price limited) Flags.0=1 Y'+
'es, Flags.0=0 No (Free price enabled)</Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[2]> <;> <Name[23]> <;> <OptionVATClass[1]> <;> <Price[1..10]> <;> <FlagsPrice[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgDisplayGreetingMessage" CmdByte="0x'+
'49"><FPOperation>Program the contents of a Display Greeting message.</FPOperation><Args><Arg Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="DisplayGreetingText" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for Display greeting messa'+
'ge</Desc></Arg><ArgsFormatRaw><![CDATA[<''0''> <;> <DisplayGreetingText[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgExtDisplay" CmdByte="0x46"><FPOperation>Programs the external display.</FPOperation><Args><Arg Name="Password" Value="" Typ'+
'e="Text" MaxLen="6"><Desc>A 6-symbol string</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]> <NumBytesCom1line[1]> <Com1line[8]> <NumBytesCom2line[1]> <Com2Line[8]> < NumBytesClrDis[1]> <ComClrDis[8]> <NumbytesXtrCom[1]> <ComXtrCom[1]> <FlagPrecod[1]> {'+
'<PrecodTabl[64]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ProgFooter" CmdByte="0x49"><FPOperation>Program the contents of a footer lines.</FPOperation><Args><Arg Name="OptionFooterLine" Value="" Type="Option" MaxLen="2"><Options><Option Name="F'+
'ooter 1" Value="F1" /><Option Name="Footer 2" Value="F2" /><Option Name="Footer 3" Value="F3" /></Options><Desc>2 symbol with value: -''F1'' - Footer 1 -''F2'' - Footer 2 -''F3'' - Footer 3</Desc></Arg><Arg Name="FooterText" Value="" Type="Text" MaxLen="6'+
'4"><Desc>TextLength symbols for footer line</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionFooterLine[2]> <;> <FooterText[TextLength]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgHeader" CmdByte="0x49"><FPOperation>Program the contents of a header '+
'lines.</FPOperation><Args><Arg Name="OptionHeaderLine" Value="" Type="Option" MaxLen="1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Name="Header 3" Value="3" /><Option Name="Header 4" Value="4" /><Option Name='+
'"Header 5" Value="5" /><Option Name="Header 6" Value="6" /><Option Name="ID number" Value="7" /><Option Name="VAT number" Value="8" /></Options><Desc>1 symbol with value:  - ''1'' - Header 1  - ''2'' - Header 2  - ''3'' - Header 3  - ''4'' - Header 4  - '+
'''5'' - Header 5  - ''6'' - Header 6  - ''7'' - ID number  - ''8'' - VAT number</Desc></Arg><Arg Name="HeaderText" Value="" Type="Text" MaxLen="64"><Desc>TextLength symbols for header lines</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionHeaderLine[1]> <;> <He'+
'aderText[TextLength]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgOperator" CmdByte="0x4A"><FPOperation>Programs the operator''s name and password.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from ''1'+
''' to ''20'' corresponding to operator''s number</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for operator''s name</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for operator''s password<'+
'/Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[1..2]> <;> <Name[20]> <;> <Password[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgParameters" CmdByte="0x45"><FPOperation>Programs the number of POS, printing of logo, cash drawer opening, cutting '+
'permission, external display management mode, article report type, enable or disable currency in receipt and working operators counter.</FPOperation><Args><Arg Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for '+
'number of POS in format ####</Desc></Arg><Arg Name="OptionPrintLogo" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg N'+
'ame="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionAutoCut" Value="" Type="Option"'+
' MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionExternalDispManagement" Value="" Type="Option" MaxLen="1"><Options><Option Name='+
'"Auto" Value="0" /><Option Name="Manual" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Manual  - ''0'' - Auto</Desc></Arg><Arg Name="OptionReceiptSend" Value="" Type="Option" MaxLen="1"><Options><Option Name="Automatic sending" Value="1" /><Op'+
'tion Name="Without sending" Value="0" /></Options><Desc>1 symbol of value:  - ''1'' - Automatic sending  - ''0'' - Without sending</Desc></Arg><Arg Name="OptionEnableCurrency" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Optio'+
'n Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionWorkOperatorCount" Value="" Type="Option" MaxLen="1"><Options><Option Name="More" Value="0" /><Option Name="One" Value="1" /></Options><D'+
'esc>1 symbol of value:  - ''1'' - One  - ''0'' - More</Desc></Arg><ArgsFormatRaw><![CDATA[ <POSNum[4]> <;> <PrintLogo[1]> <;> <AutoOpenDrawer[1]> <;> <AutoCut[1]> <;> <ExternalDispManagement[1]> <;> <ReceiptSend[1]> <;> <EnableCurrency[1]> <;> <WorkOperat'+
'orCount[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPayment" CmdByte="0x44"><FPOperation>Program the name of the payment types.</FPOperation><Args><Arg Name="OptionPaymentNum" Value="" Type="Option" MaxLen="1"><Options><Option Name="Payment'+
' 1" Value="1" /><Option Name="Payment 2" Value="2" /><Option Name="Payment 3" Value="3" /><Option Name="Payment 4" Value="4" /></Options><Desc>1 symbol for payment type:  - ''1'' - Payment 1  - ''2'' - Payment 2  - ''3'' - Payment 3  - ''4'' - Payment 4</'+
'Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment type name</Desc></Arg><Arg Name="Rate" Value="" Type="Decimal_with_format" MaxLen="10" Format="0000.00000"><Desc>10 symbols for exchange rate in format: ####.#####  '+
'of the 4 th payment type.</Desc><Meta MinLen="10" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <PaymentNum[1]> <;> <Name[10]> { <;> <Rate[10]> } ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUbarcode" CmdByte="0'+
'x4B"><FPOperation>Program the Barcode number for a certain article (item) from the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</'+
'Desc></Arg><Arg Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Barcode" Value="" Type="Text" MaxLen="13"><Desc>13 symbols for barcode</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''3'']><;><Barcode[13]> ]]></ArgsForma'+
'tRaw></Args></Command><Command Name="ProgPLUgeneral" CmdByte="0x4B"><FPOperation>Programs the general data for a certain article in the internal FD database. The price may have variable length, while the name field is fixed.</FPOperation><Args><Arg Name="'+
'PLUNum" Value="" Type="Text" MaxLen="5"><Desc>5 symbols for article number</Desc></Arg><Arg Name="Option" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PLUName" Value="" Type="Text" MaxLen="32"><Desc>32 symbols for article name</Desc></Arg><Arg'+
' Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for article price</Desc></Arg><Arg Name="FlagsPriceQty" Value="" Type="Flags" MaxLen="1"><Desc>1 symbols with value: Flags.7=1 Flags.6=0 Flags.5=0 Flags.4=1 Yes, Flags.4=0 No (Macedon'+
'ian goods) Flags.3=1 Yes, Flags.3=0 No (Allow negative quantity) Flags.2=1 Yes, Flags.2=0 No (Monitoring quantity in stock) Flags.1=1 Yes, Flags.1=0 No (Free price limited) Flags.0=1 Yes, Flags.0=0 No (Free price enabled)</Desc></Arg><Arg Name="BelongToDe'+
'pNum" Value="" Type="Decimal_plus_80h" MaxLen="2"><Desc>BelongToDepNum + 80h, 1 symbol for article department attachment, formed in the following manner: BelongToDepNum[HEX] + 80h example: Dep01 = 81h, Dep02 = 82h … Dep19 = 93h</Desc></Arg><Arg Name="Avai'+
'lableQuantity" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for quantity in stock</Desc></Arg><Arg Name="Barcode" Value="" Type="Text" MaxLen="13"><Desc>13 symbols for barcode</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;> <Option[''1'+
''']> <;> <PLUName[32]> <;> <Price[1..10]> <;> <FlagsPriceQty[1]> <;> <BelongToDepNum[1..2]> <;> <AvailableQuantity[1..11]> <;> <Barcode[13]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUprice" CmdByte="0x4B"><FPOperation>Program the price for'+
' a certain article from the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="4" Type="OptionHar'+
'dcoded" MaxLen="1" /><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for article price</Desc></Arg><Arg Name="OptionPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price is disable valid only programmed pr'+
'ice" Value="0" /><Option Name="Free price is enable" Value="1" /><Option Name="Limited price" Value="2" /></Options><Desc>1 byte for Price flag with next value:  - ''0''- Free price is disable valid only programmed price  - ''1''- Free price is enable  - '+
'''2''- Limited price</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;> <Option[''4'']> <;> <Price[1..10]> <;> <OptionPrice[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUqty" CmdByte="0x4B"><FPOperation>Programs available quantity and qu'+
'antiy type for a certain article in the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="2" Typ'+
'e="OptionHardcoded" MaxLen="1" /><Arg Name="AvailableQuantity" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for quantity in stock</Desc></Arg><Arg Name="OptionQuantityType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Availabilit'+
'y of PLU stock is not monitored" Value="0" /><Option Name="Disable negative quantity" Value="1" /><Option Name="Enable negative quantity" Value="2" /></Options><Desc>1 symbol for Quantity flag with next value:  - ''0''- Availability of PLU stock is not mo'+
'nitored  - ''1''- Disable negative quantity  - ''2''- Enable negative quantity</Desc></Arg><ArgsFormatRaw><![CDATA[<PLUNum[5]><;><Option[''2'']><;><AvailableQuantity [1..11]> <;> <OptionQuantityType[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="P'+
'rogVATrates" CmdByte="0x42"><FPOperation>Stores a block containing the values of the VAT rates into the fiscal memory. Print the values on the printer.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols string</Desc></'+
'Arg><Arg Name="VATrate1" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate А from 6 symbols in format ##.##</Desc></Arg><Arg Name="VATrate2" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of V'+
'AT rate Б from 6 symbols in format ##.##</Desc></Arg><Arg Name="VATrate3" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate В from 6 symbols in format ##.##</Desc></Arg><Arg Name="VATrate4" Value="" Type="Decimal_with_f'+
'ormat" MaxLen="6" Format="00.00"><Desc>Value of VAT rate Г from 6 symbols in format ##.##</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]> <;> <VATrate1[6]> <;> <VATrate2[6]> <;> <VATrate3[6]> <;> <VATrate4[6]> ]]></ArgsFormatRaw></Args></Command><Comma'+
'nd Name="RawRead" CmdByte="0xFF"><FPOperation> Reads raw bytes from FP.</FPOperation><Args><Arg Name="Count" Value="" Type="Decimal" MaxLen="5"><Desc>How many bytes to read if EndChar is not specified</Desc></Arg><Arg Name="EndChar" Value="" Type="Text" M'+
'axLen="1"><Desc>The character marking the end of the data. If present Count parameter is ignored.</Desc></Arg></Args><Response ACK="false"><Res Name="Bytes" Value="" Type="Base64" MaxLen="100000"><Desc>FP raw response in BASE64 encoded string</Desc></Res>'+
'</Response></Command><Command Name="RawWrite" CmdByte="0xFE"><FPOperation> Writes raw bytes to FP </FPOperation><Args><Arg Name="Bytes" Value="" Type="Base64" MaxLen="5000"><Desc>The bytes in BASE64 ecoded string to be written to FP</Desc></Arg></Args></C'+
'ommand><Command Name="ReadBluetooth_Password" CmdByte="0x4E"><FPOperation>Provides information about device''s Bluetooth password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" '+
'MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''B''><;><''P''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="B" '+
'Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the BT password length</Desc></Res><Res Name="Password" Value="" Ty'+
'pe="Text" MaxLen="100"><Desc>Up to 100 symbols for the BT password</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''B''><;><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadBluetooth_Status" CmdByte="0x'+
'4E"><FPOperation>Providing information about if the device''s Bluetooth module is enabled or disabled.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Va'+
'lue="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''B''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="B" Type="OptionHardcoded" MaxLe'+
'n="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionBTstatus" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>(Status) 1 symbol with value:  '+
'- ''0'' - Disabled  - ''1'' - Enabled</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''B''><;><''S''><;><BTstatus[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadCurrentRecInfo" CmdByte="0x72"><FPOperation>Read the current status of the receip'+
't.</FPOperation><Response ACK="false"><Res Name="OptionIsReceiptOpened" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - No  - ''1'' - Yes</Desc></Res><'+
'Res Name="OptionReceiptType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Sale" Value="1" /><Option Name="Storno" Value="0" /></Options><Desc>1 symbol with value:  - ''1'' - Sale  - ''0'' - Storno</Desc></Res><Res Name="SalesNumber" Value="" T'+
'ype="Text" MaxLen="3"><Desc>3 symbols for number of sales</Desc></Res><Res Name="MacSubtotalVATG0" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from Macedonian goods by VAT groups</Desc></Res><Res Name="MacSubtotalVATG1" Value="" Type="T'+
'ext" MaxLen="11"><Desc>11 symbols for subtotal from Macedonian goods by VAT groups</Desc></Res><Res Name="MacSubtotalVATG2" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from Macedonian goods by VAT groups</Desc></Res><Res Name="MacSubtot'+
'alVATG3" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from Macedonian goods by VAT groups</Desc></Res><Res Name="ImpSubtotalVATG0" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from imported goods by VAT groups</Desc></R'+
'es><Res Name="ImpSubtotalVATG1" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from imported goods by VAT groups</Desc></Res><Res Name="ImpSubtotalVATG2" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from imported goods by'+
' VAT groups</Desc></Res><Res Name="ImpSubtotalVATG3" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for subtotal from imported goods by VAT groups</Desc></Res><Res Name="OptionInitiatedPayment" Value="" Type="Option" MaxLen="1"><Options><Option Name="i'+
'nitiated payment" Value="1" /><Option Name="not initiated payment" Value="0" /></Options><Desc>1 symbol with value:  - ''1'' - initiated payment  - ''0'' - not initiated payment</Desc></Res><Res Name="OptionFinalizedPayment" Value="" Type="Option" MaxLen='+
'"1"><Options><Option Name="finalized payment" Value="1" /><Option Name="not finalized payment" Value="0" /></Options><Desc>1 symbol with value:  - ''1'' - finalized payment  - ''0'' - not finalized payment</Desc></Res><Res Name="OptionPowerDownInReceipt" '+
'Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value: - ''0'' - No - ''1'' - Yes</Desc></Res><Res Name="ChangeAmount" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11'+
' symbols the amount of the due change in the stated payment type</Desc></Res><Res Name="OptionChangeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name="Change In Currency" Value="2" /><Option Name="Same'+
' As The payment" Value="1" /></Options><Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The payment  - ''2'' - Change In Currency</Desc></Res><ResFormatRaw><![CDATA[<IsReceiptOpened[1]> <;> <ReceiptType[1]><;><SalesNumber[3]> <;> <'+
'MacSubtotalVATG0[11]> <;> <MacSubtotalVATG1[11]> <;> < MacSubtotalVATG2[11]> <;> <MacSubtotalVATG3[11]> <;> <ImpSubtotalVATG0[11]> <;> <ImpSubtotalVATG1[11]> <;> <ImpSubtotalVATG2[11]> <;> <ImpSubtotalVATG3[11]> <;> <InitiatedPayment[1]> <;> <FinalizedPay'+
'ment[1]> <;> < PowerDownInReceipt [1]> <;> <ChangeAmount[1..11]> <;> <OptionChangeType[1]]]></ResFormatRaw></Response></Command><Command Name="ReadDailyCounters" CmdByte="0x6E"><FPOperation>Provides information about the total fiscal counters and last Z- '+
'report date and time.</FPOperation><Args><Arg Name="" Value="5" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''5''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="5" Type="OptionHardcoded" MaxLen="1" /><Res Name="Tota'+
'lReciepts" Value="" Type="Decimal" MaxLen="5"><Desc>5 symbols for total number of fiscal receipts</Desc></Res><Res Name="TotalStorno" Value="" Type="Decimal" MaxLen="5"><Desc>5 symbols for total number of Storno receipts</Desc></Res><Res Name="NumLastFMBl'+
'ock" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of the last FM report</Desc></Res><Res Name="NumEJ" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of EJ</Desc></Res><Res Name="DateTime" Value="" Type="DateTime'+
'" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for date and time of the last block storage in FM in format "DD-MM-YYYY HH:MM"</Desc></Res><ResFormatRaw><![CDATA[<''5''> <;> <TotalReciepts[1..5]> <;> <TotalStorno[1..5]> <;> <NumLastFMBlock[1..5]>'+
' <;> <NumEJ[1..5]> <;> <DateTime "DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadDailyCountersByOperator" CmdByte="0x6F"><FPOperation>Read the last operator''s report number and date and time.</FPOperation><Args><Arg Name="" V'+
'alue="5" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''5''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><'+
'Response ACK="false"><Res Name="" Value="5" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="WorkOperatorsCounter" Value="" Typ'+
'e="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of the work operators</Desc></Res><Res Name="LastOperatorReportDateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for date and time of the last operator''s repo'+
'rt in format DD-MM-YYYY HH:MM</Desc></Res><ResFormatRaw><![CDATA[<''5''> <;> <OperNum[1..2]> <;> <WorkOperatorsCounter[1..5]> <;> <LastOperatorReportDateTime "DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadDailyGeneralRegister'+
'sByOperator" CmdByte="0x6F"><FPOperation>Read the total number of customers, discounts, additions, corrections and accumulated amounts by specified operator.</FPOperation><Args><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum"'+
' Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''1''><;><OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="1" Type="OptionHardcoded"'+
' MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="FiscalReciept" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for daily number of fiscal r'+
'eceipts</Desc></Res><Res Name="StornoReciept" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for daily number of Storno receipts</Desc></Res><Res Name="DiscountsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of discount'+
's</Desc></Res><Res Name="DiscountsAmount" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for accumulated amount of discounts</Desc></Res><Res Name="AdditionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of additions<'+
'/Desc></Res><Res Name="AdditionsAmount" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for accumulated amount of additions</Desc></Res><ResFormatRaw><![CDATA[<''1''><;><OperNum[1..2]> <;> < FiscalReciept [1..5]> <;> < StornoReciept[1..5]> <;> '+
'<DiscountsNum[1..5]> <;> <DiscountsAmount[1..11]> <;> <AdditionsNum[1..5]> <;> <AdditionsAmount[1..11]> <;>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyPO" CmdByte="0x6E"><FPOperation>Provides information about the PO amounts by type of '+
'payment and the total number of operations.</FPOperation><Args><Arg Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''3''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="3" Type="OptionHardcoded" MaxLen'+
'="1" /><Res Name="AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for PO amount by type of payment</Desc></Res><Res Name="NumPO" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</Desc></'+
'Res><ResFormatRaw><![CDATA[<''3''> <;> <AmountPayment[1..11]> <;> <NumPO[1..5]> <;>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyPObyOperator" CmdByte="0x6F"><FPOperation>Provides information about the PO and the total number of operation'+
's by specified operator.</FPOperation><Args><Arg Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDAT'+
'A[ <''3''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number'+
'</Desc></Res><Res Name="AmountPO_Payments" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for the PO by type of payment</Desc></Res><Res Name="NumPO" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</'+
'Desc></Res><ResFormatRaw><![CDATA[<''3''> <;> <OperNum[1..2]> <;> <AmountPO_Payments[1..11]> <;> <NumPO[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyRA" CmdByte="0x6E"><FPOperation>Provides information about the RA amounts by type '+
'of payment and the total number of operations.</FPOperation><Args><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''2''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="2" Type="OptionHardcoded" Max'+
'Len="1" /><Res Name="AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for RA amounts</Desc></Res><Res Name="NumRA" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</Desc></Res><ResFormatR'+
'aw><![CDATA[<''2''> <;> <AmountPayment[1..11]> <;> <NumRA[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyRAbyOperator" CmdByte="0x6F"><FPOperation>Provides information about the RA and the total number of operations by specified oper'+
'ator.</FPOperation><Args><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''2''> <;> <Ope'+
'rNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res N'+
'ame="AmountRA_Payments" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for the RA by type of payment</Desc></Res><Res Name="NumRA" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</Desc></Res><ResForm'+
'atRaw><![CDATA[<''2''> <;> <OperNum[1..2]> <;> <AmountRA_Payments[1..11]> <;> <NumRA[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReceivedSalesAmounts" CmdByte="0x6E"><FPOperation>Provides information about the amounts received fro'+
'm sales and Storno change.</FPOperation><Args><Arg Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''4''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name='+
'"AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from sales or Storno change by cash</Desc></Res><Res Name="AmountPaymentOthers" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received f'+
'rom sales or Storno change by others payment</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;> <AmountPayment[1..11]> <;> <AmountPaymentOthers[1..11]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReceivedSalesAmountsByOperator" CmdByte="0x6F'+
'"><FPOperation>Read the amounts received from sales by type of payment and specified operator.</FPOperation><Args><Arg Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 '+
'corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''4''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" Max'+
'Len="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from sales or Storno change by cash</Desc></Res><Res Name="AmountPa'+
'ymentOthers" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from sales or Storno change by others payment</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;> <OperNum[1..2]> <;> <AmountPayment[1..11]> <;> <AmountPaymentOthers[1.'+
'.11]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReturned" CmdByte="0x6E"><FPOperation>Provides information about the amounts returned as Storno or sales change.</FPOperation><Args><Arg Name="" Value="6" Type="OptionHardcoded" MaxLen="1'+
'" /><ArgsFormatRaw><![CDATA[ <''6''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Res Name="AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from s'+
'ales or Storno change by cash</Desc></Res><Res Name="AmountPaymentOthers" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from sales or Storno change by others payment</Desc></Res><ResFormatRaw><![CDATA[<''6''> <;> <AmountPa'+
'yment[1..11]> <;> <AmountPaymentOthers[1..11]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReturnedAmounts" CmdByte="0x6F"><FPOperation>Read information about the amounts returned</FPOperation><Args><Arg Name="" Value="6" Type="OptionHar'+
'dcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''6''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Re'+
's Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="AmountPayment" Value="" Type="Decimal" MaxLen="11"><Desc>U'+
'p to 11 symbols for amount received from sales or Storno change by cash</Desc></Res><Res Name="AmountPaymentOthers" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for amount received from sales or Storno change by others payment</Desc></Res><R'+
'esFormatRaw><![CDATA[<''6''> <;> <OperNum[1..2]> <;> <AmountPayment[1..11]> <;> <AmountPaymentOthers[1..11]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailySaleAndStornoAmountsByVAT" CmdByte="0x6D"><FPOperation>Provides information about th'+
'e accumulated amount by VAT group.</FPOperation><Response ACK="false"><Res Name="SalesAmountVATGr0" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from sales by VAT group А</Desc></Res><Res Name="SalesAmountVATGr1" Valu'+
'e="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from sales by VAT group Б</Desc></Res><Res Name="SalesAmountVATGr2" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from sales by VAT group В'+
'</Desc></Res><Res Name="SalesAmountVATGr3" Value="" Type="Text" MaxLen="1"><Desc>Up to 11 symbols for the amount accumulated from sales by VAT group Г</Desc></Res><Res Name="SalesMacAmountVATGr0" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for'+
' the mac amount accumulated from sales by</Desc></Res><Res Name="SalesMacAmountVATGr1" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the mac amount accumulated from sales by</Desc></Res><Res Name="SalesMacAmountVATGr2" Value="" Type="Text" M'+
'axLen="1"><Desc>Up to 11 symbols for the mac amount accumulated from sales by</Desc></Res><Res Name="SalesMacAmountVATGr3" Value="" Type="Text" MaxLen="1"><Desc>Up to 11 symbols for the mac amount accumulated from sales by</Desc></Res><Res Name="StornoAmo'+
'untVATGr0" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Storno by VAT group А</Desc></Res><Res Name="StornoAmountVATGr1" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Sto'+
'rno by VAT group Б</Desc></Res><Res Name="StornoAmountVATGr2" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Storno by VAT group В</Desc></Res><Res Name="StornoAmountVATGr3" Value="" Type="Text" MaxLen="11"><Desc>U'+
'p to 11 symbols for the amount accumulated from Storno by VAT group Г</Desc></Res><Res Name="StornoMacAmountVATGr0" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Mac Storno by</Desc></Res><Res Name="StornoMacAmoun'+
'tVATGr1" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Mac Storno by</Desc></Res><Res Name="StornoMacAmountVATGr2" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Mac Storno'+
' by</Desc></Res><Res Name="StornoMacAmountVATGr3" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for the amount accumulated from Mac Storno by</Desc></Res><ResFormatRaw><![CDATA[<SalesAmountVATGr0[11]> <;> <SalesAmountVATGr1[11]> <;> <SalesAmount'+
'VATGr2[11]> <;> <SalesAmountVATGr3[1]> <;> <SalesMacAmountVATGr0[11]> <;> <SalesMacAmountVATGr1[11]> <;> <SalesMacAmountVATGr2[1]> <;> <SalesMacAmountVATGr3[1]> <;> <StornoAmountVATGr0[11]> <;> < StornoAmountVATGr1[11]> <;> <StornoAmountVATGr2[11]> <;> <S'+
'tornoAmountVATGr3[11]> <;> <StornoMacAmountVATGr0[11]> <;> <StornoMacAmountVATGr1[11]> <;> <StornoMacAmountVATGr2[11]> <;> <StornoMacAmountVATGr3[11]>]]></ResFormatRaw></Response></Command><Command Name="ReadDateTime" CmdByte="0x68"><FPOperation>Provides '+
'information about the current date and time.</FPOperation><Response ACK="false"><Res Name="DateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>Date Time parameter in format: DD-MM-YY [Space] HH:MM</Desc></Res><ResFormatRaw><![CD'+
'ATA[<DateTime "DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadDecimalPoint" CmdByte="0x63"><FPOperation>Provides information about the current (the last value stored into the FM) decimal point format.</FPOperation><Response AC'+
'K="false"><Res Name="OptionDecimalPointPosition" Value="" Type="Option" MaxLen="1"><Options><Option Name="Fractions" Value="2" /><Option Name="Whole numbers" Value="0" /></Options><Desc>1 symbol with values:  - ''0''- Whole numbers  - ''2'' - Fractions</D'+
'esc></Res><ResFormatRaw><![CDATA[<DecimalPointPosition[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDepartment" CmdByte="0x67"><FPOperation>Provides information for the programmed data, the turnover from the stated department number</FPOpe'+
'ration><Args><Arg Name="DepNum" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols for deparment number in format: ##</Desc></Arg><ArgsFormatRaw><![CDATA[ <DepNum[2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="DepNu'+
'm" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols for department number in format ##</Desc></Res><Res Name="DepName" Value="" Type="Text" MaxLen="32"><Desc>34 symbols for department name</Desc></Res><Res Name="OptionVATClass" V'+
'alue="" Type="Option" MaxLen="1"><Options><Option Name="VAT Class 0" Value="А" /><Option Name="VAT Class 1" Value="Б" /><Option Name="VAT Class 2" Value="В" /><Option Name="VAT Class 3" Value="Г" /></Options><Desc>1 character for VAT class attachment of t'+
'he department:  - ''А'' - VAT Class 0  - ''Б'' - VAT Class 1  - ''В'' - VAT Class 2  - ''Г'' - VAT Class 3</Desc></Res><Res Name="Price" Value="" Type="Decimal" MaxLen="11"><Desc>1..11 symbols for Department price</Desc></Res><Res Name="FlagsPrice" Value='+
'"" Type="Flags" MaxLen="1"><Desc>(Setting price, signle transaction, type of goods) 1 symbol with value: Flags.7=1 Flags.6=0 Flags.5=0 Flags.4=1 Yes, Flags.4=0 No (Macedonian goods) Flags.3=0 Flags.2=1 Yes, Flags.2=0 No (Single Transaction) Flags.1=1 Yes,'+
' Flags.1=0 No (Free price limited) Flags.0=1 Yes, Flags.0=0 No (Free price enabled)</Desc></Res><Res Name="Turnover" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for accumulated turnover of the department</Desc></Res><Res Name="SoldQuantity"'+
' Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for sold quantity of the department</Desc></Res><Res Name="TurnoverMac" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for maced. turnover of the department</Desc></Res><Res Name="Sol'+
'dQuantityMac" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for maced. sold quantity of the department</Desc></Res><Res Name="TurnoverSt" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for Storno turnover of the department</Desc><'+
'/Res><Res Name="SoldQuantitySt" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for Storno</Desc></Res><Res Name="TurnoverStMac" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for Storno maced.turnover by this department</Desc></Res'+
'><Res Name="SoldQuantityStMac" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for Storno maced quantity</Desc></Res><Res Name="LastZReportNumber" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>Up to 5 symbols for the numbe'+
'r of last Z report in format #####</Desc></Res><Res Name="LastZReportDate" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for the date and hour in last Z report</Desc></Res><ResFormatRaw><![CDATA[<DepNum[2]> <;> <DepName[3'+
'2]> <;> <OptionVATClass[1]> <;> <Price[1..11]> <;> <FlagsPrice[1]> <;> <Turnover[1..11]> <;> <SoldQuantity[1..11]> <;> <TurnoverMac[1..11]> <;> <SoldQuantityMac[1..11]> <;> <TurnoverSt[1..11]><;> <SoldQuantitySt[1..11]> <;> <TurnoverStMac[1..11]> <;> <Sol'+
'dQuantityStMac[1..11]> <;> <LastZReportNumber[1..5]> <;> <LastZReportDate"DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadDetailedReceiptInfoSending" CmdByte="0x5A"><FPOperation>Read info for enable/disable detailed receipts</F'+
'POperation><Args><Arg Name="Option" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''D'']> <;> <Option[''R'']> ]]></ArgsFormatRaw></Args><Response ACK="false"'+
'><Res Name="Option" Value="ZD" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionActivationRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value : - ''1'' - Yes -'+
' ''0'' - No</Desc></Res><ResFormatRaw><![CDATA[<Option[''ZD'']> <;> <ActivationRS[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDeviceModuleSupport" CmdByte="0x4E"><FPOperation>Provide an information about modules supported by the device</F'+
'POperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''D''><;><''D''> ]]></Arg'+
'sFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionLAN" Value="" Type="O'+
'ption" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for LAN suppor - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionWiFi" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Val'+
'ue="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for WiFi support - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionGPRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Opti'+
'ons><Desc>1 symbol for GPRS support - ''0'' - No  - ''1'' - Yes BT (Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionBT" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Nam'+
'e="Yes" Value="1" /></Options><Desc>(Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''D''><;><''D''><;><LAN[1]><;><WiFi[1]><;><GPRS[1]><;><BT[1]>]]></ResFormatRaw></Response></Command><C'+
'ommand Name="ReadDeviceModuleSupportByFirmware" CmdByte="0x4E"><FPOperation>Provide an information about modules supported by device''s firmware</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="Opt'+
'ionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''D''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name'+
'="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionLAN" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 sy'+
'mbol for LAN suppor - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionWiFi" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for WiFi support - ''0'' - No  - ''1'' - Ye'+
's</Desc></Res><Res Name="OptionGPRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for GPRS support - ''0'' - No  - ''1'' - Yes BT (Bluetooth) 1 symbol for Bluetooth suppor'+
't - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionBT" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</'+
'Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''D''><;><''S''><;><LAN[1]><;><WiFi[1]><;><GPRS[1]><;><BT[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDHCP_Status" CmdByte="0x4E"><FPOperation>Provides information about device''s DHCP status</'+
'FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''T''><;><''1''> ]]></Ar'+
'gsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionDhcpStatus" Value=""'+
' Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>(DHCP Status) 1 symbol for device''s DHCP status - ''0'' - Disabled  - ''1'' - Enabled</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><'+
'''T''><;><''1''><;><DhcpStatus[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDisplayGreetingMessage" CmdByte="0x69"><FPOperation>Provide information about the display greeting message.</FPOperation><Args><Arg Name="" Value="0" Type="OptionH'+
'ardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''0''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><Res Name="DisplayGreetingText" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for greeti'+
'ng message</Desc></Res><ResFormatRaw><![CDATA[<''0''> <;> <DisplayGreetingText[20]>]]></ResFormatRaw></Response></Command><Command Name="ReadEJ" CmdByte="0x7C"><FPOperation>Read Electronic Journal report with all documents.</FPOperation><Args><Arg Name=""'+
' Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''J0''> <;> <''*''> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByDate'+
'" CmdByte="0x7C"><FPOperation>Read Electronic Journal Report from Report initial date to report Final date.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name'+
'="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in th'+
'e DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[<''J0''> <;> <''D''> <;> <StartRepFromDate"DDMMYY"> <;> <EndRepFromDate"DDMMYY"> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByReceiptNumFromZrep" CmdB'+
'yte="0x7C"><FPOperation>Read Electronic Journal Report from receipt number to receipt number.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ZrepNum" Val'+
'ue="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for Z report number in format ####</Desc></Arg><Arg Name="StartReceiptNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000"><Desc>6 symbols for initial receipt number '+
'in format ######</Desc></Arg><Arg Name="EndReceiptNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000"><Desc>6 symbols for final receipt number in format ######</Desc></Arg><ArgsFormatRaw><![CDATA[<''J0''><;><''N''><;><ZrepNum[4]><;> <Start'+
'ReceiptNum[6]><;><EndReceiptNum[6]> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByStornoNumFromZrep" CmdByte="0x7C"><FPOperation>Read Electronic Journal Report from receipt number to receipt number.</FPO'+
'peration><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="n" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ZrepNum" Value="" Type="Text" MaxLen="4"><Desc>4 symbols for Z report number</Desc></Arg><Arg Name="StartRecei'+
'ptNum" Value="" Type="Text" MaxLen="6"><Desc>5 symbols for initial daily Storno receipt number</Desc></Arg><Arg Name="EndReceiptNum" Value="" Type="Text" MaxLen="6"><Desc>5 symbols for final daily Storno receipt number</Desc></Arg><ArgsFormatRaw><![CDATA['+
' <''J0''><;><''n''><;><ZrepNum[4]><;><StartReceiptNum[6]> <;><EndReceiptNum[6]> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByZBlocks" CmdByte="0x7C"><FPOperation>Read Electronic Journal Report from by n'+
'umber of Z report blocks.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 '+
'symbols for initial number report in format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number report in format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <''J0''> <;> <''Z''> '+
'<;> <StartZNum[4]> <;> <EndZNum[4]> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadExternalDisplay" CmdByte="0x57"><FPOperation>Select type of display</FPOperation><Args><Arg Name="Option" Value="E" Type="Opt'+
'ionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''E'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="E" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionExternalType" Value="" Type="Option" MaxLen="1"><Options>'+
'<Option Name="Others" Value="0" /><Option Name="Tremol display" Value="1" /></Options><Desc>1 symbol with value:  -''1'' -Tremol display  -''0'' - Others</Desc></Res><ResFormatRaw><![CDATA[<Option[''E'']> <;> <ExternalType[1]>]]></ResFormatRaw></Response>'+
'</Command><Command Name="ReadFMcontent" CmdByte="0x75"><FPOperation>Provides consequently information about every single block stored in the FM starting with Acknowledgements and ending with end message.</FPOperation><Response ACK="true" ACK_PLUS="true" /'+
'></Command><Command Name="ReadFMfreeRecords" CmdByte="0x74"><FPOperation>Read the number of the remaining free records for Z-report in the Fiscal Memory.</FPOperation><Response ACK="false"><Res Name="FreeFMrecords" Value="" Type="Text" MaxLen="4"><Desc>4 '+
'symbols for the number of free records for Z-report in the FM</Desc></Res><ResFormatRaw><![CDATA[<FreeFMrecords[4]>]]></ResFormatRaw></Response></Command><Command Name="ReadFooter" CmdByte="0x69"><FPOperation>Provides the content of the footer lines.</FPO'+
'peration><Args><Arg Name="OptionFooterLine" Value="" Type="Option" MaxLen="2"><Options><Option Name="Footer 1" Value="F1" /><Option Name="Footer 2" Value="F2" /><Option Name="Footer 3" Value="F3" /></Options><Desc>1 symbol with value:  - ''F1'' - Footer 1'+
'  - ''F2'' - Footer 2  - ''F3'' - Footer 3</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionFooterLine[2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionFooterLine" Value="" Type="Option" MaxLen="2"><Options><Option Name="Footer 1" Value="F1'+
'" /><Option Name="Footer 2" Value="F2" /><Option Name="Footer 3" Value="F3" /></Options><Desc>(Line Number)1 symbol with value:  - ''F1'' - Footer 1  - ''F2'' - Footer 2  - ''F3'' - Footer 3</Desc></Res><Res Name="FooterText" Value="" Type="Text" MaxLen="'+
'64"><Desc>TextLength symbols for footer line</Desc></Res><ResFormatRaw><![CDATA[<OptionFooterLine[2]> <;> <FooterText[TextLength]>]]></ResFormatRaw></Response></Command><Command Name="ReadGeneralDailyRegisters" CmdByte="0x6E"><FPOperation>Provides informa'+
'tion about the number of customers (number of fiscal receipt issued), number of discounts, additions and corrections made and the accumulated amounts.</FPOperation><Args><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <'+
'''1''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="FiscalReciept" Value="" Type="Decimal" MaxLen="5"><Desc>1..5 symbols for daily number of fiscal receipts</Desc></Res><Res Name="St'+
'ornoReciept" Value="" Type="Decimal" MaxLen="5"><Desc>1..5 symbols for daily number of Storno receipts</Desc></Res><Res Name="DiscountsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of discounts</Desc></Res><Res Name="DiscountsAm'+
'ount" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for accumulated amount of discounts</Desc></Res><Res Name="AdditionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of additions</Desc></Res><Res Name="AdditionsAmou'+
'nt" Value="" Type="Decimal" MaxLen="11"><Desc>Up to 11 symbols for accumulated amount of additions</Desc></Res><ResFormatRaw><![CDATA[<''1''> <;> < FiscalReciept [1..5]> <;> < StornoReciept[1..5]> <;> <DiscountsNum[1..5]> <;> <DiscountsAmount[1..11]> <;> '+
'<AdditionsNum[1..5]> <;> <AdditionsAmount[1..11]> <;>]]></ResFormatRaw></Response></Command><Command Name="ReadGPRS_APN" CmdByte="0x4E"><FPOperation>Provides information about device''s GRPS APN.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardc'+
'oded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''A''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Valu'+
'e="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_APN_Len" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for '+
'the APN length</Desc></Res><Res Name="APN" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS APN</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''A''><;><GPRS_APN_Len[1..3]><;><APN[100]>]]></ResFormatRaw></Response>'+
'</Command><Command Name="ReadGPRS_Password" CmdByte="0x4E"><FPOperation>Provides information about device''s GPRS password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen='+
'"1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''P''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="O'+
'ptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the GPRS password length</Desc></Res><Res Name="Password" Value="" Type="T'+
'ext" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS password</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadGPRS_Signal" CmdByte="'+
'0x4E"><FPOperation>Provides information about device''s GPRS signal.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" Max'+
'Len="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Typ'+
'e="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_Signal" Value="" Type="Text" MaxLen="3"><Desc>(Signal) 3 symbols for the GPRS signal</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''S''><;><GPRS_Signal[3]]]></ResFormatRaw></Response></Command><C'+
'ommand Name="ReadGPRS_Username" CmdByte="0x4E"><FPOperation>Provides information about device''s GPRS username.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg N'+
'ame="" Value="U" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''U''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="OptionHardcod'+
'ed" MaxLen="1" /><Res Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_User_Len" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the GPRS username length</Desc></Res><Res Name="Username" Value="" Type="Text" MaxL'+
'en="100"><Desc>Up to 100 symbols for the device''s GPRS username</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''U''><;><GPRS_User_Len[1..3]><;><Username[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadHeader" CmdByte="0x69"><FPOp'+
'eration>Provides the content of the header lines.</FPOperation><Args><Arg Name="OptionHeaderLine" Value="" Type="Option" MaxLen="1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Name="Header 3" Value="3" /><Optio'+
'n Name="Header 4" Value="4" /><Option Name="Header 5" Value="5" /><Option Name="Header 6" Value="6" /><Option Name="ID number" Value="7" /><Option Name="VAT number" Value="8" /></Options><Desc>1 byte with value:  - ''1'' - Header 1  - ''2'' - Header 2  - '+
'''3'' - Header 3  - ''4'' - Header 4  - ''5'' - Header 5  - ''6'' - Header 6  - ''7'' - ID number  - ''8'' - VAT number</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionHeaderLine[1]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionHeaderLine"'+
' Value="" Type="Option" MaxLen="1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Name="Header 3" Value="3" /><Option Name="Header 4" Value="4" /><Option Name="Header 5" Value="5" /><Option Name="Header 6" Value="'+
'6" /><Option Name="ID number" Value="7" /><Option Name="VAT number" Value="8" /></Options><Desc>(Line Number)1 byte with value:  - ''1'' - Header 1  - ''2'' - Header 2  - ''3'' - Header 3  - ''4'' - Header 4  - ''5'' - Header 5  - ''6'' - Header 6  - ''7'+
''' - ID number  - ''8'' - VAT number</Desc></Res><Res Name="HeaderText" Value="" Type="Text" MaxLen="64"><Desc>TextLength symbols</Desc></Res><ResFormatRaw><![CDATA[<OptionHeaderLine[1]> <;><HeaderText[TextLength]>]]></ResFormatRaw></Response></Command><C'+
'ommand Name="ReadKeyServerAddress" CmdByte="0x4E"><FPOperation>Provides key for server address.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="K"'+
' Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''S''><;><''K''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /'+
'><Res Name="" Value="K" Type="OptionHardcoded" MaxLen="1" /><Res Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Res><Res Name="Address" Value="" Type="Text" MaxLen="60"><Desc>60 symbols for address'+
'</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''S''><;><''K''><;><ParamLength[1..3]> <;><Address[60]>]]></ResFormatRaw></Response></Command><Command Name="ReadLastDailyReportInfo" CmdByte="0x73"><FPOperation>Read date and number of last Z-report and last'+
' RAM reset event.</FPOperation><Response ACK="false"><Res Name="LastZDailyReportDate" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy"><Desc>10 symbols for last Z-report date in DD-MM-YYYY format</Desc></Res><Res Name="LastZDailyReportNum" Value="'+
'" Type="Decimal" MaxLen="4"><Desc>Up to 4 symbols for the number of the last daily report</Desc></Res><Res Name="LastRAMResetNum" Value="" Type="Decimal" MaxLen="4"><Desc>Up to 4 symbols for the number of the last RAM reset</Desc></Res><ResFormatRaw><![CD'+
'ATA[<LastZDailyReportDate "DD-MM-YYYY"> <;> <LastZDailyReportNum[1..4]> <;> <LastRAMResetNum[1..4]>]]></ResFormatRaw></Response></Command><Command Name="ReadLastReceiptNum" CmdByte="0x71"><FPOperation>Provides information about the number of the last issu'+
'ed receipt.</FPOperation><Response ACK="false"><Res Name="LastReceiptNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000 for the number of last issued fiscal receipt"><Desc>Up to 4 symbols in format #### for the number of last issued fiscal r'+
'eceipt</Desc></Res><Res Name="LastStornoNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000 for the number of last issued Storno receipt"><Desc>Up to 4 symbols in format #### for the number of last issued Storno receipt</Desc></Res><ResFormat'+
'Raw><![CDATA[<LastReceiptNum[1..4]> <;> <LastStornoNum[1..4]>]]></ResFormatRaw></Response></Command><Command Name="ReadOperatorNamePassword" CmdByte="0x6A"><FPOperation>Provides information about an operator''s name and password.</FPOperation><Args><Arg N'+
'ame="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to the number of operator</Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Number" Value="" Type="Decimal'+
'" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to the number of operator</Desc></Res><Res Name="Name" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for operator''s name</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="4"><Desc>4 sym'+
'bols for operator''s password</Desc></Res><ResFormatRaw><![CDATA[<Number[1..2]> <;> <Name[20]> <;> <Password[4]>]]></ResFormatRaw></Response></Command><Command Name="ReadParameters" CmdByte="0x65"><FPOperation>Provides information about the programmed num'+
'ber of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt.</FPOperation><Response ACK="false"><Res Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>(POS Number) 4 sy'+
'mbols for number of POS in format ####</Desc></Res><Res Name="OptionPrintLogo" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Print Logo) 1 symbol of value:  - ''1'' - Yes  - ''0'' '+
'- No</Desc></Res><Res Name="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Auto Open Drawer) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res N'+
'ame="OptionAutoCut" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Auto Cut) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionExternalDispManagement" Val'+
'ue="" Type="Option" MaxLen="1"><Options><Option Name="Auto" Value="0" /><Option Name="Manual" Value="1" /></Options><Desc>(External Display Management) 1 symbol of value:  - ''1'' - Manual  - ''0'' - Auto</Desc></Res><Res Name="OptionReceiptSend" Value=""'+
' Type="Option" MaxLen="1"><Options><Option Name="Automatic sending" Value="1" /><Option Name="Without sending" Value="0" /></Options><Desc>1 symbol of value: - ''1'' - Automatic sending - ''0'' - Without sending</Desc></Res><Res Name="OptionEnableCurrency'+
'" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Enable Currency) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionWorkOperatorCount" Value="" Type="Opti'+
'on" MaxLen="1"><Options><Option Name="More" Value="0" /><Option Name="One" Value="1" /></Options><Desc>(Work Operator Count) 1 symbol of value:  - ''1'' - One  - ''0'' - More</Desc></Res><ResFormatRaw><![CDATA[<POSNum[4]> <;> <PrintLogo[1]> <;> <AutoOpenD'+
'rawer[1]> <;> <AutoCut[1]> <;> <ExternalDispManagement[1]> <;><ReceiptSend[1]> <;> <EnableCurrency[1]> <;> <WorkOperatorCount[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadPayments" CmdByte="0x64"><FPOperation>Provides information about all'+
' programmed payment types, currency name and exchange rate.</FPOperation><Response ACK="false"><Res Name="NamePaym0" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for type 0 of payment name</Desc></Res><Res Name="NamePaym1" Value="" Type="Text" MaxLen'+
'="10"><Desc>10 symbols for type 1 of payment name</Desc></Res><Res Name="NamePaym2" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for type 2 of payment name</Desc></Res><Res Name="NamePaym3" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for type 3'+
' of payment name</Desc></Res><Res Name="NamePaym4" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for type 4 of payment name</Desc></Res><Res Name="ExchangeRate" Value="" Type="Decimal_with_format" MaxLen="10" Format="0000.00000"><Desc>10 symbols for e'+
'xchange rate of payment type 4 in format: ####.#####</Desc></Res><ResFormatRaw><![CDATA[<NamePaym0[10]> <;> <NamePaym1[10]> <;> <NamePaym2[10]> <;> <NamePaym3[10]> <;> <NamePaym4[10]> <;> <ExchangeRate[10]>]]></ResFormatRaw></Response></Command><Command N'+
'ame="ReadPLUbarcode" CmdByte="0x6B"><FPOperation>Provides information about the barcode of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with l'+
'eading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''3'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_wi'+
'th_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><Res Name="Barcode" Value="" Type="Text" MaxLen="13"><Desc>13 symbols '+
'for article barcode</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;><Option[''3'']><;><Barcode[13]>]]></ResFormatRaw></Response></Command><Command Name="ReadPLUgeneral" CmdByte="0x6B"><FPOperation>Provides information about the general registers of the s'+
'pecified.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="1" Type="OptionHardcoded" MaxLen="1'+
'" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;> <Option[''1'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format:'+
' #####</Desc></Res><Res Name="Option" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="PLUName" Value="" Type="Text" MaxLen="32"><Desc>32 symbols for article name</Desc></Res><Res Name="Price" Value="" Type="Decimal" MaxLen="11"><Desc>1..10 symbol'+
's for article price</Desc></Res><Res Name="FlagsPriceQty" Value="" Type="Flags" MaxLen="1"><Desc>(Setting price, quantity, type of goods) 1 symbols with value: Flags.7=1 Flags.6=0 Flags.5=0 Flags.4=1 Yes, Flags.4=0 No (Macedonian goods) Flags.3=1 Yes, Fla'+
'gs.3=0 No (Allow negative) Flags.2=1 Yes, Flags.2=0 No (Monitoring quantity in stock) Flags.1=1 Yes, Flags.1=0 No (Free price limited) Flags.0=1 Yes, Flags.0=0 No (Free price enabled)</Desc></Res><Res Name="BelongToDepNumber" Value="" Type="Decimal_plus_8'+
'0h" MaxLen="2"><Desc>BelongToDepNo + 80h, 1 symbol for PLU department = 0x80 … 0x93</Desc></Res><Res Name="AvailableQuantity" Value="" Type="Text" MaxLen="1"><Desc>Up to11 symbols for quantity in stock</Desc></Res><Res Name="Barcode" Value="" Type="Text" '+
'MaxLen="13"><Desc>13 symbols for article barcode</Desc></Res><Res Name="TurnoverAmount" Value="" Type="Text" MaxLen="11"><Desc>Up to 11symbols for PLU accumulated turnover</Desc></Res><Res Name="SoldQuantity" Value="" Type="Text" MaxLen="11"><Desc>Up to 1'+
'1 symbols for Sales quantity of the article</Desc></Res><Res Name="StornoTurnover" Value="" Type="Text" MaxLen="11"><Desc>Up to 11 symbols for accumulated Storno turnover</Desc></Res><Res Name="StornoQuantity" Value="" Type="Text" MaxLen="11"><Desc>Up to '+
'11 symbols for accumulated Storno quantiy</Desc></Res><Res Name="LastZReportNumber" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the number of the last article report with zeroing</Desc></Res><Res Name="LastZReportDate" Value="" Type="Date'+
'Time" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for the date and time of the last article report with zeroing in format DD-MM-YYYY HH:MM</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]> <;> <Option[''1'']> <;> <PLUName[32]> <;> <Price[1..11]> <'+
';> <FlagsPriceQty[1]> <;> <BelongToDepNumber[1]> <;> <AvailableQuantity[1]> <;> <Barcode[13]> <;> <TurnoverAmount[11]> <;> <SoldQuantity[11]> <;> <StornoTurnover[11]> <;> <StornoQuantity [11]> <;> <LastZReportNumber[1..5]> <;> <LastZReportDate "DD-MM-YYYY'+
' HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadPLUprice" CmdByte="0x6B"><FPOperation>Provides information about the price and price type of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format"'+
' MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="4" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''4'']> ]]></ArgsFormatRaw></Arg'+
's><Response ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="4" Type="OptionHardcoded" MaxLen="1" /><R'+
'es Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1..10 symbols for article price</Desc></Res><Res Name="OptionPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price is disable valid only programmed price" Value="0" /><Option N'+
'ame="Free price is enable" Value="1" /><Option Name="Limited price" Value="2" /></Options><Desc>1 byte for Price flag with next value:  - ''0''- Free price is disable valid only programmed price  - ''1''- Free price is enable  - ''2''- Limited price</Desc'+
'></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;><Option[''4'']><;><Price[1..10]><;><OptionPrice[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadPLUqty" CmdByte="0x6B"><FPOperation>Provides information about the quantity registers of the specified'+
' article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="2" Type="OptionHardcoded" MaxLen="1'+
'" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;> <Option[''2'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format '+
'#####</Desc></Res><Res Name="Option" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="AvailableQuantity" Value="" Type="Decimal" MaxLen="13"><Desc>Up to13 symbols for quantity in stock</Desc></Res><Res Name="OptionQuantityType" Value="" Type="Opti'+
'on" MaxLen="1"><Options><Option Name="Availability of PLU stock is not monitored" Value="0" /><Option Name="Disable negative quantity" Value="1" /><Option Name="Enable negative quantity" Value="2" /></Options><Desc>1 symbol for Quantity flag with next val'+
'ue:  - ''0''- Availability of PLU stock is not monitored  - ''1''- Disable negative quantity  - ''2''- Enable negative quantity</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]> <;> <Option[''2'']> <;> <AvailableQuantity[1..13]> <;> <OptionQuantityType[1]>]]'+
'></ResFormatRaw></Response></Command><Command Name="ReadRegisterServerAddress" CmdByte="0x4E"><FPOperation>Provides information about register server address.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value'+
'="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''S''><;><''R''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="'+
'1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Res><Res Name="Address'+
'" Value="" Type="Text" MaxLen="60"><Desc>60 symbols for address</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''S''><;><''R''><;><ParamLength[1..3]> <;><Address[60]>]]></ResFormatRaw></Response></Command><Command Name="ReadRegistrationInfo" CmdByte="0x61"'+
'><FPOperation>Provides information about the owner''s numbers and registration date time.</FPOperation><Response ACK="false"><Res Name="IDNum" Value="" Type="Text" MaxLen="13"><Desc>13 symbols owner''s ID number (ЕДБ)</Desc></Res><Res Name="VATNum" Value='+
'"" Type="Text" MaxLen="15"><Desc>15 symbols for owner''s VAT registration number (ДДВ)</Desc></Res><Res Name="RegistrationNumber" Value="" Type="Text" MaxLen="6"><Desc>Register number on the Fiscal device by registration</Desc></Res><Res Name="Registratio'+
'nDate" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>Date of registration</Desc></Res><ResFormatRaw><![CDATA[<IDNum[13]> <;> <VATNum[15]> <;> <RegistrationNumber[6]><;> <RegistrationDate "DD-MM-YYYY HH:MM" >]]></ResFormatRaw></Respo'+
'nse></Command><Command Name="ReadSerialAndFiscalNums" CmdByte="0x60"><FPOperation>Provides information about the manufacturing number of the fiscal device, FM number and ECR Unique number.</FPOperation><Response ACK="false"><Res Name="SerialNumber" Value='+
'"" Type="Text" MaxLen="11"><Desc>11 symbols for individual number of the fiscal device</Desc></Res><Res Name="FMNumber" Value="" Type="Text" MaxLen="11"><Desc>11 symbols for individual number of the fiscal memory</Desc></Res><Res Name="ECR_UniqueNum" Valu'+
'e="" Type="Text" MaxLen="24"><Desc>24 symbols for ECR unique number</Desc></Res><ResFormatRaw><![CDATA[<SerialNumber[11]> <;> <FMNumber[11]> <;> <ECR_UniqueNum[24]>]]></ResFormatRaw></Response></Command><Command Name="ReadServerAddress" CmdByte="0x4E"><FP'+
'Operation>Provides information about server address.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsF'+
'ormatRaw><![CDATA[ <''R''><;><''S''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcod'+
'ed" MaxLen="1" /><Res Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Res><Res Name="Address" Value="" Type="Text" MaxLen="60"><Desc>60 symbols for address</Desc></Res><ResFormatRaw><![CDATA[<''R''>'+
'<;><''S''><;><''S''><;><ParamLength[1..3]> <;><Address[60]>]]></ResFormatRaw></Response></Command><Command Name="ReadServiceMode" CmdByte="0x5A"><FPOperation>Read Service mode status</FPOperation><Args><Arg Name="Option" Value="S" Type="OptionHardcoded" M'+
'axLen="1" /><Arg Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''S'']> <;> <Option[''R'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="ZS" Type="OptionHardcoded" MaxLen="1" /><Re'+
's Name="OptionServiceMode" Value="" Type="Option" MaxLen="1"><Options><Option Name="Sales mode" Value="0" /><Option Name="Service mode" Value="1" /></Options><Desc>1 symbol:  -''1'' - Service mode -''0'' - Sales mode</Desc></Res><ResFormatRaw><![CDATA[<Op'+
'tion[''ZS'']> <;> <ServiceMode[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadShortReceiptSending" CmdByte="0x5A"><FPOperation>Read info for enable/disable short receipts</FPOperation><Args><Arg Name="Option" Value="F" Type="OptionHardcoded"'+
' MaxLen="1" /><Arg Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''F'']> <;> <Option[''R'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="ZF" Type="OptionHardcoded" MaxLen="1" /><'+
'Res Name="OptionActivationRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value : - ''1'' - Yes - ''0'' - No</Desc></Res><ResFormatRaw><![CDATA[<Option[''ZF'']> <;> '+
'<ActivationRS[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadStatus" CmdByte="0x20"><FPOperation>Provides detailed 7-byte information about the current status of the fiscal device.</FPOperation><Response ACK="false"><Res Name="FM_Read_only" '+
'Value="" Type="Status" Byte="0" Bit="0"><Desc>FM Read only</Desc></Res><Res Name="Power_down_in_opened_fiscal_receipt" Value="" Type="Status" Byte="0" Bit="1"><Desc>Power down in opened fiscal receipt</Desc></Res><Res Name="Printer_not_ready_overheat" Val'+
'ue="" Type="Status" Byte="0" Bit="2"><Desc>Printer not ready - overheat</Desc></Res><Res Name="DateTime_not_set" Value="" Type="Status" Byte="0" Bit="3"><Desc>DateTime not set</Desc></Res><Res Name="DateTime_wrong" Value="" Type="Status" Byte="0" Bit="4">'+
'<Desc>DateTime wrong</Desc></Res><Res Name="RAM_reset" Value="" Type="Status" Byte="0" Bit="5"><Desc>RAM reset</Desc></Res><Res Name="Hardware_clock_error" Value="" Type="Status" Byte="0" Bit="6"><Desc>Hardware clock error</Desc></Res><Res Name="Printer_n'+
'ot_ready_no_paper" Value="" Type="Status" Byte="1" Bit="0"><Desc>Printer not ready - no paper</Desc></Res><Res Name="Reports_registers_Overflow" Value="" Type="Status" Byte="1" Bit="1"><Desc>Reports registers Overflow</Desc></Res><Res Name="Blocking_after'+
'_24_hours_without_report" Value="" Type="Status" Byte="1" Bit="2"><Desc>Blocking after 24 hours without report</Desc></Res><Res Name="Daily_report_is_not_zeroed" Value="" Type="Status" Byte="1" Bit="3"><Desc>Daily report is not zeroed</Desc></Res><Res Nam'+
'e="Article_report_is_not_zeroed" Value="" Type="Status" Byte="1" Bit="4"><Desc>Article report is not zeroed</Desc></Res><Res Name="Operator_report_is_not_zeroed" Value="" Type="Status" Byte="1" Bit="5"><Desc>Operator report is not zeroed</Desc></Res><Res '+
'Name="Non_printed_copy" Value="" Type="Status" Byte="1" Bit="6"><Desc>Non-printed copy</Desc></Res><Res Name="Opened_Non_fiscal_Receipt" Value="" Type="Status" Byte="2" Bit="0"><Desc>Opened Non-fiscal Receipt</Desc></Res><Res Name="Opened_Fiscal_Receipt" '+
'Value="" Type="Status" Byte="2" Bit="1"><Desc>Opened Fiscal Receipt</Desc></Res><Res Name="fiscal_receipt_type_1" Value="" Type="Status" Byte="2" Bit="2"><Desc>fiscal receipt type 1</Desc></Res><Res Name="fiscal_receipt_type_2" Value="" Type="Status" Byte'+
'="2" Bit="3"><Desc>fiscal receipt type 2</Desc></Res><Res Name="fiscal_receipt_type_3" Value="" Type="Status" Byte="2" Bit="4"><Desc>fiscal receipt type 3</Desc></Res><Res Name="SD_card_near_full" Value="" Type="Status" Byte="2" Bit="5"><Desc>SD card near'+
' full</Desc></Res><Res Name="SD_card_full" Value="" Type="Status" Byte="2" Bit="6"><Desc>SD card full</Desc></Res><Res Name="No_FM_module" Value="" Type="Status" Byte="3" Bit="0"><Desc>No FM module</Desc></Res><Res Name="FM_error" Value="" Type="Status" B'+
'yte="3" Bit="1"><Desc>FM error</Desc></Res><Res Name="FM_full" Value="" Type="Status" Byte="3" Bit="2"><Desc>FM full</Desc></Res><Res Name="FM_near_full" Value="" Type="Status" Byte="3" Bit="3"><Desc>FM near full</Desc></Res><Res Name="Decimal_point" Valu'+
'e="" Type="Status" Byte="3" Bit="4"><Desc>Decimal point (1=fract, 0=whole)</Desc></Res><Res Name="FM_fiscalized" Value="" Type="Status" Byte="3" Bit="5"><Desc>FM fiscalized</Desc></Res><Res Name="FM_produced" Value="" Type="Status" Byte="3" Bit="6"><Desc>'+
'FM produced</Desc></Res><Res Name="Printer_automatic_cutting" Value="" Type="Status" Byte="4" Bit="0"><Desc>Printer: automatic cutting</Desc></Res><Res Name="External_display_transparent_display" Value="" Type="Status" Byte="4" Bit="1"><Desc>External disp'+
'lay: transparent display</Desc></Res><Res Name="Missing_display" Value="" Type="Status" Byte="4" Bit="3"><Desc>Missing display</Desc></Res><Res Name="Drawer_automatic_opening" Value="" Type="Status" Byte="4" Bit="4"><Desc>Drawer: automatic opening</Desc><'+
'/Res><Res Name="Customer_logo_included_in_the_receipt" Value="" Type="Status" Byte="4" Bit="5"><Desc>Customer logo included in the receipt</Desc></Res><Res Name="Blocking_after_10_days_without_communication" Value="" Type="Status" Byte="4" Bit="6"><Desc>B'+
'locking after 10 days without communication</Desc></Res><Res Name="Wrong_SIM_card" Value="" Type="Status" Byte="5" Bit="0"><Desc>Wrong SIM card</Desc></Res><Res Name="Wrong_SD_card" Value="" Type="Status" Byte="5" Bit="5"><Desc>Wrong SD card</Desc></Res><'+
'Res Name="No_SIM_card" Value="" Type="Status" Byte="6" Bit="0"><Desc>No SIM card</Desc></Res><Res Name="No_GPRS_Modem" Value="" Type="Status" Byte="6" Bit="1"><Desc>No GPRS Modem</Desc></Res><Res Name="No_mobile_operator" Value="" Type="Status" Byte="6" B'+
'it="2"><Desc>No mobile operator</Desc></Res><Res Name="No_GPRS_service" Value="" Type="Status" Byte="6" Bit="3"><Desc>No GPRS service</Desc></Res><Res Name="Near_end_of_paper" Value="" Type="Status" Byte="6" Bit="4"><Desc>Near end of paper</Desc></Res><Re'+
'sFormatRaw><![CDATA[<StatusBytes[7]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_Addresses" CmdByte="0x4E"><FPOperation>Provides information about device''s IP address, subnet mask, gateway address, DNS address.</FPOperation><Args><Arg Na'+
'me="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionAddressType" Value="" Type="Option" MaxLen="1"><Options><Option Name="DNS address" Value="5" /><Option Name="Gateway address" V'+
'alue="4" /><Option Name="IP address" Value="2" /><Option Name="Subnet Mask" Value="3" /></Options><Desc>1 symbol with value:  - ''2'' - IP address  - ''3'' - Subnet Mask  - ''4'' - Gateway address  - ''5'' - DNS address</Desc></Arg><ArgsFormatRaw><![CDATA'+
'[ <''R''><;><''T''><;><AddressType[1]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionAddressType" Value="" Type="Optio'+
'n" MaxLen="1"><Options><Option Name="DNS address" Value="5" /><Option Name="Gateway address" Value="4" /><Option Name="IP address" Value="2" /><Option Name="Subnet Mask" Value="3" /></Options><Desc>(Address) 1 symbol with value:  - ''2'' - IP address  - '+
'''3'' - Subnet Mask  - ''4'' - Gateway address  - ''5'' - DNS address</Desc></Res><Res Name="DeviceAddress" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for the device''s addresses</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''T''><;>< AddressType['+
'1]><;><DeviceAddress[15]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_AutoStartStatus" CmdByte="0x4E"><FPOperation>Read device TCP Auto Start status</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="'+
'" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''2''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" M'+
'axLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionTCPAutoStart" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Va'+
'lue="1" /></Options><Desc>1 symbol for TCP auto start status - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''2''><;><TCPAutoStart[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_Password" CmdByte="0x4'+
'E"><FPOperation>Provides information about device''s TCP password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLe'+
'n="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''1''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="1" Type='+
'"OptionHardcoded" MaxLen="1" /><Res Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the password length</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the TCP password'+
'</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''1''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_UsedModule" CmdByte="0x4E"><FPOperation>Read the used TCP module for communication - Lan or'+
' WiFi</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''U''> '+
']]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionUsedModule" V'+
'alue="" Type="Option" MaxLen="1"><Options><Option Name="LAN" Value="1" /><Option Name="WiFi" Value="2" /></Options><Desc>(Module) 1 symbol with value:  - ''1'' - LAN  - ''2'' - WiFi</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''U''><;><UsedMod'+
'ule[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadTotalFiscalSums" CmdByte="0x6E"><FPOperation>Provides information about the total fiscal accumulative sums from sales and Storno</FPOperation><Args><Arg Name="" Value="7" Type="OptionHardcod'+
'ed" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''7''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="7" Type="OptionHardcoded" MaxLen="1" /><Res Name="SumSalesTurnover" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total grand sum of s'+
'ales turnover from fiscal registration</Desc></Res><Res Name="SumStornoTurnover" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total sum of Storno turnover from fiscal registration</Desc></Res><Res Name="SumSalesVAT" Value="" Type="Text" MaxLen="14"><D'+
'esc>14 s. for total VAT sum of sales from fiscal registration</Desc></Res><Res Name="SumStornoVAT" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total VAT sum of Storno from fiscal registration</Desc></Res><Res Name="SumMacSalesTurnover" Value="" Type='+
'"Text" MaxLen="14"><Desc>14 s. for total grand sum of maced. sales turnover from fiscal registration</Desc></Res><Res Name="SumMacStornoTurnover" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total sum of maced.Storno turnover from fiscal registration<'+
'/Desc></Res><Res Name="SumMacSalesVAT" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total VAT sum of maced.sales from fiscal registration</Desc></Res><Res Name="SumMacStornoVAT" Value="" Type="Text" MaxLen="14"><Desc>14 s. for total VAT sum of maced.S'+
'torno from fiscal registration</Desc></Res><ResFormatRaw><![CDATA[<''7''> <;> <SumSalesTurnover[14]> <;> <SumStornoTurnover[14]> <;> <SumSalesVAT[14]> <;> <SumStornoVAT[14]> <;> <SumMacSalesTurnover[14]> <;> <SumMacStornoTurnover[14]> <;> <SumMacSalesVAT['+
'14]> <;> <SumMacStornoVAT[14]>]]></ResFormatRaw></Response></Command><Command Name="ReadVATrates" CmdByte="0x62"><FPOperation>Provides information about the current VAT rates which are the last values stored into the FM.</FPOperation><Response ACK="false"'+
'><Res Name="VATrate0" Value="" Type="Decimal_with_format" MaxLen="7" Format="00.00%"><Desc>Value of VAT rate А from 7 symbols in format ##.##%</Desc></Res><Res Name="VATrate1" Value="" Type="Decimal_with_format" MaxLen="7" Format="00.00%"><Desc>Value of V'+
'AT rate Б from 7 symbols in format ##.##%</Desc></Res><Res Name="VATrate2" Value="" Type="Decimal_with_format" MaxLen="7" Format="00.00%"><Desc>Value of VAT rate В from 7 symbols in format ##.##%</Desc></Res><Res Name="VATrate3" Value="" Type="Decimal_wit'+
'h_format" MaxLen="7" Format="00.00%"><Desc>Value of VAT rate Г from 7 symbols in format ##.##%</Desc></Res><ResFormatRaw><![CDATA[<VATrate0[7]> <;> <VATrate1[7]> <;> <VATrate2[7]> <;> <VATrate3[7]>]]></ResFormatRaw></Response></Command><Command Name="Read'+
'Version" CmdByte="0x21"><FPOperation>Provides information about the device type, model name and version.</FPOperation><Response ACK="false"><Res Name="OptionDeviceType" Value="" Type="Option" MaxLen="1"><Options><Option Name="ECR" Value="1" /><Option Name'+
'="FPr" Value="2" /></Options><Desc>1 symbol for type of fiscal device: - ''1''- ECR - ''2''- FPr</Desc></Res><Res Name="Model" Value="" Type="Text" MaxLen="50"><Desc>Up to 50 symbols for Model name</Desc></Res><Res Name="Version" Value="" Type="Text" MaxL'+
'en="20"><Desc>Up to 20 symbols for Version name and Check sum</Desc></Res><ResFormatRaw><![CDATA[<DeviceType[1]> <;> <Model[50]> <;> <Version[20]>]]></ResFormatRaw></Response></Command><Command Name="ReadWiFi_NetworkName" CmdByte="0x4E"><FPOperation>Read '+
'device''s connected WiFi network name</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDA'+
'TA[ <''R''><;><''W''><;><''N''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="N" Type="OptionHardcoded" MaxLen="1" '+
'/><Res Name="WiFiNameLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the WiFi name length</Desc></Res><Res Name="WiFiNetworkName" Value="" Type="Text" MaxLen="100"><Desc>(Name) Up to 100 symbols for the device''s WiFi network'+
' name</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''W''><;><''N''><;><WiFiNameLength[1..3]><;><WiFiNetworkName[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadWiFi_Password" CmdByte="0x4E"><FPOperation>Read device''s connected WiFi networ'+
'k password</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><'+
'''P''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Name="PassLength" '+
'Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the WiFi password length</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s WiFi password</Desc></Res><ResFormatRaw><![CDATA[<'+
'''R''><;><''W''><;><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="Read_IdleTimeout" CmdByte="0x4E"><FPOperation>Provides information about device''s idle timeout. This timeout is seconds in which the co'+
'nnection will be closed when there is an inactivity. This information is available if the device has LAN or WiFi. Maximal value - 7200, minimal value 0. 0 is for never close the connection.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" '+
'MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="I" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''I''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" '+
'Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="I" Type="OptionHardcoded" MaxLen="1" /><Res Name="IdleTimeout" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols '+
'for password in format ####</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''I''><;><IdleTimeout[4]>]]></ResFormatRaw></Response></Command><Command Name="ReceivedOnAccount_PaidOut" CmdByte="0x3B"><FPOperation>Registers cash received on account or'+
' paid out.</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to the operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type="Text" MaxLen="4"><Desc>4 symbols for operator''s passwo'+
'rd</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Amount" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for the amount lodged/withdrawn</Desc></Arg><ArgsFormatRaw><![CDATA[<OperNum[1..2]> <;> <OperPa'+
'ss[4]> <;> <reserved[''0'']> <;> <Amount[1..10]> ]]></ArgsFormatRaw></Args></Command><Command Name="SaveNetworkSettings" CmdByte="0x4E"><FPOperation>After every change on Idle timeout, LAN/WiFi/GPRS usage, LAN/WiFi/TCP/GPRS password or TCP auto start netw'+
'orks settings this Save command needs to be execute.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''P''><;><''A''> ]]></ArgsFormatRaw></A'+
'rgs></Command><Command Name="ScanAndPrintWiFiNetworks" CmdByte="0x4E"><FPOperation>Scan and print all available WiFi networks</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLe'+
'n="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><''S''> ]]></ArgsFormatRaw></Args></Command><Command Name="SelectExternalDisplay" CmdByte="0x56"><FPOperation>Select type of display</FPOperati'+
'on><Args><Arg Name="Option" Value="E" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionExternalDisplay" Value="" Type="Option" MaxLen="1"><Options><Option Name="Others" Value="0" /><Option Name="Tremol display" Value="1" /></Options><Desc>1 symbol:  -'+
'''1'' - Tremol display -''0'' - Others</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option[''E'']> <;> <ExternalDisplay[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUfromDep" CmdByte="0x34"><FPOperation>Register the sell of department. Correction'+
' is forbidden!</FPOperation><Args><Arg Name="NamePLU" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for name of sale. 34 symbols are printed on paper.</Desc></Arg><Arg Name="DepNum" Value="" Type="Decimal_plus_80h" MaxLen="2"><Desc>1 symbol for articl'+
'e department attachment, formed in the following manner: DepNum[HEX] + 80h example: Dep01 = 81h, Dep02 = 82h … Dep19 = 93h</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for article''s price.</Desc></Arg><Arg Name'+
'="OptionGoodsType" Value="" Type="Option" MaxLen="1"><Options><Option Name="importation" Value="0" /><Option Name="macedonian goods" Value="1" /></Options><Desc>1 symbol with value:  - ''1'' - macedonian goods  - ''0'' - importation</Desc></Arg><Arg Name='+
'"Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for article''s quantity sold</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>Up to 7 for percen'+
'tage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="," /></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>Up to 8 symbols for percentage of discount/addition. Use'+
' minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=":" /></Arg><ArgsFormatRaw><![CDATA[ <NamePLU[36]> <;> <DepNum[1..2]> <;> <Price[1..10]> <;> <GoodsType[1]> {<''*''> <Quantity[1..10]>} {<'',''> <DiscAddP[1..7]'+
'>} {<'':''> <DiscAddV[1..8]>} ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUFromFD_DB" CmdByte="0x32"><FPOperation>Register the sell with specified quantity of article from the internal FD database. Correction is forbidden!</FPOperation><Args>'+
'<Arg Name="OptionSign" Value="" Type="Option" MaxLen="1"><Options><Option Name="Sale" Value="+" /></Options><Desc>1 symbol with optional value:  - ''+'' -Sale</Desc><Meta MinLen="1" Compulsory="true" NoSemiColumnSeparatorAfterIt="true" /></Arg><Arg Name="'+
'PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for PLU number of FD''s database in format #####</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="8"><Desc>Up to 10 symbols for sale price</Desc><Meta MinLe'+
'n="1" Compulsory="false" ValIndicatingPresence="$" /></Arg><Arg Name="Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for article''s quantity sold</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><Arg Name="'+
'DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>Up to 7 for percentage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="," /></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxL'+
'en="8"><Desc>Up to 8 symbolsfor percentage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=":" /></Arg><ArgsFormatRaw><![CDATA[ <OptionSign[1]> <PLUNum[5]> {<''$''> <Price[1..8]>} {<'+
'''*''> <Quantity[1..10]>} {<'',''> <DiscAddP[1..7]>} {<'':''> <DiscAddV[1..8]>} ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUwithSpecifiedVAT" CmdByte="0x31"><FPOperation>Register the sell of article with specified name, price, quantity, VAT '+
'class and/or discount/addition on the transaction. Correction is forbidden!</FPOperation><Args><Arg Name="NamePLU" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for article''s name</Desc></Arg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="'+
'1"><Options><Option Name="VAT Class 0" Value="А" /><Option Name="VAT Class 1" Value="Б" /><Option Name="VAT Class 2" Value="В" /><Option Name="VAT Class 3" Value="Г" /></Options><Desc>1 character for VAT class:  - ''А'' - VAT Class 0  - ''Б'' - VAT Class '+
'1  - ''В'' - VAT Class 2  - ''Г'' - VAT Class 3</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for article''s price.</Desc></Arg><Arg Name="OptionGoodsType" Value="" Type="Option" MaxLen="1"><Options><Option Name='+
'"importation" Value="0" /><Option Name="macedonian goods" Value="1" /></Options><Desc>1 symbol with value:  - ''1'' - macedonian goods  - ''0'' - importation</Desc></Arg><Arg Name="Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols for q'+
'uantity</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>Up to 7 symbols for percentage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1"'+
' Compulsory="false" ValIndicatingPresence="," /></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>Up to 8 symbols for value of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPr'+
'esence=":" /></Arg><ArgsFormatRaw><![CDATA[ <NamePLU[36]> <;> <OptionVATClass[1]> <;> <Price[1..10]><;> <GoodsType[1]> {<''*''> <Quantity[1..10]>} {<'',''> <DiscAddP[1..7]>} {<'':''> <DiscAddV[1..8]>} ]]></ArgsFormatRaw></Args></Command><Command Name="Set'+
'ActiveLogo" CmdByte="0x23"><FPOperation>Stores in the memory the graphic file under stated number. Prints information about loaded in the printer graphic files.</FPOperation><Args><Arg Name="LogoNumber" Value="" Type="Text" MaxLen="1"><Desc>1 character va'+
'lue from ''0'' to ''9'' or ''?''. The number sets the active logo number, and the ''?'' invokes only printing of information</Desc></Arg><ArgsFormatRaw><![CDATA[ <LogoNumber[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetBluetooth_Password" Cmd'+
'Byte="0x4E"><FPOperation>Program device''s Bluetooth password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value'+
'="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the BT password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the BT password'+
'</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''B''><;><''P''><;>< PassLength[1..3]><;><Password[100]>> ]]></ArgsFormatRaw></Args></Command><Command Name="SetBluetooth_Status" CmdByte="0x4E"><FPOperation>Program device''s Bluetooth module to be enabled'+
' or disabled. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name'+
'="OptionBTstatus" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - Disabled  - ''1'' - Enabled</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;>'+
'<''B''><;><''S''><;><BTstatus[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetDateTime" CmdByte="0x48"><FPOperation>Sets the date and time and prints out the current values.</FPOperation><Args><Arg Name="DateTime" Value="" Type="DateTime" MaxLen'+
'="10" Format="dd-MM-yy HH:mm:ss"><Desc>Date Time parameter in format: DD-MM-YY HH:MM:SS</Desc></Arg><ArgsFormatRaw><![CDATA[ <DateTime "DD-MM-YY HH:MM:SS"> ]]></ArgsFormatRaw></Args></Command><Command Name="SetDeviceTCP_Addresses" CmdByte="0x4E"><FPOperat'+
'ion>Program device''s network IP address, subnet mask, gateway address, DNS address. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1"'+
' /><Arg Name="OptionAddressType" Value="" Type="Option" MaxLen="1"><Options><Option Name="DNS address" Value="5" /><Option Name="Gateway address" Value="4" /><Option Name="IP address" Value="2" /><Option Name="Subnet Mask" Value="3" /></Options><Desc>1 sy'+
'mbol with value:  - ''2'' - IP address  - ''3'' - Subnet Mask  - ''4'' - Gateway address  - ''5'' - DNS address</Desc></Arg><Arg Name="DeviceAddress" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for the selected address</Desc></Arg><ArgsFormatRaw><!['+
'CDATA[ <''P''><;><''T''><;><AddressType[1]> <;><DeviceAddress[15]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetDHCP_Enabled" CmdByte="0x4E"><FPOperation>Program device''s TCP network DHCP enabled or disabled. To apply use -SaveNetworkSettings()<'+
'/FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionDHCPEnabled" Value="" Type="Option" MaxLen'+
'="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - Disabled  - ''1'' - Enabled</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''T''><;><''1''><;><DHCPEnabled[1]> ]]></ArgsF'+
'ormatRaw></Args></Command><Command Name="SetFiscalServerAddress" CmdByte="0x4E"><FPOperation>Programs key of server address.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen'+
'="1" /><Arg Name="" Value="K" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Arg><Arg Name="Address" Value="" Type="Text" MaxLen="60"><Desc>60 symbols for a'+
'ddress</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''S''><;><''K''><;><ParamLength[1..3]> <;><Address[60]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS_APN" CmdByte="0x4E"><FPOperation>Program device''s GPRS APN. To apply use - SaveNetwo'+
'rkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><Arg Name="GPRS_APN_Len" Value="" Type="Decima'+
'l" MaxLen="3"><Desc>Up to 3 symbols for the APN len</Desc></Arg><Arg Name="APN" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS APN</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''G''><;><''A''><;><GPRS_APN_Len[1..3]><;>'+
'<APN[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS_Password" CmdByte="0x4E"><FPOperation>Program device''s GPRS password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /'+
'><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the GPRS password len</Desc></Arg><Arg Name="Passwor'+
'd" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''G''><;><''P''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS'+
'_Username" CmdByte="0x4E"><FPOperation>Program device''s GPRS user name. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Nam'+
'e="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Arg Name="GPRS_Username_Len" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the username len</Desc></Arg><Arg Name="Username" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for t'+
'he device''s GPRS username</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''G''><;><''U''><;><GPRS_Username_Len[1..3]><;><Username[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetIDandVATnum" CmdByte="0x41"><FPOperation>Stores the VAT and ID '+
'numbers into the operative memory.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols string</Desc></Arg><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="IDNum" Value="" Type="Text" MaxLen="13"><De'+
'sc>13 symbols owner''s ID number</Desc></Arg><Arg Name="VATNum" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for owner''s VAT number</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]> <;> <''1''> <;> <IDNum[13]> <;> <VATNum[15]> ]]></ArgsFormatRaw></'+
'Args></Command><Command Name="SetIdle_Timeout" CmdByte="0x4E"><FPOperation>Sets device''s idle timeout setting. Set timeout for closing the connection if there is an inactivity. Maximal value - 7200, minimal value 0. 0 is for never close the connection. T'+
'his option can be used only if the device has LAN or WiFi. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="I"'+
' Type="OptionHardcoded" MaxLen="1" /><Arg Name="IdleTimeout" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for Idle timeout in format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''I''><;><IdleTimeout[4]> ]'+
']></ArgsFormatRaw></Args></Command><Command Name="SetRegisterServerAddress" CmdByte="0x4E"><FPOperation>Programs register server address.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHard'+
'coded" MaxLen="1" /><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Arg><Arg Name="Address" Value="" Type="Text" MaxLen="60"><Desc>60 '+
'symbols for address</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''S''><;><''R''><;><ParamLength[1..3]> <;><Address[60]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetServerAddress" CmdByte="0x4E"><FPOperation>Provides information about server '+
'address.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ParamLength" Value="" Type="Decimal" Ma'+
'xLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Arg><Arg Name="Address" Value="" Type="Text" MaxLen="60"><Desc>60 symbols for address</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''S''><;><''S''><;><ParamLength[1..3]> <;><Address[60]> ]]></'+
'ArgsFormatRaw></Args></Command><Command Name="SetTCPpassword" CmdByte="0x4E"><FPOperation>Program device''s TCP password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value'+
'="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" '+
'MaxLen="100"><Desc>Up to 100 symbols for the TCP password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''1''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetTCP_ActiveModule" CmdByte="0x4E"><FPOpe'+
'ration>Sets the used TCP module for communication - Lan or WiFi. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Valu'+
'e="U" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionUsedModule" Value="" Type="Option" MaxLen="1"><Options><Option Name="LAN" Value="1" /><Option Name="WiFi" Value="2" /></Options><Desc>1 symbol with value:  - ''1'' - LAN  - ''2'' - WiFi</Desc></Ar'+
'g><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''U''><;><UsedModule[1]><;> ]]></ArgsFormatRaw></Args></Command><Command Name="SetTCP_AutoStart" CmdByte="0x4E"><FPOperation>Set device''s TCP autostart . To apply use -SaveNetworkSettings()</FPOperation><Ar'+
'gs><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionTCPAutoStart" Value="" Type="Option" MaxLen="1"><Options><'+
'Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - No  - ''1'' - Yes</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''2''><;><TCPAutoStart[1]> ]]></ArgsFormatRaw></Args></Command><Command'+
' Name="SetWiFi_NetworkName" CmdByte="0x4E"><FPOperation>Program device''s WiFi network name where it will connect. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Typ'+
'e="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="WiFiNameLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the WiFi network name len</Desc></Arg><Arg Name="WiFiNetworkName" Value="" '+
'Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s WiFi ssid network name</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''W''><;><''N''><;><WiFiNameLength[1..3]><;><WiFiNetworkName[100]> ]]></ArgsFormatRaw></Args></Command><Command Name='+
'"SetWiFi_Password" CmdByte="0x4E"><FPOperation>Program device''s WiFi network password where it will connect. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="Op'+
'tionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the WiFi password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="'+
'100"><Desc>Up to 100 symbols for the device''s WiFi password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''W''><;><''P''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_Bluetooth" CmdByte="0x4E"><FP'+
'Operation>Start Bluetooth test on the device and print out the result</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" Ma'+
'xLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''B''><;><''T''> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_GPRS" CmdByte="0x4E"><FPOperation>Start GPRS test on the device and print out the result</FPOperation><Args><Arg Name="" Value="R"'+
' Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''T''> ]]></ArgsFormatRaw></Args></Command><Command Na'+
'me="StartTest_Lan" CmdByte="0x4E"><FPOperation>Start LAN test on the device and print out the result</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Valu'+
'e="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''T''><;><''T''> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_WiFi" CmdByte="0x4E"><FPOperation>Start WiFi test on the device and print out the result</FPOperati'+
'on><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><''T''> ]]></ArgsFormatR'+
'aw></Args></Command><Command Name="Subtotal" CmdByte="0x33"><FPOperation>Calculate the subtotal amount with printing and display visualization options. Provide information about values of the calculated amounts. If a percent or value discount/addition has'+
' been specified the subtotal and the discount/addition value will be printed regardless the parameter for printing.</FPOperation><Args><Arg Name="OptionPrinting" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" V'+
'alue="1" /></Options><Desc>1 symbol with value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionDisplay" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:'+
'  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>Up to 8 symbols for the value of the discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresen'+
'ce=":" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>Up to 7 symbols for the percentage value of the discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="," /></Arg><'+
'ArgsFormatRaw><![CDATA[ <OptionPrinting[1]> <;> <OptionDisplay[1]> {<'':''> <DiscAddV[1..8]>} {<'',''> <DiscAddP[1..7]>} ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="SubtotalValue" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10 symbols f'+
'or the value of the subtotal amount</Desc></Res><ResFormatRaw><![CDATA[<SubtotalValue[1..10]>]]></ResFormatRaw></Response></Command><Command Name="UnpairAllDevices" CmdByte="0x4E"><FPOperation>Removes all paired devices. To apply use -SaveNetworkSettings('+
')</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''P''><;><''B''><;><''D''> ]]><'+
'/ArgsFormatRaw></Args></Command></Defs>';
  mXML := LoadXMLData(sXX);
  SendDefinitions(mXML);
end;


constructor FP.Create();
begin
  inherited;
  self.VersionDefs := 2407311630
end;

initialization
  RegisterClasses([OptionServiceMode_ResEnum,OptionActivationRS_ResEnum,OptionReceiptType_ResEnum,OptionChangeType_ResEnum,OptionDecimalPointPosition_ResEnum,OptionVATClass_ResEnum,OptionFooterLine_ResEnum,OptionHeaderLine_ResEnum,OptionPrintLogo_ResEnum,OptionAutoOpenDrawer_ResEnum,OptionAutoCut_ResEnum,OptionExternalDispManagement_ResEnum,OptionReceiptSend_ResEnum,OptionEnableCurrency_ResEnum,OptionWorkOperatorCount_ResEnum,OptionPrice_ResEnum,OptionQuantityType_ResEnum,OptionBTstatus_ResEnum,OptionIsReceiptOpened_ResEnum,OptionInitiatedPayment_ResEnum,OptionFinalizedPayment_ResEnum,OptionPowerDownInReceipt_ResEnum,OptionLAN_ResEnum,OptionWiFi_ResEnum,OptionGPRS_ResEnum,OptionBT_ResEnum,OptionDhcpStatus_ResEnum,OptionExternalType_ResEnum,OptionAddressType_ResEnum,OptionTCPAutoStart_ResEnum,OptionUsedModule_ResEnum,OptionDeviceType_ResEnum]);
finalization
  UnRegisterClasses([OptionServiceMode_ResEnum,OptionActivationRS_ResEnum,OptionReceiptType_ResEnum,OptionChangeType_ResEnum,OptionDecimalPointPosition_ResEnum,OptionVATClass_ResEnum,OptionFooterLine_ResEnum,OptionHeaderLine_ResEnum,OptionPrintLogo_ResEnum,OptionAutoOpenDrawer_ResEnum,OptionAutoCut_ResEnum,OptionExternalDispManagement_ResEnum,OptionReceiptSend_ResEnum,OptionEnableCurrency_ResEnum,OptionWorkOperatorCount_ResEnum,OptionPrice_ResEnum,OptionQuantityType_ResEnum,OptionBTstatus_ResEnum,OptionIsReceiptOpened_ResEnum,OptionInitiatedPayment_ResEnum,OptionFinalizedPayment_ResEnum,OptionPowerDownInReceipt_ResEnum,OptionLAN_ResEnum,OptionWiFi_ResEnum,OptionGPRS_ResEnum,OptionBT_ResEnum,OptionDhcpStatus_ResEnum,OptionExternalType_ResEnum,OptionAddressType_ResEnum,OptionTCPAutoStart_ResEnum,OptionUsedModule_ResEnum,OptionDeviceType_ResEnum]);
end.