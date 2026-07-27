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
      'FIRMAID',                            // код текущий фирмы в которой работает пользователь
      'FIRMA_NAME',                         // название текущий фирмы в которой работает пользователь
      'DT',                                 // код фирмы из документа
      'DT_NAME',                            // название фирмы из документа
      'CT',                                 // код потребителя из документа
      'CT_NAME',                            // название потребителя из документа
      'DOCTYPEID',                          // тип документа
      'DOCTYPE_NAME',                       // название типа документа
      'DOCID',                              // код документа
      'USERID',                             // код пользователя
      'USER_NAME',                          // имя пользователя
      'NUMAR_BON_FISCAL',                   // номер кассового чека (Счет фактура,)
      'INVOICEID',                          // номер Счет Фактуры
      'TARGET_DT',                          // код выбранной фирмы
      'USER_GROUPS',                        // список групп пользователей
      'SHOW_ADMIN',                         // выводить Администраторов в списке пользователей
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
