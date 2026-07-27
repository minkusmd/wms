unit frmServiceReturnToCustomerGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DialogTitle, DBAccess, IBC, MemDS,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmServiceReturnToCustomerGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_DOC_TYPE: TcxGridDBColumn;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_SNPN: TcxGridDBColumn;
    cxGridTable_DATA: TcxGridDBColumn;
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    FDocID: Integer;
    procedure SetDocID(const Value: Integer);
    function HasSelection:Boolean;
    function AddGoods:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DocID:Integer read FDocID write SetDocID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNDBErrors;

{ TfrmServiceReturnToCustomerGoodsDlg }

function TfrmServiceReturnToCustomerGoodsDlg.AddGoods: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_F35_ADD_GOODS_TO_JURNAL(:SDOCID,:DOCID,:GOODSID,:SERIAL_TYPE_ID,:SNPN)';
        Query.ParamByName('SDOCID').AsInteger:=IBCQueryGoods.FieldByName('DOCID').AsInteger;
        Query.ParamByName('DOCID').AsInteger:=FDocID;
        Query.ParamByName('GOODSID').AsInteger:=IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        Query.ParamByName('SERIAL_TYPE_ID').AsInteger:=IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger;
        Query.ParamByName('SNPN').AsString:=IBCQueryGoods.FieldByName('SNPN').AsString;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(e) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmServiceReturnToCustomerGoodsDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure TfrmServiceReturnToCustomerGoodsDlg.cxGridTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridTable_DATA.Index])
       then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridTable_DATA.Index]);
end;

function TfrmServiceReturnToCustomerGoodsDlg.HasSelection: Boolean;
begin
     Result:=cxGridTable.DataController.RecNo>0;
end;

function TfrmServiceReturnToCustomerGoodsDlg.IsFormDataPosted: Boolean;
begin
     Result:=HasSelection and AddGoods;
end;

procedure TfrmServiceReturnToCustomerGoodsDlg.Prepare;
begin
     IBCQueryGoods.ParamByName('DOCID').AsInteger:=FDocID;
     IBCQueryGoods.Active:=True;
     cxGridTable_SNPN.Focused:=True;
     if (cxGridTable.DataController.RecordCount=0) then
     begin
          btnOk.Visible:=False;
          btnCancel.Caption:='Закрыть';
          btnCancel.Default:=True;
     end;
end;

procedure TfrmServiceReturnToCustomerGoodsDlg.SetDocID(const Value: Integer);
begin
     FDocID := Value;
end;

end.
