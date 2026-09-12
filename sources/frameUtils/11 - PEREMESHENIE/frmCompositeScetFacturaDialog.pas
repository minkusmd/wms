unit frmCompositeScetFacturaDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, cxImageComboBox,  IBC,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses, dxBar,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCalendar, cxBarEditItem, dxBarExtItems,
  dxBarExtDBItems, cxCheckBox, cxDBExtLookupComboBox, cxButtonEdit, MemDS, DBAccess, Vcl.DBCtrls, cxCurrencyEdit, cxLabel;

type
  TfrmCompositeScetFacturaDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnBottom: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    cxGridDTable: TcxGridTableView;
    cxGridDLevel: TcxGridLevel;
    cxGridD: TcxGrid;
    cxGridJTable: TcxGridDBTableView;
    cxGridJLevel: TcxGridLevel;
    cxGridJ: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bdcDate: TdxBarDateCombo;
    dxBarLookupCombo1: TdxBarLookupCombo;
    cxGridD_Selection: TcxGridColumn;
    cxBarEditItem1: TcxBarEditItem;
    beiFirms: TcxBarEditItem;
    IBCQueryDocsLocal: TIBCQuery;
    IBCDataSourceDocsLocal: TIBCDataSource;
    cxGridD_DATA: TcxGridColumn;
    cxGridD_CTDEP_NAME: TcxGridColumn;
    cxGridD_CREATED_BY_NAME: TcxGridColumn;
    cxGridD_DOCID: TcxGridColumn;
    IBCQueryJurnalLocal: TIBCQuery;
    IBCDataSourceJurnalLocal: TIBCDataSource;
    cxGridJ_GOODSID: TcxGridDBColumn;
    cxGridJ_GOODS_NAME: TcxGridDBColumn;
    cxGridJ_QTY: TcxGridDBColumn;
    cxGridJ_UM_NAME: TcxGridDBColumn;
    cxGridJ_PRICE: TcxGridDBColumn;
    cxGridJ_SUMA: TcxGridDBColumn;
    cxGridJTableColumn1: TcxGridDBColumn;
    procedure bdcDateChange(Sender: TObject);
    procedure cxGridD_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure beiFirmsChange(Sender: TObject);
    procedure cxGridDTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
  private
    { Private declarations }
    procedure ReadFirmList;
    procedure DateFirmaChanged;
    procedure CopyRecordsToGrid;
    procedure PostEditors;
    function CheckSelection:Boolean;
    function UserAgree:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    function GetDocumentsList:String;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, System.DateUtils, SWNUtils, SWNConst;

{ TfrmCompositeScetFacturaDlg }

procedure TfrmCompositeScetFacturaDlg.bdcDateChange(Sender: TObject);
begin
     DateFirmaChanged;
end;

procedure TfrmCompositeScetFacturaDlg.beiFirmsChange(Sender: TObject);
begin
     DateFirmaChanged;
end;

function TfrmCompositeScetFacturaDlg.CheckSelection: Boolean;
var i,selCount:integer;
begin
     selCount:=0;
     for i := 0 to cxGridDTable.DataController.RecordCount-1 do
     if cxGridDTable.DataController.Values[i,cxGridD_Selection.Index]=1 then Inc(selCount);
     if (selCount=0) then ShowErrorDialog(cMSG_GeneralInputError_Title,'Selectați documentele pentru "Factură fiscală complexă"!');
     Result:=selCount>0;
end;

procedure TfrmCompositeScetFacturaDlg.CopyRecordsToGrid;
var N:Integer;
begin
     cxGridDTable.BeginUpdate;
     try
        while Not IBCQueryDocsLocal.Eof do
        begin
             N:=cxGridDTable.DataController.AppendRecord;
             cxGridDTable.DataController.Values[N,cxGridD_Selection.Index]:=0;
             cxGridDTable.DataController.Values[N,cxGridD_DOCID.Index]:=IBCQueryDocsLocal.FieldByName('DOCID').AsInteger;
             cxGridDTable.DataController.Values[N,cxGridD_DATA.Index]:=IBCQueryDocsLocal.FieldByName('DATA').AsDateTime;
             cxGridDTable.DataController.Values[N,cxGridD_CTDEP_NAME.Index]:=IBCQueryDocsLocal.FieldByName('CTDEP_NAME').AsString;
             cxGridDTable.DataController.Values[N,cxGridD_CREATED_BY_NAME.Index]:=IBCQueryDocsLocal.FieldByName('CREATED_BY_NAME').AsString;
             IBCQueryDocsLocal.Next;
        end;
     finally
        cxGridDTable.EndUpdate;
     end;
end;

procedure TfrmCompositeScetFacturaDlg.cxGridDTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     if Assigned(AFocusedRecord) then
     begin
          // mutam cursorul in dataset
          IBCQueryDocsLocal.Locate('DOCID',AFocusedRecord.Values[cxGridD_DOCID.Index],[]);
          if Not IBCQueryJurnalLocal.Active then IBCQueryJurnalLocal.Active:=True;
     end;
end;

procedure TfrmCompositeScetFacturaDlg.cxGridDTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if Not VarisNull(ARecord.Values[cxGridD_Selection.Index]) and (ARecord.Values[cxGridD_Selection.Index]=1) then
     begin
          AStyle := dmAdditions.cxStyle_ПеремешениеДокПринят
     end;
end;

procedure TfrmCompositeScetFacturaDlg.cxGridD_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridD_DATA.Index]) then
     begin
          if DateOf(Now) = DateOf(ARecord.Values[cxGridD_DATA.Index])
            then AText := FormatDateTime('Astazi, HH:NN', ARecord.Values[cxGridD_DATA.Index])
            else AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridD_DATA.Index]);
     end;
end;

procedure TfrmCompositeScetFacturaDlg.DateFirmaChanged;
var i:integer;
begin
     // clear grid
     cxGridDTable.BeginUpdate;
     try
        for i := cxGridDTable.DataController.RecordCount-1 downto 0 do cxGridDTable.DataController.DeleteRecord(i);
     finally
         cxGridDTable.EndUpdate;
     end;
     // close data source
     IBCQueryDocsLocal.Close;
     IBCQueryJurnalLocal.Close;

     // apply filter values
     if Not VarIsNull(bdcDate.Date) and Not VarIsNull(beiFirms.EditValue) then
     begin
          IBCQueryDocsLocal.ParamByName('currFirma').AsInteger:=dmDB.CurrentFirma;
          IBCQueryDocsLocal.ParamByName('targetFirma').AsInteger:=beiFirms.EditValue;
          IBCQueryDocsLocal.ParamByName('data').AsDate:=DateOf(bdcDate.Date);
          IBCQueryDocsLocal.Active:=True;
          CopyRecordsToGrid;
     end;
end;

function TfrmCompositeScetFacturaDlg.GetDocumentsList: String;
var list:TStringList;
    i:integer;
begin
     list:=TStringList.Create;
     try
        for i := 0 to cxGridDTable.DataController.RecordCount-1 do
        if cxGridDTable.DataController.Values[i,cxGridD_Selection.Index]=1 then list.Add(cxGridDTable.DataController.Values[i,cxGridD_DOCID.Index]);
        Result:=list.CommaText;
     finally
        list.Free;
     end;
end;

function TfrmCompositeScetFacturaDlg.IsFormDataPosted: Boolean;
begin
     PostEditors;
     Result:=CheckSelection and UserAgree;
end;

procedure TfrmCompositeScetFacturaDlg.PostEditors;
begin
     if (cxGridDTable.DataController.EditingRecordIndex>=0) then
     begin
          cxGridDTable.DataController.Post(true);
     end;
end;

procedure TfrmCompositeScetFacturaDlg.Prepare;
begin
     ReadFirmList;
end;

procedure TfrmCompositeScetFacturaDlg.ReadFirmList;
var Query:TIBCQuery;
    Props: TcxImageComboBoxProperties;
    Item: TcxImageComboBoxItem;
begin
     Props := TcxImageComboBoxProperties(beiFirms.Properties);
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM GET_FIRMS_BY_USER(:UserID) WHERE CUSTOMERID<>:curFirma';
        Query.ParamByName('UserID').AsInteger := dmDB.CurrentUserID;
        Query.ParamByName('curFirma').AsInteger := dmDB.CurrentFirma;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             Item := Props.Items.Add;
             Item.Value := Query.FieldByName('CUSTOMERID').AsInteger;
             Item.Description := Format('%s (%d)', [Query.FieldByName('DISPLAYNAME').AsString, Integer(Item.Value)]);
             Item.ImageIndex:=11;
             Query.Next;
        end;
     finally
        Query.Free;
     end;
end;

function TfrmCompositeScetFacturaDlg.UserAgree: Boolean;
begin
     Result:=ShowAskDialog('Factură fiscală complexă', 'Doriți să creați a factura fiscală complexă pentru documentele "Transfer" selectate?')=mrYes;
end;

end.
