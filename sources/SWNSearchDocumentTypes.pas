unit SWNSearchDocumentTypes;

interface

type

  TSearchDocumentSearchTarget = (sdstDoc,sdstInvoice,sdstContract,sdstIncident,sdstAWB, sdstDelivery, sdstNONE);
  TSearchDocumentSearchTargets = set of TSearchDocumentSearchTarget;

  TSearchDocumentSearchMasks=record
    SearchByID:Boolean;
    SearchByText:Boolean;
    ID:Integer;
    Text:String;
    Targets:TSearchDocumentSearchTargets;
  end;

  TSearchDocumentSearchResult=class
    DocID:Integer;
    InvoiceID:Integer;
    IncidentID:Integer;
    ContractID:Integer;
    AWB: string;
    constructor Create;
  end;

  TSearchDocumentResultInfo=record
    ID:Integer;
    Doctype:TSearchDocumentSearchTarget;
  end;


implementation

{ TSearchDocumentSearchResult }

constructor TSearchDocumentSearchResult.Create;
begin
     DocID:=-1;
     InvoiceID:=-1;
     IncidentID:=-1;
     ContractID:=-1;
end;


end.
