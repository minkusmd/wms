unit frame36ServiceCardClientUnit;
{
 СЕРВИС - Сервисная карта клиента
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ImgList, SWNBaseFrameUnit, cxGraphics, cxCustomData, cxStyles,
  cxTL, cxLabel, cxCheckBox, cxTLdxBarBuiltInMenu, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxImageComboBox,
  DBAccess, IBC, MemDS, dxBar, cxClasses, cxImage, cxDBEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxControls, cxGridCustomView, cxGrid, cxSplitter, cxMemo, cxCheckListBox, cxDBCheckListBox, ComCtrls, cxInplaceContainer, cxDBTL,
  cxTLData, cxTextEdit, cxMaskEdit, cxButtonEdit, cxContainer, cxDBLabel, StdCtrls, ExtCtrls, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  Tframe36ServiceCardClient = class(TSWNBaseFrame)
    dxBarManager: TdxBarManager;
    pnClientInfo: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    cxDBLabel2: TcxDBLabel;
    cxDBLabel3: TcxDBLabel;
    cxDBLabel4: TcxDBLabel;
    cxDBLabel5: TcxDBLabel;
    cxDBLabel6: TcxDBLabel;
    cxDBLabel7: TcxDBLabel;
    cxDBLabel8: TcxDBLabel;
    cxDBLabel9: TcxDBLabel;
    cxDBLabel10: TcxDBLabel;
    dxBarManager1Bar2: TdxBar;
    bbModifyIncidentInfo: TdxBarButton;
    Panel1: TPanel;
    pnIncidente: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    cxDBTreeList: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList_Col_DATA: TcxDBTreeListColumn;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManager1Bar3: TdxBar;
    bbDocNew: TdxBarButton;
    cxDBTreeList1cxDBTreeListColumn4: TcxDBTreeListColumn;
    cxSplitter: TcxSplitter;
    cxGridRashod: TcxGrid;
    cxGridRashodTable: TcxGridDBTableView;
    cxGridRashodTableDocID: TcxGridDBColumn;
    cxGridRashodTableDocNo: TcxGridDBColumn;
    cxGridRashodTableData: TcxGridDBColumn;
    cxGridRashodTableWarehouse: TcxGridDBColumn;
    cxGridRashodTableCtName: TcxGridDBColumn;
    cxGridRashodTableSuma: TcxGridDBColumn;
    cxGridRashodTableCurrencyName: TcxGridDBColumn;
    cxGridRashodTableVAT: TcxGridDBColumn;
    cxGridRashodTableRate: TcxGridDBColumn;
    cxGridRashodTableParentDocID: TcxGridDBColumn;
    cxGridRashodTableFlgACNT: TcxGridDBColumn;
    cxGridRashodTableCreatedBy: TcxGridDBColumn;
    cxGridRashodTable_FLG_SHIP: TcxGridDBColumn;
    cxGridRashodTable_FLG_PROTECTED: TcxGridDBColumn;
    cxGridRashodLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_K_UM: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    pnIncidentInfo: TPanel;
    pcPageControlID: TPageControl;
    TabSheet1: TTabSheet;
    IBCQueryCustomerInfo: TIBCQuery;
    IBCDataSourceCustomerInfo: TIBCDataSource;
    IBCQueryIncidents: TIBCQuery;
    IBCDataSourceIncidents: TIBCDataSource;
    cxDBTreeList1cxDBTreeListColumn5: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn6: TcxDBTreeListColumn;
    bbCreateInitialTask: TdxBarButton;
    pcPageControlIR: TPageControl;
    tbsSales: TTabSheet;
    tbsTasks: TTabSheet;
    tbsProfScheduler: TTabSheet;
    cxGridTasks: TcxGrid;
    cxGridTasksDBTable: TcxGridDBTableView;
    cxGridTasksLevel: TcxGridLevel;
    cxGridTasksDBTableColumn1: TcxGridDBColumn;
    cxGridTasksDB_DATA_ASSIGN: TcxGridDBColumn;
    cxGridTasksDBTableColumn3: TcxGridDBColumn;
    cxGridTasksDBTableColumn4: TcxGridDBColumn;
    cxDBMemo3: TcxDBMemo;
    Label12: TLabel;
    cxGridPScheduler: TcxGrid;
    cxGridPSchedulerDBTable: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridPSchedulerLevel: TcxGridLevel;
    bbChangeStatus: TdxBarButton;
    IBCQueryCustomerInfoCUSTOMERID: TIntegerField;
    IBCQueryCustomerInfoPARENTID: TIntegerField;
    IBCQueryCustomerInfoFLG_FOLDER: TSmallintField;
    IBCQueryCustomerInfoPREFIXNAME: TWideStringField;
    IBCQueryCustomerInfoNAME: TWideStringField;
    IBCQueryCustomerInfoSUFIXNAME: TWideStringField;
    IBCQueryCustomerInfoDISPLAYNAME: TWideStringField;
    IBCQueryCustomerInfoORG_PARENT_ID: TIntegerField;
    IBCQueryCustomerInfoCUSTOMER_TYPE_ID: TIntegerField;
    IBCQueryCustomerInfoCUSTOMER_STATUS_ID: TIntegerField;
    IBCQueryCustomerInfoVAT: TSmallintField;
    IBCQueryCustomerInfoORDERNO: TIntegerField;
    IBCQueryCustomerInfoCHIEF: TWideStringField;
    IBCQueryCustomerInfoACCOUNTANT: TWideStringField;
    IBCQueryCustomerInfoTELEFON1: TWideStringField;
    IBCQueryCustomerInfoTELEFON2: TWideStringField;
    IBCQueryCustomerInfoMOBILE: TWideStringField;
    IBCQueryCustomerInfoFAX: TWideStringField;
    IBCQueryCustomerInfoIDEN_NUMBER: TWideStringField;
    IBCQueryCustomerInfoVAT_NUMBER: TWideStringField;
    IBCQueryCustomerInfoEMAIL: TWideStringField;
    IBCQueryCustomerInfoADDRESS: TWideStringField;
    IBCQueryCustomerInfoREZIDENT: TWideStringField;
    IBCQueryCustomerInfoCITY_ID: TIntegerField;
    IBCQueryCustomerInfoACCOUNTNUMBER: TWideStringField;
    IBCQueryCustomerInfoPRICECOLUMN: TSmallintField;
    IBCQueryCustomerInfoCUSTOMER_TYPE_TITLE: TWideStringField;
    IBCQueryCustomerInfoCUSTOMER_STATUS_TITLE: TWideStringField;
    IBCQueryCustomerInfoCITY_TITLE: TWideStringField;
    IBCQueryCustomerInfoCALC_ALL_PHONES: TStringField;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarButton4: TdxBarButton;
    dxBarButton12: TdxBarButton;
    cxDBTreeList_Col_PRIORITY: TcxDBTreeListColumn;
    Panel2: TPanel;
    Label13: TLabel;
    clbFLAGS_COMPLECT: TcxDBCheckListBox;
    Panel3: TPanel;
    Label14: TLabel;
    cxDBMemo2: TcxDBMemo;
    Panel4: TPanel;
    cxDBMemo1: TcxDBMemo;
    Label15: TLabel;
    dxBarManagerBar3: TdxBar;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    dxBarButton15: TdxBarButton;
    TabSheet2: TTabSheet;
    cxDBImage1: TcxDBImage;
    cxGridPhotos: TcxGrid;
    cxGridPhotosDBTable: TcxGridDBTableView;
    cxGridPhotosDBTableColumn1: TcxGridDBColumn;
    cxGridPhotosDBTableColumn2: TcxGridDBColumn;
    cxGridPhotosLevel: TcxGridLevel;
    dxBarDockControl6: TdxBarDockControl;
    cxDBTreeList_Col_FLG_INCIDENT_CLOSED: TcxDBTreeListColumn;
    cxDBTreeList_Col_DATA_CLOSED: TcxDBTreeListColumn;
    IBCQueryTasks: TIBCQuery;
    IBCDataSourceTasks: TIBCDataSource;
    IBCQueryScheduler: TIBCQuery;
    IBCDataSourceScheduler: TIBCDataSource;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn;
    IBCQueryTaskDsc: TIBCQuery;
    IBCDataSourceTaskDsc: TIBCDataSource;
    cxGridTasksDB_HC: TcxGridDBColumn;
    dbeCUSTOMER: TcxDBButtonEdit;
    cxGridTasksDB_STATUS_ID: TcxGridDBColumn;
    TabSheet3: TTabSheet;
    cxDBTreeList_Col_FLG_INCIDENT_FINISHED: TcxDBTreeListColumn;
    dxBarDockControl4: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbNewCall: TdxBarButton;
    bbModifyCall: TdxBarButton;
    bbRemoveCall: TdxBarButton;
    cxGridCalls: TcxGrid;
    cxGridCallsDBTableView: TcxGridDBTableView;
    cxGridCallsDB_CALL_TIME: TcxGridDBColumn;
    cxGridCallsDB_PHONE: TcxGridDBColumn;
    cxGridCallsDB_CALL_RESULT_TEXT: TcxGridDBColumn;
    cxGridCallsDB_COMMENTS: TcxGridDBColumn;
    cxGridCallsDB_USER_FULLNAME: TcxGridDBColumn;
    cxGridCallsLevel: TcxGridLevel;
    IBCQueryCalls: TIBCQuery;
    IBCDataSourceCalls: TIBCDataSource;
    procedure bbSelectCustomerClick(Sender: TObject);
    procedure IBCQueryIncidentsCalcFields(DataSet: TDataSet);
    procedure IBCQueryCustomerInfoCalcFields(DataSet: TDataSet);
    procedure cxDBTreeList_Col_DATAGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
    procedure dbeCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbModifyIncidentInfoClick(Sender: TObject);
    procedure cxDBTreeList_Col_PRIORITYGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
    procedure cxDBTreeListFocusedNodeChanged(Sender: TObject; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure bbCreateInitialTaskClick(Sender: TObject);
    procedure cxDBTreeList_Col_DATA_CLOSEDGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
    procedure bbChangeStatusClick(Sender: TObject);
    procedure bbDocNewClick(Sender: TObject);
    procedure cxGridTasksDB_DATA_ASSIGNGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridTasksDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridCallsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxDBTreeListDblClick(Sender: TObject);
    procedure cxDBTreeListSelectionChanged(Sender: TObject);
  private
    { Private declarations }
    fCurrentCustomerID:integer;

    procedure TreeSelectionChanged;

    procedure IncidentCallsSelectionChanged;

    procedure ShowSelectCustomerDialog;
    procedure CloseAllData;

    procedure ShowModifyIncidentInfoDialog;
    function CheckParamsForTask:Boolean;

    function DoAcionDB_CreateTask(const IID:integer):Boolean;

    procedure ShowChangeIncidentStatusDialog;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;
    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;

    procedure DoFrameShow;override;
    procedure DoFrameHide;override;

  public
    { Public declarations }
    function HasDocID:Boolean;override;

    procedure SelectCustomer(const CustomerID:integer);

    procedure GetParamsListForReport(const ParamsList:TStringList);override;
    function GetParamValueForReport(const ParamName:String):Variant;override;
  end;


implementation

uses DataModuleAdditions, frmCustomersDlg, DataModuleDB,
  frmIncidentDescriptionDialog, SWNConst, SWNUtils, SWNDBErrors, frmIncidentStatusDialog,
  SWNTypes, frame28NakladnieRNSUnit;

{$R *.dfm}

{ TSWNBaseFrame1 }


procedure Tframe36ServiceCardClient.bbChangeStatusClick(Sender: TObject);
begin
     ShowChangeIncidentStatusDialog;
end;

procedure Tframe36ServiceCardClient.bbCreateInitialTaskClick(Sender: TObject);
begin
     if CheckParamsForTask then
     begin
          if ShowAskDialog('Создание задачи','Вы хотите пустить инцидент в работу?')=mrYes then
          begin
               if DoAcionDB_CreateTask(IBCQueryIncidents.FieldByName('IID').AsInteger) then
               begin
                    IBCQueryIncidents.Refresh;
                    TreeSelectionChanged;
               end;
          end;
     end;
end;

procedure Tframe36ServiceCardClient.bbDocNewClick(Sender: TObject);
var frame:Tframe28NakladnieRNS;
    IID:integer;
begin
     IID:=IBCQueryIncidents.FieldByName('IID').AsInteger;

     frame:=Tframe28NakladnieRNS(SWNFrameManager.GoToFrame(28));
     if Assigned(Frame) then
     begin
          frame.CreateDocument(fCurrentCustomerID,496,IID);
     end;
end;

procedure Tframe36ServiceCardClient.bbModifyIncidentInfoClick(Sender: TObject);
begin
     ShowModifyIncidentInfoDialog;
end;

procedure Tframe36ServiceCardClient.bbSelectCustomerClick(Sender: TObject);
begin
     ShowSelectCustomerDialog;
end;

function Tframe36ServiceCardClient.CheckParamsForTask: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if IBCQueryIncidents.FieldByName('GOODS_MODEL').IsNull or (IBCQueryIncidents.FieldByName('GOODS_MODEL').AsString='') then AddErrorToStr(ErrorStr,'Модель товара!');
     if IBCQueryIncidents.FieldByName('DEFECT_DSC').IsNull or (IBCQueryIncidents.FieldByName('DEFECT_DSC').AsString='') then AddErrorToStr(ErrorStr,'Описание дефекта!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog('Ошибка!','Опишите полностью инцидент для создания задачи.',ErrorStr);
end;

procedure Tframe36ServiceCardClient.CloseAllData;
begin
     // close data
     IBCQueryTaskDsc.Close;
     IBCQueryScheduler.Close;
     IBCQueryTasks.Close;
     IBCQueryJurnal.Active:=False;
     IBCQueryDocs.Active:=False;
     IBCQueryIncidents.Close;
     IBCQueryCustomerInfo.Close;
end;

procedure Tframe36ServiceCardClient.cxDBTreeList_Col_DATAGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
  var Value: string);
begin
     Value:=FormatDateTime('dd-mmm-yyyy HH:MM',ANode.Values[cxDBTreeList_Col_DATA.ItemIndex]);
end;

procedure Tframe36ServiceCardClient.cxDBTreeList_Col_DATA_CLOSEDGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
  var Value: string);
begin
     if Not VarIsNull(ANode.Values[cxDBTreeList_Col_DATA_CLOSED.ItemIndex])
      then Value:=FormatDateTime('dd-mmm-yyyy'+#13#10+'HH:MM',ANode.Values[cxDBTreeList_Col_DATA_CLOSED.ItemIndex]);
end;

procedure Tframe36ServiceCardClient.cxDBTreeList_Col_PRIORITYGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
begin
     Value:=cINCIDENT_Priority[Integer(ANode.Values[cxDBTreeList_Col_PRIORITY.ItemIndex])];
end;

procedure Tframe36ServiceCardClient.cxGridCallsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     IncidentCallsSelectionChanged;
end;

procedure Tframe36ServiceCardClient.cxGridTasksDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var TaskStatus:integer;
begin
     // Статус задач в сервисе
     // 6301 - В ожидание
     // 6302 - В исполнение

     TaskStatus:=ARecord.Values[cxGridTasksDB_STATUS_ID.Index];
     case TaskStatus of
     6301: AStyle:=dmAdditions.cxStyle_TextColorRed;
     6302: AStyle:=dmAdditions.cxStyle_TextColorGreen;
     6303: AStyle:=dmAdditions.cxStyle_TextGray;
     end

end;

procedure Tframe36ServiceCardClient.cxGridTasksDB_DATA_ASSIGNGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     AText:=FormatDateTime('dd-mmm-yyyy HH:MM',ARecord.Values[cxGridTasksDB_DATA_ASSIGN.Index]);
end;

procedure Tframe36ServiceCardClient.dbeCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     ShowSelectCustomerDialog;
end;

procedure Tframe36ServiceCardClient.cxDBTreeListDblClick(Sender: TObject);
var ht:TcxTreeListHitTest;
begin
     ht:=cxDBTreeList.HitTest;
     if ht.HitAtNode and Assigned(ht.HitNode) and bbModifyIncidentInfo.Enabled and (bbModifyIncidentInfo.Visible=ivAlways)
      then bbModifyIncidentInfoClick(bbModifyIncidentInfo);
end;

procedure Tframe36ServiceCardClient.cxDBTreeListFocusedNodeChanged(Sender: TObject; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
     TreeSelectionChanged;
end;

procedure Tframe36ServiceCardClient.cxDBTreeListSelectionChanged(Sender: TObject);
begin
     TreeSelectionChanged;
end;

function Tframe36ServiceCardClient.DoAcionDB_CreateTask(const IID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_SC_CREATE_NEW_INCIDENT(:IID)';
           Query.ParamByName('IID').AsInteger:=IID;
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe36ServiceCardClient.DoFrameHide;
begin
     CloseAllData;

     inherited;
end;

procedure Tframe36ServiceCardClient.DoFrameShow;
begin
     inherited;

     fCurrentCustomerID:=-1;

     TreeSelectionChanged;
end;

function Tframe36ServiceCardClient.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe36ServiceCardClient.GetFrameButtons: TFrameButtons;
begin
     Result:=[];
end;

procedure Tframe36ServiceCardClient.GetParamsListForReport(const ParamsList: TStringList);
begin
     if fCurrentCustomerID<>-1 then
     begin
          ParamsList.Add('CustomerID');
     end;
end;

function Tframe36ServiceCardClient.GetParamValueForReport(const ParamName: String): Variant;
begin
     if SameText(ParamName,'CustomerID') then Result:=fCurrentCustomerID;
end;

function Tframe36ServiceCardClient.HasDocID: Boolean;
begin
     Result:=False;
end;

procedure Tframe36ServiceCardClient.IBCQueryCustomerInfoCalcFields(DataSet: TDataSet);
var S,S2:String;
begin
     With DataSet do
     begin
          S:='';

          S2:=FieldByName('TELEFON1').AsString;
          if S2<>'' then S:=S+S2;

          S2:=FieldByName('TELEFON2').AsString;
          if S2<>'' then
          begin
               if S<>'' then S:=S+', ';
               S:=S+S2;
          end;

          S2:=FieldByName('MOBILE').AsString;
          if S2<>'' then
          begin
               if S<>'' then S:=S+', ';
               S:=S+S2;
          end;

          FieldByName('CALC_ALL_PHONES').AsString:=S;
     end;
end;

procedure Tframe36ServiceCardClient.IBCQueryIncidentsCalcFields(DataSet: TDataSet);
begin
     with DataSet do
     FieldByName('INCIDENT_TITLE').AsString:=Format('%s (%s; %s)',[FieldByName('TYPE_TITLE').AsString,FieldByName('SN').AsString,FieldByName('GOODS_NAME').AsString]);
end;

procedure Tframe36ServiceCardClient.IncidentCallsSelectionChanged;
var fModify,fDelete:Boolean;
begin
     fModify:=False;
     fDelete:=False;

     if cxDBTreeList.DataController.FocusedRecordIndex>=0 then
     begin
          if (IBCQueryIncidents.FieldByName('FLG_INCIDENT_CLOSED').AsInteger = 0) and (cxGridCallsDBTableView.DataController.RecNo>0) then
          begin
               fModify:=True;
               fDelete:=True;
          end;
     end;

     bbModifyCall.Enabled:=fModify;
     bbRemoveCall.Enabled:=fDelete;
end;

function Tframe36ServiceCardClient.InitFrameID: integer;
begin
     Result:=36; // СЕРВИС - Сервисная карта клиента
end;

procedure Tframe36ServiceCardClient.SelectCustomer(const CustomerID: integer);
begin
     CloseAllData;
     // params
     fCurrentCustomerID:=CustomerID;
     IBCQueryCustomerInfo.ParamByName('CustomerID').AsInteger:=fCurrentCustomerID;
     IBCQueryIncidents.ParamByName('CustomerID').AsInteger:=fCurrentCustomerID;
     // open data
     IBCQueryCustomerInfo.Open;
     IBCQueryIncidents.Open;
     IBCQueryDocs.Active:=True;
     IBCQueryJurnal.Active:=True;
     IBCQueryTasks.Open;
     IBCQueryScheduler.Open;
     IBCQueryTaskDsc.Open;
     IBCQueryCalls.Open;
end;

procedure Tframe36ServiceCardClient.ShowChangeIncidentStatusDialog;
var dialog:TfrmIncidentStatusDlg;
begin
     dialog:=TfrmIncidentStatusDlg.Create(Self,IBCQueryIncidents,IBCDataSourceIncidents);
     try
        if dialog.ShowModal=mrOk then
        begin
             TreeSelectionChanged;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe36ServiceCardClient.ShowModifyIncidentInfoDialog;
var dialog:TfrmIncidentDescriptionDlg;
begin
     dialog:=TfrmIncidentDescriptionDlg.Create(Self,IBCQueryIncidents,IBCDataSourceIncidents);
     try
        if dialog.ShowModal=mrOk then
        begin
             TreeSelectionChanged;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe36ServiceCardClient.ShowSelectCustomerDialog;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(fCurrentCustomerID,False,0,'Выбрать клиента для Сервисной карты') then
        begin
             SelectCustomer(dialog.CustomerID);
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe36ServiceCardClient.TreeSelectionChanged;
var fInDsc,fCreateTask,fChangeStatus:Boolean;
    fDocNew:Boolean;
    fIncidentNew:Boolean;
begin
     fInDsc:=False;
     fCreateTask:=False;
     fChangeStatus:=False;

     fDocNew:=False;
     fIncidentNew:=False;

     // FocusedRecordIndex

     if Assigned(cxDBTreeList.FocusedNode) then
     begin
          if IBCQueryIncidents.FieldByName('FLG_INCIDENT_CLOSED').AsInteger = 0 then  // FLG_INCIDENT_CLOSED
          begin
               fInDsc:=IBCQueryIncidents.FieldByName('STATUS_ID').AsInteger = 6101; // Описание инцидента
               fCreateTask:=(IBCQueryIncidents.FieldByName('STATUS_ID').AsInteger = 6101); // Создать задачу
               fChangeStatus:=True; // Изменить статус

               fDocNew:=True; // Новый расход на сервис
               fIncidentNew:=True; // Новый звонок
          end;
     end;

     // tree buttons
     bbModifyIncidentInfo.Enabled:=fInDsc;
     bbCreateInitialTask.Enabled:=fCreateTask;
     bbChangeStatus.Enabled:=fChangeStatus;

     bbDocNew.Enabled:=fDocNew;
     bbNewCall.Enabled:=fIncidentNew;
     bbModifyCall.Enabled:=False;
     bbRemoveCall.Enabled:=False;

     // update selection for other grids
     IncidentCallsSelectionChanged;
end;


end.
