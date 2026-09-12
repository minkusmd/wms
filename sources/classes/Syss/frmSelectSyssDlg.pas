unit frmSelectSyssDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IBC, SWNBaseUnit,
  MemDS, DBAccess, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxDBLookupComboBox,
  cxTextEdit, Vcl.Menus, dxBar, cxClasses, Vcl.StdCtrls, cxButtons, dxGDIPlusClasses, DialogTitle, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid;

type

  TSyssSelectMode = (ssmVendor,ssmCity,ssmDistrict,ssmCustomerType,ssmCustomerStatus,ssmGoodsType,ssmStockType,ssmGoodsSerialType);

  TfrmSelectSyssDialog = class(TSWNBaseFormClass)
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    dxBarManagerBar1: TdxBar;
    cxGridSYSS_Vendors: TcxGridDBTableView;
    cxGridSYSSLevel1: TcxGridLevel;
    cxGridSYSS: TcxGrid;
    cxGridSYSS_VC1: TcxGridDBColumn;
    cxGridSYSS_VC2: TcxGridDBColumn;
    cxGridSYSS_VC3: TcxGridDBColumn;
    cxGridSYSS_Cities: TcxGridDBTableView;
    cxGridSYSS_CC1: TcxGridDBColumn;
    cxGridSYSS_CC2: TcxGridDBColumn;
    cxGridSYSS_CC3: TcxGridDBColumn;
    dtDialogTitle: TDialogTitle;
    cxGridSYSS_District: TcxGridDBTableView;
    cxGridSYSS_DC1: TcxGridDBColumn;
    cxGridSYSS_DC2: TcxGridDBColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxGridSYSS_CustomerType: TcxGridDBTableView;
    cxGridSYSS_CTC1: TcxGridDBColumn;
    cxGridSYSS_CTC2: TcxGridDBColumn;
    cxGridSYSS_CustomerStatus: TcxGridDBTableView;
    cxGridSYSS_CSC1: TcxGridDBColumn;
    cxGridSYSS_CSC2: TcxGridDBColumn;
    cxGridSYSS_GoodsType: TcxGridDBTableView;
    cxGridSYSS_GTC1: TcxGridDBColumn;
    cxGridSYSS_GTC2: TcxGridDBColumn;
    cxGridSYSS_StockType: TcxGridDBTableView;
    cxGridSYSS_STC1: TcxGridDBColumn;
    cxGridSYSS_STC2: TcxGridDBColumn;
    IBCDataSourceSYSS: TIBCDataSource;
    IBCQuerySYSS: TIBCQuery;
    IBCTableSYSS2: TIBCTable;
    IBCDataSourceSYSS2: TIBCDataSource;
    IBCTrUpdateSYSS: TIBCTransaction;
    cxGridSYSS_GoodsSerialType: TcxGridDBTableView;
    cxGridSYSS_GST1: TcxGridDBColumn;
    cxGridSYSS_GST2: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure DataSourceSYSSDataChange(Sender: TObject; Field: TField);
    procedure bbDeleteClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridSYSS_VendorsDblClick(Sender: TObject);
    procedure IBCQuerySYSSBeforePost(DataSet: TDataSet);
  private
    FSelectMode: TSyssSelectMode;
    FBrowseMode: Boolean;
    fSelectedSYSSID:Integer;
    fItemsChanged: Boolean;
    procedure SetSelectMode(const Value: TSyssSelectMode);
    procedure ChangeViewMode;
    procedure CreateNewRecord;
    procedure DeleteCurrentRecord;
    procedure EditSelectedRecord;

    procedure SetBrowseMode(const Value: Boolean);
    procedure SelectionChanged;
    procedure GetEditorTitles(const vSelectMode:TSyssSelectMode; var TitleText,ValueText:String);
    function GetEditorViewMode(const vSelectMode:TSyssSelectMode):TfrmSyssEditorViewMode;

  protected
    procedure InitValues;override;
  public
    { Public declarations }

    property SelectMode:TSyssSelectMode read FSelectMode write SetSelectMode;
    property BrowseMode:Boolean read FBrowseMode write SetBrowseMode;

    property SelectedSYSSID:integer read fSelectedSYSSID write fSelectedSYSSID;
    property ItemsChanged:Boolean read fItemsChanged;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst;



{$R *.dfm}

type
    TSyssFilterParam = record
     SType:String;
     SNO:integer;
     Caption:String;
     Description:String;
    end;

const
    cSYSS_Filter:array[TSyssSelectMode] of TSyssFilterParam =
    (
     (SType:'V'; SNO:1; Caption:'Producatori';Description:'Producatorii marfurilor'), // Vendor
     (SType:'C'; SNO:1; Caption:'Orase';Description:'Orasele si localitatile'), // City
     (SType:'D'; SNO:1; Caption:'Raioane';Description:''), // Districts
     (SType:'C'; SNO:2; Caption:'Tipul contraagentului';Description:''), // Customer type
     (SType:'C'; SNO:3; Caption:'Statutul contraagentului';Description:''), // Customer Status
     (SType:'G'; SNO:1; Caption:'Tipul marfii';Description:''), // Goods Type
     (SType:'S'; SNO:1; Caption:'Tipul depozitului';Description:''), // Stock Type
     (SType:'G'; SNO:2; Caption:'Tipul evidentei seriale';Description:'') // Goods Serial Type
    );


{ TfrmSelectSyssDialog }

procedure TfrmSelectSyssDialog.bbDeleteClick(Sender: TObject);
begin
     DeleteCurrentRecord;
end;

procedure TfrmSelectSyssDialog.bbModifyClick(Sender: TObject);
begin
     EditSelectedRecord;
end;

procedure TfrmSelectSyssDialog.bbNewClick(Sender: TObject);
begin
     CreateNewRecord;
end;

procedure TfrmSelectSyssDialog.btnOkClick(Sender: TObject);
begin
     if (IBCQuerySYSS.RecordCount>0) and (Not IBCQuerySYSS.FieldByName('SYSSID').IsNull) then
     begin
          fSelectedSYSSID:=IBCQuerySYSS.FieldByName('SYSSID').asInteger;
          ModalResult:=mrOk;
     end;
end;

procedure TfrmSelectSyssDialog.ChangeViewMode;
var Params:TSyssFilterParam;
    NeedSecondaryDataSet:Boolean;
    Props:TcxLookupComboBoxProperties;
    Btn:TcxEditButton;
    SecondaryDataSQL:String;
begin
     NeedSecondaryDataSet:=False;

     if Not FBrowseMode then
     begin
          btnOk.Visible:=False;
          btnCancel.Caption:='Inchide';
     end;

     // select required view
     case FSelectMode of
       ssmVendor:         begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_Vendors;
                               cxGridSYSS_Vendors.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_Vendors.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmCity:           begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_Cities;
                               cxGridSYSS_Cities.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_Cities.OptionsData.Editing:=Not FBrowseMode;

                               // additional button
                               Props:=TcxLookupComboBoxProperties(cxGridSYSS_CC3.Properties);
                               SecondaryDataSQL:='SELECT SYSSID,TITLE FROM GET_DISTRICTS';
                               NeedSecondaryDataSet:=True;
                          end;
       ssmDistrict:       begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_District;
                               cxGridSYSS_District.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_District.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmCustomerType:   begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_CustomerType;
                               cxGridSYSS_CustomerType.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_CustomerType.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmCustomerStatus: begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_CustomerStatus;
                               cxGridSYSS_CustomerStatus.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_CustomerStatus.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmGoodsType:      begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_GoodsType;
                               cxGridSYSS_GoodsType.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_GoodsType.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmStockType:      begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_StockType;
                               cxGridSYSS_StockType.DataController.DataSource:=IBCDataSourceSYSS;
                               //cxGridSYSS_StockType.OptionsData.Editing:=Not FBrowseMode;
                          end;
       ssmGoodsSerialType: begin
                               cxGridSYSSLevel1.GridView:=cxGridSYSS_GoodsSerialType;
                               cxGridSYSS_GoodsSerialType.DataController.DataSource:=IBCDataSourceSYSS;
                           end;
     end;

     // apply sql filter
     Params:=cSYSS_Filter[FSelectMode];
     IBCQuerySYSS.ParamByName('STYPE').AsString:=Params.SType;
     IBCQuerySYSS.ParamByName('SNO').AsInteger:=Params.SNO;
     Caption:=Params.Caption;
     dtDialogTitle.Title:=Params.Caption;
     dtDialogTitle.Text:=Params.Description;

     // open data
     IBCQuerySYSS.Active:=True;
     if NeedSecondaryDataSet then
     begin
          IBCTableSYSS2.SQL.Text:=SecondaryDataSQL;
          IBCTableSYSS2.Active:=True;
     end;

     if fSelectedSYSSID>-1 then IBCQuerySYSS.Locate('SYSSID',fSelectedSYSSID,[]);
end;

procedure TfrmSelectSyssDialog.CreateNewRecord;
var editor:TfrmSyssEditorDlg;
    t,v:String;
begin
     editor:=TfrmSyssEditorDlg.Create(Self,IBCQuerySYSS,IBCTableSYSS2,IBCDataSourceSYSS,IBCDataSourceSYSS2);
     try
        GetEditorTitles(FSelectMode,t,v);
        editor.ViewMode:=GetEditorViewMode(FSelectMode);
        editor.SetTitles(t,v);
        editor.EditMode:=False;
        if editor.ShowModal=mrOk then
        begin
             fItemsChanged:=True;
        end;
     finally
        editor.Free;
     end;
end;


procedure TfrmSelectSyssDialog.cxGridSYSS_VendorsDblClick(Sender: TObject);
begin
     if (IBCQuerySYSS.RecordCount>0) and (Not IBCQuerySYSS.FieldByName('SYSSID').IsNull) and FBrowseMode
      then btnOkClick(btnOk);
end;

procedure TfrmSelectSyssDialog.DataSourceSYSSDataChange(Sender: TObject; Field: TField);
begin
     SelectionChanged;
end;

procedure TfrmSelectSyssDialog.DeleteCurrentRecord;
var S,S2:WideString;
begin
     case FSelectMode of
       ssmVendor:         begin S:='Stergere producator'; S2:='Stergeti producatorul "%s"?'; end;
       ssmCity:           begin S:='Stergere oras'; S2:='Stergeti orasul '; end;
       ssmDistrict:       begin S:='Stergere raion'; S2:='Stergeti raionul "%s"?'; end;
       ssmCustomerType:   begin S:='Stergere tip contraagent'; S2:='Stergeti tipul de contraagent "%s"?'; end;
       ssmCustomerStatus: begin S:='Stergere statut contraagent'; S2:='Stergeti statutul contraagentului "%s"?'; end;
       ssmGoodsType:      begin S:='Stergere tip marfa'; S2:='Stergeti tipul de marfa "%s"?'; end;
       ssmStockType:      begin S:='Stergere tip depozit'; S2:='Stergeti tipul de depozit "%s"?'; end;
       ssmGoodsSerialType:begin S:='Stergere tip evidenta seriala'; S2:='Stergeti tipul de evidenta seriala "%s"?'; end;
     end;
     if ShowAskDialog(S,Format(S2,[IBCQuerySYSS.FieldByName('TITLE').asString]))=mrYes then
     begin
          IBCQuerySYSS.Delete;
          IBCTrUpdateSYSS.Commit;
          fItemsChanged:=True;
     end;
end;

procedure TfrmSelectSyssDialog.EditSelectedRecord;
var editor:TfrmSyssEditorDlg;
    t,v:String;
begin
     editor:=TfrmSyssEditorDlg.Create(Self,IBCQuerySYSS,IBCTableSYSS2,IBCDataSourceSYSS,IBCDataSourceSYSS2);
     try
        GetEditorTitles(FSelectMode,t,v);
        editor.ViewMode:=GetEditorViewMode(FSelectMode);
        editor.SetTitles(t,v);
        if editor.ShowModal=mrOk then
        begin
             fItemsChanged:=True;
        end;
     finally
        editor.Free;
     end;
end;

procedure TfrmSelectSyssDialog.FormShow(Sender: TObject);
begin
     ChangeViewMode;
end;

procedure TfrmSelectSyssDialog.GetEditorTitles(const vSelectMode: TSyssSelectMode; var TitleText,ValueText: String);
begin
     ValueText:='';
     case vSelectMode of
     ssmVendor:         begin TitleText:='Producator'; ValueText:='Adresa internet';  end;
     ssmCity:           begin TitleText:='Oras'; ValueText:='Raion'; end;
     ssmDistrict:       begin TitleText:='Raion'; end;
     ssmCustomerType:   begin TitleText:='Tipul producatorului'; end;
     ssmCustomerStatus: begin TitleText:='Statutul producatorului'; end;
     ssmGoodsType:      begin TitleText:='Tipul marfii'; end;
     ssmStockType:      begin TitleText:='Tipul depozitului'; end;
     ssmGoodsSerialType:begin TitleText:='Tipul evidentei seriale'; end;
     end;
end;

function TfrmSelectSyssDialog.GetEditorViewMode(const vSelectMode: TSyssSelectMode): TfrmSyssEditorViewMode;
begin
     case FSelectMode of
       ssmVendor: Result:=seemTitleValueStr;
       ssmCity:   Result:=seemTitleValueInt;
       else       Result:=seemTitle;
     end;
end;

procedure TfrmSelectSyssDialog.IBCQuerySYSSBeforePost(DataSet: TDataSet);
begin
     // STYPE
     if IBCQuerySYSS.FieldByName('STYPE').IsNull
      then IBCQuerySYSS.FieldByName('STYPE').asString:=cSYSS_Filter[FSelectMode].SType;
     // SNO
     if IBCQuerySYSS.FieldByName('SNO').IsNull
      then IBCQuerySYSS.FieldByName('SNO').asInteger:=cSYSS_Filter[FSelectMode].SNO;
end;

procedure TfrmSelectSyssDialog.InitValues;
begin
     inherited;

     FBrowseMode := True;
     FSelectMode := ssmVendor;
     fSelectedSYSSID := -1;
     fItemsChanged := False;

     // REMOVE DATA SOURSE FROM ALL VIEWS (just in case from Design mode)
     cxGridSYSS_Vendors.DataController.DataSource:=nil;
     cxGridSYSS_Cities.DataController.DataSource:=nil;
     cxGridSYSS_District.DataController.DataSource:=nil;
     cxGridSYSS_CustomerType.DataController.DataSource:=nil;
     cxGridSYSS_CustomerStatus.DataController.DataSource:=nil;
     cxGridSYSS_GoodsType.DataController.DataSource:=nil;
     cxGridSYSS_StockType.DataController.DataSource:=nil;

     IBCQuerySYSS.Connection:=fIBCConnection;
     IBCTableSYSS2.Connection:=fIBCConnection;
     IBCTrUpdateSYSS.DefaultConnection:=fIBCConnection;
end;

procedure TfrmSelectSyssDialog.SelectionChanged;
var f1,f2,f3:Boolean;
begin
     f1:=False;
     f2:=False;
     f3:=False;
     if IBCQuerySYSS.RecordCount>0 then
     begin
          f1:=Not (IBCQuerySYSS.State in dsEditModes);
          f2:=Not (IBCQuerySYSS.State in dsEditModes);
          f3:=Not (IBCQuerySYSS.State in dsEditModes);
     end
     else f1:=True;

     bbNew.Enabled:=f1; // security
     bbModify.Enabled:=f2; // security
     bbDelete.Enabled:=f3;  // security

     btnOk.Enabled:=f2;
end;

procedure TfrmSelectSyssDialog.SetBrowseMode(const Value: Boolean);
begin
     FBrowseMode := Value;
end;

procedure TfrmSelectSyssDialog.SetSelectMode(const Value: TSyssSelectMode);
begin
     FSelectMode := Value;
end;

end.
