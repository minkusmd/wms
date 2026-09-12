unit SWNDocumentFilters;

interface
Uses System.Generics.Collections;

type

  // 01.07.2013
  // Deoarece avem mai multe tipuri de surse de documente (DOCS, Service-u), introducem sursa documentului
{
  TFrameDocumentSource = (fdsNone, fdsDOCS,
                          fdsSERVICE_IncidenteNoi, // frame 36
                          fdsSERVICE_IncidenteFinisate, // frame38
                          fdsSERVICE_IncidenteEngineer // frame 39
                          );
}

  // 01.07.2013
  // si mai introdum setul de filtre pentru document
  TFrameDocumentDateFilter =
  (
   fdfNone,            // Not used
   fdfToday,           // Astazi
   fdfLast2days,        // cu 2 zile inainte
   fdfLast7days,       // Ultimele 7 zile
   fdfCurrentWeek,     // Saptamana curenta
   fdfLast2weeks,      // 2 saptamani
   fdfCurrentMonth,    // Luna curenta
   fdfIQuarter,        // Trimestrul I
   fdfIIQuarter,       // Trimestrul II
   fdfIIIQuarter,      // Trimestrul III
   fdfIVQuarter,       // Trimestrul IV
   fdfFirstHalfYear,   // Semestrul I
   fdfSecondHalfYear,  // Semestrul II
   fdfCurrentYear,     // An
   fdfAll              // Toate
  );

  TFrameDocumentDateFilterSet = set of TFrameDocumentDateFilter;


  TDocumentDateFilterItem=class
  private
    fFilter:TFrameDocumentDateFilter;
    fHasFilter:Boolean;
    fTitle:String;
  public
    constructor Create(const AFilter:TFrameDocumentDateFilter; const AHasFilter:Boolean; const ATitle:String);

    property Filter:TFrameDocumentDateFilter read fFilter;
    property HasFilter:Boolean read fHasFilter;
    property Title:String read fTitle;
  end;


  TDocumentDateFiltersManager = class
  private
    fFilters:TDictionary<TFrameDocumentDateFilter, TDocumentDateFilterItem>;
    procedure ClearDictionary;
    procedure AddFilterObject(const DateFilterItem:TDocumentDateFilterItem);
    procedure InitFilters;
  public
    constructor Create;
    destructor Destroy;override;

    function GetFilterObject(const DateFilter:TFrameDocumentDateFilter):TDocumentDateFilterItem;
  end;


const
     // All filters, except fdfNONE
     cDocumentAllFilters:TFrameDocumentDateFilterSet = [fdfToday, fdfLast2days,fdfLast7days, fdfCurrentWeek, fdfLast2weeks, fdfCurrentMonth,
                                                    fdfIQuarter, fdfIIQuarter, fdfIIIQuarter, fdfIVQuarter,
                                                    fdfFirstHalfYear, fdfSecondHalfYear, fdfCurrentYear, fdfAll
                                                   ];
     //  All filters, except fdfNONE, fdfAll
     cDocumentAllFiltersWithFilter:TFrameDocumentDateFilterSet = [fdfToday, fdfLast2days, fdfLast7days, fdfCurrentWeek, fdfLast2weeks, fdfCurrentMonth,
                                                    fdfIQuarter, fdfIIQuarter, fdfIIIQuarter, fdfIVQuarter,
                                                    fdfFirstHalfYear, fdfSecondHalfYear, fdfCurrentYear
                                                   ];

     // Filtru implicit care se aplica kind se schimba Firma sau DocTypeID
     cDocumentDefaultFilter = fdfToday;

var
   SWNDocumentFrameDateFilters:TDocumentDateFiltersManager;

implementation

{ TDocumentFilterItem }

constructor TDocumentDateFilterItem.Create(const AFilter:TFrameDocumentDateFilter; const AHasFilter: Boolean; const ATitle: String);
begin
     fFilter:=AFilter;
     fHasFilter:=AHasFilter;
     fTitle:=ATitle;
end;



{ TDocumentFiltersManager }

procedure TDocumentDateFiltersManager.AddFilterObject(const DateFilterItem: TDocumentDateFilterItem);
begin
     fFilters.Add(DateFilterItem.fFilter, DateFilterItem);
end;

procedure TDocumentDateFiltersManager.ClearDictionary;
var obj:TDocumentDateFilterItem;
begin
     for obj in fFilters.Values do obj.Free;
     fFilters.Clear;
end;

constructor TDocumentDateFiltersManager.Create;
begin
     fFilters:=TDictionary<TFrameDocumentDateFilter, TDocumentDateFilterItem>.Create();
     InitFilters;
end;

destructor TDocumentDateFiltersManager.Destroy;
begin
     ClearDictionary;
     fFilters.Free;
     inherited;
end;

function TDocumentDateFiltersManager.GetFilterObject(const DateFilter: TFrameDocumentDateFilter): TDocumentDateFilterItem;
begin
     Result:=fFilters[DateFilter];
end;

procedure TDocumentDateFiltersManager.InitFilters;
begin
     AddFilterObject(TDocumentDateFilterItem.Create(fdfNone, false, ''));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfToday, True, 'Astazi'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfLast2days, True, '2 zile'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfLast7days, True, '7 zile'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfCurrentWeek, True, 'Saptamina curenta'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfLast2weeks, True, '2 saptamini'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfCurrentMonth, True, 'Luna curenta'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfIQuarter, True, 'I Trimestru'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfIIQuarter, True, 'II Trimestru'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfIIIQuarter, True, 'III Trimestru'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfIVQuarter, True, 'IV Trimestru'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfFirstHalfYear, True, 'I jumatate de an'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfSecondHalfYear, True, 'II jumatate de an'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfCurrentYear, True, 'Anul curent'));
     AddFilterObject(TDocumentDateFilterItem.Create(fdfAll, True, 'Toate inregistrarile'));
end;


initialization

  SWNDocumentFrameDateFilters:=TDocumentDateFiltersManager.Create;

finalization

  SWNDocumentFrameDateFilters.Free;

end.
