unit frmListofIncidentDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus,
  DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid;

type
  TfrmDialogListOfIncidents = class(TSWNMasteredFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnSelectQtyFromComplectBtnClose: TcxButton;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    cxGrid1DBTableView1INCIDENTID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_SN: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_MODEL: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FIBCQueryMasterDocs: TIBCQuery;
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmDialogListOfIncidents: TfrmDialogListOfIncidents;

implementation

uses
  DataModuleDB;

{$R *.dfm}

{ TfrmDialogListOfIncidents }

procedure TfrmDialogListOfIncidents.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IBCQueryDocs.Close;
end;

procedure TfrmDialogListOfIncidents.FormShow(Sender: TObject);
begin
  cxGrid1.SetFocus;
end;

procedure TfrmDialogListOfIncidents.Prepare;
begin
  inherited;

  IBCQueryDocs.Connection := fMasterDataSet.Connection;

  IBCQueryDocs.Close;
  IBCQueryDocs.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
  IBCQueryDocs.Open;
end;

end.

