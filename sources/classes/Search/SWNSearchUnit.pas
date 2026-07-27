unit SWNSearchUnit;

interface
Uses Classes, SearchDialog;

type

  TSearchTable = (stNone,stCustomer,stBank,stStocks,stGoods,stGoodsACNT,stProcuri,stGoodsType,stCertificate,stWebCatalog,stReports);
  TSearchMode = (smExactSearch,smLikeSearch);
  TSearchField = (sfID, sfName, sfDiscount, sfEMail, sfPhone, sfIDNO, sfCredit,
                  sfGoodsCurrentGroup, sfGoodsAvailable, sfGoodsDefect, sfGoodsAdmin,
                  sfArticul, sfGoodsSumRangeStart,sfGoodsSumRangeEnd, sfIDCustom, sfAcntID,
                  sfComposite, sfPersoanaDelegata, sfBarcode, sfAdvancedCustomerSearch,
                  sfWebMode, sfFoldersMode
                 );


  TSearchCriteria = class
  private
    { private declarations }
    FSearchText: String;
    FSearchField: TSearchField;
  public
    { public declarations }
    property SearchField:TSearchField read FSearchField;
    property SearchText:String read FSearchText;
  end;


  TSWNSearchDialog = class
  private
    FAdvancedSearchOptions: Boolean;
    { private declarations }
    function GetSearchCriteria(index: integer): TSearchCriteria;
    function GetSearchCriteriasCount: integer;
    procedure SetAdvancedSearchOptions(const Value: Boolean);
  protected
    { protected declarations }
    fAOwner:TComponent;
    fSearchCriterias:TList;
    fSearchTable:TSearchTable;
    procedure ClearSearchCriterias;
    procedure InitSearchResults;
    procedure InitSearchForm(const SearchTable:TSearchTable; const SearchForm:TfrmSearchDialog);
    procedure WhenGetCriteriaInfo(const CriteriaIndex:integer; var outCriteriaIsNumeric:Boolean; var outCriteriaDescription:String);
    procedure PrepareSearchResults(const CriteriaIndex:integer; TextToSerch:String; const SearchForm:TfrmSearchDialog);
    procedure AddSearchCriteria(const SearchField:TSearchField; const TextToSerch:String);
  public
    { public declarations }
    constructor Create(const AOwner:TComponent);
    destructor Destroy;override;

    property AdvancedSearchOptions:Boolean read FAdvancedSearchOptions write SetAdvancedSearchOptions;

    function GetSearchCritera(const SearchTable:TSearchTable):Boolean;

    property SearchCriteriasCount:integer read GetSearchCriteriasCount;
    property SearchCriterias[index:integer]:TSearchCriteria read GetSearchCriteria;

  end;

  function PrepareTextForLIKE(SearchText:String):String;
  procedure AddConditionToWhere(var WHERE:String; Condition:String; const CondOperator:String='AND');

implementation

uses Controls, SysUtils;

type
    TSearchCriteraItem = record
      Table:TSearchTable;
      SearchField:TSearchField;
      // new
      IsNumeric:Boolean;

      Title:String;
      Description:String;
    end;

const

   cSearchCriteriaTitle:array[TSearchTable] of String =
   (
    '',
    'Cauta client',             // Customer
    'Cauta banca',              // Bank
    'Cauta depozit',            // Stocks
    'Cauta produs',             // Goods
    'Cauta denumirea din 1C',   // Goods ACNT
    'Cauta procura',            // Procuri
    'Cauta tip produs',         // Goods Type
    'Cauta certificat produs',  // Certificate
    'Cauta filtre web',         // Web Catalog
    'Cauta raport'              // Reports
   );


   cSearchCriterias:array[0..32] of TSearchCriteraItem =
   (
    // stCustomer
    (Table:stCustomer; SearchField:sfAdvancedCustomerSearch; IsNumeric: False;   Title:'Cautare complexa';             Description:'Cauta dupa Cod, Denumire, CodFiscal.'),
    (Table:stCustomer; SearchField:sfName;                   IsNumeric: False;   Title:'Denumirea clientului';         Description:'Cauta dupa denumirea clientlui.'),
    (Table:stCustomer; SearchField:sfID;                     IsNumeric: True;    Title:'Cod client';                   Description:'Cauta dupa codul clientului.'),
    (Table:stCustomer; SearchField:sfPhone;                  IsNumeric: False;   Title:'Telefon';                      Description:'Cauta dupa telefonul clientului.'),
    (Table:stCustomer; SearchField:sfEMail;                  IsNumeric: False;   Title:'EMail';                        Description:'Cauta dupa EMail-ul clientului.'),
    (Table:stCustomer; SearchField:sfIDNO;                   IsNumeric: False;   Title:'Cod fiscal';                   Description:'Cauta dupa codul fiscal.'),
    (Table:stCustomer; SearchField:sfDiscount;               IsNumeric: False;   Title:'Cartela de discount';          Description:'Cauta dupa numarul cartelei de discount.'),


    // stBank
    (Table:stBank; SearchField:sfName;                       IsNumeric:False;    Title:'Denumirea bancii';             Description:'Cauta dupa denumirea bancii.'),

    // stStocks
    (Table:stStocks; SearchField:sfName;                     IsNumeric:False;    Title:'Denumire depozit';             Description:'Cauta dupa denumirea depozitului.'),
    (Table:stStocks; SearchField:sfID;                       IsNumeric:True;     Title:'Cod depozit';                  Description:'Cauta dupa codul depozitului.'),

    // stGoods
    (Table:stGoods; SearchField:sfComposite;                 IsNumeric:False;    Title:'Cautare complexa';             Description:'Cauta dupa cod, denumire si articol'),
    (Table:stGoods; SearchField:sfName;                      IsNumeric:False;    Title:'Denumire';                     Description:'Cauta dupa denumirea produsului.'),
    (Table:stGoods; SearchField:sfWebMode;                   IsNumeric:False;    Title:'Cautare web';                  Description:'Cauta dupa cod, denumire si articol, produse sililare, chei'),
    (Table:stGoods; SearchField:sfFoldersMode;               IsNumeric:False;    Title:'Cautare in mape';              Description:'Cauta dupa codul sau denumirea mapei'),
    (Table:stGoods; SearchField:sfID;                        IsNumeric:True;     Title:'Cod';                          Description:'Cauta dupa codul produsului'),
    (Table:stGoods; SearchField:sfAcntID;                    IsNumeric:True;     Title:'Cod din contabilitate';        Description:'Cauta dupa codul din contabilitate'),
    (Table:stGoods; SearchField:sfArticul;                   IsNumeric:False;    Title:'Articul';                      Description:'Cauta dupa articul.'),
    (Table:stGoods; SearchField:sfBarCode;                   IsNumeric:False;    Title:'Codul de bare';                Description:'Cauta dupa codul de bara.'),
    (Table:stGoods; SearchField:sfIDCustom;                  IsNumeric:False;    Title:'Cod produs la furnizor';       Description:'Cauta dupa codul produsului la furnizor'),

    // stGoodsACNT
    (Table:stGoodsACNT; SearchField:sfName;                  IsNumeric:False;    Title:'Denumire';                     Description:'Cauta dupa denumirea prodului din 1C.'),
    (Table:stGoodsACNT; SearchField:sfID;                    IsNumeric:True;     Title:'Cod';                          Description:'Cauta dupa codul produsului din 1C.'),

    // stProcuri
    (Table:stProcuri; SearchField:sfID;                      IsNumeric:False;    Title:'Numar procura';                Description:'Cauta dupa numarul procurii.'),
    (Table:stProcuri; SearchField:sfPersoanaDelegata;        IsNumeric:False;    Title:'Persoana delegata';            Description:'Cauta dupa persoana delegata.'),
    (Table:stProcuri; SearchField:sfName;                    IsNumeric:False;    Title:'Denumirea intreprinderii';     Description:'Cauta dupa denumirea intreprinderii.'#13#10'"S.C.", "SRL" sau alte cuvinte nu trebuie de indicat.'),
    // stGoodsType
    (Table:stGoodsType; SearchField:sfName;                  IsNumeric:False;    Title:'Denumirea produsului';         Description:'Cauta dupa denumirea produsului.'),

    // stCertificate
    (Table:stCertificate; SearchField:sfName;                IsNumeric:False;    Title:'Denumire';                     Description:'Cauta dupa denumirea certificatului.'),
    (Table:stCertificate; SearchField:sfID;                  IsNumeric:False;    Title:'Numar de inregistrare';        Description:'Cauta dupa numarul de inregistrare.'),
    (Table:stCertificate; SearchField:sfArticul;             IsNumeric:False;    Title:'Informatie supliementara';     Description:'Cauta dupa informatia suplimentara.'),

    // stWebCatalog
    (Table:stWebCatalog; SearchField:sfID;                   IsNumeric:True;     Title:'Cod';                          Description:'Cauta dupa codul de filtre web'),
    (Table:stWebCatalog; SearchField:sfName;                 IsNumeric:False;    Title:'Denumire';                     Description:'Cauta dupa denumirea filtrului web'),
    (Table:stWebCatalog; SearchField:sfIDCustom;             IsNumeric:False;    Title:'Valoare filtrelor';            Description:'Cauta dupa valoarea filtrelor web'),

    // stWebCatalog
    (Table:stReports; SearchField:sfName;                    IsNumeric:False;    Title:'Denumire';                     Description:'Cauta dupa denumirea raportului'),
    (Table:stReports; SearchField:sfID;                      IsNumeric:True;     Title:'Cod';                          Description:'Cauta dupa codul raportului')
   );


function PrepareTextForLIKE(SearchText:String):String;
begin
     // remove quotes if exists
     SearchText:=StringReplace(SearchText,'''','',[rfReplaceAll]);
     SearchText:=StringReplace(SearchText,'"','',[rfReplaceAll]);
     SearchText:=StringReplace(SearchText,'  ',' ',[rfReplaceAll]);
     //SearchText:=StringReplace(SearchText,' ','%',[rfReplaceAll]);

     Result:=Format('''%%%s%%''',[TrimRight(SearchText)]);
end;

function PreparePhoneNumberForContaining(const SearchText:String):String;
begin

end;


function AddParanthesis(const Text:String):String;
begin
     Result:=Text;
     if (Text<>'') and (Pos('(',Text)<>1) then Result:='('+Text+')'
end;

procedure AddConditionToWhere(var WHERE:String; Condition:String; const CondOperator:String='AND');
begin
     if (Condition='') then
     begin
          if (WHERE<>'') then WHERE:=AddParanthesis(WHERE)
     end
     else
     if WHERE='' then WHERE := AddParanthesis(Condition)
     else
     begin
          if CondOperator='' then raise Exception.Create('SQL condition in WHERE statement is missing!');
          WHERE := WHERE+' '+Trim(CondOperator)+' ('+Condition+')';
     end;
end;


{ TSWNSearchDialog }

procedure TSWNSearchDialog.AddSearchCriteria(const SearchField: TSearchField; const TextToSerch: String);
var SC:TSearchCriteria;
begin
     SC:=TSearchCriteria.Create;
     SC.FSearchField:=SearchField;
     SC.FSearchText:=TextToSerch;
     fSearchCriterias.Add(SC);
end;

procedure TSWNSearchDialog.ClearSearchCriterias;
var i:integer;
begin
     for i := 0 to fSearchCriterias.Count - 1 do
     TSearchCriteria(fSearchCriterias[i]).Free;
     fSearchCriterias.Clear;
end;

constructor TSWNSearchDialog.Create(const AOwner:TComponent);
begin
     fAOwner:=AOwner;
     FAdvancedSearchOptions := True;
     fSearchCriterias:=TList.Create;
     InitSearchResults;
end;

destructor TSWNSearchDialog.Destroy;
begin
     ClearSearchCriterias;
     fSearchCriterias.Free;
     inherited;
end;

function TSWNSearchDialog.GetSearchCritera(const SearchTable: TSearchTable): Boolean;
var SearchDialog:TfrmSearchDialog;
begin
     fSearchTable:=SearchTable;

     Result:=False;
     InitSearchResults;

     SearchDialog:=TfrmSearchDialog.Create(fAOwner);
     InitSearchForm(SearchTable,SearchDialog);
     with SearchDialog do
     begin
          pnGoodsSearchOptions.Visible := False;
          if SearchTable = stGoods then
            pnGoodsSearchOptions.Visible:=FAdvancedSearchOptions;
          if ShowModal=mrOk then
          begin
               PrepareSearchResults(SelectedItemIndex,SelectedSearchText,SearchDialog);
               Result:=True;
          end;
          Free;
     end;
end;

function TSWNSearchDialog.GetSearchCriteria(index: integer): TSearchCriteria;
begin
     Result:=TSearchCriteria(fSearchCriterias[index]);
end;

function TSWNSearchDialog.GetSearchCriteriasCount: integer;
begin
     Result:=fSearchCriterias.Count;
end;

procedure TSWNSearchDialog.InitSearchForm(const SearchTable: TSearchTable; const SearchForm:TfrmSearchDialog);
var i:integer;
    sc:TSearchCriteraItem;
begin
     SearchForm.SetCaption(cSearchCriteriaTitle[SearchTable]);
     SearchForm.OnGetCriteriaInfo:=WhenGetCriteriaInfo;

     // add criterias
     SearchForm.cmbCriteria.Properties.Items.BeginUpdate;
     try
        SearchForm.cmbCriteria.Properties.Items.Clear;

        for i := Low(cSearchCriterias) to High(cSearchCriterias) do
        begin
             sc:=cSearchCriterias[i];
             if sc.Table=SearchTable then
             begin
                  SearchForm.cmbCriteria.Properties.Items.AddObject(sc.Title,TObject(i));
             end;
        end;
        if (SearchForm.cmbCriteria.Properties.Items.Count>0) then SearchForm.cmbCriteria.ItemIndex:=0;
     finally
        SearchForm.cmbCriteria.Properties.Items.EndUpdate;
     end;


     if SearchTable in [stCustomer,stBank,stStocks,stGoodsACNT,stProcuri,stGoodsType,stCertificate, stWebCatalog,stReports] then
     begin
          // simple search mode
          // hide advanced search conditions
          SearchForm.pnGoodsSearchOptions.Visible := False;

     end
     else
     if SearchTable in [stGoods] then
     begin
          // goods search, advanced mode
//          SearchForm.PageControlOptions.ActivePage:=SearchForm.tbsGoods;
          SearchForm.pnGoodsSearchOptions.Visible := True;
     end;

end;

procedure TSWNSearchDialog.InitSearchResults;
begin
     ClearSearchCriterias;
end;

procedure TSWNSearchDialog.PrepareSearchResults(const CriteriaIndex: integer; TextToSerch:String; const SearchForm:TfrmSearchDialog);
var sc:TSearchCriteraItem;
begin
     // base criteria
     sc:=cSearchCriterias[CriteriaIndex];
     AddSearchCriteria(sc.SearchField,TextToSerch);

     if fSearchTable in [stGoods] then
     begin
          // additional criterias
          if SearchForm.cbSearchOption_CurrentGroup.Checked then AddSearchCriteria(sfGoodsCurrentGroup,'1');
          if SearchForm.cbSearchOption_Available.Checked then AddSearchCriteria(sfGoodsAvailable,'1');
          if SearchForm.cbSearchOption_Defect.Checked then AddSearchCriteria(sfGoodsDefect,'1');
          if SearchForm.cbSearchOption_Admin.Checked then AddSearchCriteria(sfGoodsAdmin,'1');
          if SearchForm.cbSearchOption_SumRange.Checked then
          begin
               AddSearchCriteria(sfGoodsSumRangeStart,FloatToStr(SearchForm.edSum_Start.Value));
               AddSearchCriteria(sfGoodsSumRangeEnd,FloatToStr(SearchForm.edSum_End.Value));
          end;
     end;
end;

procedure TSWNSearchDialog.SetAdvancedSearchOptions(const Value: Boolean);
begin
     FAdvancedSearchOptions := Value;
end;

procedure TSWNSearchDialog.WhenGetCriteriaInfo(const CriteriaIndex:integer; var outCriteriaIsNumeric:Boolean; var outCriteriaDescription:String);
var sc:TSearchCriteraItem;
begin
     sc:=cSearchCriterias[CriteriaIndex];
     outCriteriaIsNumeric:=sc.IsNumeric;
     outCriteriaDescription:=sc.Description;
end;

{ TSearchCriteria }



end.
