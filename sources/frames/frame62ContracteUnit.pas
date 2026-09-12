unit frame62ContracteUnit;
{
  CONTRACTE. Contracte
  DocTypeID = 105
  Frame Index = 62
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxSplitter, Vcl.ExtCtrls,
  cxPCdxBarPopupMenu, cxPC, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, cxCalc,
  DBAccess, IBC, MemDS, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe62Contracte = class(TSWNBaseFrame)
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    pcTabs: TcxPageControl;
    tbsDocs: TcxTabSheet;
    tbsJurnal: TcxTabSheet;
    cxGridContractsTable: TcxGridDBTableView;
    cxGridContractsLevel: TcxGridLevel;
    cxGridContracts: TcxGrid;
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocs_DOCID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocs_CREATED_DATE: TcxGridDBColumn;
    cxGridDocs_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_FLG_ACNT: TcxGridDBColumn;
    cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocs_CT: TcxGridDBColumn;
    cxGridDocs_DT: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    cxGridDocs_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    IBCQueryContracte: TIBCQuery;
    IBCDataSourceContracte: TIBCDataSource;
    cxGridContracts_CONTRACTID: TcxGridDBColumn;
    cxGridContracts_CODE: TcxGridDBColumn;
    cxGridContracts_DT_NAME: TcxGridDBColumn;
    cxGridContracts_CT_NAME: TcxGridDBColumn;
    cxGridContracts_SIGN_DATE: TcxGridDBColumn;
    cxGridContracts_CREATED_DATE: TcxGridDBColumn;
    cxGridContracts_EXPIRE_DATE: TcxGridDBColumn;
    cxGridContracts_CONTRACT_TYPE_TITLE: TcxGridDBColumn;
    cxGridContracts_PRICE_COLUMN: TcxGridDBColumn;
    cxGridContracts_FLG_ACNT: TcxGridDBColumn;
    cxGridContracts_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridContracts_CREATED_BY_NAME: TcxGridDBColumn;
    IBCDataSourceDocsLocal: TIBCDataSource;
    IBCQueryDocsLocal: TIBCQuery;
    IBCQueryJurnalLocal: TIBCQuery;
    IBCDataSourceJurnalLocal: TIBCDataSource;
    cxGridDocs_FLG_CLOSED: TcxGridDBColumn;
    cxGridContracts_DT: TcxGridDBColumn;
    cxGridContracts_CT: TcxGridDBColumn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dxBarManager1: TdxBarManager;
    bbCalcProfitability: TdxBarButton;
    dxBarPopupMenuContracts: TdxBarPopupMenu;
    cxGridContracts_FLG_CLOSED: TcxGridDBColumn;
    bbCloseContract: TdxBarButton;
    cxTabSheet1: TcxTabSheet;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_TITLE: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    bbGotoDoc: TdxBarButton;
    bbFileSave: TdxBarButton;
    bbFileOpen: TdxBarButton;
    bbFileNew: TdxBarButton;
    bbFileRemove: TdxBarButton;
    procedure cxGridContractsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridContracts_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridContractsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDocsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridContractsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbCalcProfitabilityClick(Sender: TObject);
    procedure bbCloseContractClick(Sender: TObject);
    procedure bbGotoDocClick(Sender: TObject);
    procedure cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbFileSaveClick(Sender: TObject);
    procedure bbFileOpenClick(Sender: TObject);
    procedure bbFileNewClick(Sender: TObject);
    procedure bbFileRemoveClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_Allow:Boolean;
    fLastContractID:Integer;
    fLastFilePath:String;
    procedure ContractSelectionChanged;
    procedure DocsSelectionChanged;
    procedure FileSelectionChanged;
    procedure ShowCalcProfitabilityByContractDialog(const ContractID:Integer);
    function DoCloseContractDB:Boolean;

    procedure OpenData(const FrameDataFilterInfo:TFrameDataFilteringInfo);

    procedure SaveFileToDisk;
    procedure PreviewFile;
    procedure SaveFileToDiskDB(const ContractFileID:integer; const TargetPath:String);

    procedure ShowAddNewFileDialog;
    procedure DeleteSelectedFile;

  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;

    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;
    procedure RefreshData;override;

    procedure SaveFrameStates;override;
    procedure ReadFrameStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function LocateDocument(const DocID:integer):Boolean; override;
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: String): Variant; override;
  end;


implementation

{$R *.dfm}

uses System.UITypes, DataModuleDB, DataModuleAdditions, SWNValueStorageUnit, frmCalcProfitabilityContractDialog, SWNUtils, SWNDBErrors, SWNSecurity,
  SWNSecurityFlags, frmCustomerContractEditorDialog, SWNConst, FileCtrl, System.IOUtils, Winapi.ShellAPI, frmCustomerContractFileEditorDialog;

{ Tframe62Dogovora }

procedure Tframe62Contracte.bbCalcProfitabilityClick(Sender: TObject);
begin
     ShowCalcProfitabilityByContractDialog(IBCQueryContracte.FieldByName('CONTRACTID').asInteger);
end;

procedure Tframe62Contracte.bbCloseContractClick(Sender: TObject);
begin
     if ShowAskDialog('Inchidere contract',
                      Format('Sigur doriti sa inchideti contractul nr.%s cu "%s"?',[IBCQueryContracte.FieldByName('CODE').asString,IBCQueryContracte.FieldByName('CT_NAME').asString]),
                      'Operatiile ulterioare cu acest contract nu vor mai fi posibile!')=mrYes then
     begin
          if DoCloseContractDB then RefreshData;
     end;
end;

procedure Tframe62Contracte.bbFileNewClick(Sender: TObject);
begin
     ShowAddNewFileDialog;
end;

procedure Tframe62Contracte.bbFileOpenClick(Sender: TObject);
begin
     PreviewFile;
end;

procedure Tframe62Contracte.bbFileRemoveClick(Sender: TObject);
begin
     DeleteSelectedFile;
end;

procedure Tframe62Contracte.bbFileSaveClick(Sender: TObject);
begin
     SaveFileToDisk;
end;

procedure Tframe62Contracte.bbGotoDocClick(Sender: TObject);
begin
     FindDocument(IBCQueryDocsLocal.FieldByName('DOCID').AsInteger);
end;

procedure Tframe62Contracte.ContractSelectionChanged;
var FLG_CLOSED,fDocChanged:Boolean;
    fCalcProf,fClose:Boolean;
    fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=fSECURITY_Allow;
     fEdit:=False;
     fDelete:=False;
     fDocChanged:=False;
     fCalcProf:=False;
     fClose:=False;

     if (cxGridContractsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=IBCQueryContracte.FieldByName('FLG_CLOSED').AsInteger=1;
          fEdit:=fSECURITY_Allow and Not FLG_CLOSED;
          fDelete:=fSECURITY_Allow and Not FLG_CLOSED;
          fDocChanged:=IBCQueryContracte.FieldByName('CONTRACTID').AsInteger<>fLastContractID;
          fLastContractID:=IBCQueryContracte.FieldByName('CONTRACTID').AsInteger;

          fCalcProf:=True;
          fClose:=fSECURITY_Allow and Not FLG_CLOSED;
     end;
     // main buttons
     ButtonStateChanged(fbtADD,fAdd);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);

     if fDocChanged then pcTabs.ActivePage:=tbsDocs;

     bbCalcProfitability.Enabled:=fCalcProf;
     bbCloseContract.Enabled:=fClose;

     DocsSelectionChanged;
     FileSelectionChanged;
end;

procedure Tframe62Contracte.CreateNewRecord;
var dialog:TfrmCustomerContractEditorDlg;
begin
     dialog:=TfrmCustomerContractEditorDlg.Create(Self,IBCQueryContracte,IBCDataSourceContracte);
     try
        dialog.CreateNewRecord:=True;
        if dialog.ShowModal=mrOk then ContractSelectionChanged;
     finally
        dialog.Free;
     end;
end;

procedure Tframe62Contracte.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe62Contracte.cxGridContractsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridContracts_FLG_CLOSED.Index]) then
    begin
         if (AViewInfo.GridRecord.Values[cxGridContracts_FLG_CLOSED.Index]=1) then
         begin
              ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
              if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
         end;
    end;
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridContracts_FLG_ACNT.Index]) then
     begin
          // Document prin contabilitate
          if (AViewInfo.GridRecord.Values[cxGridContracts_FLG_ACNT.Index]=1) and Not AViewInfo.Selected
            then ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
    end;

    if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe62Contracte.cxGridContractsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     ContractSelectionChanged;
end;

procedure Tframe62Contracte.cxGridContractsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridContractsTable, Key, Shift);
end;

procedure Tframe62Contracte.cxGridContracts_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridContracts_CREATED_DATE.Index]) then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridContracts_CREATED_DATE.Index]);
end;

procedure Tframe62Contracte.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index]=1 then
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
          end;
     end;

     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDocs_FLG_ACNT.Index]) then
     begin
          if Not AViewInfo.Selected then
          begin
               // Document prin contabilitate
               if AViewInfo.GridRecord.Values[cxGridDocs_FLG_ACNT.Index] = 1 then ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
          end;
    end;

    if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe62Contracte.cxGridDocsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocsSelectionChanged;
end;

procedure Tframe62Contracte.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe62Contracte.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridDocs_DATA.Index]) then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_DATA.Index]);
end;

procedure Tframe62Contracte.cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     FileSelectionChanged;
end;

procedure Tframe62Contracte.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_62,[IBCQueryContracte.FieldByName('CONTRACTID').asInteger]))=mrYes then
     begin
          IBCQueryContracte.UpdateTransaction.StartTransaction;
          try
             IBCQueryContracte.Delete;
             IBCQueryContracte.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQueryContracte.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure Tframe62Contracte.DeleteSelectedFile;
begin
     if ShowAskDialog('Stergere fisier',Format('Doriti sa stergeti fisierul "%s"?',[IBCQueryFiles.FieldByName('TITLE').AsString]))<>mrYes then Exit;

     IBCQueryFiles.UpdateTransaction.StartTransaction;
     try
        IBCQueryFiles.Delete;
        IBCQueryFiles.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryFiles.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

function Tframe62Contracte.DoCloseContractDB: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_105(:ID)';
        Query.ParamByName('ID').AsInteger:=IBCQueryDocsLocal.FieldByName('CONTRACTID').AsInteger;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
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

procedure Tframe62Contracte.DocsSelectionChanged;
var hasGoods,fGotoDoc:Boolean;
begin
     hasGoods:=False;
     fGotoDoc:=False;

     if (cxGridDocsTable.DataController.RecNo>0) then
     begin
          hasGoods:=IBCQueryDocsLocal.FieldByName('HAS_JURNAL_GOODS').AsInteger=1;
          fGotoDoc:=True;
     end;

     bbGotoDoc.Enabled:=fGotoDoc;

     if hasGoods then
     begin
          tbsJurnal.TabVisible:=True;
     end
     else
     begin
          pcTabs.ActivePage:=tbsDocs;
          tbsJurnal.TabVisible:=False;
     end;
end;

procedure Tframe62Contracte.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryJurnalLocal.Close;
     IBCQueryDocsLocal.Close;
     IBCQueryContracte.Close;

     inherited;
end;

procedure Tframe62Contracte.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // deschidem datele interne
     OpenData(FrameDataFilterInfo);

     // 4. Selection update
     ContractSelectionChanged;
end;

procedure Tframe62Contracte.FileSelectionChanged;
var fNew,fDelete,fSave:Boolean;
    FLG_CLOSED:Boolean;
begin
     fNew:=False;
     fDelete:=False;
     fSave:=False;

     if (cxGridContractsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=IBCQueryContracte.FieldByName('FLG_CLOSED').AsInteger=1;

          fNew:=fSECURITY_Allow and Not FLG_CLOSED;
          if (cxGridFilesTable.DataController.RecNo>0) then
          begin
               fDelete:=fSECURITY_Allow and Not FLG_CLOSED;
               fSave:=True;
          end;
     end;

     bbFileNew.Enabled:=fNew;
     bbFileRemove.Enabled:=fDelete;
     bbFileSave.Enabled:=fSave;
     bbFileOpen.Enabled:=fSave;
end;

function Tframe62Contracte.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridContractsTable.Site.Focused then
     begin
          // context from Contracts
          if cxGridContracts_CT_NAME.Focused then
          begin
               // Contraagent
               Result.Context := ffCustomer;
               Result.ValueInt := IBCQueryContracte.FieldByName('CT').AsInteger;
               Result.ValueStr := IBCQueryContracte.FieldByName('CT_NAME').AsString;
          end
          else
              if cxGridContracts_CREATED_DATE.Focused then
              begin
                   // Data
                   Result.Context := ffDate;
                   Result.ValueDateTime := IBCQueryContracte.FieldByName('CREATED_DATE').AsDateTime;
              end;
     end;
end;

function Tframe62Contracte.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe62Contracte.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtADD,fbtMODIFY,fbtDELETE,fbtREFRESH];
end;

procedure Tframe62Contracte.GetParamsListForReport(const ParamsList: TStringList);
begin
  inherited;
  if IBCQueryContracte.Active then
  begin
    ParamsList.Add('CONTRACTID');
    ParamsList.Add('DT');
  end;
end;

function Tframe62Contracte.GetParamValueForReport(const ParamName: String): Variant;
begin
  if IBCQueryContracte.Active then
  begin
    if SameText(ParamName, 'CONTRACTID') then
      Result := IBCQueryContracte.FieldByName('CONTRACTID').AsInteger;
    if SameText(ParamName, 'DT') then
      Result := dmDB.CurrentFirma;
  end;
end;

function Tframe62Contracte.InitFrameID: integer;
begin
     // CONTRACTE - Contracte
     Result:=62;

     fLastFilePath:='';
     fLastContractID:=-1;
     dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

function Tframe62Contracte.LocateDocument(const DocID: integer): Boolean;
begin
     Result:=IBCQueryContracte.Locate('CONTRACTID',DocID,[]);
end;

procedure Tframe62Contracte.ModifyRecord;
var dialog:TfrmCustomerContractEditorDlg;
begin
     dialog:=TfrmCustomerContractEditorDlg.Create(Self,IBCQueryContracte,IBCDataSourceContracte);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe62Contracte.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var filters:TFrameDataFilterSet;
    whereStr:String;
begin
     IBCQueryContracte.Close;
     IBCQueryDocsLocal.Close;
     IBCQueryJurnalLocal.Close;
     IBCQueryFiles.Close;

     filters:=FrameDataFilterInfo.FrameFilters;

     // prepeare Where condition
     whereStr:='DT=:FIRMA';
     if (dfiDATE in filters) then whereStr:=whereStr+' AND (CAST(CREATED_DATE AS DATE)>=:DATA1 AND CAST(CREATED_DATE AS DATE)<=:DATA2)';
     if (dfiCustomerID in filters) then whereStr:=whereStr+' AND (CT=:CT)';

     // apply filter
     IBCQueryContracte.FilterSQL:=whereStr;

     // setup params

     IBCQueryContracte.ParamByName('FIRMA').AsInteger:=FrameDataFilterInfo.FirmaID;
     if (dfiDATE in filters) then
     begin
          IBCQueryContracte.ParamByName('DATA1').AsDate:=FrameDataFilterInfo.DateStart;
          IBCQueryContracte.ParamByName('DATA2').AsDate:=FrameDataFilterInfo.DateEnd;
     end;
     if (dfiCustomerID in filters) then IBCQueryContracte.ParamByName('FIRMA').AsInteger:=FrameDataFilterInfo.CustomerID;

     // open data
     IBCQueryContracte.Open;
     IBCQueryDocsLocal.Open;
     IBCQueryJurnalLocal.Open;
     IBCQueryFiles.Open;
end;

procedure Tframe62Contracte.PreviewFile;
var dir,filename:String;
begin
     dir:=IncludeTrailingPathDelimiter(TPath.GetTempPath);
     SaveFileToDiskDB(IBCQueryFiles.FieldByName('CONTRACTFILEID').AsInteger,dir);
     filename:=Concat(dir,IBCQueryFiles.FieldByName('FILENAME').AsString);
     ShellExecute(handle,'open',PWideChar(filename),nil,nil,SW_SHOWNORMAL);
end;

procedure Tframe62Contracte.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridContractsTable);
        ReadGridColumnsSettings(cxGridDocsTable);
        ReadGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe62Contracte.RefreshData;
begin
     IBCQueryContracte.Refresh;
     IBCQueryDocsLocal.Refresh;
     IBCQueryJurnalLocal.Refresh;
     IBCQueryFiles.Refresh;
end;

procedure Tframe62Contracte.SaveFileToDisk;
var dir:String;
begin
     dir:=fLastFilePath;
     if SelectDirectory('Alegeti unde sa salvati fisierul','',dir) then
     begin
          SaveFileToDiskDB(IBCQueryFiles.FieldByName('CONTRACTFILEID').AsInteger,dir);
          fLastFilePath:=dir;
     end;
end;

procedure Tframe62Contracte.SaveFileToDiskDB(const ContractFileID: integer; const TargetPath: String);
var Query:TIBCQuery;
    filename:String;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT FILENAME,FILECONTENT FROM TDB_CONTRACT_FILES WHERE CONTRACTFILEID=:ID';
        Query.ParamByName('ID').AsInteger:=ContractFileID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             filename:=IncludeTrailingPathDelimiter(TargetPath)+Query.Fields[0].AsString;
             TBlobField(Query.Fields[1]).SaveToFile(filename);
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe62Contracte.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridContractsTable);
        SaveGridColumnsSettings(cxGridDocsTable);
        SaveGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe62Contracte.SetupDefaultFocus;
begin
     // focused grid
     cxGridContracts.SetFocus;
     // set focused column
     cxGridContracts_CT_NAME.Focused := True;
     cxGridDocs_CT_NAME.Focused := True;
     cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe62Contracte.SetupSecurityItems;
begin
     fSECURITY_Allow:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование);
end;

procedure Tframe62Contracte.ShowAddNewFileDialog;
var dialog:TfrmCustomerContractFileEditorDlg;
begin
     dialog:=TfrmCustomerContractFileEditorDlg.Create(Self,IBCQueryFiles,IBCDataSourceFiles);
     try
        dialog.ContractID:=IBCQueryContracte.FieldByName('CONTRACTID').AsInteger;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe62Contracte.ShowCalcProfitabilityByContractDialog(const ContractID: Integer);
var dialog:TfrmCalcProfitabilityContractDlg;
begin
     dialog:=TfrmCalcProfitabilityContractDlg.Create(Self);
     try
        dialog.ContractID:=ContractID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe62Contracte.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     OpenData(FrameDataFilterInfo);
end;

end.
