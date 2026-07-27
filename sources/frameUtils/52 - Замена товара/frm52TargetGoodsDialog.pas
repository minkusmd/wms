unit frm52TargetGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxBar, Vcl.ExtCtrls, DialogTitle, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.StdCtrls, DBAccess,
  IBC, MemDS, cxNavigator, dxDateRanges, dxScrollbarAnnotations, dxCoreGraphics;

type
  Tfrm52TargetGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnSettings: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    Label1: TLabel;
    beCUSTOMER: TcxButtonEdit;
    dxBarManager1Bar1: TdxBar;
    bbProcess: TdxBarButton;
    pnButtons: TPanel;
    btnClose: TButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_DOC_DATA: TcxGridDBColumn;
    cxGrid_DOC_CT_NAME: TcxGridDBColumn;
    cxGrid_DT_GOODSID: TcxGridDBColumn;
    cxGrid_DT_GOODS_TITLE: TcxGridDBColumn;
    cxGrid_DT_IDENT: TcxGridDBColumn;
    cxGrid_DT_PRICE: TcxGridDBColumn;
    procedure beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGrid_DOC_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbProcessClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    FCustomerID: integer;
    procedure SetCustomerID(const Value: integer);
    procedure OpenData;
    procedure SetCustomerName(const Value: String);
    procedure SelectCustomer;
    procedure SelectionChanged;

    procedure ShowProcessDialog;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    property CustomerID:integer read FCustomerID write SetCustomerID;
    property CustomerName:String write SetCustomerName;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, frmCustomersDlg, frm52ZamenaTovaraEditorDialog, SWNUtils;

{ Tfrm52TargetGoodsDlg }

procedure Tfrm52TargetGoodsDlg.bbProcessClick(Sender: TObject);
begin
     ShowProcessDialog;
end;

procedure Tfrm52TargetGoodsDlg.beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectCustomer;
end;

constructor Tfrm52TargetGoodsDlg.Create(AOwner: TComponent);
begin
     inherited;
     FCustomerID:=-1;
end;

procedure Tfrm52TargetGoodsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and bbProcess.Enabled then
     begin
          bbProcessClick(bbProcess);
          AHandled:=True;
     end;
end;

procedure Tfrm52TargetGoodsDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tfrm52TargetGoodsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tfrm52TargetGoodsDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          CopyGridCellTextToClipboard(cxGridTable);
          Key:=0;
          Shift:=[];
     end;
end;

procedure Tfrm52TargetGoodsDlg.cxGrid_DOC_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGrid_DOC_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGrid_DOC_DATA.Index]);
end;

procedure Tfrm52TargetGoodsDlg.OpenData;
begin
     IBCQueryGoods.Close;
     IBCQueryGoods.ParamByName('ID').AsInteger:=FCustomerID;
     if FCustomerID<>-1 then IBCQueryGoods.Active:=True;
     SelectionChanged;
end;

procedure Tfrm52TargetGoodsDlg.Prepare;
begin
     if FCustomerID=-1 then beCUSTOMER.Text:='Выберите контрагента...';
     OpenData;
end;

procedure Tfrm52TargetGoodsDlg.SelectCustomer;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(FCustomerID) then
        begin
             FCustomerID:=dialog.CustomerID;
             beCUSTOMER.Text:=Format('#%d %s',[FCustomerID,dialog.CustomerTitle]);
             OpenData;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tfrm52TargetGoodsDlg.SelectionChanged;
var fProcess:Boolean;
begin
     fProcess:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fProcess:=True;
     end;
     bbProcess.Enabled:=fProcess;
end;

procedure Tfrm52TargetGoodsDlg.SetCustomerID(const Value: integer);
begin
     FCustomerID := Value;
end;

procedure Tfrm52TargetGoodsDlg.SetCustomerName(const Value: String);
begin
     if FCustomerID<>-1 then beCUSTOMER.Text:=Format('#%d %s',[FCustomerID,Value]);
end;

procedure Tfrm52TargetGoodsDlg.ShowProcessDialog;
var dialog:Tfrm52ZamenaTovaraEditorDlg;
begin
     dialog:=Tfrm52ZamenaTovaraEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewRecord:=False;
        dialog.DisableLeftPane;
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryGoods.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

end.
