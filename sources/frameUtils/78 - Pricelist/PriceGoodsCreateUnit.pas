unit PriceGoodsCreateUnit;

{
  Crearea unui produs nou in nomenclator (TS_GOODS) dintr-un articol de pricelist, pe baza unui
  produs-model existent. Folosit de:
    - frame78 (bbAddSelectedGoodsToCatalogClick) - rindurile selectate; modelul e GOODSID-ul
      din clipboard;
    - frmAddGoodsfromPrices (bbCreateBasedOnSelectedGoodClick) - articolul din dialog; modelul e
      produsul selectat in lista produselor gasite.

  Valorile lipsa din articol se iau din model:
    mapa (PARENTGOODSID)    - mapa modelului (sau modelul insusi, daca e mapa);
    tipul web (GOODSTYPEID) - tipul modelului;
    producatorul            - al modelului, cu confirmare;
    flag-ul RRP             - bitul 4 din TS_GOODS_FOREIGN.FLAGS al modelului la acelasi furnizor;
                              fara PRICE7 dar cu PRICE3 produsul se creeaza oricum in modul RRP.
}

interface

type
  // articolul din pricelist; valorile <= 0 inseamna "nesetat"
  TPriceItemGoodsData = record
    SupplierID: Integer;
    SupplierGoodsCode: string;
    SupplierGoodsName: string;
    Model: string;             // SUPPLIER_GOODS_MODEL -> codul (CODE) produsului
    VendorID: Integer;         // SYSTEM_VENDORID
    WebGoodsTypeID: Integer;   // GOODSTYPEID
    ParentGoodsID: Integer;    // PARENTGOODSID
    Price3: Double;
    Currency3ID: Integer;
    Price7: Double;
    Currency7ID: Integer;
  end;

  // produsul-model (Loaded = False: fara model)
  TTemplateGoods = record
    Loaded: Boolean;
    GoodsID: Integer;
    Title: string;
    IsFolder: Boolean;
    ParentID: Integer;         // mapa in care se creeaza produsul nou
    WebGoodsTypeID: Integer;
    VendorID: Integer;
    FlgRRP: Integer;
  end;

// citeste produsul-model; False daca GOODSID nu exista
function LoadTemplateGoods(AGoodsID, ASupplierID: Integer; out ATemplate: TTemplateGoods): Boolean;

// creeaza produsul si intoarce GOODSID-ul nou (AParentID = mapa folosita). Exception daca lipseste
// mapa sau producatorul, ori daca utilizatorul refuza producatorul modelului.
function CreateGoodsFromPriceItem(const AItem: TPriceItemGoodsData; const ATemplate: TTemplateGoods;
  out AParentID: Integer): Integer;

implementation

uses
  System.SysUtils, System.UITypes, Data.DB, Vcl.Dialogs, IBC, DataModuleDB, frmGoods;

function LoadTemplateGoods(AGoodsID, ASupplierID: Integer; out ATemplate: TTemplateGoods): Boolean;
var
  q: TIBCQuery;
begin
  ATemplate := Default(TTemplateGoods);
  ATemplate.ParentID := -1;
  ATemplate.WebGoodsTypeID := -1;
  ATemplate.VendorID := -1;
  Result := False;
  if AGoodsID <= 0 then
    Exit;

  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text :=
      'select g.GOODSID, g.PARENTID, g.TITLE, g.FLG_FOLDER, g.WEBGOODSTYPE_ID, g.VENDOR_ID, ' +
      '  (select first 1 get_flg_value(f.FLAGS, 4) from TS_GOODS_FOREIGN f ' +
      '   where f.CUSTOMERID = :SUPPLIERID and f.GOODSID = g.GOODSID) as RRP_FLAG ' +
      'from VW_TS_GOODS g where g.GOODSID = :GOODSID';
    q.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
    q.ParamByName('GOODSID').AsInteger := AGoodsID;
    q.Open;
    if q.IsEmpty then
      Exit;

    ATemplate.Loaded := True;
    ATemplate.GoodsID := AGoodsID;
    ATemplate.Title := q.FieldByName('TITLE').AsString;
    ATemplate.IsFolder := q.FieldByName('FLG_FOLDER').AsInteger = 1;
    if ATemplate.IsFolder then
      // model = mapa: produsul se creeaza in ea, restul valorilor trebuie sa vina din articol
      ATemplate.ParentID := AGoodsID
    else
    begin
      ATemplate.ParentID := q.FieldByName('PARENTID').AsInteger;
      ATemplate.WebGoodsTypeID := q.FieldByName('WEBGOODSTYPE_ID').AsInteger;
      ATemplate.VendorID := q.FieldByName('VENDOR_ID').AsInteger;
      ATemplate.FlgRRP := q.FieldByName('RRP_FLAG').AsInteger;
    end;
    Result := True;
  finally
    q.Free;
  end;
end;

function CreateGoodsFromPriceItem(const AItem: TPriceItemGoodsData; const ATemplate: TTemplateGoods;
  out AParentID: Integer): Integer;
var
  VendorID, WebGoodsTypeID, FlgRRP, AccountingCostFormationTypeID: Integer;
  CodeRO, BaseParamsRO: string;
  Info: TGoodsWebInfoClass;
begin
  AParentID := AItem.ParentGoodsID;
  if (AParentID <= 0) and ATemplate.Loaded then
    AParentID := ATemplate.ParentID;
  if AParentID <= 0 then
    raise Exception.Create('Nu este setata mapa unde doriti sa adaugati produsul!' + sLineBreak +
      'Copiati in clipboard codul unui produs din mapa dorita.');

  WebGoodsTypeID := AItem.WebGoodsTypeID;
  if (WebGoodsTypeID <= 0) and ATemplate.Loaded then
    WebGoodsTypeID := ATemplate.WebGoodsTypeID;

  VendorID := AItem.VendorID;
  if VendorID <= 0 then
  begin
    if not (ATemplate.Loaded and (ATemplate.VendorID > 0)) then
      raise Exception.Create('Eroare! Nu este indicat producatorul pentru "' + AItem.SupplierGoodsName + '"');
    case MessageDlg(Format('Nu este setat producatorul pentru "%s"!' + sLineBreak +
      'Folosim producatorul produsului sursa #%d %s?', [AItem.SupplierGoodsName, ATemplate.GoodsID,
      ATemplate.Title]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        VendorID := ATemplate.VendorID;
      mrNo:
        raise Exception.Create('Nu este indicat producatorul!');
    else
      raise Exception.Create('Oprit');
    end;
  end;

  FlgRRP := 0;
  if ATemplate.Loaded and (ATemplate.FlgRRP > 0) then
    FlgRRP := ATemplate.FlgRRP;
  // fara pret indicativ de la furnizor produsul nou nu are din ce sa-si
  // calculeze pretul de vinzare - il cream direct in modul EPP, pe baza RRP-ului
  if (AItem.Price7 = 0) and (AItem.Price3 > 0) then
    FlgRRP := 1;

  AccountingCostFormationTypeID := 4201;
  CodeRO := '';
  BaseParamsRO := '';
  Info := GetGoodsWebInfo(AParentID);
  try
    if Assigned(Info) then
    begin
      if Info.AccountingCostFormationTypeID <> -1 then
        AccountingCostFormationTypeID := Info.AccountingCostFormationTypeID;
      CodeRO := Info.CodeRO;
      BaseParamsRO := Info.BaseParamsRO;
    end;
  finally
    Info.Free;
  end;
  if AItem.Model <> '' then
    CodeRO := AItem.Model;

  Result := dmDB.CreateNewGoods(AParentID,
    StringReplace(AItem.SupplierGoodsName, #13#10, ' ', [rfReplaceAll]),
    AccountingCostFormationTypeID, WebGoodsTypeID,
    StringReplace(AItem.SupplierGoodsCode, #13#10, ' ', [rfReplaceAll]),
    VendorID, AItem.SupplierID, CodeRO, BaseParamsRO,
    AItem.Price3, AItem.Currency3ID, AItem.Price7, AItem.Currency7ID, FlgRRP);
end;

end.
