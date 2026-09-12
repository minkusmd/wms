unit ReportFunctions;

interface
uses SysUtils, Classes, fs_iinterpreter, buchutils;

const
 cYearMonthsRom:array[1..12] of String = ('Ianuarie','Februarie','Martie','Aprilie','Mai','Iunie', 'Iulie','August','Septembrie','Octombrie','Noiembrie','Decembrie');
 cYearMonthsRus:array[1..12] of String = ('Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь');

type

  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const
    MethodName: String; var Params: Variant): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;

  function DateToMDLText(Data : TDateTime): String;
  function DateTimeToMDLText(Data : TDateTime): String;
  function CustomerContactsFull(const Adress,Phone1,Phone2,Fax,Email,WWW:String):String;
  function InvoiceDelegatProcura(const Delegat,ProcuraNo:String; StartDate:TDateTime):String;
  function InvoiceDocumenteAnexate(const ListaBonuri,ActLucrari:String; const ActLucrariData:TDateTime; const FoaieDeParcurs:String):String;
  function MonthToRomStr(Month:Integer):String;
  function MonthToRusStr(Month:Integer):String;
  function FirstDayInMonth(ADate: TDateTime): TDate;


implementation



function FormatFiscalReceiptNumbers(const ListaBonuri:String):String;
var i,k:integer;
begin
     Result:=ListaBonuri;
     i := 1;
     k:=pos(IntToStr(i),Result);
     while (K>0) and (i<=10) do
     begin
          Result:=StringReplace(Result,IntToStr(i),Format('%4.4d',[i]),[]);
          inc(i);
          k:=pos(IntToStr(i),Result);
     end;
end;

function FormatFiscalReceiptNumbers2(const ListaBonuri:String):String;
begin
     Result:='';
     if ListaBonuri='' then Exit;

     // lista de bonuri vine in formatul: 0001:18.01.2011,0002:18.01.2011,0004:18.01.2011
     Result:='BON №'+ListaBonuri+')';
     Result:=StringReplace(Result,',','); BON №',[rfReplaceAll]);
     Result:=StringReplace(Result,':','(',[rfReplaceAll]);
     // ca rezultat primimi: BON №0001(18.01.2011); BON №0002(18.01.2011); BON №0004(18.01.2011)
end;


function DateToMDLText(Data : TDateTime): String;
var
  d,m,y : word;
begin
     DecodeDate(Data, y,m,d);
     Result :=Format('%d %s %d',[d,cYearMonthsRom[m],y]);
end;

function DateTimeToMDLText(Data : TDateTime): String;
var d,m,y : word;
    hh,mm,ss,mss:word;
begin
     DecodeDate(Data, y,m,d);
     DecodeTime(Data,hh,mm,ss,mss);
     Result :=Format('%d %s %d, %2.2d:%2.2d',[d,cYearMonthsRom[m],y,hh,mm]);
end;

function CustomerContactsFull(const Adress,Phone1,Phone2,Fax,Email,WWW:String):String;
begin
     Result:='';

     if Adress<>'' then Result:=Result+Adress;

     if (Phone1<>'') or (Phone2<>'') then
     begin
          if Result<>'' then Result:=Result+'; ';
          Result:=Result+'<i>tel:</i> ';
          if Phone1<>'' then Result:=Result+Phone1;
          if Phone2<>'' then Result:=Result+', '+Phone2;
     end;

     if Fax<>'' then
     begin
          if Result<>'' then Result:=Result+'; ';
          Result:=Result+'<i>fax:</i> '+Fax;
     end;

     if Email<>'' then
     begin
          if Result<>'' then Result:=Result+'; ';
          Result:=Result+'<i>email:</i> '+Email;
     end;

     if WWW<>'' then
     begin
          if Result<>'' then Result:=Result+'; ';
          Result:=Result+'<i>web page:</i> '+WWW;
     end;

end;

function InvoiceDelegatProcura(const Delegat,ProcuraNo:String; StartDate:TDateTime):String;
begin
     Result:='<b>'+Delegat+'</b>';
     if ProcuraNo<>'' then
     begin
          Result:=Result+', procura №<b>'+ProcuraNo+'</b>, din <b>'+DateToMDLText(StartDate)+'</b>';
     end;
end;

function InvoiceDocumenteAnexate(const ListaBonuri,ActLucrari:String; const ActLucrariData:TDateTime; const FoaieDeParcurs:String):String;
begin
     Result:='';
     if ListaBonuri<>'' then Result:=FormatFiscalReceiptNumbers2(ListaBonuri);
     if ActLucrari<>'' then
     begin
          if Result<>'' then Result:=Result+sLineBreak;
          Result:=Result+'ACT №'+ActLucrari+'('+FormatDateTime('dd.mm.yyyy',ActLucrariData)+')';
     end;
     if FoaieDeParcurs<>'' then
     begin
          if Result<>'' then Result:=Result+sLineBreak;
          Result:=Result+'Foaie de parcurs: '+FoaieDeParcurs;
     end;
     if (Result='') then Result:='- - - - -';



//     Result:='';
//     if ListaBonuri<>'' then Result:='BON №.'+FormatFiscalReceiptNumbers(ListaBonuri);
//     if ActLucrari<>'' then
//     begin
//          if Result<>'' then Result:=Result+sLineBreak;
//          Result:=Result+'ACT №.'+ActLucrari+' DIN '+FormatDateTime('dd.mm.yyyy',ActLucrariData);
//     end;
//     if FoaieDeParcurs<>'' then
//     begin
//          if Result<>'' then Result:=Result+sLineBreak;
//          Result:=Result+'Foaie de parcurs: '+FoaieDeParcurs;
//     end;
end;

function MonthToRomStr(Month:Integer):String;
begin
     Result:='?';
     if (Month>=1) and (Month<=12) then Result:=cYearMonthsRom[Month];
end;

 function MonthToRusStr(Month:Integer):String;
begin
     Result:='?';
     if (Month>=1) and (Month<=12) then Result:=cYearMonthsRus[Month];
end;

function FirstDayInMonth(ADate: TDateTime): TDate;
var
 d, m, y: word;
begin
   try
   DecodeDate(ADate, y, m, d);
   result := EncodeDate(y, m, 1);
   except
     Result := EncodeDate(2016, 1, 1);
   end;
end;


{ TFunctions }

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
begin
     if SameText(MethodName,'DateToTextRom') then Result := DateToMDLText(Params[0])
     else
     if SameText(MethodName,'DateTimeToTextRom') then Result := DateTimeToMDLText(Params[0])
     else
     if SameText(MethodName,'SumaToTextRom') then Result:=MoneyToSampl(Params[0],Params[1])
     else
     if SameText(MethodName,'CustomerContactsFull') then Result:=CustomerContactsFull(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5])
     else
     if SameText(MethodName,'CustomerAddressPhones') then Result:=CustomerContactsFull(Params[0],Params[1],Params[2],Params[3],'','')
     else
     if SameText(MethodName,'InvoiceDelegatProcura') then Result:=InvoiceDelegatProcura(Params[0],Params[1],Params[2])
     else
     if SameText(MethodName,'InvoiceDocumenteAnexate') then Result:=InvoiceDocumenteAnexate(Params[0],Params[1], Params[2], Params[3])
     else
     if SameText(MethodName,'MonthToRomStr') then Result:=MonthToRomStr(Params[0])
     else
     if SameText(MethodName,'MonthToRusStr') then Result:=MonthToRusStr(Params[0])
     else
     if SameText(MethodName,'FirstDayInMonth') then Result:=FirstDayInMonth(Params[0])

end;

constructor TFunctions.Create(AScript: TfsScript);
begin
     inherited Create(AScript);
     with AScript do
     begin
          AddMethod('function DateToTextRom(Data:TDateTime): String',CallMethod, 'Functiile mele', 'Returneaza data scrisa in litere in limba romana');
          AddMethod('function DateTimeToTextRom(Data:TDateTime): String',CallMethod, 'Functiile mele', 'Returneaza data si ora scrise in litere in limba romana');
          AddMethod('function MonthToRomStr(Month:Integer): String',CallMethod, 'Functiile mele', 'Returneaza denumirea lunii in limba romana');
          AddMethod('procedure SumaToTextRom(Sum: Currency; Currency: Integer): String', CallMethod, 'Functiile mele', 'Returneaza suma scrisa in litere in limba romana. Currency poate avea urmatoarele valori: 486-MDL, 840-USD, 976-EURO');
          AddMethod('function CustomerContactsFull(Address,Phone1,Phon2,Fax,Email,WWW:String): String',CallMethod, 'Functiile mele', 'Returneaza adresa, telefonul, faxul, emailul si adresa de internet intr-un singur rand. Formatare HTML!');
          AddMethod('function CustomerAddressPhones(Address,Phone1,Phon2,Fax:String): String',CallMethod, 'Functiile mele', 'Returneaza adresa, telefonul si faxul intr-un singur rand. Formatare HTML!');
          AddMethod('function InvoiceDelegatProcura(Delegat,ProcuraNo:String; StartDate:TDateTime): String',CallMethod, 'Functiile mele', 'Returneaza Delegatul, Numarul si Data eliberarii procurii intr-un singur rand. Formatare HTML!');
          AddMethod('function InvoiceDocumenteAnexate(ListaBonuri,ActLucrari:String; ActLucrariData:TDateTime; FoaieDeParcurs:String): String',CallMethod, 'Functiile mele', 'Returneaza max 3 randuri: lista bonurilor fiscale, actul lucrarilor efectuate si numarul foii de parcurs!');
          AddMethod('function FirstDayInMonth(ADate:TDateTime): TDate',CallMethod, 'Functiile mele', 'Returneaza prima zi a lunii!');
     end;
end;



initialization

  fsRTTIModules.Add(TFunctions);


end.
