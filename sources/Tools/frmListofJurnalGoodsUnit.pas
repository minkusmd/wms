unit frmListofJurnalGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, DBAccess, IBC, MemDS,
  dxScrollbarAnnotations;

type
  TfrmListofJurnalGoodsDialog = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1UM_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1QTY: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE: TcxGridDBColumn;
    cxGrid1DBTableView1SUMA: TcxGridDBColumn;
  protected
    { Protected declarations }
    FDocID: Integer;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  private
    { Private declarations }
  public
    { Public declarations }

    constructor Create(const AOwner: TComponent; const DocID: Integer; const IBCConnection: TIBCConnection); reintroduce; virtual;

  end;

var
  frmListofJurnalGoodsDialog: TfrmListofJurnalGoodsDialog;

implementation

uses
   DataModuleDB;

{$R *.dfm}

{ TForm6 }

constructor TfrmListofJurnalGoodsDialog.Create(const AOwner: TComponent; const DocID: Integer; const IBCConnection: TIBCConnection);
begin
  inherited Create(AOwner, IBCConnection);

  FDocID := DocID;
end;

function TfrmListofJurnalGoodsDialog.IsFormDataPosted: Boolean;
begin

  dmdb.ExecuteQuery('EXECUTE PROCEDURE CREATE_ACT_CASARE(:DOCID)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  Result := True;
end;

procedure TfrmListofJurnalGoodsDialog.Prepare;
begin
   IBCQueryJurnal.ParamByName('DOCID').AsInteger := FDocID;
   IBCQueryJurnal.Open;
end;

procedure TfrmListofJurnalGoodsDialog.WhenCancelForm;
begin
  inherited;

end;

end.
