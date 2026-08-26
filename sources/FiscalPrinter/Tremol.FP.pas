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
  OptionEjectRetractEnum = (er_for_postponed_receipt_eject = 101 {e}, er_for_postponed_receipt_retract = 114 {r});
  OptionPrintingBarcodeEnum = (pb_Disable = 68 {D}, pb_Enable = 69 {E});
  OptionFiscalRecieptPrintTypeEnum = (frpt_Empty = 0, frpt_Postponed_Printing = 49 {1}, frpt_Step_by_step_printing = 48 {0});
  OptionReceipTypeEnum = (rt_Empty = 0, rt_Refund_receipt = 49 {1}, rt_Standard_fiscal_receipt = 48 {0});
  OptionFiscalRcpPrintTypeEnum = (fpt_Empty = 0, fpt_Buffered_printing = 52 {4}, fpt_Postponed_Printing = 50 {2}, fpt_Step_by_step_printing = 48 {0});
  OptionPaymentTypeEnum = (pt_Payment_0 = 48 {0}, pt_Payment_1 = 49 {1}, pt_Payment_2 = 50 {2}, pt_Payment_3 = 51 {3}, pt_Payment_4 = 52 {4}, pt_Payment_5 = 53 {5}, pt_Payment_6 = 54 {6});
  OptionPaymentTypeV2_1Enum = (ptv21_ABONAMENT = 54 {6}, ptv21_ALT_IP = 55 {7}, ptv21_Alt_mod = 3407921 {14}, ptv21_Arvuna = 3211313 {11}, ptv21_Avans = 3145777 {10}, ptv21_CARD_PLATA = 49 {1}, ptv21_CEC = 51 {3}, ptv21_Compensare = 3342385 {13}, ptv21_Credit = 56 {8}, ptv21_Gaj = 3276849 {12}, ptv21_Leasing = 57 {9}, ptv21_NUMERAR = 48 {0}, ptv21_TICKET = 52 {4}, ptv21_TME = 53 {5}, ptv21_VOUCHER = 50 {2});
  OptionPaymentTypeV2Enum = (ptv2_ABONAMENT = 55 {7}, ptv2_ALT_IP = 56 {8}, ptv2_CARD_PLATA = 49 {1}, ptv2_CEC = 51 {3}, ptv2_NUMERAR = 48 {0}, ptv2_TICKET = 52 {4}, ptv2_TME = 54 {6}, ptv2_TMH = 53 {5}, ptv2_VOUCHER = 50 {2});
  OptionChangeEnum = (c_With_Change_default = 48 {0}, c_Without_Change = 49 {1});
  OptionChangeTypeEnum = (ct_Empty = 0, ct_Change_In_Cash = 48 {0}, ct_Same_As_The_payment = 49 {1});
  OptionZeroingEnum = (z_Without_zeroing = 88 {X}, z_Zeroing = 90 {Z});
  OptionCodeTypeEnum = (ct_CODABAR = 54 {6}, ct_CODE_128 = 73 {I}, ct_CODE_39 = 52 {4}, ct_CODE_93 = 72 {H}, ct_EAN_13 = 50 {2}, ct_EAN_8 = 51 {3}, ct_ITF = 53 {5}, ct_UPC_A = 48 {0}, ct_UPC_E = 49 {1});
  OptionVATClassEnum = (vatc_VAT_class_A = 65 {A}, vatc_VAT_class_B = 66 {B}, vatc_VAT_class_C = 67 {C}, vatc_VAT_class_D = 68 {D}, vatc_VAT_class_E = 69 {E}, vatc_VAT_class_F = 70 {F}, vatc_VAT_class_G = 71 {G}, vatc_VAT_class_H = 72 {H}, vatc_VAT_class_I = 73 {I});
  OptionDepPriceEnum = (dp_Empty = 0, dp_Free_price_disabled = 48 {0}, dp_Free_price_disabled_for_single_transaction = 52 {4}, dp_Free_price_enabled = 49 {1}, dp_Free_price_enabled_for_single_transaction = 53 {5}, dp_Limited_price = 50 {2}, dp_Limited_price_for_single_transaction = 54 {6});
  OptionHeaderLineEnum = (hl_Header_1 = 49 {1}, hl_Header_2 = 50 {2}, hl_Header_3 = 51 {3}, hl_Header_4 = 52 {4}, hl_Header_5 = 53 {5}, hl_Header_6 = 54 {6}, hl_Header_7 = 55 {7});
  OptionMandatoryConnectingEnum = (mc_No = 48 {0}, mc_Yes = 49 {1});
  OptionPrintLogoEnum = (pl_No = 48 {0}, pl_Yes = 49 {1});
  OptionAutoOpenDrawerEnum = (aod_No = 48 {0}, aod_Yes = 49 {1});
  OptionAutoCutEnum = (ac_No = 48 {0}, ac_Yes = 49 {1});
  OptionExternalDispManagementEnum = (edm_Auto = 48 {0}, edm_Manual = 49 {1});
  OptionEJFontTypeEnum = (ejft_Low_Font = 49 {1}, ejft_Normal_Font = 48 {0});
  OptionExternalDisplayMonitoringEnum = (edm_No = 48 {0}, edm_Yes = 49 {1});
  OptionPriceEnum = (p_Free_price_is_disable_valid_only_programmed_price = 48 {0}, p_Free_price_is_enable = 49 {1}, p_Limited_price = 50 {2});
  OptionTransactionEnum = (t_Empty = 0, t_Active_Single_transaction_in_receipt = 49 {1}, t_Inactive_default_value = 48 {0});
  OptionQuantityTypeEnum = (qt_for_availability_of_PLU_stock_is_not_monitored = 48 {0}, qt_for_disable_negative_quantity = 49 {1}, qt_for_enable_negative_quantity = 50 {2});
  OptionActivationEnum = (a_No = 48 {0}, a_Yes = 49 {1});
  OptionTypeActivationEnum = (ta_Empty = 0, ta_attention_and_blocking = 49 {1}, ta_attention_only = 48 {0});
  OptionLineSymbolsEnum = (ls_Symbols_per_line_32 = 48 {0}, ls_Symbols_per_line_48 = 49 {1});
  OptionBTstatusEnum = (bt_Disabled = 48 {0}, bt_Enabled = 49 {1});
  OptionForbiddenVoidEnum = (fv_allowed = 48 {0}, fv_forbidden = 49 {1});
  OptionVATinReceiptEnum = (vatr_with_printing = 48 {0}, vatr_without_printing = 49 {1});
  OptionDetailedReceiptEnum = (dr_brief = 48 {0}, dr_detailed_format = 49 {1});
  OptionInitiatedPaymentEnum = (ip_initiated_payment = 48 {0}, ip_not_initiated_payment = 49 {1});
  OptionFinalizedPaymentEnum = (fp_finalized_payment = 48 {0}, fp_not_finalized_payment = 49 {1});
  OptionFlagPowerDownEnum = (fpd_no_power_down = 48 {0}, fpd_power_down = 49 {1});
  OptionClientReceiptEnum = (cr_invoice_client_receipt = 49 {1}, cr_standard_receipt = 48 {0});
  OptionRcpChangeTypeEnum = (rct_Change_In_Cash = 48 {0}, rct_Change_In_Currency = 50 {2}, rct_Same_As_The_payment = 49 {1});
  OptionLANEnum = (lan_No = 48 {0}, lan_Yes = 49 {1});
  OptionWiFiEnum = (wf_No = 48 {0}, wf_Yes = 49 {1});
  OptionGPRSEnum = (gprs_No = 48 {0}, gprs_Yes = 49 {1});
  OptionBTEnum = (bt_No = 48 {0}, bt_Yes = 49 {1});
  OptionDhcpStatusEnum = (ds_Disabled = 48 {0}, ds_Enabled = 49 {1});
  OptionStorageReportEnum = (sr_To_PC = 3145834 {j0}, sr_To_SD_card = 3407978 {j4}, sr_To_USB_Flash_Drive = 3276906 {j2});
  OptionArticleReportTypeEnum = (art_Brief = 48 {0}, art_Detailed = 49 {1});
  OptionCurrencyEnum = (c_Disabled = 48 {0}, c_Enabled = 49 {1});
  OptionAddressTypeEnum = (at_DNS_address = 53 {5}, at_Gateway_address = 52 {4}, at_IP_address = 50 {2}, at_Subnet_Mask = 51 {3});
  OptionTCPAutoStartEnum = (tcpas_No = 48 {0}, tcpas_Yes = 49 {1});
  OptionUsedModuleEnum = (um_LAN = 49 {1}, um_WiFi = 50 {2});
  OptionCommunicationModuleEnum = (cm_GSM = 48 {0}, cm_LAN_or_WiFi = 49 {1});
  OptionVATRegEnum = (vatr_No = 48 {0}, vatr_Yes = 49 {1});
  OptionSignEnum = (s_Correction = 45 {-}, s_Sale = 43 {+});
  OptionDHCPEnabledEnum = (dhcpe_Disabled = 48 {0}, dhcpe_Enabled = 49 {1});
  OptionPrintingEnum = (p_No = 48 {0}, p_Yes = 49 {1});
  OptionDisplayEnum = (d_No = 48 {0}, d_Yes = 49 {1});


  OptionVATClass_ResEnum = class(ResEnum)
  public
    Name : OptionVATClassEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionDepPrice_ResEnum = class(ResEnum)
  public
    Name : OptionDepPriceEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionHeaderLine_ResEnum = class(ResEnum)
  public
    Name : OptionHeaderLineEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionMandatoryConnecting_ResEnum = class(ResEnum)
  public
    Name : OptionMandatoryConnectingEnum;
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

  OptionEJFontType_ResEnum = class(ResEnum)
  public
    Name : OptionEJFontTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionExternalDisplayMonitoring_ResEnum = class(ResEnum)
  public
    Name : OptionExternalDisplayMonitoringEnum;
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

  OptionTypeActivation_ResEnum = class(ResEnum)
  public
    Name : OptionTypeActivationEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionBTstatus_ResEnum = class(ResEnum)
  public
    Name : OptionBTstatusEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionForbiddenVoid_ResEnum = class(ResEnum)
  public
    Name : OptionForbiddenVoidEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionVATinReceipt_ResEnum = class(ResEnum)
  public
    Name : OptionVATinReceiptEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionDetailedReceipt_ResEnum = class(ResEnum)
  public
    Name : OptionDetailedReceiptEnum;
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

  OptionFlagPowerDown_ResEnum = class(ResEnum)
  public
    Name : OptionFlagPowerDownEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionClientReceipt_ResEnum = class(ResEnum)
  public
    Name : OptionClientReceiptEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionRcpChangeType_ResEnum = class(ResEnum)
  public
    Name : OptionRcpChangeTypeEnum;
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

  OptionArticleReportType_ResEnum = class(ResEnum)
  public
    Name : OptionArticleReportTypeEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionCurrency_ResEnum = class(ResEnum)
  public
    Name : OptionCurrencyEnum;
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

  OptionCommunicationModule_ResEnum = class(ResEnum)
  public
    Name : OptionCommunicationModuleEnum;
    Value : String;
    procedure Init(nam: Variant; val: string); override;
  end;

  OptionVATReg_ResEnum = class(ResEnum)
  public
    Name : OptionVATRegEnum;
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

  CompanyAddress_V2Res = class(TPersistent)
  private
    FCompAddrLen: double;
    FCompanyAddress: WideString;
  published
    {(Length) Up to 3 symbols for the company address length}
    Property CompAddrLen: double read FCompAddrLen write FCompAddrLen;
    {(Company address) 96 symbols for company address}
    Property CompanyAddress: WideString read FCompanyAddress write FCompanyAddress;
  end;

  CompanyName_V2Res = class(TPersistent)
  private
    FCompNameLen: double;
    FCompanyName: WideString;
  published
    {(Length) Up to 3 symbols for the company name length}
    Property CompNameLen: double read FCompNameLen write FCompNameLen;
    {(Company name) 60 symbols for company name}
    Property CompanyName: WideString read FCompanyName write FCompanyName;
  end;

  CurrentReceiptInfoRes = class(TPersistent)
  private
    FIsReceiptOpened: WideString;
    FSalesNumber: WideString;
    FSubtotalAmountVATGA: double;
    FSubtotalAmountVATGB: double;
    FSubtotalAmountVATGC: double;
    FSubtotalAmountVATGD: double;
    FSubtotalAmountVATGE: double;
    FSubtotalAmountVATGF: double;
    FSubtotalAmountVATGG: double;
    FSubtotalAmountVATGH: double;
    FSubtotalAmountVATGI: double;
    FOptionForbiddenVoid: OptionForbiddenVoid_ResEnum;
    FOptionVATinReceipt: OptionVATinReceipt_ResEnum;
    FOptionDetailedReceipt: OptionDetailedReceipt_ResEnum;
    FOptionInitiatedPayment: OptionInitiatedPayment_ResEnum;
    FOptionFinalizedPayment: OptionFinalizedPayment_ResEnum;
    FOptionFlagPowerDown: OptionFlagPowerDown_ResEnum;
    FOptionClientReceipt: OptionClientReceipt_ResEnum;
    FChangeAmount: double;
    FOptionRcpChangeType: OptionRcpChangeType_ResEnum;
  published
    {1 symbol with value '1' for initiated (opened) receipt}
    Property IsReceiptOpened: WideString read FIsReceiptOpened write FIsReceiptOpened;
    {3 symbols for number of sales}
    Property SalesNumber: WideString read FSalesNumber write FSalesNumber;
    {1..13 symbols for subtotal by VAT group A}
    Property SubtotalAmountVATGA: double read FSubtotalAmountVATGA write FSubtotalAmountVATGA;
    {1..13 symbols for subtotal by VAT group B}
    Property SubtotalAmountVATGB: double read FSubtotalAmountVATGB write FSubtotalAmountVATGB;
    {1..13 symbols for subtotal by VAT group C}
    Property SubtotalAmountVATGC: double read FSubtotalAmountVATGC write FSubtotalAmountVATGC;
    {1..13 symbols for subtotal by VAT group D}
    Property SubtotalAmountVATGD: double read FSubtotalAmountVATGD write FSubtotalAmountVATGD;
    {1..13 symbols for subtotal by VAT group E}
    Property SubtotalAmountVATGE: double read FSubtotalAmountVATGE write FSubtotalAmountVATGE;
    {1..13 symbols for subtotal by VAT group F}
    Property SubtotalAmountVATGF: double read FSubtotalAmountVATGF write FSubtotalAmountVATGF;
    {1..13 symbols for subtotal by VAT group G}
    Property SubtotalAmountVATGG: double read FSubtotalAmountVATGG write FSubtotalAmountVATGG;
    {1..13 symbols for subtotal by VAT group H}
    Property SubtotalAmountVATGH: double read FSubtotalAmountVATGH write FSubtotalAmountVATGH;
    {1..13 symbols for subtotal by VAT group I}
    Property SubtotalAmountVATGI: double read FSubtotalAmountVATGI write FSubtotalAmountVATGI;
    {1 symbol with value:     
 - '0' - allowed     
 - '1' - forbidden}
    Property OptionForbiddenVoid: OptionForbiddenVoid_ResEnum read FOptionForbiddenVoid write FOptionForbiddenVoid;
    {1 symbol with value:     
 - '0' - with printing     
 - '1' - without printing}
    Property OptionVATinReceipt: OptionVATinReceipt_ResEnum read FOptionVATinReceipt write FOptionVATinReceipt;
    {1 symbol with value:      
 - '0' - brief     
 - '1' - detailed format}
    Property OptionDetailedReceipt: OptionDetailedReceipt_ResEnum read FOptionDetailedReceipt write FOptionDetailedReceipt;
    {1 symbol with value:     
 - '0' - initiated payment     
 - '1' - not initiated payment}
    Property OptionInitiatedPayment: OptionInitiatedPayment_ResEnum read FOptionInitiatedPayment write FOptionInitiatedPayment;
    {1 symbol with value:     
 - '0' - finalized payment     
 - '1' - not finalized payment}
    Property OptionFinalizedPayment: OptionFinalizedPayment_ResEnum read FOptionFinalizedPayment write FOptionFinalizedPayment;
    {1 symbol with value:     
 - '0' - no power down     
 - '1' - power down}
    Property OptionFlagPowerDown: OptionFlagPowerDown_ResEnum read FOptionFlagPowerDown write FOptionFlagPowerDown;
    {1 symbol with value:     
 - '0' - standard receipt     
 - '1' - invoice (client) receipt}
    Property OptionClientReceipt: OptionClientReceipt_ResEnum read FOptionClientReceipt write FOptionClientReceipt;
    {1..13 symbols the amount of the due change in the stated     
payment type}
    Property ChangeAmount: double read FChangeAmount write FChangeAmount;
    {1 symbols with value:     
 - '0' - Change In Cash     
 - '1' - Same As The payment     
 - '2' - Change In Currency}
    Property OptionRcpChangeType: OptionRcpChangeType_ResEnum read FOptionRcpChangeType write FOptionRcpChangeType;
  end;

  CustomerDataRes = class(TPersistent)
  private
    FCustomerNum: double;
    FCustomerVatNum: WideString;
    FCustomerName: WideString;
    FCustomerAddress: WideString;
    FFreeLine1: WideString;
    FFreeLine2: WideString;
    FFreeLine3: WideString;
    FFreeLine4: WideString;
  published
    {3 symbols for customer number in order in format ####}
    Property CustomerNum: double read FCustomerNum write FCustomerNum;
    {15 symbols for customer VAT registration number}
    Property CustomerVatNum: WideString read FCustomerVatNum write FCustomerVatNum;
    {30 symbols for customer name}
    Property CustomerName: WideString read FCustomerName write FCustomerName;
    {30 symbols for customer address}
    Property CustomerAddress: WideString read FCustomerAddress write FCustomerAddress;
    {20 ASCII symbols for customer data}
    Property FreeLine1: WideString read FFreeLine1 write FFreeLine1;
    {20 ASCII symbols for customer data}
    Property FreeLine2: WideString read FFreeLine2 write FFreeLine2;
    {20 ASCII symbols for customer data}
    Property FreeLine3: WideString read FFreeLine3 write FFreeLine3;
    {20 ASCII symbols for customer data}
    Property FreeLine4: WideString read FFreeLine4 write FFreeLine4;
  end;

  DailyAvailableAmounts_V2Res = class(TPersistent)
  private
    FAmountPay0: double;
    FAmountPay1: double;
    FAmountPay2: double;
    FAmountPay3: double;
    FAmountPay4: double;
    FAmountPay5: double;
    FAmountPay6: double;
    FAmountPay7: double;
    FAmountPay8: double;
  published
    {1..13 symbols for the accumulated amount of payment type 0}
    Property AmountPay0: double read FAmountPay0 write FAmountPay0;
    {1..13 symbols for the accumulated amount of payment type 1}
    Property AmountPay1: double read FAmountPay1 write FAmountPay1;
    {1..13 symbols for the accumulated amount of payment type 2}
    Property AmountPay2: double read FAmountPay2 write FAmountPay2;
    {1..13 symbols for the accumulated amount of payment type 3}
    Property AmountPay3: double read FAmountPay3 write FAmountPay3;
    {1..13 symbols for the accumulated amount of payment type 4}
    Property AmountPay4: double read FAmountPay4 write FAmountPay4;
    {1..13 symbols for the accumulated amount of payment type 5}
    Property AmountPay5: double read FAmountPay5 write FAmountPay5;
    {1..13 symbols for the accumulated amount of payment type 6}
    Property AmountPay6: double read FAmountPay6 write FAmountPay6;
    {1..13 symbols for the accumulated amount of payment type 7}
    Property AmountPay7: double read FAmountPay7 write FAmountPay7;
    {1..13 symbols for the accumulated amount of payment type 8}
    Property AmountPay8: double read FAmountPay8 write FAmountPay8;
  end;

  DailyAvailableAmounts_V2_1Res = class(TPersistent)
  private
    FAmountPay0: double;
    FAmountPay1: double;
    FAmountPay2: double;
    FAmountPay3: double;
    FAmountPay4: double;
    FAmountPay5: double;
    FAmountPay6: double;
    FAmountPay7: double;
    FAmountPay8: double;
    FAmountPay9: double;
    FAmountPay10: double;
    FAmountPay11: double;
    FAmountPay12: double;
    FAmountPay13: double;
    FAmountPay14: double;
  published
    {1..13 symbols for the accumulated amount of payment type 0}
    Property AmountPay0: double read FAmountPay0 write FAmountPay0;
    {1..13 symbols for the accumulated amount of payment type 1}
    Property AmountPay1: double read FAmountPay1 write FAmountPay1;
    {1..13 symbols for the accumulated amount of payment type 2}
    Property AmountPay2: double read FAmountPay2 write FAmountPay2;
    {1..13 symbols for the accumulated amount of payment type 3}
    Property AmountPay3: double read FAmountPay3 write FAmountPay3;
    {1..13 symbols for the accumulated amount of payment type 4}
    Property AmountPay4: double read FAmountPay4 write FAmountPay4;
    {1..13 symbols for the accumulated amount of payment type 5}
    Property AmountPay5: double read FAmountPay5 write FAmountPay5;
    {1..13 symbols for the accumulated amount of payment type 6}
    Property AmountPay6: double read FAmountPay6 write FAmountPay6;
    {1..13 symbols for the accumulated amount of payment type 7}
    Property AmountPay7: double read FAmountPay7 write FAmountPay7;
    {1..13 symbols for the accumulated amount of payment type 8}
    Property AmountPay8: double read FAmountPay8 write FAmountPay8;
    {1..13 symbols for the accumulated amount of payment type 9}
    Property AmountPay9: double read FAmountPay9 write FAmountPay9;
    {1..13 symbols for the accumulated amount of payment type 10}
    Property AmountPay10: double read FAmountPay10 write FAmountPay10;
    {1..13 symbols for the accumulated amount of payment type 11}
    Property AmountPay11: double read FAmountPay11 write FAmountPay11;
    {1..13 symbols for the accumulated amount of payment type 12}
    Property AmountPay12: double read FAmountPay12 write FAmountPay12;
    {1..13 symbols for the accumulated amount of payment type 13}
    Property AmountPay13: double read FAmountPay13 write FAmountPay13;
    {1..13 symbols for the accumulated amount of payment type 14}
    Property AmountPay14: double read FAmountPay14 write FAmountPay14;
  end;

  DailyCountersRes = class(TPersistent)
  private
    FLastReportNumFromReset: double;
    FLastFMBlockNum: double;
    FEJNum: double;
    FDateTime: TDateTime;
  published
    {Up to 5 symbols for number of the last report from reset}
    Property LastReportNumFromReset: double read FLastReportNumFromReset write FLastReportNumFromReset;
    {Up to 5 symbols for number of the last FM report}
    Property LastFMBlockNum: double read FLastFMBlockNum write FLastFMBlockNum;
    {Up to 5 symbols for number of EJ}
    Property EJNum: double read FEJNum write FEJNum;
    {16 symbols for date and time of the last block storage in FM in     
format "DD-MM-YYYY HH:MM"}
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
    {10 symbols for date and time of the last operator's report in     
format DD-MM-YYYY}
    Property LastOperatorReportDateTime: TDateTime read FLastOperatorReportDateTime write FLastOperatorReportDateTime;
  end;

  DailyGeneralRegistersByOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FCustomersNum: double;
    FDiscountsNum: double;
    FDiscountsAmount: double;
    FAdditionsNum: double;
    FAdditionsAmount: double;
    FCorrectionsNum: double;
    FCorrectionsAmount: double;
  published
    {(Operator Number) Symbol from 1 to 20in format corresponding to     
operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 5 symbols for number of customers}
    Property CustomersNum: double read FCustomersNum write FCustomersNum;
    {Up to 5 symbols for number of discounts}
    Property DiscountsNum: double read FDiscountsNum write FDiscountsNum;
    {Up to 13 symbols for accumulated amount of discounts}
    Property DiscountsAmount: double read FDiscountsAmount write FDiscountsAmount;
    {Up to 5 symbols for number ofadditions}
    Property AdditionsNum: double read FAdditionsNum write FAdditionsNum;
    {Up to 13 symbols for accumulated amount of additions}
    Property AdditionsAmount: double read FAdditionsAmount write FAdditionsAmount;
    {Up to 5 symbols for number of corrections}
    Property CorrectionsNum: double read FCorrectionsNum write FCorrectionsNum;
    {Up to 13 symbols for accumulated amount of corrections}
    Property CorrectionsAmount: double read FCorrectionsAmount write FCorrectionsAmount;
  end;

  DailyPORes = class(TPersistent)
  private
    FAmountPayment0: double;
    FPONum: double;
  published
    {Up to 13 symbols for the accumulated amount by payment type 0}
    Property AmountPayment0: double read FAmountPayment0 write FAmountPayment0;
    {Up to 5 symbols for the total number of operations}
    Property PONum: double read FPONum write FPONum;
  end;

  DailyPObyOperator_V2Res = class(TPersistent)
  private
    FOperNum: double;
    FReceivedSalesAmountPay0: double;
    FReceivedSalesAmountPay1: double;
    FReceivedSalesAmountPay2: double;
    FReceivedSalesAmountPay3: double;
    FReceivedSalesAmountPay4: double;
    FReceivedSalesAmountPay5: double;
    FReceivedSalesAmountPay6: double;
    FReceivedSalesAmountPay7: double;
    FReceivedSalesAmountPay8: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for amounts received by sales for paym.0}
    Property ReceivedSalesAmountPay0: double read FReceivedSalesAmountPay0 write FReceivedSalesAmountPay0;
    {Up to 13 symbols for amounts received by sales for paym.1}
    Property ReceivedSalesAmountPay1: double read FReceivedSalesAmountPay1 write FReceivedSalesAmountPay1;
    {Up to 13 symbols for amounts received by sales for paym.2}
    Property ReceivedSalesAmountPay2: double read FReceivedSalesAmountPay2 write FReceivedSalesAmountPay2;
    {Up to 13 symbols for amounts received by sales for paym.3}
    Property ReceivedSalesAmountPay3: double read FReceivedSalesAmountPay3 write FReceivedSalesAmountPay3;
    {Up to 13 symbols for amounts received by sales for paym.4}
    Property ReceivedSalesAmountPay4: double read FReceivedSalesAmountPay4 write FReceivedSalesAmountPay4;
    {Up to 13 symbols for amounts received by sales for paym.5}
    Property ReceivedSalesAmountPay5: double read FReceivedSalesAmountPay5 write FReceivedSalesAmountPay5;
    {Up to 13 symbols for amounts received by sales for paym.6}
    Property ReceivedSalesAmountPay6: double read FReceivedSalesAmountPay6 write FReceivedSalesAmountPay6;
    {Up to 13 symbols for amounts received by sales for paym.7}
    Property ReceivedSalesAmountPay7: double read FReceivedSalesAmountPay7 write FReceivedSalesAmountPay7;
    {Up to 13 symbols for amounts received by sales for paym.8}
    Property ReceivedSalesAmountPay8: double read FReceivedSalesAmountPay8 write FReceivedSalesAmountPay8;
  end;

  DailyPObyOperator_V2_1Res = class(TPersistent)
  private
    FOperNum: double;
    FReceivedSalesAmountPay0: double;
    FReceivedSalesAmountPay1: double;
    FReceivedSalesAmountPay2: double;
    FReceivedSalesAmountPay3: double;
    FReceivedSalesAmountPay4: double;
    FReceivedSalesAmountPay5: double;
    FReceivedSalesAmountPay6: double;
    FReceivedSalesAmountPay7: double;
    FReceivedSalesAmountPay8: double;
    FReceivedSalesAmountPay9: double;
    FReceivedSalesAmountPay10: double;
    FReceivedSalesAmountPay11: double;
    FReceivedSalesAmountPay12: double;
    FReceivedSalesAmountPay13: double;
    FReceivedSalesAmountPay14: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for amounts received by sales for paym.0}
    Property ReceivedSalesAmountPay0: double read FReceivedSalesAmountPay0 write FReceivedSalesAmountPay0;
    {Up to 13 symbols for amounts received by sales for paym.1}
    Property ReceivedSalesAmountPay1: double read FReceivedSalesAmountPay1 write FReceivedSalesAmountPay1;
    {Up to 13 symbols for amounts received by sales for paym.2}
    Property ReceivedSalesAmountPay2: double read FReceivedSalesAmountPay2 write FReceivedSalesAmountPay2;
    {Up to 13 symbols for amounts received by sales for paym.3}
    Property ReceivedSalesAmountPay3: double read FReceivedSalesAmountPay3 write FReceivedSalesAmountPay3;
    {Up to 13 symbols for amounts received by sales for paym.4}
    Property ReceivedSalesAmountPay4: double read FReceivedSalesAmountPay4 write FReceivedSalesAmountPay4;
    {Up to 13 symbols for amounts received by sales for paym.5}
    Property ReceivedSalesAmountPay5: double read FReceivedSalesAmountPay5 write FReceivedSalesAmountPay5;
    {Up to 13 symbols for amounts received by sales for paym.6}
    Property ReceivedSalesAmountPay6: double read FReceivedSalesAmountPay6 write FReceivedSalesAmountPay6;
    {Up to 13 symbols for amounts received by sales for paym.7}
    Property ReceivedSalesAmountPay7: double read FReceivedSalesAmountPay7 write FReceivedSalesAmountPay7;
    {Up to 13 symbols for amounts received by sales for paym.8}
    Property ReceivedSalesAmountPay8: double read FReceivedSalesAmountPay8 write FReceivedSalesAmountPay8;
    {Up to 13 symbols for amounts received by sales for paym.9}
    Property ReceivedSalesAmountPay9: double read FReceivedSalesAmountPay9 write FReceivedSalesAmountPay9;
    {Up to 13 symbols for amounts received by sales for paym.10}
    Property ReceivedSalesAmountPay10: double read FReceivedSalesAmountPay10 write FReceivedSalesAmountPay10;
    {Up to 13 symbols for amounts received by sales for paym.11}
    Property ReceivedSalesAmountPay11: double read FReceivedSalesAmountPay11 write FReceivedSalesAmountPay11;
    {Up to 13 symbols for amounts received by sales for paym.12}
    Property ReceivedSalesAmountPay12: double read FReceivedSalesAmountPay12 write FReceivedSalesAmountPay12;
    {Up to 13 symbols for amounts received by sales for paym.13}
    Property ReceivedSalesAmountPay13: double read FReceivedSalesAmountPay13 write FReceivedSalesAmountPay13;
    {Up to 13 symbols for amounts received by sales for paym.14}
    Property ReceivedSalesAmountPay14: double read FReceivedSalesAmountPay14 write FReceivedSalesAmountPay14;
  end;

  DailyRARes = class(TPersistent)
  private
    FAmountPayment0: double;
    FRANum: double;
  published
    {Up to 13 symbols for the accumulated amount by payment type 0}
    Property AmountPayment0: double read FAmountPayment0 write FAmountPayment0;
    {Up to 5 symbols for the total number of operations}
    Property RANum: double read FRANum write FRANum;
  end;

  DailyRAbyOperatorRes = class(TPersistent)
  private
    FOperNum: double;
    FAmountRA_Payment0: double;
    FNoRA: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for the RA by type of payment 0}
    Property AmountRA_Payment0: double read FAmountRA_Payment0 write FAmountRA_Payment0;
    {Up to 5 symbols for the total number of operations}
    Property NoRA: double read FNoRA write FNoRA;
  end;

  DailyReceivedAmounts_V2Res = class(TPersistent)
  private
    FAmountPayment0: double;
    FAmountPayment1: double;
    FAmountPayment2: double;
    FAmountPayment3: double;
    FAmountPayment4: double;
    FAmountPayment5: double;
    FAmountPayment6: double;
    FAmountPayment7: double;
    FAmountPayment8: double;
  published
    {Up to 13 symbols for the accumulated amount by payment type 0}
    Property AmountPayment0: double read FAmountPayment0 write FAmountPayment0;
    {Up to 13 symbols for the accumulated amount by payment type 1}
    Property AmountPayment1: double read FAmountPayment1 write FAmountPayment1;
    {Up to 13 symbols for the accumulated amount by payment type 2}
    Property AmountPayment2: double read FAmountPayment2 write FAmountPayment2;
    {Up to 13 symbols for the accumulated amount by payment type 3}
    Property AmountPayment3: double read FAmountPayment3 write FAmountPayment3;
    {Up to 13 symbols for the accumulated amount by payment type 4}
    Property AmountPayment4: double read FAmountPayment4 write FAmountPayment4;
    {Up to 13 symbols for the accumulated amount by payment type 5}
    Property AmountPayment5: double read FAmountPayment5 write FAmountPayment5;
    {Up to 13 symbols for the accumulated amount by payment type 6}
    Property AmountPayment6: double read FAmountPayment6 write FAmountPayment6;
    {Up to 13 symbols for the accumulated amount by payment type 7}
    Property AmountPayment7: double read FAmountPayment7 write FAmountPayment7;
    {Up to 13 symbols for the accumulated amount by payment type 8}
    Property AmountPayment8: double read FAmountPayment8 write FAmountPayment8;
  end;

  DailyReceivedAmounts_V2_1Res = class(TPersistent)
  private
    FAmountPayment0: double;
    FAmountPayment1: double;
    FAmountPayment2: double;
    FAmountPayment3: double;
    FAmountPayment4: double;
    FAmountPayment5: double;
    FAmountPayment6: double;
    FAmountPayment7: double;
    FAmountPayment8: double;
    FAmountPayment9: double;
    FAmountPayment10: double;
    FAmountPayment11: double;
    FAmountPayment12: double;
    FAmountPayment13: double;
    FAmountPayment14: double;
  published
    {Up to 13 symbols for the accumulated amount by payment type 0}
    Property AmountPayment0: double read FAmountPayment0 write FAmountPayment0;
    {Up to 13 symbols for the accumulated amount by payment type 1}
    Property AmountPayment1: double read FAmountPayment1 write FAmountPayment1;
    {Up to 13 symbols for the accumulated amount by payment type 2}
    Property AmountPayment2: double read FAmountPayment2 write FAmountPayment2;
    {Up to 13 symbols for the accumulated amount by payment type 3}
    Property AmountPayment3: double read FAmountPayment3 write FAmountPayment3;
    {Up to 13 symbols for the accumulated amount by payment type 4}
    Property AmountPayment4: double read FAmountPayment4 write FAmountPayment4;
    {Up to 13 symbols for the accumulated amount by payment type 5}
    Property AmountPayment5: double read FAmountPayment5 write FAmountPayment5;
    {Up to 13 symbols for the accumulated amount by payment type 6}
    Property AmountPayment6: double read FAmountPayment6 write FAmountPayment6;
    {Up to 13 symbols for the accumulated amount by payment type 7}
    Property AmountPayment7: double read FAmountPayment7 write FAmountPayment7;
    {Up to 13 symbols for the accumulated amount by payment type 8}
    Property AmountPayment8: double read FAmountPayment8 write FAmountPayment8;
    {Up to 13 symbols for the accumulated amount by payment type 9}
    Property AmountPayment9: double read FAmountPayment9 write FAmountPayment9;
    {Up to 13 symbols for the accumulated amount by payment type 10}
    Property AmountPayment10: double read FAmountPayment10 write FAmountPayment10;
    {Up to 13 symbols for the accumulated amount by payment type 11}
    Property AmountPayment11: double read FAmountPayment11 write FAmountPayment11;
    {Up to 13 symbols for the accumulated amount by payment type 12}
    Property AmountPayment12: double read FAmountPayment12 write FAmountPayment12;
    {Up to 13 symbols for the accumulated amount by payment type 13}
    Property AmountPayment13: double read FAmountPayment13 write FAmountPayment13;
    {Up to 13 symbols for the accumulated amount by payment type 14}
    Property AmountPayment14: double read FAmountPayment14 write FAmountPayment14;
  end;

  DailyReturnedChangeAmountsByOperator_V2Res = class(TPersistent)
  private
    FOperNum: double;
    FChangeAmountPayment0: double;
    FChangeAmountPayment1: double;
    FChangeAmountPayment2: double;
    FChangeAmountPayment3: double;
    FChangeAmountPayment4: double;
    FChangeAmountPayment5: double;
    FChangeAmountPayment6: double;
    FChangeAmountPayment7: double;
    FChangeAmountPayment8: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for amounts received by type of payment 0}
    Property ChangeAmountPayment0: double read FChangeAmountPayment0 write FChangeAmountPayment0;
    {Up to 13 symbols for amounts received by type of payment 1}
    Property ChangeAmountPayment1: double read FChangeAmountPayment1 write FChangeAmountPayment1;
    {Up to 13 symbols for amounts received by type of payment 2}
    Property ChangeAmountPayment2: double read FChangeAmountPayment2 write FChangeAmountPayment2;
    {Up to 13 symbols for amounts received by type of payment 3}
    Property ChangeAmountPayment3: double read FChangeAmountPayment3 write FChangeAmountPayment3;
    {Up to 13 symbols for amounts received by type of payment 4}
    Property ChangeAmountPayment4: double read FChangeAmountPayment4 write FChangeAmountPayment4;
    {Up to 13 symbols for amounts received by type of payment 5}
    Property ChangeAmountPayment5: double read FChangeAmountPayment5 write FChangeAmountPayment5;
    {Up to 13 symbols for amounts received by type of payment 6}
    Property ChangeAmountPayment6: double read FChangeAmountPayment6 write FChangeAmountPayment6;
    {Up to 13 symbols for amounts received by type of payment 7}
    Property ChangeAmountPayment7: double read FChangeAmountPayment7 write FChangeAmountPayment7;
    {Up to 13 symbols for amounts received by type of payment 8}
    Property ChangeAmountPayment8: double read FChangeAmountPayment8 write FChangeAmountPayment8;
  end;

  DailyReturnedChangeAmountsByOperator_V2_1Res = class(TPersistent)
  private
    FOperNum: double;
    FChangeAmountPayment0: double;
    FChangeAmountPayment1: double;
    FChangeAmountPayment2: double;
    FChangeAmountPayment3: double;
    FChangeAmountPayment4: double;
    FChangeAmountPayment5: double;
    FChangeAmountPayment6: double;
    FChangeAmountPayment7: double;
    FChangeAmountPayment8: double;
    FChangeAmountPayment9: double;
    FChangeAmountPayment10: double;
    FChangeAmountPayment11: double;
    FChangeAmountPayment12: double;
    FChangeAmountPayment13: double;
    FChangeAmountPayment14: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for amounts received by type of payment 0}
    Property ChangeAmountPayment0: double read FChangeAmountPayment0 write FChangeAmountPayment0;
    {Up to 13 symbols for amounts received by type of payment 1}
    Property ChangeAmountPayment1: double read FChangeAmountPayment1 write FChangeAmountPayment1;
    {Up to 13 symbols for amounts received by type of payment 2}
    Property ChangeAmountPayment2: double read FChangeAmountPayment2 write FChangeAmountPayment2;
    {Up to 13 symbols for amounts received by type of payment 3}
    Property ChangeAmountPayment3: double read FChangeAmountPayment3 write FChangeAmountPayment3;
    {Up to 13 symbols for amounts received by type of payment 4}
    Property ChangeAmountPayment4: double read FChangeAmountPayment4 write FChangeAmountPayment4;
    {Up to 13 symbols for amounts received by type of payment 5}
    Property ChangeAmountPayment5: double read FChangeAmountPayment5 write FChangeAmountPayment5;
    {Up to 13 symbols for amounts received by type of payment 6}
    Property ChangeAmountPayment6: double read FChangeAmountPayment6 write FChangeAmountPayment6;
    {Up to 13 symbols for amounts received by type of payment 7}
    Property ChangeAmountPayment7: double read FChangeAmountPayment7 write FChangeAmountPayment7;
    {Up to 13 symbols for amounts received by type of payment 8}
    Property ChangeAmountPayment8: double read FChangeAmountPayment8 write FChangeAmountPayment8;
    {Up to 13 symbols for amounts received by type of payment 9}
    Property ChangeAmountPayment9: double read FChangeAmountPayment9 write FChangeAmountPayment9;
    {Up to 13 symbols for amounts received by type of payment 10}
    Property ChangeAmountPayment10: double read FChangeAmountPayment10 write FChangeAmountPayment10;
    {Up to 13 symbols for amounts received by type of payment 11}
    Property ChangeAmountPayment11: double read FChangeAmountPayment11 write FChangeAmountPayment11;
    {Up to 13 symbols for amounts received by type of payment 12}
    Property ChangeAmountPayment12: double read FChangeAmountPayment12 write FChangeAmountPayment12;
    {Up to 13 symbols for amounts received by type of payment 13}
    Property ChangeAmountPayment13: double read FChangeAmountPayment13 write FChangeAmountPayment13;
    {Up to 13 symbols for amounts received by type of payment 14}
    Property ChangeAmountPayment14: double read FChangeAmountPayment14 write FChangeAmountPayment14;
  end;

  DepartmentRes = class(TPersistent)
  private
    FDepNum: WideString;
    FDepName: WideString;
    FOptionVATClass: OptionVATClass_ResEnum;
    FTurnover: double;
    FSoldQuantity: double;
    FLastZReportNumber: double;
    FLastZReportDate: TDateTime;
    FPrice: double;
    FOptionDepPrice: OptionDepPrice_ResEnum;
  published
    {(Department Number) 2 symbols for department in format:     
##}
    Property DepNum: WideString read FDepNum write FDepNum;
    {(Department Name) 20 symbols for department name}
    Property DepName: WideString read FDepName write FDepName;
    {1 symbol for article's VAT Class with optional values:     
 - 'A' - VAT class A     
 - 'B' - VAT class B     
 - 'C' - VAT class C     
 - 'D' - VAT class D     
 - 'E' - VAT class E     
 - 'F' - VAT class F     
 - 'G' - VAT class G     
 - 'H' - VAT class H     
 - 'I' - VAT class I}
    Property OptionVATClass: OptionVATClass_ResEnum read FOptionVATClass write FOptionVATClass;
    {1..13 symbols for accumulated turnover of the department}
    Property Turnover: double read FTurnover write FTurnover;
    {1..13 symbols for sold quantity of the department}
    Property SoldQuantity: double read FSoldQuantity write FSoldQuantity;
    {1..5 symbols for the number of last Z report}
    Property LastZReportNumber: double read FLastZReportNumber write FLastZReportNumber;
    {16 symbols for the date and time of the last article report     
with zeroing      
in format DD-MM-YYYY HH:MM}
    Property LastZReportDate: TDateTime read FLastZReportDate write FLastZReportDate;
    {1 to 10 symbols for department price}
    Property Price: double read FPrice write FPrice;
    {1 symbol for Department flags with next value:     
 - '0' - Free price disabled      
 - '1' - Free price enabled      
 - '2' - Limited price     
 - '4' - Free price disabled for single transaction     
 - '5' - Free price enabled for single transaction     
 - '6' - Limited price for single transaction}
    Property OptionDepPrice: OptionDepPrice_ResEnum read FOptionDepPrice write FOptionDepPrice;
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

  FirstUnsentReceiptToServerRes = class(TPersistent)
  private
    FReceiptDate: TDateTime;
    FReceiptNumber: WideString;
  published
    {Receipt Date parameter}
    Property ReceiptDate: TDateTime read FReceiptDate write FReceiptDate;
    {6 symbols for receipt number}
    Property ReceiptNumber: WideString read FReceiptNumber write FReceiptNumber;
  end;

  GeneralDailyRegistersRes = class(TPersistent)
  private
    FCustomersNum: double;
    FDiscountsNum: double;
    FDiscountsAmount: double;
    FAdditionsNum: double;
    FAdditionsAmount: double;
    FCorrectionsNum: double;
    FCorrectionsAmount: double;
  published
    {Up to 5 symbols for number of customers}
    Property CustomersNum: double read FCustomersNum write FCustomersNum;
    {Up to 5 symbols for number of discounts}
    Property DiscountsNum: double read FDiscountsNum write FDiscountsNum;
    {Up to 13 symbols for accumulated amount of discounts}
    Property DiscountsAmount: double read FDiscountsAmount write FDiscountsAmount;
    {Up to 5 symbols for number of additions}
    Property AdditionsNum: double read FAdditionsNum write FAdditionsNum;
    {Up to 13 symbols for accumulated amount of additions}
    Property AdditionsAmount: double read FAdditionsAmount write FAdditionsAmount;
    {Up to 5 symbols for number of corrections}
    Property CorrectionsNum: double read FCorrectionsNum write FCorrectionsNum;
    {Up to 13 symbols for accumulated amount of corrections}
    Property CorrectionsAmount: double read FCorrectionsAmount write FCorrectionsAmount;
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
    {(Line Number)1 symbol with value:     
 - '1' - Header 1     
 - '2' - Header 2     
 - '3' - Header 3     
 - '4' - Header 4     
 - '5' - Header 5     
 - '6' - Header 6     
 - '7' - Header 7}
    Property OptionHeaderLine: OptionHeaderLine_ResEnum read FOptionHeaderLine write FOptionHeaderLine;
    {TextLength symbols for header lines}
    Property HeaderText: WideString read FHeaderText write FHeaderText;
  end;

  IntervalUnsentMsgRes = class(TPersistent)
  private
    FPassword: WideString;
    FTimeHours: double;
  published
    {6 symbols for  password}
    Property Password: WideString read FPassword write FPassword;
    {Up to 5 symbols for hour period}
    Property TimeHours: double read FTimeHours write FTimeHours;
  end;

  LastDailyReportInfoRes = class(TPersistent)
  private
    FLastZDailyReportDate: TDateTime;
    FNoLastZDailyReport: double;
    FNoLastRAMReset: double;
  published
    {10 symbols for last Z-report date in DD-MM-YYYY format}
    Property LastZDailyReportDate: TDateTime read FLastZDailyReportDate write FLastZDailyReportDate;
    {1..4 symbols for the number of the last daily report in format ####}
    Property NoLastZDailyReport: double read FNoLastZDailyReport write FNoLastZDailyReport;
    {1..4 symbols for the number of the lastRAM reset in format ####}
    Property NoLastRAMReset: double read FNoLastRAMReset write FNoLastRAMReset;
  end;

  LastReceiptNumRes = class(TPersistent)
  private
    FDailyReceiptCounter: double;
    FProgressiveReceiptCounter: double;
  published
    {4 symbols for the daily receipt counter in format ####}
    Property DailyReceiptCounter: double read FDailyReceiptCounter write FDailyReceiptCounter;
    {7 symbols for the receipt counter in format #######}
    Property ProgressiveReceiptCounter: double read FProgressiveReceiptCounter write FProgressiveReceiptCounter;
  end;

  OperatorNameAndPasswordRes = class(TPersistent)
  private
    FNumber: double;
    FName: WideString;
    FPassword: WideString;
  published
    {Symbols from 1 to 20 corresponding to the number of operator}
    Property Number: double read FNumber write FNumber;
    {20 symbols for operator's name}
    Property Name: WideString read FName write FName;
    {6 symbols for operator's password}
    Property Password: WideString read FPassword write FPassword;
  end;

  OperPORes = class(TPersistent)
  private
    FOperNum: double;
    FAmountPO_Payment0: double;
    FNoPO: double;
  published
    {Symbols from 1 to 20 corresponding to operator's number}
    Property OperNum: double read FOperNum write FOperNum;
    {Up to 13 symbols for the RA by type of payment 0}
    Property AmountPO_Payment0: double read FAmountPO_Payment0 write FAmountPO_Payment0;
    {Up to 5 symbols for the total number of operations}
    Property NoPO: double read FNoPO write FNoPO;
  end;

  ParametersECRRes = class(TPersistent)
  private
    FPOSNum: double;
    FOptionPrintLogo: OptionPrintLogo_ResEnum;
    FOptionAutoOpenDrawer: OptionAutoOpenDrawer_ResEnum;
    FOptionAutoCut: OptionAutoCut_ResEnum;
    FOptionExternalDispManagement: OptionExternalDispManagement_ResEnum;
    FOptionArticleReportType: OptionArticleReportType_ResEnum;
    FOptionCurrency: OptionCurrency_ResEnum;
    FOptionEJFontType: OptionEJFontType_ResEnum;
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
    {(Article Report) 1 symbol of value:     
 - '1' - Detailed     
 - '0' - Brief}
    Property OptionArticleReportType: OptionArticleReportType_ResEnum read FOptionArticleReportType write FOptionArticleReportType;
    {1 symbol of value:     
 - '1' - Enabled     
 - '0' - Disabled}
    Property OptionCurrency: OptionCurrency_ResEnum read FOptionCurrency write FOptionCurrency;
    {(EJ Font) 1 symbol of value:     
 - '1' - Low Font     
 - '0' - Normal Font}
    Property OptionEJFontType: OptionEJFontType_ResEnum read FOptionEJFontType write FOptionEJFontType;
  end;

  ParametersFPRes = class(TPersistent)
  private
    FPOSNum: double;
    FOptionPrintLogo: OptionPrintLogo_ResEnum;
    FOptionAutoOpenDrawer: OptionAutoOpenDrawer_ResEnum;
    FOptionAutoCut: OptionAutoCut_ResEnum;
    FOptionExternalDispManagement: OptionExternalDispManagement_ResEnum;
    FOptionArticleReportType: OptionArticleReportType_ResEnum;
    FOptionCurrency: OptionCurrency_ResEnum;
    FOptionEJFontType: OptionEJFontType_ResEnum;
    FOptionExternalDisplayMonitoring: OptionExternalDisplayMonitoring_ResEnum;
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
    {(Article Report) 1 symbol of value:     
 - '1' - Detailed     
 - '0' - Brief}
    Property OptionArticleReportType: OptionArticleReportType_ResEnum read FOptionArticleReportType write FOptionArticleReportType;
    {1 symbol of value:     
 - '1' - Enabled     
 - '0' - Disabled}
    Property OptionCurrency: OptionCurrency_ResEnum read FOptionCurrency write FOptionCurrency;
    {(EJ Font) 1 symbol of value:     
 - '1' - Low Font     
 - '0' - Normal Font}
    Property OptionEJFontType: OptionEJFontType_ResEnum read FOptionEJFontType write FOptionEJFontType;
    {1 symbol of value:     
 - '1' - Yes     
 - '0' - No}
    Property OptionExternalDisplayMonitoring: OptionExternalDisplayMonitoring_ResEnum read FOptionExternalDisplayMonitoring write FOptionExternalDisplayMonitoring;
  end;

  PaymentsRes = class(TPersistent)
  private
    FNamePaym0: WideString;
    FNamePaym1: WideString;
    FNamePaym2: WideString;
    FNamePaym3: WideString;
    FNamePaym4: WideString;
    FNamePaym5: WideString;
    FNamePaym6: WideString;
  published
    {10 symbols for payment name of type 0}
    Property NamePaym0: WideString read FNamePaym0 write FNamePaym0;
    {10 symbols for payment name of type 1}
    Property NamePaym1: WideString read FNamePaym1 write FNamePaym1;
    {10 symbols for payment name of type 2}
    Property NamePaym2: WideString read FNamePaym2 write FNamePaym2;
    {10 symbols for payment name of type 3}
    Property NamePaym3: WideString read FNamePaym3 write FNamePaym3;
    {10 symbols for payment name of type 4}
    Property NamePaym4: WideString read FNamePaym4 write FNamePaym4;
    {10 symbols for payment name of type 5}
    Property NamePaym5: WideString read FNamePaym5 write FNamePaym5;
    {10 symbols for payment name of type 6}
    Property NamePaym6: WideString read FNamePaym6 write FNamePaym6;
  end;

  Payments_V2Res = class(TPersistent)
  private
    FNamePaym0: WideString;
    FNamePaym1: WideString;
    FNamePaym2: WideString;
    FNamePaym3: WideString;
    FNamePaym4: WideString;
    FNamePaym5: WideString;
    FNamePaym6: WideString;
    FNamePaym7: WideString;
    FNamePaym8: WideString;
  published
    {10 symbols for payment name of type 0}
    Property NamePaym0: WideString read FNamePaym0 write FNamePaym0;
    {10 symbols for payment name of type 1}
    Property NamePaym1: WideString read FNamePaym1 write FNamePaym1;
    {10 symbols for payment name of type 2}
    Property NamePaym2: WideString read FNamePaym2 write FNamePaym2;
    {10 symbols for payment name of type 3}
    Property NamePaym3: WideString read FNamePaym3 write FNamePaym3;
    {10 symbols for payment name of type 4}
    Property NamePaym4: WideString read FNamePaym4 write FNamePaym4;
    {10 symbols for payment name of type 5}
    Property NamePaym5: WideString read FNamePaym5 write FNamePaym5;
    {10 symbols for payment name of type 6}
    Property NamePaym6: WideString read FNamePaym6 write FNamePaym6;
    {10 symbols for payment name of type 7}
    Property NamePaym7: WideString read FNamePaym7 write FNamePaym7;
    {10 symbols for payment name of type 8}
    Property NamePaym8: WideString read FNamePaym8 write FNamePaym8;
  end;

  Payments_V2_1Res = class(TPersistent)
  private
    FNamePaym0: WideString;
    FNamePaym1: WideString;
    FNamePaym2: WideString;
    FNamePaym3: WideString;
    FNamePaym4: WideString;
    FNamePaym5: WideString;
    FNamePaym6: WideString;
    FNamePaym7: WideString;
    FNamePaym8: WideString;
    FNamePaym9: WideString;
    FNamePaym10: WideString;
    FNamePaym11: WideString;
    FNamePaym12: WideString;
    FNamePaym13: WideString;
    FNamePaym14: WideString;
  published
    {10 symbols for payment name of type 0}
    Property NamePaym0: WideString read FNamePaym0 write FNamePaym0;
    {10 symbols for payment name of type 1}
    Property NamePaym1: WideString read FNamePaym1 write FNamePaym1;
    {10 symbols for payment name of type 2}
    Property NamePaym2: WideString read FNamePaym2 write FNamePaym2;
    {10 symbols for payment name of type 3}
    Property NamePaym3: WideString read FNamePaym3 write FNamePaym3;
    {10 symbols for payment name of type 4}
    Property NamePaym4: WideString read FNamePaym4 write FNamePaym4;
    {10 symbols for payment name of type 5}
    Property NamePaym5: WideString read FNamePaym5 write FNamePaym5;
    {10 symbols for payment name of type 6}
    Property NamePaym6: WideString read FNamePaym6 write FNamePaym6;
    {10 symbols for payment name of type 7}
    Property NamePaym7: WideString read FNamePaym7 write FNamePaym7;
    {10 symbols for payment name of type 8}
    Property NamePaym8: WideString read FNamePaym8 write FNamePaym8;
    {10 symbols for payment name of type 9}
    Property NamePaym9: WideString read FNamePaym9 write FNamePaym9;
    {10 symbols for payment name of type 10}
    Property NamePaym10: WideString read FNamePaym10 write FNamePaym10;
    {10 symbols for payment name of type 11}
    Property NamePaym11: WideString read FNamePaym11 write FNamePaym11;
    {10 symbols for payment name of type 12}
    Property NamePaym12: WideString read FNamePaym12 write FNamePaym12;
    {10 symbols for payment name of type 13}
    Property NamePaym13: WideString read FNamePaym13 write FNamePaym13;
    {10 symbols for payment name of type 14}
    Property NamePaym14: WideString read FNamePaym14 write FNamePaym14;
  end;

  PLURes = class(TPersistent)
  private
    FPLUNum: double;
    FPLUName: WideString;
    FPrice: double;
    FFlagsPricePLU: WideString;
    FOptionVATClass: OptionVATClass_ResEnum;
    FDepNum: double;
    FTurnover: double;
    FSoldQuantity: double;
    FLastZReportNumber: double;
    FLastZReportDate: TDateTime;
    FAvailableQuantity: double;
    FBarcode: WideString;
  published
    {5 symbols for article number with leading zeroes in format #####}
    Property PLUNum: double read FPLUNum write FPLUNum;
    {34 symbols for article name (LF=7Ch)}
    Property PLUName: WideString read FPLUName write FPLUName;
    {1..11 symbols for article price}
    Property Price: double read FPrice write FPrice;
    {1 symbol for flags = 0x80 + FlagSinglTr + FlagQTY + OptionPrice     
Where      
OptionPrice:     
0x00 - for free price is disable /valid only programmed price/     
0x01 - for free price is enable     
0x02 - for limited price     
FlagQTY:     
0x00 - for availability of PLU stock is not monitored     
0x04 - for disable negative quantity     
0x08 - for enable negative quantity     
FlagSingleTr:     
0x00 - no single transaction     
0x10 - single transaction is active}
    Property FlagsPricePLU: WideString read FFlagsPricePLU write FFlagsPricePLU;
    {1 symbol for article's VAT Class with optional values:     
 - 'A' - VAT class A     
 - 'B' - VAT class B     
 - 'C' - VAT class C     
 - 'D' - VAT class D     
 - 'E' - VAT class E     
 - 'F' - VAT class F     
 - 'G' - VAT class G     
 - 'H' - VAT class H     
 - 'I' - VAT class I}
    Property OptionVATClass: OptionVATClass_ResEnum read FOptionVATClass write FOptionVATClass;
    {DepNum + 80h, 1 symbol for article department attachment, formed in     
the following manner: example: Dep01 = 81h, Dep02 = 82h … Dep19     
= 93h}
    Property DepNum: double read FDepNum write FDepNum;
    {13 symbols for PLU accumulated turnover}
    Property Turnover: double read FTurnover write FTurnover;
    {13 symbols for Sales quantity of the article}
    Property SoldQuantity: double read FSoldQuantity write FSoldQuantity;
    {5 symbols for the number of the last article report with zeroing}
    Property LastZReportNumber: double read FLastZReportNumber write FLastZReportNumber;
    {16 symbols for the date and time of the last article report with zeroing      
in format DD-MM-YYYY HH:MM}
    Property LastZReportDate: TDateTime read FLastZReportDate write FLastZReportDate;
    {(Available Quantity) - 1..11 symbols for quantity in stock}
    Property AvailableQuantity: double read FAvailableQuantity write FAvailableQuantity;
    {13 symbols for article barcode}
    Property Barcode: WideString read FBarcode write FBarcode;
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
 - '0'- Free price is disable /valid only programmed price/     
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
    {1 byte for Quantity flag with next value:     
 - '0'- for availability of PLU stock is not monitored     
 - '1'- for disable negative quantity     
 - '2'- for enable negative quantity}
    Property OptionQuantityType: OptionQuantityType_ResEnum read FOptionQuantityType write FOptionQuantityType;
  end;

  SerialAndFiscalNumsRes = class(TPersistent)
  private
    FSerialNum: WideString;
    FFMNum: WideString;
  published
    {10 symbols for individual number of the fiscal device}
    Property SerialNum: WideString read FSerialNum write FSerialNum;
    {12 symbol Fiscal Memory number}
    Property FMNum: WideString read FFMNum write FFMNum;
  end;

  SerialAndFiscalNums_V2Res = class(TPersistent)
  private
    FSerialNum: WideString;
    FFMNum: WideString;
    FUniCode: WideString;
  published
    {10 symbols for individual number of the fiscal device}
    Property SerialNum: WideString read FSerialNum write FSerialNum;
    {12 symbol Fiscal Memory number}
    Property FMNum: WideString read FFMNum write FFMNum;
    {20 ASCII symbols for unique server registration code}
    Property UniCode: WideString read FUniCode write FUniCode;
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

  ServiceContractActivationRes = class(TPersistent)
  private
    FExpiryDate: TDateTime;
    FOptionTypeActivation: OptionTypeActivation_ResEnum;
  published
    {8 symbols for date in format DDMMYYYY}
    Property ExpiryDate: TDateTime read FExpiryDate write FExpiryDate;
    {1 symbol with value:     
 - '0'- attention only      
 - '1'- attention and blocking}
    Property OptionTypeActivation: OptionTypeActivation_ResEnum read FOptionTypeActivation write FOptionTypeActivation;
  end;

  SpecificMessageNumberRes = class(TPersistent)
  private
    FMessageNum: WideString;
    FDateTime: TDateTime;
    FType: WideString;
    FCode: WideString;
    FMessageText: WideString;
  published
    {2 symbols for total number of messages}
    Property MessageNum: WideString read FMessageNum write FMessageNum;
    {Date Time parameter}
    Property DateTime: TDateTime read FDateTime write FDateTime;
    {1 symbol for type}
    Property MessageType: WideString read FType write FType;
    {3 symbols for code}
    Property Code: WideString read FCode write FCode;
    {Up to 128 symbols for message text}
    Property MessageText: WideString read FMessageText write FMessageText;
  end;

  StatusECRRes = class(TPersistent)
  private
    FFM_Read_only: boolean;
    FPower_down_in_opened_fiscal_receipt: boolean;
    FPrinter_not_ready_or_overheated: boolean;
    FIncorrect_time: boolean;
    FIncorrect_date: boolean;
    FRAM_reset: boolean;
    FDate_and_time_hardware_error: boolean;
    FPrinter_not_ready_or_no_paper: boolean;
    FReports_registers_overflow: boolean;
    FBlocking_after_24_hours: boolean;
    FNon_zero_daily_report: boolean;
    FNon_zero_article_report: boolean;
    FNon_zero_operator_report: boolean;
    FNon_printed_copy: boolean;
    FOpened_Non_fiscal_Receipt: boolean;
    FOpened_Fiscal_Receipt: boolean;
    FStandard_Cash_Receipt: boolean;
    FVAT_included_in_the_receipt: boolean;
    FInvoice: boolean;
    FEJ_near_full: boolean;
    FEJ_full: boolean;
    FNo_FM_module: boolean;
    FFM_error: boolean;
    FFM_full: boolean;
    FFM_near_full: boolean;
    FDecimal_point: boolean;
    FFM_fiscalized: boolean;
    FFM_produced: boolean;
    FPrinter_automatic_cutting: boolean;
    FExternal_Display_Management: boolean;
    FExpired_service_contract: boolean;
    FBrief_or_Detailed_EJ: boolean;
    FDrawer_automatic_opening: boolean;
    FCustomer_logo_included_in_the_receipt: boolean;
    FUnsent_data_for_72h: boolean;
  published
    {FM Read only  ( ST3.0 or ST3.1 or ST3.2 )}
    Property FM_Read_only: boolean read FFM_Read_only write FFM_Read_only;
    {Power down in opened fiscal receipt}
    Property Power_down_in_opened_fiscal_receipt: boolean read FPower_down_in_opened_fiscal_receipt write FPower_down_in_opened_fiscal_receipt;
    {Printer not ready or overheated}
    Property Printer_not_ready_or_overheated: boolean read FPrinter_not_ready_or_overheated write FPrinter_not_ready_or_overheated;
    {Incorrect time}
    Property Incorrect_time: boolean read FIncorrect_time write FIncorrect_time;
    {Incorrect date}
    Property Incorrect_date: boolean read FIncorrect_date write FIncorrect_date;
    {RAM reset}
    Property RAM_reset: boolean read FRAM_reset write FRAM_reset;
    {Date and time hardware error}
    Property Date_and_time_hardware_error: boolean read FDate_and_time_hardware_error write FDate_and_time_hardware_error;
    {Printer not ready or no paper}
    Property Printer_not_ready_or_no_paper: boolean read FPrinter_not_ready_or_no_paper write FPrinter_not_ready_or_no_paper;
    {Reports registers overflow}
    Property Reports_registers_overflow: boolean read FReports_registers_overflow write FReports_registers_overflow;
    {Blocking after 24 hours}
    Property Blocking_after_24_hours: boolean read FBlocking_after_24_hours write FBlocking_after_24_hours;
    {Non-zero daily report}
    Property Non_zero_daily_report: boolean read FNon_zero_daily_report write FNon_zero_daily_report;
    {Non-zero article report}
    Property Non_zero_article_report: boolean read FNon_zero_article_report write FNon_zero_article_report;
    {Non-zero operator report}
    Property Non_zero_operator_report: boolean read FNon_zero_operator_report write FNon_zero_operator_report;
    {Non-printed copy}
    Property Non_printed_copy: boolean read FNon_printed_copy write FNon_printed_copy;
    {Opened Non-fiscal Receipt}
    Property Opened_Non_fiscal_Receipt: boolean read FOpened_Non_fiscal_Receipt write FOpened_Non_fiscal_Receipt;
    {Opened Fiscal Receipt}
    Property Opened_Fiscal_Receipt: boolean read FOpened_Fiscal_Receipt write FOpened_Fiscal_Receipt;
    {Standard Cash Receipt}
    Property Standard_Cash_Receipt: boolean read FStandard_Cash_Receipt write FStandard_Cash_Receipt;
    {VAT included in the receipt}
    Property VAT_included_in_the_receipt: boolean read FVAT_included_in_the_receipt write FVAT_included_in_the_receipt;
    {Invoice}
    Property Invoice: boolean read FInvoice write FInvoice;
    {EJ near full}
    Property EJ_near_full: boolean read FEJ_near_full write FEJ_near_full;
    {EJ full}
    Property EJ_full: boolean read FEJ_full write FEJ_full;
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
    {External Display Management}
    Property External_Display_Management: boolean read FExternal_Display_Management write FExternal_Display_Management;
    {Expired service contract}
    Property Expired_service_contract: boolean read FExpired_service_contract write FExpired_service_contract;
    {Brief or Detailed EJ}
    Property Brief_or_Detailed_EJ: boolean read FBrief_or_Detailed_EJ write FBrief_or_Detailed_EJ;
    {Drawer: automatic opening}
    Property Drawer_automatic_opening: boolean read FDrawer_automatic_opening write FDrawer_automatic_opening;
    {Customer logo included in the receipt}
    Property Customer_logo_included_in_the_receipt: boolean read FCustomer_logo_included_in_the_receipt write FCustomer_logo_included_in_the_receipt;
    {Unsent data for 72h}
    Property Unsent_data_for_72h: boolean read FUnsent_data_for_72h write FUnsent_data_for_72h;
  end;

  StatusFPRes = class(TPersistent)
  private
    FFM_Read_only: boolean;
    FPower_down_in_opened_fiscal_receipt: boolean;
    FPrinter_not_ready_or_overheated: boolean;
    FIncorrect_time: boolean;
    FIncorrect_date: boolean;
    FRAM_reset: boolean;
    FDate_and_time_hardware_error: boolean;
    FPrinter_not_ready_or_no_paper: boolean;
    FReports_registers_overflow: boolean;
    FBlocking_after_24_hours: boolean;
    FNon_zero_daily_report: boolean;
    FNon_zero_article_report: boolean;
    FNon_zero_operator_report: boolean;
    FNon_printed_copy: boolean;
    FOpened_Non_fiscal_Receipt: boolean;
    FOpened_Fiscal_Receipt: boolean;
    FStandard_Cash_Receipt: boolean;
    FVAT_included_in_the_receipt: boolean;
    FInvoice: boolean;
    FEJ_near_full: boolean;
    FEJ_full: boolean;
    FNo_FM_module: boolean;
    FFM_error: boolean;
    FFM_full: boolean;
    FFM_near_full: boolean;
    FDecimal_point: boolean;
    FFM_fiscalized: boolean;
    FFM_produced: boolean;
    FPrinter_automatic_cutting: boolean;
    FExternal_Display_Management: boolean;
    FExpired_service_contract: boolean;
    FBrief_or_Detailed_EJ: boolean;
    FDrawer_automatic_opening: boolean;
    FCustomer_logo_included_in_the_receipt: boolean;
    FUnsent_data_for_72h: boolean;
    FPrinter_disconnected: boolean;
    FWrong_SD_card: boolean;
    FNear_end_of_paper: boolean;
  published
    {FM Read only  ( ST3.0 or ST3.1 or ST3.2 )}
    Property FM_Read_only: boolean read FFM_Read_only write FFM_Read_only;
    {Power down in opened fiscal receipt}
    Property Power_down_in_opened_fiscal_receipt: boolean read FPower_down_in_opened_fiscal_receipt write FPower_down_in_opened_fiscal_receipt;
    {Printer not ready or overheated}
    Property Printer_not_ready_or_overheated: boolean read FPrinter_not_ready_or_overheated write FPrinter_not_ready_or_overheated;
    {Incorrect time}
    Property Incorrect_time: boolean read FIncorrect_time write FIncorrect_time;
    {Incorrect date}
    Property Incorrect_date: boolean read FIncorrect_date write FIncorrect_date;
    {RAM reset}
    Property RAM_reset: boolean read FRAM_reset write FRAM_reset;
    {Date and time hardware error}
    Property Date_and_time_hardware_error: boolean read FDate_and_time_hardware_error write FDate_and_time_hardware_error;
    {Printer not ready or no paper}
    Property Printer_not_ready_or_no_paper: boolean read FPrinter_not_ready_or_no_paper write FPrinter_not_ready_or_no_paper;
    {Reports registers overflow}
    Property Reports_registers_overflow: boolean read FReports_registers_overflow write FReports_registers_overflow;
    {Blocking after 24 hours}
    Property Blocking_after_24_hours: boolean read FBlocking_after_24_hours write FBlocking_after_24_hours;
    {Non-zero daily report}
    Property Non_zero_daily_report: boolean read FNon_zero_daily_report write FNon_zero_daily_report;
    {Non-zero article report}
    Property Non_zero_article_report: boolean read FNon_zero_article_report write FNon_zero_article_report;
    {Non-zero operator report}
    Property Non_zero_operator_report: boolean read FNon_zero_operator_report write FNon_zero_operator_report;
    {Non-printed copy}
    Property Non_printed_copy: boolean read FNon_printed_copy write FNon_printed_copy;
    {Opened Non-fiscal Receipt}
    Property Opened_Non_fiscal_Receipt: boolean read FOpened_Non_fiscal_Receipt write FOpened_Non_fiscal_Receipt;
    {Opened Fiscal Receipt}
    Property Opened_Fiscal_Receipt: boolean read FOpened_Fiscal_Receipt write FOpened_Fiscal_Receipt;
    {Standard Cash Receipt}
    Property Standard_Cash_Receipt: boolean read FStandard_Cash_Receipt write FStandard_Cash_Receipt;
    {VAT included in the receipt}
    Property VAT_included_in_the_receipt: boolean read FVAT_included_in_the_receipt write FVAT_included_in_the_receipt;
    {Invoice}
    Property Invoice: boolean read FInvoice write FInvoice;
    {EJ near full}
    Property EJ_near_full: boolean read FEJ_near_full write FEJ_near_full;
    {EJ full}
    Property EJ_full: boolean read FEJ_full write FEJ_full;
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
    {External Display Management}
    Property External_Display_Management: boolean read FExternal_Display_Management write FExternal_Display_Management;
    {Expired service contract}
    Property Expired_service_contract: boolean read FExpired_service_contract write FExpired_service_contract;
    {Brief or Detailed EJ}
    Property Brief_or_Detailed_EJ: boolean read FBrief_or_Detailed_EJ write FBrief_or_Detailed_EJ;
    {Drawer: automatic opening}
    Property Drawer_automatic_opening: boolean read FDrawer_automatic_opening write FDrawer_automatic_opening;
    {Customer logo included in the receipt}
    Property Customer_logo_included_in_the_receipt: boolean read FCustomer_logo_included_in_the_receipt write FCustomer_logo_included_in_the_receipt;
    {Unsent data for 72h}
    Property Unsent_data_for_72h: boolean read FUnsent_data_for_72h write FUnsent_data_for_72h;
    {Printer disconnected}
    Property Printer_disconnected: boolean read FPrinter_disconnected write FPrinter_disconnected;
    {Wrong SD card}
    Property Wrong_SD_card: boolean read FWrong_SD_card write FWrong_SD_card;
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

  VATClassAmountsRes = class(TPersistent)
  private
    FAmountVATGrA: double;
    FAmountVATGrB: double;
    FAmountVATGrC: double;
    FAmountVATGrD: double;
    FAmountVATGrE: double;
    FAmountVATGrF: double;
    FAmountVATGrG: double;
    FAmountVATGrH: double;
    FAmountVATGrI: double;
  published
    {1..13 symbols for the amount accumulated in the VAT group A}
    Property AmountVATGrA: double read FAmountVATGrA write FAmountVATGrA;
    {1..13 symbols for the amount accumulated in the VAT group B}
    Property AmountVATGrB: double read FAmountVATGrB write FAmountVATGrB;
    {1..13 symbols for the amount accumulated in the VAT group C}
    Property AmountVATGrC: double read FAmountVATGrC write FAmountVATGrC;
    {1..13 symbols for the amount accumulated in the VAT group D}
    Property AmountVATGrD: double read FAmountVATGrD write FAmountVATGrD;
    {1..13 symbols for the amount accumulated in the VAT group E}
    Property AmountVATGrE: double read FAmountVATGrE write FAmountVATGrE;
    {1..13 symbols for the amount accumulated in the VAT group F}
    Property AmountVATGrF: double read FAmountVATGrF write FAmountVATGrF;
    {1..13 symbols for the amount accumulated in the VAT group G}
    Property AmountVATGrG: double read FAmountVATGrG write FAmountVATGrG;
    {1..13 symbols for the amount accumulated in the VAT group H}
    Property AmountVATGrH: double read FAmountVATGrH write FAmountVATGrH;
    {1..13 symbols for the amount accumulated in the VAT group I}
    Property AmountVATGrI: double read FAmountVATGrI write FAmountVATGrI;
  end;

  VATNumber_V2Res = class(TPersistent)
  private
    FVATNum: WideString;
    FOptionVATReg: OptionVATReg_ResEnum;
  published
    {15 symbols for VAT number}
    Property VATNum: WideString read FVATNum write FVATNum;
    {1 symbols for registration     
 - '1' - Yes     
 - '0' - No}
    Property OptionVATReg: OptionVATReg_ResEnum read FOptionVATReg write FOptionVATReg;
  end;

  VATratesRes = class(TPersistent)
  private
    FVATrateA: double;
    FVATrateB: double;
    FVATrateC: double;
    FVATrateD: double;
    FVATrateE: double;
    FVATrateF: double;
    FVATrateG: double;
    FVATrateH: double;
    FVATrateI: double;
  published
    {6 symbols for VATrates of VAT class A in format ##.##%}
    Property VATrateA: double read FVATrateA write FVATrateA;
    {6 symbols for VATrates of VAT class B in format ##.##%}
    Property VATrateB: double read FVATrateB write FVATrateB;
    {6 symbols for VATrates of VAT class C in format ##.##%}
    Property VATrateC: double read FVATrateC write FVATrateC;
    {6 symbols for VATrates of VAT class D in format ##.##%}
    Property VATrateD: double read FVATrateD write FVATrateD;
    {6 symbols for VATrates of VAT class E in format ##.##%}
    Property VATrateE: double read FVATrateE write FVATrateE;
    {6 symbols for VATrates of VAT class F in format ##.##%}
    Property VATrateF: double read FVATrateF write FVATrateF;
    {6 symbols for VATrates of VAT class G in format ##.##%}
    Property VATrateG: double read FVATrateG write FVATrateG;
    {6 symbols for VATrates of VAT class H in format ##.##%}
    Property VATrateH: double read FVATrateH write FVATrateH;
    {6 symbols for VATrates of VAT class I in format ##.##%}
    Property VATrateI: double read FVATrateI write FVATrateI;
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
    {Available only if receipt is not closed. Void all sales in receipt and close the fiscal receipt. If payment is started, then finish payment and close the receipt.}
    procedure CancelReceipt();

    {Close the fiscal receipt, paying the due amount in cash}
    procedure CashPayCloseReceipt();

    {Close the fiscal receipt, paying the due amount in cash with sent SMS which includes receipt information.}
    procedure CashPayCloseReceiptWithPhoneNum(TelephoneNumber: WideString);

    {Close the fiscal receipt, paying the due amount in cash with sent SMS which includes receipt information.The first symbols must be either '+' or number. And option for postponed receipt eject/retrack.}
    procedure CashPayCloseReceiptWithPhoneNumRejectRetract(TelephoneNumber: WideString; OptionEjectRetract: OptionEjectRetractEnum; Timeout: double);

    {Clears the display.}
    procedure ClearDisplay();

    {Closes the non-fiscal receipt.}
    procedure CloseNonFiscalReceipt();

    {Close the fiscal receipt and telephone number.}
    procedure CloseReceipt();

    {Closes the opened fiscal receipt with sent SMS which includes receipt information.The first symbols must be either '+' or number. Minimum 2 symbols allowed for telephone number.}
    procedure CloseReceiptWithPhoneNum(TelephoneNumber: WideString);

    {Closes the opened fiscal receipt with sent SMS which includes receipt information.The first symbols must be either '+' or number. Minimum 2 symbols allowed for telephone number.}
    procedure CloseReceiptWithPhoneNumRejectRetract(TelephoneNumber: WideString; OptionEjectRetract: OptionEjectRetractEnum; Timeout: double);

    {Store VAT and Fiscal Memory numbers into the Fiscal memory.}
    procedure ConfirmFiscalization(Password: WideString);

    {Start paper cutter. The command works only in fiscal printer devices.}
    procedure CutPaper();

    {Executes the direct command .}
    function DirectCommand(Input: WideString): WideString;
    {Shows the current date and time on the display.}
    procedure DisplayDateTime();

    {Shows a 20-symbol text in the upper display line.}
    procedure DisplayText1(Text: WideString);

    {Shows a 40-symbol text in the two display lines.}
    procedure DisplayText1and2(Text: WideString);

    {Shows a 20-symbol text in the lower display line.}
    procedure DisplayText2(Text: WideString);

    {Depending of the parameter prints or not barcode at the end of each clients receipt. The Barcode is EAN-13 with format specified by the next command.}
    procedure EnablePrintRecBarcode(OptionPrintingBarcode: OptionPrintingBarcodeEnum);

    {Programs the PLU Category for a certain article (item) from the internal database.}
    procedure EraseAllPLUs(Password: WideString);

    {Open a non-fiscal receipt assigned to the specified operator.}
    procedure OpenNonFiscalReceipt(OperNum: double; OperPass: WideString; OptionFiscalRecieptPrintType: OptionFiscalRecieptPrintTypeEnum);

    {Opens a fiscal receipt assigned to the specified operator or refund receipt.}
    procedure OpenReceipt(OperNum: double; OperPass: WideString; OptionReceipType: OptionReceipTypeEnum; OptionFiscalRcpPrintType: OptionFiscalRcpPrintTypeEnum);

    {Opens a fiscal receipt assigned to the specified operator or refund receipt. Devices with version 2 doesn't support refund option}
    procedure OpenReceipt_V2(OperNum: double; OperPass: WideString; OptionFiscalRcpPrintType: OptionFiscalRcpPrintTypeEnum);

    {Feeds 1 line of paper.}
    procedure PaperFeed();

    {Register the payment in the receipt with specified type of payment and exact amount received.}
    procedure PayExactSum(OptionPaymentType: OptionPaymentTypeEnum);

    {Register the payment in the receipt with specified type of payment and exact amount received.}
    procedure PayExactSumV2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum);

    {Register the payment in the receipt with specified type of payment and exact amount received.}
    procedure PayExactSum_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum);

    {Register the payment in the receipt with specified type of payment and amount received (if the payment type is 0-5 the amount of change due is not obligatory.)}
    procedure Payment(OptionPaymentType: OptionPaymentTypeEnum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);

    {Register the payment in the receipt with specified type of payment and amount received (if the payment type is 0-5 the amount of change due is not obligatory.)}
    procedure Payment_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);

    {Register the payment in the receipt with specified type of payment and amount received (if the payment type is 0-5 the amount of change due is not obligatory.)}
    procedure Payment_V2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);

    {Prints an article report with or without zeroing ('Z' or 'X').}
    procedure PrintArticleReport(OptionZeroing: OptionZeroingEnum);

    {Prints barcode from type stated by CodeType and CodeLen and with data stated in CodeData field.}
    procedure PrintBarcode(OptionCodeType: OptionCodeTypeEnum; CodeLen: double; CodeData: WideString);

    {Print a brief payment FM report by initial and end FM report number.}
    procedure PrintBriefFMPaymentsReportByZNum(StartNum: double; EndNum: double);

    {Print a brief FM report by initial and end date.}
    procedure PrintBriefFMReportByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Print a brief FM report by initial and end FM report number.}
    procedure PrintBriefFMReportByZBlocks(StartZNum: double; EndZNum: double);

    {Depending on the parameter prints:   daily fiscal report with zeroing and fiscal memory record, preceded by Electronic Journal report print ('Z');  daily fiscal report without zeroing ('X');}
    procedure PrintDailyReport(OptionZeroing: OptionZeroingEnum);

    {Prints departments report}
    procedure PrintDepartmentReport(OptionZeroing: OptionZeroingEnum);

    {Prints an extended daily financial report (an article report followed by a daily financial report) with or without zeroing ('Z' or 'X').}
    procedure PrintDetailedDailyReport(OptionZeroing: OptionZeroingEnum);

    {Print a detailed FM payment report by initial and end FM report number.}
    procedure PrintDetailedFMPaymentsReportByZNum(StartNum: double; EndNum: double);

    {Prints a detailed FM report by initial and end date.}
    procedure PrintDetailedFMReportByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Print a detailed FM report by initial and end FM report number.}
    procedure PrintDetailedFMReportByZBlocks(StartNo: double; EndNo: double);

    {Prints out a diagnostic receipt.}
    procedure PrintDiagnostics();

    {Reading/Printing all Electronic Journal report.}
    procedure PrintEJ();

    {Printing Electronic Journal Report from Start Date to End Date.}
    procedure PrintEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime; FlagsTypeRec: WideString);

    {Print Electronic Journal Report by initial and end date, and selected documents content.}
    procedure PrintEJByDateCustom(FlagsTypeRec: WideString; StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Printing Electronic Journal Report from receipt number to receipt number.}
    procedure PrintEJByRcpNum(StartRcpNum: double; EndRcpNum: double; FlagsTypeRec: WideString);

    {Print Electronic Journal Report from receipt number to receipt number and selected documents content.}
    procedure PrintEJByRcpNumCustom(FlagsTypeRec: WideString; StartRcpNum: double; EndRcpNum: double);

    {Printing Electronic Journal Report from report number to report number.}
    procedure PrintEJByZBlocks(StartZNum: double; EndZNum: double; FlagsTypeRec: WideString);

    {Print Electronic Journal Report by number of Z report blocks and selected documents content.}
    procedure PrintEJByZBlocksCustom(FlagsTypeRec: WideString; StartZNum: double; EndZNum: double);

    {Print Electronic Journal report with selected documents content. FlagsTypeRec is a char with bits representing the receipt types.}
    procedure PrintEJCustom(FlagsTypeRec: WideString);

    {Print a copy of the last receipt document issued}
    procedure PrintLastReceiptDuplicate();

    {Print the programmed graphical logo with the stated number.}
    procedure PrintLogo(Number: double);

    {Prints an operator's report for a specified operator (0 = all operators) with or without zeroing ('Z' or 'X').}
    procedure PrintOperatorReport(OptionZeroing: OptionZeroingEnum; Number: double);

    {Prints QR code}
    procedure PrintQRCode(Resolution: double; Data: WideString);

    {Print all special FM events report.}
    procedure PrintSpecialEventsFMreport();

    {Prints a free text.}
    procedure PrintText(Text: WideString);

    {Program the owner's company address.}
    procedure ProgCompanyAddress_V2(CompAddrLen: double; CompanyAddress: WideString);

    {Programs the owner's company name.}
    procedure ProgCompanyName_V2(CompNameLen: double; CompanyName: WideString);

    {Programs the customer DB for special customer receipt issuing.}
    procedure ProgCustomerData(CustomerNum: double; VATNumber: WideString; CustomerCompanyName: WideString; Address: WideString; FreeLine1: WideString; FreeLine2: WideString; FreeLine3: WideString; FreeLine4: WideString);

    {Set data for the stated department number from the internal FD database.}
    procedure ProgDepartment(Number: double; Name: WideString; OptionVATClass: OptionVATClassEnum; Price: double; OptionDepPrice: OptionDepPriceEnum);

    {Program the contents of a Display Greeting message.}
    procedure ProgDisplayGreeting(DisplayGreetingText: WideString);

    {Preprograms the external display.}
    procedure ProgExtDisplay(Password: WideString);

    {Program the contents of a footer lines.}
    procedure ProgFooter(FooterText: WideString);

    {Program the contents of a header lines.}
    procedure ProgHeader(OptionHeaderLine: OptionHeaderLineEnum; HeaderText: WideString);

    {Program the interval of unsent messages}
    procedure ProgIntervalUnsentMsg(Password: WideString; TimeHours: double);

    {Programming a parameter indicating whether the connection of an external printer is mandatory. (only for FP25 devices)}
    procedure ProgMandatoryConnectionExtPrinter(OptionMandatoryConnecting: OptionMandatoryConnectingEnum);

    {Programs the operator's name and password.}
    procedure ProgOperator(Number: double; Name: WideString; Password: WideString);

    {Programs the number of POS, printing of logo, safe box opening, display mode, cutting permission.}
    procedure ProgParameters_ECR(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionEJFontType: OptionEJFontTypeEnum);

    {Programs the number of POS, printing of logo, safe box opening, display mode, cutting permission.}
    procedure ProgParameters_FP(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionEJFontType: OptionEJFontTypeEnum; OptionExternalDisplayMonitoring: OptionExternalDisplayMonitoringEnum);

    {Preprogram the name of the payment type.}
    procedure ProgPayment(OptionPaymentType: OptionPaymentTypeEnum; Name: WideString);

    {Preprogram the name of the payment type.}
    procedure ProgPayment_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum; Name: WideString);

    {Preprogram the name of the payment type.}
    procedure ProgPayment_V2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum; Name: WideString);

    {Program the Barcode number for a certain article (item) from the internal database.}
    procedure ProgPLUbarcode(PLUNum: double; Barcode: WideString);

    {Programs the PLU Category for a certain article (item) from the internal database.}
    procedure ProgPLUcategory(PLUNum: double; Category: double);

    {Programs internal database items.}
    procedure ProgPLUgeneral(PLUNum: double; Name: WideString; Price: double; OptionPrice: OptionPriceEnum; OptionVATClass: OptionVATClassEnum; BelongToDepNum: double; OptionTransaction: OptionTransactionEnum);

    {Program the price for a certain article (item) from the internal database.}
    procedure ProgPLUprice(PLUNum: double; Price: double; OptionPrice: OptionPriceEnum);

    {Program the available quantity for a certain article (item) from the internal database.}
    procedure ProgPLUqty(PLUNum: double; AvailableQuantity: double; OptionQuantityType: OptionQuantityTypeEnum);

    {Program expiration date of the service contract}
    procedure ProgramExpirationServiceContract(Password: WideString; OptionActivation: OptionActivationEnum; ExpiryDate: TDateTime; OptionTypeActivation: OptionTypeActivationEnum);

    {Program phone number for SMS warning message}
    procedure ProgramPhoneNumber(PhoneNo: WideString);

    {Program service contract password}
    procedure ProgramServiceContractPassword(Old_Password: WideString; New_Password: WideString);

    {Program the number of symbols per line.}
    procedure ProgSymbolsPerLine(Password: WideString; OptionLineSymbols: OptionLineSymbolsEnum);

    {Program the contents of the VAT Name.}
    procedure ProgVATNum(VATname: WideString);

    {Store the VAT rates into the fiscal memory.}
    procedure ProgVATrates(Password: WideString; VATrateA: double; VATrateB: double; VATrateC: double; VATrateD: double; VATrateF: double; VATrateG: double; VATrateH: double; VATrateI: double);

    { Reads raw bytes from FP.}
    function RawRead(Count: double; EndChar: WideString): TByteArray;
    { Writes raw bytes to FP }
    procedure RawWrite(Bytes: TByteArray);

    {Provides information about device's Bluetooth password.}
    function ReadBluetooth_Password(): Bluetooth_PasswordRes;
    {Providing information about if the device's Bluetooth module is enabled or disabled.}
    function ReadBluetooth_Status(): OptionBTstatusEnum;
    {Store a brief FM report by initial and end date.}
    procedure ReadBriefFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);

    {Store a brief FM report by initial and end FM report number.}
    procedure ReadBriefFMReportByNum(StartNum: double; EndNum: double);

    {Reads the owner's company address.}
    function ReadCompanyAddress_V2(): CompanyAddress_V2Res;
    {Reads the owner's company name.}
    function ReadCompanyName_V2(): CompanyName_V2Res;
    {Read the current status of the receipt.}
    function ReadCurrentReceiptInfo(): CurrentReceiptInfoRes;
    {Provide information for specified customer from FD database.}
    function ReadCustomerData(CustomerNum: double): CustomerDataRes;
    {Provide information about the amounts on hand by type of payment.}
    function ReadDailyAvailableAmounts_V2(): DailyAvailableAmounts_V2Res;
    {Provide information about the amounts on hand by type of payment.}
    function ReadDailyAvailableAmounts_V2_1(): DailyAvailableAmounts_V2_1Res;
    {Provides information about the current reading of the daily-report- with-zeroing counter, the number of the last block stored in FM, the number of EJ and the date and time of the last block storage in the FM.}
    function ReadDailyCounters(): DailyCountersRes;
    {Read the last operator's report number and date and time.}
    function ReadDailyCountersByOperator(OperNum: double): DailyCountersByOperatorRes;
    {Provides information about the number of customers (number of fiscal receipt issued), number of discounts, additions and corrections made and the accumulated amounts.}
    function ReadDailyGeneralRegistersByOperator(OperNum: double): DailyGeneralRegistersByOperatorRes;
    {Provides information about the PO amounts by type of payment and the total number of operations.}
    function ReadDailyPO(): DailyPORes;
    {Provides information about the amounts received from sales by type of payment and specified operator.}
    function ReadDailyPObyOperator_V2(OperNum: double): DailyPObyOperator_V2Res;
    {Provides information about the amounts received from sales by type of payment and specified operator.}
    function ReadDailyPObyOperator_V2_1(OperNum: double): DailyPObyOperator_V2_1Res;
    {Provides information about the RA amounts by type of payment and the total number of operations.}
    function ReadDailyRA(): DailyRARes;
    {Provides information about the RA by type of payment as well as the total number of operations by specified operator.}
    function ReadDailyRAbyOperator(OperNum: double): DailyRAbyOperatorRes;
    {Provides information about the amounts received from sales by type of payment.}
    function ReadDailyReceivedAmounts_V2(): DailyReceivedAmounts_V2Res;
    {Provides information about the amounts received from sales by type of payment.}
    function ReadDailyReceivedAmounts_V2_1(): DailyReceivedAmounts_V2_1Res;
    {Provides information about the amounts returned as change by different payment types for the specified operator.}
    function ReadDailyReturnedChangeAmountsByOperator_V2(OperNum: double): DailyReturnedChangeAmountsByOperator_V2Res;
    {Provides information about the amounts returned as change by different payment types for the specified operator.}
    function ReadDailyReturnedChangeAmountsByOperator_V2_1(OperNum: double): DailyReturnedChangeAmountsByOperator_V2_1Res;
    {Provide information about the current date and time.}
    function ReadDateTime(): TDateTime;
    {Provides information for the programmed data, the turnover from the stated department number}
    function ReadDepartment(DepNum: double): DepartmentRes;
    {Storage a detailed FM report by initial and end date.}
    procedure ReadDetailedFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);

    {Storage a detailed FM report by initial and end FM report number.}
    procedure ReadDetailedFMReportByZNum(StartNum: double; EndNum: double);

    {Provide an information about modules supported by the device}
    function ReadDeviceModuleSupport(): DeviceModuleSupportRes;
    {Provide an information about modules supported by device's firmware}
    function ReadDeviceModuleSupportByFirmware(): DeviceModuleSupportByFirmwareRes;
    {Provides information about device's DHCP status}
    function ReadDHCP_Status(): OptionDhcpStatusEnum;
    {Provide information about the contents of a Display Greeting message.}
    function ReadDisplayGreetingMessage(): WideString;
    {Reading all Electronic Journal report.}
    procedure ReadEJ();

    {Reading Electronic Journal Report from Start Date to End Date.}
    procedure ReadEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime; FlagsTypeRec: WideString);

    {Read or Store Electronic Journal Report by initial to end date}
    procedure ReadEJByDateCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; reserved: WideString; StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);

    {Reading Electronic Journal Report from receipt number to receipt number.}
    procedure ReadEJByReceiptNum(StartRcpNum: double; EndRcpNum: double; FlagsTypeRec: WideString);

    {Read or Store Electronic Journal Report from receipt number to receipt number, CSV format option and document content. If CSV format is set the content can includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.}
    procedure ReadEJByReceiptNumCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; StartRcpNum: double; EndRcpNum: double);

    {Reading Electronic Journal Report from report number to report number.}
    procedure ReadEJByZBlocks(StartZNum: double; EndZNum: double; FlagsTypeRec: WideString);

    {Read or Store Electronic Journal Report by number of Z report blocks, CSV format option and document content. If CSV format is set the content can includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.}
    procedure ReadEJByZBlocksCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; StartZNum: double; EndZNum: double);

    {Read or Store Electronic Journal report by CSV format option and document content selecting. If CSV format is set the content can includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.}
    procedure ReadEJCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString);

    {Provide information about first unsent receipt to server}
    function ReadFirstUnsentReceiptToServer(): FirstUnsentReceiptToServerRes;
    {Provides consequently information about every single block stored in the FM starting with ACKs and ending with end message.}
    procedure ReadFMcontent();

    {Read the number of the remaining free records for Z-report in the Fiscal Memory.}
    function ReadFMfreeRecords(): WideString;
    {Provide information about the contents of a footer line.}
    function ReadFooter(): WideString;
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
    {Provide information about the contents of a header lines.}
    function ReadHeader(OptionHeaderLine: OptionHeaderLineEnum): HeaderRes;
    {Read the interval of the unsent messages}
    function ReadIntervalUnsentMsg(): IntervalUnsentMsgRes;
    {Read the date and number of the last Z-report and the last RAM reset event.}
    function ReadLastDailyReportInfo(): LastDailyReportInfoRes;
    {Read the daily and progressive counter of last issued receipt.}
    function ReadLastReceiptNum(): LastReceiptNumRes;
    {Read the parameter indicating whether the connection of an external printer is mandatory. (only for FP25 devices)}
    function ReadMandatoryConnectionExtPrinter(): OptionMandatoryConnectingEnum;
    {Read odometer result.  *the command is valid for ADPOS model only.}
    function ReadOdometer(): double;
    {Provide information about operators name and password.}
    function ReadOperatorNameAndPassword(Number: double): OperatorNameAndPasswordRes;
    {Provides information about the PO by type of payment as well as the total number of operations by specified operator}
    function ReadOperPO(OpNo: double): OperPORes;
    {Provides information about the programmed number of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt and enable/disableUSB host mode.}
    function ReadParametersECR(): ParametersECRRes;
    {Provides information about the programmed number of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt and enable/disableUSB host mode.}
    function ReadParametersFP(): ParametersFPRes;
    {Read the all programmed Payment types.}
    function ReadPayments(): PaymentsRes;
    {Read the all programmed Payment types.}
    function ReadPayments_V2(): Payments_V2Res;
    {Read the all programmed Payment types.}
    function ReadPayments_V2_1(): Payments_V2_1Res;
    {Read phone number for SMS warning}
    function ReadPhoneNumber(): WideString;
    {Provides information about the all registers of the specified article.}
    function ReadPLU(PLUNum: double): PLURes;
    {Provides information about the barcode of the specified article.}
    function ReadPLUbarcode(PLUNum: double): PLUbarcodeRes;
    {Provides information about the price and price type of the specified article.}
    function ReadPLUprice(PLUNum: double): PLUpriceRes;
    {Provides information about the quantity registers of the specified article.}
    function ReadPLUqty(PLUNum: double): PLUqtyRes;
    {Provides information about the manufactoring number of the fiscal device.}
    function ReadSerialAndFiscalNums(): SerialAndFiscalNumsRes;
    {Provides information about the manufactoring number of the fiscal device.}
    function ReadSerialAndFiscalNums_V2(): SerialAndFiscalNums_V2Res;
    {Program fiscal server address}
    function ReadServerAddress(): ServerAddressRes;
    {Program expiration date of the service contract}
    function ReadServiceContractActivation(): ServiceContractActivationRes;
    {Read the service contract expiry date}
    function ReadServiceContractExpiryDate(): TDateTime;
    {Reads specific message number}
    function ReadSpecificMessageNumber(MessageNum: WideString): SpecificMessageNumberRes;
    {Provides detailed 5-byte information about the current status of the fiscal printer.}
    function ReadStatusECR(): StatusECRRes;
    {Provides detailed 7-byte information about the current status of the fiscal printer.}
    function ReadStatusFP(): StatusFPRes;
    {Read the number of symbols per line.}
    function ReadSymbolsPerLine(): double;
    {Provides information about device's IP address, subnet mask, gateway address, DNS address.}
    function ReadTCP_Addresses(OptionAddressType: OptionAddressTypeEnum): TCP_AddressesRes;
    {Read device TCP Auto Start status}
    function ReadTCP_AutoStartStatus(): OptionTCPAutoStartEnum;
    {Provides information about device's TCP password.}
    function ReadTCP_Password(): TCP_PasswordRes;
    {Read the used TCP module for communication - Lan or WiFi}
    function ReadTCP_UsedModule(): OptionUsedModuleEnum;
    {Reads all messages from log}
    function ReadTotalMessagesCount(): WideString;
    {Reads the communication module used to communicate with the fiscal server}
    function ReadUsedCommunicationModule(): OptionCommunicationModuleEnum;
    {Provide information about the accumulated amount by VAT group.}
    function ReadVATClassAmounts(): VATClassAmountsRes;
    {Provide information about the contents of the VAT Name.}
    function ReadVATname(): WideString;
    {Provides information about the programmed VAT number.}
    function ReadVATNumber(): WideString;
    {Provides information about the programmed VAT number.}
    function ReadVATNumber_V2(): VATNumber_V2Res;
    {Read the current VAT rates (the last values stored into the FM).}
    function ReadVATrates(): VATratesRes;
    {Provides information about the device model and firmware version.}
    function ReadVersion(): WideString;
    {Read device's connected WiFi network name}
    function ReadWiFi_NetworkName(): WiFi_NetworkNameRes;
    {Read device's connected WiFi network password}
    function ReadWiFi_Password(): WiFi_PasswordRes;
    {Provides information about device's idle timeout. This timeout is seconds in which the connection will be closed when there is an inactivity. This information is available if the device has LAN or WiFi. Maximal value - 7200, minimal value 1. 0 is for never close the connection.}
    function Read_IdleTimeout(): double;
    {Received amount (RA)/ paid out amount (PO) with sign '-' in the specified type of payment assigned to the specified operator.}
    procedure ReceivedOnAccount_PaidOut(OperNum: double; Password: WideString; Amount: double; Text: WideString);

    {Reset odometer function *the command is valid for ADPOS model only.}
    procedure ResetOdometer(Password: WideString);

    {Opens the safe box.}
    procedure SafeBoxOpen();

    {Saves owner's company name and address in the fiscal memory}
    procedure SaveCompanyData_V2(password: WideString);

    {After every change on Idle timeout, LAN/WiFi/GPRS usage, LAN/WiFi/TCP/GPRS password or TCP auto start networks settings this Save command needs to be execute.}
    procedure SaveNetworkSettings();

    {Scan and print all available WiFi networks}
    procedure ScanAndPrintWiFiNetworks();

    {Registers the sale or correction in this department with specified name, price, quantity, VAT group and/or discount/addition on the transaction.}
    procedure SellPLUFromDep(NamePLU: WideString; DepNum: double; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double; NamePLUextension: WideString; AdditionalNamePLU: WideString);

    {Registers the sale or correction of a specified quantity of an article of the internal database of the FD.}
    procedure SellPLUFromFD_DB(OptionSign: OptionSignEnum; PLUNum: double; Quantity: double; DiscAddP: double; DiscAddV: double);

    {Register the sale or correction of article with specified name, price, quantity, VAT group and/or discount/addition on the transaction.}
    procedure SellPLUwithSpecifiedVAT(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double; NamePLUextension: WideString; AdditionalNamePLU: WideString);

    {Sets the number of logo file, which is active and will be printed as logo in the receipt header. Prints Information about active number.}
    procedure SetActiveLogoNum(LogoFileNumber: WideString);

    {Program device's Bluetooth password. To apply use - SaveNetworkSettings()}
    procedure SetBluetooth_Password(PassLength: double; Password: WideString);

    {Program device's Bluetooth module to be enabled or disabled. To apply use -SaveNetworkSettings()}
    procedure SetBluetooth_Status(OptionBTstatus: OptionBTstatusEnum);

    {Sets the date and time and prints the current values using the RECEIPT printer.}
    procedure SetDateTime(DateTime: TDateTime);

    {Program device's network IP address, subnet mask, gateway address, DNS address. To apply use -SaveNetworkSettings()}
    procedure SetDeviceTCP_Addresses(OptionAddressType: OptionAddressTypeEnum; DeviceAddress: WideString);

    {Program device's TCP network DHCP enabled or disabled. To apply use -SaveNetworkSettings()}
    procedure SetDHCP_Enabled(OptionDHCPEnabled: OptionDHCPEnabledEnum);

    {Program device's GPRS APN. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_APN(GPRS_APN_Len: double; APN: WideString);

    {Program device's GPRS password. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_Password(PassLength: double; Password: WideString);

    {Program device's GPRS user name. To apply use - SaveNetworkSettings()}
    procedure SetGPRS_Username(GPRS_Username_Len: double; Username: WideString);

    {Sets device's idle timeout setting. Set timeout for closing the connection if there is an inactivity. Maximal value - 7200, minimal value 1. 0 is for never close the connection. This option can be used only if the device has LAN or WiFi. To apply use - SaveNetworkSettings()}
    procedure SetIdle_Timeout(IdleTimeout: double);

    {Defines the contents of the 18 characters of the barcode, printed in the end of each clients receipt.}
    procedure SetRecbarcodeFormat(CodeForm: WideString);

    {Stores the Manufacturing number into the operative memory.}
    procedure SetSerialNumer(Password: WideString; SerialNum: WideString);

    {Program fiscal server address}
    procedure SetServerAddress(ParamLength: double; Address: WideString);

    {Program device's TCP password. To apply use - SaveNetworkSettings()}
    procedure SetTCPpassword(PassLength: double; Password: WideString);

    {Sets the used TCP module for communication - Lan or WiFi. To apply use -SaveNetworkSettings()}
    procedure SetTCP_ActiveModule(OptionUsedModule: OptionUsedModuleEnum);

    {Set device's TCP autostart . To apply use -SaveNetworkSettings()}
    procedure SetTCP_AutoStart(OptionTCPAutoStart: OptionTCPAutoStartEnum);

    {Sets the communication module used to communicate with the fiscal server  server}
    procedure SetUsedCommunicationModule(OptionCommunicationModule: OptionCommunicationModuleEnum);

    {Stores the VAT and Fiscal Memory number into the operative memory.}
    procedure SetVATAndFiscNums(Password: WideString; VATNo: WideString; FMNo: WideString);

    {Stores the registration numbers into the operative memory.}
    procedure SetVATAndFiscNums_V2(Password: WideString; VATNo: WideString; FMNo: WideString; OptionVATReg: OptionVATRegEnum; UniCode: WideString);

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

    {Register storno of the article with name, price, quantity and VAT Class.}
    procedure StornoPLU(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; Quantity: double);

    {Calculate the subtotal amount with printing and display visualization options. Provide information about values of the calculated amounts. If a percent or value discount/addition has been specified the subtotal and the discount/addition value will be printed regardless the parameter for printing.}
    function Subtotal(OptionPrinting: OptionPrintingEnum; OptionDisplay: OptionDisplayEnum; DiscAddV: double; DiscAddP: double): double;
    {Removes all paired devices. To apply use -SaveNetworkSettings()}
    procedure UnpairAllDevices();

    { Sends client definitions to the server for compatibility. }
    procedure ApplyClientLibraryDefinitions();
  end;

implementation
procedure OptionVATClass_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionVATClassEnum(nam);
  self.Value := val;
end;

procedure OptionDepPrice_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionDepPriceEnum(nam);
  self.Value := val;
end;

procedure OptionHeaderLine_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionHeaderLineEnum(nam);
  self.Value := val;
end;

procedure OptionMandatoryConnecting_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionMandatoryConnectingEnum(nam);
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

procedure OptionEJFontType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionEJFontTypeEnum(nam);
  self.Value := val;
end;

procedure OptionExternalDisplayMonitoring_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionExternalDisplayMonitoringEnum(nam);
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

procedure OptionTypeActivation_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionTypeActivationEnum(nam);
  self.Value := val;
end;

procedure OptionBTstatus_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionBTstatusEnum(nam);
  self.Value := val;
end;

procedure OptionForbiddenVoid_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionForbiddenVoidEnum(nam);
  self.Value := val;
end;

procedure OptionVATinReceipt_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionVATinReceiptEnum(nam);
  self.Value := val;
end;

procedure OptionDetailedReceipt_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionDetailedReceiptEnum(nam);
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

procedure OptionFlagPowerDown_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionFlagPowerDownEnum(nam);
  self.Value := val;
end;

procedure OptionClientReceipt_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionClientReceiptEnum(nam);
  self.Value := val;
end;

procedure OptionRcpChangeType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionRcpChangeTypeEnum(nam);
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

procedure OptionArticleReportType_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionArticleReportTypeEnum(nam);
  self.Value := val;
end;

procedure OptionCurrency_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionCurrencyEnum(nam);
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

procedure OptionCommunicationModule_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionCommunicationModuleEnum(nam);
  self.Value := val;
end;

procedure OptionVATReg_ResEnum.Init(nam: Variant; val: string);
begin
  self.Name := OptionVATRegEnum(nam);
  self.Value := val;
end;


procedure FP.CancelReceipt();
begin
  Execute('CancelReceipt',[]);
end;

procedure FP.CashPayCloseReceipt();
begin
  Execute('CashPayCloseReceipt',[]);
end;

procedure FP.CashPayCloseReceiptWithPhoneNum(TelephoneNumber: WideString);
begin
  Execute('CashPayCloseReceiptWithPhoneNum',['TelephoneNumber',TelephoneNumber]);
end;

procedure FP.CashPayCloseReceiptWithPhoneNumRejectRetract(TelephoneNumber: WideString; OptionEjectRetract: OptionEjectRetractEnum; Timeout: double);
begin
  Execute('CashPayCloseReceiptWithPhoneNumRejectRetract',['TelephoneNumber',TelephoneNumber, 'OptionEjectRetract',OptionEjectRetract, 'Timeout',Timeout]);
end;

procedure FP.ClearDisplay();
begin
  Execute('ClearDisplay',[]);
end;

procedure FP.CloseNonFiscalReceipt();
begin
  Execute('CloseNonFiscalReceipt',[]);
end;

procedure FP.CloseReceipt();
begin
  Execute('CloseReceipt',[]);
end;

procedure FP.CloseReceiptWithPhoneNum(TelephoneNumber: WideString);
begin
  Execute('CloseReceiptWithPhoneNum',['TelephoneNumber',TelephoneNumber]);
end;

procedure FP.CloseReceiptWithPhoneNumRejectRetract(TelephoneNumber: WideString; OptionEjectRetract: OptionEjectRetractEnum; Timeout: double);
begin
  Execute('CloseReceiptWithPhoneNumRejectRetract',['TelephoneNumber',TelephoneNumber, 'OptionEjectRetract',OptionEjectRetract, 'Timeout',Timeout]);
end;

procedure FP.ConfirmFiscalization(Password: WideString);
begin
  Execute('ConfirmFiscalization',['Password',Password]);
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

procedure FP.DisplayText1(Text: WideString);
begin
  Execute('DisplayText1',['Text',Text]);
end;

procedure FP.DisplayText1and2(Text: WideString);
begin
  Execute('DisplayText1and2',['Text',Text]);
end;

procedure FP.DisplayText2(Text: WideString);
begin
  Execute('DisplayText2',['Text',Text]);
end;

procedure FP.EnablePrintRecBarcode(OptionPrintingBarcode: OptionPrintingBarcodeEnum);
begin
  Execute('EnablePrintRecBarcode',['OptionPrintingBarcode',OptionPrintingBarcode]);
end;

procedure FP.EraseAllPLUs(Password: WideString);
begin
  Execute('EraseAllPLUs',['Password',Password]);
end;

procedure FP.OpenNonFiscalReceipt(OperNum: double; OperPass: WideString; OptionFiscalRecieptPrintType: OptionFiscalRecieptPrintTypeEnum);
begin
  Execute('OpenNonFiscalReceipt',['OperNum',OperNum, 'OperPass',OperPass, 'OptionFiscalRecieptPrintType',OptionFiscalRecieptPrintType]);
end;

procedure FP.OpenReceipt(OperNum: double; OperPass: WideString; OptionReceipType: OptionReceipTypeEnum; OptionFiscalRcpPrintType: OptionFiscalRcpPrintTypeEnum);
begin
  Execute('OpenReceipt',['OperNum',OperNum, 'OperPass',OperPass, 'OptionReceipType',OptionReceipType, 'OptionFiscalRcpPrintType',OptionFiscalRcpPrintType]);
end;

procedure FP.OpenReceipt_V2(OperNum: double; OperPass: WideString; OptionFiscalRcpPrintType: OptionFiscalRcpPrintTypeEnum);
begin
  Execute('OpenReceipt_V2',['OperNum',OperNum, 'OperPass',OperPass, 'OptionFiscalRcpPrintType',OptionFiscalRcpPrintType]);
end;

procedure FP.PaperFeed();
begin
  Execute('PaperFeed',[]);
end;

procedure FP.PayExactSum(OptionPaymentType: OptionPaymentTypeEnum);
begin
  Execute('PayExactSum',['OptionPaymentType',OptionPaymentType]);
end;

procedure FP.PayExactSumV2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum);
begin
  Execute('PayExactSumV2_1',['OptionPaymentTypeV2_1',OptionPaymentTypeV2_1]);
end;

procedure FP.PayExactSum_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum);
begin
  Execute('PayExactSum_V2',['OptionPaymentTypeV2',OptionPaymentTypeV2]);
end;

procedure FP.Payment(OptionPaymentType: OptionPaymentTypeEnum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);
begin
  Execute('Payment',['OptionPaymentType',OptionPaymentType, 'OptionChange',OptionChange, 'Amount',Amount, 'OptionChangeType',OptionChangeType]);
end;

procedure FP.Payment_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);
begin
  Execute('Payment_V2',['OptionPaymentTypeV2',OptionPaymentTypeV2, 'OptionChange',OptionChange, 'Amount',Amount, 'OptionChangeType',OptionChangeType]);
end;

procedure FP.Payment_V2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum; OptionChange: OptionChangeEnum; Amount: double; OptionChangeType: OptionChangeTypeEnum);
begin
  Execute('Payment_V2_1',['OptionPaymentTypeV2_1',OptionPaymentTypeV2_1, 'OptionChange',OptionChange, 'Amount',Amount, 'OptionChangeType',OptionChangeType]);
end;

procedure FP.PrintArticleReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintArticleReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintBarcode(OptionCodeType: OptionCodeTypeEnum; CodeLen: double; CodeData: WideString);
begin
  Execute('PrintBarcode',['OptionCodeType',OptionCodeType, 'CodeLen',CodeLen, 'CodeData',CodeData]);
end;

procedure FP.PrintBriefFMPaymentsReportByZNum(StartNum: double; EndNum: double);
begin
  Execute('PrintBriefFMPaymentsReportByZNum',['StartNum',StartNum, 'EndNum',EndNum]);
end;

procedure FP.PrintBriefFMReportByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('PrintBriefFMReportByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.PrintBriefFMReportByZBlocks(StartZNum: double; EndZNum: double);
begin
  Execute('PrintBriefFMReportByZBlocks',['StartZNum',StartZNum, 'EndZNum',EndZNum]);
end;

procedure FP.PrintDailyReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintDailyReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintDepartmentReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintDepartmentReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintDetailedDailyReport(OptionZeroing: OptionZeroingEnum);
begin
  Execute('PrintDetailedDailyReport',['OptionZeroing',OptionZeroing]);
end;

procedure FP.PrintDetailedFMPaymentsReportByZNum(StartNum: double; EndNum: double);
begin
  Execute('PrintDetailedFMPaymentsReportByZNum',['StartNum',StartNum, 'EndNum',EndNum]);
end;

procedure FP.PrintDetailedFMReportByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('PrintDetailedFMReportByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.PrintDetailedFMReportByZBlocks(StartNo: double; EndNo: double);
begin
  Execute('PrintDetailedFMReportByZBlocks',['StartNo',StartNo, 'EndNo',EndNo]);
end;

procedure FP.PrintDiagnostics();
begin
  Execute('PrintDiagnostics',[]);
end;

procedure FP.PrintEJ();
begin
  Execute('PrintEJ',[]);
end;

procedure FP.PrintEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime; FlagsTypeRec: WideString);
begin
  Execute('PrintEJByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.PrintEJByDateCustom(FlagsTypeRec: WideString; StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('PrintEJByDateCustom',['FlagsTypeRec',FlagsTypeRec, 'StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.PrintEJByRcpNum(StartRcpNum: double; EndRcpNum: double; FlagsTypeRec: WideString);
begin
  Execute('PrintEJByRcpNum',['StartRcpNum',StartRcpNum, 'EndRcpNum',EndRcpNum, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.PrintEJByRcpNumCustom(FlagsTypeRec: WideString; StartRcpNum: double; EndRcpNum: double);
begin
  Execute('PrintEJByRcpNumCustom',['FlagsTypeRec',FlagsTypeRec, 'StartRcpNum',StartRcpNum, 'EndRcpNum',EndRcpNum]);
end;

procedure FP.PrintEJByZBlocks(StartZNum: double; EndZNum: double; FlagsTypeRec: WideString);
begin
  Execute('PrintEJByZBlocks',['StartZNum',StartZNum, 'EndZNum',EndZNum, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.PrintEJByZBlocksCustom(FlagsTypeRec: WideString; StartZNum: double; EndZNum: double);
begin
  Execute('PrintEJByZBlocksCustom',['FlagsTypeRec',FlagsTypeRec, 'StartZNum',StartZNum, 'EndZNum',EndZNum]);
end;

procedure FP.PrintEJCustom(FlagsTypeRec: WideString);
begin
  Execute('PrintEJCustom',['FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.PrintLastReceiptDuplicate();
begin
  Execute('PrintLastReceiptDuplicate',[]);
end;

procedure FP.PrintLogo(Number: double);
begin
  Execute('PrintLogo',['Number',Number]);
end;

procedure FP.PrintOperatorReport(OptionZeroing: OptionZeroingEnum; Number: double);
begin
  Execute('PrintOperatorReport',['OptionZeroing',OptionZeroing, 'Number',Number]);
end;

procedure FP.PrintQRCode(Resolution: double; Data: WideString);
begin
  Execute('PrintQRCode',['Resolution',Resolution, 'Data',Data]);
end;

procedure FP.PrintSpecialEventsFMreport();
begin
  Execute('PrintSpecialEventsFMreport',[]);
end;

procedure FP.PrintText(Text: WideString);
begin
  Execute('PrintText',['Text',Text]);
end;

procedure FP.ProgCompanyAddress_V2(CompAddrLen: double; CompanyAddress: WideString);
begin
  Execute('ProgCompanyAddress_V2',['CompAddrLen',CompAddrLen, 'CompanyAddress',CompanyAddress]);
end;

procedure FP.ProgCompanyName_V2(CompNameLen: double; CompanyName: WideString);
begin
  Execute('ProgCompanyName_V2',['CompNameLen',CompNameLen, 'CompanyName',CompanyName]);
end;

procedure FP.ProgCustomerData(CustomerNum: double; VATNumber: WideString; CustomerCompanyName: WideString; Address: WideString; FreeLine1: WideString; FreeLine2: WideString; FreeLine3: WideString; FreeLine4: WideString);
begin
  Execute('ProgCustomerData',['CustomerNum',CustomerNum, 'VATNumber',VATNumber, 'CustomerCompanyName',CustomerCompanyName, 'Address',Address, 'FreeLine1',FreeLine1, 'FreeLine2',FreeLine2, 'FreeLine3',FreeLine3, 'FreeLine4',FreeLine4]);
end;

procedure FP.ProgDepartment(Number: double; Name: WideString; OptionVATClass: OptionVATClassEnum; Price: double; OptionDepPrice: OptionDepPriceEnum);
begin
  Execute('ProgDepartment',['Number',Number, 'Name',Name, 'OptionVATClass',OptionVATClass, 'Price',Price, 'OptionDepPrice',OptionDepPrice]);
end;

procedure FP.ProgDisplayGreeting(DisplayGreetingText: WideString);
begin
  Execute('ProgDisplayGreeting',['DisplayGreetingText',DisplayGreetingText]);
end;

procedure FP.ProgExtDisplay(Password: WideString);
begin
  Execute('ProgExtDisplay',['Password',Password]);
end;

procedure FP.ProgFooter(FooterText: WideString);
begin
  Execute('ProgFooter',['FooterText',FooterText]);
end;

procedure FP.ProgHeader(OptionHeaderLine: OptionHeaderLineEnum; HeaderText: WideString);
begin
  Execute('ProgHeader',['OptionHeaderLine',OptionHeaderLine, 'HeaderText',HeaderText]);
end;

procedure FP.ProgIntervalUnsentMsg(Password: WideString; TimeHours: double);
begin
  Execute('ProgIntervalUnsentMsg',['Password',Password, 'TimeHours',TimeHours]);
end;

procedure FP.ProgMandatoryConnectionExtPrinter(OptionMandatoryConnecting: OptionMandatoryConnectingEnum);
begin
  Execute('ProgMandatoryConnectionExtPrinter',['OptionMandatoryConnecting',OptionMandatoryConnecting]);
end;

procedure FP.ProgOperator(Number: double; Name: WideString; Password: WideString);
begin
  Execute('ProgOperator',['Number',Number, 'Name',Name, 'Password',Password]);
end;

procedure FP.ProgParameters_ECR(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionEJFontType: OptionEJFontTypeEnum);
begin
  Execute('ProgParameters_ECR',['POSNum',POSNum, 'OptionPrintLogo',OptionPrintLogo, 'OptionAutoOpenDrawer',OptionAutoOpenDrawer, 'OptionAutoCut',OptionAutoCut, 'OptionExternalDispManagement',OptionExternalDispManagement, 'OptionEJFontType',OptionEJFontType]);
end;

procedure FP.ProgParameters_FP(POSNum: double; OptionPrintLogo: OptionPrintLogoEnum; OptionAutoOpenDrawer: OptionAutoOpenDrawerEnum; OptionAutoCut: OptionAutoCutEnum; OptionExternalDispManagement: OptionExternalDispManagementEnum; OptionEJFontType: OptionEJFontTypeEnum; OptionExternalDisplayMonitoring: OptionExternalDisplayMonitoringEnum);
begin
  Execute('ProgParameters_FP',['POSNum',POSNum, 'OptionPrintLogo',OptionPrintLogo, 'OptionAutoOpenDrawer',OptionAutoOpenDrawer, 'OptionAutoCut',OptionAutoCut, 'OptionExternalDispManagement',OptionExternalDispManagement, 'OptionEJFontType',OptionEJFontType, 'OptionExternalDisplayMonitoring',OptionExternalDisplayMonitoring]);
end;

procedure FP.ProgPayment(OptionPaymentType: OptionPaymentTypeEnum; Name: WideString);
begin
  Execute('ProgPayment',['OptionPaymentType',OptionPaymentType, 'Name',Name]);
end;

procedure FP.ProgPayment_V2(OptionPaymentTypeV2: OptionPaymentTypeV2Enum; Name: WideString);
begin
  Execute('ProgPayment_V2',['OptionPaymentTypeV2',OptionPaymentTypeV2, 'Name',Name]);
end;

procedure FP.ProgPayment_V2_1(OptionPaymentTypeV2_1: OptionPaymentTypeV2_1Enum; Name: WideString);
begin
  Execute('ProgPayment_V2_1',['OptionPaymentTypeV2_1',OptionPaymentTypeV2_1, 'Name',Name]);
end;

procedure FP.ProgPLUbarcode(PLUNum: double; Barcode: WideString);
begin
  Execute('ProgPLUbarcode',['PLUNum',PLUNum, 'Barcode',Barcode]);
end;

procedure FP.ProgPLUcategory(PLUNum: double; Category: double);
begin
  Execute('ProgPLUcategory',['PLUNum',PLUNum, 'Category',Category]);
end;

procedure FP.ProgPLUgeneral(PLUNum: double; Name: WideString; Price: double; OptionPrice: OptionPriceEnum; OptionVATClass: OptionVATClassEnum; BelongToDepNum: double; OptionTransaction: OptionTransactionEnum);
begin
  Execute('ProgPLUgeneral',['PLUNum',PLUNum, 'Name',Name, 'Price',Price, 'OptionPrice',OptionPrice, 'OptionVATClass',OptionVATClass, 'BelongToDepNum',BelongToDepNum, 'OptionTransaction',OptionTransaction]);
end;

procedure FP.ProgPLUprice(PLUNum: double; Price: double; OptionPrice: OptionPriceEnum);
begin
  Execute('ProgPLUprice',['PLUNum',PLUNum, 'Price',Price, 'OptionPrice',OptionPrice]);
end;

procedure FP.ProgPLUqty(PLUNum: double; AvailableQuantity: double; OptionQuantityType: OptionQuantityTypeEnum);
begin
  Execute('ProgPLUqty',['PLUNum',PLUNum, 'AvailableQuantity',AvailableQuantity, 'OptionQuantityType',OptionQuantityType]);
end;

procedure FP.ProgramExpirationServiceContract(Password: WideString; OptionActivation: OptionActivationEnum; ExpiryDate: TDateTime; OptionTypeActivation: OptionTypeActivationEnum);
begin
  Execute('ProgramExpirationServiceContract',['Password',Password, 'OptionActivation',OptionActivation, 'ExpiryDate',ExpiryDate, 'OptionTypeActivation',OptionTypeActivation]);
end;

procedure FP.ProgramPhoneNumber(PhoneNo: WideString);
begin
  Execute('ProgramPhoneNumber',['PhoneNo',PhoneNo]);
end;

procedure FP.ProgramServiceContractPassword(Old_Password: WideString; New_Password: WideString);
begin
  Execute('ProgramServiceContractPassword',['Old_Password',Old_Password, 'New_Password',New_Password]);
end;

procedure FP.ProgSymbolsPerLine(Password: WideString; OptionLineSymbols: OptionLineSymbolsEnum);
begin
  Execute('ProgSymbolsPerLine',['Password',Password, 'OptionLineSymbols',OptionLineSymbols]);
end;

procedure FP.ProgVATNum(VATname: WideString);
begin
  Execute('ProgVATNum',['VATname',VATname]);
end;

procedure FP.ProgVATrates(Password: WideString; VATrateA: double; VATrateB: double; VATrateC: double; VATrateD: double; VATrateF: double; VATrateG: double; VATrateH: double; VATrateI: double);
begin
  Execute('ProgVATrates',['Password',Password, 'VATrateA',VATrateA, 'VATrateB',VATrateB, 'VATrateC',VATrateC, 'VATrateD',VATrateD, 'VATrateF',VATrateF, 'VATrateG',VATrateG, 'VATrateH',VATrateH, 'VATrateI',VATrateI]);
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

procedure FP.ReadBriefFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);
begin
  Execute('ReadBriefFMReportByDate',['StartDate',StartDate, 'EndDate',EndDate]);
end;

procedure FP.ReadBriefFMReportByNum(StartNum: double; EndNum: double);
begin
  Execute('ReadBriefFMReportByNum',['StartNum',StartNum, 'EndNum',EndNum]);
end;

function FP.ReadCompanyAddress_V2(): CompanyAddress_V2Res;
begin
  Result := createRes(CompanyAddress_V2Res, Execute('ReadCompanyAddress_V2',[])) as CompanyAddress_V2Res;
end;

function FP.ReadCompanyName_V2(): CompanyName_V2Res;
begin
  Result := createRes(CompanyName_V2Res, Execute('ReadCompanyName_V2',[])) as CompanyName_V2Res;
end;

function FP.ReadCurrentReceiptInfo(): CurrentReceiptInfoRes;
begin
  Result := createRes(CurrentReceiptInfoRes, Execute('ReadCurrentReceiptInfo',[])) as CurrentReceiptInfoRes;
end;

function FP.ReadCustomerData(CustomerNum: double): CustomerDataRes;
begin
  Result := createRes(CustomerDataRes, Execute('ReadCustomerData',['CustomerNum',CustomerNum])) as CustomerDataRes;
end;

function FP.ReadDailyAvailableAmounts_V2(): DailyAvailableAmounts_V2Res;
begin
  Result := createRes(DailyAvailableAmounts_V2Res, Execute('ReadDailyAvailableAmounts_V2',[])) as DailyAvailableAmounts_V2Res;
end;

function FP.ReadDailyAvailableAmounts_V2_1(): DailyAvailableAmounts_V2_1Res;
begin
  Result := createRes(DailyAvailableAmounts_V2_1Res, Execute('ReadDailyAvailableAmounts_V2_1',[])) as DailyAvailableAmounts_V2_1Res;
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

function FP.ReadDailyPObyOperator_V2(OperNum: double): DailyPObyOperator_V2Res;
begin
  Result := createRes(DailyPObyOperator_V2Res, Execute('ReadDailyPObyOperator_V2',['OperNum',OperNum])) as DailyPObyOperator_V2Res;
end;

function FP.ReadDailyPObyOperator_V2_1(OperNum: double): DailyPObyOperator_V2_1Res;
begin
  Result := createRes(DailyPObyOperator_V2_1Res, Execute('ReadDailyPObyOperator_V2_1',['OperNum',OperNum])) as DailyPObyOperator_V2_1Res;
end;

function FP.ReadDailyRA(): DailyRARes;
begin
  Result := createRes(DailyRARes, Execute('ReadDailyRA',[])) as DailyRARes;
end;

function FP.ReadDailyRAbyOperator(OperNum: double): DailyRAbyOperatorRes;
begin
  Result := createRes(DailyRAbyOperatorRes, Execute('ReadDailyRAbyOperator',['OperNum',OperNum])) as DailyRAbyOperatorRes;
end;

function FP.ReadDailyReceivedAmounts_V2(): DailyReceivedAmounts_V2Res;
begin
  Result := createRes(DailyReceivedAmounts_V2Res, Execute('ReadDailyReceivedAmounts_V2',[])) as DailyReceivedAmounts_V2Res;
end;

function FP.ReadDailyReceivedAmounts_V2_1(): DailyReceivedAmounts_V2_1Res;
begin
  Result := createRes(DailyReceivedAmounts_V2_1Res, Execute('ReadDailyReceivedAmounts_V2_1',[])) as DailyReceivedAmounts_V2_1Res;
end;

function FP.ReadDailyReturnedChangeAmountsByOperator_V2(OperNum: double): DailyReturnedChangeAmountsByOperator_V2Res;
begin
  Result := createRes(DailyReturnedChangeAmountsByOperator_V2Res, Execute('ReadDailyReturnedChangeAmountsByOperator_V2',['OperNum',OperNum])) as DailyReturnedChangeAmountsByOperator_V2Res;
end;

function FP.ReadDailyReturnedChangeAmountsByOperator_V2_1(OperNum: double): DailyReturnedChangeAmountsByOperator_V2_1Res;
begin
  Result := createRes(DailyReturnedChangeAmountsByOperator_V2_1Res, Execute('ReadDailyReturnedChangeAmountsByOperator_V2_1',['OperNum',OperNum])) as DailyReturnedChangeAmountsByOperator_V2_1Res;
end;

function FP.ReadDateTime(): TDateTime;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadDateTime',[])) as DummyCoreObject).Value;
end;

function FP.ReadDepartment(DepNum: double): DepartmentRes;
begin
  Result := createRes(DepartmentRes, Execute('ReadDepartment',['DepNum',DepNum])) as DepartmentRes;
end;

procedure FP.ReadDetailedFMReportByDate(StartDate: TDateTime; EndDate: TDateTime);
begin
  Execute('ReadDetailedFMReportByDate',['StartDate',StartDate, 'EndDate',EndDate]);
end;

procedure FP.ReadDetailedFMReportByZNum(StartNum: double; EndNum: double);
begin
  Execute('ReadDetailedFMReportByZNum',['StartNum',StartNum, 'EndNum',EndNum]);
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

procedure FP.ReadEJByDate(StartRepFromDate: TDateTime; EndRepFromDate: TDateTime; FlagsTypeRec: WideString);
begin
  Execute('ReadEJByDate',['StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.ReadEJByDateCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; reserved: WideString; StartRepFromDate: TDateTime; EndRepFromDate: TDateTime);
begin
  Execute('ReadEJByDateCustom',['OptionStorageReport',OptionStorageReport, 'FlagsTypeRec',FlagsTypeRec, 'reserved',reserved, 'StartRepFromDate',StartRepFromDate, 'EndRepFromDate',EndRepFromDate]);
end;

procedure FP.ReadEJByReceiptNum(StartRcpNum: double; EndRcpNum: double; FlagsTypeRec: WideString);
begin
  Execute('ReadEJByReceiptNum',['StartRcpNum',StartRcpNum, 'EndRcpNum',EndRcpNum, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.ReadEJByReceiptNumCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; StartRcpNum: double; EndRcpNum: double);
begin
  Execute('ReadEJByReceiptNumCustom',['OptionStorageReport',OptionStorageReport, 'FlagsTypeRec',FlagsTypeRec, 'StartRcpNum',StartRcpNum, 'EndRcpNum',EndRcpNum]);
end;

procedure FP.ReadEJByZBlocks(StartZNum: double; EndZNum: double; FlagsTypeRec: WideString);
begin
  Execute('ReadEJByZBlocks',['StartZNum',StartZNum, 'EndZNum',EndZNum, 'FlagsTypeRec',FlagsTypeRec]);
end;

procedure FP.ReadEJByZBlocksCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString; StartZNum: double; EndZNum: double);
begin
  Execute('ReadEJByZBlocksCustom',['OptionStorageReport',OptionStorageReport, 'FlagsTypeRec',FlagsTypeRec, 'StartZNum',StartZNum, 'EndZNum',EndZNum]);
end;

procedure FP.ReadEJCustom(OptionStorageReport: OptionStorageReportEnum; FlagsTypeRec: WideString);
begin
  Execute('ReadEJCustom',['OptionStorageReport',OptionStorageReport, 'FlagsTypeRec',FlagsTypeRec]);
end;

function FP.ReadFirstUnsentReceiptToServer(): FirstUnsentReceiptToServerRes;
begin
  Result := createRes(FirstUnsentReceiptToServerRes, Execute('ReadFirstUnsentReceiptToServer',[])) as FirstUnsentReceiptToServerRes;
end;

procedure FP.ReadFMcontent();
begin
  Execute('ReadFMcontent',[]);
end;

function FP.ReadFMfreeRecords(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadFMfreeRecords',[])) as DummyCoreObject).Value;
end;

function FP.ReadFooter(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadFooter',[])) as DummyCoreObject).Value;
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

function FP.ReadIntervalUnsentMsg(): IntervalUnsentMsgRes;
begin
  Result := createRes(IntervalUnsentMsgRes, Execute('ReadIntervalUnsentMsg',[])) as IntervalUnsentMsgRes;
end;

function FP.ReadLastDailyReportInfo(): LastDailyReportInfoRes;
begin
  Result := createRes(LastDailyReportInfoRes, Execute('ReadLastDailyReportInfo',[])) as LastDailyReportInfoRes;
end;

function FP.ReadLastReceiptNum(): LastReceiptNumRes;
begin
  Result := createRes(LastReceiptNumRes, Execute('ReadLastReceiptNum',[])) as LastReceiptNumRes;
end;

function FP.ReadMandatoryConnectionExtPrinter(): OptionMandatoryConnectingEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadMandatoryConnectionExtPrinter',[])) as DummyCoreObject).Value;
end;

function FP.ReadOdometer(): double;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadOdometer',[])) as DummyCoreObject).Value;
end;

function FP.ReadOperatorNameAndPassword(Number: double): OperatorNameAndPasswordRes;
begin
  Result := createRes(OperatorNameAndPasswordRes, Execute('ReadOperatorNameAndPassword',['Number',Number])) as OperatorNameAndPasswordRes;
end;

function FP.ReadOperPO(OpNo: double): OperPORes;
begin
  Result := createRes(OperPORes, Execute('ReadOperPO',['OpNo',OpNo])) as OperPORes;
end;

function FP.ReadParametersECR(): ParametersECRRes;
begin
  Result := createRes(ParametersECRRes, Execute('ReadParametersECR',[])) as ParametersECRRes;
end;

function FP.ReadParametersFP(): ParametersFPRes;
begin
  Result := createRes(ParametersFPRes, Execute('ReadParametersFP',[])) as ParametersFPRes;
end;

function FP.ReadPayments(): PaymentsRes;
begin
  Result := createRes(PaymentsRes, Execute('ReadPayments',[])) as PaymentsRes;
end;

function FP.ReadPayments_V2(): Payments_V2Res;
begin
  Result := createRes(Payments_V2Res, Execute('ReadPayments_V2',[])) as Payments_V2Res;
end;

function FP.ReadPayments_V2_1(): Payments_V2_1Res;
begin
  Result := createRes(Payments_V2_1Res, Execute('ReadPayments_V2_1',[])) as Payments_V2_1Res;
end;

function FP.ReadPhoneNumber(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadPhoneNumber',[])) as DummyCoreObject).Value;
end;

function FP.ReadPLU(PLUNum: double): PLURes;
begin
  Result := createRes(PLURes, Execute('ReadPLU',['PLUNum',PLUNum])) as PLURes;
end;

function FP.ReadPLUbarcode(PLUNum: double): PLUbarcodeRes;
begin
  Result := createRes(PLUbarcodeRes, Execute('ReadPLUbarcode',['PLUNum',PLUNum])) as PLUbarcodeRes;
end;

function FP.ReadPLUprice(PLUNum: double): PLUpriceRes;
begin
  Result := createRes(PLUpriceRes, Execute('ReadPLUprice',['PLUNum',PLUNum])) as PLUpriceRes;
end;

function FP.ReadPLUqty(PLUNum: double): PLUqtyRes;
begin
  Result := createRes(PLUqtyRes, Execute('ReadPLUqty',['PLUNum',PLUNum])) as PLUqtyRes;
end;

function FP.ReadSerialAndFiscalNums(): SerialAndFiscalNumsRes;
begin
  Result := createRes(SerialAndFiscalNumsRes, Execute('ReadSerialAndFiscalNums',[])) as SerialAndFiscalNumsRes;
end;

function FP.ReadSerialAndFiscalNums_V2(): SerialAndFiscalNums_V2Res;
begin
  Result := createRes(SerialAndFiscalNums_V2Res, Execute('ReadSerialAndFiscalNums_V2',[])) as SerialAndFiscalNums_V2Res;
end;

function FP.ReadServerAddress(): ServerAddressRes;
begin
  Result := createRes(ServerAddressRes, Execute('ReadServerAddress',[])) as ServerAddressRes;
end;

function FP.ReadServiceContractActivation(): ServiceContractActivationRes;
begin
  Result := createRes(ServiceContractActivationRes, Execute('ReadServiceContractActivation',[])) as ServiceContractActivationRes;
end;

function FP.ReadServiceContractExpiryDate(): TDateTime;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadServiceContractExpiryDate',[])) as DummyCoreObject).Value;
end;

function FP.ReadSpecificMessageNumber(MessageNum: WideString): SpecificMessageNumberRes;
begin
  Result := createRes(SpecificMessageNumberRes, Execute('ReadSpecificMessageNumber',['MessageNum',MessageNum])) as SpecificMessageNumberRes;
end;

function FP.ReadStatusECR(): StatusECRRes;
begin
  Result := createRes(StatusECRRes, Execute('ReadStatusECR',[])) as StatusECRRes;
end;

function FP.ReadStatusFP(): StatusFPRes;
begin
  Result := createRes(StatusFPRes, Execute('ReadStatusFP',[])) as StatusFPRes;
end;

function FP.ReadSymbolsPerLine(): double;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadSymbolsPerLine',[])) as DummyCoreObject).Value;
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

function FP.ReadTotalMessagesCount(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadTotalMessagesCount',[])) as DummyCoreObject).Value;
end;

function FP.ReadUsedCommunicationModule(): OptionCommunicationModuleEnum;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadUsedCommunicationModule',[])) as DummyCoreObject).Value;
end;

function FP.ReadVATClassAmounts(): VATClassAmountsRes;
begin
  Result := createRes(VATClassAmountsRes, Execute('ReadVATClassAmounts',[])) as VATClassAmountsRes;
end;

function FP.ReadVATname(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadVATname',[])) as DummyCoreObject).Value;
end;

function FP.ReadVATNumber(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadVATNumber',[])) as DummyCoreObject).Value;
end;

function FP.ReadVATNumber_V2(): VATNumber_V2Res;
begin
  Result := createRes(VATNumber_V2Res, Execute('ReadVATNumber_V2',[])) as VATNumber_V2Res;
end;

function FP.ReadVATrates(): VATratesRes;
begin
  Result := createRes(VATratesRes, Execute('ReadVATrates',[])) as VATratesRes;
end;

function FP.ReadVersion(): WideString;
begin
  Result := (createRes(DummyCoreObject, Execute('ReadVersion',[])) as DummyCoreObject).Value;
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

procedure FP.ReceivedOnAccount_PaidOut(OperNum: double; Password: WideString; Amount: double; Text: WideString);
begin
  Execute('ReceivedOnAccount_PaidOut',['OperNum',OperNum, 'Password',Password, 'Amount',Amount, 'Text',Text]);
end;

procedure FP.ResetOdometer(Password: WideString);
begin
  Execute('ResetOdometer',['Password',Password]);
end;

procedure FP.SafeBoxOpen();
begin
  Execute('SafeBoxOpen',[]);
end;

procedure FP.SaveCompanyData_V2(password: WideString);
begin
  Execute('SaveCompanyData_V2',['password',password]);
end;

procedure FP.SaveNetworkSettings();
begin
  Execute('SaveNetworkSettings',[]);
end;

procedure FP.ScanAndPrintWiFiNetworks();
begin
  Execute('ScanAndPrintWiFiNetworks',[]);
end;

procedure FP.SellPLUFromDep(NamePLU: WideString; DepNum: double; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double; NamePLUextension: WideString; AdditionalNamePLU: WideString);
begin
  Execute('SellPLUFromDep',['NamePLU',NamePLU, 'DepNum',DepNum, 'Price',Price, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV, 'NamePLUextension',NamePLUextension, 'AdditionalNamePLU',AdditionalNamePLU]);
end;

procedure FP.SellPLUFromFD_DB(OptionSign: OptionSignEnum; PLUNum: double; Quantity: double; DiscAddP: double; DiscAddV: double);
begin
  Execute('SellPLUFromFD_DB',['OptionSign',OptionSign, 'PLUNum',PLUNum, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV]);
end;

procedure FP.SellPLUwithSpecifiedVAT(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; Quantity: double; DiscAddP: double; DiscAddV: double; NamePLUextension: WideString; AdditionalNamePLU: WideString);
begin
  Execute('SellPLUwithSpecifiedVAT',['NamePLU',NamePLU, 'OptionVATClass',OptionVATClass, 'Price',Price, 'Quantity',Quantity, 'DiscAddP',DiscAddP, 'DiscAddV',DiscAddV, 'NamePLUextension',NamePLUextension, 'AdditionalNamePLU',AdditionalNamePLU]);
end;

procedure FP.SetActiveLogoNum(LogoFileNumber: WideString);
begin
  Execute('SetActiveLogoNum',['LogoFileNumber',LogoFileNumber]);
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

procedure FP.SetIdle_Timeout(IdleTimeout: double);
begin
  Execute('SetIdle_Timeout',['IdleTimeout',IdleTimeout]);
end;

procedure FP.SetRecbarcodeFormat(CodeForm: WideString);
begin
  Execute('SetRecbarcodeFormat',['CodeForm',CodeForm]);
end;

procedure FP.SetSerialNumer(Password: WideString; SerialNum: WideString);
begin
  Execute('SetSerialNumer',['Password',Password, 'SerialNum',SerialNum]);
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

procedure FP.SetUsedCommunicationModule(OptionCommunicationModule: OptionCommunicationModuleEnum);
begin
  Execute('SetUsedCommunicationModule',['OptionCommunicationModule',OptionCommunicationModule]);
end;

procedure FP.SetVATAndFiscNums(Password: WideString; VATNo: WideString; FMNo: WideString);
begin
  Execute('SetVATAndFiscNums',['Password',Password, 'VATNo',VATNo, 'FMNo',FMNo]);
end;

procedure FP.SetVATAndFiscNums_V2(Password: WideString; VATNo: WideString; FMNo: WideString; OptionVATReg: OptionVATRegEnum; UniCode: WideString);
begin
  Execute('SetVATAndFiscNums_V2',['Password',Password, 'VATNo',VATNo, 'FMNo',FMNo, 'OptionVATReg',OptionVATReg, 'UniCode',UniCode]);
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

procedure FP.StornoPLU(NamePLU: WideString; OptionVATClass: OptionVATClassEnum; Price: double; Quantity: double);
begin
  Execute('StornoPLU',['NamePLU',NamePLU, 'OptionVATClass',OptionVATClass, 'Price',Price, 'Quantity',Quantity]);
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
sXX := '<Defs><ServerStartupSettings>  <Encoding CodePage="1251" EncodingName="Cyrillic (Windows)" />  <GenerationTimeStamp>2403121055</GenerationTimeStamp>  <SignalFD>0</SignalFD>  <SilentFindDevice>0</SilentFindDevice>  <EM>0</EM> </ServerStartupSettings><Comma'+
'nd Name="CancelReceipt" CmdByte="0x39"><FPOperation>Available only if receipt is not closed. Void all sales in receipt and close the fiscal receipt. If payment is started, then finish payment and close the receipt.</FPOperation></Command><Command Name="Ca'+
'shPayCloseReceipt" CmdByte="0x36"><FPOperation>Close the fiscal receipt, paying the due amount in cash</FPOperation></Command><Command Name="CashPayCloseReceiptWithPhoneNum" CmdByte="0x36"><FPOperation>Close the fiscal receipt, paying the due amount in ca'+
'sh with sent SMS which includes receipt information.</FPOperation><Args><Arg Name="TelephoneNumber" Value="" Type="Text" MaxLen="20"><Desc>Up to 20 symbols for telephone number</Desc></Arg><ArgsFormatRaw><![CDATA[ <TelephoneNumber[20]> ]]></ArgsFormatRaw>'+
'</Args></Command><Command Name="CashPayCloseReceiptWithPhoneNumRejectRetract" CmdByte="0x36"><FPOperation>Close the fiscal receipt, paying the due amount in cash with sent SMS which includes receipt information.The first symbols must be either ''+'' or nu'+
'mber. And option for postponed receipt eject/retrack.</FPOperation><Args><Arg Name="TelephoneNumber" Value="" Type="Text" MaxLen="20"><Desc>1..20 symbols for telephone number</Desc></Arg><Arg Name="OptionEjectRetract" Value="" Type="Option" MaxLen="1"><Op'+
'tions><Option Name="for postponed receipt eject" Value="e" /><Option Name="for postponed receipt retract" Value="r" /></Options><Desc>1 symbol with value: - ''e'' - for postponed receipt eject - ''r'' - for postponed receipt retract</Desc></Arg><Arg Name='+
'"Timeout" Value="" Type="Decimal" MaxLen="3"><Desc>1..3 ASCII symbols for timeout [sec] from''1'' to ''999'' If not present, default value is 15 sec</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <Tele'+
'phoneNumber[20]><;><EjectRetract[1]>{<;><Timeout[1..3]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ClearDisplay" CmdByte="0x24"><FPOperation>Clears the display.</FPOperation></Command><Command Name="CloseNonFiscalReceipt" CmdByte="0x2F"><FPOperat'+
'ion>Closes the non-fiscal receipt.</FPOperation></Command><Command Name="CloseReceipt" CmdByte="0x38"><FPOperation>Close the fiscal receipt and telephone number.</FPOperation></Command><Command Name="CloseReceiptWithPhoneNum" CmdByte="0x38"><FPOperation>C'+
'loses the opened fiscal receipt with sent SMS which includes receipt information.The first symbols must be either ''+'' or number. Minimum 2 symbols allowed for telephone number.</FPOperation><Args><Arg Name="TelephoneNumber" Value="" Type="Text" MaxLen="'+
'20"><Desc>Up to 20 symbols for telephone number</Desc></Arg><ArgsFormatRaw><![CDATA[ <TelephoneNumber[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="CloseReceiptWithPhoneNumRejectRetract" CmdByte="0x38"><FPOperation>Closes the opened fiscal recei'+
'pt with sent SMS which includes receipt information.The first symbols must be either ''+'' or number. Minimum 2 symbols allowed for telephone number.</FPOperation><Args><Arg Name="TelephoneNumber" Value="" Type="Text" MaxLen="20"><Desc>1..20 symbols for t'+
'elephone number</Desc></Arg><Arg Name="OptionEjectRetract" Value="" Type="Option" MaxLen="1"><Options><Option Name="for postponed receipt eject" Value="e" /><Option Name="for postponed receipt retract" Value="r" /></Options><Desc>1 symbol with value: - '+
'''e'' - for postponed receipt eject - ''r'' - for postponed receipt retract</Desc></Arg><Arg Name="Timeout" Value="" Type="Decimal" MaxLen="3"><Desc>1..3 ASCII symbols for timeout [sec] from''1'' to ''999''  If not present, default value is 15 sec</Desc><'+
'Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <TelephoneNumber[20]><;><EjectRetract[1]>{<;><Timeout[1..3]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ConfirmFiscalization" CmdByte="0x41"><FPOperatio'+
'n>Store VAT and Fiscal Memory numbers into the Fiscal memory.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6-symbols string</Desc></Arg><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <P'+
'assword[6]><;> <''2''><;> ]]></ArgsFormatRaw></Args></Command><Command Name="CutPaper" CmdByte="0x29"><FPOperation>Start paper cutter. The command works only in fiscal printer devices.</FPOperation></Command><Command Name="DirectCommand" CmdByte="0xF1"><F'+
'POperation>Executes the direct command .</FPOperation><Args><Arg Name="Input" Value="" Type="Text" MaxLen="200"><Desc>Raw request to FP</Desc></Arg></Args><Response ACK="false"><Res Name="Output" Value="" Type="Text" MaxLen="200"><Desc>FP raw response</De'+
'sc></Res></Response></Command><Command Name="DisplayDateTime" CmdByte="0x28"><FPOperation>Shows the current date and time on the display.</FPOperation></Command><Command Name="DisplayText1" CmdByte="0x25"><FPOperation>Shows a 20-symbol text in the upper d'+
'isplay line.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="20"><Desc>20 symbols text</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="DisplayText1and2" CmdByte="0x27"><FPOperation>Shows '+
'a 40-symbol text in the two display lines.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="40"><Desc>40 symbols text</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[40]> ]]></ArgsFormatRaw></Args></Command><Command Name="DisplayText2" CmdByte='+
'"0x26"><FPOperation>Shows a 20-symbol text in the lower display line.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="20"><Desc>20 symbols text</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[20]> ]]></ArgsFormatRaw></Args></Command><Command N'+
'ame="EnablePrintRecBarcode" CmdByte="0x51"><FPOperation>Depending of the parameter prints or not barcode at the end of each clients receipt. The Barcode is EAN-13 with format specified by the next command.</FPOperation><Args><Arg Name="OptionPrintingBarco'+
'de" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disable" Value="D" /><Option Name="Enable" Value="E" /></Options><Desc>1 character with value:  - ''E'' - Enable  - ''D'' - Disable</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionPrintingBarcode[1]'+
'> ]]></ArgsFormatRaw></Args></Command><Command Name="EraseAllPLUs" CmdByte="0x4B"><FPOperation>Programs the PLU Category for a certain article (item) from the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="00000" Type="OptionHardcoded" Ma'+
'xLen="5" /><Arg Name="Option" Value="$" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for password</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[''00000'']><;><Option[''$'']><;><Password[6]> ]]></A'+
'rgsFormatRaw></Args></Command><Command Name="OpenNonFiscalReceipt" CmdByte="0x2E"><FPOperation>Open a non-fiscal receipt assigned to the specified operator.</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 2'+
'0 corresponding to operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for operator''s password</Desc></Arg><Arg Name="Reserved" Value="0" Type="OptionHardcoded" MaxLen="1"><Meta MinLen="1" Compulsory="false'+
'" ValIndicatingPresence=";" /></Arg><Arg Name="OptionFiscalRecieptPrintType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Postponed Printing" Value="1" /><Option Name="Step by step printing" Value="0" /></Options><Desc>1 symbol with value:  - '+
'''0'' - Step by step printing  - ''1'' - Postponed Printing</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <OperNum[1..2]><;><OperPass[6]> {<;> <Reserved[''0'']> <;><FiscalRecieptPrintType[1]>} ]]></Ar'+
'gsFormatRaw></Args></Command><Command Name="OpenReceipt" CmdByte="0x30"><FPOperation>Opens a fiscal receipt assigned to the specified operator or refund receipt.</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Up to 2 symbo'+
'ls from 1 to 20 corresponding to operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type="Text" MaxLen="4"><Desc>4 symbols for operator''s password</Desc></Arg><Arg Name="Reserved" Value="0" Type="OptionHardcoded" MaxLen="1"><Meta MinLen="1" Com'+
'pulsory="false" ValIndicatingPresence=";" /></Arg><Arg Name="OptionReceipType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Refund receipt" Value="1" /><Option Name="Standard fiscal receipt" Value="0" /></Options><Desc>1 symbol with value:  - '+
'''0'' - Standard fiscal receipt  - ''1'' - Refund receipt</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><Arg Name="OptionFiscalRcpPrintType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Buffered printing" Value="4'+
'" /><Option Name="Postponed Printing" Value="2" /><Option Name="Step by step printing" Value="0" /></Options><Desc>1 symbol with value:  - ''0'' - Step by step printing  - ''2'' - Postponed Printing  - ''4'' - Buffered printing</Desc><Meta MinLen="1" Comp'+
'ulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <OperNum[1..2]> <;> < OperPass[4]> {<;> <Reserved[''0'']> <;><OptionReceipType[1]><;><FiscalRcpPrintType[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="OpenReceipt_V2" CmdB'+
'yte="0x30"><FPOperation>Opens a fiscal receipt assigned to the specified operator or refund receipt. Devices with version 2 doesn''t support refund option</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Up to 2 symbols from'+
' 1 to 20 corresponding to operator''s number</Desc></Arg><Arg Name="OperPass" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for operator''s password</Desc></Arg><Arg Name="Reserved" Value="0" Type="OptionHardcoded" MaxLen="1"><Meta MinLen="1" Compulsory'+
'="false" ValIndicatingPresence=";" /></Arg><Arg Name="Reserved" Value="0" Type="OptionHardcoded" MaxLen="1"><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><Arg Name="OptionFiscalRcpPrintType" Value="" Type="Option" MaxLen="1"><Optio'+
'ns><Option Name="Buffered printing" Value="4" /><Option Name="Postponed Printing" Value="2" /><Option Name="Step by step printing" Value="0" /></Options><Desc>1 symbol with value:  - ''0'' - Step by step printing  - ''2'' - Postponed Printing  - ''4'' - B'+
'uffered printing</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <OperNum[1..2]> <;> < OperPass[6]> {<;> <Reserved[''0'']> <;>< Reserved[''0'']><;><FiscalRcpPrintType[1]>} ]]></ArgsFormatRaw></Args></Co'+
'mmand><Command Name="PaperFeed" CmdByte="0x2B"><FPOperation>Feeds 1 line of paper.</FPOperation></Command><Command Name="PayExactSum" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and exact amount received.'+
'</FPOperation><Args><Arg Name="OptionPaymentType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Payment 0" Value="0" /><Option Name="Payment 1" Value="1" /><Option Name="Payment 2" Value="2" /><Option Name="Payment 3" Value="3" /><Option Name="'+
'Payment 4" Value="4" /><Option Name="Payment 5" Value="5" /><Option Name="Payment 6" Value="6" /></Options><Desc>1 symbol for payment type:  - ''0'' - Payment 0  - ''1'' - Payment 1  - ''2'' - Payment 2  - ''3'' - Payment 3  - ''4'' - Payment 4  - ''5'' -'+
' Payment 5  - ''6'' - Payment 6</Desc></Arg><Arg Name="Option" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Amount" Value="&quot;" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PaymentType[1]> <;> <Option[''0'']> <;> <Amount['+
'''"'']> ]]></ArgsFormatRaw></Args></Command><Command Name="PayExactSumV2_1" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and exact amount received.</FPOperation><Args><Arg Name="OptionPaymentTypeV2_1" Valu'+
'e="" Type="Option" MaxLen="2"><Options><Option Name="ABONAMENT" Value="6" /><Option Name="ALT IP" Value="7" /><Option Name="Alt mod" Value="14" /><Option Name="Arvuna" Value="11" /><Option Name="Avans" Value="10" /><Option Name="CARD PLATA" Value="1" /><O'+
'ption Name="CEC" Value="3" /><Option Name="Compensare" Value="13" /><Option Name="Credit" Value="8" /><Option Name="Gaj" Value="12" /><Option Name="Leasing" Value="9" /><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME'+
'" Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1..2 symbols for payment type: - ''0'' - NUMERAR - ''1'' - CARD PLATA - ''2'' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TME - ''6'' - ABONAMENT  - ''7'' - ALT IP - ''8'' - Credit -'+
' ''9'' - Leasing - ''10'' - Avans - ''11'' - Arvuna - ''12'' - Gaj - ''13'' - Compensare - ''14'' - Alt mod</Desc></Arg><Arg Name="Option" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Amount" Value="&quot;" Type="OptionHardcoded" MaxLen="1" />'+
'<ArgsFormatRaw><![CDATA[ <PaymentTypeV2_1[1..2]> <;> <Option[''0'']> <;> <Amount[''"'']> ]]></ArgsFormatRaw></Args></Command><Command Name="PayExactSum_V2" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and '+
'exact amount received.</FPOperation><Args><Arg Name="OptionPaymentTypeV2" Value="" Type="Option" MaxLen="1"><Options><Option Name="ABONAMENT" Value="7" /><Option Name="ALT IP" Value="8" /><Option Name="CARD PLATA" Value="1" /><Option Name="CEC" Value="3" '+
'/><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME" Value="6" /><Option Name="TMH" Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1 symbol for payment type: - ''0'' - NUMERAR - ''1'' - CARD PLATA - ''2'+
''' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TMH - ''6'' - TME - ''7'' - ABONAMENT  - ''8'' - ALT IP</Desc></Arg><Arg Name="Option" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Amount" Value="&quot;" Type="OptionHardcoded" MaxLen="1"'+
' /><ArgsFormatRaw><![CDATA[ <PaymentTypeV2[1]> <;> <Option[''0'']> <;> <Amount[''"'']> ]]></ArgsFormatRaw></Args></Command><Command Name="Payment" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and amount re'+
'ceived (if the payment type is 0-5 the amount of change due is not obligatory.)</FPOperation><Args><Arg Name="OptionPaymentType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Payment 0" Value="0" /><Option Name="Payment 1" Value="1" /><Option N'+
'ame="Payment 2" Value="2" /><Option Name="Payment 3" Value="3" /><Option Name="Payment 4" Value="4" /><Option Name="Payment 5" Value="5" /><Option Name="Payment 6" Value="6" /></Options><Desc>1 symbol for payment type:  - ''0'' - Payment 0  - ''1'' - Paym'+
'ent 1  - ''2'' - Payment 2  - ''3'' - Payment 3  - ''4'' - Payment 4  - ''5'' - Payment 5  - ''6'' - Payment 6</Desc></Arg><Arg Name="OptionChange" Value="" Type="Option" MaxLen="1"><Options><Option Name="With Change default" Value="0" /><Option Name="Wit'+
'hout Change" Value="1" /></Options><Desc>1 symbol with value:  - ''0 - With Change default  - ''1'' - Without Change</Desc></Arg><Arg Name="Amount" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 characters for received amount</Desc></Arg><Arg Name="Opt'+
'ionChangeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name="Same As The payment" Value="1" /></Options><Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The payment</Desc><Meta M'+
'inLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><ArgsFormatRaw><![CDATA[ <PaymentType[1]><;><OptionChange[1]><;><Amount[1..10]> {<*><OptionChangeType[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="Payment_V2" CmdByte="0x35"><FPOper'+
'ation>Register the payment in the receipt with specified type of payment and amount received (if the payment type is 0-5 the amount of change due is not obligatory.)</FPOperation><Args><Arg Name="OptionPaymentTypeV2" Value="" Type="Option" MaxLen="1"><Opt'+
'ions><Option Name="ABONAMENT" Value="7" /><Option Name="ALT IP" Value="8" /><Option Name="CARD PLATA" Value="1" /><Option Name="CEC" Value="3" /><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME" Value="6" /><Option Na'+
'me="TMH" Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1 symbol for payment type: - ''0'' - NUMERAR - ''1'' - CARD PLATA - ''2'' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TMH - ''6'' - TME - ''7'' - ABONAMENT  - ''8'' - ALT IP</'+
'Desc></Arg><Arg Name="OptionChange" Value="" Type="Option" MaxLen="1"><Options><Option Name="With Change default" Value="0" /><Option Name="Without Change" Value="1" /></Options><Desc>1 symbol with value:  - ''0 - With Change default  - ''1'' - Without Ch'+
'ange</Desc></Arg><Arg Name="Amount" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 characters for received amount</Desc></Arg><Arg Name="OptionChangeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name'+
'="Same As The payment" Value="1" /></Options><Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The payment</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><ArgsFormatRaw><![CDATA[ <PaymentTypeV2[1]><;><Op'+
'tionChange[1]><;><Amount[1..10]> {<*><OptionChangeType[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="Payment_V2_1" CmdByte="0x35"><FPOperation>Register the payment in the receipt with specified type of payment and amount received (if the payment'+
' type is 0-5 the amount of change due is not obligatory.)</FPOperation><Args><Arg Name="OptionPaymentTypeV2_1" Value="" Type="Option" MaxLen="2"><Options><Option Name="ABONAMENT" Value="6" /><Option Name="ALT IP" Value="7" /><Option Name="Alt mod" Value="'+
'14" /><Option Name="Arvuna" Value="11" /><Option Name="Avans" Value="10" /><Option Name="CARD PLATA" Value="1" /><Option Name="CEC" Value="3" /><Option Name="Compensare" Value="13" /><Option Name="Credit" Value="8" /><Option Name="Gaj" Value="12" /><Optio'+
'n Name="Leasing" Value="9" /><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME" Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1..2 symbols for payment type: - ''0'' - NUMERAR - ''1'' - CARD PLATA - ''2'+
''' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TME - ''6'' - ABONAMENT  - ''7'' - ALT IP - ''8'' - Credit - ''9'' - Leasing - ''10'' - Avans - ''11'' - Arvuna - ''12'' - Gaj - ''13'' - Compensare - ''14'' - Alt mod</Desc></Arg><Arg Name="OptionCha'+
'nge" Value="" Type="Option" MaxLen="1"><Options><Option Name="With Change default" Value="0" /><Option Name="Without Change" Value="1" /></Options><Desc>1 symbol with value:  - ''0 - With Change default  - ''1'' - Without Change</Desc></Arg><Arg Name="Amo'+
'unt" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 characters for received amount</Desc></Arg><Arg Name="OptionChangeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name="Same As The payment" Value="1'+
'" /></Options><Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The payment</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><ArgsFormatRaw><![CDATA[ <PaymentTypeV2_1[1..2]><;><OptionChange[1]><;><Amount[1'+
'..10]> {<*><OptionChangeType[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="PrintArticleReport" CmdByte="0x7E"><FPOperation>Prints an article report with or without zeroing (''Z'' or ''X'').</FPOperation><Args><Arg Name="OptionZeroing" Value="" T'+
'ype="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>with following values:  - ''Z'' -Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> ]]><'+
'/ArgsFormatRaw></Args></Command><Command Name="PrintBarcode" CmdByte="0x51"><FPOperation>Prints barcode from type stated by CodeType and CodeLen and with data stated in CodeData field.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLe'+
'n="1" /><Arg Name="OptionCodeType" Value="" Type="Option" MaxLen="1"><Options><Option Name="CODABAR" Value="6" /><Option Name="CODE 128" Value="I" /><Option Name="CODE 39" Value="4" /><Option Name="CODE 93" Value="H" /><Option Name="EAN 13" Value="2" /><O'+
'ption Name="EAN 8" Value="3" /><Option Name="ITF" Value="5" /><Option Name="UPC A" Value="0" /><Option Name="UPC E" Value="1" /></Options><Desc>1 symbol with possible values:  - ''0'' - UPC A  - ''1'' - UPC E  - ''2'' - EAN 13  - ''3'' - EAN 8  - ''4'' - '+
'CODE 39  - ''5'' - ITF  - ''6'' - CODABAR  - ''H'' - CODE 93  - ''I'' - CODE 128</Desc></Arg><Arg Name="CodeLen" Value="" Type="Decimal" MaxLen="2"><Desc>1..2 bytes for number of bytes according to the table</Desc></Arg><Arg Name="CodeData" Value="" Type='+
'"Text" MaxLen="100"><Desc>''2'' or ''C''  12 or 13   ''0'' to ''9''        (13 if checksum           included) JAN8 (EAN8)       ''3'' or ''D''  7 or 8   ''0'' to ''9'' CODE 39  ''4'' or ''E''  1 to 10       ''SP'' ''$'' ''%'' ''+'' ''-'' ''.'' ''/''     '+
'        ''0'' to ''9'' ; ''A'' to ''Z'' ITF   ''5'' or ''F''  2 to 18        ''0'' to ''9''        (evens only) CODABAR   ''6'' or ''G''    1 to 15      ''$'' ''+'' ''-'' ''/''                               ''0'' to ''9'' / ''A'' to ''D'' CODE 93        '+
'''H''       1 to 14       Bytes from 0 to 7F CODE 128      ''I''        1 to 12       Bytes from 0 to 7F    The length restriction for some of the barcode types is because of the the print area not because of the barcode standard. If more data is sent the'+
' printed barcode may not be read correctly.</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''> <;> <CodeType[1]> <;> <CodeLen[1..2]> <;> <CodeData[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBriefFMPaymentsReportByZNum" CmdByte="0x79"><FPOpera'+
'tion>Print a brief payment FM report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial report number included in report, format ####</D'+
'esc></Arg><Arg Name="EndNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final report number included in report, format ####</Desc></Arg><Arg Name="OptionPayment" Value="P" Type="OptionHardcoded" MaxLen="1" /><Args'+
'FormatRaw><![CDATA[ <StartNum[4]><;><EndNum[4]><;><OptionPayment[''P'']> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBriefFMReportByDate" CmdByte="0x7B"><FPOperation>Print a brief FM report by initial and end date.</FPOperation><Args><Arg Name'+
'="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in th'+
'e DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartRepFromDate"DDMMYY"><;><EndRepFromDate"DDMMYY"> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintBriefFMReportByZBlocks" CmdByte="0x79"><FPOperation>Print a brief FM report by initial and e'+
'nd FM report number.</FPOperation><Args><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial FM report number included in report, format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Deci'+
'mal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final FM report number included in report, format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartZNum[4]><;><EndZNum[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDailyReport'+
'" CmdByte="0x7C"><FPOperation>Depending on the parameter prints:  daily fiscal report with zeroing and fiscal memory record, preceded by Electronic Journal report print (''Z'');  daily fiscal report without zeroing (''X'');</FPOperation><Args><Arg Name='+
'"OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>1 character with following values:  - ''Z'' - Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsForm'+
'atRaw><![CDATA[ <OptionZeroing[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDepartmentReport" CmdByte="0x76"><FPOperation>Prints departments report</FPOperation><Args><Arg Name="OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Opt'+
'ion Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>with following values:  - ''Z'' -Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> ]]></ArgsFormatRaw></Args></Command><Comm'+
'and Name="PrintDetailedDailyReport" CmdByte="0x7F"><FPOperation>Prints an extended daily financial report (an article report followed by a daily financial report) with or without zeroing (''Z'' or ''X'').</FPOperation><Args><Arg Name="OptionZeroing" Value'+
'="" Type="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>with following values:  - ''Z'' -Zeroing  - ''X'' - Without zeroing</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]>'+
' ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDetailedFMPaymentsReportByZNum" CmdByte="0x78"><FPOperation>Print a detailed FM payment report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNum" Value="" Type="Decimal_wit'+
'h_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial report number included in report, format ####</Desc></Arg><Arg Name="EndNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final report number includ'+
'ed in report, format ####</Desc></Arg><Arg Name="OptionPayment" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <StartNum[4]><;><EndNum[4]><;><OptionPayment[''P'']> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDetailedFMR'+
'eportByDate" CmdByte="0x7A"><FPOperation>Prints a detailed FM report by initial and end date.</FPOperation><Args><Arg Name="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc>'+
'</Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[ <StartRepFromDate"DDMMYY"><;><EndRepFromDate"DDMMYY"> ]]></ArgsFormatRaw></Args>'+
'</Command><Command Name="PrintDetailedFMReportByZBlocks" CmdByte="0x78"><FPOperation>Print a detailed FM report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNo" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>'+
'4 symbols for the initial report number included in report, format ####</Desc></Arg><Arg Name="EndNo" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final report number included in report, format ####</Desc></Arg><Arg'+
'sFormatRaw><![CDATA[ <StartNo[4]><;><EndNo[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintDiagnostics" CmdByte="0x22"><FPOperation>Prints out a diagnostic receipt.</FPOperation></Command><Command Name="PrintEJ" CmdByte="0x7C"><FPOperation>Rea'+
'ding/Printing all Electronic Journal report.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''J1''><;><''*''> ]]></ArgsFormatRaw></Args></'+
'Command><Command Name="PrintEJByDate" CmdByte="0x7C"><FPOperation>Printing Electronic Journal Report from Start Date to End Date.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="D" Type="OptionHardcoded" '+
'MaxLen="1" /><Arg Name="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbol'+
's for final date in the DDMMYY format</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal r'+
'eceipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></A'+
'rg><ArgsFormatRaw><![CDATA[<''J1''><;><''D''><;><StartRepFromDate"DDMMYY"><;>< EndRepFromDate"DDMMYY"> {<;><FlagsTypeRec[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByDateCustom" CmdByte="0x7C"><FPOperation>Print Electronic Journal Repo'+
'rt by initial and end date, and selected documents content.</FPOperation><Args><Arg Name="" Value="j1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="X" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"'+
'><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flag'+
's.6 =1 For included fiscal sales receipts, 0= for not included  Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRepFromDate" Value="" Typ'+
'e="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><Arg'+
'sFormatRaw><![CDATA[<''j1''> <;> <''X''> <;> <FlagsTypeRec[1]> <;> <reserved[''0'']> <;> <''D''> <;> <StartRepFromDate "DDMMYY"> <;> <EndRepFromDate "DDMMYY"> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByRcpNum" CmdByte="0x7C"><FPOperation>'+
'Printing Electronic Journal Report from receipt number to receipt number.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRcpNum" Value="" Type="Deci'+
'mal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for initial receipt number included in report, format #####</Desc></Arg><Arg Name="EndRcpNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for final receipt number'+
' included in report, format #####</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 =1 For included non-fiscal receip'+
'ts, 0= for not included Flags.4 =1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 = 1 For included fiscal sales receipts, 0= for not included  Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><'+
'ArgsFormatRaw><![CDATA[ <''J1''><;><''N''><;><StartRcpNum[5]><;><EndRcpNum[5]> {<;><FlagsTypeRec[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByRcpNumCustom" CmdByte="0x7C"><FPOperation>Print Electronic Journal Report from receipt number'+
' to receipt number and selected documents content.</FPOperation><Args><Arg Name="" Value="j1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="X" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 '+
'optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 =1 For included non-fiscal receipts, 0= for not included Flags.4 =1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 = 1 For'+
' included fiscal sales receipts, 0= for not included  Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRcpNum" Value="" Type="Decimal_with'+
'_format" MaxLen="6" Format="000000."><Desc>6 symbols for initial receipt number included in report in format ######.</Desc></Arg><Arg Name="EndRcpNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000."><Desc>6 symbols for final receipt number'+
' included in report in format ######.</Desc></Arg><ArgsFormatRaw><![CDATA[ <''j1''> <;> <''X''> <;> <FlagsTypeRec[1]> <;> <reserved[''0'']> <;> <''N''> <;> <StartRcpNum[6]> <;> <EndRcpNum[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByZBl'+
'ocks" CmdByte="0x7C"><FPOperation>Printing Electronic Journal Report from report number to report number.</FPOperation><Args><Arg Name="" Value="J1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="'+
'StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for initial number report in format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number '+
'report in format ####</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 =1 For included non-fiscal receipts, 0= for n'+
'ot included Flags.4 =1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 = 1 For included fiscal sales receipts, 0= for not included  Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRa'+
'w><![CDATA[ <''J1''><;><''Z''><;><StartZNum[4]><;><EndZNum[4]> {<;><FlagsTypeRec[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJByZBlocksCustom" CmdByte="0x7C"><FPOperation>Print Electronic Journal Report by number of Z report blocks and s'+
'elected documents content.</FPOperation><Args><Arg Name="" Value="j1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="X" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag '+
'for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales '+
'receipts, 0= for not included Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format'+
'="0000"><Desc>4 symbols for initial number report in format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number report in format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <''j1'+
'''> <;> <''X''> <;> < FlagsTypeRec[1]> <;> <reserved [''0'']> <;> <''Z''> <;> <StartZNum[4]> <;> <EndZNum[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintEJCustom" CmdByte="0x7C"><FPOperation>Print Electronic Journal report with selected docum'+
'ents content. FlagsTypeRec is a char with bits representing the receipt types.</FPOperation><Args><Arg Name="" Value="j1" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="X" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type'+
'="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not includ'+
'ed Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA'+
'[ <''j1''> <;> <''X''> <;> <FlagsTypeRec[1]> <;> <reserved[''0'']> <;> <''*''> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintLastReceiptDuplicate" CmdByte="0x3A"><FPOperation>Print a copy of the last receipt document issued</FPOperation></Comman'+
'd><Command Name="PrintLogo" CmdByte="0x6C"><FPOperation>Print the programmed graphical logo with the stated number.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Number of logo to be printed. If missing prints logo with nu'+
'mber 0</Desc></Arg><ArgsFormatRaw><![CDATA[<Number[1..2]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintOperatorReport" CmdByte="0x7D"><FPOperation>Prints an operator''s report for a specified operator (0 = all operators) with or without zeroing'+
' (''Z'' or ''X'').</FPOperation><Args><Arg Name="OptionZeroing" Value="" Type="Option" MaxLen="1"><Options><Option Name="Without zeroing" Value="X" /><Option Name="Zeroing" Value="Z" /></Options><Desc>1 symbol with following values:  - ''Z'' -Zeroing  - '+
'''X'' - Without zeroing</Desc></Arg><Arg Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 0 to 20 corresponding to operator''s number (0 = all operators)</Desc></Arg><ArgsFormatRaw><![CDATA[ <OptionZeroing[1]> <;> <Number[1..2]> ]]></Ar'+
'gsFormatRaw></Args></Command><Command Name="PrintQRCode" CmdByte="0x51"><FPOperation>Prints QR code</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Resolution" Value="" Type="Decimal_with_format" MaxLen="1" Format='+
'"0"><Desc>1 character value from ''1'' to ''9'' for resolution in format #</Desc></Arg><Arg Name="Data" Value="" Type="Text" MaxLen="200"><Desc>text with variable length not padded with spaces UP TO 200 symbols</Desc></Arg><ArgsFormatRaw><![CDATA[ <''R''>'+
'<;><Resolution[1]><;><Data[200]> ]]></ArgsFormatRaw></Args></Command><Command Name="PrintSpecialEventsFMreport" CmdByte="0x77"><FPOperation>Print all special FM events report.</FPOperation></Command><Command Name="PrintText" CmdByte="0x37"><FPOperation>Pr'+
'ints a free text.</FPOperation><Args><Arg Name="Text" Value="" Type="Text" MaxLen="64"><Desc>Free text : [printed line symbols]- 2 symbols</Desc></Arg><ArgsFormatRaw><![CDATA[ <Text[TextLength-2]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgCom'+
'panyAddress_V2" CmdByte="0x49"><FPOperation>Program the owner''s company address.</FPOperation><Args><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="CompAddrLen" Value="" Typ'+
'e="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the company address len</Desc></Arg><Arg Name="CompanyAddress" Value="" Type="Text" MaxLen="96"><Desc>Up to 96 symbols for company address</Desc></Arg><ArgsFormatRaw><![CDATA[<''N''> <;> <''2''><;> <CompAdd'+
'rLen[1..3]><;><CompanyAddress[96]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgCompanyName_V2" CmdByte="0x49"><FPOperation>Programs the owner''s company name.</FPOperation><Args><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Na'+
'me="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="CompNameLen" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the company name len</Desc></Arg><Arg Name="CompanyName" Value="" Type="Text" MaxLen="60"><Desc>Up to 60 symbols for c'+
'ompany name</Desc></Arg><ArgsFormatRaw><![CDATA[<''N''> <;> <''1''><;> <CompNameLen[1..3]><;><CompanyName[60]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgCustomerData" CmdByte="0x52"><FPOperation>Programs the customer DB for special customer r'+
'eceipt issuing.</FPOperation><Args><Arg Name="Option" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="CustomerNum" Value="" Type="Decimal_with_format" MaxLen="3" Format="000"><Desc>3 symbols for customer number in order in format ###</Desc></Arg>'+
'<Arg Name="VATNumber" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for customer VAT registration number</Desc></Arg><Arg Name="CustomerCompanyName" Value="" Type="Text" MaxLen="30"><Desc>30 symbols for customer name</Desc></Arg><Arg Name="Address" Va'+
'lue="" Type="Text" MaxLen="30"><Desc>30 symbols for address on customer</Desc></Arg><Arg Name="FreeLine1" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc></Arg><Arg Name="FreeLine2" Value="" Type="Text" MaxLen="20"><Desc>20'+
' ASCII symbols for customer data</Desc></Arg><Arg Name="FreeLine3" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc></Arg><Arg Name="FreeLine4" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc>'+
'</Arg><ArgsFormatRaw><![CDATA[ <Option[''P'']> <;><CustomerNum[3]> <;> <VATNumber[15]> <;> <CustomerCompanyName[30]> <;> <Address[30] <;><FreeLine1[20]> <;> <FreeLine2[20]> <;> <FreeLine3[20]> <;> <FreeLine4[20]> ]]></ArgsFormatRaw></Args></Command><Comma'+
'nd Name="ProgDepartment" CmdByte="0x47"><FPOperation>Set data for the stated department number from the internal FD database.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols for department n'+
'umber in format ##</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="20"><Desc>20 characters department name</Desc></Arg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Option Name="VAT class A" Value="A" /><Option Name="VAT'+
' class B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Option Name="VAT class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Name="VAT class G" Value="G" /><Option Name="VAT class H" Value="H" /'+
'><Option Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article''s VAT Class with optional values:  - ''A'' - VAT class A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'' - VAT class D  - ''E'' - VAT class E  - ''F'' - VAT class F  - '+
'''G'' - VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for department price /ECR Only/</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /'+
'></Arg><Arg Name="OptionDepPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price disabled" Value="0" /><Option Name="Free price disabled for single transaction" Value="4" /><Option Name="Free price enabled" Value="1" /><Option Name="F'+
'ree price enabled for single transaction" Value="5" /><Option Name="Limited price" Value="2" /><Option Name="Limited price for single transaction" Value="6" /></Options><Desc>1 symbol for Department flags with next value:  - ''0'' - Free price disabled  -'+
' ''1'' - Free price enabled  - ''2'' - Limited price  - ''4'' - Free price disabled for single transaction  - ''5'' - Free price enabled for single transaction  - ''6'' - Limited price for single transaction</Desc><Meta MinLen="1" Compulsory="false" ValIn'+
'dicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <Number[2]> <;><Name[20]> <;> <OptionVATClass[1]> {<;> <Price[1..10]> <;><OptionDepPrice[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ProgDisplayGreeting" CmdByte="0x49"><FPOperation>Program'+
' the contents of a Display Greeting message.</FPOperation><Args><Arg Name="OptionDisplayGreeting" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="DisplayGreetingText" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for display greeting message<'+
'/Desc></Arg><ArgsFormatRaw><![CDATA[<OptionDisplayGreeting[''0'']><;><DisplayGreetingText[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgExtDisplay" CmdByte="0x46"><FPOperation>Preprograms the external display.</FPOperation><Args><Arg Name="P'+
'assword" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for access password</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]> <NoBytesCom1line[1]> <Com1line[8]> <NoBytesCom2line[1]> <Com2Line[8]> < NoBytesClrDis[1]> <ComClrDis[8]> <NobytesXtrCom[1]> <Co'+
'mXtrCom[1]> <FlagPrecod[1]> {<PrecodTabl[64]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ProgFooter" CmdByte="0x49"><FPOperation>Program the contents of a footer lines.</FPOperation><Args><Arg Name="OptionFooterLine" Value="8" Type="OptionHardcod'+
'ed" MaxLen="1" /><Arg Name="FooterText" Value="" Type="Text" MaxLen="64"><Desc>TextLength symbols for footer line</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionFooterLine[''8'']> <;> <FooterText[TextLength]> ]]></ArgsFormatRaw></Args></Command><Command Name='+
'"ProgHeader" CmdByte="0x49"><FPOperation>Program the contents of a header lines.</FPOperation><Args><Arg Name="OptionHeaderLine" Value="" Type="Option" MaxLen="1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Nam'+
'e="Header 3" Value="3" /><Option Name="Header 4" Value="4" /><Option Name="Header 5" Value="5" /><Option Name="Header 6" Value="6" /><Option Name="Header 7" Value="7" /></Options><Desc>1 symbol with value:  - ''1'' - Header 1  - ''2'' - Header 2  - ''3'' '+
'- Header 3  - ''4'' - Header 4  - ''5'' - Header 5  - ''6'' - Header 6  - ''7'' - Header 7</Desc></Arg><Arg Name="HeaderText" Value="" Type="Text" MaxLen="64"><Desc>TextLength symbols for header lines</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionHeaderLine['+
'1]> <;> <HeaderText[TextLength]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgIntervalUnsentMsg" CmdByte="0x4F"><FPOperation>Program the interval of unsent messages</FPOperation><Args><Arg Name="Option1" Value="T" Type="OptionHardcoded" MaxLen="'+
'1" /><Arg Name="Option2" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for password</Desc></Arg><Arg Name="TimeHours" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for hour pe'+
'riod</Desc></Arg><ArgsFormatRaw><![CDATA[<Option1[''T'']> <;><Option2[''W'']><;> <Password[6]> <;><TimeHours[1..5]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgMandatoryConnectionExtPrinter" CmdByte="0x4F"><FPOperation>Programming a parameter i'+
'ndicating whether the connection of an external printer is mandatory. (only for FP25 devices)</FPOperation><Args><Arg Name="Option1" Value="p" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name='+
'"OptionMandatoryConnecting" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - No  - ''1'' - Yes</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option1[''p'']> <;>'+
'<Option2[''W'']><;>< MandatoryConnecting[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgOperator" CmdByte="0x4A"><FPOperation>Programs the operator''s name and password.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal" MaxLen="2">'+
'<Desc>Symbols from ''1'' to ''20'' corresponding to operator''s number</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for operator''s name</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for'+
' operator''s password</Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[1..2]> <;> <Name[20]> <;> <Password[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgParameters_ECR" CmdByte="0x45"><FPOperation>Programs the number of POS, printing of logo, saf'+
'e box opening, display mode, cutting permission.</FPOperation><Args><Arg Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for number of POS in format ####</Desc></Arg><Arg Name="OptionPrintLogo" Value="" Type="Opt'+
'ion" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><Options><Option Name="No"'+
' Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionAutoCut" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Opt'+
'ions><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionExternalDispManagement" Value="" Type="Option" MaxLen="1"><Options><Option Name="Auto" Value="0" /><Option Name="Manual" Value="1" /></Options><Desc>1 symbol of value:'+
'  - ''1'' - Manual  - ''0'' - Auto</Desc></Arg><Arg Name="reserved" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionEJFontType" Value="" Type="Option" MaxLen="1"><Options><O'+
'ption Name="Low Font" Value="1" /><Option Name="Normal Font" Value="0" /></Options><Desc>1 symbol of value:  - ''1'' - Low Font  - ''0'' - Normal Font</Desc></Arg><ArgsFormatRaw><![CDATA[<POSNum[4]><;>< PrintLogo[1]><;><AutoOpenDrawer[1]><;><AutoCut[1]><;'+
'> <ExternalDispManagement[1]> <;> <reserved[''1'']> <;> <reserved[''0'']> <;> <EJFontType[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgParameters_FP" CmdByte="0x45"><FPOperation>Programs the number of POS, printing of logo, safe box opening,'+
' display mode, cutting permission.</FPOperation><Args><Arg Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for number of POS in format ####</Desc></Arg><Arg Name="OptionPrintLogo" Value="" Type="Option" MaxLen="1'+
'"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><'+
'Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionAutoCut" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 s'+
'ymbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionExternalDispManagement" Value="" Type="Option" MaxLen="1"><Options><Option Name="Auto" Value="0" /><Option Name="Manual" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Ma'+
'nual  - ''0'' - Auto</Desc></Arg><Arg Name="reserved" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionEJFontType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Lo'+
'w Font" Value="1" /><Option Name="Normal Font" Value="0" /></Options><Desc>1 symbol of value:  - ''1'' - Low Font  - ''0'' - Normal Font</Desc></Arg><Arg Name="OptionExternalDisplayMonitoring" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" V'+
'alue="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><ArgsFormatRaw><![CDATA[<POSNum[4]><;>< PrintLogo[1]><;><AutoOpenDrawer[1]><;><AutoCut[1]><;> <ExternalDispManagement[1]> <;> <reserved['+
'''1'']> <;> <reserved[''0'']> <;> <EJFontType[1]> <;><ExternalDisplayMonitoring[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPayment" CmdByte="0x44"><FPOperation>Preprogram the name of the payment type.</FPOperation><Args><Arg Name="OptionPa'+
'ymentType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Payment 0" Value="0" /><Option Name="Payment 1" Value="1" /><Option Name="Payment 2" Value="2" /><Option Name="Payment 3" Value="3" /><Option Name="Payment 4" Value="4" /><Option Name="Pa'+
'yment 5" Value="5" /><Option Name="Payment 6" Value="6" /></Options><Desc>1 symbol for payment type:  - ''0'' - Payment 0  - ''1'' - Payment 1  - ''2'' - Payment 2  - ''3'' - Payment 3  - ''4'' - Payment 4  - ''5'' - Payment 5  - ''6'' - Payment 6</Desc><'+
'/Arg><Arg Name="Name" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment type name</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionPaymentType[1]> <;> <Name[10]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPayment_V2" CmdByte="0x44"><FPOp'+
'eration>Preprogram the name of the payment type.</FPOperation><Args><Arg Name="OptionPaymentTypeV2" Value="" Type="Option" MaxLen="1"><Options><Option Name="ABONAMENT" Value="7" /><Option Name="ALT IP" Value="8" /><Option Name="CARD PLATA" Value="1" /><Op'+
'tion Name="CEC" Value="3" /><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME" Value="6" /><Option Name="TMH" Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1 symbol for payment type: - ''0'' - NUMERAR '+
'- ''1'' - CARD PLATA - ''2'' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TMH - ''6'' - TME - ''7'' - ABONAMENT  - ''8'' - ALT IP</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment type name</Desc></Arg><Args'+
'FormatRaw><![CDATA[<OptionPaymentTypeV2[1]> <;> <Name[10]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPayment_V2_1" CmdByte="0x44"><FPOperation>Preprogram the name of the payment type.</FPOperation><Args><Arg Name="OptionPaymentTypeV2_1" Value'+
'="" Type="Option" MaxLen="2"><Options><Option Name="ABONAMENT" Value="6" /><Option Name="ALT IP" Value="7" /><Option Name="Alt mod" Value="14" /><Option Name="Arvuna" Value="11" /><Option Name="Avans" Value="10" /><Option Name="CARD PLATA" Value="1" /><Op'+
'tion Name="CEC" Value="3" /><Option Name="Compensare" Value="13" /><Option Name="Credit" Value="8" /><Option Name="Gaj" Value="12" /><Option Name="Leasing" Value="9" /><Option Name="NUMERAR" Value="0" /><Option Name="TICKET" Value="4" /><Option Name="TME"'+
' Value="5" /><Option Name="VOUCHER" Value="2" /></Options><Desc>1..2 symbols for payment type: - ''0'' - NUMERAR - ''1'' - CARD PLATA - ''2'' - VOUCHER - ''3'' - CEC  - ''4'' - TICKET - ''5'' - TME - ''6'' - ABONAMENT  - ''7'' - ALT IP - ''8'' - Credit - '+
'''9'' - Leasing - ''10'' - Avans - ''11'' - Arvuna - ''12'' - Gaj - ''13'' - Compensare - ''14'' - Alt mod</Desc></Arg><Arg Name="Name" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment type name</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionPaym'+
'entTypeV2_1[1..2]> <;> <Name[10]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUbarcode" CmdByte="0x4B"><FPOperation>Program the Barcode number for a certain article (item) from the internal database.</FPOperation><Args><Arg Name="PLUNum" Valu'+
'e="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Barcode" Value="" Type="Text" MaxLen="13"><Desc>13 symbol'+
's for barcode</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''3'']><;><Barcode[13]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUcategory" CmdByte="0x4B"><FPOperation>Programs the PLU Category for a certain article (item) from th'+
'e internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="5" Type="OptionHardcoded" MaxLen="1" /><Arg '+
'Name="Category" Value="" Type="Decimal_with_format" MaxLen="7" Format="0000.00"><Desc>Up to 7 symbols for PLU Category code in format ####.##</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''5'']><;><Category[1..7]> ]]></ArgsFormatRaw></Args><'+
'/Command><Command Name="ProgPLUgeneral" CmdByte="0x4B"><FPOperation>Programs internal database items.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</'+
'Desc></Arg><Arg Name="Option" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Name" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for article name; Symbol for LF=7Ch - ''|''; separator for MU=80h or 60h followed up to 3 symbols for unit.</Des'+
'c></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for article price</Desc></Arg><Arg Name="OptionPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price is disable /valid only programmed price/" Value="'+
'0" /><Option Name="Free price is enable" Value="1" /><Option Name="Limited price" Value="2" /></Options><Desc>1 byte for Price flag with next value:  - ''0''- Free price is disable /valid only programmed price/  - ''1''- Free price is enable  - ''2''- Lim'+
'ited price</Desc></Arg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Option Name="VAT class A" Value="A" /><Option Name="VAT class B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Optio'+
'n Name="VAT class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Name="VAT class G" Value="G" /><Option Name="VAT class H" Value="H" /><Option Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article VAT class:  - ''A'' - VAT cla'+
'ss A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'' - VAT class D  - ''E'' - VAT class E  - ''F'' - VAT class F  - ''G'' - VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Arg><Arg Name="BelongToDepNum" Value="" Type="Decimal_plus'+
'_80h" MaxLen="2"><Desc>BelongToDepNo + 80h. 1 symbol for article department attachment, formed in the following manner: example: Dep01 = 81h, Dep02 =</Desc></Arg><Arg Name="OptionTransaction" Value="" Type="Option" MaxLen="1"><Options><Option Name="Active'+
' Single transaction in receipt" Value="1" /><Option Name="Inactive /default value/" Value="0" /></Options><Desc>1 symbol with value:  - ''1'' - Active Single transaction in receipt  - ''0'' - Inactive /default value/  Note: this parameter is not obligator'+
'y</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;><Option[''1'']><;> <Name[36]> <;><Price[1..10]><;> <OptionPrice[1]><;><OptionVATClass[1]><;><BelongToDepNum[1..2]> {<;> <OptionTransactio'+
'n[1]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUprice" CmdByte="0x4B"><FPOperation>Program the price for a certain article (item) from the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen'+
'="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="4" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for article price</Desc></Arg>'+
'<Arg Name="OptionPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price is disable /valid only programmed price/" Value="0" /><Option Name="Free price is enable" Value="1" /><Option Name="Limited price" Value="2" /></Options><Desc>1 by'+
'te for Price flag with next value:  - ''0''- Free price is disable /valid only programmed price/  - ''1''- Free price is enable  - ''2''- Limited price</Desc></Arg><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''4'']><;><Price[1..10]><;><OptionPrice[1]> '+
']]></ArgsFormatRaw></Args></Command><Command Name="ProgPLUqty" CmdByte="0x4B"><FPOperation>Program the available quantity for a certain article (item) from the internal database.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" Ma'+
'xLen="5" Format="00000"><Desc>5 symbols for article number in format: #####</Desc></Arg><Arg Name="Option" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="AvailableQuantity" Value="" Type="Decimal" MaxLen="11"><Desc>1..11 symbols for quantity in '+
'stock</Desc></Arg><Arg Name="OptionQuantityType" Value="" Type="Option" MaxLen="1"><Options><Option Name="for availability of PLU stock is not monitored" Value="0" /><Option Name="for disable negative quantity" Value="1" /><Option Name="for enable negativ'+
'e quantity" Value="2" /></Options><Desc>1 byte for Quantity flag with next value:  - ''0''- for availability of PLU stock is not monitored  - ''1''- for disable negative quantity  - ''2''- for enable negative quantity</Desc></Arg><ArgsFormatRaw><![CDATA[ '+
'<PLUNum[5]> <;><Option[''2'']> <;> <AvailableQuantity[1..11]> <;> <OptionQuantityType[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgramExpirationServiceContract" CmdByte="0x5A"><FPOperation>Program expiration date of the service contract</FPO'+
'peration><Args><Arg Name="Option" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Password" Value="" Type="Text" MaxLen="5"><Desc>5 symbols for password</Desc></Arg><Arg Name="OptionActivation" Value="" Type="Option" MaxLen="1"><Options><Option N'+
'ame="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  - ''0''- No  - ''1''- Yes</Desc></Arg><Arg Name="ExpiryDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for date in format DDMMYY</Desc></A'+
'rg><Arg Name="OptionTypeActivation" Value="" Type="Option" MaxLen="1"><Options><Option Name="attention and blocking" Value="1" /><Option Name="attention only" Value="0" /></Options><Desc>1 symbol with value:  - ''0''- attention only  - ''1''- attention an'+
'd blocking</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <Option[''B'']> <;><Password[5]> <;><Activation[1]> <;><ExpiryDate "DDMMYY">{<;><TypeActivation[1]>} ]]></ArgsFormatRaw></Args></Command><Comma'+
'nd Name="ProgramPhoneNumber" CmdByte="0x5A"><FPOperation>Program phone number for SMS warning message</FPOperation><Args><Arg Name="OptionS" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="P" Type="OptionHardcoded" MaxLen="1" /><Ar'+
'g Name="PhoneNo" Value="" Type="Text" MaxLen="20"><Desc>Up to 20 digits for phone number or Space character for disable</Desc></Arg><ArgsFormatRaw><![CDATA[ < OptionS[''S'']><;> < Option[''P'']> <;><PhoneNo[20]> ]]></ArgsFormatRaw></Args></Command><Comman'+
'd Name="ProgramServiceContractPassword" CmdByte="0x5A"><FPOperation>Program service contract password</FPOperation><Args><Arg Name="Option" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Old_Password" Value="" Type="Text" MaxLen="5"><Desc>5 symb'+
'ols for old password</Desc></Arg><Arg Name="New_Password" Value="" Type="Text" MaxLen="5"><Desc>5 symbols for new password</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option[''P'']> <;><Old_Password[5]> <;><New_Password[5]> ]]></ArgsFormatRaw></Args></Command><'+
'Command Name="ProgSymbolsPerLine" CmdByte="0x4F"><FPOperation>Program the number of symbols per line.</FPOperation><Args><Arg Name="Option1" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="W" Type="OptionHardcoded" MaxLen="1" /><A'+
'rg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for password</Desc></Arg><Arg Name="OptionLineSymbols" Value="" Type="Option" MaxLen="1"><Options><Option Name="Symbols per line 32" Value="0" /><Option Name="Symbols per line 48" Value="1'+
'" /></Options><Desc>1 symbol with value:  - ''0'' - Symbols per line 32  - ''1'' - Symbols per line 48</Desc></Arg><ArgsFormatRaw><![CDATA[ <Option1[''P'']> <;><Option2[''W'']><;> <Password[6]> <;> <LineSymbols[1]> ]]></ArgsFormatRaw></Args></Command><Com'+
'mand Name="ProgVATNum" CmdByte="0x49"><FPOperation>Program the contents of the VAT Name.</FPOperation><Args><Arg Name="OptionVATline" Value="9" Type="OptionHardcoded" MaxLen="1" /><Arg Name="VATname" Value="" Type="Text" MaxLen="8"><Desc>8 symbols for VAT'+
' Number</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionVATline[''9'']> <;> <VATname[8]> ]]></ArgsFormatRaw></Args></Command><Command Name="ProgVATrates" CmdByte="0x42"><FPOperation>Store the VAT rates into the fiscal memory.</FPOperation><Args><Arg Name="Pass'+
'word" Value="" Type="Text" MaxLen="6"><Desc>6-symbols string</Desc></Arg><Arg Name="VATrateA" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate A from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateB" Va'+
'lue="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate B from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateC" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate C from 2 to '+
'6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateD" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate D from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateE" Value="0" Type="OptionHardcoded" Ma'+
'xLen="1" /><Arg Name="VATrateF" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate F from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateG" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><D'+
'esc>Value of VAT rate G from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateH" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate H from 2 to 6 symbols with format ##.##</Desc></Arg><Arg Name="VATrateI" V'+
'alue="" Type="Decimal_with_format" MaxLen="6" Format="00.00"><Desc>Value of VAT rate I from 2 to 6 symbols with format ##.##</Desc></Arg><ArgsFormatRaw><![CDATA[<Password[6]><;><VATrateA[2..6]> <;> <VATrateB[2..6]> <;> <VATrateC[2..6]> <;> <VATrateD[2..6]'+
'> <;> <VATrateE[''0'']> <;> <VATrateF[2..6]> <;> <VATrateG[2..6]> <;> <VATrateH[2..6]> <;> <VATrateI[2..6]> <;> ]]></ArgsFormatRaw></Args></Command><Command Name="RawRead" CmdByte="0xFF"><FPOperation> Reads raw bytes from FP.</FPOperation><Args><Arg Name='+
'"Count" Value="" Type="Decimal" MaxLen="5"><Desc>How many bytes to read if EndChar is not specified</Desc></Arg><Arg Name="EndChar" Value="" Type="Text" MaxLen="1"><Desc>The character marking the end of the data. If present Count parameter is ignored.</De'+
'sc></Arg></Args><Response ACK="false"><Res Name="Bytes" Value="" Type="Base64" MaxLen="100000"><Desc>FP raw response in BASE64 encoded string</Desc></Res></Response></Command><Command Name="RawWrite" CmdByte="0xFE"><FPOperation> Writes raw bytes to FP </F'+
'POperation><Args><Arg Name="Bytes" Value="" Type="Base64" MaxLen="5000"><Desc>The bytes in BASE64 ecoded string to be written to FP</Desc></Arg></Args></Command><Command Name="ReadBluetooth_Password" CmdByte="0x4E"><FPOperation>Provides information about '+
'device''s Bluetooth password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R'+
'''><;><''B''><;><''P''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res N'+
'ame="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the BT password length</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the BT password</Desc></Res><ResFormatRaw><![CDATA'+
'[<''R''><;><''B''><;><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadBluetooth_Status" CmdByte="0x4E"><FPOperation>Providing information about if the device''s Bluetooth module is enabled or disabled'+
'.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''B''><;><''S''> ]]><'+
'/ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionBTstatus" Value="'+
'" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>(Status) 1 symbol with value:  - ''0'' - Disabled  - ''1'' - Enabled</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''B''><;><''S''><'+
';><BTstatus[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadBriefFMReportByDate" CmdByte="0x7B"><FPOperation>Store a brief FM report by initial and end date.</FPOperation><Args><Arg Name="StartDate" Value="" Type="DateTime" MaxLen="10" Format'+
'="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><Arg Name="PCStorage" Value="8" Type="Opti'+
'onHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <StartDate "DDMMYY"><;><EndDate "DDMMYY"> <;><PCStorage[''8'']> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadBriefFMReportByNum" CmdByte="0x79"><FPOperatio'+
'n>Store a brief FM report by initial and end FM report number.</FPOperation><Args><Arg Name="StartNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial report number included in report, format ####</Desc></Arg><'+
'Arg Name="EndNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the final report number included in report, format ####</Desc></Arg><Arg Name="PCStorage" Value="8" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CD'+
'ATA[ <StartNum[4]><;><EndNum[4]> <;><PCStorage[''8'']> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadCompanyAddress_V2" CmdByte="0x69"><FPOperation>Reads the owner''s company address.</FPOperation><Args><Arg'+
' Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<''N''> <;> <''2''><;> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="N" Type="OptionHardcoded" '+
'MaxLen="1" /><Res Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="CompAddrLen" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the company address length</Desc></Res><Res Name="CompanyAddress" Value="" Type="Text" Ma'+
'xLen="96"><Desc>(Company address) 96 symbols for company address</Desc></Res><ResFormatRaw><![CDATA[<''N''> <;> <''2''><;><CompAddrLen[1..3]><;> <CompanyAddress[96]>]]></ResFormatRaw></Response></Command><Command Name="ReadCompanyName_V2" CmdByte="0x69"><'+
'FPOperation>Reads the owner''s company name.</FPOperation><Args><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<''N''> <;> <''1''> ]]></ArgsFormatRaw></Args><Re'+
'sponse ACK="false"><Res Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="CompNameLen" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the company name length<'+
'/Desc></Res><Res Name="CompanyName" Value="" Type="Text" MaxLen="60"><Desc>(Company name) 60 symbols for company name</Desc></Res><ResFormatRaw><![CDATA[<''N''> <;> <''1''><;><CompNameLen[1..3]><;> <CompanyName[60]>]]></ResFormatRaw></Response></Command><'+
'Command Name="ReadCurrentReceiptInfo" CmdByte="0x72"><FPOperation>Read the current status of the receipt.</FPOperation><Response ACK="false"><Res Name="IsReceiptOpened" Value="" Type="Text" MaxLen="1"><Desc>1 symbol with value ''1'' for initiated (opened)'+
' receipt</Desc></Res><Res Name="SalesNumber" Value="" Type="Text" MaxLen="3"><Desc>3 symbols for number of sales</Desc></Res><Res Name="SubtotalAmountVATGA" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group A</Desc></Res><R'+
'es Name="SubtotalAmountVATGB" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group B</Desc></Res><Res Name="SubtotalAmountVATGC" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group C</Desc></Res><'+
'Res Name="SubtotalAmountVATGD" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group D</Desc></Res><Res Name="SubtotalAmountVATGE" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group E</Desc></Res>'+
'<Res Name="SubtotalAmountVATGF" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group F</Desc></Res><Res Name="SubtotalAmountVATGG" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group G</Desc></Res'+
'><Res Name="SubtotalAmountVATGH" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group H</Desc></Res><Res Name="SubtotalAmountVATGI" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for subtotal by VAT group I</Desc></Re'+
's><Res Name="OptionForbiddenVoid" Value="" Type="Option" MaxLen="1"><Options><Option Name="allowed" Value="0" /><Option Name="forbidden" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - allowed  - ''1'' - forbidden</Desc></Res><Res Name="Option'+
'VATinReceipt" Value="" Type="Option" MaxLen="1"><Options><Option Name="with printing" Value="0" /><Option Name="without printing" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - with printing  - ''1'' - without printing</Desc></Res><Res Name="'+
'OptionDetailedReceipt" Value="" Type="Option" MaxLen="1"><Options><Option Name="brief" Value="0" /><Option Name="detailed format" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - brief  - ''1'' - detailed format</Desc></Res><Res Name="OptionIni'+
'tiatedPayment" Value="" Type="Option" MaxLen="1"><Options><Option Name="initiated payment" Value="0" /><Option Name="not initiated payment" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - initiated payment  - ''1'' - not initiated payment</Des'+
'c></Res><Res Name="OptionFinalizedPayment" Value="" Type="Option" MaxLen="1"><Options><Option Name="finalized payment" Value="0" /><Option Name="not finalized payment" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - finalized payment  - ''1'' '+
'- not finalized payment</Desc></Res><Res Name="OptionFlagPowerDown" Value="" Type="Option" MaxLen="1"><Options><Option Name="no power down" Value="0" /><Option Name="power down" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - no power down  - '+
'''1'' - power down</Desc></Res><Res Name="OptionClientReceipt" Value="" Type="Option" MaxLen="1"><Options><Option Name="invoice (client) receipt" Value="1" /><Option Name="standard receipt" Value="0" /></Options><Desc>1 symbol with value:  - ''0'' - stand'+
'ard receipt  - ''1'' - invoice (client) receipt</Desc></Res><Res Name="ChangeAmount" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols the amount of the due change in the stated payment type</Desc></Res><Res Name="OptionRcpChangeType" Value="" Type='+
'"Option" MaxLen="1"><Options><Option Name="Change In Cash" Value="0" /><Option Name="Change In Currency" Value="2" /><Option Name="Same As The payment" Value="1" /></Options><Desc>1 symbols with value:  - ''0'' - Change In Cash  - ''1'' - Same As The paym'+
'ent  - ''2'' - Change In Currency</Desc></Res><ResFormatRaw><![CDATA[<IsReceiptOpened[1]> <;> <SalesNumber[3]> <;> <SubtotalAmountVATGA[1..13]> <;> <SubtotalAmountVATGB[1..13]> <;> <SubtotalAmountVATGC[1..13]> <;> <SubtotalAmountVATGD[1..13]> <;> <Subtota'+
'lAmountVATGE[1..13]> <;> <SubtotalAmountVATGF[1..13]> <;> <SubtotalAmountVATGG[1..13]> <;> <SubtotalAmountVATGH[1..13]> <;> <SubtotalAmountVATGI[1..13]> <;> <ForbiddenVoid[1]> <;><VATinReceipt[1]> <;> <DetailedReceipt[1]> <;> <InitiatedPayment[1]> <;> <Fi'+
'nalizedPayment[1]><;> <FlagPowerDown[1]> <;> <ClientReceipt[1]> <;> <ChangeAmount[1..13]> <;> <OptionRcpChangeType[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadCustomerData" CmdByte="0x52"><FPOperation>Provide information for specified cus'+
'tomer from FD database.</FPOperation><Args><Arg Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="CustomerNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for customer number in order in format ####</D'+
'esc></Arg><ArgsFormatRaw><![CDATA[ <Option[''R'']> <;><CustomerNum[4]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="CustomerNum" Value="" Type="Decimal_with_format" MaxLen="3" Format="0000"><Desc>3 symbols for customer number in order in for'+
'mat ####</Desc></Res><Res Name="CustomerVatNum" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for customer VAT registration number</Desc></Res><Res Name="CustomerName" Value="" Type="Text" MaxLen="30"><Desc>30 symbols for customer name</Desc></Res><Re'+
's Name="CustomerAddress" Value="" Type="Text" MaxLen="30"><Desc>30 symbols for customer address</Desc></Res><Res Name="FreeLine1" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc></Res><Res Name="FreeLine2" Value="" Type="Te'+
'xt" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc></Res><Res Name="FreeLine3" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for customer data</Desc></Res><Res Name="FreeLine4" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols '+
'for customer data</Desc></Res><ResFormatRaw><![CDATA[<CustomerNum[3]> <;> <CustomerVatNum[15]> <;> <CustomerName[30]> <;> <CustomerAddress[30] <;><FreeLine1[20]> <;> <FreeLine2[20]> <;> <FreeLine3[20]> <;> <FreeLine4[20]>]]></ResFormatRaw></Response></Com'+
'mand><Command Name="ReadDailyAvailableAmounts_V2" CmdByte="0x6E"><FPOperation>Provide information about the amounts on hand by type of payment.</FPOperation><Args><Arg Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''0''> '+
']]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><Res Name="AmountPay0" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 0</Desc></Res><Res Name="A'+
'mountPay1" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 1</Desc></Res><Res Name="AmountPay2" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 2</Desc><'+
'/Res><Res Name="AmountPay3" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 3</Desc></Res><Res Name="AmountPay4" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payme'+
'nt type 4</Desc></Res><Res Name="AmountPay5" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 5</Desc></Res><Res Name="AmountPay6" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulate'+
'd amount of payment type 6</Desc></Res><Res Name="AmountPay7" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 7</Desc></Res><Res Name="AmountPay8" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols f'+
'or the accumulated amount of payment type 8</Desc></Res><ResFormatRaw><![CDATA[<''0''><;><AmountPay0[1..13]><;><AmountPay1[1..13]><;> <AmountPay2[1..13]><;><AmountPay3[1..13]> <;><AmountPay4[1..13]> <;><AmountPay5[1..13]> <;><AmountPay6[1..13]> <;><Amount'+
'Pay7[1..13]> <;><AmountPay8[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyAvailableAmounts_V2_1" CmdByte="0x6E"><FPOperation>Provide information about the amounts on hand by type of payment.</FPOperation><Args><Arg Name="" Value="0'+
'" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''0''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><Res Name="AmountPay0" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbol'+
's for the accumulated amount of payment type 0</Desc></Res><Res Name="AmountPay1" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 1</Desc></Res><Res Name="AmountPay2" Value="" Type="Decimal" MaxLen="13"><'+
'Desc>1..13 symbols for the accumulated amount of payment type 2</Desc></Res><Res Name="AmountPay3" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 3</Desc></Res><Res Name="AmountPay4" Value="" Type="Decim'+
'al" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 4</Desc></Res><Res Name="AmountPay5" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 5</Desc></Res><Res Name="AmountPay6" Val'+
'ue="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 6</Desc></Res><Res Name="AmountPay7" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 7</Desc></Res><Res Name'+
'="AmountPay8" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 8</Desc></Res><Res Name="AmountPay9" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 9</Des'+
'c></Res><Res Name="AmountPay10" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 10</Desc></Res><Res Name="AmountPay11" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of'+
' payment type 11</Desc></Res><Res Name="AmountPay12" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 12</Desc></Res><Res Name="AmountPay13" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the '+
'accumulated amount of payment type 13</Desc></Res><Res Name="AmountPay14" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the accumulated amount of payment type 14</Desc></Res><ResFormatRaw><![CDATA[<''0''><;><AmountPay0[1..13]><;><AmountPay1['+
'1..13]><;> <AmountPay2[1..13]><;><AmountPay3[1..13]> <;><AmountPay4[1..13]> <;><AmountPay5[1..13]> <;><AmountPay6[1..13]> <;><AmountPay7[1..13]> <;><AmountPay8[1..13]> <;><AmountPay9[1..13]> <;><AmountPay10[1..13]> <;><AmountPay11[1..13]> <;><AmountPay12['+
'1..13]> <;><AmountPay13[1..13]> <;><AmountPay14[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyCounters" CmdByte="0x6E"><FPOperation>Provides information about the current reading of the daily-report- with-zeroing counter, the numbe'+
'r of the last block stored in FM, the number of EJ and the date and time of the last block storage in the FM.</FPOperation><Args><Arg Name="" Value="5" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''5''> ]]></ArgsFormatRaw></Args><Respons'+
'e ACK="false"><Res Name="" Value="5" Type="OptionHardcoded" MaxLen="1" /><Res Name="LastReportNumFromReset" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of the last report from reset</Desc></Res><Res Name="LastFMBlockNum" Value="" T'+
'ype="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of the last FM report</Desc></Res><Res Name="EJNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of EJ</Desc></Res><Res Name="DateTime" Value="" Type="DateTime" MaxLen="10" F'+
'ormat="dd-MM-yyyy HH:mm"><Desc>16 symbols for date and time of the last block storage in FM in format "DD-MM-YYYY HH:MM"</Desc></Res><ResFormatRaw><![CDATA[<''5''> <;> <LastReportNumFromReset[1..5]> <;> <LastFMBlockNum[1..5]> <;> <EJNum[1..5]> <;> <DateTi'+
'me "DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Name="ReadDailyCountersByOperator" CmdByte="0x6F"><FPOperation>Read the last operator''s report number and date and time.</FPOperation><Args><Arg Name="" Value="5" Type="OptionHardcoded'+
'" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''5''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name'+
'="" Value="5" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="WorkOperatorsCounter" Value="" Type="Decimal" MaxLen="5"><Desc>U'+
'p to 5 symbols for number of the work operators</Desc></Res><Res Name="LastOperatorReportDateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy"><Desc>10 symbols for date and time of the last operator''s report in format DD-MM-YYYY</Desc></Res>'+
'<ResFormatRaw><![CDATA[<''5''> <;> <OperNum[1..2]> <;> <WorkOperatorsCounter[1..5]> <;> <LastOperatorReportDateTime "DD-MM-YYYY">]]></ResFormatRaw></Response></Command><Command Name="ReadDailyGeneralRegistersByOperator" CmdByte="0x6F"><FPOperation>Provide'+
's information about the number of customers (number of fiscal receipt issued), number of discounts, additions and corrections made and the accumulated amounts.</FPOperation><Args><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNu'+
'm" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20in format corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''1''><;><OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="1" Type="Option'+
'Hardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>(Operator Number) Symbol from 1 to 20in format corresponding to operator''s number</Desc></Res><Res Name="CustomersNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 s'+
'ymbols for number of customers</Desc></Res><Res Name="DiscountsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of discounts</Desc></Res><Res Name="DiscountsAmount" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for acc'+
'umulated amount of discounts</Desc></Res><Res Name="AdditionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number ofadditions</Desc></Res><Res Name="AdditionsAmount" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for accumu'+
'lated amount of additions</Desc></Res><Res Name="CorrectionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of corrections</Desc></Res><Res Name="CorrectionsAmount" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for ac'+
'cumulated amount of corrections</Desc></Res><ResFormatRaw><![CDATA[<''1''> <;><OperNum[1..2]> <;> <CustomersNum[1..5]> <;> <DiscountsNum[1..5]> <;> <DiscountsAmount[1..13]> <;> <AdditionsNum[1..5]> <;> <AdditionsAmount[1..13]> <;> <CorrectionsNum[1..5]> <'+
';> <CorrectionsAmount[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyPO" CmdByte="0x6E"><FPOperation>Provides information about the PO amounts by type of payment and the total number of operations.</FPOperation><Args><Arg Name="" Va'+
'lue="3" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''3''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><Res Name="AmountPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up'+
' to 13 symbols for the accumulated amount by payment type 0</Desc></Res><Res Name="PONum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</Desc></Res><ResFormatRaw><![CDATA[<''3''> <;> <AmountPayment0[1..13]> <;'+
'> <PONum[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyPObyOperator_V2" CmdByte="0x6F"><FPOperation>Provides information about the amounts received from sales by type of payment and specified operator.</FPOperation><Args><Arg Name="'+
'" Value="4" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''4''> <;> < OperNum[1..2]> ]]></ArgsFormatRaw></Arg'+
's><Response ACK="false"><Res Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="ReceivedSalesAmountPay0" Value='+
'"" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.0</Desc></Res><Res Name="ReceivedSalesAmountPay1" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.1</Desc></Res><'+
'Res Name="ReceivedSalesAmountPay2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.2</Desc></Res><Res Name="ReceivedSalesAmountPay3" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts r'+
'eceived by sales for paym.3</Desc></Res><Res Name="ReceivedSalesAmountPay4" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.4</Desc></Res><Res Name="ReceivedSalesAmountPay5" Value="" Type="Decimal" MaxLen='+
'"13"><Desc>Up to 13 symbols for amounts received by sales for paym.5</Desc></Res><Res Name="ReceivedSalesAmountPay6" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.6</Desc></Res><Res Name="ReceivedSalesAm'+
'ountPay7" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.7</Desc></Res><Res Name="ReceivedSalesAmountPay8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym'+
'.8</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;> <OperNum[1..2]> <;> <ReceivedSalesAmountPay0[1..13]> <;> <ReceivedSalesAmountPay1[1..13]> <;> <ReceivedSalesAmountPay2[1..13]> <;> <ReceivedSalesAmountPay3[1..13]> <;> <ReceivedSalesAmountPay4[1..13]> <;> '+
'<ReceivedSalesAmountPay5[1..13]> <;> <ReceivedSalesAmountPay6[1..13]> <;> <ReceivedSalesAmountPay7[1..13]> <;> <ReceivedSalesAmountPay8[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyPObyOperator_V2_1" CmdByte="0x6F"><FPOperation>Pr'+
'ovides information about the amounts received from sales by type of payment and specified operator.</FPOperation><Args><Arg Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to'+
' 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''4''> <;> < OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal'+
'" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="ReceivedSalesAmountPay0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.0</Desc></Res><Res Name="Received'+
'SalesAmountPay1" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.1</Desc></Res><Res Name="ReceivedSalesAmountPay2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales f'+
'or paym.2</Desc></Res><Res Name="ReceivedSalesAmountPay3" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.3</Desc></Res><Res Name="ReceivedSalesAmountPay4" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 1'+
'3 symbols for amounts received by sales for paym.4</Desc></Res><Res Name="ReceivedSalesAmountPay5" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.5</Desc></Res><Res Name="ReceivedSalesAmountPay6" Value=""'+
' Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.6</Desc></Res><Res Name="ReceivedSalesAmountPay7" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.7</Desc></Res><Re'+
's Name="ReceivedSalesAmountPay8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.8</Desc></Res><Res Name="ReceivedSalesAmountPay9" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts rec'+
'eived by sales for paym.9</Desc></Res><Res Name="ReceivedSalesAmountPay10" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.10</Desc></Res><Res Name="ReceivedSalesAmountPay11" Value="" Type="Decimal" MaxLen'+
'="13"><Desc>Up to 13 symbols for amounts received by sales for paym.11</Desc></Res><Res Name="ReceivedSalesAmountPay12" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.12</Desc></Res><Res Name="ReceivedSal'+
'esAmountPay13" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales for paym.13</Desc></Res><Res Name="ReceivedSalesAmountPay14" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by sales f'+
'or paym.14</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;> <OperNum[1..2]> <;> <ReceivedSalesAmountPay0[1..13]> <;> <ReceivedSalesAmountPay1[1..13]> <;> <ReceivedSalesAmountPay2[1..13]> <;> <ReceivedSalesAmountPay3[1..13]> <;> <ReceivedSalesAmountPay4[1..1'+
'3]> <;> <ReceivedSalesAmountPay5[1..13]> <;> <ReceivedSalesAmountPay6[1..13]> <;> <ReceivedSalesAmountPay7[1..13]> <;> <ReceivedSalesAmountPay8[1..13]> <;> <ReceivedSalesAmountPay9[1..13]> <;> <ReceivedSalesAmountPay10[1..13]> <;> <ReceivedSalesAmountPay1'+
'1[1..13]> <;> <ReceivedSalesAmountPay12[1..13]> <;> <ReceivedSalesAmountPay13[1..13]><;><ReceivedSalesAmountPay14[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyRA" CmdByte="0x6E"><FPOperation>Provides information about the RA amoun'+
'ts by type of payment and the total number of operations.</FPOperation><Args><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''2''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="2" Type="OptionHar'+
'dcoded" MaxLen="1" /><Res Name="AmountPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 0</Desc></Res><Res Name="RANum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total nu'+
'mber of operations</Desc></Res><ResFormatRaw><![CDATA[<''2''><;><AmountPayment0[1..13]> <;> <RANum[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyRAbyOperator" CmdByte="0x6F"><FPOperation>Provides information about the RA by type of '+
'payment as well as the total number of operations by specified operator.</FPOperation><Args><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to operat'+
'or''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''2''> <;> <OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols f'+
'rom 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="AmountRA_Payment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the RA by type of payment 0</Desc></Res><Res Name="NoRA" Value="" Type="Decimal" MaxLen="5"><Desc>Up t'+
'o 5 symbols for the total number of operations</Desc></Res><ResFormatRaw><![CDATA[<''2''> <;> <OperNum[1..2]> <;> <AmountRA_Payment0[1..13]> <;> <NoRA[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReceivedAmounts_V2" CmdByte="0x6E">'+
'<FPOperation>Provides information about the amounts received from sales by type of payment.</FPOperation><Args><Arg Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''4''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res'+
' Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="AmountPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 0</Desc></Res><Res Name="AmountPayment1" Value="" Type="Decimal" MaxLen'+
'="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 1</Desc></Res><Res Name="AmountPayment2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 2</Desc></Res><Res Name="AmountPayment3"'+
' Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 3</Desc></Res><Res Name="AmountPayment4" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 4</Desc><'+
'/Res><Res Name="AmountPayment5" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 5</Desc></Res><Res Name="AmountPayment6" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated a'+
'mount by payment type 6</Desc></Res><Res Name="AmountPayment7" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 7</Desc></Res><Res Name="AmountPayment8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 1'+
'3 symbols for the accumulated amount by payment type 8</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;><AmountPayment0[1..13]> <;> <AmountPayment1[1..13]> <;> <AmountPayment2[1..13]> <;> <AmountPayment3[1..13]> <;> <AmountPayment4[1..13]> <;><AmountPayment5'+
'[1..13]><;><AmountPayment6[1..13]><;><AmountPayment7[1..13]><;><AmountPayment8[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReceivedAmounts_V2_1" CmdByte="0x6E"><FPOperation>Provides information about the amounts received from sal'+
'es by type of payment.</FPOperation><Args><Arg Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''4''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="Amo'+
'untPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 0</Desc></Res><Res Name="AmountPayment1" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment ty'+
'pe 1</Desc></Res><Res Name="AmountPayment2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 2</Desc></Res><Res Name="AmountPayment3" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the a'+
'ccumulated amount by payment type 3</Desc></Res><Res Name="AmountPayment4" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 4</Desc></Res><Res Name="AmountPayment5" Value="" Type="Decimal" MaxLen="13"><'+
'Desc>Up to 13 symbols for the accumulated amount by payment type 5</Desc></Res><Res Name="AmountPayment6" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 6</Desc></Res><Res Name="AmountPayment7" Value='+
'"" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 7</Desc></Res><Res Name="AmountPayment8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 8</Desc></Res><R'+
'es Name="AmountPayment9" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 9</Desc></Res><Res Name="AmountPayment10" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount '+
'by payment type 10</Desc></Res><Res Name="AmountPayment11" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 11</Desc></Res><Res Name="AmountPayment12" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 '+
'symbols for the accumulated amount by payment type 12</Desc></Res><Res Name="AmountPayment13" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 13</Desc></Res><Res Name="AmountPayment14" Value="" Type="D'+
'ecimal" MaxLen="13"><Desc>Up to 13 symbols for the accumulated amount by payment type 14</Desc></Res><ResFormatRaw><![CDATA[<''4''> <;><AmountPayment0[1..13]><;><AmountPayment1[1..13]><;><AmountPayment2[1..13]><;><AmountPayment3[1..13]><;><AmountPayment4['+
'1..13]><;><AmountPayment5[1..13]><;><AmountPayment6[1..13]><;><AmountPayment7[1..13]><;><AmountPayment8[1..13]><;><AmountPayment9[1..13]><;><AmountPayment10[1..13]> <;><AmountPayment11[1..13]><;><AmountPayment12[1..13]> <;><AmountPayment13[1..13]><;><Amou'+
'ntPayment14[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReturnedChangeAmountsByOperator_V2" CmdByte="0x6F"><FPOperation>Provides information about the amounts returned as change by different payment types for the specified operat'+
'or.</FPOperation><Args><Arg Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''6''> <;> < OperN'+
'um[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Nam'+
'e="ChangeAmountPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 0</Desc></Res><Res Name="ChangeAmountPayment1" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by t'+
'ype of payment 1</Desc></Res><Res Name="ChangeAmountPayment2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 2</Desc></Res><Res Name="ChangeAmountPayment3" Value="" Type="Decimal" MaxLen="13"><Desc>Up to'+
' 13 symbols for amounts received by type of payment 3</Desc></Res><Res Name="ChangeAmountPayment4" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 4</Desc></Res><Res Name="ChangeAmountPayment5" Value="" T'+
'ype="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 5</Desc></Res><Res Name="ChangeAmountPayment6" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 6</Desc></Res><Res N'+
'ame="ChangeAmountPayment7" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 7</Desc></Res><Res Name="ChangeAmountPayment8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by'+
' type of payment 8</Desc></Res><ResFormatRaw><![CDATA[<''6''> <;> <OperNum[1..2]> <;> <ChangeAmountPayment0[1..13]> <;> <ChangeAmountPayment1[1..13]> <;> <ChangeAmountPayment2[1..13]> <;> <ChangeAmountPayment3[1..13]> <;> <ChangeAmountPayment4[1..13]> <;>'+
' <ChangeAmountPayment5[1..13]> <;> <ChangeAmountPayment6[1..13]> <;> <ChangeAmountPayment7[1..13]> <;> <ChangeAmountPayment8[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDailyReturnedChangeAmountsByOperator_V2_1" CmdByte="0x6F"><FPOper'+
'ation>Provides information about the amounts returned as change by different payment types for the specified operator.</FPOperation><Args><Arg Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OperNum" Value="" Type="Decimal" MaxLen="2"><De'+
'sc>Symbol from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''6''> <;> < OperNum[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="6" Type="OptionHardcoded" MaxLen="1" /><Res Name="OperNum" Val'+
'ue="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="ChangeAmountPayment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 0</Desc></Res><R'+
'es Name="ChangeAmountPayment1" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 1</Desc></Res><Res Name="ChangeAmountPayment2" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts receive'+
'd by type of payment 2</Desc></Res><Res Name="ChangeAmountPayment3" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 3</Desc></Res><Res Name="ChangeAmountPayment4" Value="" Type="Decimal" MaxLen="13"><Desc'+
'>Up to 13 symbols for amounts received by type of payment 4</Desc></Res><Res Name="ChangeAmountPayment5" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 5</Desc></Res><Res Name="ChangeAmountPayment6" Valu'+
'e="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 6</Desc></Res><Res Name="ChangeAmountPayment7" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 7</Desc></Res>'+
'<Res Name="ChangeAmountPayment8" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 8</Desc></Res><Res Name="ChangeAmountPayment9" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts recei'+
'ved by type of payment 9</Desc></Res><Res Name="ChangeAmountPayment10" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 10</Desc></Res><Res Name="ChangeAmountPayment11" Value="" Type="Decimal" MaxLen="13">'+
'<Desc>Up to 13 symbols for amounts received by type of payment 11</Desc></Res><Res Name="ChangeAmountPayment12" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 12</Desc></Res><Res Name="ChangeAmountPaymen'+
't13" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 13</Desc></Res><Res Name="ChangeAmountPayment14" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for amounts received by type of payment 14<'+
'/Desc></Res><ResFormatRaw><![CDATA[<''6''> <;> <OperNum[1..2]> <;> <ChangeAmountPayment0[1..13]> <;> <ChangeAmountPayment1[1..13]> <;> <ChangeAmountPayment2[1..13]> <;> <ChangeAmountPayment3[1..13]> <;> <ChangeAmountPayment4[1..13]> <;> <ChangeAmountPayme'+
'nt5[1..13]> <;> <ChangeAmountPayment6[1..13]> <;> <ChangeAmountPayment7[1..13]> <;> <ChangeAmountPayment8[1..13]> <;> <ChangeAmountPayment9[1..13]> <;> <ChangeAmountPayment10[1..13]> <;> <ChangeAmountPayment11[1..13]> <;> <ChangeAmountPayment12[1..13]> <;'+
'> <ChangeAmountPayment13[1..13]> <;> <ChangeAmountPayment14[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadDateTime" CmdByte="0x68"><FPOperation>Provide information about the current date and time.</FPOperation><Response ACK="false"><Res'+
' Name="DateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>Date Time parameter in format: DD-MM-YY [Space] hh:mm</Desc></Res><ResFormatRaw><![CDATA[<DateTime "DD-MM-YYYY HH:MM">]]></ResFormatRaw></Response></Command><Command Nam'+
'e="ReadDepartment" CmdByte="0x67"><FPOperation>Provides information for the programmed data, the turnover from the stated department number</FPOperation><Args><Arg Name="DepNum" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols fo'+
'r deparment number in format: ##</Desc></Arg><ArgsFormatRaw><![CDATA[ <DepNum[2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="DepNum" Value="" Type="Text" MaxLen="2"><Desc>(Department Number) 2 symbols for department in format: ##</Desc></R'+
'es><Res Name="DepName" Value="" Type="Text" MaxLen="20"><Desc>(Department Name) 20 symbols for department name</Desc></Res><Res Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Option Name="VAT class A" Value="A" /><Option Name="VAT class'+
' B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Option Name="VAT class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Name="VAT class G" Value="G" /><Option Name="VAT class H" Value="H" /><Opti'+
'on Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article''s VAT Class with optional values:  - ''A'' - VAT class A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'' - VAT class D  - ''E'' - VAT class E  - ''F'' - VAT class F  - ''G'' - '+
'VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Res><Res Name="Turnover" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for accumulated turnover of the department</Desc></Res><Res Name="SoldQuantity" Value="" Type="Decimal" MaxL'+
'en="13"><Desc>1..13 symbols for sold quantity of the department</Desc></Res><Res Name="LastZReportNumber" Value="" Type="Decimal" MaxLen="5"><Desc>1..5 symbols for the number of last Z report</Desc></Res><Res Name="LastZReportDate" Value="" Type="DateTime'+
'" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for the date and time of the last article report with zeroing  in format DD-MM-YYYY HH:MM</Desc></Res><Res Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for department price'+
'</Desc></Res><Res Name="OptionDepPrice" Value="" Type="Option" MaxLen="1"><Options><Option Name="Free price disabled" Value="0" /><Option Name="Free price disabled for single transaction" Value="4" /><Option Name="Free price enabled" Value="1" /><Option N'+
'ame="Free price enabled for single transaction" Value="5" /><Option Name="Limited price" Value="2" /><Option Name="Limited price for single transaction" Value="6" /></Options><Desc>1 symbol for Department flags with next value:  - ''0'' - Free price disab'+
'led  - ''1'' - Free price enabled  - ''2'' - Limited price  - ''4'' - Free price disabled for single transaction  - ''5'' - Free price enabled for single transaction  - ''6'' - Limited price for single transaction</Desc></Res><ResFormatRaw><![CDATA[<DepNu'+
'm[2]> <;><DepName[20]> <;> <OptionVATClass[1]> <;> <Turnover[1..13]> <;> <SoldQuantity[1..13]> <;><LastZReportNumber[1..5]> <;> < LastZReportDate "DD-MM-YYYY HH:MM"> <;><Price[1..10]><;><OptionDepPrice[1]>]]></ResFormatRaw></Response></Command><Command Na'+
'me="ReadDetailedFMReportByDate" CmdByte="0x7A"><FPOperation>Storage a detailed FM report by initial and end date.</FPOperation><Args><Arg Name="StartDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY '+
'format</Desc></Arg><Arg Name="EndDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><Arg Name="PCStorage" Value="8" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Start'+
'Date "DDMMYY"><;><EndDate "DDMMYY"> <;><PCStorage[''8'']> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadDetailedFMReportByZNum" CmdByte="0x78"><FPOperation>Storage a detailed FM report by initial and end FM '+
'report number.</FPOperation><Args><Arg Name="StartNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for the initial report number included in report, format ####</Desc></Arg><Arg Name="EndNum" Value="" Type="Decimal_with_fo'+
'rmat" MaxLen="4" Format="0000"><Desc>4 symbols for the final report number included in report, format ####</Desc></Arg><Arg Name="PCStorage" Value="8" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <StartNum[4]><;><EndNum[4]><;><PCStorage['+
'''8'']> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadDeviceModuleSupport" CmdByte="0x4E"><FPOperation>Provide an information about modules supported by the device</FPOperation><Args><Arg Name="" Value="R" T'+
'ype="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''D''><;><''D''> ]]></ArgsFormatRaw></Args><Response ACK="false"><'+
'Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionLAN" Value="" Type="Option" MaxLen="1"><Options><Option Name="'+
'No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for LAN suppor - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionWiFi" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /><'+
'/Options><Desc>1 symbol for WiFi support - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionGPRS" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for GPRS support - ''0'+
''' - No  - ''1'' - Yes BT (Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionBT" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Blue'+
'tooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''D''><;><''D''><;><LAN[1]><;><WiFi[1]><;><GPRS[1]><;><BT[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDeviceModuleSupportByFir'+
'mware" CmdByte="0x4E"><FPOperation>Provide an information about modules supported by device''s firmware</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" V'+
'alue="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''D''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="D" Type="OptionHardcoded" MaxL'+
'en="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionLAN" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for LAN suppor - ''0'' - No  - ''1'+
''' - Yes</Desc></Res><Res Name="OptionWiFi" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for WiFi support - ''0'' - No  - ''1'' - Yes</Desc></Res><Res Name="OptionGPRS" Va'+
'lue="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for GPRS support - ''0'' - No  - ''1'' - Yes BT (Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></R'+
'es><Res Name="OptionBT" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Bluetooth) 1 symbol for Bluetooth support - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<''R'+
'''><;><''D''><;><''S''><;><LAN[1]><;><WiFi[1]><;><GPRS[1]><;><BT[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadDHCP_Status" CmdByte="0x4E"><FPOperation>Provides information about device''s DHCP status</FPOperation><Args><Arg Name="" Value="'+
'R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''T''><;><''1''> ]]></ArgsFormatRaw></Args><Response ACK="fals'+
'e"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionDhcpStatus" Value="" Type="Option" MaxLen="1"><Options><Op'+
'tion Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>(DHCP Status) 1 symbol for device''s DHCP status - ''0'' - Disabled  - ''1'' - Enabled</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''T''><;><''1''><;><DhcpStatus[1]>]]><'+
'/ResFormatRaw></Response></Command><Command Name="ReadDisplayGreetingMessage" CmdByte="0x69"><FPOperation>Provide information about the contents of a Display Greeting message.</FPOperation><Args><Arg Name="OptionDisplayGreeting" Value="0" Type="OptionHard'+
'coded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<OptionDisplayGreeting[''0'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionDisplayGreeting" Value="0" Type="OptionHardcoded" MaxLen="1" /><Res Name="DisplayGreetingText" Value="" Type="Text"'+
' MaxLen="20"><Desc>20 symbols for display greeting message</Desc></Res><ResFormatRaw><![CDATA[<OptionDisplayGreeting[''0'']><;><DisplayGreetingText[20]>]]></ResFormatRaw></Response></Command><Command Name="ReadEJ" CmdByte="0x7C"><FPOperation>Reading all E'+
'lectronic Journal report.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''J0''><;><''*''> ]]></ArgsFormatRaw></Args><Response ACK="true" '+
'ACK_PLUS="true" /></Command><Command Name="ReadEJByDate" CmdByte="0x7C"><FPOperation>Reading Electronic Journal Report from Start Date to End Date.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="D" Type='+
'"OptionHardcoded" MaxLen="1" /><Arg Name="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMM'+
'yy"><Desc>6 symbols for final date in the DDMMYY format</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For inc'+
'luded non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicating'+
'Presence=";" /></Arg><ArgsFormatRaw><![CDATA[ <''J0''><;><''D''><;>< StartRepFromDate "DDMMYY"><;>< EndRepFromDate "DDMMYY"> {<;><FlagsTypeRec[1]>} ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByDateCusto'+
'm" CmdByte="0x7C"><FPOperation>Read or Store Electronic Journal Report by initial to end date</FPOperation><Args><Arg Name="OptionStorageReport" Value="" Type="Option" MaxLen="2"><Options><Option Name="To PC" Value="j0" /><Option Name="To SD card" Value="'+
'j4" /><Option Name="To USB Flash Drive" Value="j2" /></Options><Desc>2 characters with value:  - ''j0'' - To PC  - ''j2'' - To USB Flash Drive  - ''j4'' - To SD card</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name='+
'"FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z dail'+
'y reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="" Type="Text" MaxLen="1"><Desc>0</Desc></Arg><Arg Name="" Value="D" Type="OptionHardcoded" Ma'+
'xLen="1" /><Arg Name="StartRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols for initial date in the DDMMYY format</Desc></Arg><Arg Name="EndRepFromDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyy"><Desc>6 symbols '+
'for final date in the DDMMYY format</Desc></Arg><ArgsFormatRaw><![CDATA[ <StorageReport[2]> <;> <reserved[''0'']> <;> <FlagsTypeRec[1]> <;> <reserved[1]> <;> <''D''> <;> <StartRepFromDate "DDMMYY"> <;> <EndRepFromDate "DDMMYY"> ]]></ArgsFormatRaw></Args><'+
'Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByReceiptNum" CmdByte="0x7C"><FPOperation>Reading Electronic Journal Report from receipt number to receipt number.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLe'+
'n="2" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRcpNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for initial receipt number included in report, format #####</Desc></Arg><Arg Name="End'+
'RcpNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for final receipt number included in report, format #####</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type '+
'of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts,'+
' 0= for not included Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <''J0''><;><''N''><;><StartRcpNum[5]><;><EndRcpNum[5]> {<;><FlagsTypeRec[1]>} ]]></ArgsFormatRaw></Args><Response ACK="tr'+
'ue" ACK_PLUS="true" /></Command><Command Name="ReadEJByReceiptNumCustom" CmdByte="0x7C"><FPOperation>Read or Store Electronic Journal Report from receipt number to receipt number, CSV format option and document content. If CSV format is set the content ca'+
'n includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.</FPOperation><Args><Arg Name="OptionStorageReport" Value="" Type="Option" MaxLen="2"><Options'+
'><Option Name="To PC" Value="j0" /><Option Name="To SD card" Value="j4" /><Option Name="To USB Flash Drive" Value="j2" /></Options><Desc>1 character with value  - ''j0'' - To PC  - ''j2'' - To USB Flash Drive  - ''j4'' - To SD card</Desc></Arg><Arg Name="'+
'reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fi'+
'scal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" M'+
'axLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartRcpNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000."><Desc>6 symbols for initial receipt number included in report in format ######.</Desc></Arg><Arg'+
' Name="EndRcpNum" Value="" Type="Decimal_with_format" MaxLen="6" Format="000000."><Desc>6 symbols for final receipt number included in report in format ######.</Desc></Arg><ArgsFormatRaw><![CDATA[ <StorageReport[2]> <;> <reserved[''0'']> <;> <FlagsTypeRec'+
'[1]> <;> <reserved[''0'']> <;> <''N''> <;> <StartRcpNum[6]> <;> <EndRcpNum[6]> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByZBlocks" CmdByte="0x7C"><FPOperation>Reading Electronic Journal Report from re'+
'port number to report number.</FPOperation><Args><Arg Name="" Value="J0" Type="OptionHardcoded" MaxLen="2" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Des'+
'c>4 symbols for initial number report in format ####</Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number report in format ####</Desc></Arg><Arg Name="FlagsTypeRec" Value="" Type="Fl'+
'ags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included F'+
'lags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <''J0''><;><''Z''><;><StartZNum[4]><;><EndZNum[4]> {<;><FlagsTyp'+
'eRec[1]>} ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJByZBlocksCustom" CmdByte="0x7C"><FPOperation>Read or Store Electronic Journal Report by number of Z report blocks, CSV format option and document con'+
'tent. If CSV format is set the content can includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.</FPOperation><Args><Arg Name="OptionStorageReport" V'+
'alue="" Type="Option" MaxLen="2"><Options><Option Name="To PC" Value="j0" /><Option Name="To SD card" Value="j4" /><Option Name="To USB Flash Drive" Value="j2" /></Options><Desc>1 character with value  - ''j0'' - To PC  - ''j2'' - To USB Flash Drive  - '+
'''j4'' - To SD card</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: Flags.0 = 0 Flags.1 = 0 '+
'Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0</Desc></Arg><Arg Name="r'+
'eserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="StartZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for initial number report in format ####</'+
'Desc></Arg><Arg Name="EndZNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for final number report in format ####</Desc></Arg><ArgsFormatRaw><![CDATA[ <StorageReport[2]> <;> <reserved[''0'']> <;> <FlagsTypeRec[1]> <;> <res'+
'erved[''0'']> <;> <''Z''> <;> <StartZNum[4]> <;> <EndZNum[4]> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadEJCustom" CmdByte="0x7C"><FPOperation>Read or Store Electronic Journal report by CSV format option '+
'and document content selecting. If CSV format is set the content can includes only fiscal receipts. FlagsReceipts is a char with bits representing the receipt types. FlagsReports is a char with bits representing the report type.</FPOperation><Args><Arg Na'+
'me="OptionStorageReport" Value="" Type="Option" MaxLen="2"><Options><Option Name="To PC" Value="j0" /><Option Name="To SD card" Value="j4" /><Option Name="To USB Flash Drive" Value="j2" /></Options><Desc>1 character with value  - ''j0'' - To PC  - ''j2'' '+
'- To USB Flash Drive  - ''j4'' - To SD card</Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="FlagsTypeRec" Value="" Type="Flags" MaxLen="1"><Desc>1 optional byte with flag for type of included receipts as follows: '+
'Flags.0 = 0 Flags.1 = 0 Flags.2 = 0 Flags.3 = 1 For included non-fiscal receipts, 0= for not included Flags.4 = 1 For included Z daily reports, 0= for not included Flags.5 = 0 Flags.6 =1 For included fiscal sales receipts, 0= for not included Flags.7 = 0<'+
'/Desc></Arg><Arg Name="reserved" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="*" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <StorageReport[2]> <;> <reserved[''0'']> <;> <FlagsTypeRec[1]> <;> <reserved[''0'']> <;> <'+
'''*''> ]]></ArgsFormatRaw></Args><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadFirstUnsentReceiptToServer" CmdByte="0x5A"><FPOperation>Provide information about first unsent receipt to server</FPOperation><Args><Arg Name="Option" Val'+
'ue="5" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''5'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="5" Type="OptionHardcoded" MaxLen="1" /><Res Name="ReceiptDate" Value="" Type="DateTime" MaxLen="1'+
'0" Format="dd-MM-yyyy HH:mm:ss"><Desc>Receipt Date parameter</Desc></Res><Res Name="ReceiptNumber" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for receipt number</Desc></Res><ResFormatRaw><![CDATA[<Option[''5'']> <;> <ReceiptDate "DD-MM-YYYY HH:MM:SS"'+
'> <;><ReceiptNumber[6]>]]></ResFormatRaw></Response></Command><Command Name="ReadFMcontent" CmdByte="0x75"><FPOperation>Provides consequently information about every single block stored in the FM starting with ACKs and ending with end message.</FPOperatio'+
'n><Response ACK="true" ACK_PLUS="true" /></Command><Command Name="ReadFMfreeRecords" CmdByte="0x74"><FPOperation>Read the number of the remaining free records for Z-report in the Fiscal Memory.</FPOperation><Response ACK="false"><Res Name="FreeFMrecords" '+
'Value="" Type="Text" MaxLen="4"><Desc>4 symbols for the number of free records for Z-report in the FM</Desc></Res><ResFormatRaw><![CDATA[<FreeFMrecords[4]><;>]]></ResFormatRaw></Response></Command><Command Name="ReadFooter" CmdByte="0x69"><FPOperation>Pro'+
'vide information about the contents of a footer line.</FPOperation><Args><Arg Name="OptionFooterLine" Value="8" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<OptionFooterLine[''8'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name'+
'="OptionFooterLine" Value="8" Type="OptionHardcoded" MaxLen="1" /><Res Name="FooterText" Value="" Type="Text" MaxLen="64"><Desc>TextLength symbols for footer line</Desc></Res><ResFormatRaw><![CDATA[<OptionFooterLine[''8'']> <;> <FooterText[TextLength]>]]>'+
'</ResFormatRaw></Response></Command><Command Name="ReadGeneralDailyRegisters" CmdByte="0x6E"><FPOperation>Provides information about the number of customers (number of fiscal receipt issued), number of discounts, additions and corrections made and the acc'+
'umulated amounts.</FPOperation><Args><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''1''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Res Name="Customer'+
'sNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of customers</Desc></Res><Res Name="DiscountsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of discounts</Desc></Res><Res Name="DiscountsAmount" Value="" T'+
'ype="Decimal" MaxLen="13"><Desc>Up to 13 symbols for accumulated amount of discounts</Desc></Res><Res Name="AdditionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of additions</Desc></Res><Res Name="AdditionsAmount" Value="" Typ'+
'e="Decimal" MaxLen="13"><Desc>Up to 13 symbols for accumulated amount of additions</Desc></Res><Res Name="CorrectionsNum" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for number of corrections</Desc></Res><Res Name="CorrectionsAmount" Value=""'+
' Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for accumulated amount of corrections</Desc></Res><ResFormatRaw><![CDATA[<''1''> <;> <CustomersNum[1..5]> <;> <DiscountsNum[1..5]> <;> <DiscountsAmount[1..13]> <;> <AdditionsNum[1..5]> <;> <AdditionsAmoun'+
't[1..13]> <;> <CorrectionsNum[1..5]> <;> <CorrectionsAmount[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadGPRS_APN" CmdByte="0x4E"><FPOperation>Provides information about device''s GRPS APN.</FPOperation><Args><Arg Name="" Value="R" Typ'+
'e="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''A''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Re'+
's Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_APN_Len" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to '+
'3 symbols for the APN length</Desc></Res><Res Name="APN" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS APN</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''A''><;><GPRS_APN_Len[1..3]><;><APN[100]>]]></ResFormatR'+
'aw></Response></Command><Command Name="ReadGPRS_Password" CmdByte="0x4E"><FPOperation>Provides information about device''s GPRS password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHard'+
'coded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''P''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Val'+
'ue="G" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the GPRS password length</Desc></Res><Res Name="Password" Va'+
'lue="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS password</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadGPRS_Sig'+
'nal" CmdByte="0x4E"><FPOperation>Provides information about device''s GPRS signal.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="Option'+
'Hardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Res Name=""'+
' Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_Signal" Value="" Type="Text" MaxLen="3"><Desc>(Signal) 3 symbols for the GPRS signal</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''S''><;><GPRS_Signal[3]]]></ResFormatRaw></Respons'+
'e></Command><Command Name="ReadGPRS_Username" CmdByte="0x4E"><FPOperation>Provides information about device''s GPRS username.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLe'+
'n="1" /><Arg Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''U''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="G" Type='+
'"OptionHardcoded" MaxLen="1" /><Res Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Res Name="GPRS_User_Len" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the GPRS username length</Desc></Res><Res Name="Username" Value="" Ty'+
'pe="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS username</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''G''><;><''U''><;><GPRS_User_Len[1..3]><;><Username[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadHeader" CmdByt'+
'e="0x69"><FPOperation>Provide information about the contents of a header lines.</FPOperation><Args><Arg Name="OptionHeaderLine" Value="" Type="Option" MaxLen="1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Name'+
'="Header 3" Value="3" /><Option Name="Header 4" Value="4" /><Option Name="Header 5" Value="5" /><Option Name="Header 6" Value="6" /><Option Name="Header 7" Value="7" /></Options><Desc>1 symbol with value:  - ''1'' - Header 1  - ''2'' - Header 2  - ''3'' -'+
' Header 3  - ''4'' - Header 4  - ''5'' - Header 5  - ''6'' - Header 6  - ''7'' - Header 7</Desc></Arg><ArgsFormatRaw><![CDATA[<OptionHeaderLine[1]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionHeaderLine" Value="" Type="Option" MaxLen='+
'"1"><Options><Option Name="Header 1" Value="1" /><Option Name="Header 2" Value="2" /><Option Name="Header 3" Value="3" /><Option Name="Header 4" Value="4" /><Option Name="Header 5" Value="5" /><Option Name="Header 6" Value="6" /><Option Name="Header 7" Va'+
'lue="7" /></Options><Desc>(Line Number)1 symbol with value:  - ''1'' - Header 1  - ''2'' - Header 2  - ''3'' - Header 3  - ''4'' - Header 4  - ''5'' - Header 5  - ''6'' - Header 6  - ''7'' - Header 7</Desc></Res><Res Name="HeaderText" Value="" Type="Text"'+
' MaxLen="64"><Desc>TextLength symbols for header lines</Desc></Res><ResFormatRaw><![CDATA[<OptionHeaderLine[1]> <;> <HeaderText[TextLength]>]]></ResFormatRaw></Response></Command><Command Name="ReadIntervalUnsentMsg" CmdByte="0x4F"><FPOperation>Read the i'+
'nterval of the unsent messages</FPOperation><Args><Arg Name="Option1" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<Option1[''T'']> <;><Option2[''R'']> ]]></ArgsFor'+
'matRaw></Args><Response ACK="false"><Res Name="Option1" Value="T" Type="OptionHardcoded" MaxLen="1" /><Res Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for password</Desc></Res><Res Name="TimeHours" Value="" Type="Decimal" MaxLen="5"><D'+
'esc>Up to 5 symbols for hour period</Desc></Res><ResFormatRaw><![CDATA[<Option1[''T'']><;><Password[6]> <;><TimeHours[1..5]>]]></ResFormatRaw></Response></Command><Command Name="ReadLastDailyReportInfo" CmdByte="0x73"><FPOperation>Read the date and number'+
' of the last Z-report and the last RAM reset event.</FPOperation><Response ACK="false"><Res Name="LastZDailyReportDate" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy"><Desc>10 symbols for last Z-report date in DD-MM-YYYY format</Desc></Res><Res '+
'Name="NoLastZDailyReport" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>1..4 symbols for the number of the last daily report in format ####</Desc></Res><Res Name="NoLastRAMReset" Value="" Type="Decimal_with_format" MaxLen="4" Format="'+
'0000"><Desc>1..4 symbols for the number of the lastRAM reset in format ####</Desc></Res><ResFormatRaw><![CDATA[<LastZDailyReportDate "DD-MM-YYYY"><;> <NoLastZDailyReport[4]> <;><NoLastRAMReset[4]>]]></ResFormatRaw></Response></Command><Command Name="ReadL'+
'astReceiptNum" CmdByte="0x71"><FPOperation>Read the daily and progressive counter of last issued receipt.</FPOperation><Response ACK="false"><Res Name="DailyReceiptCounter" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for t'+
'he daily receipt counter in format ####</Desc></Res><Res Name="ProgressiveReceiptCounter" Value="" Type="Decimal_with_format" MaxLen="7" Format="0000000"><Desc>7 symbols for the receipt counter in format #######</Desc></Res><ResFormatRaw><![CDATA[< DailyR'+
'eceiptCounter[4]> <;> <ProgressiveReceiptCounter[7]>]]></ResFormatRaw></Response></Command><Command Name="ReadMandatoryConnectionExtPrinter" CmdByte="0x4F"><FPOperation>Read the parameter indicating whether the connection of an external printer is mandato'+
'ry. (only for FP25 devices)</FPOperation><Args><Arg Name="Option1" Value="p" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option2" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option1[''p'']><;><Option2[''R'']> ]]></ArgsFormat'+
'Raw></Args><Response ACK="false"><Res Name="Option1" Value="p" Type="OptionHardcoded" MaxLen="1" /><Res Name="Option2" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionMandatoryConnecting" Value="" Type="Option" MaxLen="1"><Options><Option N'+
'ame="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<Option1[''p'']> <;><Option2[''R'']> <;><MandatoryConnecting[1]>]]></ResFormatRaw></Response></Command'+
'><Command Name="ReadOdometer" CmdByte="0x58"><FPOperation>Read odometer result. *the command is valid for ADPOS model only.</FPOperation><Args><Arg Name="Option" Value="O" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="R" Type="OptionHardco'+
'ded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <Option[''O'']><;><Option[''R'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="O" Type="OptionHardcoded" MaxLen="1" /><Res Name="OdomResult" Value="" Type="Decimal" MaxLen="19"><Desc>'+
'1..19 symbols for odometer result: used paper length in mm</Desc></Res><ResFormatRaw><![CDATA[<Option[''O'']><;> <OdomResult[1..19]>]]></ResFormatRaw></Response></Command><Command Name="ReadOperatorNameAndPassword" CmdByte="0x6A"><FPOperation>Provide info'+
'rmation about operators name and password.</FPOperation><Args><Arg Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to the number of operator</Desc></Arg><ArgsFormatRaw><![CDATA[ <Number[1..2]> ]]></ArgsFormatRaw><'+
'/Args><Response ACK="false"><Res Name="Number" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to the number of operator</Desc></Res><Res Name="Name" Value="" Type="Text" MaxLen="20"><Desc>20 symbols for operator''s name</Desc>'+
'</Res><Res Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for operator''s password</Desc></Res><ResFormatRaw><![CDATA[<Number[1..2]> <;> <Name[20]> <;> <Password[6]>]]></ResFormatRaw></Response></Command><Command Name="ReadOperPO" CmdByte'+
'="0x6F"><FPOperation>Provides information about the PO by type of payment as well as the total number of operations by specified operator</FPOperation><Args><Arg Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OpNo" Value="" Type="Decimal'+
'" MaxLen="2"><Desc>Symbol from 1 to 20 corresponding to operator''s number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''3''> <;> <OpNo[1..2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="3" Type="OptionHardcoded" MaxLen="1" /><Res Name="'+
'OperNum" Value="" Type="Decimal" MaxLen="2"><Desc>Symbols from 1 to 20 corresponding to operator''s number</Desc></Res><Res Name="AmountPO_Payment0" Value="" Type="Decimal" MaxLen="13"><Desc>Up to 13 symbols for the RA by type of payment 0</Desc></Res><Re'+
's Name="NoPO" Value="" Type="Decimal" MaxLen="5"><Desc>Up to 5 symbols for the total number of operations</Desc></Res><ResFormatRaw><![CDATA[<''3''> <;> <OperNum[1..2]> <;> <AmountPO_Payment0[1..13]> <;> <NoPO[1..5]>]]></ResFormatRaw></Response></Command>'+
'<Command Name="ReadParametersECR" CmdByte="0x65"><FPOperation>Provides information about the programmed number of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt and enable/disableUSB host mode.'+
'</FPOperation><Response ACK="false"><Res Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>(POS Number) 4 symbols for number of POS in format ####</Desc></Res><Res Name="OptionPrintLogo" Value="" Type="Option" MaxLen="1"><Op'+
'tions><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Print Logo) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value'+
'="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Auto Open Drawer) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionAutoCut" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Valu'+
'e="1" /></Options><Desc>(Auto Cut) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionExternalDispManagement" Value="" Type="Option" MaxLen="1"><Options><Option Name="Auto" Value="0" /><Option Name="Manual" Value="1" /></Options>'+
'<Desc>(External Display Management) 1 symbol of value:  - ''1'' - Manual  - ''0'' - Auto</Desc></Res><Res Name="OptionArticleReportType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Brief" Value="0" /><Option Name="Detailed" Value="1" /></Opti'+
'ons><Desc>(Article Report) 1 symbol of value:  - ''1'' - Detailed  - ''0'' - Brief</Desc></Res><Res Name="OptionCurrency" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>1 s'+
'ymbol of value:  - ''1'' - Enabled  - ''0'' - Disabled</Desc></Res><Res Name="OptionEJFontType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Low Font" Value="1" /><Option Name="Normal Font" Value="0" /></Options><Desc>(EJ Font) 1 symbol of val'+
'ue:  - ''1'' - Low Font  - ''0'' - Normal Font</Desc></Res><ResFormatRaw><![CDATA[<POSNum[4]> <;> <PrintLogo[1]> <;> <AutoOpenDrawer[1]> <;> <AutoCut[1]> <;> <ExternalDispManagement[1]> <;> < ArticleReportType[1]><;><Currency[1]><;><EJFontType[1]>]]></Res'+
'FormatRaw></Response></Command><Command Name="ReadParametersFP" CmdByte="0x65"><FPOperation>Provides information about the programmed number of POS and the current values of the logo, cutting permission, display mode, enable/disable currency in receipt an'+
'd enable/disableUSB host mode.</FPOperation><Response ACK="false"><Res Name="POSNum" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>(POS Number) 4 symbols for number of POS in format ####</Desc></Res><Res Name="OptionPrintLogo" Value="'+
'" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Print Logo) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionAutoOpenDrawer" Value="" Type="Option" MaxLen="1"><O'+
'ptions><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Auto Open Drawer) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionAutoCut" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value'+
'="0" /><Option Name="Yes" Value="1" /></Options><Desc>(Auto Cut) 1 symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><Res Name="OptionExternalDispManagement" Value="" Type="Option" MaxLen="1"><Options><Option Name="Auto" Value="0" /><Option Name="'+
'Manual" Value="1" /></Options><Desc>(External Display Management) 1 symbol of value:  - ''1'' - Manual  - ''0'' - Auto</Desc></Res><Res Name="OptionArticleReportType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Brief" Value="0" /><Option Name'+
'="Detailed" Value="1" /></Options><Desc>(Article Report) 1 symbol of value:  - ''1'' - Detailed  - ''0'' - Brief</Desc></Res><Res Name="OptionCurrency" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" V'+
'alue="1" /></Options><Desc>1 symbol of value:  - ''1'' - Enabled  - ''0'' - Disabled</Desc></Res><Res Name="OptionEJFontType" Value="" Type="Option" MaxLen="1"><Options><Option Name="Low Font" Value="1" /><Option Name="Normal Font" Value="0" /></Options><'+
'Desc>(EJ Font) 1 symbol of value:  - ''1'' - Low Font  - ''0'' - Normal Font</Desc></Res><Res Name="OptionExternalDisplayMonitoring" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 '+
'symbol of value:  - ''1'' - Yes  - ''0'' - No</Desc></Res><ResFormatRaw><![CDATA[<POSNum[4]> <;> <PrintLogo[1]> <;> <AutoOpenDrawer[1]> <;> <AutoCut[1]> <;> <ExternalDispManagement[1]> <;> < ArticleReportType[1]><;><Currency[1]><;><EJFontType[1]> <;> <Ext'+
'ernalDisplayMonitoring[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadPayments" CmdByte="0x64"><FPOperation>Read the all programmed Payment types.</FPOperation><Response ACK="false"><Res Name="NamePaym0" Value="" Type="Text" MaxLen="10"><Des'+
'c>10 symbols for payment name of type 0</Desc></Res><Res Name="NamePaym1" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 1</Desc></Res><Res Name="NamePaym2" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of '+
'type 2</Desc></Res><Res Name="NamePaym3" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 3</Desc></Res><Res Name="NamePaym4" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 4</Desc></Res><Res Name="Nam'+
'ePaym5" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 5</Desc></Res><Res Name="NamePaym6" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 6</Desc></Res><ResFormatRaw><![CDATA[<NamePaym0[10]> <;> <Nam'+
'ePaym1[10]> <;> <NamePaym2[10]> <;> <NamePaym3[10]> <;> <NamePaym4[10]> <;> <NamePaym5[10]><;><NamePaym6[10]>]]></ResFormatRaw></Response></Command><Command Name="ReadPayments_V2" CmdByte="0x64"><FPOperation>Read the all programmed Payment types.</FPOpera'+
'tion><Response ACK="false"><Res Name="NamePaym0" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 0</Desc></Res><Res Name="NamePaym1" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 1</Desc></Res><Res N'+
'ame="NamePaym2" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 2</Desc></Res><Res Name="NamePaym3" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 3</Desc></Res><Res Name="NamePaym4" Value="" Type="Te'+
'xt" MaxLen="10"><Desc>10 symbols for payment name of type 4</Desc></Res><Res Name="NamePaym5" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 5</Desc></Res><Res Name="NamePaym6" Value="" Type="Text" MaxLen="10"><Desc>10 symbols '+
'for payment name of type 6</Desc></Res><Res Name="NamePaym7" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 7</Desc></Res><Res Name="NamePaym8" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 8</Desc>'+
'</Res><ResFormatRaw><![CDATA[<NamePaym0[10]> <;> <NamePaym1[10]> <;> <NamePaym2[10]> <;> <NamePaym3[10]> <;> <NamePaym4[10]> <;> <NamePaym5[10]><;><NamePaym6[10]> <;> <NamePaym7[10]><;><NamePaym8[10]>]]></ResFormatRaw></Response></Command><Command Name="R'+
'eadPayments_V2_1" CmdByte="0x64"><FPOperation>Read the all programmed Payment types.</FPOperation><Response ACK="false"><Res Name="NamePaym0" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 0</Desc></Res><Res Name="NamePaym1" Va'+
'lue="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 1</Desc></Res><Res Name="NamePaym2" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 2</Desc></Res><Res Name="NamePaym3" Value="" Type="Text" MaxLen="10"><D'+
'esc>10 symbols for payment name of type 3</Desc></Res><Res Name="NamePaym4" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 4</Desc></Res><Res Name="NamePaym5" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name o'+
'f type 5</Desc></Res><Res Name="NamePaym6" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 6</Desc></Res><Res Name="NamePaym7" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 7</Desc></Res><Res Name="N'+
'amePaym8" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 8</Desc></Res><Res Name="NamePaym9" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 9</Desc></Res><Res Name="NamePaym10" Value="" Type="Text" M'+
'axLen="10"><Desc>10 symbols for payment name of type 10</Desc></Res><Res Name="NamePaym11" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 11</Desc></Res><Res Name="NamePaym12" Value="" Type="Text" MaxLen="10"><Desc>10 symbols f'+
'or payment name of type 12</Desc></Res><Res Name="NamePaym13" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 13</Desc></Res><Res Name="NamePaym14" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for payment name of type 14</D'+
'esc></Res><ResFormatRaw><![CDATA[<NamePaym0[10]> <;> <NamePaym1[10]> <;> <NamePaym2[10]> <;> <NamePaym3[10]> <;> <NamePaym4[10]> <;> <NamePaym5[10]><;><NamePaym6[10]> <;> <NamePaym7[10]><;><NamePaym8[10]> <;><NamePaym9[10]> <;><NamePaym10[10]> <;><NamePay'+
'm11[10]> <;><NamePaym12[10]> <;><NamePaym13[10]> <;><NamePaym14[10]>]]></ResFormatRaw></Response></Command><Command Name="ReadPhoneNumber" CmdByte="0x5A"><FPOperation>Read phone number for SMS warning</FPOperation><Args><Arg Name="OptionS" Value="S" Type='+
'"OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ < OptionS[''S'']><;> < Option[''R'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionS" Value="S" Type="OptionHardco'+
'ded" MaxLen="1" /><Res Name="Option" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="PhoneNo" Value="" Type="Text" MaxLen="20"><Desc>Up to 20 symbols for phone number</Desc></Res><ResFormatRaw><![CDATA[< OptionS[''S'']><;> < Option[''R'']> <;><Ph'+
'oneNo[20]>]]></ResFormatRaw></Response></Command><Command Name="ReadPLU" CmdByte="0x6B"><FPOperation>Provides information about the all registers of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5'+
'" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Arg><Arg Name="Option" Value="&quot;" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]> <;><Option[''"'']> ]]></ArgsFormatRaw></Args><Re'+
'sponse ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="&quot;" Type="OptionHardcoded" MaxLen="1" /><R'+
'es Name="PLUName" Value="" Type="Text" MaxLen="34"><Desc>34 symbols for article name (LF=7Ch)</Desc></Res><Res Name="Price" Value="" Type="Decimal" MaxLen="11"><Desc>1..11 symbols for article price</Desc></Res><Res Name="FlagsPricePLU" Value="" Type="Flag'+
's" MaxLen="1"><Desc>1 symbol for flags = 0x80 + FlagSinglTr + FlagQTY + OptionPrice Where  OptionPrice: 0x00 - for free price is disable /valid only programmed price/ 0x01 - for free price is enable 0x02 - for limited price FlagQTY: 0x00 - for availabilit'+
'y of PLU stock is not monitored 0x04 - for disable negative quantity 0x08 - for enable negative quantity FlagSingleTr: 0x00 - no single transaction 0x10 - single transaction is active</Desc></Res><Res Name="OptionVATClass" Value="" Type="Option" MaxLen="1'+
'"><Options><Option Name="VAT class A" Value="A" /><Option Name="VAT class B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Option Name="VAT class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Na'+
'me="VAT class G" Value="G" /><Option Name="VAT class H" Value="H" /><Option Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article''s VAT Class with optional values:  - ''A'' - VAT class A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'+
''' - VAT class D  - ''E'' - VAT class E  - ''F'' - VAT class F  - ''G'' - VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Res><Res Name="DepNum" Value="" Type="Decimal_plus_80h" MaxLen="2"><Desc>DepNum + 80h, 1 symbol for article departm'+
'ent attachment, formed in the following manner: example: Dep01 = 81h, Dep02 = 82h … Dep19 = 93h</Desc></Res><Res Name="Turnover" Value="" Type="Decimal" MaxLen="13"><Desc>13 symbols for PLU accumulated turnover</Desc></Res><Res Name="SoldQuantity" Value="'+
'" Type="Decimal" MaxLen="13"><Desc>13 symbols for Sales quantity of the article</Desc></Res><Res Name="LastZReportNumber" Value="" Type="Decimal" MaxLen="5"><Desc>5 symbols for the number of the last article report with zeroing</Desc></Res><Res Name="Last'+
'ZReportDate" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>16 symbols for the date and time of the last article report with zeroing  in format DD-MM-YYYY HH:MM</Desc></Res><Res Name="AvailableQuantity" Value="" Type="Decimal" MaxLen'+
'="13"><Desc>(Available Quantity) - 1..11 symbols for quantity in stock</Desc></Res><Res Name="Barcode" Value="" Type="Text" MaxLen="13"><Desc>13 symbols for article barcode</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;> <Option[''"'']><;><PLUName[34]><'+
';><Price[1..11]><;> <FlagsPricePLU[1]><;> <OptionVATClass[1]> <;> <DepNum[1]><;> <Turnover[1..13]><;> < SoldQuantity[1..13]><;> <LastZReportNumber[1..5]><;> <LastZReportDate "DD-MM-YYYY HH:MM"> <;> <AvailableQuantity[1..13]><;> <Barcode[13]>]]></ResFormat'+
'Raw></Response></Command><Command Name="ReadPLUbarcode" CmdByte="0x6B"><FPOperation>Provides information about the barcode of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>'+
'5 symbols for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''3'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name'+
'="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="3" Type="OptionHardcoded" MaxLen="1" /><Res Name="Barcode" Value="" Type="'+
'Text" MaxLen="13"><Desc>13 symbols for article barcode</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;><Option[''3'']><;><Barcode[13]>]]></ResFormatRaw></Response></Command><Command Name="ReadPLUprice" CmdByte="0x6B"><FPOperation>Provides information abo'+
'ut the price and price type of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option'+
'" Value="4" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''4'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for art'+
'icle number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="4" Type="OptionHardcoded" MaxLen="1" /><Res Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1..10 symbols for article price</Desc></Res><Res Name="OptionPrice" Va'+
'lue="" Type="Option" MaxLen="1"><Options><Option Name="Free price is disable /valid only programmed price/" Value="0" /><Option Name="Free price is enable" Value="1" /><Option Name="Limited price" Value="2" /></Options><Desc>1 byte for Price flag with nex'+
't value:  - ''0''- Free price is disable /valid only programmed price/  - ''1''- Free price is enable  - ''2''- Limited price</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;><Option[''4'']><;><Price[1..10]><;><OptionPrice[1]>]]></ResFormatRaw></Response>'+
'</Command><Command Name="ReadPLUqty" CmdByte="0x6B"><FPOperation>Provides information about the quantity registers of the specified article.</FPOperation><Args><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbol'+
's for article number with leading zeroes in format: #####</Desc></Arg><Arg Name="Option" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <PLUNum[5]><;><Option[''2'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="PLUNum'+
'" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for article number with leading zeroes in format #####</Desc></Res><Res Name="Option" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="AvailableQuantity" Value="" Type'+
'="Decimal" MaxLen="13"><Desc>Up to13 symbols for quantity in stock</Desc></Res><Res Name="OptionQuantityType" Value="" Type="Option" MaxLen="1"><Options><Option Name="for availability of PLU stock is not monitored" Value="0" /><Option Name="for disable ne'+
'gative quantity" Value="1" /><Option Name="for enable negative quantity" Value="2" /></Options><Desc>1 byte for Quantity flag with next value:  - ''0''- for availability of PLU stock is not monitored  - ''1''- for disable negative quantity  - ''2''- for e'+
'nable negative quantity</Desc></Res><ResFormatRaw><![CDATA[<PLUNum[5]><;><Option[''2'']><;><AvailableQuantity[1..13]><;> <OptionQuantityType[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadSerialAndFiscalNums" CmdByte="0x60"><FPOperation>Prov'+
'ides information about the manufactoring number of the fiscal device.</FPOperation><Response ACK="false"><Res Name="SerialNum" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for individual number of the fiscal device</Desc></Res><Res Name="FMNum" Value'+
'="" Type="Text" MaxLen="12"><Desc>12 symbol Fiscal Memory number</Desc></Res><ResFormatRaw><![CDATA[<SerialNum[10]><;><FMNum[12]>]]></ResFormatRaw></Response></Command><Command Name="ReadSerialAndFiscalNums_V2" CmdByte="0x60"><FPOperation>Provides informa'+
'tion about the manufactoring number of the fiscal device.</FPOperation><Response ACK="false"><Res Name="SerialNum" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for individual number of the fiscal device</Desc></Res><Res Name="FMNum" Value="" Type="Te'+
'xt" MaxLen="12"><Desc>12 symbol Fiscal Memory number</Desc></Res><Res Name="UniCode" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for unique server registration code</Desc></Res><ResFormatRaw><![CDATA[<SerialNum[10]> <;><FMNum[12]> <;> < UniCod'+
'e[20]>]]></ResFormatRaw></Response></Command><Command Name="ReadServerAddress" CmdByte="0x4E"><FPOperation>Program fiscal server address</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardc'+
'oded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''S''><;><''S''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Valu'+
'e="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for parameter length</Desc></Res><Res Name="Address" Value="" Type="Text"'+
' MaxLen="60"><Desc>60 symbols for address</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''S''><;><''S''><;><ParamLength[1..3]><;><Address[60]>]]></ResFormatRaw></Response></Command><Command Name="ReadServiceContractActivation" CmdByte="0x5A"><FPOperation>'+
'Program expiration date of the service contract</FPOperation><Args><Arg Name="Option" Value="b" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ < Option[''b'']> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="Option" Value="b" Type'+
'="OptionHardcoded" MaxLen="1" /><Res Name="ExpiryDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyyyy"><Desc>8 symbols for date in format DDMMYYYY</Desc></Res><Res Name="OptionTypeActivation" Value="" Type="Option" MaxLen="1"><Options><Option Name='+
'"attention and blocking" Value="1" /><Option Name="attention only" Value="0" /></Options><Desc>1 symbol with value:  - ''0''- attention only  - ''1''- attention and blocking</Desc></Res><ResFormatRaw><![CDATA[< Option[''b'']> <;><ExpiryDate "DDMMYYYY"><;>'+
'<TypeActivation[1]]]></ResFormatRaw></Response></Command><Command Name="ReadServiceContractExpiryDate" CmdByte="0x5A"><FPOperation>Read the service contract expiry date</FPOperation><Args><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><ArgsFor'+
'matRaw><![CDATA[ <''D''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><Res Name="ExpiryDate" Value="" Type="DateTime" MaxLen="10" Format="ddMMyyyy"><Desc>8 symbols for date in the format ''DDMM'+
'YYYY''</Desc></Res><ResFormatRaw><![CDATA[<''D''> <;> <ExpiryDate "DDMMYYYY">]]></ResFormatRaw></Response></Command><Command Name="ReadSpecificMessageNumber" CmdByte="0x4E"><FPOperation>Reads specific message number</FPOperation><Args><Arg Name="" Value="'+
'R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="L" Type="OptionHardcoded" MaxLen="1" /><Arg Name="MessageNum" Value="" Type="Text" MaxLen="2"><Desc>2 symbols for total number of messages</Desc></Arg><ArgsFormatRaw><![CDATA[ <''R''><;><''L''><;>'+
'<MessageNum[2]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="L" Type="OptionHardcoded" MaxLen="1" /><Res Name="MessageNum" Value="" Type="Text" MaxLen="2"><Desc>2 symbols fo'+
'r total number of messages</Desc></Res><Res Name="DateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yyyy HH:mm"><Desc>Date Time parameter</Desc></Res><Res Name="Type" Value="" Type="Text" MaxLen="1"><Desc>1 symbol for type</Desc></Res><Res Name'+
'="Code" Value="" Type="Text" MaxLen="3"><Desc>3 symbols for code</Desc></Res><Res Name="MessageText" Value="" Type="Text" MaxLen="128"><Desc>Up to 128 symbols for message text</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''L''><;><MessageNum[2]><;> <Date'+
'Time "DD-MM-YYYY HH:MM"> <;><Type[1]><;><Code[3]> <;><MessageText[128]>]]></ResFormatRaw></Response></Command><Command Name="ReadStatusECR" CmdByte="0x20"><FPOperation>Provides detailed 5-byte information about the current status of the fiscal printer.</F'+
'POperation><Response ACK="false"><Res Name="FM_Read_only" Value="" Type="Status" Byte="0" Bit="0"><Desc>FM Read only ( ST3.0 or ST3.1 or ST3.2 )</Desc></Res><Res Name="Power_down_in_opened_fiscal_receipt" Value="" Type="Status" Byte="0" Bit="1"><Desc>Powe'+
'r down in opened fiscal receipt</Desc></Res><Res Name="Printer_not_ready_or_overheated" Value="" Type="Status" Byte="0" Bit="2"><Desc>Printer not ready or overheated</Desc></Res><Res Name="Incorrect_time" Value="" Type="Status" Byte="0" Bit="3"><Desc>Inco'+
'rrect time</Desc></Res><Res Name="Incorrect_date" Value="" Type="Status" Byte="0" Bit="4"><Desc>Incorrect date</Desc></Res><Res Name="RAM_reset" Value="" Type="Status" Byte="0" Bit="5"><Desc>RAM reset</Desc></Res><Res Name="Date_and_time_hardware_error" V'+
'alue="" Type="Status" Byte="0" Bit="6"><Desc>Date and time hardware error</Desc></Res><Res Name="Printer_not_ready_or_no_paper" Value="" Type="Status" Byte="1" Bit="0"><Desc>Printer not ready or no paper</Desc></Res><Res Name="Reports_registers_overflow" '+
'Value="" Type="Status" Byte="1" Bit="1"><Desc>Reports registers overflow</Desc></Res><Res Name="Blocking_after_24_hours" Value="" Type="Status" Byte="1" Bit="2"><Desc>Blocking after 24 hours</Desc></Res><Res Name="Non_zero_daily_report" Value="" Type="Sta'+
'tus" Byte="1" Bit="3"><Desc>Non-zero daily report</Desc></Res><Res Name="Non_zero_article_report" Value="" Type="Status" Byte="1" Bit="4"><Desc>Non-zero article report</Desc></Res><Res Name="Non_zero_operator_report" Value="" Type="Status" Byte="1" Bit="5'+
'"><Desc>Non-zero operator report</Desc></Res><Res Name="Non_printed_copy" Value="" Type="Status" Byte="1" Bit="6"><Desc>Non-printed copy</Desc></Res><Res Name="Opened_Non_fiscal_Receipt" Value="" Type="Status" Byte="2" Bit="0"><Desc>Opened Non-fiscal Rece'+
'ipt</Desc></Res><Res Name="Opened_Fiscal_Receipt" Value="" Type="Status" Byte="2" Bit="1"><Desc>Opened Fiscal Receipt</Desc></Res><Res Name="Standard_Cash_Receipt" Value="" Type="Status" Byte="2" Bit="2"><Desc>Standard Cash Receipt</Desc></Res><Res Name="'+
'VAT_included_in_the_receipt" Value="" Type="Status" Byte="2" Bit="3"><Desc>VAT included in the receipt</Desc></Res><Res Name="Invoice" Value="" Type="Status" Byte="2" Bit="4"><Desc>Invoice</Desc></Res><Res Name="EJ_near_full" Value="" Type="Status" Byte="'+
'2" Bit="5"><Desc>EJ near full</Desc></Res><Res Name="EJ_full" Value="" Type="Status" Byte="2" Bit="6"><Desc>EJ full</Desc></Res><Res Name="No_FM_module" Value="" Type="Status" Byte="3" Bit="0"><Desc>No FM module</Desc></Res><Res Name="FM_error" Value="" T'+
'ype="Status" Byte="3" Bit="1"><Desc>FM error</Desc></Res><Res Name="FM_full" Value="" Type="Status" Byte="3" Bit="2"><Desc>FM full</Desc></Res><Res Name="FM_near_full" Value="" Type="Status" Byte="3" Bit="3"><Desc>FM near full</Desc></Res><Res Name="Decim'+
'al_point" Value="" Type="Status" Byte="3" Bit="4"><Desc>Decimal point (1=fract, 0=whole)</Desc></Res><Res Name="FM_fiscalized" Value="" Type="Status" Byte="3" Bit="5"><Desc>FM fiscalized</Desc></Res><Res Name="FM_produced" Value="" Type="Status" Byte="3" '+
'Bit="6"><Desc>FM produced</Desc></Res><Res Name="Printer_automatic_cutting" Value="" Type="Status" Byte="4" Bit="0"><Desc>Printer: automatic cutting</Desc></Res><Res Name="External_Display_Management" Value="" Type="Status" Byte="4" Bit="1"><Desc>External'+
' Display Management</Desc></Res><Res Name="Expired_service_contract" Value="" Type="Status" Byte="4" Bit="2"><Desc>Expired service contract</Desc></Res><Res Name="Brief_or_Detailed_EJ" Value="" Type="Status" Byte="4" Bit="3"><Desc>Brief or Detailed EJ</De'+
'sc></Res><Res Name="Drawer_automatic_opening" Value="" Type="Status" Byte="4" Bit="4"><Desc>Drawer: automatic opening</Desc></Res><Res Name="Customer_logo_included_in_the_receipt" Value="" Type="Status" Byte="4" Bit="5"><Desc>Customer logo included in the'+
' receipt</Desc></Res><Res Name="Unsent_data_for_72h" Value="" Type="Status" Byte="4" Bit="6"><Desc>Unsent data for 72h</Desc></Res><ResFormatRaw><![CDATA[<StatusBytes[5]>]]></ResFormatRaw></Response></Command><Command Name="ReadStatusFP" CmdByte="0x20"><F'+
'POperation>Provides detailed 7-byte information about the current status of the fiscal printer.</FPOperation><Response ACK="false"><Res Name="FM_Read_only" Value="" Type="Status" Byte="0" Bit="0"><Desc>FM Read only ( ST3.0 or ST3.1 or ST3.2 )</Desc></Res>'+
'<Res Name="Power_down_in_opened_fiscal_receipt" Value="" Type="Status" Byte="0" Bit="1"><Desc>Power down in opened fiscal receipt</Desc></Res><Res Name="Printer_not_ready_or_overheated" Value="" Type="Status" Byte="0" Bit="2"><Desc>Printer not ready or ov'+
'erheated</Desc></Res><Res Name="Incorrect_time" Value="" Type="Status" Byte="0" Bit="3"><Desc>Incorrect time</Desc></Res><Res Name="Incorrect_date" Value="" Type="Status" Byte="0" Bit="4"><Desc>Incorrect date</Desc></Res><Res Name="RAM_reset" Value="" Typ'+
'e="Status" Byte="0" Bit="5"><Desc>RAM reset</Desc></Res><Res Name="Date_and_time_hardware_error" Value="" Type="Status" Byte="0" Bit="6"><Desc>Date and time hardware error</Desc></Res><Res Name="Printer_not_ready_or_no_paper" Value="" Type="Status" Byte="'+
'1" Bit="0"><Desc>Printer not ready or no paper</Desc></Res><Res Name="Reports_registers_overflow" Value="" Type="Status" Byte="1" Bit="1"><Desc>Reports registers overflow</Desc></Res><Res Name="Blocking_after_24_hours" Value="" Type="Status" Byte="1" Bit='+
'"2"><Desc>Blocking after 24 hours</Desc></Res><Res Name="Non_zero_daily_report" Value="" Type="Status" Byte="1" Bit="3"><Desc>Non-zero daily report</Desc></Res><Res Name="Non_zero_article_report" Value="" Type="Status" Byte="1" Bit="4"><Desc>Non-zero arti'+
'cle report</Desc></Res><Res Name="Non_zero_operator_report" Value="" Type="Status" Byte="1" Bit="5"><Desc>Non-zero operator report</Desc></Res><Res Name="Non_printed_copy" Value="" Type="Status" Byte="1" Bit="6"><Desc>Non-printed copy</Desc></Res><Res Nam'+
'e="Opened_Non_fiscal_Receipt" Value="" Type="Status" Byte="2" Bit="0"><Desc>Opened Non-fiscal Receipt</Desc></Res><Res Name="Opened_Fiscal_Receipt" Value="" Type="Status" Byte="2" Bit="1"><Desc>Opened Fiscal Receipt</Desc></Res><Res Name="Standard_Cash_Re'+
'ceipt" Value="" Type="Status" Byte="2" Bit="2"><Desc>Standard Cash Receipt</Desc></Res><Res Name="VAT_included_in_the_receipt" Value="" Type="Status" Byte="2" Bit="3"><Desc>VAT included in the receipt</Desc></Res><Res Name="Invoice" Value="" Type="Status"'+
' Byte="2" Bit="4"><Desc>Invoice</Desc></Res><Res Name="EJ_near_full" Value="" Type="Status" Byte="2" Bit="5"><Desc>EJ near full</Desc></Res><Res Name="EJ_full" Value="" Type="Status" Byte="2" Bit="6"><Desc>EJ full</Desc></Res><Res Name="No_FM_module" Valu'+
'e="" Type="Status" Byte="3" Bit="0"><Desc>No FM module</Desc></Res><Res Name="FM_error" Value="" Type="Status" Byte="3" Bit="1"><Desc>FM error</Desc></Res><Res Name="FM_full" Value="" Type="Status" Byte="3" Bit="2"><Desc>FM full</Desc></Res><Res Name="FM_'+
'near_full" Value="" Type="Status" Byte="3" Bit="3"><Desc>FM near full</Desc></Res><Res Name="Decimal_point" Value="" Type="Status" Byte="3" Bit="4"><Desc>Decimal point (1=fract, 0=whole)</Desc></Res><Res Name="FM_fiscalized" Value="" Type="Status" Byte="3'+
'" Bit="5"><Desc>FM fiscalized</Desc></Res><Res Name="FM_produced" Value="" Type="Status" Byte="3" Bit="6"><Desc>FM produced</Desc></Res><Res Name="Printer_automatic_cutting" Value="" Type="Status" Byte="4" Bit="0"><Desc>Printer: automatic cutting</Desc></'+
'Res><Res Name="External_Display_Management" Value="" Type="Status" Byte="4" Bit="1"><Desc>External Display Management</Desc></Res><Res Name="Expired_service_contract" Value="" Type="Status" Byte="4" Bit="2"><Desc>Expired service contract</Desc></Res><Res '+
'Name="Brief_or_Detailed_EJ" Value="" Type="Status" Byte="4" Bit="3"><Desc>Brief or Detailed EJ</Desc></Res><Res Name="Drawer_automatic_opening" Value="" Type="Status" Byte="4" Bit="4"><Desc>Drawer: automatic opening</Desc></Res><Res Name="Customer_logo_in'+
'cluded_in_the_receipt" Value="" Type="Status" Byte="4" Bit="5"><Desc>Customer logo included in the receipt</Desc></Res><Res Name="Unsent_data_for_72h" Value="" Type="Status" Byte="4" Bit="6"><Desc>Unsent data for 72h</Desc></Res><Res Name="Printer_disconn'+
'ected" Value="" Type="Status" Byte="5" Bit="4"><Desc>Printer disconnected</Desc></Res><Res Name="Wrong_SD_card" Value="" Type="Status" Byte="5" Bit="5"><Desc>Wrong SD card</Desc></Res><Res Name="Near_end_of_paper" Value="" Type="Status" Byte="6" Bit="4"><'+
'Desc>Near end of paper</Desc></Res><ResFormatRaw><![CDATA[<StatusBytes[7]>]]></ResFormatRaw></Response></Command><Command Name="ReadSymbolsPerLine" CmdByte="0x4F"><FPOperation>Read the number of symbols per line.</FPOperation><Args><Arg Name="" Value="P" '+
'Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''P''> <;> <''R''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Nam'+
'e="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="Symbols" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>2 symbols indicating a number of symbols per line in format ##</Desc></Res><ResFormatRaw><![CDATA[<''P''> <;> <''R''> <'+
';> <Symbols[2]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_Addresses" CmdByte="0x4E"><FPOperation>Provides information about device''s IP address, subnet mask, gateway address, DNS address.</FPOperation><Args><Arg Name="" Value="R" Type='+
'"OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionAddressType" Value="" Type="Option" MaxLen="1"><Options><Option Name="DNS address" Value="5" /><Option Name="Gateway address" Value="4" /><Option Na'+
'me="IP address" Value="2" /><Option Name="Subnet Mask" Value="3" /></Options><Desc>1 symbol with value:  - ''2'' - IP address  - ''3'' - Subnet Mask  - ''4'' - Gateway address  - ''5'' - DNS address</Desc></Arg><ArgsFormatRaw><![CDATA[ <''R''><;><''T''><;'+
'><AddressType[1]> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionAddressType" Value="" Type="Option" MaxLen="1"><Option'+
's><Option Name="DNS address" Value="5" /><Option Name="Gateway address" Value="4" /><Option Name="IP address" Value="2" /><Option Name="Subnet Mask" Value="3" /></Options><Desc>(Address) 1 symbol with value:  - ''2'' - IP address  - ''3'' - Subnet Mask  -'+
' ''4'' - Gateway address  - ''5'' - DNS address</Desc></Res><Res Name="DeviceAddress" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for the device''s addresses</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''T''><;>< AddressType[1]><;><DeviceAddress[1'+
'5]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_AutoStartStatus" CmdByte="0x4E"><FPOperation>Read device TCP Auto Start status</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="Opti'+
'onHardcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''2''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name='+
'"" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionTCPAutoStart" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><D'+
'esc>1 symbol for TCP auto start status - ''0'' - No  - ''1'' - Yes</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''2''><;><TCPAutoStart[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_Password" CmdByte="0x4E"><FPOperation>Provid'+
'es information about device''s TCP password.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw'+
'><![CDATA[ <''R''><;><''Z''><;><''1''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="1" Type="OptionHardcoded" MaxL'+
'en="1" /><Res Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the password length</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the TCP password</Desc></Res><ResForma'+
'tRaw><![CDATA[<''R''><;><''Z''><;><''1''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadTCP_UsedModule" CmdByte="0x4E"><FPOperation>Read the used TCP module for communication - Lan or WiFi</FPOperation><Ar'+
'gs><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''U''> ]]></ArgsFormatRaw></A'+
'rgs><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionUsedModule" Value="" Type="Option" '+
'MaxLen="1"><Options><Option Name="LAN" Value="1" /><Option Name="WiFi" Value="2" /></Options><Desc>(Module) 1 symbol with value:  - ''1'' - LAN  - ''2'' - WiFi</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''U''><;><UsedModule[1]>]]></ResFormatR'+
'aw></Response></Command><Command Name="ReadTotalMessagesCount" CmdByte="0x4E"><FPOperation>Reads all messages from log</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="L" Type="OptionHardcoded" MaxLen="1" /'+
'><Arg Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''L''><;><''0''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="L" Type="Option'+
'Hardcoded" MaxLen="1" /><Res Name="" Value="0" Type="OptionHardcoded" MaxLen="1" /><Res Name="LineNum" Value="" Type="Text" MaxLen="2"><Desc>2 symbols for line number</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''L''><;><''0''><;><LineNum[2]>]]></ResFor'+
'matRaw></Response></Command><Command Name="ReadUsedCommunicationModule" CmdByte="0x4E"><FPOperation>Reads the communication module used to communicate with the fiscal server</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Ar'+
'g Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="E" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''S''><;><''E''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHard'+
'coded" MaxLen="1" /><Res Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="E" Type="OptionHardcoded" MaxLen="1" /><Res Name="OptionCommunicationModule" Value="" Type="Option" MaxLen="1"><Options><Option Name="GSM" Value="0" /><Opti'+
'on Name="LAN or WiFi" Value="1" /></Options><Desc>(Communication module) 1 symbol with value:  - ''0'' - GSM  - ''1'' - LAN or WiFi</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''S''><;><''E''><;>< CommunicationModule[1]>]]></ResFormatRaw></Response></Co'+
'mmand><Command Name="ReadVATClassAmounts" CmdByte="0x6D"><FPOperation>Provide information about the accumulated amount by VAT group.</FPOperation><Response ACK="false"><Res Name="AmountVATGrA" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for th'+
'e amount accumulated in the VAT group A</Desc></Res><Res Name="AmountVATGrB" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group B</Desc></Res><Res Name="AmountVATGrC" Value="" Type="Decimal" MaxLen="13"><De'+
'sc>1..13 symbols for the amount accumulated in the VAT group C</Desc></Res><Res Name="AmountVATGrD" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group D</Desc></Res><Res Name="AmountVATGrE" Value="" Type="D'+
'ecimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group E</Desc></Res><Res Name="AmountVATGrF" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group F</Desc></Res><Res Name="AmountV'+
'ATGrG" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group G</Desc></Res><Res Name="AmountVATGrH" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group H</Desc><'+
'/Res><Res Name="AmountVATGrI" Value="" Type="Decimal" MaxLen="13"><Desc>1..13 symbols for the amount accumulated in the VAT group I</Desc></Res><ResFormatRaw><![CDATA[<AmountVATGrA[1..13]><;><AmountVATGrB[1..13]><;> <AmountVATGrC[1..13]><;><AmountVATGrD[1'+
'..13]> <;><AmountVATGrE[1..13]> <;><AmountVATGrF[1..13]> <;><AmountVATGrG[1..13]> <;><AmountVATGrH[1..13]> <;> <AmountVATGrI[1..13]>]]></ResFormatRaw></Response></Command><Command Name="ReadVATname" CmdByte="0x69"><FPOperation>Provide information about th'+
'e contents of the VAT Name.</FPOperation><Args><Arg Name="OptionVATline" Value="9" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[<OptionVATline[''9'']> <;> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="OptionVATline" Value="9" T'+
'ype="OptionHardcoded" MaxLen="1" /><Res Name="VATname" Value="" Type="Text" MaxLen="8"><Desc>8 symbols for VAT name</Desc></Res><ResFormatRaw><![CDATA[<OptionVATline[''9'']> <;> <VATname[8]>]]></ResFormatRaw></Response></Command><Command Name="ReadVATNumb'+
'er" CmdByte="0x61"><FPOperation>Provides information about the programmed VAT number.</FPOperation><Response ACK="false"><Res Name="VATNum" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for VAT number</Desc></Res><ResFormatRaw><![CDATA[<VATNum[15]>]]>'+
'</ResFormatRaw></Response></Command><Command Name="ReadVATNumber_V2" CmdByte="0x61"><FPOperation>Provides information about the programmed VAT number.</FPOperation><Response ACK="false"><Res Name="VATNum" Value="" Type="Text" MaxLen="15"><Desc>15 symbols '+
'for VAT number</Desc></Res><Res Name="OptionVATReg" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbols for registration  - ''1'' - Yes  - ''0'' - No</Desc></Res><ResFormatRaw><'+
'![CDATA[<VATNum[15]><;><VATReg[1]>]]></ResFormatRaw></Response></Command><Command Name="ReadVATrates" CmdByte="0x62"><FPOperation>Read the current VAT rates (the last values stored into the FM).</FPOperation><Response ACK="false"><Res Name="VATrateA" Valu'+
'e="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class A in format ##.##%</Desc></Res><Res Name="VATrateB" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT cla'+
'ss B in format ##.##%</Desc></Res><Res Name="VATrateC" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class C in format ##.##%</Desc></Res><Res Name="VATrateD" Value="" Type="Decimal_with_format" MaxLen='+
'"6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class D in format ##.##%</Desc></Res><Res Name="VATrateE" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class E in format ##.##%</Desc></Res><Res '+
'Name="VATrateF" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class F in format ##.##%</Desc></Res><Res Name="VATrateG" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for'+
' VATrates of VAT class G in format ##.##%</Desc></Res><Res Name="VATrateH" Value="" Type="Decimal_with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class H in format ##.##%</Desc></Res><Res Name="VATrateI" Value="" Type="Decimal_'+
'with_format" MaxLen="6" Format="00.00%"><Desc>6 symbols for VATrates of VAT class I in format ##.##%</Desc></Res><ResFormatRaw><![CDATA[<VATrateA[1..6]> <;> <VATrateB[1..6]> <;> <VATrateC[1..6]> <;> <VATrateD[1..6]> <;> <VATrateE[1..6]> <;> <VATrateF[1..6'+
']> <;> <VATrateG[1..6]> <;> <VATrateH[1..6]> <;> <VATrateI[1..6]>]]></ResFormatRaw></Response></Command><Command Name="ReadVersion" CmdByte="0x21"><FPOperation>Provides information about the device model and firmware version.</FPOperation><Response ACK="f'+
'alse"><Res Name="Model" Value="" Type="Text" MaxLen="100"><Desc>Model information</Desc></Res><ResFormatRaw><![CDATA[<Model[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadWiFi_NetworkName" CmdByte="0x4E"><FPOperation>Read device''s connect'+
'ed WiFi network name</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><'+
'''W''><;><''N''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="N" Type="OptionHardcoded" MaxLen="1" /><Res Name="Wi'+
'FiNameLength" Value="" Type="Decimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the WiFi name length</Desc></Res><Res Name="WiFiNetworkName" Value="" Type="Text" MaxLen="100"><Desc>(Name) Up to 100 symbols for the device''s WiFi network name</Desc></R'+
'es><ResFormatRaw><![CDATA[<''R''><;><''W''><;><''N''><;><WiFiNameLength[1..3]><;><WiFiNetworkName[100]>]]></ResFormatRaw></Response></Command><Command Name="ReadWiFi_Password" CmdByte="0x4E"><FPOperation>Read device''s connected WiFi network password</FPO'+
'peration><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><''P''> ]]></ArgsF'+
'ormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Res Name="PassLength" Value="" Type="De'+
'cimal" MaxLen="3"><Desc>(Length) Up to 3 symbols for the WiFi password length</Desc></Res><Res Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s WiFi password</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''W''><;'+
'><''P''><;><PassLength[1..3]><;><Password[100]>]]></ResFormatRaw></Response></Command><Command Name="Read_IdleTimeout" CmdByte="0x4E"><FPOperation>Provides information about device''s idle timeout. This timeout is seconds in which the connection will be c'+
'losed when there is an inactivity. This information is available if the device has LAN or WiFi. Maximal value - 7200, minimal value 1. 0 is for never close the connection.</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg '+
'Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="I" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''Z''><;><''I''> ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="" Value="R" Type="OptionHardco'+
'ded" MaxLen="1" /><Res Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Res Name="" Value="I" Type="OptionHardcoded" MaxLen="1" /><Res Name="IdleTimeout" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for password in fo'+
'rmat ####</Desc></Res><ResFormatRaw><![CDATA[<''R''><;><''Z''><;><''I''><;><IdleTimeout[4]>]]></ResFormatRaw></Response></Command><Command Name="ReceivedOnAccount_PaidOut" CmdByte="0x3B"><FPOperation>Received amount (RA)/ paid out amount (PO) with sign '+
'''-'' in the specified type of payment assigned to the specified operator.</FPOperation><Args><Arg Name="OperNum" Value="" Type="Decimal_with_format" MaxLen="2" Format="00"><Desc>Symbols from 1 to 20in format ## corresponding to the operator''s number</De'+
'sc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for operator''s password</Desc></Arg><Arg Name="OptionPaymentType" Value="0" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Amount" Value="" Type="Decimal" MaxLen="10"><Desc>1 t'+
'o 10 symbols for the amount lodged/withdrawn</Desc></Arg><Arg Name="Text" Value="" Type="Text" MaxLen="64"><Desc>Text - 34 bytes</Desc><Meta MinLen="64" Compulsory="false" ValIndicatingPresence="@" /></Arg><ArgsFormatRaw><![CDATA[<OperNum[1..2]><;><Passwo'+
'rd[6]><;><OptionPaymentType[''0'']><;> <Amount[1..10]> {<''@''><Text[TextLength-2]>} ]]></ArgsFormatRaw></Args></Command><Command Name="ResetOdometer" CmdByte="0x58"><FPOperation>Reset odometer function *the command is valid for ADPOS model only.</FPOpera'+
'tion><Args><Arg Name="Option" Value="O" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Option" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for access password</Desc></Arg><ArgsFormatRa'+
'w><![CDATA[ <Option[''O'']><;><Option[''Z'']><;><Password[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="SafeBoxOpen" CmdByte="0x2A"><FPOperation>Opens the safe box.</FPOperation></Command><Command Name="SaveCompanyData_V2" CmdByte="0x49"><FPOpera'+
'tion>Saves owner''s company name and address in the fiscal memory</FPOperation><Args><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for password</Desc></Arg><ArgsFormatRaw><!'+
'[CDATA[<''S''><;><password[6]> ]]></ArgsFormatRaw></Args></Command><Command Name="SaveNetworkSettings" CmdByte="0x4E"><FPOperation>After every change on Idle timeout, LAN/WiFi/GPRS usage, LAN/WiFi/TCP/GPRS password or TCP auto start networks settings this'+
' Save command needs to be execute.</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''P''><;><''A''> ]]></ArgsFormatRaw></Args></Command><Com'+
'mand Name="ScanAndPrintWiFiNetworks" CmdByte="0x4E"><FPOperation>Scan and print all available WiFi networks</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name='+
'"" Value="S" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><''S''> ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUFromDep" CmdByte="0x34"><FPOperation>Registers the sale or correction in this department with s'+
'pecified name, price, quantity, VAT group and/or discount/addition on the transaction.</FPOperation><Args><Arg Name="NamePLU" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for article''s name included separator for MU=80h or 60h followed up to 3 symbo'+
'ls for unit</Desc></Arg><Arg Name="DepNum" Value="" Type="Decimal_plus_80h" MaxLen="2"><Desc>1 or 2 symbols for article department attachment, formed in the following manner: DepNo[HEX] + 80h example: Dep01 = 81h, Dep02 = 82h ... Dep19 = 93h</Desc></Arg><'+
'Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for article''s price</Desc></Arg><Arg Name="Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>Up to 10symbols for article''s quantity sold</Desc><Meta MinLen="1" Compulsory="fals'+
'e" ValIndicatingPresence="*" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>Up to 7 for percentage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="," /></Arg><'+
'Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>Up to 8 symbols for percentage of discount/addition. Use minus sign ''-'' for discount</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence=":" /></Arg><Arg Name="NamePLUextension" Va'+
'lue="" Type="Text" MaxLen="10"><Desc>10 symbols for extension of the PLU Name: FP Only</Desc><Meta MinLen="10" Compulsory="false" ValIndicatingPresence="#" /></Arg><Arg Name="AdditionalNamePLU" Value="" Type="Text" MaxLen="32"><Desc>32 symbols for additio'+
'nal PLU name: ECR Only</Desc><Meta MinLen="32" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA[ <NamePLU[36]><;><DepNum[1..2]><;><Price[1..10]> {<''*''>< Quantity[1..10]>} {<'',''> <DiscAddP[1..7]>} {<'':''> <DiscAddV[1..8]>} '+
'{<''#''> <NamePLUextension[10]>} {<'';''><AdditionalNamePLU[32]> } ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUFromFD_DB" CmdByte="0x32"><FPOperation>Registers the sale or correction of a specified quantity of an article of the internal data'+
'base of the FD.</FPOperation><Args><Arg Name="OptionSign" Value="" Type="Option" MaxLen="1"><Options><Option Name="Correction" Value="-" /><Option Name="Sale" Value="+" /></Options><Desc>1 symbol with optional value:  - ''+'' -Sale  - ''-'' - Correction</'+
'Desc><Meta MinLen="1" Compulsory="true" NoSemiColumnSeparatorAfterIt="true" /></Arg><Arg Name="PLUNum" Value="" Type="Decimal_with_format" MaxLen="5" Format="00000"><Desc>5 symbols for PLU number of FD database in format #####</Desc></Arg><Arg Name="Quant'+
'ity" Value="" Type="Decimal" MaxLen="10"><Desc>1..10 symbols for article''s quantity sold</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>2 to 7 for percentage of di'+
'scount/addition</Desc><Meta MinLen="2" Compulsory="false" ValIndicatingPresence="," /></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>2 to 8 symbolsfor percentage of discount/addition (with</Desc><Meta MinLen="2" Compulsory="false" Val'+
'IndicatingPresence=":" /></Arg><ArgsFormatRaw><![CDATA[ <OptionSign[1]> <PLUNum[5]> {<''*''><Quantity[1..10]>} {<'',''><DiscAddP[2..7]>}{<'':''><DiscAddV[2..8]>} ]]></ArgsFormatRaw></Args></Command><Command Name="SellPLUwithSpecifiedVAT" CmdByte="0x31"><F'+
'POperation>Register the sale or correction of article with specified name, price, quantity, VAT group and/or discount/addition on the transaction.</FPOperation><Args><Arg Name="NamePLU" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for article''s name'+
'</Desc></Arg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Option Name="VAT class A" Value="A" /><Option Name="VAT class B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Option Name="VA'+
'T class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Name="VAT class G" Value="G" /><Option Name="VAT class H" Value="H" /><Option Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article''s VAT Class with optional values:  - '+
'''A'' - VAT class A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'' - VAT class D  - ''E'' - VAT class E  - ''F'' - VAT class F  - ''G'' - VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Arg><Arg Name="Price" Value="" Type="Decima'+
'l" MaxLen="10"><Desc>1 to 10 symbols for article''s price</Desc></Arg><Arg Name="Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for quantity</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><Arg Name="DiscAd'+
'dP" Value="" Type="Decimal" MaxLen="7"><Desc>2 to 7 symbols for percentage of discount/addition</Desc><Meta MinLen="2" Compulsory="false" ValIndicatingPresence="," /></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="8"><Desc>2 to8 symbols for val'+
'ue of discount/addition</Desc><Meta MinLen="2" Compulsory="false" ValIndicatingPresence=":" /></Arg><Arg Name="NamePLUextension" Value="" Type="Text" MaxLen="10"><Desc>10 symbols for extension of the PLU Name: FP Only</Desc><Meta MinLen="10" Compulsory="f'+
'alse" ValIndicatingPresence="#" /></Arg><Arg Name="AdditionalNamePLU" Value="" Type="Text" MaxLen="32"><Desc>32 symbols for additional PLU name: ECR Only</Desc><Meta MinLen="32" Compulsory="false" ValIndicatingPresence=";" /></Arg><ArgsFormatRaw><![CDATA['+
' <NamePLU[36]><;><OptionVATClass[1]><;><Price[1..10]> {<''*''><Quantity[1..10]>} {<'',''><DiscAddP[2..7]>} {<'':''><DiscAddV[2..8]>} {<''#''><NamePLUextension[10]>} {<'';''> <AdditionalNamePLU[32]> } ]]></ArgsFormatRaw></Args></Command><Command Name="SetA'+
'ctiveLogoNum" CmdByte="0x23"><FPOperation>Sets the number of logo file, which is active and will be printed as logo in the receipt header. Prints Information about active number.</FPOperation><Args><Arg Name="LogoFileNumber" Value="" Type="Text" MaxLen="1'+
'"><Desc>1 character value from ''0'' to ''9'' or ''?''. The number sets the active file, and the ''?'' invokes only printing of information</Desc></Arg><ArgsFormatRaw><![CDATA[ <LogoFileNumber[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetBlue'+
'tooth_Password" CmdByte="0x4E"><FPOperation>Program device''s Bluetooth password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /'+
'><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the BT password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols '+
'for the BT password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''B''><;><''P''><;>< PassLength[1..3]><;><Password[100]>> ]]></ArgsFormatRaw></Args></Command><Command Name="SetBluetooth_Status" CmdByte="0x4E"><FPOperation>Program device''s Bluetooth m'+
'odule to be enabled or disabled. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" Max'+
'Len="1" /><Arg Name="OptionBTstatus" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - Disabled  - ''1'' - Enabled</Desc></Arg><ArgsFormatRaw><'+
'![CDATA[ <''P''><;><''B''><;><''S''><;><BTstatus[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetDateTime" CmdByte="0x48"><FPOperation>Sets the date and time and prints the current values using the RECEIPT printer.</FPOperation><Args><Arg Name="'+
'DateTime" Value="" Type="DateTime" MaxLen="10" Format="dd-MM-yy HH:mm:ss"><Desc>Date Time parameter in format: DD-MM-YY [Space] HH:MM:SS</Desc></Arg><ArgsFormatRaw><![CDATA[ <DateTime "DD-MM-YY HH:MM:SS"> ]]></ArgsFormatRaw></Args></Command><Command Name='+
'"SetDeviceTCP_Addresses" CmdByte="0x4E"><FPOperation>Program device''s network IP address, subnet mask, gateway address, DNS address. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Na'+
'me="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionAddressType" Value="" Type="Option" MaxLen="1"><Options><Option Name="DNS address" Value="5" /><Option Name="Gateway address" Value="4" /><Option Name="IP address" Value="2" /><Option Na'+
'me="Subnet Mask" Value="3" /></Options><Desc>1 symbol with value:  - ''2'' - IP address  - ''3'' - Subnet Mask  - ''4'' - Gateway address  - ''5'' - DNS address</Desc></Arg><Arg Name="DeviceAddress" Value="" Type="Text" MaxLen="15"><Desc>15 symbols for th'+
'e selected address</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''T''><;><AddressType[1]> <;><DeviceAddress[15]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetDHCP_Enabled" CmdByte="0x4E"><FPOperation>Program device''s TCP network DHCP enabled '+
'or disabled. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name='+
'"OptionDHCPEnabled" Value="" Type="Option" MaxLen="1"><Options><Option Name="Disabled" Value="0" /><Option Name="Enabled" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - Disabled  - ''1'' - Enabled</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><'+
';><''T''><;><''1''><;><DHCPEnabled[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS_APN" CmdByte="0x4E"><FPOperation>Program device''s GPRS APN. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardc'+
'oded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="A" Type="OptionHardcoded" MaxLen="1" /><Arg Name="GPRS_APN_Len" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the APN len</Desc></Arg><Arg Nam'+
'e="APN" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS APN</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''G''><;><''A''><;><GPRS_APN_Len[1..3]><;><APN[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS_Pa'+
'ssword" CmdByte="0x4E"><FPOperation>Program device''s GPRS password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name=""'+
' Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the GPRS password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the dev'+
'ice''s GPRS password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''G''><;><''P''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetGPRS_Username" CmdByte="0x4E"><FPOperation>Program device''s GPRS user name.'+
' To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Arg Name="GPRS_Usern'+
'ame_Len" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the username len</Desc></Arg><Arg Name="Username" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s GPRS username</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><'+
';><''G''><;><''U''><;><GPRS_Username_Len[1..3]><;><Username[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetIdle_Timeout" CmdByte="0x4E"><FPOperation>Sets device''s idle timeout setting. Set timeout for closing the connection if there is an in'+
'activity. Maximal value - 7200, minimal value 1. 0 is for never close the connection. This option can be used only if the device has LAN or WiFi. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen='+
'"1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="I" Type="OptionHardcoded" MaxLen="1" /><Arg Name="IdleTimeout" Value="" Type="Decimal_with_format" MaxLen="4" Format="0000"><Desc>4 symbols for Idle timeout in format ###'+
'#</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''I''><;><IdleTimeout[4]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetRecbarcodeFormat" CmdByte="0x51"><FPOperation>Defines the contents of the 18 characters of the barcode, printed in '+
'the end of each clients receipt.</FPOperation><Args><Arg Name="" Value="F" Type="OptionHardcoded" MaxLen="1" /><Arg Name="CodeForm" Value="" Type="Text" MaxLen="18"><Desc>12 characters with possilbe combination of values:  * digits from 0 to 9 - included '+
'directly into the barcode on the corresponding possition  * 2 characters ''dd'' - includes the day from the current date * 2 characters ''mm'' - includes the month from the current date * 2 characters ''yy'' - includes the last 2 digits of the year from t'+
'he current date * 2 characters ''hh'' - includes the last 2 digits of the hour  * 2 characters ''MM'' - includes the last 2 digits of the month * 4 characters ''YYYY'' - includes the last 4 digits of the year  * 4 characters ''NNNN'' - Includes the receip'+
't number  * 4 characters ''PPPP'' - Includes the POS number</Desc></Arg><ArgsFormatRaw><![CDATA[ <''F''> <;> <CodeForm[18]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetSerialNumer" CmdByte="0x40"><FPOperation>Stores the Manufacturing number into'+
' the operative memory.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6-symbol string</Desc></Arg><Arg Name="SerialNum" Value="" Type="Text" MaxLen="12"><Desc>12 symbol Manufacturing number</Desc></Arg><ArgsFormatRaw><![CDAT'+
'A[ <Password[6]><;><SerialNum[12]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetServerAddress" CmdByte="0x4E"><FPOperation>Program fiscal server address</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Va'+
'lue="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="ParamLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols parameter length</Desc></Arg><Arg Name="Address" Value="" Type="Text" M'+
'axLen="60"><Desc>Up to 60 symbols for address</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''S''><;><''S''><;><ParamLength[1..3]><;><Address[60]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetTCPpassword" CmdByte="0x4E"><FPOperation>Program dev'+
'ice''s TCP password. To apply use - SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><'+
'Arg Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the TCP password</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P'+
'''><;><''Z''><;><''1''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetTCP_ActiveModule" CmdByte="0x4E"><FPOperation>Sets the used TCP module for communication - Lan or WiFi. To apply use -SaveNetworkSettings('+
')</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="U" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionUsedModule" Value="" Type="Option" MaxLe'+
'n="1"><Options><Option Name="LAN" Value="1" /><Option Name="WiFi" Value="2" /></Options><Desc>1 symbol with value:  - ''1'' - LAN  - ''2'' - WiFi</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''U''><;><UsedModule[1]><;> ]]></ArgsFormatRaw></Ar'+
'gs></Command><Command Name="SetTCP_AutoStart" CmdByte="0x4E"><FPOperation>Set device''s TCP autostart . To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="Z" Type="OptionHa'+
'rdcoded" MaxLen="1" /><Arg Name="" Value="2" Type="OptionHardcoded" MaxLen="1" /><Arg Name="OptionTCPAutoStart" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol with value:  -'+
' ''0'' - No  - ''1'' - Yes</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''Z''><;><''2''><;><TCPAutoStart[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetUsedCommunicationModule" CmdByte="0x4E"><FPOperation>Sets the communication module used t'+
'o communicate with the fiscal server server</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="S" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="E" Type="OptionHardcoded" MaxLen="1" /><Arg Name="Opti'+
'onCommunicationModule" Value="" Type="Option" MaxLen="1"><Options><Option Name="GSM" Value="0" /><Option Name="LAN or WiFi" Value="1" /></Options><Desc>1 symbol with value:  - ''0'' - GSM  - ''1'' - LAN or WiFi</Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''>'+
'<;><''S''><;><''E''><;>< CommunicationModule[1]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetVATAndFiscNums" CmdByte="0x41"><FPOperation>Stores the VAT and Fiscal Memory number into the operative memory.</FPOperation><Args><Arg Name="Password" V'+
'alue="" Type="Text" MaxLen="6"><Desc>6 symbols for access password</Desc></Arg><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="VATNo" Value="" Type="Text" MaxLen="15"><Desc>15 symbol VAT number</Desc></Arg><Arg Name="FMNo" Value="" T'+
'ype="Text" MaxLen="12"><Desc>12 symbol Fiscal Memory number</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]><;><''1''><;><VATNo[15]><;><FMNo[12]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetVATAndFiscNums_V2" CmdByte="0x41"><FPOperation>Stores'+
' the registration numbers into the operative memory.</FPOperation><Args><Arg Name="Password" Value="" Type="Text" MaxLen="6"><Desc>6 symbols for access password</Desc></Arg><Arg Name="" Value="1" Type="OptionHardcoded" MaxLen="1" /><Arg Name="VATNo" Value'+
'="" Type="Text" MaxLen="15"><Desc>15 symbols VAT number</Desc></Arg><Arg Name="FMNo" Value="" Type="Text" MaxLen="12"><Desc>12 symbols Fiscal Memory number</Desc></Arg><Arg Name="OptionVATReg" Value="" Type="Option" MaxLen="1"><Options><Option Name="No" V'+
'alue="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol for type of owner''s VAT registration: - ''1'' - Yes - ''0'' - No</Desc></Arg><Arg Name="UniCode" Value="" Type="Text" MaxLen="20"><Desc>20 ASCII symbols for unique server registration cod'+
'e</Desc></Arg><ArgsFormatRaw><![CDATA[ <Password[6]><;><''1''><;><VATNo[15]><;><FMNo[12]><;><VATReg[1]><;> <UniCode[20]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetWiFi_NetworkName" CmdByte="0x4E"><FPOperation>Program device''s WiFi network nam'+
'e where it will connect. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="N" Type="OptionHardcoded" MaxLen="1" '+
'/><Arg Name="WiFiNameLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the WiFi network name len</Desc></Arg><Arg Name="WiFiNetworkName" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s WiFi ssid network name<'+
'/Desc></Arg><ArgsFormatRaw><![CDATA[ <''P''><;><''W''><;><''N''><;><WiFiNameLength[1..3]><;><WiFiNetworkName[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="SetWiFi_Password" CmdByte="0x4E"><FPOperation>Program device''s WiFi network password whe'+
're it will connect. To apply use -SaveNetworkSettings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Ar'+
'g Name="PassLength" Value="" Type="Decimal" MaxLen="3"><Desc>Up to 3 symbols for the WiFi password len</Desc></Arg><Arg Name="Password" Value="" Type="Text" MaxLen="100"><Desc>Up to 100 symbols for the device''s WiFi password</Desc></Arg><ArgsFormatRaw><!'+
'[CDATA[ <''P''><;><''W''><;><''P''><;><PassLength[1..3]><;><Password[100]> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_Bluetooth" CmdByte="0x4E"><FPOperation>Start Bluetooth test on the device and print out the result</FPOperation><Args><'+
'Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''B''><;><''T''> ]]></ArgsFormatRaw></Args>'+
'</Command><Command Name="StartTest_GPRS" CmdByte="0x4E"><FPOperation>Start GPRS test on the device and print out the result</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="G" Type="OptionHardcoded" MaxLen='+
'"1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''G''><;><''T''> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_Lan" CmdByte="0x4E"><FPOperation>Start LAN test on the device and print out '+
'the result</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''T''><;><'+
'''T''> ]]></ArgsFormatRaw></Args></Command><Command Name="StartTest_WiFi" CmdByte="0x4E"><FPOperation>Start WiFi test on the device and print out the result</FPOperation><Args><Arg Name="" Value="R" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="'+
'W" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="T" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''R''><;><''W''><;><''T''> ]]></ArgsFormatRaw></Args></Command><Command Name="StornoPLU" CmdByte="0x3C"><FPOperation>Register storn'+
'o of the article with name, price, quantity and VAT Class.</FPOperation><Args><Arg Name="NamePLU" Value="" Type="Text" MaxLen="36"><Desc>36 symbols for article''s name</Desc></Arg><Arg Name="OptionVATClass" Value="" Type="Option" MaxLen="1"><Options><Opti'+
'on Name="VAT class A" Value="A" /><Option Name="VAT class B" Value="B" /><Option Name="VAT class C" Value="C" /><Option Name="VAT class D" Value="D" /><Option Name="VAT class E" Value="E" /><Option Name="VAT class F" Value="F" /><Option Name="VAT class G"'+
' Value="G" /><Option Name="VAT class H" Value="H" /><Option Name="VAT class I" Value="I" /></Options><Desc>1 symbol for article''s VAT Class with optional values:  - ''A'' - VAT class A  - ''B'' - VAT class B  - ''C'' - VAT class C  - ''D'' - VAT class D '+
' - ''E'' - VAT class E  - ''F'' - VAT class F  - ''G'' - VAT class G  - ''H'' - VAT class H  - ''I'' - VAT class I</Desc></Arg><Arg Name="Price" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 digits for price</Desc><Meta MinLen="1" Compulsory="false" V'+
'alIndicatingPresence=";-" /></Arg><Arg Name="Quantity" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 digits for sold quantity</Desc><Meta MinLen="1" Compulsory="false" ValIndicatingPresence="*" /></Arg><ArgsFormatRaw><![CDATA[ <NamePLU[36]> <;> <Optio'+
'nVATClass[1]> {<'';-''><Price[1..10]> <''*''> <Quantity[1..10]> } ]]></ArgsFormatRaw></Args></Command><Command Name="Subtotal" CmdByte="0x33"><FPOperation>Calculate the subtotal amount with printing and display visualization options. Provide information a'+
'bout values of the calculated amounts. If a percent or value discount/addition has been specified the subtotal and the discount/addition value will be printed regardless the parameter for printing.</FPOperation><Args><Arg Name="OptionPrinting" Value="" Ty'+
'pe="Option" MaxLen="1"><Options><Option Name="No" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol withvalue:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="OptionDisplay" Value="" Type="Option" MaxLen="1"><Options><Option Name="No'+
'" Value="0" /><Option Name="Yes" Value="1" /></Options><Desc>1 symbol withvalue:  - ''1'' - Yes  - ''0'' - No</Desc></Arg><Arg Name="DiscAddV" Value="" Type="Decimal" MaxLen="10"><Desc>1 to 10 symbols for the value of the discount/addition</Desc><Meta Min'+
'Len="1" Compulsory="false" ValIndicatingPresence=":" /></Arg><Arg Name="DiscAddP" Value="" Type="Decimal" MaxLen="7"><Desc>2 to 7 symbols for the percentage value of the discount/addition</Desc><Meta MinLen="2" Compulsory="false" ValIndicatingPresence=","'+
' /></Arg><ArgsFormatRaw><![CDATA[ <OptionPrinting[1]><;><OptionDisplay[1]> {<'':''>< DiscAddV[1..10]>} {<'',''><DiscAddP[2..7]>} ]]></ArgsFormatRaw></Args><Response ACK="false"><Res Name="SubtotalValue" Value="" Type="Decimal" MaxLen="10"><Desc>1..10 symb'+
'ols for the value of the subtotal amount</Desc></Res><ResFormatRaw><![CDATA[<SubtotalValue[1..10]>]]></ResFormatRaw></Response></Command><Command Name="UnpairAllDevices" CmdByte="0x4E"><FPOperation>Removes all paired devices. To apply use -SaveNetworkSett'+
'ings()</FPOperation><Args><Arg Name="" Value="P" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="B" Type="OptionHardcoded" MaxLen="1" /><Arg Name="" Value="D" Type="OptionHardcoded" MaxLen="1" /><ArgsFormatRaw><![CDATA[ <''P''><;><''B''><;><''D''>'+
' ]]></ArgsFormatRaw></Args></Command></Defs>';
  mXML := LoadXMLData(sXX);
  SendDefinitions(mXML);
end;


constructor FP.Create();
begin
  inherited;
  self.VersionDefs := 2403121055
end;

initialization
  RegisterClasses([OptionVATClass_ResEnum,OptionDepPrice_ResEnum,OptionHeaderLine_ResEnum,OptionMandatoryConnecting_ResEnum,OptionPrintLogo_ResEnum,OptionAutoOpenDrawer_ResEnum,OptionAutoCut_ResEnum,OptionExternalDispManagement_ResEnum,OptionEJFontType_ResEnum,OptionExternalDisplayMonitoring_ResEnum,OptionPrice_ResEnum,OptionQuantityType_ResEnum,OptionTypeActivation_ResEnum,OptionBTstatus_ResEnum,OptionForbiddenVoid_ResEnum,OptionVATinReceipt_ResEnum,OptionDetailedReceipt_ResEnum,OptionInitiatedPayment_ResEnum,OptionFinalizedPayment_ResEnum,OptionFlagPowerDown_ResEnum,OptionClientReceipt_ResEnum,OptionRcpChangeType_ResEnum,OptionLAN_ResEnum,OptionWiFi_ResEnum,OptionGPRS_ResEnum,OptionBT_ResEnum,OptionDhcpStatus_ResEnum,OptionArticleReportType_ResEnum,OptionCurrency_ResEnum,OptionAddressType_ResEnum,OptionTCPAutoStart_ResEnum,OptionUsedModule_ResEnum,OptionCommunicationModule_ResEnum,OptionVATReg_ResEnum]);
finalization
  UnRegisterClasses([OptionVATClass_ResEnum,OptionDepPrice_ResEnum,OptionHeaderLine_ResEnum,OptionMandatoryConnecting_ResEnum,OptionPrintLogo_ResEnum,OptionAutoOpenDrawer_ResEnum,OptionAutoCut_ResEnum,OptionExternalDispManagement_ResEnum,OptionEJFontType_ResEnum,OptionExternalDisplayMonitoring_ResEnum,OptionPrice_ResEnum,OptionQuantityType_ResEnum,OptionTypeActivation_ResEnum,OptionBTstatus_ResEnum,OptionForbiddenVoid_ResEnum,OptionVATinReceipt_ResEnum,OptionDetailedReceipt_ResEnum,OptionInitiatedPayment_ResEnum,OptionFinalizedPayment_ResEnum,OptionFlagPowerDown_ResEnum,OptionClientReceipt_ResEnum,OptionRcpChangeType_ResEnum,OptionLAN_ResEnum,OptionWiFi_ResEnum,OptionGPRS_ResEnum,OptionBT_ResEnum,OptionDhcpStatus_ResEnum,OptionArticleReportType_ResEnum,OptionCurrency_ResEnum,OptionAddressType_ResEnum,OptionTCPAutoStart_ResEnum,OptionUsedModule_ResEnum,OptionCommunicationModule_ResEnum,OptionVATReg_ResEnum]);
end.