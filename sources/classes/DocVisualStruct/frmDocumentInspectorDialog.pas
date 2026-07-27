unit frmDocumentInspectorDialog;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  SWNBaseUnit,
  SWNSearchDocumentTypes,
  System.UITypes,
  IBC,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  DialogTitle,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridBandedTableView,
  cxGridCustomView,
  cxClasses,
  cxGridLevel,
  cxGrid,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  dxBar,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  cxNavigator,
  Vcl.ComCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxBarBuiltInMenu,
  dxDateRanges,
  dxScrollbarAnnotations;

const
  cOPTION_Bold = $01;
  cOPTION_COLOR_RED = $02;
  cOPTION_COLOR_GREEN = $04;
  cOPTION_COLOR_BLUE = $08;
  cOPTION_COLOR_YELLOW = $10;

type
  TColDBType = (ctString, ctInteger, ctFloat, ctDate, ctBoolean);

  TfrmDocumentInspectorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    Shape1: TShape;
    Shape3: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarManager1: TdxBarManager;
    bbGotoDocument: TdxBarButton;
    bbCopyValue: TdxBarButton;
    pnLoading: TPanel;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    bbGotoIncident: TdxBarButton;
    procedure cxGridTableColumnHeaderClick(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenu1Popup(Sender: TObject);
    procedure bbCopyValueClick(Sender: TObject);
    procedure bbGotoDocumentClick(Sender: TObject);
    procedure bbGotoIncidentClick(Sender: TObject);
  private
    { Private declarations }
    fDocID: integer;
    fGotoDocID: integer;
    FDocumentTarget: TSearchDocumentSearchTarget;

    procedure LoadData;
    procedure CreateHeaderColumn;
    procedure AddNewDefinitionRow(const SysName, Title: string; const DataType: TColDBType; const Options: Integer = 0);
    procedure ReadDocumentData2;
    procedure WhenNeedToReloadData(Sender: TObject);

    procedure WhenInitSql(const Query: TIBCQuery);
    procedure WhenGetResultSQL(const Query: TIBCQuery);
    procedure SetDocID(const Value: integer);

  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property DocumentTarget: TSearchDocumentSearchTarget read FDocumentTarget;
    property DocID: integer read fDocID write SetDocID;
    property GotoDocID: integer read fGotoDocID;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions,
  DataModuleDB,
  SWNUtils,
  SWNValueStorageUnit,
  ClipBrd,
  SQLThread;

{ TfrmDocumentInspectorDlg }

procedure TfrmDocumentInspectorDlg.AddNewDefinitionRow(const SysName, Title: string; const DataType: TColDBType; const
  Options: Integer);
var
  N: integer;
begin
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, 0] := SysName;
  cxGridTable.DataController.Values[N, 1] := DataType;
  cxGridTable.DataController.Values[N, 2] := Title;
  cxGridTable.DataController.Values[N, 3] := Options;
end;

procedure TfrmDocumentInspectorDlg.bbCopyValueClick(Sender: TObject);
var
  RecordIndex: integer;
begin
  RecordIndex := cxGridTable.DataController.GetRowInfo(cxGridTable.DataController.FocusedRowIndex).RecordIndex;
  Clipboard.asText := Trim(cxGridTable.DataController.GetDisplayText(RecordIndex, cxGridTable.Controller.FocusedColumn.Index));
end;

procedure TfrmDocumentInspectorDlg.bbGotoDocumentClick(Sender: TObject);
begin
  FDocumentTarget := sdstDoc;
  fGotoDocID := cxGridTable.DataController.Values[0, cxGridTable.Controller.FocusedColumn.Index];
  ModalResult := mrYes;
end;

procedure TfrmDocumentInspectorDlg.bbGotoIncidentClick(Sender: TObject);
begin
  FDocumentTarget := sdstIncident;
  fGotoDocID := cxGridTable.DataController.Values[32, cxGridTable.Controller.FocusedColumn.Index];
  ModalResult := mrYes;
end;

procedure TfrmDocumentInspectorDlg.CreateHeaderColumn;
var
  col: TcxGridColumn;
begin
     // create field name column
  col := cxGridTable.CreateColumn;
  col.Visible := False;
  col.VisibleForCustomization := False;

     // create field datatype column
  col := cxGridTable.CreateColumn;
  col.Visible := False;
  col.VisibleForCustomization := False;

     // create title column
  col := cxGridTable.CreateColumn;
  col.Options.HorzSizing := False;
  col.Width := MulDiv(200, Screen.PixelsPerInch, 96);
  col.Caption := 'Proprietate';
  col.Styles.Content := dmAdditions.cxStyle_GridContentEven;
  col.Options.Focusing := False;
  col.HeaderAlignmentVert := vaCenter;

     // create field Options
  col := cxGridTable.CreateColumn;
  col.Visible := False;
  col.VisibleForCustomization := False;
  col.DataBinding.ValueType := 'Integer';


     // create rows
  AddNewDefinitionRow('DOCID', 'Cod Document', ctInteger, cOPTION_Bold);
  AddNewDefinitionRow('CREATED_DATE', 'Data crearii', ctDate);
  AddNewDefinitionRow('DATA', 'Data document', ctDate);
  AddNewDefinitionRow('PARENTDOCID', 'Document parinte', ctInteger);
  AddNewDefinitionRow('DT_NAME', 'Subdiviziune', ctString, cOPTION_Bold);
  AddNewDefinitionRow('CT', 'Cod client', ctInteger);
  AddNewDefinitionRow('CT_NAME', 'Client', ctString, cOPTION_Bold);
  AddNewDefinitionRow('SUMA', 'Suma', ctFloat, cOPTION_Bold + cOPTION_COLOR_BLUE);

  AddNewDefinitionRow('DTDEP_NAME', 'Depozit 1', ctString);
  AddNewDefinitionRow('CTDEP_NAME', 'Depozit 2', ctString);
  AddNewDefinitionRow('DTSC_NAME', 'Analitica DT', ctString);
  AddNewDefinitionRow('SC2_NAME', 'Analitica', ctString);
  AddNewDefinitionRow('CURRENCY_NAME', 'Valuta', ctString, cOPTION_Bold);

  AddNewDefinitionRow('RATE', 'Rata', ctInteger);
  AddNewDefinitionRow('RATEUSD', 'Rata USD', ctInteger);
  AddNewDefinitionRow('FLG_SHIP', 'FLG_SHIP', ctBoolean);
  AddNewDefinitionRow('FLG_ACNT', 'FLG_ACNT', ctBoolean, cOPTION_Bold + cOPTION_COLOR_RED);

  AddNewDefinitionRow('FLG_PAID', 'FLG_PAID', ctBoolean);
  AddNewDefinitionRow('FLG_INVOICE', 'FLG_INVOICE', ctBoolean);
  AddNewDefinitionRow('FLG_GOODS_ARRIVAL', 'FLG_GOODS_ARRIVAL', ctBoolean);
  AddNewDefinitionRow('FLG_READY', 'FLG_READY', ctBoolean);
  AddNewDefinitionRow('FLG_CLOSED', 'FLG_CLOSED', ctBoolean, cOPTION_Bold + cOPTION_COLOR_RED);
  AddNewDefinitionRow('FLG_CASHBACK', 'FLG_CASHBACK', ctBoolean, cOPTION_Bold + cOPTION_COLOR_RED);
  AddNewDefinitionRow('FLG_WEBSHOP_ORDER', 'FLG_WEBSHOP_ORDER', ctBoolean, cOPTION_Bold + cOPTION_COLOR_RED);
  AddNewDefinitionRow('COMMENTS', 'Mentiuni', ctString, cOPTION_COLOR_YELLOW);
  AddNewDefinitionRow('RECEIPS', 'Bonuri de casa', ctString, cOPTION_COLOR_BLUE);
  AddNewDefinitionRow('FACTURANO', 'Numar factura fiscala', ctString, cOPTION_COLOR_BLUE);
  AddNewDefinitionRow('CREATED_BY_NAME', 'Utilizator', ctString);
  AddNewDefinitionRow('INCIDENTID', 'Numar incident', ctInteger);
  AddNewDefinitionRow('WAYBILLID', 'Livrare', ctInteger);
end;

procedure TfrmDocumentInspectorDlg.cxGridTableColumnHeaderClick(Sender: TcxGridTableView; AColumn: TcxGridColumn);
var
  dic: integer;
begin
  if AColumn.Index > 2 then
  begin
    dic := StrToInt(cxGridTable.DataController.Values[0, AColumn.Index]);
    if (dic <> FDocID) then
    begin
      fDocID := dic;
      with TDelayThread.Create(100, WhenNeedToReloadData) do
        Start;
    end;
  end;
end;

procedure TfrmDocumentInspectorDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  N: integer;
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[3]) and (AViewInfo.GridRecord.Values[3] > 0) then
  begin
    N := AViewInfo.GridRecord.Values[3];
    if (N and cOPTION_Bold) = cOPTION_Bold then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
    if not AViewInfo.Selected then
    begin
      if (N and cOPTION_COLOR_RED) = cOPTION_COLOR_RED then
        ACanvas.Font.Color := clRed;
      if (N and cOPTION_COLOR_GREEN) = cOPTION_COLOR_GREEN then
        ACanvas.Font.Color := clGreen;
      if (N and cOPTION_COLOR_BLUE) = cOPTION_COLOR_BLUE then
        ACanvas.Font.Color := clBlue;
      if (N and cOPTION_COLOR_YELLOW) = cOPTION_COLOR_YELLOW then
        ACanvas.Font.Color := $00003CB7;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure TfrmDocumentInspectorDlg.dxBarPopupMenu1Popup(Sender: TObject);
begin
  bbGotoDocument.Enabled := cxGridTable.Controller.FocusedColumnIndex > 0;
  bbGotoIncident.Enabled := (cxGridTable.Controller.FocusedColumnIndex > 0) and (cxGridTable.DataController.Values[28,
    cxGridTable.Controller.FocusedColumn.Index] <> '');
end;

procedure TfrmDocumentInspectorDlg.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfrmDocumentInspectorDlg.LoadData;
begin
  cxGridTable.BeginUpdate;
  try
    while cxGridTable.DataController.RecordCount > 0 do
      cxGridTable.DataController.DeleteRecord(0);
    cxGridTable.ClearItems;
  finally
    cxGridTable.EndUpdate;
  end;
  ReadDocumentData2;
end;

procedure TfrmDocumentInspectorDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
    (Self) then
    Self.Position := poDesigned;
end;

procedure TfrmDocumentInspectorDlg.Prepare;
begin
  fGotoDocID := -1;
  LoadData;
end;

procedure TfrmDocumentInspectorDlg.ReadDocumentData2;
begin
  pnLoading.Left := (Width - pnLoading.Width) div 2;
  pnLoading.Top := (Height - pnLoading.Height) div 2;
  pnLoading.Show;
     // run SQL in thread
  with TSQLThread.Create(WhenInitSql, WhenGetResultSQL) do
    Start;
end;

procedure TfrmDocumentInspectorDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmDocumentInspectorDlg.SetDocID(const Value: integer);
begin
  fDocID := Value;
end;

procedure TfrmDocumentInspectorDlg.WhenGetResultSQL(const Query: TIBCQuery);
var
  col: TcxGridColumn;
  i: integer;
begin
  cxGridTable.BeginUpdate;
  try
    CreateHeaderColumn;

    while not Query.Eof do
    begin
             // create column
      col := cxGridTable.CreateColumn;
      col.Width := MulDiv(200, Screen.PixelsPerInch, 96);
      col.Tag := Query.FieldByName('DOCID').AsInteger;
      col.Caption := Query.FieldByName('DOCTYPE_NAME').AsString;
      col.HeaderAlignmentHorz := taCenter;
      col.HeaderAlignmentVert := vaCenter;
      col.Styles.Header := dmAdditions.cxStyle_Bold;

      case Query.FieldByName('DOC_TYPE').asInteger of
        -1:
          col.Styles.Content := dmAdditions.cxStyle_DocInSpector_Parent;
        0:
          col.Styles.Content := dmAdditions.cxStyle_DocInSpector_CurrDoc;
        1:
          ;
      end;

             // values
      for i := 0 to cxGridTable.DataController.RecordCount - 1 do
      begin
        case TColDBType(cxGridTable.DataController.Values[i, 1]) of
          ctString:
            cxGridTable.DataController.Values[i, col.Index] := Query.FieldByName(cxGridTable.DataController.Values[i, 0]).AsString;
          ctInteger:
            cxGridTable.DataController.Values[i, col.Index] := Query.FieldByName(cxGridTable.DataController.Values[i, 0]).AsString;
          ctFloat:
            cxGridTable.DataController.Values[i, col.Index] := Format('%f', [Query.FieldByName(cxGridTable.DataController.Values
              [i, 0]).AsFloat]);
          ctDate:
            cxGridTable.DataController.Values[i, col.Index] := FormatDateTime('dd.mm.yyyy HH:NN', Query.FieldByName(cxGridTable.DataController.Values
              [i, 0]).AsDateTime);
          ctBoolean:
            if Query.FieldByName(cxGridTable.DataController.Values[i, 0]).AsInteger = 1 then
              cxGridTable.DataController.Values[i, col.Index] := '●';
        end;
      end;
      Query.Next;
    end;
  finally
    cxGridTable.EndUpdate;
    pnLoading.Hide;
  end;
end;

procedure TfrmDocumentInspectorDlg.WhenInitSql(const Query: TIBCQuery);
begin
  Query.Connection := dmDB.IBCConnection;
  Query.SQL.Text := 'select * from SP_DOCS_INSPECTOR(:DOCID) order by parentdocid';
  Query.ParamByName('DOCID').AsInteger := fDocID;
end;

procedure TfrmDocumentInspectorDlg.WhenNeedToReloadData(Sender: TObject);
begin
  LoadData;
end;

end.

