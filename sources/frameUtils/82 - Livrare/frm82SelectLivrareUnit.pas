unit frm82SelectLivrareUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
    cxNavigator, dxDateRanges, Data.DB, cxDBData, cxCheckBox, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SWNBaseUnit,
  dxScrollbarAnnotations;

type
    Tfrm82SelectLivrareDlg = class(TSWNBaseFormClass)
        DialogTitle1: TDialogTitle;
        Panel2: TPanel;
        Button1: TButton;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1Level1: TcxGridLevel;
        cxGrid1: TcxGrid;
        IBCQueryLivrari: TIBCQuery;
        IBCDataSourceLivrari: TIBCDataSource;
        Button2: TButton;
        cxGrid1DBTableView1WAYBILLID: TcxGridDBColumn;
        cxGrid1DBTableView1CURIER_NAME: TcxGridDBColumn;
        cxGrid1DBTableView1TRANSPORT_NAME: TcxGridDBColumn;
        cxGrid1DBTableView1DATA: TcxGridDBColumn;
        cxGrid1DBTableView1SC_NAME: TcxGridDBColumn;
        cxGrid1DBTableView1FLG_CLOSED: TcxGridDBColumn;
        cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn;
        cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
        procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    private
        FDocID: Integer;
        procedure DoAddDocID2Livrari;
        procedure SetDocID(const Value: Integer);
    { Private declarations }
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
        function CheckParams: Boolean;
    public
        property DocID: Integer read FDocID write SetDocID;
    { Public declarations }
    end;

var
    frm82SelectLivrareDlg: Tfrm82SelectLivrareDlg;

implementation

uses
    DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmSelectLivrareDlg }

function Tfrm82SelectLivrareDlg.CheckParams: Boolean;
var
    ErrorStr: string;
    S_DT, S_DTSC: string;
    S_CT: string;
begin
    Result := True;

end;

procedure Tfrm82SelectLivrareDlg.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
    ModalResult := mrOk;
end;

procedure Tfrm82SelectLivrareDlg.DoAddDocID2Livrari;
var
    query: TIBCQuery;
begin
    query := TIBCQuery.Create(self);
    try
        query.Transaction := dmdb.IBCTrDefaultUpdate;
        query.SQL.Text := 'EXECUTE PROCEDURE SP_ADD_DOCID2LIVRARI(:WAYBILLID, :DOCID)';
        query.ParamByName('DOCID').AsInteger := DocID;
        query.ParamByName('WAYBILLID').AsInteger := IBCQueryLivrari.FieldByName('WAYBILLID').AsInteger;
        try
            query.ExecSQL;
        except
            on e: Exception do
                MessageDlg('A aparut o eroare, mai incercati odata!'+#13#10+e.Message, mtError, [mbOK], 0);
        end;
    finally
        query.Free;
    end;
end;

function Tfrm82SelectLivrareDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if CheckParams then
    begin
        try
            DoAddDocID2Livrari;
            Result := True;
        except
            on e: Exception do
            begin
                Result := False;
                raise;
            end;
        end;

    end;
end;

procedure Tfrm82SelectLivrareDlg.Prepare;
begin
    inherited;
    IBCQueryLivrari.Active := True;
end;

procedure Tfrm82SelectLivrareDlg.SetDocID(const Value: Integer);
begin
    FDocID := Value;
end;

procedure Tfrm82SelectLivrareDlg.WhenCancelForm;
begin
    if IBCQueryLivrari.State in (dsEditModes) then
        IBCQueryLivrari.Cancel;
end;

end.

