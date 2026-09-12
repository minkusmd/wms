unit frmScetFakturaCekPKODialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  DBAccess, IBC, MemDS, Vcl.StdCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DialogTitle, cxCurrencyEdit, cxLabel, cxNavigator;

type
  TfrmScetFakturaCekPKODlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryPKO: TIBCQuery;
    IBCDataSourcePKO: TIBCDataSource;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_CT_NAME: TcxGridDBColumn;
    cxGrid_SUMA: TcxGridDBColumn;
    cxGridDBTableColumn1: TcxGridDBColumn;
  private
    FCT: integer;
    FSuma: Currency;
    FDocID: integer;
    procedure SetCT(const Value: integer);
    procedure SetSuma(const Value: Currency);
    procedure SetDocID(const Value: integer);
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DocID:integer read FDocID write SetDocID;
    property CT:integer read FCT write SetCT;
    property Suma:Currency read FSuma write SetSuma;
    function GetPKO_DocID:integer;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB;

{ TfrmScetFakturaCekPKODlg }

function TfrmScetFakturaCekPKODlg.GetPKO_DocID: integer;
begin
     Result:=-1;
     if Assigned(cxGridDBTable.Controller.FocusedRecord) then Result:=cxGridDBTable.Controller.FocusedRecord.Values[cxGrid_DOCID.Index];
end;

function TfrmScetFakturaCekPKODlg.IsFormDataPosted: Boolean;
begin
     Result:=Assigned(cxGridDBTable.Controller.FocusedRecord);
end;

procedure TfrmScetFakturaCekPKODlg.Prepare;
begin
     IBCQueryPKO.ParamByName('DT').AsInteger:=dmDB.CurrentFirma;
     IBCQueryPKO.ParamByName('CT').AsInteger:=fCT;
     IBCQueryPKO.ParamByName('SUMA').AsCurrency:=fSuma;
     IBCQueryPKO.ParamByName('DOCID').AsInteger:=fDocID;
     IBCQueryPKO.Active:=True;
end;

procedure TfrmScetFakturaCekPKODlg.SetCT(const Value: integer);
begin
  FCT := Value;
end;

procedure TfrmScetFakturaCekPKODlg.SetDocID(const Value: integer);
begin
  FDocID := Value;
end;

procedure TfrmScetFakturaCekPKODlg.SetSuma(const Value: Currency);
begin
  FSuma := Value;
end;

end.
