unit frm52ZamenaTovaraSelectSNDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxImageComboBox, StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxContainer, cxTextEdit, cxDBEdit, Buttons, ExtCtrls, DialogTitle,
  SWNSNClasses, cxLookAndFeels, cxLookAndFeelPainters, cxMemo, cxNavigator;

type

  Tfrm52ZamenaTovaraSelectSNDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnGoods: TPanel;
    cxLabel1: TLabel;
    Label3: TLabel;
    cxGridAvSN: TcxGrid;
    cxGridAvSNLevel: TcxGridLevel;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridAvSNTable: TcxGridTableView;
    cxGridAvSNTable_IMG: TcxGridColumn;
    cxGridAvSNTable_SN: TcxGridColumn;
    edQuickSearchAv: TEdit;
    Label1: TLabel;
    mmInfo: TcxMemo;
    cxGridAvSNTable_COUNTRYID: TcxGridColumn;
    cxGridAvSNTable_VENDORID: TcxGridColumn;
    procedure cxGridAvSNTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridAvSNTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure edQuickSearchAvChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    { Private declarations }
    //fSerialsCount:integer;
    fGoodsID: integer;
    fDEP: integer;
    fData: TDateTime;
    fSN: String;
    fCountryID: integer;
    fVendorID: integer;

    procedure SelectionChanged;

    procedure ReadAvailableSerialsFromDB;

    procedure DoQuickSearchAvailableSN(const Text:String);
    procedure SetData(const Value: TDateTime);
    procedure SetDEP(const Value: integer);
    procedure SetGoodsID(const Value: integer);
    procedure SetGoodsTitle(const Value: String);

  protected
    { Protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:integer read fGoodsID write SetGoodsID;
    property GoodsTitle:String write SetGoodsTitle;
    property DEP:integer read fDEP write SetDEP;
    property Data:TDateTime read fData write SetData;
    property SN:String read fSN;
    property CountryID:integer read fCountryID;
    property VendorID:integer read fVendorID;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNValueStorageUnit, DataModuleDB, SWNConst, ClipBrd, SWNDBErrors;

{$R *.dfm}

{ TfrmSelectSNDlg }

procedure Tfrm52ZamenaTovaraSelectSNDlg.btnOkClick(Sender: TObject);
begin
     if Assigned(cxGridAvSNTable.Controller.FocusedRow) then
     begin
          fSN:=cxGridAvSNTable.Controller.FocusedRow.Values[cxGridAvSNTable_SN.Index];
          fCountryID:=cxGridAvSNTable.Controller.FocusedRow.Values[cxGridAvSNTable_COUNTRYID.Index];
          fVendorID:=cxGridAvSNTable.Controller.FocusedRow.Values[cxGridAvSNTable_VENDORID.Index];
          ModalResult:=mrOk;
     end;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     btnOkClick(Sender)
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.cxGridAvSNTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.cxGridAvSNTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
     SelectionChanged;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.DoQuickSearchAvailableSN(const Text: String);
var i,N:integer;
    S:String;
begin
     cxGridAvSNTable.Controller.ClearSelection;
     cxGridAvSNTable.BeginUpdate;
     try
        for i := 0 to cxGridAvSNTable.DataController.RecordCount - 1 do
        begin
             S:=UpperCase(cxGridAvSNTable.DataController.Values[i,cxGridAvSNTable_SN.Index]);
             if Pos(Text,S)>0 then
             begin
                  N:=cxGridAvSNTable.DataController.GetRowIndexByRecordIndex(i,true);
                  cxGridAvSNTable.Controller.FocusedRecordIndex:=i;
                  cxGridAvSNTable.DataController.SelectRows(N,N);
                  break;
             end;
        end;
     finally
        cxGridAvSNTable.EndUpdate;
     end;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.edQuickSearchAvChange(Sender: TObject);
begin
     DoQuickSearchAvailableSN(edQuickSearchAv.Text);
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.Prepare;
begin
     ReadAvailableSerialsFromDB;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.ReadAvailableSerialsFromDB;
var Query:TIBCQuery;
    N:integer;
begin
     Query:=TIBCQuery.Create(self);
     cxGridAvSNTable.BeginUpdate;
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='EXECUTE PROCEDURE GET_SN_DEP_GOODS(:GOODSID,:DTDEP,:DT,:DATA)';
        Query.ParamByName('GOODSID').AsInteger:=fGoodsID;
        Query.ParamByName('DTDEP').AsInteger:=fDEP;
        Query.ParamByName('DT').AsInteger:=FirmaID;
        Query.ParamByName('DATA').AsDate:=FData;
        Query.ExecSQL;
        Query.SQL.Text:='SELECT SN, COUNTRYID, VENDORID FROM TMP_SN ORDER BY SN';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             N:=cxGridAvSNTable.DataController.AppendRecord;
             cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_SN.Index]:=Query.Fields[0].AsString;
             cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_COUNTRYID.Index]:=Query.Fields[1].AsInteger;
             cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_VENDORID.Index]:=Query.Fields[2].AsInteger;

             Query.Next;
        end;
        Query.Close;
     finally
        cxGridAvSNTable.EndUpdate;
        Query.Free;
     end;

     if cxGridAvSNTable.DataController.RecordCount>0 then
     begin
          cxGridAvSNTable.ViewData.Records[0].Selected:=True;
          cxGridAvSNTable.ViewData.Records[0].Focused:=True;
     end;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.SelectionChanged;
begin
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.SetData(const Value: TDateTime);
begin
     fData := Value;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.SetDEP(const Value: integer);
begin
     fDEP := Value;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.SetGoodsID(const Value: integer);
begin
     fGoodsID := Value;
end;

procedure Tfrm52ZamenaTovaraSelectSNDlg.SetGoodsTitle(const Value: String);
begin
     mmInfo.Text:=Value;
end;

end.
