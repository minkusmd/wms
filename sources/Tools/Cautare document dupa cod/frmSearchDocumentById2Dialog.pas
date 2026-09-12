unit frmSearchDocumentById2Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, SWNSearchDocumentTypes,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, DB,
  DBAccess, IBC, MemDS, cxInplaceContainer, cxVGrid, cxDBVGrid, StdCtrls, ExtCtrls, cxCheckBox, cxLabel,
  cxButtonEdit, cxPCdxBarPopupMenu, cxPC, cxCurrencyEdit, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxGridCustomTableView,
  cxGridTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type

  TfrmSearchDocumentById2Dlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    btnSearch: TButton;
    edSearchText: TEdit;
    btnGotoDoc: TButton;
    btnCancel: TButton;
    IBCQueryDOCS: TIBCQuery;
    IBCDataSourceDOCS: TIBCDataSource;
    pcPageControl: TcxPageControl;
    tbsDoc: TcxTabSheet;
    tbsContract: TcxTabSheet;
    tbsIncident: TcxTabSheet;
    Label3: TLabel;
    cxGridH: TcxGrid;
    cxGridHTable: TcxGridTableView;
    cxGridHTable_COD: TcxGridColumn;
    cxGridHTable_TEXT: TcxGridColumn;
    cxGridHLevel: TcxGridLevel;
    cxDBVerticalGrid: TcxDBVerticalGrid;
    rowDOCTYPE_NAME: TcxDBEditorRow;
    rowDOCID: TcxDBEditorRow;
    rowPARENTDOCID: TcxDBEditorRow;
    rowDATA: TcxDBEditorRow;
    rowDT_NAME: TcxDBEditorRow;
    rowCT_NAME: TcxDBEditorRow;
    rowCURRENCY_NAME: TcxDBEditorRow;
    rowSUMA: TcxDBEditorRow;
    rowRATE: TcxDBEditorRow;
    rowRATEUSD: TcxDBEditorRow;
    rowCREATED_BY_NAME: TcxDBEditorRow;
    cxDBVerticalGridFlags: TcxDBVerticalGrid;
    cxDBVerticalGridFlagsDBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow6: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow8: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow9: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow10: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow11: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow12: TcxDBEditorRow;
    tbsNotFound: TcxTabSheet;
    Label2: TLabel;
    tbsInvoice: TcxTabSheet;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxDBEditorRow2: TcxDBEditorRow;
    cxDBEditorRow3: TcxDBEditorRow;
    cxDBEditorRow4: TcxDBEditorRow;
    cxDBEditorRow5: TcxDBEditorRow;
    cxDBEditorRow6: TcxDBEditorRow;
    cxDBEditorRow7: TcxDBEditorRow;
    cxDBEditorRow8: TcxDBEditorRow;
    cxDBEditorRow11: TcxDBEditorRow;
    cxDBEditorRow12: TcxDBEditorRow;
    cxDBEditorRow22: TcxDBEditorRow;
    cxDBEditorRow121: TcxDBEditorRow;
    IBCQueryINVOICE: TIBCQuery;
    IBCDataSourceINVOICE: TIBCDataSource;
    IBCQueryCONTRACT: TIBCQuery;
    IBCDataSourceCONTRACT: TIBCDataSource;
    IBCQueryINCIDENTE: TIBCQuery;
    IBCDataSourceINCIDENTE: TIBCDataSource;
    cxDBVerticalGrid3: TcxDBVerticalGrid;
    cxDBEditorRow1: TcxDBEditorRow;
    cxDBEditorRow10: TcxDBEditorRow;
    cxDBEditorRow9: TcxDBEditorRow;
    cxDBEditorRow17: TcxDBEditorRow;
    cxDBEditorRow18: TcxDBEditorRow;
    cxDBEditorRow19: TcxDBEditorRow;
    cxDBEditorRow20: TcxDBEditorRow;
    cxDBEditorRow21: TcxDBEditorRow;
    cxDBEditorRow23: TcxDBEditorRow;
    cxDBVerticalGrid3DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid2: TcxDBVerticalGrid;
    cxDBEditorRow14: TcxDBEditorRow;
    cxDBEditorRow13: TcxDBEditorRow;
    cxDBEditorRow15: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow7: TcxDBEditorRow;
    cxDBEditorRow16: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow6: TcxDBEditorRow;
    cxGridHTable_DOCTYPE: TcxGridColumn;
    cxGridHTable_ISNEW: TcxGridColumn;
    dxBarManager1: TdxBarManager;
    dxBarPopupMenuH: TdxBarPopupMenu;
    cxGridHPopupMenu: TcxGridPopupMenu;
    bbClearHistory: TdxBarButton;
    rowINCIDENTID: TcxDBEditorRow;
    cxDBEditorRowCustomerName: TcxDBEditorRow;
    tbsAWB: TcxTabSheet;
    cxDBVerticalGrid4: TcxDBVerticalGrid;
    cxDBEditorRow24: TcxDBEditorRow;
    cxDBEditorRow25: TcxDBEditorRow;
    cxDBEditorRow26: TcxDBEditorRow;
    cxDBEditorRow27: TcxDBEditorRow;
    cxDBEditorRow28: TcxDBEditorRow;
    cxDBEditorRow29: TcxDBEditorRow;
    cxDBEditorRow30: TcxDBEditorRow;
    cxDBEditorRow31: TcxDBEditorRow;
    cxDBEditorRow32: TcxDBEditorRow;
    cxDBEditorRow33: TcxDBEditorRow;
    cxDBEditorRow34: TcxDBEditorRow;
    cxDBEditorRow35: TcxDBEditorRow;
    IBCQueryAWB: TIBCQuery;
    IBCDataSourceAWB: TIBCDataSource;
    rowDeliveryInfo: TcxDBMultiEditorRow;
    procedure edSearchTextChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edSearchTextEnter(Sender: TObject);
    procedure rowPARENTDOCIDEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxDBEditorRow9EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxDBVerticalGrid2DBEditorRow4EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxDBVerticalGrid2DBEditorRow3EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridHTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure bbClearHistoryClick(Sender: TObject);
    procedure rowINCIDENTIDEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    function GetSearchMasks:TSearchDocumentSearchMasks;
    function SearchDocsByMask(const Masks:TSearchDocumentSearchMasks):TSearchDocumentSearchResult;
    procedure DisplaySearchResult(const SearchResult:TSearchDocumentSearchResult; const ToHistory:Boolean=True);
    procedure CloseAllData;
    procedure AddToHistory(const DocumentID:Integer; const Text:String; const Target:TSearchDocumentSearchTarget);
    procedure SearchByDocID(const DocID:Integer);
    procedure SearchByIncidentID(const IncidentID:Integer);
    function ClearHistoryDB:Boolean;
    procedure ClearHistoryGrid;

    procedure SaveHistory;
    procedure LoadHistory;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    function GetSearchResult:TSearchDocumentResultInfo;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNValueStorageUnit, SWNDBErrors;

{$R *.dfm}

{ TfrmSearchDocumentByIdDlg }

procedure TfrmSearchDocumentById2Dlg.AddToHistory(const DocumentID: Integer; const Text: String; const Target:TSearchDocumentSearchTarget);
var N:Integer;
begin
     // locate existing record
     for N := 0 to cxGridHTable.DataController.RecordCount-1 do
     begin
          if (cxGridHTable.DataController.Values[N,cxGridHTable_COD.Index]=DocumentID) and (cxGridHTable.DataController.Values[N,cxGridHTable_DOCTYPE.Index]=Target) then
          begin
               cxGridHTable.Controller.FocusRecord(N,true);
               cxGridHTable.Controller.MakeFocusedRecordVisible;
               Exit;
          end;
     end;

     cxGridHTable.DataController.BeginUpdate;
     try
        N:=cxGridHTable.DataController.InsertRecord(0);
        cxGridHTable.DataController.Values[N,cxGridHTable_COD.Index]:=DocumentID;
        cxGridHTable.DataController.Values[N,cxGridHTable_TEXT.Index]:=Text;
        cxGridHTable.DataController.Values[N,cxGridHTable_DOCTYPE.Index]:=Target;
        cxGridHTable.DataController.Values[N,cxGridHTable_ISNEW.Index]:=True;
     finally
        cxGridHTable.DataController.EndUpdate;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.bbClearHistoryClick(Sender: TObject);
begin
     if ClearHistoryDB then ClearHistoryGrid;

end;

procedure TfrmSearchDocumentById2Dlg.btnSearchClick(Sender: TObject);
var searchResult:TSearchDocumentSearchResult;
begin
     if Trim(edSearchText.Text)='' then
     begin
          ShowErrorDialog('Eroare','Introduceri codul documentului!');
          Exit;
     end;

     searchResult:=SearchDocsByMask(GetSearchMasks);
     DisplaySearchResult(searchResult);
     if Assigned(searchResult) then searchResult.Free;
end;

function TfrmSearchDocumentById2Dlg.ClearHistoryDB: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='DELETE FROM TDB_SEARCH_DOC_HISTORY WHERE USERID=:US';
        Query.ParamByName('US').AsInteger:=dmDB.CurrentUserID;
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
           Query.Transaction.Commit;
           Result:=True;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.ClearHistoryGrid;
var i:Integer;
begin
     cxGridHTable.DataController.BeginUpdate;
     try
        for i := cxGridHTable.DataController.RecordCount-1 downto 0 do cxGridHTable.DataController.DeleteRecord(i);
     finally
        cxGridHTable.DataController.EndUpdate;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.CloseAllData;
begin
     pcPageControl.Properties.BeginUpdate;
     try
        tbsDoc.TabVisible:=False;
        tbsInvoice.TabVisible:=False;
        tbsContract.TabVisible:=False;
        tbsIncident.TabVisible:=False;
        tbsNotFound.TabVisible:=False;
        tbsAWB.TabVisible:=False;
     finally
        pcPageControl.Properties.EndUpdate;
     end;

     IBCQueryDOCS.Close;
     IBCQueryINVOICE.Close;
     IBCQueryCONTRACT.Close;
     IBCQueryINCIDENTE.Close;
end;

procedure TfrmSearchDocumentById2Dlg.cxDBEditorRow9EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SearchByDocID(IBCQueryINVOICE.FieldByName('DOCID').AsInteger);
end;

procedure TfrmSearchDocumentById2Dlg.cxDBVerticalGrid2DBEditorRow3EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SearchByDocID(IBCQueryINCIDENTE.FieldByName('RASHOD_DOCID').AsInteger);
end;

procedure TfrmSearchDocumentById2Dlg.cxDBVerticalGrid2DBEditorRow4EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SearchByDocID(IBCQueryINCIDENTE.FieldByName('GOODS_DOCID').AsInteger);
end;

procedure TfrmSearchDocumentById2Dlg.cxGridHTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var masks:TSearchDocumentSearchMasks;
    searchResult:TSearchDocumentSearchResult;
begin
     masks.SearchByText:=False;
     masks.Targets:=[TSearchDocumentSearchTarget(ACellViewInfo.GridRecord.Values[cxGridHTable_DOCTYPE.Index])];
     masks.SearchByID:=True;
     masks.ID:=ACellViewInfo.GridRecord.Values[cxGridHTable_COD.Index];
     searchResult:=SearchDocsByMask(masks);
     DisplaySearchResult(searchResult,False);
     if Assigned(searchResult) then searchResult.Free;
end;

procedure TfrmSearchDocumentById2Dlg.DisplaySearchResult(const SearchResult: TSearchDocumentSearchResult; const ToHistory:Boolean);
begin
     pcPageControl.Properties.BeginUpdate;
     try
        CloseAllData;

        if Assigned(SearchResult) then
        begin
             // Document
             if SearchResult.DocID>0 then
             begin
                  tbsDoc.TabVisible:=True;
                  IBCQueryDOCS.ParamByName('DOCID').AsInteger:=SearchResult.DocID;
                  IBCQueryDOCS.Open;
                  // Document parinte
                  rowPARENTDOCID.Visible:=IBCQueryDOCS.FieldByName('PARENTDOCID').AsInteger>0;
                  TcxButtonEditProperties(rowPARENTDOCID.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryDOCS.FieldByName('PARENTDOCID').AsInteger>0;
                  // Incident in service
                  rowINCIDENTID.Visible:=Not IBCQueryDOCS.FieldByName('INCIDENTID').IsNull;
                  TcxButtonEditProperties(rowINCIDENTID.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryDOCS.FieldByName('INCIDENTID').AsInteger>0;
                  rowDeliveryInfo.Visible := IBCQueryDOCS.FieldByName('WAYBILLID').AsInteger > 0;
                  if ToHistory then AddToHistory(SearchResult.DocID,Format('Document: %s',[IBCQueryDOCS.FieldByName('DOCTYPE_NAME').AsString]),sdstDoc);
             end;

             // Nakladnaia fiscala
             if SearchResult.InvoiceID>0 then
             begin
                  tbsInvoice.TabVisible:=True;
                  IBCQueryINVOICE.ParamByName('INVOICEID').AsInteger:=SearchResult.InvoiceID;
                  IBCQueryINVOICE.Open;
                  // Codul documentului
                  cxDBEditorRow9.Visible:=IBCQueryINVOICE.FieldByName('DOCID').AsInteger>0;

                  TcxButtonEditProperties(cxDBEditorRow9.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryINVOICE.FieldByName('DOCID').AsInteger>0;
                  if ToHistory then AddToHistory(SearchResult.InvoiceID,Format('Factura fiscala: %s',[IBCQueryINVOICE.FieldByName('FACTURANO').AsString]),sdstInvoice);
             end;

             // Contract
             if SearchResult.ContractID>0 then
             begin
                  tbsContract.TabVisible:=True;
                  IBCQueryCONTRACT.ParamByName('CONTRACTID').AsInteger:=SearchResult.ContractID;
                  IBCQueryCONTRACT.Open;
                  if ToHistory then AddToHistory(SearchResult.ContractID,Format('Contract: %s',[IBCQueryCONTRACT.FieldByName('CODE').AsString]),sdstContract);
             end;

             // Incident in service
             if SearchResult.IncidentID>0 then
             begin
                  tbsIncident.TabVisible:=True;
                  IBCQueryINCIDENTE.ParamByName('INCIDENTID').AsInteger:=SearchResult.IncidentID;
                  IBCQueryINCIDENTE.Open;
                  // Cerere de reparatie
                  cxDBVerticalGrid2DBEditorRow4.Visible:=IBCQueryINCIDENTE.FieldByName('GOODS_DOCID').AsInteger>0;
                  TcxButtonEditProperties(cxDBVerticalGrid2DBEditorRow4.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryINCIDENTE.FieldByName('GOODS_DOCID').AsInteger>0;
                  // Nakladnaia de iesire
                  cxDBVerticalGrid2DBEditorRow3.Visible:=IBCQueryINCIDENTE.FieldByName('RASHOD_DOCID').AsInteger>0;
                  TcxButtonEditProperties(cxDBVerticalGrid2DBEditorRow3.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryINCIDENTE.FieldByName('RASHOD_DOCID').AsInteger>0;
                  if ToHistory then AddToHistory(SearchResult.IncidentID,'Incident',sdstIncident);
             end;

             // AWB
             if SearchResult.AWB <> '' then
             begin
                  tbsAWB.TabVisible:=True;
                  IBCQueryAWB.ParamByName('AWB').AsString := SearchResult.AWB;
                  IBCQueryAWB.Open;
                  // Cerere de reparatie
//                  cxDBVerticalGrid2DBEditorRow4.Visible:=IBCQueryAWB.FieldByName('GOODS_DOCID').AsInteger>0;
//                  TcxButtonEditProperties(cxDBVerticalGrid2DBEditorRow4.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryINCIDENTE.FieldByName('GOODS_DOCID').AsInteger>0;
                  // Nakladnaia de iesire
//                  TcxButtonEditProperties(cxDBVerticalGrid2DBEditorRow3.Properties.EditProperties).Buttons[0].Enabled:=IBCQueryINCIDENTE.FieldByName('RASHOD_DOCID').AsInteger>0;
                  if ToHistory then AddToHistory(IBCQueryAWB.FieldByName('DOCID').AsInteger,'AWB',sdstAWB);
             end;

             pcPageControl.SelectNextPage(true);
             btnGotoDoc.SetFocus;
        end
        else
        begin
             tbsNotFound.TabVisible:=True;
             pcPageControl.ActivePage:=tbsNotFound;
        end;
     finally
       pcPageControl.Properties.EndUpdate;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.edSearchTextChange(Sender: TObject);
begin
     btnSearch.Enabled:=Trim(edSearchText.Text)<>'';
end;

procedure TfrmSearchDocumentById2Dlg.edSearchTextEnter(Sender: TObject);
begin
     btnGotoDoc.Default:=False;
     btnSearch.Default:=True;
end;

function TfrmSearchDocumentById2Dlg.GetSearchMasks: TSearchDocumentSearchMasks;
begin
     Result.Targets:=[sdstDoc,sdstInvoice,sdstContract,sdstIncident, sdstAWB, sdstDelivery];

     Result.SearchByText:=True;
     Result.Text:=Trim(edSearchText.Text);
     Result.ID:=StrToIntDef(Result.Text,0);
     Result.SearchByID:=Result.ID>0;
end;

function TfrmSearchDocumentById2Dlg.GetSearchResult: TSearchDocumentResultInfo;
begin
     Result.Doctype:=sdstNONE;
     Result.ID:=-1;

     if pcPageControl.ActivePage=tbsDoc then
     begin
          Result.Doctype:=sdstDoc;
          Result.ID:=IBCQueryDOCS.FieldByName('DOCID').AsInteger;
     end
     else
     if pcPageControl.ActivePage=tbsContract then
     begin
          Result.Doctype:=sdstContract;
          Result.ID:=IBCQueryCONTRACT.FieldByName('CONTRACTID').AsInteger;
     end
     else
     if pcPageControl.ActivePage=tbsIncident then
     begin
          Result.Doctype:=sdstIncident;
          Result.ID:=IBCQueryINCIDENTE.FieldByName('INCIDENTID').AsInteger;
     end
     else
     if pcPageControl.ActivePage=tbsInvoice then
     begin
          Result.Doctype:=sdstInvoice;
          Result.ID:=IBCQueryINVOICE.FieldByName('INVOICEID').AsInteger;
     end
     else
     if pcPageControl.ActivePage=tbsAWB then
     begin
          Result.Doctype:=sdstAWB;
          Result.ID:=IBCQueryAWB.FieldByName('DOCID').AsInteger;
     end

end;

function TfrmSearchDocumentById2Dlg.IsFormDataPosted: Boolean;
begin
     // salvam historia numai daca s-a trecut pe vre-on document
     SaveHistory;
     Result:=Assigned(pcPageControl.ActivePage) and pcPageControl.ActivePage.TabVisible;
end;

procedure TfrmSearchDocumentById2Dlg.LoadHistory;
var Query:TIBCQuery;
    N:integer;
begin
     Query:=TIBCQuery.Create(Self);
     cxGridHTable.DataController.BeginUpdate;
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT DOCUMENTID,TITLE,DOCTYPEID FROM TDB_SEARCH_DOC_HISTORY WHERE USERID=:US ORDER BY ORDERNO DESC';
        Query.ParamByName('US').AsInteger:=dmDB.CurrentUserID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             N:=cxGridHTable.DataController.AppendRecord;
             cxGridHTable.DataController.Values[N,cxGridHTable_COD.Index]:=Query.Fields[0].AsInteger;
             cxGridHTable.DataController.Values[N,cxGridHTable_TEXT.Index]:=Query.Fields[1].AsString;
             cxGridHTable.DataController.Values[N,cxGridHTable_DOCTYPE.Index]:=Query.Fields[2].AsInteger;
             cxGridHTable.DataController.Values[N,cxGridHTable_ISNEW.Index]:=False;
             Query.Next;
        end;
     finally
        cxGridHTable.DataController.EndUpdate;
        Query.Free;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.LoadStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try

     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.Prepare;
begin
     LoadHistory;
     CloseAllData;
     btnSearch.Enabled:=False;
end;

procedure TfrmSearchDocumentById2Dlg.rowINCIDENTIDEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SearchByIncidentID(IBCQueryDOCS.FieldByName('INCIDENTID').AsInteger);
end;

procedure TfrmSearchDocumentById2Dlg.rowPARENTDOCIDEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SearchByDocID(IBCQueryDOCS.FieldByName('PARENTDOCID').AsInteger);
end;

procedure TfrmSearchDocumentById2Dlg.SaveHistory;
var Query:TIBCQuery;
    i:integer;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='INSERT INTO TDB_SEARCH_DOC_HISTORY (DOCUMENTID,TITLE,DOCTYPEID,USERID) VALUES (:ID,:TEXT,:DT,:US)';
        Query.ParamByName('US').AsInteger:=dmDB.CurrentUserID;
        Query.Transaction.StartTransaction;
        try
           for i := cxGridHTable.DataController.RecordCount-1 downto 0 do
           begin
                if (cxGridHTable.DataController.Values[i,cxGridHTable_ISNEW.Index]=true) then
                begin
                     Query.ParamByName('ID').AsInteger  := cxGridHTable.DataController.Values[i,cxGridHTable_COD.Index];
                     Query.ParamByName('TEXT').AsString := cxGridHTable.DataController.Values[i,cxGridHTable_TEXT.Index];
                     Query.ParamByName('DT').AsInteger  := cxGridHTable.DataController.Values[i,cxGridHTable_DOCTYPE.Index];
                     Query.Execute;
                end;
           end;
           Query.Transaction.Commit;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.SaveStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try

     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmSearchDocumentById2Dlg.SearchByDocID(const DocID: Integer);
var masks:TSearchDocumentSearchMasks;
    searchResult:TSearchDocumentSearchResult;
begin
     masks.SearchByText:=False;
     masks.Targets:=[sdstDoc];
     masks.SearchByID:=True;
     masks.ID:=DocID;
     searchResult:=SearchDocsByMask(masks);
     DisplaySearchResult(searchResult);
     if Assigned(searchResult) then searchResult.Free;
end;

procedure TfrmSearchDocumentById2Dlg.SearchByIncidentID(const IncidentID: Integer);
var masks:TSearchDocumentSearchMasks;
    searchResult:TSearchDocumentSearchResult;
begin
     masks.SearchByText:=False;
     masks.Targets:=[sdstIncident];
     masks.SearchByID:=True;
     masks.ID:=IncidentID;
     searchResult:=SearchDocsByMask(masks);
     DisplaySearchResult(searchResult);
     if Assigned(searchResult) then searchResult.Free;
end;

function TfrmSearchDocumentById2Dlg.SearchDocsByMask(const Masks: TSearchDocumentSearchMasks): TSearchDocumentSearchResult;
var Query:TIBCQuery;
begin
     Result:=nil;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Add('SELECT');
        // Nakladnaia fiscala
        if (sdstInvoice in Masks.Targets) then
        begin
//             if Masks.SearchByID and Masks.SearchByText then Query.SQL.Add('(SELECT FIRST 1 INVOICEID FROM TDB_INVOICES WHERE FLG_CANCELED=0 AND UPPER(FACTURANO)=:TEXT OR INVOICEID=:ID),')
//             else
             if Masks.SearchByText then Query.SQL.Add('(SELECT FIRST 1 INVOICEID FROM TDB_INVOICES WHERE FLG_CANCELED=0 AND UPPER(FACTURANO)=:TEXT),')
             else
             if Masks.SearchByID then Query.SQL.Add('(SELECT INVOICEID FROM TDB_INVOICES WHERE FLG_CANCELED=0 AND INVOICEID=:ID),')
             else
             Query.SQL.Add('NULL,');
        end
        else Query.SQL.Add('NULL,');


        // Contract
        if (sdstContract in Masks.Targets) then
        begin
             if Masks.SearchByID and Masks.SearchByText then Query.SQL.Add('(SELECT FIRST 1 CONTRACTID FROM TDB_CONTRACTS WHERE CODE=:TEXT OR CONTRACTID=:ID),')
             else
             if Masks.SearchByText then Query.SQL.Add('(SELECT FIRST 1 CONTRACTID FROM TDB_CONTRACTS WHERE CODE=:TEXT),')
             else
             if Masks.SearchByID then Query.SQL.Add('(SELECT CONTRACTID FROM TDB_CONTRACTS WHERE CONTRACTID=:ID),')
             else
             Query.SQL.Add('NULL,');
        end
        else Query.SQL.Add('NULL,');

        // Document
        if (sdstDoc in Masks.Targets) and Masks.SearchByID then Query.SQL.Add('(SELECT DOCID FROM TDB_DOCS WHERE DOCID=:ID),') else Query.SQL.Add('NULL,');
        // Incident in service
        if (sdstIncident in Masks.Targets) and Masks.SearchByID then Query.SQL.Add('(SELECT INCIDENTID FROM SC_INCIDENTE WHERE INCIDENTID=:ID), ') else Query.SQL.Add('NULL,');

        // AWB
        if (sdstAWB in Masks.Targets) then
        begin
           if Masks.SearchByText then Query.SQL.Add('(SELECT AWB FROM TDB_DOCS_DELIVERY WHERE AWB = :TEXT)')
           else
             Query.SQL.Add('NULL');
        end
        else Query.SQL.Add('NULL');



        Query.SQL.Add('FROM RDB$DATABASE');

        if Masks.SearchByID then Query.ParamByName('ID').AsInteger:=Masks.ID;
        if Masks.SearchByText then Query.ParamByName('TEXT').AsString:=Masks.Text;
        Query.Open;
        if Not Query.Eof then
        begin
             if Not (Query.Fields[0].IsNull and Query.Fields[1].IsNull and Query.Fields[2].IsNull and Query.Fields[3].IsNull and Query.Fields[4].IsNull) then
             begin
                  Result:=TSearchDocumentSearchResult.Create;
                  // Nakladnaia fiscala
                  if Not Query.Fields[0].IsNull then Result.InvoiceID:=Query.Fields[0].AsInteger;
                  // Contract
                  if Not Query.Fields[1].IsNull then Result.ContractID:=Query.Fields[1].AsInteger;
                  // Document
                  if Not Query.Fields[2].IsNull then Result.DocID:=Query.Fields[2].AsInteger;
                  // Incident in service
                  if Not Query.Fields[3].IsNull then Result.IncidentID:=Query.Fields[3].AsInteger;

                  // AWB
                  if Not Query.Fields[4].IsNull then Result.AWB:=Query.Fields[4].Asstring;

             end;
        end;
     finally
        Query.Free;
     end;
end;


end.
