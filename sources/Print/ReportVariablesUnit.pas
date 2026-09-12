unit ReportVariablesUnit;

interface

Uses Classes, frxClass;

  procedure SetReportVariables(const Report:TfrxReport);

implementation
Uses frxVariables;

const
     cCategoryTitle = 'Internal Variable';
     cMAX_Variables = 25;
     cVARIABLES:array[0..cMAX_Variables-1] of String =
     (
      'FIRMAID',                            // codul firmei curente in care lucreaza utilizatorul
      'FIRMA_NAME',                         // denumirea firmei curente in care lucreaza utilizatorul
      'DT',                                 // codul firmei din document
      'DT_NAME',                            // denumirea firmei din document
      'CT',                                 // codul clientului din document
      'CT_NAME',                            // denumirea clientului din document
      'DOCTYPEID',                          // tipul documentului
      'DOCTYPE_NAME',                       // denumirea tipului de document
      'DOCID',                              // codul documentului
      'USERID',                             // codul utilizatorului
      'USER_NAME',                          // numele utilizatorului
      'NUMAR_BON_FISCAL',                   // numarul bonului de casa (Factura fiscala,)
      'INVOICEID',                          // numarul Facturii Fiscale
      'TARGET_DT',                          // codul firmei selectate
      'USER_GROUPS',                        // lista grupurilor de utilizatori
      'SHOW_ADMIN',                         // afisarea Administratorilor in lista utilizatorilor
      'USER_POSITION',                      // functia detinuta
      'SYS_REPORT_RERUN',                   // indica ca raportul se face inc-odata in aceeas fereastra
      'GOODSID',                            // GoodsID din Spravocinik Tovarov
      'GOODSPARENTID',                      // GoodsParentID din Spravocinik Tovarov
      'INCIDENTID',                         // Cod Incident from sc_incidente
      'PROMOACTIONID',                      // Cod promo actiune
      'CONTRACTID',                         // ContractID
      'WAYBILLID',                          //WaybillID
      'CONTRACT_TYPEID'                     // CONTRACTTYPEID
     );

procedure SetReportVariables(const Report:TfrxReport);
var Category: TfrxVariable;
    i,N:integer;
    S:String;
begin
     // 1. Category
     N:=Report.Variables.IndexOf(' '+cCategoryTitle);
     if N=-1 then
     begin
          // create Category
          Category:=Report.Variables.Add;
          Category.Name:=' '+cCategoryTitle;
     end;
     // 2. Variable
     for i := 0 to cMAX_Variables - 1 do
     begin
          s:=cVARIABLES[i];
          if Report.Variables.IndexOf(S)=-1
           then Report.Variables.AddVariable(cCategoryTitle,S,0);
     end;
end;

end.
