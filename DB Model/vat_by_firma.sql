/* ============================================================================
   TVA la nivel de firma emitenta

   GET_VAT_BY_CUSTOMER calculeaza suma TVA pe rand; e apelata din trigger-ele
   TDB_JURNAL (BI/BU), TDB_DOCS (BI/BU0) si din GET_GOODS_FOR_RECEIPT*.
   Pana acum:
       cota = min(TDB_CONTRACTS.VAT al contractului documentului (implicit 20),
                  TS_GOODS.VAT)
   De acum, pentru companiile proprii (TS_CUSTOMER.CUSTOMER_TYPE_ID = 4002),
   conteaza si cota firmei emitente - campul "TVA, %" din fisa clientului
   (TS_CUSTOMER.VAT):
       cota = min(cota firmei, cota contractului, cota produsului)

   O firma neplatitoare de TVA (ex. SOLUTII COMERCIALE SRL, 316910) are
   TS_CUSTOMER.VAT = 0, deci documentele ei ies fara TVA, desi aceleasi produse
   au 20% la PRIME STORE / GAMA COMPUTER (VAT = 20 - pentru ele nu se schimba
   nimic). Furnizorii/clientii obisnuiti (alte tipuri) nu sunt afectati.

   Se aplica randurilor inserate/modificate dupa rulare; documentele existente
   nu se recalculeaza.

   Script RE-RULABIL.
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_VAT_BY_CUSTOMER (
    FIRMAID DM_INTEGER,
    CUSTOMERID DM_INTEGER,
    GOODSID DM_INTEGER,
    SUMA DOUBLE PRECISION,
    CONTRACTID DM_INTEGER)
RETURNS (
    VAT DOUBLE PRECISION)
AS
declare FIRMAVAT DM_SMALLINT;
declare goods_vat dm_integer;
declare firm_own_vat dm_integer;
BEGIN
 /* 1. verificat % TVA pentru produs */
 :suma = coalesce(:suma, 0);
 select vat from ts_goods where goodsid = :goodsid into :goods_vat;

 /* 2. verificam in contract valoarea tva */
 SELECT VAT FROM TDB_CONTRACTS C WHERE C.DT=:FIRMAID and c.contractid=:contractid INTO :FIRMAVAT;
 :firmaVAT = coalesce(:firmaVAT, 20);

 /* 3. 12.09.2026: cota firmei emitente, doar pentru companiile proprii (tip 4002);
       firma neplatitoare de TVA are TS_CUSTOMER.VAT = 0 */
 select iif(c.customer_type_id = 4002, c.vat, 20) from ts_customer c where c.customerid = :firmaid into :firm_own_vat;
 :firm_own_vat = coalesce(:firm_own_vat, 20);

 VAT=ROUND((:SUMA * minvalue(:FIRMAVAT, :goods_vat, :firm_own_vat))/(100 + minvalue(:FIRMAVAT, :goods_vat, :firm_own_vat)),2);
 if (vat is null) then :vat = :suma / 6;
 SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* SOLUTII COMERCIALE SRL - neplatitoare de TVA (idempotent) */
UPDATE TS_CUSTOMER SET VAT = 0 WHERE CUSTOMERID = 316910 AND VAT <> 0;

COMMIT;
