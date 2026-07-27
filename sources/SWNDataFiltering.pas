unit SWNDataFiltering;
{
 07.04.2014
 Filtrarea datelor.

 Kind se schimba data sau se alege filtru dupa careva criterii,
 acesti indicatori de filtrare si valorile lor se transmit in SWNFrameManager.
 Din SWNFrameManager datele ajung in CurrentFrame un pot fi modificati runtime, si
 din CurrentFrame se duc in DataModule pentru a fi aplicate asupra surselor de date ale CurrentFrame-ului.
 Extindem indicatorii de filtrare.
 Din Dialogul de filtreare/filtrul caledaristic obtinem setul gata de indicatori
}
interface
Uses SWNDocumentFilters, SWNUtils, IBC, SWNClasses;

type

  // Filter types
  TFrameFilterField = (ffDate,              // dupa Data
                       ffCustomer,          // dupa numele sau codul contragentului
                       ffCustomerType,      // dupa tipul contragentului
                       ffGoods,             // dupa denumirea sau codul produsului
                       ffStock,             // dupa codul depozitului
                       ffGoodsFolders,      // produsele sa fie in grupele indicate
                       ffAcntGoods,         // produsele sa fie in grupele de contabilitate indicate
                       ffGoodsSN,           // dupa numarul de serie al produsului
                       ffGoodsConcurents,   // dupa produs in tdb_docs_goods_concurents
                       ffNone);
  TFrameFilterFields = set of TFrameFilterField;

  // Frame-u poate avea surse de date interne.
  // Daca are surse de date externe (DataModule), atunci indicatorii de mai jos descriu
  // care tipuri de surse de date are nevoie Frame-u.
  // Peste sursele de date cerute se va aplica filtrele din "TFrameDataFilter"
  TFrameExternalDataSource = (
                              fedsDocs,             // TDB_DOCS
                              fedsJurnal,           // TDB_JURNAL
                              fedsIncidente,        // Incidente
                              fedsIncidenteBlob,    // Blob-ul din incidente
                              fedsOportunitati,    // Oportunitati
                              fedsPriceList,       // Pricelist
                              fedsNONE
                             );
  TFrameExternalDataSourceSet = set of TFrameExternalDataSource;



  // indicatorii de filtrare
  TFrameDataFilter = (
                      dfiFIRMA,                 // datele se filtreaza dupa firma curenta
                      dfiDOCTYPE,               // dupa tipul documentului
                      dfiDATE,                  // dupa data
                      dfiCustomerID,            // dupa codul contragentului
                      dfiCustomerText,          // dupa denumirea contragentului
                      dfiCustomerTypeID,        // dupa tipul contragentului
                      dfiGoodsID,               // dupa codul produsului
                      dfiGoodsText,             // dupa denumirea produsului
                      dfiGoodsSN,               // dupa numarul de serie a produsului
                      dfiGoodsFolders,          // dupa lista de mape in care se afla produsul
                      dfiAcntGoods,             // dupa lista de codul de contabilitate
                      dfiStockID,               // dupa codul Depozitului
                      dfiDOC_SECURED_CREATED_BY // dupa utilizatorul current
                     );
  TFrameDataFilterSet = set of TFrameDataFilter;


  TFrameCustomDataFilterGetSQL = procedure(var FilterSQL:String) of object;
  TFrameCustomDataFilterSetParams = procedure(const Query:TIBCQuery) of object;


  TFrameDataFilteringInfo = class
  private
    { private declarations }
    FDateEnd: TDateTime;
    FCustomerText: String;
    FGoodsID: Integer;
    fAcntGoods: TIntegerList;
    FCustomerTypeID: Integer;
    FStockID: Integer;
    FGoodsText: String;
    FGoodsSN: String;
    FDateStart: TDateTime;
    fGoodsFolders: TIntegerList;
    FCustomerID: Integer;
    FDocTypeID: Integer;
    FExcludeEmployers: Boolean;
    FFirmaID: Integer;
    FOnCustomDataFilterSetParams: TFrameCustomDataFilterSetParams;
    FOnCustomDataFilterGetSQL: TFrameCustomDataFilterGetSQL;
    fFrameFilters: TFrameDataFilterSet;
    fFilterByCurrentUser: Boolean;
    procedure SetCustomerID(const Value: Integer);
    procedure SetCustomerText(const Value: String);
    procedure SetCustomerTypeID(const Value: Integer);
    procedure SetDateEnd(const Value: TDateTime);
    procedure SetDateStart(const Value: TDateTime);
    procedure SetDocTypeID(const Value: Integer);
    procedure SetExcludeEmployers(const Value: Boolean);
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsSN(const Value: String);
    procedure SetGoodsText(const Value: String);
    procedure SetStockID(const Value: Integer);
    procedure SetFirmaID(const Value: Integer);
    procedure SetOnCustomDataFilterGetSQL(const Value: TFrameCustomDataFilterGetSQL);
    procedure SetOnCustomDataFilterSetParams(const Value: TFrameCustomDataFilterSetParams);
    procedure SetFilterByCurrentUser(const Value: Boolean);
  protected
    { protected declarations }
    procedure ComputeDateFilters;
    procedure WhenGoodsFoldersChanged(Sender:TObject);
    procedure WhenAcntGoodsChanged(Sender:TObject);
  public
    { public declarations }

    constructor Create;overload;
    constructor Create(const SourceObject:TFrameDataFilteringInfo);overload;
    destructor Destroy;override;

    procedure Clear;overload;
    procedure Clear(const DefaultDateFilter:TFrameDocumentDateFilter);overload;
    procedure CopyFiltersTo(const TargetDataFilter:TFrameDataFilteringInfo);
    function Clone:TFrameDataFilteringInfo;

    procedure AdjustToFrameFilters(const FrameFilterFields:TFrameFilterFields);

    // indicatorii de filtrare a datelor
    property FrameFilters:TFrameDataFilterSet read fFrameFilters;

    property FirmaID:Integer read FFirmaID write SetFirmaID;
    property DocTypeID:Integer read FDocTypeID write SetDocTypeID;
    property DateStart:TDateTime read FDateStart write SetDateStart;
    property DateEnd:TDateTime read FDateEnd write SetDateEnd;
    property CustomerID:Integer read FCustomerID write SetCustomerID;
    property CustomerText:String read FCustomerText write SetCustomerText;
    property CustomerTypeID:Integer read FCustomerTypeID write SetCustomerTypeID;
    property GoodsID:Integer read FGoodsID write SetGoodsID;
    property GoodsText:String read FGoodsText write SetGoodsText;
    property GoodsSN:String read FGoodsSN write SetGoodsSN;
    property GoodsFolders:TIntegerList read fGoodsFolders;
    property AcntGoods:TIntegerList read fAcntGoods;
    property ExcludeEmployers: Boolean read FExcludeEmployers write
        SetExcludeEmployers;
    property StockID:Integer read FStockID write SetStockID;

    // indicatori speciali de filtrare
    // se utilizeaza din frame-uri
    property FilterByCurrentUser: Boolean read fFilterByCurrentUser write SetFilterByCurrentUser; // filtreaza documentele numai dupa UserID.


    // Custom filtering events
    property OnCustomDataFilterGetSQL:TFrameCustomDataFilterGetSQL read FOnCustomDataFilterGetSQL write SetOnCustomDataFilterGetSQL;
    property OnCustomDataFilterSetParams:TFrameCustomDataFilterSetParams read FOnCustomDataFilterSetParams write SetOnCustomDataFilterSetParams;
  end;



implementation
Uses System.SysUtils;

{ TFrameDataFilteringInfo }

procedure TFrameDataFilteringInfo.Clear;
begin
     fFrameFilters:=[];
     FFirmaID:=-1;
     FDocTypeID:=0;
     fDateStart:=0;
     fDateEnd:=0;
     FCustomerID:=-1;
     FCustomerText:='';
     FCustomerTypeID:=-1;
     FGoodsID:=-1;
     FGoodsText:='';
     FGoodsSN:='';
     fGoodsFolders.Clear;
     fAcntGoods.Clear;
     FStockID:=-1;
     fFilterByCurrentUser:=False;
     // aceste evenimente nici odata nu se pastreaza
     FOnCustomDataFilterSetParams:=nil;
     FOnCustomDataFilterGetSQL:=nil;
end;

procedure TFrameDataFilteringInfo.AdjustToFrameFilters(const FrameFilterFields: TFrameFilterFields);
begin
     // daca frame nu are careva filtruri, atunci pentru ele se omite informatia
     if (FrameFilterFields*[ffDate])=[] then
     begin
          fDateStart:=0;
          fDateEnd:=0;
     end;
     if (FrameFilterFields*[ffCustomer])=[] then
     begin
          FCustomerID:=-1;
          FCustomerText:='';
     end;
     if (FrameFilterFields*[ffCustomerType])=[] then FCustomerTypeID:=-1;
     if (FrameFilterFields*[ffGoods])=[] then
     begin
          FGoodsID:=-1;
          FGoodsText:='';
     end;
     if (FrameFilterFields*[ffGoodsSN])=[] then FGoodsSN:='';
     if (FrameFilterFields*[ffStock])=[] then FStockID:=-1;
     if (FrameFilterFields*[ffGoodsFolders])=[] then fGoodsFolders.Clear;
     if (FrameFilterFields*[ffAcntGoods])=[] then fAcntGoods.Clear;
end;

procedure TFrameDataFilteringInfo.Clear(const DefaultDateFilter:TFrameDocumentDateFilter);
var filterObj:TDocumentDateFilterItem;
    lastFirmaID,lastDocTypeID:Integer;
begin
     // la stergere, pastram valorile curente ale FirmaID si DocTypeID
     lastFirmaID:=FFirmaID;
     lastDocTypeID:=FDocTypeID;
     Clear;
     FirmaID:=lastFirmaID;
     DocTypeID:=lastDocTypeID;

     // aplicam filtru pe calendar
     if (DefaultDateFilter<>fdfNone) then
     begin
          filterObj:=SWNDocumentFrameDateFilters.GetFilterObject(DefaultDateFilter);
          GetDocumentFrameFilterDateValues(filterObj.Filter, FDateStart, FDateEnd);
          ComputeDateFilters;
     end;
end;

function TFrameDataFilteringInfo.Clone: TFrameDataFilteringInfo;
begin
     Result:=TFrameDataFilteringInfo.Create;
     CopyFiltersTo(Result);
end;

procedure TFrameDataFilteringInfo.CopyFiltersTo(const TargetDataFilter: TFrameDataFilteringInfo);
begin
     // copiem filtrele in destinatie
     TargetDataFilter.FirmaID:=FFirmaID;
     TargetDataFilter.DateEnd:=FDateEnd;
     TargetDataFilter.CustomerText:=FCustomerText;
     TargetDataFilter.GoodsID:=FGoodsID;
     TargetDataFilter.AcntGoods.CopyValues(fAcntGoods);
     TargetDataFilter.CustomerTypeID:=FCustomerTypeID;
     TargetDataFilter.StockID:=FStockID;
     TargetDataFilter.GoodsText:=FGoodsText;
     TargetDataFilter.GoodsSN:=FGoodsSN;
     TargetDataFilter.DateStart:=FDateStart;
     TargetDataFilter.GoodsFolders.CopyValues(fGoodsFolders);
     TargetDataFilter.CustomerID:=FCustomerID;
     TargetDataFilter.DocTypeID:=FDocTypeID;
     TargetDataFilter.OnCustomDataFilterSetParams:=nil;
     TargetDataFilter.OnCustomDataFilterGetSQL:=nil;
end;

constructor TFrameDataFilteringInfo.Create(const SourceObject: TFrameDataFilteringInfo);
begin
     Create;
     SourceObject.CopyFiltersTo(Self);
end;

constructor TFrameDataFilteringInfo.Create;
begin
     fGoodsFolders:=TIntegerList.Create;
     fAcntGoods:=TIntegerList.Create;
     // change events
     fGoodsFolders.OnChange:=WhenGoodsFoldersChanged;
     fAcntGoods.OnChange:=WhenAcntGoodsChanged;
     Clear;
end;

destructor TFrameDataFilteringInfo.Destroy;
begin
     fGoodsFolders.Free;
     fAcntGoods.Free;
     inherited;
end;

procedure TFrameDataFilteringInfo.ComputeDateFilters;
begin
     if (fDateStart>0) and (fDateEnd>0) then fFrameFilters:=fFrameFilters+[dfiDATE] else fFrameFilters:=fFrameFilters-[dfiDATE];
end;

procedure TFrameDataFilteringInfo.SetCustomerID(const Value: Integer);
begin
     FCustomerID := Value;
     if (FCustomerID<>-1) then fFrameFilters:=fFrameFilters+[dfiCustomerID] else fFrameFilters:=fFrameFilters-[dfiCustomerID];
end;

procedure TFrameDataFilteringInfo.SetCustomerText(const Value: String);
begin
     FCustomerText := Trim(Value);
     if (FCustomerText<>'') then fFrameFilters:=fFrameFilters+[dfiCustomerText] else fFrameFilters:=fFrameFilters-[dfiCustomerText];
end;

procedure TFrameDataFilteringInfo.SetCustomerTypeID(const Value: Integer);
begin
     FCustomerTypeID := Value;
     if (FCustomerTypeID<>-1) then fFrameFilters:=fFrameFilters+[dfiCustomerTypeID] else fFrameFilters:=fFrameFilters-[dfiCustomerTypeID];
end;

procedure TFrameDataFilteringInfo.SetDateEnd(const Value: TDateTime);
begin
     FDateEnd := Value;
     ComputeDateFilters;
end;

procedure TFrameDataFilteringInfo.SetDateStart(const Value: TDateTime);
begin
     FDateStart := Value;
     ComputeDateFilters;
end;

procedure TFrameDataFilteringInfo.SetDocTypeID(const Value: Integer);
begin
     FDocTypeID := Value;
     if (FDocTypeID<>-1) then fFrameFilters:=fFrameFilters+[dfiDOCTYPE] else fFrameFilters:=fFrameFilters-[dfiDOCTYPE];
end;

procedure TFrameDataFilteringInfo.SetExcludeEmployers(const Value: Boolean);
begin
  FExcludeEmployers := Value;
end;

procedure TFrameDataFilteringInfo.SetFirmaID(const Value: Integer);
begin
     FFirmaID := Value;
     if (FFirmaID<>-1) then fFrameFilters:=fFrameFilters+[dfiFIRMA] else fFrameFilters:=fFrameFilters-[dfiFIRMA];
end;

procedure TFrameDataFilteringInfo.SetGoodsID(const Value: Integer);
begin
     FGoodsID := Value;
     if (FGoodsID<>-1) then fFrameFilters:=fFrameFilters+[dfiGoodsID] else fFrameFilters:=fFrameFilters-[dfiGoodsID];
end;

procedure TFrameDataFilteringInfo.SetGoodsSN(const Value: String);
begin
     FGoodsSN := Trim(Value);
     if (FGoodsSN<>'') then fFrameFilters:=fFrameFilters+[dfiGoodsSN] else fFrameFilters:=fFrameFilters-[dfiGoodsSN];
end;

procedure TFrameDataFilteringInfo.SetGoodsText(const Value: String);
begin
     FGoodsText := Trim(Value);
     if (FGoodsText<>'') then fFrameFilters:=fFrameFilters+[dfiGoodsText] else fFrameFilters:=fFrameFilters-[dfiGoodsText];
end;

procedure TFrameDataFilteringInfo.SetOnCustomDataFilterGetSQL(const Value: TFrameCustomDataFilterGetSQL);
begin
     FOnCustomDataFilterGetSQL := Value;
end;

procedure TFrameDataFilteringInfo.SetOnCustomDataFilterSetParams(const Value: TFrameCustomDataFilterSetParams);
begin
     FOnCustomDataFilterSetParams := Value;
end;

procedure TFrameDataFilteringInfo.SetStockID(const Value: Integer);
begin
     FStockID := Value;
     if (FStockID<>-1) then fFrameFilters:=fFrameFilters+[dfiStockID] else fFrameFilters:=fFrameFilters-[dfiStockID];
end;

procedure TFrameDataFilteringInfo.SetFilterByCurrentUser(const Value: Boolean);
begin
     fFilterByCurrentUser := Value;
end;

procedure TFrameDataFilteringInfo.WhenAcntGoodsChanged(Sender: TObject);
begin
     if (fAcntGoods.Count>0) then fFrameFilters:=fFrameFilters+[dfiAcntGoods] else fFrameFilters:=fFrameFilters-[dfiAcntGoods];
end;

procedure TFrameDataFilteringInfo.WhenGoodsFoldersChanged(Sender: TObject);
begin
     if (fGoodsFolders.Count>0) then fFrameFilters:=fFrameFilters+[dfiGoodsFolders] else fFrameFilters:=fFrameFilters-[dfiGoodsFolders];
end;

end.
