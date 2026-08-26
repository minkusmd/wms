unit frmDocumentTreeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  Vcl.ExtCtrls, RzPanel, RzDlgBtn, DBAccess, IBC, MemDS, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, SWNSearchDocumentTypes;

type
  TfrmDocumentTreeDlg = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1DIRECTION: TcxGridDBColumn;
    cxGrid1DBTableView1LEVEL_: TcxGridDBColumn;
    cxGrid1DBTableView1DOCID_OUT: TcxGridDBColumn;
    cxGrid1DBTableView1PARENTDOCID: TcxGridDBColumn;
    cxGrid1DBTableView1DOCTYPE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1DATA_DOC: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_ID: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure RzDialogButtons1ClickOk(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    FDocID: Integer;
    procedure SetDocID(const Value: Integer);
    procedure GotoDocument(const SearchDocumentID: Integer;
      const Target: TSearchDocumentSearchTarget);
    { Private declarations }
  public
    property DocID: Integer read FDocID write SetDocID;
    { Public declarations }

  end;

var
  frmDocumentTreeDlg: TfrmDocumentTreeDlg;

implementation

uses
  frmDocumentBrowserDialog, DataModuleDB, cxImageComboBox, MainForm;

{$R *.dfm}

procedure TfrmDocumentTreeDlg.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  var d:=TfrmDocumentBrowserDlg.Create(self, dmdb.ibcconnection);
  try
      d.docid := ibcquerydocs.fieldbyname('docid').asinteger;
      d.showmodal;
  finally
      d.Free;
  end;
end;

procedure TfrmDocumentTreeDlg.RzDialogButtons1ClickOk(Sender: TObject);
var
resultInfo: TSearchDocumentResultInfo;
begin
  GotoDocument (ibcquerydocs.fieldbyname('DOCID_OUT').asinteger, sdstDoc);
end;

procedure TfrmDocumentTreeDlg.cxGrid1DBTableView1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if UpperCase(ARecord.Values[cxGrid1DBTableView1DIRECTION.Index]) = 'CURRENT' then
    AStyle.Color := clLime;

end;

procedure TfrmDocumentTreeDlg.GotoDocument(const SearchDocumentID: Integer; const Target: TSearchDocumentSearchTarget);
begin
     frmMainForm.GotoDocument(SearchDocumentID, sdstDoc);
     ModalResult := mrYes;
end;


procedure TfrmDocumentTreeDlg.SetDocID(const Value: Integer);
begin
    FDocID := Value;
    IBCQueryDocs.Close;
    IBCQueryDocs.ParamByName('docid').AsInteger := FDocID;
    IBCQueryDocs.Open;
end;

end.
