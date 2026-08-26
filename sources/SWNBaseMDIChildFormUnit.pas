unit SWNBaseMDIChildFormUnit;

interface

uses
   Classes, Controls, Forms, System.Types, SWNDocumentFilters, SWNDataFiltering,
   frmPrintEngineWindow, cxGridDBTableView, cxGridTableView, cxCustomData, Data.DB, IBC,
   cxGridCustomTableView;

type
  // Button types
   TFrameButtonType = (fbtADD, fbtMODIFY, fbtDELETE, fbtCLONE, fbtREFRESH, fbtDial);
   TFrameButtons = set of TFrameButtonType;
   TOnCustomPrintSetupReportParams = procedure(const ReportParams: TReportParamsList) of object;

   TSearchContextValue = record
      Context: TFrameFilterField;
      ValueInt: Integer;
      ValueStr: string;
      ValueDateTime: TDateTime;
   end;

   TOnShowPrintDialog = procedure(const FrameID: Integer) of object;

   // Înlocuim TFrame cu TForm și adăugăm FormStyle pentru MDI Child
   TSWNBaseMDIChild = class(TForm)
   private
    { Private declarations }
      fQtyReplaceMask: string;
      fQtyDisplayFormat: string;
      fFilterFields: TFrameFilterFields;
      fFrameButtons: TFrameButtons;
      FOnCustomPrintSetupReportParams: TOnCustomPrintSetupReportParams;
      FOnShowPrintDialog: TOnShowPrintDialog;
      procedure SetDefaultValue(const Value: Integer);
      procedure SetOnCustomPrintSetupReportParams(const Value: TOnCustomPrintSetupReportParams);
      procedure SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
   protected
    { Protected declarations }
      fFrameID: Integer;
      fFilter_DateStart, fFilter_DateEnd: TDateTime;
      fFilter_CustomerID: Integer;
      fFilter_GoodsID: Integer;
      fFilter_StockID: Integer;
      fDefaultValue: Integer;

      function InitFrameID: Integer; virtual;
      function GetFilterFields: TFrameFilterFields; virtual;
      function GetFrameButtons: TFrameButtons; virtual;
      procedure DoFormShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); virtual;
      procedure DoFormHide; virtual;
      procedure DoButtonClick(const ButtonType: TFrameButtonType); virtual;
      procedure DoDocumentDoubleClick; virtual;
      procedure CreateNewRecord; virtual;
      procedure ModifyRecord; virtual;
      procedure DeleteRecord; virtual;
      procedure RefreshData; virtual;
      procedure CloneRecord; virtual;
      function GetPhoneNumber: string; virtual;
      procedure ButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
      procedure ReadFormStates; virtual;
      procedure SaveFormStates; virtual;
      procedure SetupSecurityItems; virtual;
      procedure ShowPrintDialog;
      function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; virtual;
      procedure OpenExternalData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
      procedure CloseExternalData;
      procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); virtual;

    // internal usage
      procedure SetupFont; overload;
      procedure SaveGridColumnsSettings(const Grid: TcxGridTableView);
      procedure ReadGridColumnsSettings(const Grid: TcxGridTableView);
      function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
      function CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: Integer): Boolean;
      function CheckGridForCTField(const Grid: TcxGridDBTableView; var CT: Integer): Boolean;
      function CheckGridForDocIDValue(const Grid: TcxGridDBTableView; var DocID: Integer): Boolean;
      procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView; AOnlyCellValue: boolean);
      procedure ShowQuickInfoDialog(const GoodsID: Integer);
      procedure ShowQuickInfoCustomers(const DT, CT: Integer);
      procedure ShowGoodsBrowser(const GoodsID: Integer);
      procedure ShowCustomersBrowser(const CustomerID: Integer);
      procedure FindParentDocument(const DocID: Integer);
      procedure FindDocument(const DocID: Integer);
      function ShowDocumentCommentsDialog(const DocID: Integer): Boolean;
      procedure ShowDocumentExplorer(const DocID: Integer);
      procedure ShowCopyGridContent(const Grid: TcxGridDBTableView);
      procedure ShowPricingRulesDialog(const Grid: TcxGridDBTableView; GoodsID: integer);
      procedure ShowForeignGoodsCodesDialog(GoodsID: integer);
   public
    { Public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function DocumentDefaultFilter: TFrameDocumentDateFilter; virtual;
      procedure SetFilter(const StarDate, EndDate: TDateTime; const CustomerID, GoodsID, StockID: Integer); virtual;

      property FrameID: Integer read fFrameID;
      property FilterFields: TFrameFilterFields read fFilterFields;
      property FrameButtons: TFrameButtons read fFrameButtons;

      procedure GetParamsListForReport(const ParamsList: TStringList); virtual;
      function GetParamValueForReport(const ParamName: string): Variant; virtual;
      function LocateDocument(const DocID: Integer): Boolean; virtual;
      procedure SetupDefaultView; virtual;
      procedure SetupDefaultFocus; virtual;
      function GetCurrentSearchContext: TSearchContextValue; virtual;

      property DefaultValue: Integer read fDefaultValue write SetDefaultValue;
      property OnCustomPrintSetupReportParams: TOnCustomPrintSetupReportParams read
         FOnCustomPrintSetupReportParams write SetOnCustomPrintSetupReportParams;
      property OnShowPrintDialog: TOnShowPrintDialog read FOnShowPrintDialog write SetOnShowPrintDialog;
      property QtyReplaceMask: string read fQtyReplaceMask;
      property QtyDisplayFormat: string read fQtyDisplayFormat;
   end;

  // SWNFormManager (renamed from FrameManager)
   TOnRequiredFormNotFound = procedure(const RequiredFrameID: Integer; var NewCustomForm: TSWNBaseMDIChild) of object;
   TOnFormShow = procedure(const ShownForm: TSWNBaseMDIChild) of object;
   TOnButtonStateChanged = procedure(const Button: TFrameButtonType; const ButtonEnabled: Boolean) of object;
   TOnGotoForm = procedure(const FrameID: Integer; const Value: Integer; var FormFound: Boolean) of object;
   TOnGotoFormEx = procedure(const FrameID: Integer; const Value: Integer; const DocDate: TDateTime; var
      FormFound: Boolean) of object;

   TSWNFormManager = class
   private
    { Private declarations }
      fFormList: TList;
      fCurrentDisplayForm: TSWNBaseMDIChild;
      fMDIParentForm: TForm;
      fOnRequiredFormNotFound: TOnRequiredFormNotFound;
      FOnFormShow: TOnFormShow;
      FOnButtonStateChanged: TOnButtonStateChanged;
      FOnGotoForm: TOnGotoForm;
      FOnGotoFormEx: TOnGotoFormEx;
      FOnShowPrintDialog: TOnShowPrintDialog;

      procedure SetMDIParentForm(const Value: TForm);
      function FormIDExists(const FrameID: Integer): Boolean;
      procedure SetOnRequiredFormNotFound(const Value: TOnRequiredFormNotFound);
      procedure SetOnFormShow(const Value: TOnFormShow);
      procedure SetOnButtonStateChanged(const Value: TOnButtonStateChanged);
      procedure FormButtonStateChanged(const Form: TSWNBaseMDIChild; const Button: TFrameButtonType; const
         ButtonEnabled: Boolean);
      procedure SetOnGotoForm(const Value: TOnGotoForm);
      procedure SetOnGotoFormEx(const Value: TOnGotoFormEx);
      procedure SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
   public
    { Public declarations }
      constructor Create;
      destructor Destroy; override;

      property MDIParentForm: TForm read fMDIParentForm write SetMDIParentForm;
      property CurrentForm: TSWNBaseMDIChild read fCurrentDisplayForm;

      procedure RegisterForm(const CustomForm: TSWNBaseMDIChild);
      procedure UnRegisterForm(const CustomForm: TSWNBaseMDIChild);
      function SwitchToForm(const FrameID: Integer; const FrameDataFilterInfo: TFrameDataFilteringInfo; const
         Value: Integer): TSWNBaseMDIChild;
      function GoToForm(const FrameID: Integer; const Value: Integer = -1): TSWNBaseMDIChild;
      function GoToFormEx(const FrameID: Integer; const Value: Integer; const DocDate: TDateTime): TSWNBaseMDIChild;
      procedure HideCurrentForm;
      procedure DoButtonClick(const ButtonType: TFrameButtonType);
      function GetFormByID(const FrameID: Integer): TSWNBaseMDIChild;
      function GetFormNumberToDial: string;

      property OnRequiredFormNotFound: TOnRequiredFormNotFound read fOnRequiredFormNotFound write
         SetOnRequiredFormNotFound;
      property OnFormShow: TOnFormShow read FOnFormShow write SetOnFormShow;
      property OnButtonStateChanged: TOnButtonStateChanged read FOnButtonStateChanged write SetOnButtonStateChanged;
      property OnGotoForm: TOnGotoForm read FOnGotoForm write SetOnGotoForm;
      property OnGotoFormEx: TOnGotoFormEx read FOnGotoFormEx write SetOnGotoFormEx;
      property OnShowPrintDialog: TOnShowPrintDialog read FOnShowPrintDialog write SetOnShowPrintDialog;

      procedure FormDataFilterChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
   end;

const
   cFrameButtonsSet_BasicButtons = [fbtADD, fbtMODIFY, fbtDELETE, fbtREFRESH];
   cFrameButtonsSet_AllButtons = [fbtADD, fbtMODIFY, fbtDELETE, fbtCLONE, fbtREFRESH];

var
   SWNFormManager: TSWNFormManager;

implementation

uses
   SysUtils, SWNConst, SWNValueStorageUnit, SWNUtils, DataModuleDB, ClipBrd, Dialogs, frmGoods, Variants,
   frmGoodsQuickInfoDialog, frmQuickCustomerInfoDialog, frmCustomersDlg, SWNSecurity,
   frmDocumentCommentsV2Dialog, frmDocumentInspectorDialog, frmBSToolsCopyGridClipboardDialog, MainForm,
   SWNCommonDialogs, frmPriceTypesUnit, frmGoodsForeignCodeDialog;

{$R *.dfm}

procedure RegisterForm(const CustomForm: TSWNBaseMDIChild);
begin
   if Assigned(SWNFormManager) then
      SWNFormManager.RegisterForm(CustomForm);
end;

procedure UnRegisterForm(const CustomForm: TSWNBaseMDIChild);
begin
   if Assigned(SWNFormManager) then
      SWNFormManager.UnRegisterForm(CustomForm);
end;

{ TSWNBaseMDIChild }

procedure TSWNBaseMDIChild.ButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
begin
   SWNFormManager.FormButtonStateChanged(Self, Button, ButtonEnabled);
end;

function TSWNBaseMDIChild.CheckGridForCTField(const Grid: TcxGridDBTableView; var CT: Integer): Boolean;
var
   i: Integer;
   col: TcxGridDBColumn;
begin
   CT := -1;
   for i := 0 to Grid.ColumnCount - 1 do
      if Grid.Columns[i] is TcxGridDBColumn then
      begin
         col := Grid.Columns[i];
         if (col.DataBinding.FieldName = 'CT') or (col.DataBinding.FieldName = 'CUSTOMERID') then
         begin
            if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index])
               then
               CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
         end;
      end;
   Result := (CT <> -1)
end;

function TSWNBaseMDIChild.CheckGridForDocIDValue(const Grid: TcxGridDBTableView; var DocID: Integer): Boolean;
var
   i: Integer;
   col: TcxGridDBColumn;
begin
   DocID := -1;
   Result := False;
   for i := 0 to Grid.ColumnCount - 1 do
   begin
      col := Grid.Columns[i];
      if (col.DataBinding.FieldName = 'DOCID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex,
         col.Index]) then
      begin
         DocID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
         Result := True;
         Break;
      end;
   end;
end;

function TSWNBaseMDIChild.CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
var
   i: Integer;
   col: TcxGridDBColumn;
begin
   GoodsID := -1;
   Result := False;
   for i := 0 to Grid.ColumnCount - 1 do
   begin
      col := Grid.Columns[i];
      if (col.DataBinding.FieldName.ToUpper = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex,
         col.Index]) then
      begin
         GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
         Result := True;
         Break;
      end;
   end;
end;

procedure TSWNBaseMDIChild.CloneRecord;
begin
  // se apelează când se apasă butonul Clone Document
end;

procedure TSWNBaseMDIChild.CloseExternalData;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.CloseExternalData(dataSources);
end;

procedure TSWNBaseMDIChild.CopyGridCellTextToClipboard(const Grid: TcxGridTableView; AOnlyCellValue: boolean);
var
   RecordIndex: Integer;
   i, j: Integer;
   MS: TStringList;
   S: string;
   AColumn: TcxGridDBColumn;
   GoodsID: Integer;
   GoodsQTY: Double;
begin
   MS := TStringList.Create;
   try
      for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
      begin
         GoodsID := -1;
         RecordIndex := Grid.Controller.SelectedRecords[I].RecordIndex;
         if Assigned(TcxGridDBColumn(Grid.Controller.FocusedColumn)) and
            (TcxGridDBColumn(Grid.Controller.FocusedColumn).DataBinding.FieldName = 'GOODS_NAME') then
         begin
            for j := 0 to Grid.ColumnCount - 1 do
            begin
               AColumn := TcxGridDBTableView(Grid).Columns[j];
               if AColumn.DataBinding.Field.FieldName = 'GOODSID' then
               begin
                  GoodsID := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).toInteger;
               end;
               if AColumn.DataBinding.Field.FieldName = 'QTY' then
               begin
                  GoodsQTY := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).ToDouble;
                  Break;
               end;
            end;
         end;
         if AOnlyCellValue then
            GoodsID := -1;
         if GoodsID > -1 then
         begin
            S := GoodsQTY.ToString + ' #' + GoodsID.ToString + '- ' +
                 Copy(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index), 1, 48);
         end
         else
            S := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
         if s <> '' then
            MS.Add(S);
      end;
      Clipboard.AsText := Trim(ms.Text);
   finally
      MS.Free;
   end;
end;

constructor TSWNBaseMDIChild.Create(AOwner: TComponent);
var
   qtyDigitsMode: Integer;
begin
   inherited;

   // Setare pentru MDI Child
   FormStyle := fsMDIChild;
   Position := poDefault;
   WindowState := wsMaximized;

   if (csDesigning in ComponentState) then
   begin
      Width := 1300;
      Height := 890;
   end;

   fDefaultValue := -1;
   fFilter_DateStart := 0;
   fFilter_DateEnd := 0;
   fFilter_CustomerID := 0;
   fFilter_GoodsID := 0;
   fFilter_StockID := 0;
   FOnCustomPrintSetupReportParams := nil;

   qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
   fQtyDisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
   fQtyReplaceMask := Format(cQTY_DigitsMask2[qtyDigitsMode], [FormatSettings.DecimalSeparator]);

   fFrameID := InitFrameID;
   SetupSecurityItems;
   fFilterFields := GetFilterFields;
   fFrameButtons := GetFrameButtons;
   SetupFont;

   RegisterForm(Self);

   if not SWNSecurityManager.IsPartialAccessMode then
      ReadFormStates;
end;

procedure TSWNBaseMDIChild.CreateNewRecord;
begin
  // se apelează când se apasă butonul New Document
end;

procedure TSWNBaseMDIChild.DeleteRecord;
begin
  // se apelează când se apasă butonul Delete Document
end;

destructor TSWNBaseMDIChild.Destroy;
begin
   try
      if not SWNSecurityManager.IsPartialAccessMode then
         SaveFormStates;
      UnRegisterForm(Self);
   finally
      inherited;
   end;
end;

function TSWNBaseMDIChild.GetPhoneNumber: string;
begin
  // se apelează când s-a apăsat butonul Apelează
  Result := '';
end;

function TSWNBaseMDIChild.InitFrameID: Integer;
begin
  // indicăm numărul formularului
   Result := -1;
end;

function TSWNBaseMDIChild.LocateDocument(const DocID: Integer): Boolean;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   Result := False;
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      Result := dmDB.LocateExternalDataDoc(dataSources, DocID);
end;

procedure TSWNBaseMDIChild.ModifyRecord;
begin
  // se apelează când s-a apăsat butonul Edit Document
end;

procedure TSWNBaseMDIChild.OpenExternalData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
   dataSources: TFrameExternalDataSourceSet;
begin
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.OpenExternalData(dataSources, FrameDataFilterInfo);
end;

procedure TSWNBaseMDIChild.ShowForeignGoodsCodesDialog(GoodsID: integer);
var
   dialog: TfrmGoodsForeignCodeDlg;
begin
   dialog := TfrmGoodsForeignCodeDlg.Create(Self);
   try
      dialog.GoodsID := GoodsID;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

function TSWNBaseMDIChild.CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: Integer): Boolean;
var
   i: Integer;
   col: TcxGridDBColumn;
begin
   DT := -1;
   CT := -1;
   for i := 0 to Grid.ColumnCount - 1 do
      if Grid.Columns[i] is TcxGridDBColumn then
      begin
         col := Grid.Columns[i];
         if col.DataBinding.FieldName = 'DT' then
         begin
            if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
               DT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
         end
         else if (col.DataBinding.FieldName = 'CT') or (col.DataBinding.FieldName = 'CUSTOMERID') then
         begin
            if VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index]) then
               CT := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, Grid.Columns[i].Index];
         end;
      end;
   Result := (DT <> -1) or (CT <> -1)
end;

procedure TSWNBaseMDIChild.ReadFormStates;
begin
  // citim stările sau opțiunile formularului
end;

procedure TSWNBaseMDIChild.ReadGridColumnsSettings(const Grid: TcxGridTableView);
begin
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(Grid);
end;

procedure TSWNBaseMDIChild.RefreshData;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.RefreshExternalData(dataSources);
end;

procedure TSWNBaseMDIChild.DoButtonClick(const ButtonType: TFrameButtonType);
begin
   case ButtonType of
      fbtADD: CreateNewRecord;
      fbtMODIFY: ModifyRecord;
      fbtDELETE: DeleteRecord;
      fbtCLONE: CloneRecord;
      fbtREFRESH: RefreshData;
   end;
end;

function TSWNBaseMDIChild.DocumentDefaultFilter: TFrameDocumentDateFilter;
begin
   Result := cDocumentDefaultFilter;
end;

procedure TSWNBaseMDIChild.DoDocumentDoubleClick;
begin
   ModifyRecord;
end;

procedure TSWNBaseMDIChild.DoFormHide;
begin
  // Ascunderea formularului MDI Child
end;

procedure TSWNBaseMDIChild.DoFormShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  // Afișarea formularului MDI Child
end;

procedure TSWNBaseMDIChild.FindDocument(const DocID: Integer);
var
   DT, TabIndex: Integer;
   DocData: TDateTime;
begin
   if dmDB.GetDocumentGotoInfo(DocID, DT, TabIndex, DocData) then
   begin
      SWNFormManager.GoToFormEx(TabIndex, DocID, DocData);
   end;
end;

procedure TSWNBaseMDIChild.FindParentDocument(const DocID: Integer);
var
   DT, ParentDocID, TabIndex: Integer;
   DocData: TDateTime;
begin
   if dmDB.GetDocumentParentInfo(DocID, DT, ParentDocID, TabIndex, DocData) then
   begin
      SWNFormManager.GoToFormEx(TabIndex, ParentDocID, DocData);
   end;
end;

function TSWNBaseMDIChild.GetCurrentSearchContext: TSearchContextValue;
begin
   Result.Context := ffNone;
   Result.ValueInt := 0;
   Result.ValueStr := '';
end;

function TSWNBaseMDIChild.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
   Result := [fedsNONE];
end;

function TSWNBaseMDIChild.GetFilterFields: TFrameFilterFields;
begin
   Result := [ffDate];
end;

function TSWNBaseMDIChild.GetFrameButtons: TFrameButtons;
begin
   Result := [fbtADD, fbtMODIFY, fbtDELETE, fbtREFRESH, fbtDial];
end;

procedure TSWNBaseMDIChild.GetParamsListForReport(const ParamsList: TStringList);
begin
  // arătăm ce parametri poate dispune raportul
end;

function TSWNBaseMDIChild.GetParamValueForReport(const ParamName: string): Variant;
begin
  // întoarcem valoarea parametrului pentru raport
end;

procedure TSWNBaseMDIChild.SaveFormStates;
begin
  // salvăm stările sau opțiunile formularului
end;

procedure TSWNBaseMDIChild.SaveGridColumnsSettings(const Grid: TcxGridTableView);
begin
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(Grid);
end;

procedure TSWNBaseMDIChild.SetDefaultValue(const Value: Integer);
begin
   fDefaultValue := Value;
end;

procedure TSWNBaseMDIChild.SetFilter(const StarDate, EndDate: TDateTime; const CustomerID, GoodsID, StockID: Integer);
begin
  // salvăm valorile pentru utilizare ulterioară
end;

procedure TSWNBaseMDIChild.SetOnCustomPrintSetupReportParams(const Value: TOnCustomPrintSetupReportParams);
begin
   FOnCustomPrintSetupReportParams := Value;
end;

procedure TSWNBaseMDIChild.SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
begin
   FOnShowPrintDialog := Value;
end;

procedure TSWNBaseMDIChild.SetupDefaultFocus;
begin
  // după ce se arată formularul, se setează focus-ul implicit
end;

procedure TSWNBaseMDIChild.SetupDefaultView;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.LocateOnLastRecord(dataSources);
end;

procedure TSWNBaseMDIChild.SetupFont;
begin
  // setare font
end;

procedure TSWNBaseMDIChild.SetupSecurityItems;
begin
  // pentru clase derivate
end;

procedure TSWNBaseMDIChild.ShowCopyGridContent(const Grid: TcxGridDBTableView);
var
   dialog: TfrmBSToolsCopyGridClipboardDlg;
begin
   dialog := TfrmBSToolsCopyGridClipboardDlg.Create(Self);
   try
      dialog.Grid := Grid;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowPricingRulesDialog(const Grid: TcxGridDBTableView; GoodsID: integer);
var
   ibcConnection: TIBCConnection;
   dialog: TfrmPriceTypesDlg;
begin
   IBCConnection := TIBCQuery(Grid.DataController.DataSet).Connection;
   dialog := TfrmPriceTypesDlg.Create(Self, ibcConnection);
   try
      dialog.GoodsID := GoodsID;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowCustomersBrowser(const CustomerID: Integer);
var
   dialog: TfrmCustomersDlg;
begin
   dialog := TfrmCustomersDlg.Create(Self);
   try
      dialog.CustomerID := CustomerID;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

function TSWNBaseMDIChild.ShowDocumentCommentsDialog(const DocID: Integer): Boolean;
var
   dialog: TfrmDocumentCommentsV2Dlg;
begin
   Result := False;
   dialog := TfrmDocumentCommentsV2Dlg.Create(Self);
   try
      dialog.DocID := DocID;
      if dialog.ShowModal = mrOk then
      begin
         Result := True;
         if dmDB.IBCQueryDocComments.Active then
            dmDB.IBCQueryDocComments.Refresh;
      end;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowDocumentExplorer(const DocID: Integer);
var
   dialog: TfrmDocumentInspectorDlg;
begin
   dialog := TfrmDocumentInspectorDlg.Create(Self);
   try
      dialog.DocID := DocID;
      if dialog.ShowModal = mrYes then
         frmMainForm.GotoDocument(dialog.GotoDocID, dialog.DocumentTarget);
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowGoodsBrowser(const GoodsID: Integer);
var
   dialog: TfrmGoodsBrowser;
begin
   dialog := TfrmGoodsBrowser.Create(Self);
   try
      dialog.GoodsID := GoodsID;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowPrintDialog;
begin
   if Assigned(FOnShowPrintDialog) then
      FOnShowPrintDialog(fFrameID);
end;

procedure TSWNBaseMDIChild.ShowQuickInfoCustomers(const DT, CT: Integer);
var
   dialog: TfrmQuickCustomerInfoDlg;
begin
   dialog := TfrmQuickCustomerInfoDlg.Create(Self);
   try
      dialog.DT := DT;
      dialog.CT := CT;
      if dialog.ShowModal = mrOk then
         ShowCustomersBrowser(dialog.CustomerIDToOpen);
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.ShowQuickInfoDialog(const GoodsID: Integer);
var
   dialog: TfrmGoodsQuickInfoDlg;
begin
   dialog := TfrmGoodsQuickInfoDlg.Create(Self);
   try
      dialog.GoodsID := GoodsID;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseMDIChild.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
OpenExternalData(FrameDataFilterInfo);
end;
{ TSWNFormManager }
constructor TSWNFormManager.Create;
begin
fFormList := TList.Create;
fCurrentDisplayForm := nil;
fMDIParentForm := nil;
fOnRequiredFormNotFound := nil;
FOnButtonStateChanged := nil;
FOnGotoForm := nil;
end;
destructor TSWNFormManager.Destroy;
begin
fFormList.Free;
inherited;
end;
procedure TSWNFormManager.DoButtonClick(const ButtonType: TFrameButtonType);
begin
if Assigned(fCurrentDisplayForm) then
fCurrentDisplayForm.DoButtonClick(ButtonType);
end;
procedure TSWNFormManager.FormButtonStateChanged(const Form: TSWNBaseMDIChild; const Button: TFrameButtonType;
const ButtonEnabled: Boolean);
begin
if Assigned(FOnButtonStateChanged) then
FOnButtonStateChanged(Button, ButtonEnabled);
end;
procedure TSWNFormManager.FormDataFilterChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
if Assigned(fCurrentDisplayForm) then
fCurrentDisplayForm.WhenFilterDataChanged(FrameDataFilterInfo);
end;
function TSWNFormManager.FormIDExists(const FrameID: Integer): Boolean;
var
i: Integer;
tmpForm: TSWNBaseMDIChild;
begin
Result := False;
for i := 0 to fFormList.Count - 1 do
begin
tmpForm := TSWNBaseMDIChild(fFormList[i]);
if Assigned(tmpForm) and (tmpForm.fFrameID = FrameID) then
begin
Result := True;
Break;
end;
end;
end;
function TSWNFormManager.GetFormByID(const FrameID: Integer): TSWNBaseMDIChild;
var
i: Integer;
tmpForm: TSWNBaseMDIChild;
begin
Result := nil;
for i := 0 to fFormList.Count - 1 do
begin
tmpForm := TSWNBaseMDIChild(fFormList[i]);
if Assigned(tmpForm) and (tmpForm.fFrameID = FrameID) then
begin
Result := tmpForm;
Break;
end;
end;
end;
function TSWNFormManager.GetFormNumberToDial: string;
begin
if Assigned(fCurrentDisplayForm) then
Result := fCurrentDisplayForm.GetPhoneNumber;
end;
function TSWNFormManager.GoToForm(const FrameID: Integer; const Value: Integer): TSWNBaseMDIChild;
var
FormFound: Boolean;
begin
Result := nil;
if Assigned(FOnGotoForm) then
begin
FormFound := False;
FOnGotoForm(FrameID, Value, FormFound);
if FormFound then
Result := fCurrentDisplayForm;
end;
end;
function TSWNFormManager.GoToFormEx(const FrameID, Value: Integer; const DocDate: TDateTime): TSWNBaseMDIChild;
var
FormFound: Boolean;
begin
Result := nil;
if Assigned(FOnGotoFormEx) then
begin
FormFound := False;
FOnGotoFormEx(FrameID, Value, DocDate, FormFound);
if FormFound then
Result := fCurrentDisplayForm;
end;
end;
procedure TSWNFormManager.HideCurrentForm;
begin
if fCurrentDisplayForm <> nil then
begin
try
fCurrentDisplayForm.DoFormHide;
fCurrentDisplayForm.Hide;
finally
fCurrentDisplayForm := nil;
end;
end;
end;
procedure TSWNFormManager.RegisterForm(const CustomForm: TSWNBaseMDIChild);
begin
if FormIDExists(CustomForm.FrameID) then
raise Exception.Create('Another form with the same FrameID already registered! FrameID=' + IntToStr(CustomForm.FrameID))
else
begin
CustomForm.OnShowPrintDialog := FOnShowPrintDialog;
fFormList.Add(CustomForm);
end;
end;
procedure TSWNFormManager.SetMDIParentForm(const Value: TForm);
begin
fMDIParentForm := Value;
end;
procedure TSWNFormManager.SetOnButtonStateChanged(const Value: TOnButtonStateChanged);
begin
FOnButtonStateChanged := Value;
end;
procedure TSWNFormManager.SetOnFormShow(const Value: TOnFormShow);
begin
FOnFormShow := Value;
end;
procedure TSWNFormManager.SetOnGotoForm(const Value: TOnGotoForm);
begin
FOnGotoForm := Value;
end;
procedure TSWNFormManager.SetOnGotoFormEx(const Value: TOnGotoFormEx);
begin
FOnGotoFormEx := Value;
end;
procedure TSWNFormManager.SetOnRequiredFormNotFound(const Value: TOnRequiredFormNotFound);
begin
fOnRequiredFormNotFound := Value;
end;
procedure TSWNFormManager.SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
begin
FOnShowPrintDialog := Value;
end;
function TSWNFormManager.SwitchToForm(const FrameID: Integer; const FrameDataFilterInfo:
TFrameDataFilteringInfo; const Value: Integer): TSWNBaseMDIChild;
var
i: Integer;
tmpForm: TSWNBaseMDIChild;
found: Boolean;
localFrameDataFilterInfo: TFrameDataFilteringInfo;
begin
Result := nil;
if not Assigned(fMDIParentForm) then
raise Exception.Create('MDI Parent form is not assigned!');
// Căutăm formularul existent
found := False;
for i := 0 to fFormList.Count - 1 do
begin
tmpForm := TSWNBaseMDIChild(fFormList[i]);
if (tmpForm.fFrameID = FrameID) then
begin
// Dacă formularul există deja, îl activăm
if tmpForm.Visible then
begin
tmpForm.BringToFront;
fCurrentDisplayForm := tmpForm;
Result := tmpForm;
Exit;
end;
     // Dacă formularul există dar nu e vizibil, îl arătăm
     fCurrentDisplayForm := tmpForm;
     found := True;
     Result := tmpForm;

     localFrameDataFilterInfo := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
     try
        localFrameDataFilterInfo.AdjustToFrameFilters(tmpForm.GetFilterFields);
        tmpForm.DefaultValue := Value;
        tmpForm.Show;
        tmpForm.DoFormShow(FrameDataFilterInfo);
     finally
        localFrameDataFilterInfo.Free;
     end;

     if Assigned(FOnFormShow) then
        FOnFormShow(fCurrentDisplayForm);

     Break;
  end;
end;
// Dacă nu am găsit formularul, încercăm să-l creăm
if not found then
begin
if Assigned(fOnRequiredFormNotFound) then
begin
tmpForm := nil;
fOnRequiredFormNotFound(FrameID, tmpForm);
     if Assigned(tmpForm) and (fFormList.IndexOf(tmpForm) >= 0) then
     begin
        Result := tmpForm;
        fCurrentDisplayForm := tmpForm;

        localFrameDataFilterInfo := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
        try
           localFrameDataFilterInfo.AdjustToFrameFilters(tmpForm.GetFilterFields);
           tmpForm.DefaultValue := Value;
           tmpForm.Show;
           tmpForm.DoFormShow(FrameDataFilterInfo);
        finally
           localFrameDataFilterInfo.Free;
        end;

        if Assigned(FOnFormShow) then
           FOnFormShow(fCurrentDisplayForm);
     end;
  end;
end;
end;

procedure TSWNFormManager.UnRegisterForm(const CustomForm: TSWNBaseMDIChild);
begin
fFormList.Remove(CustomForm);
end;

initialization
SWNFormManager := TSWNFormManager.Create;

finalization
if Assigned(SWNFormManager) then
FreeAndNil(SWNFormManager);

end.
