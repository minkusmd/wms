unit frmOtgruzkaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridLevel, cxGrid, cxButtonEdit, cxCheckBox, cxNavigator, cxLabel;

type
  TfrmOtgruzkaDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    pnActiuni: TPanel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_ID: TcxGridColumn;
    cxGridTable_CHECK: TcxGridColumn;
    cxGridTable_TITLE: TcxGridColumn;
    cxGridTable_Errors: TcxGridColumn;
    cxGridTableHasError: TcxGridColumn;
    cxGridLevel: TcxGridLevel;
    Label2: TLabel;
    lbErrorInfo: TLabel;
    pnButtons: TPanel;
    btnYes: TButton;
    btnNo: TButton;
    Label4: TLabel;
    procedure cxGridTableEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fDocID: integer;
    procedure SetDocID(const Value: integer);
    procedure LoadActiuni;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property DocID:integer read FDocID write SetDocID;
    function GetActiuneList:String;
  end;


implementation

uses DataModuleAdditions, IBC, DataModuleDB, SWNUpdateClientDBClass, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmOtgruzkaDlg }

procedure TfrmOtgruzkaDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if Not VarIsNull(ACellViewInfo.GridRecord.Values[cxGridTableHasError.Index]) then
     begin
          AHandled:=True;
          // show Error info
          ShowErrorDialog(cMSG_GeneralError_Title,ACellViewInfo.GridRecord.Values[cxGridTable_Errors.Index]);
     end;
end;

procedure TfrmOtgruzkaDlg.cxGridTableEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
     if (AItem=cxGridTable_CHECK) then
     begin
          AAllow:=Not cxGridTable.Controller.FocusedRecord.Values[cxGridTableHasError.Index];
     end;
end;

procedure TfrmOtgruzkaDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Not VarIsNull(ARecord.Values[cxGridTableHasError.Index]) then
  begin
       if Not ARecord.Values[cxGridTableHasError.Index] then AStyle:=dmAdditions.cxStyle_TextColorGreen;
  end;
end;

function TfrmOtgruzkaDlg.GetActiuneList: String;
var i:integer;
begin
     Result:='';
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     begin
          if Not cxGridTable.DataController.Values[i,cxGridTableHasError.Index]
             and
             cxGridTable.DataController.Values[i,cxGridTable_CHECK.Index]
          then
          begin
               if Result<>'' then Result:=Result+',';
               Result:=Result+IntToStr(cxGridTable.DataController.Values[i,cxGridTable_ID.Index]);
          end;
     end;
end;

procedure TfrmOtgruzkaDlg.LoadActiuni;
var Query:TIBCQuery;
    N:integer;
begin
     cxGridTable.DataController.BeginUpdate;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT ACTIUNEID,TITLE,ERRORS FROM SP_GET_SHIPMENT_ACTIUNI(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=fDocID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             N:=cxGridTable.DataController.AppendRecord;
             cxGridTable.DataController.Values[N,cxGridTable_ID.Index]:=Query.Fields[0].AsInteger;

             cxGridTable.DataController.Values[N,cxGridTable_TITLE.Index]:=Query.Fields[1].AsString;
             if Query.Fields[2].IsNull or (Query.Fields[2].AsString='') then
             begin
                  cxGridTable.DataController.Values[N,cxGridTable_CHECK.Index]:=False; // by default is not selected
                  cxGridTable.DataController.Values[N,cxGridTableHasError.Index]:=False;
                  cxGridTable.DataController.Values[N,cxGridTable_Errors.Index]:='';
                  lbErrorInfo.Visible:=False;
             end
             else
             begin
                  cxGridTable.DataController.Values[N,cxGridTable_CHECK.Index]:=Null;
                  cxGridTable.DataController.Values[N,cxGridTableHasError.Index]:=True;
                  cxGridTable.DataController.Values[N,cxGridTable_Errors.Index]:=Query.Fields[2].AsString;
                  lbErrorInfo.Visible:=True;
             end;

             // next
             Query.Next;
        end;
     finally
        Query.Free;
        cxGridTable.DataController.EndUpdate;
     end;
end;

procedure TfrmOtgruzkaDlg.Prepare;
begin
     LoadActiuni;
     pnActiuni.Visible:=cxGridTable.DataController.RecordCount>0;
end;

procedure TfrmOtgruzkaDlg.SetDocID(const Value: integer);
begin
     fDocID := Value;
end;

end.
