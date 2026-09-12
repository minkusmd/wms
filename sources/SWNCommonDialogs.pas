unit SWNCommonDialogs;

interface


type

  TSWNCommonDialogs = class
  public
    { public declarations }
    /// <summary>Show dialog "Fisa produsului".</summary>
    class procedure GoodsInfoCardDialog(const GoodsID: Integer; const GoodsTitle:String);

    /// <summary>Show dialog "Modificare preturi marfa".</summary>
    class procedure ModifyGoodsPriceDlg(const GoodsID: Integer; const GoodsTitle:String);

    /// <summary>Show dialog "Corespondenta produsului in alte firme"</summary>
    class procedure GoodsForeignCode(const GoodsID: Integer; qty: double = 0);

    /// <summary>Show dialog "Datorii curente contraagent"</summary>
    class procedure CustomerDebts(const CustomerID: Integer);

    /// <summary>Show dialog "Reamintire despre datoriile contraagentului"</summary>
    class procedure CustomerNotifyDebts(const CustomerID: Integer);

    /// <summary>Show dialog "Contracte"</summary>
    class function ContractsDialog(ANewContractID: Integer; ACurrencyID: integer; AFLG_ACNT: integer;
                                   const ACT: Integer; const AContractID: Integer): string;
  end;


implementation
uses frmGoodsInfoCardDialog, frmGoodsPricesDialog, frmGoodsForeignCodeDialog, frmCustomerCurrentDebtsDialog,
     frmCustomerNotifyDebtsDialog, frmCustomerContractsDialog, System.SysUtils;

{ TSWNCommonDialogs }

class procedure TSWNCommonDialogs.CustomerDebts(const CustomerID: Integer);
var dialog: TfrmCustomerCurrentDebtsDlg;
begin
     dialog := TfrmCustomerCurrentDebtsDlg.Create(nil);
     try
        dialog.CustomerID := CustomerID;
        dialog.ShowModal;
     finally
       dialog.Free;
     end;
end;

class procedure TSWNCommonDialogs.CustomerNotifyDebts(const CustomerID: Integer);
var dialog: TfrmCustomerNotifyDebtsDlg;
begin
     dialog := TfrmCustomerNotifyDebtsDlg.Create(nil);
     try
        dialog.CustomerID := CustomerID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

class procedure TSWNCommonDialogs.GoodsForeignCode(const GoodsID: Integer; qty: double = 0);
var dialog:TfrmGoodsForeignCodeDlg;
begin
     dialog:=TfrmGoodsForeignCodeDlg.Create(nil);
     try
        dialog.GoodsID:=GoodsID;
        dialog.Qty := Qty;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

class procedure TSWNCommonDialogs.GoodsInfoCardDialog(const GoodsID: Integer; const GoodsTitle: String);
begin
     with TfrmGoodsInfoCardDlg.Create(nil) do
     try
        SetGoodsInfo(GoodsID, GoodsTitle);
        ShowModal;
     finally
        Free;
     end;
end;

class procedure TSWNCommonDialogs.ModifyGoodsPriceDlg(const GoodsID: Integer; const GoodsTitle: String);
begin
     with TfrmGoodsPricesDlg.Create(nil) do
     try
        SetGoodsInfo(GoodsID,GoodsTitle);
        ShowModal;
     finally
        Free;
     end;
end;

class function TSWNCommonDialogs.ContractsDialog(ANewContractID: Integer; ACurrencyID: integer; AFLG_ACNT: Integer; const ACT: Integer; const AContractID: Integer): string;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  Result := '';
  contractInfo := SelectCustomerContract(ACT, AContractID);
  if Assigned(contractInfo) then
  begin
    Result := Format('%s (#%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
//    ANewContractID := contractInfo.ContractID;
//    ACurrencyID := contractInfo.CurrencyID;
//    if contractInfo.FLG_ACNT then
//      AFLG_ACNT := 1;
  end;
end;



end.
