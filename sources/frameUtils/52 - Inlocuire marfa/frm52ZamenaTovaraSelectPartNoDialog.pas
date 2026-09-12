unit frm52ZamenaTovaraSelectPartNoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, SWNPNClasses, IBC,
  Dialogs, DialogTitle, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxImageComboBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, cxContainer, cxTextEdit, cxDBEdit, Buttons,
  StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, cxLabel, cxMemo, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  Tfrm52ZamenaTovaraSelectPartNoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxGridAParts: TcxGrid;
    cxGridAPartsTable: TcxGridTableView;
    cxGridAParts_PARTNO: TcxGridColumn;
    cxGridAParts_QTY: TcxGridColumn;
    cxGridAPartsLevel: TcxGridLevel;
    Label3: TLabel;
    cxGridAPartsTable_IMG: TcxGridColumn;
    mmInfo: TcxMemo;
    cxGridAParts_COUNTRYID: TcxGridColumn;
    cxGridAParts_VENDORID: TcxGridColumn;
    procedure btnOkClick(Sender: TObject);
    procedure cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    fPartNO: String;
    FGoodsID: integer;
    FDEP: Integer;
    FDocData: TDateTime;
    fCountryID: integer;
    fVendorID: integer;
    { Private declarations }
    procedure ReadAvailablePartNumbersFromDB;
    procedure SetDEP(const Value: Integer);
    procedure SetDocData(const Value: TDateTime);
    procedure SetGoodsID(const Value: integer);
    procedure SetGoodsTitle(const Value: string);
  protected
    procedure Prepare; override;
  public
    { Public declarations }
    property PartNO:String read fPartNO;
    property GoodsID:integer read FGoodsID write SetGoodsID;
    property GoodsTitle:string write SetGoodsTitle;
    property DEP:Integer read FDEP write SetDEP;
    property DocData:TDateTime read FDocData write SetDocData;
    property CountryID:integer read fCountryID;
    property VendorID:integer read fVendorID;
  end;

implementation

Uses SWNUtils, DataModuleDB, DataModuleAdditions, SWNValueStorageUnit, SWNConst, SWNDBErrors;

{$R *.dfm}

{ TfrmSelectSNDlg }

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.ReadAvailablePartNumbersFromDB;
var Query:TIBCQuery;
    N:integer;
begin
     Query:=TIBCQuery.Create(self);
     cxGridAPartsTable.BeginUpdate;
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;

        Query.SQL.Text:='EXECUTE PROCEDURE GET_PARTS_DEP_GOODS(:GOODSID,:DTDEP,:DT,:DATA)';
        Query.ParamByName('GOODSID').AsInteger:=fGoodsID;
        Query.ParamByName('DTDEP').AsInteger:=fDEP;
        Query.ParamByName('DT').AsInteger:=FirmaID;
        Query.ParamByName('DATA').AsDate:=fDocData;
        Query.ExecSQL;
        Query.Close;

        Query.SQL.Text:='SELECT PARTNO, QTY, COUNTRYID, VENDORID FROM TMP_PARTS';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             N:=cxGridAPartsTable.DataController.AppendRecord;
             cxGridAPartsTable.DataController.Values[N,cxGridAParts_PARTNO.Index]:=Query.Fields[0].AsString;
             cxGridAPartsTable.DataController.Values[N,cxGridAParts_QTY.Index]:=Query.Fields[1].AsInteger;
             cxGridAPartsTable.DataController.Values[N,cxGridAParts_COUNTRYID.Index]:=Query.Fields[2].AsInteger;
             cxGridAPartsTable.DataController.Values[N,cxGridAParts_VENDORID.Index]:=Query.Fields[3].AsInteger;
             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
        cxGridAPartsTable.EndUpdate;
     end;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.SetDEP(const Value: Integer);
begin
     FDEP := Value;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.SetDocData(const Value: TDateTime);
begin
     FDocData := Value;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.SetGoodsID(const Value: integer);
begin
     FGoodsID := Value;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.SetGoodsTitle(const Value: string);
begin
     mmInfo.Text:=Value;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.btnOkClick(Sender: TObject);
begin
     if Assigned(cxGridAPartsTable.Controller.FocusedRow) then
     begin
          fPartNO:=cxGridAPartsTable.Controller.FocusedRow.Values[cxGridAParts_PARTNO.Index];
          fCountryID:=cxGridAPartsTable.Controller.FocusedRow.Values[cxGridAParts_COUNTRYID.Index];
          fVendorID:=cxGridAPartsTable.Controller.FocusedRow.Values[cxGridAParts_VENDORID.Index];
          ModalResult:=mrOk;
     end;
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     btnOkClick(Sender);
end;

procedure Tfrm52ZamenaTovaraSelectPartNoDlg.Prepare;
begin
     ReadAvailablePartNumbersFromDB;
end;

end.
