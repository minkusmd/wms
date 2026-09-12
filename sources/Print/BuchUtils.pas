unit BuchUtils;

interface

uses IniFiles, SysUtils;

function DoubleChar(ch: string): string;
function NumToSampl(N:  string): string;
function MoneyToSampl(M: Currency; Tip: integer = 0): string;


implementation
Uses StrUtils;

const
   Zero = 'zero ';  // numele zero-ului
   One = 'una ';    // unitatea "una"
   Two = 'două ';   // doi "doua"
   fAnd = 'şi ';
   fOne = 'un ';

   Rubl:array[1..3,1..3] of String =   // matricea numelor rublelor
   (
    ('Leu ', 'Lei ', 'Lei '),       // MDL = 496
    ('Dolar ','Dolari ','Dolari '), // USD = 840
    ('Euro ', 'Euro ', 'Euro ')     // EURO = 976
   );

   Cop: array[1..3,1..3]of String =          // matricea numelor copeicilor
   (
    ('bani ','bani ','bani '),    // MDL = 496
    ('cent ','cenți ','cenți '),  // USD = 840
    ('cent ','cenți ','cenți ')   // EURO = 976
   );

   NameNum: array[0..9, 1..4] of String =  //matricea numelor cifrelor
   (
    ('','','',''),
    ('unu ',   'zece ',      'una sută ',   'unsprezece ' ),
    ('doi ',   'douăzeci ',  'două sute ',  'douăsprezece ' ),
    ('trei ',  'treizeci ',  'trei sute ',  'treisprezece ' ),
    ('patru ', 'patruzeci ', 'patru sute ', 'patrusprezece ' ),
    ('cinci ', 'cincizeci ', 'cinci sute ', 'cincisprezece ' ),
    ('şase ',  'şaizeci ',   'şase sute ',  'şaisprezece ' ),
    ('şapte ', 'şaptezeci ', 'şapte sute ', 'şaptesprezece ' ),
    ('opt ',   'optzeci ',   'opt sute ',   'optsprezece ' ),
    ('nouă ',  'nouăzeci ',  'nouă sute ',  'nouăsprezece ' )
   );

   Ext: array[0..4, 1..3] of String =      // matricea extensiilor (mii, milioane ...)
   (
    ('','',''),
    ('mie ', 'mii ', 'mii '),              // Mii
    ('milion ', 'milioane ', 'milioane '), // Milioane
    ('miliard ','miliarde ','miliarde '),  // Miliarde
    ('trilion ','trilioane ','trilioane ') // Trilion
   );

   Univer: array[1..9, 1..4] of Integer =  // matricea terminatiilor
   (
    (1,2,2,2),
    (3,2,2,2),
    (3,2,2,2),
    (3,2,2,2),
    (2,2,2,2),
    (2,2,2,2),
    (2,2,2,2),
    (2,2,2,2),
    (2,2,2,2)
   );


function GetCurrencyIndexByID(const CurrencyID:integer):integer;
begin
     if CurrencyID=498 then Result:=1
     else
     if CurrencyID=840 then Result:=2
     else
     if CurrencyID=976 then Result:=3
     else Result:=1;
end;


function NumToSampl(N:  string): string;
// transforma numarul in litere
var
   k, i, i_indx: integer;
   number, string_num: string;
   index: integer;
   pos: integer;
   fl_ext: boolean;
begin
   fl_ext:=true;
   i:=1;
   string_num:='';
   number:=Trim(N);
   k:=Length(number);
   if (k=1)and(number='0')then string_num:=Zero
   else begin

      pos:=0;
      while (k>0) do begin
         if (k<>1)and(i=1)and(Length(number)<>1)and(copy(number,k-1,1)='1')
         and(copy(number,k,1)<>'0') then begin
            index:=StrToInt(copy(number,k,1));
            dec(k);
            inc(i);
            i_indx:=4;
         end
         else begin
            index:=StrToInt(copy(number,k,1));
            i_indx:=i;
         end;
         if (NameNum[index,i_indx]<>'')and(fl_ext=true)then begin
            string_num:=Ext[pos,Univer[index,i_indx]]+string_num;
            fl_ext:=false;
         end;


         if (index=1)and(pos=1)and(i=1)then
            string_num:=One+string_num
         else if (index=2)and(pos=1)and(i=1)then
               string_num:=Two+string_num
            else
               if (i_indx=2) and (index<>0) and (string_num<>'') then
                 if k>1 then
                   string_num:=NameNum[index,i_indx] + fAnd + string_num
                 else
                   string_num:=NameNum[index,i_indx] + string_num
               else
                  if (i_indx=1) and (i=1) and (string_num='') and (k=1) and (index=1) then
                     string_num:=fOne + string_num
                  else
                     string_num:=NameNum[index,i_indx]+string_num;
         inc(i);
         if i=4 then begin
            i:=1;
            inc(pos);
            fl_ext:=true
         end;
         dec(k);
      end;
   end;

   if Trim(string_num)<>'' then
   begin
       string_num:=WideUpperCase(string_num[1])+Copy(string_num,2,Length(string_num));
       //string_num[1]:=  CHR(ORD(string_num[1])-32);
       Result:=string_num;
   end;
end;

function DoubleChar(ch: string): string;
// {Transforma x in 0x}
begin
     if Length(ch)=1 then Result:='0'+ch
     else Result:=ch;
end;

function MoneyToSampl(M: Currency; Tip: integer): string;
// transforma suma de bani in litere
var
   Int_Part, idx, idxIP, idxRP: integer;
   Int_Str, Real_Part, Sampl: string;
   CurrencyIndex:integer;
begin
     CurrencyIndex:=GetCurrencyIndexByID(Tip);

     Int_Part:=Trunc(Int(M));
     if (Int_Part<0) then
     begin
          Int_Part := Int_Part*-1;
          m := m*-1;
     end;
     Int_Str:=IntToStr(Int_Part);
     Real_Part:=DoubleChar(IntToStr(Trunc(Int((M-Int_Part+0.001)*100))));
     Sampl:=NumToSampl(Int_Str);
     idx:=StrToInt(Int_Str[Length(Int_Str)]);
     if (Length(Int_Str)>1) then idx := 2;
     if idx=0 then idx:=5;
     idxIP:=Univer[idx, 1];
     idx:=StrToInt(Real_Part[Length(Real_Part)]);
     if idx=0 then idx:=5;
     idxRP:=Univer[idx, 1];
     Result:=Sampl+Rubl[CurrencyIndex,idxIP]+Real_Part+' '+Cop[CurrencyIndex,idxRP];
end;

end.
