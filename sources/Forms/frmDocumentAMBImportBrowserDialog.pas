unit frmDocumentAMBImportBrowserDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxClasses, dxBar, ExtCtrls, dxBarExtItems, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, cxCalendar, StdCtrls, cxBarEditItem, DBAccess, IBC, MemDS, cxDropDownEdit,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxContainer, SWNUtils,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, cxCalc, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges, SWNClasses, dxScrollbarAnnotations, dxUIAClasses;

type
  TfrmDocumentAMBImportBrowserDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    pnClient: TPanel;
    bbRefresh: TdxBarButton;
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPNTableData: TcxGridDBColumn;
    cxGridNPNTableWarehouse: TcxGridDBColumn;
    cxGridNPNCol_CT_NAME: TcxGridDBColumn;
    cxGridNPNTableSuma: TcxGridDBColumn;
    cxGridNPNTableCurrencyName: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPNTableRate: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPN_FLG_ACNT: TcxGridDBColumn;
    cxGridNPNTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPN_FLG_SHIP: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxGridComponents: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    IBCQueryDocsLocal: TIBCQuery;
    IBCDataSourceDocsLocal: TIBCDataSource;
    IBCQueryJurnalLocal: TIBCQuery;
    IBCDataSourceJurnalLocal: TIBCDataSource;
    beDateStart: TcxBarEditItem;
    beDateEnd: TcxBarEditItem;
    pnSettings: TPanel;
    cxLabel2: TLabel;
    lcbDocType: TcxLookupComboBox;
    cmbDate: TcxComboBox;
    IBCDataSourceDocTypes: TIBCDataSource;
    IBCQueryDocTypes: TIBCQuery;
    cxGridNPNTable_DT_NAME: TcxGridDBColumn;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    IBC_AMB_Connection: TIBCConnection;
    IBCTrSelect: TIBCTransaction;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridNPNTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure pnSettingsDblClick(Sender: TObject);
  private
    { Private declarations }
    fDefaultDocTypeID:Integer;
    fDefaultFirmaID:Integer;
    fDefaultUserID:Integer;
    fDocRate: double;
    fDocDocTypeName: String;
    fDocCurrency_Name: String;
    fDocSuma: Currency;
    fDocID: integer;

    fFixedFirmaID:Boolean;
    fFixedUserID:Boolean;
    FDocTypeList: TIntegerList;
    fAccessFirmeList:String;

    procedure OpenDocDataByFilter;

    procedure CreateDateFilter;
    procedure SetDefaultValues;

    procedure SetDefaultDocTypeID(const Value: integer);
    procedure SetDefaultFirmaID(const Value: integer);
    procedure SetDefaultUserID(const Value: integer);
    procedure SetFixedFirmaID(const Value: Boolean);
    procedure SetFixedUserID(const Value: Boolean);

    procedure WhenFilterChanged(Sender:TObject);
    procedure SetDocTypeList(const Value: TIntegerList);
    procedure ReadAccessFirmeList;

    procedure SetupQtyFields;

  protected
    { protected declarations }
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    function SelectDoc:Boolean;

    property DocTypeList:TIntegerList read FDocTypeList write SetDocTypeList;
    property DefaultDocTypeID:integer write SetDefaultDocTypeID;
    property DefaultFirmaID:integer write SetDefaultFirmaID;
    property DefaultUserID:integer write SetDefaultUserID;

    property FixedFirmaID:Boolean write SetFixedFirmaID;
    property FixedUserID:Boolean write SetFixedUserID;


    property DocID:integer read fDocID;
    property DocDocTypeName:String read fDocDocTypeName;
    property DocSuma:Currency read fDocSuma;
    property DocCurrency_Name:String read fDocCurrency_Name;
    property DocRate:double read fDocRate;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNConst, SWNSearchUnit, SWNValueStorageUnit, SWNDocumentFilters,
     System.UITypes;

{$R *.dfm}

{ TfrmIPTSelectGoodsSourceDlg }

procedure TfrmDocumentAMBImportBrowserDlg.btnOkClick(Sender: TObject);
begin
     if cxGridNPNTable.DataController.RecNo>0 then
     begin
          fDocID:=IBCQueryDocsLocal.FieldByName('DOCID').AsInteger;
          fDocRate:=IBCQueryDocsLocal.FieldByName('RATE').AsFloat;
          fDocDocTypeName:=IBCQueryDocsLocal.FieldByName('DOCTYPE_NAME').AsString;
          fDocCurrency_Name:=IBCQueryDocsLocal.FieldByName('CURRENCY_NAME').AsString;
          fDocSuma:=IBCQueryDocsLocal.FieldByName('SUMA').AsCurrency;

          ModalResult:=mrOk;
     end
     else ShowErrorDialog('Import','Alegeti documentul pentru import!');
end;

procedure TfrmDocumentAMBImportBrowserDlg.CreateDateFilter;
var i:TFrameDocumentDateFilter;
    N:integer;
    filterObject:TDocumentDateFilterItem;
begin
     cmbDate.Properties.Items.BeginUpdate;
     try
        cmbDate.Properties.Items.Clear;
        for i in cDocumentAllFilters do
        begin
             filterObject:=SWNDocumentFrameDateFilters.GetFilterObject(i);

             N:=cmbDate.Properties.Items.AddObject(filterObject.Title, filterObject);
             if (i=cDocumentDefaultFilter) then
                cmbDate.ItemIndex := N;
        end;
     finally
        cmbDate.Properties.Items.EndUpdate;
     end;
end;

procedure TfrmDocumentAMBImportBrowserDlg.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPN_FLG_SHIP.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridNPN_FLG_SHIP.Index] = 0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_ACNT.Index] = 1 then ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    ACanvas.Font.Color := clGrayText;
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_ACNT.Index] = 1 then ACanvas.Font.Color := $008B8BC5;
               end;
          end;
     end;

end;

procedure TfrmDocumentAMBImportBrowserDlg.cxGridNPNTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridNPNTableData.Index])
       then AText:=FormatDateTime('dd.mm.yyyy HH:NN',ARecord.Values[cxGridNPNTableData.Index]);
end;

procedure TfrmDocumentAMBImportBrowserDlg.FormCreate(Sender: TObject);
begin
     fDefaultDocTypeID:=-1;
     fDefaultFirmaID:=FirmaID;
     fDefaultUserID:=-1;
     fDocID:=-1;
     fDocRate:=0;
     fDocDocTypeName:='';
     fDocCurrency_Name:='';
     fDocSuma:=0;
     fFixedFirmaID:=False;
     fFixedUserID:=False;
     FDocTypeList := TIntegerList.Create;
end;

procedure TfrmDocumentAMBImportBrowserDlg.FormDestroy(Sender: TObject);
begin
     FDocTypeList.Free;
end;

procedure TfrmDocumentAMBImportBrowserDlg.LoadStates;
begin
     if AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Position:=poDesigned;
end;

procedure TfrmDocumentAMBImportBrowserDlg.OpenDocDataByFilter;
var f1,f4:Boolean;
    S:String;
    d1,d2:TDateTime;
    filterObject:TDocumentDateFilterItem;
begin
     // close active
     IBCQueryDocsLocal.Active := False;

     // create filter
     f4:=False;
     S:=Format('(DT IN (%d) AND CT IN (%d))',[387,1533]);

     AddConditionToWHERE(S,'DOCTYPEID=:DOCTYPE');
     f1:=True;

     if cmbDate.ItemIndex<>-1 then
     begin
          filterObject:=TDocumentDateFilterItem(cmbDate.Properties.Items.Objects[cmbDate.ItemIndex]);
          f4:=GetDocumentFrameFilterDateValues(filterObject.Filter,d1,d2);
          if f4 then
          begin
               AddConditionToWHERE(S,'CAST(DATA AS DATE)>=:Date1');
               AddConditionToWHERE(S,'CAST(DATA AS DATE)<=:Date2');
          end;
     end;

     IBCQueryDocsLocal.DisableControls;
     IBCQueryJurnalLocal.DisableControls;
     try
        IBCQueryJurnalLocal.Close;
        IBCQueryDocsLocal.Close;

        // apply filter
        IBCQueryDocsLocal.FilterSQL:=S;

        // set params
        if f1 then IBCQueryDocsLocal.ParamByName('DOCTYPE').Value:=lcbDocType.EditValue;
        if f4 then
        begin
             IBCQueryDocsLocal.ParamByName('Date1').AsDate:=d1;
             IBCQueryDocsLocal.ParamByName('Date2').AsDate:=d2;
        end;

        fDocID:=-1;
        // open data
        IBCQueryDocsLocal.Open;
        IBCQueryJurnalLocal.Open;
     finally
       IBCQueryDocsLocal.EnableControls;
       IBCQueryJurnalLocal.EnableControls;
     end;
end;

procedure TfrmDocumentAMBImportBrowserDlg.pnSettingsDblClick(Sender: TObject);
begin
  cmbDate.ItemIndex := 12;
end;

procedure TfrmDocumentAMBImportBrowserDlg.Prepare;
var S:String;
begin
     IBC_AMB_Connection.Connected := True;
     SetupQtyFields;

     try
        CreateDateFilter;
        ReadAccessFirmeList;

        // open data
        if FDocTypeList.Count>0
         then S:=FDocTypeList.GetValueList
         else S:='-1';

        IBCQueryDocTypes.FilterSQL:=Format('DOCTYPEID IN (%s)',[S]);
        IBCQueryDocTypes.Active:=True;

        // set default values
        SetDefaultValues;

        //SelectionChanged;
        OpenDocDataByFilter;
     except
        IBCQueryDocTypes.Active:=False;

        raise;
     end;


end;

procedure TfrmDocumentAMBImportBrowserDlg.ReadAccessFirmeList;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT COALESCE(LIST(CUSTOMERID),''-1'') FROM GET_FIRMS_BY_USER2';
        Query.ExecSQL;
        if Not Query.Eof then fAccessFirmeList:=Query.Fields[0].AsString;
     finally
        Query.Free;
     end;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SaveStates;
begin
     AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

function TfrmDocumentAMBImportBrowserDlg.SelectDoc: Boolean;
begin
     Result:=ShowModal=mrOk;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetDefaultDocTypeID(const Value: integer);
begin
     fDefaultDocTypeID:=Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetDefaultFirmaID(const Value: integer);
begin
     fDefaultFirmaID:=Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetDefaultUserID(const Value: integer);
begin
     fDefaultUserID:=Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetDefaultValues;
begin
     if fDefaultDocTypeID<>-1 then IBCQueryDocTypes.Locate('DOCTYPEID',fDefaultDocTypeID,[]);
     lcbDocType.EditValue:=IBCQueryDocTypes.FieldByName('DOCTYPEID').Value;

     // set event handlers
     cmbDate.Properties.OnChange:=WhenFilterChanged;
     lcbDocType.Properties.OnChange:=WhenFilterChanged;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetDocTypeList(const Value: TIntegerList);
begin
     FDocTypeList := Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetFixedFirmaID(const Value: Boolean);
begin
     fFixedFirmaID:=Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetFixedUserID(const Value: Boolean);
begin
     fFixedUserID:=Value;
end;

procedure TfrmDocumentAMBImportBrowserDlg.SetupQtyFields;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
     TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
     cxGridDBCol_QTY.Summary.FooterFormat:=cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmDocumentAMBImportBrowserDlg.WhenFilterChanged(Sender: TObject);
begin
     OpenDocDataByFilter;
end;

end.
