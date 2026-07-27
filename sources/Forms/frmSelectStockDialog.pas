unit frmSelectStockDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, DB, cxDBData, cxGridCustomTableView,
  cxGridDBTableView, cxGridLevel, cxGrid, StdCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxGridTableView, cxClasses,
  cxGridCustomView;

type
  TfrmSelectStockDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_STOCKID: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_PARENT_TITLE: TcxGridDBColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    { Private declarations }
    fStockID:integer;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property StockID:integer read fStockID;
  end;

implementation

uses DataModuleDB;

{$R *.dfm}

{ TfrmSelectStockDlg }

procedure TfrmSelectStockDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (cxGridTable.DataController.RecNo>0) then
     begin
          ModalResult:=mrOk;
     end;
end;

procedure TfrmSelectStockDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     dmDB.IBCQueryStocks.Active:=False;
end;

procedure TfrmSelectStockDlg.FormCreate(Sender: TObject);
begin
     fStockID:=0;
end;

function TfrmSelectStockDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fStockID:=dmDB.IBCQueryStocks.FieldByName('STOCKID').AsInteger;
          Result:=True;
     end;
end;

procedure TfrmSelectStockDlg.Prepare;
begin
     dmDB.IBCQueryStocks.Active:=True;
     cxGridTable.DataController.Groups.FullExpand;
end;

end.
