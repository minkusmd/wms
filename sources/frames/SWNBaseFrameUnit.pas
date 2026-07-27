unit SWNBaseFrameUnit;

interface

uses
  Classes, Controls, Forms, IBC, SWNDataFiltering, SWNDocumentFilters, cxCustomData, cxGridCustomTableView,
  cxGridDBTableView, cxGridTableView, dxBar, frmPrintEngineWindow,
  Data.DB,
  System.Types;

type

  // Button types
   TFrameButtonType = (fbtADD, fbtMODIFY, fbtDELETE, fbtCLONE, fbtREFRESH, fbtDial, fbtOpenDocument, fbtCloseDocument);

   TFrameButtons = set of TFrameButtonType;

   TOnCustomPrintSetupReportParams = procedure(const ReportParams: TReportParamsList) of object;

   TSearchContextValue = record
      Context: TFrameFilterField;
      ValueInt: Integer;
      ValueStr: string;
      ValueDateTime: TDateTime;
   end;

   TOnShowPrintDialog = procedure(const FrameID: Integer) of object;

   TOnDocumentEvent = procedure(const DocID: Integer) of object;

   TSWNBaseFrame = class(TFrame)
   private
      FbbCloseDocument: TdxBarButton;
      FbbOpenDocument: TdxBarButton;
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
      procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); virtual;
      procedure DoFrameHide; virtual;
      procedure DoButtonClick(const ButtonType: TFrameButtonType); virtual;
      procedure DoDocumentDoubleClick; virtual;
      procedure CreateNewRecord; virtual;
      procedure ModifyRecord; virtual;
      procedure DeleteRecord; virtual;
      procedure RefreshData; virtual;
      procedure CloneRecord; virtual;
      function GetPhoneNumber: string; virtual;

      procedure DoCloseDocument(const DocID: Integer); virtual;
      procedure DoOpenDocument(const DocID: Integer); virtual;
      procedure SetCloseDocumentEnabled(AEnabled: boolean);
      procedure SetOpenDocumentEnabled(AEnabled: boolean);

      procedure ButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
      procedure ReadFrameStates; virtual;
      procedure SaveFrameStates; virtual;
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
// TODO: ProcessCommonKeys
//    function ProcessCommonKeys(const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState; AOnlyCellValue: boolean = False):
//        Boolean;
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

    // new! arata din care sursa de date se iau documentele pentru acest frame
      function DocumentDefaultFilter: TFrameDocumentDateFilter; virtual;
      procedure SetFilter(const StarDate, EndDate: TDateTime; const CustomerID, GoodsID, StockID: Integer); virtual;
      procedure GetParamsListForReport(const ParamsList: TStringList); virtual;
      function GetParamValueForReport(const ParamName: string): Variant; virtual;
      function LocateDocument(const DocID: Integer): Boolean; virtual;
      procedure SetupDefaultView; virtual;
      procedure SetupDefaultFocus; virtual;
      function GetCurrentSearchContext: TSearchContextValue; virtual;


      property FrameID: Integer read fFrameID;
      property FilterFields: TFrameFilterFields read fFilterFields;
      property FrameButtons: TFrameButtons read fFrameButtons;


      property DefaultValue: Integer read fDefaultValue write SetDefaultValue;
      property OnCustomPrintSetupReportParams: TOnCustomPrintSetupReportParams read
         FOnCustomPrintSetupReportParams write SetOnCustomPrintSetupReportParams;
      property OnShowPrintDialog: TOnShowPrintDialog read FOnShowPrintDialog write SetOnShowPrintDialog;
      property bbCloseDocument: TdxBarButton read FbbCloseDocument write
          FbbCloseDocument;
      property bbOpenDocument: TdxBarButton read FbbOpenDocument write
          FbbOpenDocument;

      property QtyReplaceMask: string read fQtyReplaceMask;
      property QtyDisplayFormat: string read fQtyDisplayFormat;
   end;


  // SWNFrameManager

   TOnRequiredFrameNotFound = procedure(const RequiredFrameID: Integer; var NewCustomFrame: TSWNBaseFrame) of object;

   TOnFrameShow = procedure(const ShownFrame: TSWNBaseFrame) of object;

   TOnButtonStateChanged = procedure(const Button: TFrameButtonType; const ButtonEnabled: Boolean) of object;

   TOnGotoFrame = procedure(const FrameID: Integer; const Value: Integer; var FrameFound: Boolean) of object;

   TOnGotoFrameEx = procedure(const FrameID: Integer; const Value: Integer; const DocDate: TDateTime; var
      FrameFound: Boolean) of object;

   TSWNFrameManager = class
   private
    { Private declarations }
      fFrameList: TList;
      fCurrentDisplayFrame: TSWNBaseFrame;
      fFrameParentControl: TWinControl;
      fOnRequiredFrameNotFound: TOnRequiredFrameNotFound;
      FOnFrameShow: TOnFrameShow;
      FOnButtonStateChanged: TOnButtonStateChanged;
      FOnGotoFrame: TOnGotoFrame;
      FOnGotoFrameEx: TOnGotoFrameEx;
      FOnShowPrintDialog: TOnShowPrintDialog;
      procedure SetFrameParentControl(const Value: TWinControl);
      function FrameIDExists(const FrameID: Integer): Boolean;
      procedure SetOnRequiredFrameNotFound(const Value: TOnRequiredFrameNotFound);
      procedure SetOnFrameShow(const Value: TOnFrameShow);
      procedure SetOnButtonStateChanged(const Value: TOnButtonStateChanged);
      procedure FrameButtonStateChanged(const Frame: TSWNBaseFrame; const Button: TFrameButtonType; const
         ButtonEnabled: Boolean);
      procedure SetOnGotoFrame(const Value: TOnGotoFrame);
      procedure SetOnGotoFrameEx(const Value: TOnGotoFrameEx);
      procedure SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
   public
    { Public declarations }
      constructor Create;
      destructor Destroy; override;
      property FrameParentControl: TWinControl read fFrameParentControl write SetFrameParentControl;
      property CurrentFrame: TSWNBaseFrame read fCurrentDisplayFrame;
      procedure RegisterFrame(const CustomFrame: TSWNBaseFrame);
      procedure UnRegisterFrame(const CustomFrame: TSWNBaseFrame);
      function SwitchToFrame(const FrameID: Integer; const FrameDataFilterInfo: TFrameDataFilteringInfo; const
         Value: Integer): TSWNBaseFrame;
      function GoToFrame(const FrameID: Integer; const Value: Integer = -1): TSWNBaseFrame;
      function GoToFrameEx(const FrameID: Integer; const Value: Integer; const DocDate: TDateTime): TSWNBaseFrame;
      procedure HideCurrentFrame;
      procedure DoButtonClick(const ButtonType: TFrameButtonType);

      function GetFrameByID(const FrameID: Integer): TSWNBaseFrame;
      function GetFrameNumberToDial: string;
      property OnRequiredFrameNotFound: TOnRequiredFrameNotFound read fOnRequiredFrameNotFound write
         SetOnRequiredFrameNotFound;
      property OnFrameShow: TOnFrameShow read FOnFrameShow write SetOnFrameShow;
      property OnButtonStateChanged: TOnButtonStateChanged read FOnButtonStateChanged write SetOnButtonStateChanged;
      property OnGotoFrame: TOnGotoFrame read FOnGotoFrame write SetOnGotoFrame;
      property OnGotoFrameEx: TOnGotoFrameEx read FOnGotoFrameEx write SetOnGotoFrameEx;
      property OnShowPrintDialog: TOnShowPrintDialog read FOnShowPrintDialog write SetOnShowPrintDialog;

      procedure DoCloseDocument(DOCID: Integer); virtual;
      procedure DoOpenDocument(DOCID: Integer); virtual;

    // 07.04.2014
      procedure FrameDataFilterChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
   end;

const
   cFrameButtonsSet_BasicButtons =[fbtADD, fbtMODIFY, fbtDELETE, fbtREFRESH];
   cFrameButtonsSet_AllButtons =[fbtADD, fbtMODIFY, fbtDELETE, fbtCLONE, fbtREFRESH];

var
   SWNFrameManager: TSWNFrameManager;

implementation

uses
   SysUtils, SWNConst, SWNValueStorageUnit, SWNUtils, DataModuleDB, ClipBrd, Dialogs, frmGoods, Variants,
   frmGoodsQuickInfoDialog, frmQuickCustomerInfoDialog, frmCustomersDlg, SWNSecurity,
   frmDocumentCommentsV2Dialog, frmDocumentInspectorDialog, frmBSToolsCopyGridClipboardDialog, MainForm,
   SWNCommonDialogs, frmPriceTypesUnit, frmGoodsForeignCodeDialog;

{$R *.dfm}

procedure RegisterFrame(const CustomFrame: TSWNBaseFrame);
begin
   if Assigned(SWNFrameManager) then
      SWNFrameManager.RegisterFrame(CustomFrame);
end;

procedure UnRegisterFrame(const CustomFrame: TSWNBaseFrame);
begin
   if Assigned(SWNFrameManager) then
      SWNFrameManager.UnRegisterFrame(CustomFrame);
end;

{ TSWNBaseFrame }

procedure TSWNBaseFrame.ButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
begin
   SWNFrameManager.FrameButtonStateChanged(Self, Button, ButtonEnabled);
end;

function TSWNBaseFrame.CheckGridForCTField(const Grid: TcxGridDBTableView; var CT: Integer): Boolean;
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

function TSWNBaseFrame.CheckGridForDocIDValue(const Grid: TcxGridDBTableView; var DocID: Integer): Boolean;
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

function TSWNBaseFrame.CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
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

procedure TSWNBaseFrame.CloneRecord;
begin
  // se kiama atunci kind se apasa butonul Clone Document
end;

procedure TSWNBaseFrame.CloseExternalData;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.CloseExternalData(dataSources);
end;

procedure TSWNBaseFrame.CopyGridCellTextToClipboard(const Grid: TcxGridTableView; AOnlyCellValue: boolean);
var
   RecordIndex: Integer;
   i, j: Integer;
   MS: TStringList;
   S: string;
   AColumn: TcxGridDBColumn;
   GoodsID: Integer;
   GoodsQTY: Double;
//  UM_NAME: string;
begin
   MS := TStringList.Create;
   try
      for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
      begin
         // multiple cells selected
         GoodsID := -1;

         RecordIndex := Grid.Controller.SelectedRecords[I].RecordIndex;

         if Assigned(TcxGridDBColumn(Grid.Controller.FocusedColumn)) and (TcxGridDBColumn(Grid.Controller.FocusedColumn).DataBinding.FieldName = 'GOODS_NAME') then
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
            S := GoodsQTY.ToString + ' #' + GoodsID.ToString + '- ' + Copy(Grid.DataController.GetDisplayText(RecordIndex,
               Grid.Controller.FocusedColumn.Index), 1, 48);
         end
         else
            S := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
         if s <>'' then
            MS.Add(S); // append to collection formated row
      end;

      Clipboard.AsText := Trim(ms.Text);
   finally
      MS.Free;
   end;
end;

constructor TSWNBaseFrame.Create(AOwner: TComponent);
var
//  QtyDisplayFormat: string;
  qtyDigitsMode: Integer;
//  QtyReplaceMask: string;

begin
   inherited;

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

  // Numarul de zecimale in QTY :
   qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
   fQtyDisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
   fQtyReplaceMask := Format(cQTY_DigitsMask2[qtyDigitsMode], [FormatSettings.DecimalSeparator]);

   fFrameID := InitFrameID;

   SetupSecurityItems;

   fFilterFields := GetFilterFields;
   fFrameButtons := GetFrameButtons;

   SetupFont;

   RegisterFrame(Self);

   if not SWNSecurityManager.IsPartialAccessMode then
      ReadFrameStates;
end;

procedure TSWNBaseFrame.CreateNewRecord;
begin
  // se kiama kind se apasa butonul New Document
end;

procedure TSWNBaseFrame.DeleteRecord;
begin
  // se kiama kind se apasa butonul Delete Document
end;

destructor TSWNBaseFrame.Destroy;
begin
   try
      if not SWNSecurityManager.IsPartialAccessMode then
         SaveFrameStates;
      UnRegisterFrame(Self);
   finally
      inherited;
   end;
end;

function TSWNBaseFrame.GetPhoneNumber;
begin
  // se kiama atunci kind s-a apasat butinul Apeleaza
end;

function TSWNBaseFrame.InitFrameID: Integer;
begin
  // indicam numarul Frame-ului
   Result := -1;
end;

function TSWNBaseFrame.LocateDocument(const DocID: Integer): Boolean;
var
   dataSources: TFrameExternalDataSourceSet;
begin
   Result := False;

   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      Result := dmDB.LocateExternalDataDoc(dataSources, DocID);

  // LocateDocument() nu se chiama, daca se chiama SetupDefaultView() si invers
end;

procedure TSWNBaseFrame.ModifyRecord;
begin
  // se kiama atunci kind s-a apasat butinul Edit Document
end;

procedure TSWNBaseFrame.OpenExternalData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
   dataSources: TFrameExternalDataSourceSet;
begin
  // deschide sursele de date externe conform "GetExternalDataSourceTypes"
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.OpenExternalData(dataSources, FrameDataFilterInfo);
end;

procedure TSWNBaseFrame.ShowForeignGoodsCodesDialog(GoodsID: integer);
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

function TSWNBaseFrame.CheckGridForCustomerFields(const Grid: TcxGridDBTableView; var DT, CT: Integer): Boolean;
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


// TODO: ProcessCommonKeys
//function TSWNBaseFrame.ProcessCommonKeys(const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState; AOnlyCellValue: boolean): Boolean;
//var
// GoodsID: Integer;
// DT, CT, DocID: Integer;
//begin
// Result := False;
//
// // Ctrl+Z
// if ((Key = 122) or (Key=90)) and (Shift = [ssCtrl]) then
// begin
//    if CheckGridForGoodsIDValue(Grid, GoodsID) then
//       ShowForeignGoodsCodesDialog(GoodsID);
//
//    Key := 0;
//    Shift := [];
//    Result := True;
// end;
//
// // Alt+P - Politica de preturi
// if (Key = 112) and (Shift = [ssAlt]) then
// begin
//    if CheckGridForGoodsIDValue(Grid, GoodsID) then
//    ShowPricingRulesDialog(Grid, GoodsID);
//    Key := 0;
//    Shift := [];
//    Result := True;
// end;
//
//// Ctrl+Alt+C - Copy grid to buffer
// if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
// begin
//    ShowCopyGridContent(Grid);
// end
// else
//
//  // Ctrl+C
// if (Key = 67) and (Shift = [ssCtrl]) then
// begin
//    // copy cell content in clipboard
//    CopyGridCellTextToClipboard(Grid, AOnlyCellValue);
//    Key := 0;
//    Shift := [];
//    Result := True;
// end
// else
//    // Ctrl+Shift+T
//if (Key = 84) and (Shift = [ssCtrl, ssShift]) then
// begin
//    if CheckGridForGoodsIDValue(Grid, GoodsID) then
//       ShowGoodsBrowser(GoodsID);
// end
// else
//      // Ctrl+Shift+K
//if (Key = 75) and (Shift = [ssCtrl, ssShift]) then
// begin
//    if CheckGridForCustomerFields(Grid, DT, CT) then
//    begin
//       if CT <> -1 then
//          ShowCustomersBrowser(CT)
//       else
//          ShowCustomersBrowser(DT);
//    end;
// end
// else
//        // F1
//if (Key = 112) and (Shift = []) then
// begin
//    if CheckGridForGoodsIDValue(Grid, GoodsID) then begin
//       ShowQuickInfoDialog(GoodsID);
//    end
//    else if CheckGridForCustomerFields(Grid, DT, CT) then
//       ShowQuickInfoCustomers(DT, CT);
// end
// else
//          // F12 - Document Inspector
//if (Key = 123) and (Shift = []) then
// begin
//    if CheckGridForDocIDValue(Grid, DocID) then
//       ShowDocumentExplorer(DocID);
// end
// else
//            // TEST ONLY
//            // Ctrl+Shift+Q
//if (Key = 81) and (Shift = [ssCtrl, ssShift]) then
// begin
//    ShowInfoDialog('QTY Display Format', Format('Format: %s' + sLineBreak+ 'Number of digits: %d', [QtyDisplayFormat,
//       AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, -1)]));
// end
// else
// if (((Key = Ord('d')) or (Key = Ord('D'))) and (Shift = [ssCtrl])) then
// begin
//   if CheckGridForCTField(Grid, CT) then
//      TSWNCommonDialogs.CustomerDebts(CT);
// end;
//
//end;

procedure TSWNBaseFrame.ReadFrameStates;
begin
  // citim starile sau optiunile Frame-ului
end;

procedure TSWNBaseFrame.ReadGridColumnsSettings(const Grid: TcxGridTableView);
begin
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(Grid);
end;

procedure TSWNBaseFrame.RefreshData;
var
   dataSources: TFrameExternalDataSourceSet;
begin
  // Se kiama atunci kind se face Refresh in Frame
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.RefreshExternalData(dataSources);
end;

procedure TSWNBaseFrame.DoButtonClick(const ButtonType: TFrameButtonType);
begin
   case ButtonType of
      fbtADD:
         CreateNewRecord;
      fbtMODIFY:
         ModifyRecord;
      fbtDELETE:
         DeleteRecord;
      fbtCLONE:
         CloneRecord;
      fbtREFRESH:
         RefreshData;
   end;
end;

function TSWNBaseFrame.DocumentDefaultFilter: TFrameDocumentDateFilter;
begin
   Result := cDocumentDefaultFilter;
end;

procedure TSWNBaseFrame.DoDocumentDoubleClick;
begin
   ModifyRecord;
end;

procedure TSWNBaseFrame.DoFrameHide;
begin
  // Trecerea de la forma activa a Frame-ului la forma inactiva ( nu se vede pe ecran)
  // Ce trebuie sa faca Frame-u:
  // 1. Sa deconecteze sursele de date locale
  // 2. Altele
end;

procedure TSWNBaseFrame.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  // Trecerea de la forma inactiva la forma activa (de lucru) a Frame-ului
  // FrameDataFilterInfo - contine informatia de filtrare curenta setata in program, inclusiv:
  // 1. FirmaID - firma curenta
  // 2. DocTypeID - tipul documentului curent (optional)
  // Obiectul "FrameDataFilterInfo" urmeaza a fi mai departe prelucrat local sau se transmite in DataModule
  // daca sursele de date sunt acolo

  // La aceasta etapa se intimpla:
  // 1. Conectarea surselor de date spre utilizare
  // 2. Refresh la butoanele dependente de sursele de date
  // 3. Altele
end;

procedure TSWNBaseFrame.FindDocument(const DocID: Integer);
var
   DT, TabIndex: Integer;
   DocData: TDateTime;
begin
   if dmDB.GetDocumentGotoInfo(DocID, DT, TabIndex, DocData) then
   begin
      SWNFrameManager.GoToFrameEx(TabIndex, DocID, DocData);
   end;
end;

procedure TSWNBaseFrame.FindParentDocument(const DocID: Integer);
var
   DT, ParentDocID, TabIndex: Integer;
   DocData: TDateTime;
begin
   if dmDB.GetDocumentParentInfo(DocID, DT, ParentDocID, TabIndex, DocData) then
   begin
      SWNFrameManager.GoToFrameEx(TabIndex, ParentDocID, DocData);
   end;
end;

function TSWNBaseFrame.GetCurrentSearchContext: TSearchContextValue;
begin
   Result.Context := ffNone;
   Result.ValueInt := 0;
   Result.ValueStr := '';
end;

function TSWNBaseFrame.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  // se intarce lista sourselor de date externe
   Result := [fedsNONE];
end;

function TSWNBaseFrame.GetFilterFields: TFrameFilterFields;
begin
  // aratam de care optiuni de cautare are nevoie Frame-u
   Result := [ffDate];
end;

function TSWNBaseFrame.GetFrameButtons: TFrameButtons;
begin
  // aratam de care butoane are nevoie Frame-u
   Result := [fbtADD, fbtMODIFY, fbtDELETE, fbtREFRESH, fbtDial];
end;

procedure TSWNBaseFrame.GetParamsListForReport(const ParamsList: TStringList);
begin
  // aratam care parametri poate dispune raportul din acest Frame
end;

function TSWNBaseFrame.GetParamValueForReport(const ParamName: string): Variant;
begin
  // intoarcem valoarea parametrului pentru raport
end;

procedure TSWNBaseFrame.SaveFrameStates;
begin
  // salvam starile sau optiunile Frame-ului
end;

procedure TSWNBaseFrame.SaveGridColumnsSettings(const Grid: TcxGridTableView);
begin
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(Grid);
end;

procedure TSWNBaseFrame.SetCloseDocumentEnabled(AEnabled: boolean);
begin
  if Assigned(bbCloseDocument) then
    bbCloseDocument.Enabled := AEnabled;
end;

procedure TSWNBaseFrame.SetDefaultValue(const Value: Integer);
begin
   fDefaultValue := Value;
end;

procedure TSWNBaseFrame.SetFilter(const StarDate, EndDate: TDateTime; const CustomerID, GoodsID, StockID: Integer);
begin
  // save values for furthe usage
  // operatie necesara de facut de toate frame-urile
  // 1. De deconectat dela sura de date
end;

procedure TSWNBaseFrame.SetOnCustomPrintSetupReportParams(const Value: TOnCustomPrintSetupReportParams);
begin
   FOnCustomPrintSetupReportParams := Value;
end;

procedure TSWNBaseFrame.SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
begin
   FOnShowPrintDialog := Value;
end;

procedure TSWNBaseFrame.SetOpenDocumentEnabled(AEnabled: boolean);
begin

end;

procedure TSWNBaseFrame.DoCloseDocument(const DocID: Integer);
begin
  // se chiama cind se apasa F9
end;

procedure TSWNBaseFrame.DoOpenDocument(const DocID: Integer);
begin
  // se chiama cind se apasa Shift F9
end;

procedure TSWNBaseFrame.SetupDefaultFocus;
begin
  // dupa ce se arata frame, se seteaza focusu implicit
  // 1. FDefaultValue - indica daca este DocID de focusat
  // 2. se focuseaza gridu necesar
end;

procedure TSWNBaseFrame.SetupDefaultView;
var
   dataSources: TFrameExternalDataSourceSet;
begin
  // deschide sursele de date externe conform "GetExternalDataSourceTypes"
   dataSources := GetExternalDataSourceTypes;
   if (dataSources <> [fedsNONE]) and (dataSources <> []) then
      dmDB.LocateOnLastRecord(dataSources);

  // kind se arata frame-u si nu este necesar de cautat vre-un document
  // de exemplu: se pozitioneaza pe ultimu record

  // SetupDefaultView() nu se chiama, daca se chiama LocateDocument() si invers
  {
    if (DocumentSource<>fdsNone) and dmDB.IBCQueryDocs.Active then
    begin
    // allow to move on last record in dataset
    allow:=True;

    // pentru filtru de data "���", nu pozitionam la urma
    if (dmDB.CurrentDocumentFilter in [fdfNone,fdfAll]) then allow:=False;

    if allow then
    begin
    dmDB.IBCQueryDocs.DisableControls;
    try
    dmDB.IBCQueryDocs.Last;
    finally
    dmDB.IBCQueryDocs.EnableControls;
    end;
    end;
    end;
  }
end;

procedure TSWNBaseFrame.SetupFont;
begin
//   with cFontSizeItems[AppUserConfigStorage.IntValues.GetValue(cSETTINGS_UserFontSize, cAppDefaultFontIndex)] do
//   begin
//      Font.Name := FontName;
//      Font.Size := FontSize;
//   end;

end;

procedure TSWNBaseFrame.SetupSecurityItems;
begin
  // for children
end;

procedure TSWNBaseFrame.ShowCopyGridContent(const Grid: TcxGridDBTableView);
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

procedure TSWNBaseFrame.ShowPricingRulesDialog(const Grid: TcxGridDBTableView; GoodsID: integer);
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

procedure TSWNBaseFrame.ShowCustomersBrowser(const CustomerID: Integer);
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

function TSWNBaseFrame.ShowDocumentCommentsDialog(const DocID: Integer): Boolean;
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

procedure TSWNBaseFrame.ShowDocumentExplorer(const DocID: Integer);
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

procedure TSWNBaseFrame.ShowGoodsBrowser(const GoodsID: Integer);
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

procedure TSWNBaseFrame.ShowPrintDialog;
begin
   if Assigned(FOnShowPrintDialog) then
      FOnShowPrintDialog(fFrameID);
end;

procedure TSWNBaseFrame.ShowQuickInfoCustomers(const DT, CT: Integer);
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

procedure TSWNBaseFrame.ShowQuickInfoDialog(const GoodsID: Integer);
var
   dialog: TfrmGoodsQuickInfoDlg;
begin
   dialog := TfrmGoodsQuickInfoDlg.Create(Self);
   try
      dialog.GoodsID := GoodsID;
//      dialog.OnAddGoods2Jurnal := AddGoods2Jurnal;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TSWNBaseFrame.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
   OpenExternalData(FrameDataFilterInfo);
end;

{ TSWNBaseFrameManager }

constructor TSWNFrameManager.Create;
begin
   fFrameList := TList.Create;
   fCurrentDisplayFrame := nil;
   fFrameParentControl := nil;
   fOnRequiredFrameNotFound := nil;
   FOnButtonStateChanged := nil;
   FOnGotoFrame := nil;
end;

destructor TSWNFrameManager.Destroy;
begin
   fFrameList.Free;
   inherited;
end;

procedure TSWNFrameManager.DoButtonClick(const ButtonType: TFrameButtonType);
begin
   if Assigned(fCurrentDisplayFrame) then
      fCurrentDisplayFrame.DoButtonClick(ButtonType);
end;

procedure TSWNFrameManager.DoCloseDocument(DOCID: Integer);
begin
   if Assigned(fCurrentDisplayFrame) then
      fCurrentDisplayFrame.DoCloseDocument(DocID);
end;

procedure TSWNFrameManager.DoOpenDocument(DOCID: Integer);
begin
   if Assigned(fCurrentDisplayFrame) then
      fCurrentDisplayFrame.DoOpenDocument(DocID);
end;

procedure TSWNFrameManager.FrameButtonStateChanged(const Frame: TSWNBaseFrame; const Button: TFrameButtonType;
   const ButtonEnabled: Boolean);
begin
   if Assigned(FOnButtonStateChanged) then
      FOnButtonStateChanged(Button, ButtonEnabled);
end;

procedure TSWNFrameManager.FrameDataFilterChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
   if Assigned(fCurrentDisplayFrame) then
      fCurrentDisplayFrame.WhenFilterDataChanged(FrameDataFilterInfo);
end;

function TSWNFrameManager.FrameIDExists(const FrameID: Integer): Boolean;
var
   i: Integer;
   tmpFrame: TSWNBaseFrame;
begin
   Result := False;

   for i := 0 to fFrameList.Count - 1 do
   begin
      tmpFrame := TSWNBaseFrame(fFrameList[i]);
      if Assigned(tmpFrame) and (tmpFrame.fFrameID = FrameID) then
      begin
         Result := True;
         Break;
      end;
   end;
end;

function TSWNFrameManager.GetFrameByID(const FrameID: Integer): TSWNBaseFrame;
var
   i: Integer;
   tmpFrame: TSWNBaseFrame;
begin
   Result := nil;
   for i := 0 to fFrameList.Count - 1 do
   begin
      tmpFrame := TSWNBaseFrame(fFrameList[i]);
      if Assigned(tmpFrame) and (tmpFrame.fFrameID = FrameID) then
      begin
         Result := tmpFrame;
         Break;
      end;
   end;
end;

function TSWNFrameManager.GetFrameNumberToDial: string;
begin
   if Assigned(fCurrentDisplayFrame) then
      Result := fCurrentDisplayFrame.GetPhoneNumber;
end;

function TSWNFrameManager.GoToFrame(const FrameID: Integer; const Value: Integer): TSWNBaseFrame;
var
   FrameFound: Boolean;
begin
   Result := nil;
   if Assigned(FOnGotoFrame) then
   begin
      FrameFound := False;
      FOnGotoFrame(FrameID, Value, FrameFound);
      if FrameFound then
         Result := fCurrentDisplayFrame;
   end;
end;

function TSWNFrameManager.GoToFrameEx(const FrameID, Value: Integer; const DocDate: TDateTime): TSWNBaseFrame;
var
   FrameFound: Boolean;
begin
   Result := nil;
   if Assigned(FOnGotoFrameEx) then
   begin
      FrameFound := False;
      FOnGotoFrameEx(FrameID, Value, DocDate, FrameFound);
      if FrameFound then
         Result := fCurrentDisplayFrame;
   end;
end;

procedure TSWNFrameManager.HideCurrentFrame;
begin
   if fCurrentDisplayFrame <> nil then
   begin
      fCurrentDisplayFrame.Parent := nil;
      try
         fCurrentDisplayFrame.DoFrameHide;
      finally
         fCurrentDisplayFrame := nil;
      // if Assigned(FOnFrameShow) then FOnFrameShow(nil);
      end;
   end;
end;

procedure TSWNFrameManager.RegisterFrame(const CustomFrame: TSWNBaseFrame);
begin
   if FrameIDExists(CustomFrame.FrameID) then
      Exception.Create('Another frame with the same FrameID already registered! FrameID=' + IntToStr(CustomFrame.FrameID))
   else
   begin
    // setup cemmon events
      CustomFrame.OnShowPrintDialog := FOnShowPrintDialog;
    // register
      fFrameList.Add(CustomFrame);
   end;
end;

procedure TSWNFrameManager.SetFrameParentControl(const Value: TWinControl);
begin
   fFrameParentControl := Value;
end;

procedure TSWNFrameManager.SetOnButtonStateChanged(const Value: TOnButtonStateChanged);
begin
   FOnButtonStateChanged := Value;
end;

procedure TSWNFrameManager.SetOnFrameShow(const Value: TOnFrameShow);
begin
   FOnFrameShow := Value;
end;

procedure TSWNFrameManager.SetOnGotoFrame(const Value: TOnGotoFrame);
begin
   FOnGotoFrame := Value;
end;

procedure TSWNFrameManager.SetOnGotoFrameEx(const Value: TOnGotoFrameEx);
begin
   FOnGotoFrameEx := Value;
end;

procedure TSWNFrameManager.SetOnRequiredFrameNotFound(const Value: TOnRequiredFrameNotFound);
begin
   fOnRequiredFrameNotFound := Value;
end;

procedure TSWNFrameManager.SetOnShowPrintDialog(const Value: TOnShowPrintDialog);
begin
   FOnShowPrintDialog := Value;
end;

function TSWNFrameManager.SwitchToFrame(const FrameID: Integer; const FrameDataFilterInfo:
   TFrameDataFilteringInfo; const Value: Integer): TSWNBaseFrame;
var
   i: Integer;
   tmpFrame: TSWNBaseFrame;
   found: Boolean;
   localFrameDataFilterInfo: TFrameDataFilteringInfo;
begin
  // Se schimba Frame-u curent
  // FrameID: id-ul intern a frame-ului
  // Value: id-ul documentului implicit pentru focusare la aratare

   Result := Nil;
   if not Assigned(fFrameParentControl) then
      raise Exception.Create('Parent control to display frames is not assigned!');

  // hide existing, if exists
   if Assigned(fCurrentDisplayFrame) then
   begin
      if fCurrentDisplayFrame.FrameID = FrameID then
      begin
         Result := fCurrentDisplayFrame;
         Exit;
      end
      else
         HideCurrentFrame;
   end;

  // find Frame to show
   found := False;
   for i := 0 to fFrameList.Count - 1 do
   begin
      tmpFrame := TSWNBaseFrame(fFrameList[i]);
      if (tmpFrame.fFrameID = FrameID) then
      begin
         fCurrentDisplayFrame := tmpFrame;
         found := True;
         Result := tmpFrame;

         localFrameDataFilterInfo := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
         try
        // ajustam valorile de filtrare cu filtrele la care se uita Frame-u
            localFrameDataFilterInfo.AdjustToFrameFilters(fCurrentDisplayFrame.GetFilterFields);

            tmpFrame.Parent := fFrameParentControl;
            tmpFrame.DefaultValue := Value;
            tmpFrame.DoFrameShow(FrameDataFilterInfo);
         finally
            localFrameDataFilterInfo.Free;
         end;

         if Assigned(FOnFrameShow) then
            FOnFrameShow(fCurrentDisplayFrame);
      end;
      if found then
         Break;
   end;

  // frame to found, ask for frame
   if not found then
   begin
      if Assigned(fOnRequiredFrameNotFound) then
      begin
         tmpFrame := nil;
      // attemp to create missing frame on the fly
         fOnRequiredFrameNotFound(FrameID, tmpFrame);
      // check if NewFrame valid and added in internal list
         if Assigned(tmpFrame) and (fFrameList.IndexOf(tmpFrame) >= 0) then
         begin
            Result := tmpFrame;
            tmpFrame.Parent := fFrameParentControl;
            fCurrentDisplayFrame := tmpFrame;

            localFrameDataFilterInfo := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
            try
          // ajustam valorile de filtrare cu filtrele la care se uita Frame-u
               localFrameDataFilterInfo.AdjustToFrameFilters(fCurrentDisplayFrame.GetFilterFields);

               tmpFrame.DefaultValue := Value;
               tmpFrame.DoFrameShow(FrameDataFilterInfo);
            finally
               localFrameDataFilterInfo.Free;
            end;

            if Assigned(FOnFrameShow) then
               FOnFrameShow(fCurrentDisplayFrame);
         end;
      end;
   end;
end;

procedure TSWNFrameManager.UnRegisterFrame(const CustomFrame: TSWNBaseFrame);
begin
   fFrameList.Remove(CustomFrame);
end;

initialization
   SWNFrameManager := TSWNFrameManager.Create;

finalization
   if Assigned(SWNFrameManager) then
      FreeAndNil(SWNFrameManager);

end.

