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

    /// <summary>Alegerea "Denumirii pe contabilitate" a produsului direct din document.</summary>
    class function GoodsAcntSelect(const GoodsID: Integer; const ACanModify: Boolean): Boolean;
  end;


implementation
uses frmGoodsInfoCardDialog, frmGoodsPricesDialog, frmGoodsForeignCodeDialog, frmCustomerCurrentDebtsDialog,
     frmCustomerNotifyDebtsDialog, frmCustomerContractsDialog, System.SysUtils,
     frmGoodsACNTBrowser, DataModuleDB, SWNValueStorageUnit, IBC, Data.DB;

{ TSWNCommonDialogs }

// Denumirea pe contabilitate a produsului (TS_GOODS.GOODS_ACNT_ID), aleasa direct din document, fara
// editorul produsului. ACanModify = dreptul de a schimba denumirea; fara el catalogul doar se vizualizeaza.
// Scrierea merge pe o tranzactie proprie, comisa pe loc. True = denumirea s-a schimbat.
class function TSWNCommonDialogs.GoodsAcntSelect(const GoodsID: Integer; const ACanModify: Boolean): Boolean;
const
  cLastGoodsAcntKey = 'DocGoods_GOODS_ACNT_ID';
var
  dialog: TfrmGoodsACNTDlg;
  q: TIBCQuery;
  tr: TIBCTransaction;
  CurrentID, StartID, NewID: Integer;
begin
  Result := False;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT GOODS_ACNT_ID FROM TS_GOODS WHERE GOODSID = :GOODSID';
    q.ParamByName('GOODSID').AsInteger := GoodsID;
    q.Open;
    if q.IsEmpty then
      Exit;
    CurrentID := q.Fields[0].AsInteger;
  finally
    q.Free;
  end;

  dialog := TfrmGoodsACNTDlg.Create(nil);
  try
    if not ACanModify then
    begin
      dialog.BrowseGoodsACNT(CurrentID);
      Exit;
    end;
    // produsul fara denumire (-1): catalogul se deschide pe ultima denumire aleasa
    StartID := CurrentID;
    if StartID <= 0 then
      StartID := AppUserConfigStorage.IntValues.GetValue(cLastGoodsAcntKey, -1);
    if not dialog.SelectGoodsACNT(StartID) or (dialog.GoodsAcntID = CurrentID) then
      Exit;
    NewID := dialog.GoodsAcntID;
  finally
    dialog.Free;
  end;

  tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    tr.DefaultConnection := dmDB.IBCConnection;
    q.Connection := dmDB.IBCConnection;
    q.Transaction := tr;
    q.SQL.Text := 'UPDATE TS_GOODS SET GOODS_ACNT_ID = :GOODS_ACNT_ID WHERE GOODSID = :GOODSID';
    q.ParamByName('GOODS_ACNT_ID').AsInteger := NewID;
    q.ParamByName('GOODSID').AsInteger := GoodsID;
    tr.StartTransaction;
    try
      q.ExecSQL;
      tr.Commit;
    except
      tr.Rollback;
      raise;
    end;
  finally
    q.Free;
    tr.Free;
  end;
  AppUserConfigStorage.IntValues.SetValue(cLastGoodsAcntKey, NewID);
  Result := True;
end;

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
