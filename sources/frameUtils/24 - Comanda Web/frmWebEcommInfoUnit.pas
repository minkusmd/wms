unit frmWebEcommInfoUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxScrollbarAnnotations, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxInplaceContainer, cxVGrid, cxDBVGrid,
  Data.DB, MemDS, DBAccess, IBC, cxMemo;

type
  TfrmWebEcommInfoDialog = class(TSWNBaseFormClass)
    IBCDataSource1: TIBCDataSource;
    IBCQuery1: TIBCQuery;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    btnClose: TcxButton;
    cxDBVerticalGrid1TRANSACTIONID: TcxDBEditorRow;
    cxDBVerticalGrid1TRANSACTIONRESULT: TcxDBEditorRow;
    cxDBVerticalGrid1REGISTERDATE: TcxDBEditorRow;
    cxDBVerticalGrid1SUBMITDATE: TcxDBEditorRow;
    cxDBVerticalGrid1SHOPPINGCARTOBJECTS: TcxDBEditorRow;
    cxDBVerticalGrid1DOCID: TcxDBEditorRow;
    cxDBVerticalGrid1AMOUNT: TcxDBEditorRow;
    cxDBVerticalGrid1STATUS: TcxDBEditorRow;
    cxDBVerticalGrid1MESSAGE: TcxDBEditorRow;
    cxDBVerticalGrid1IP: TcxDBEditorRow;
    cxDBVerticalGrid1UANCIRC_RESERVCODE: TcxDBEditorRow;
  private
    FDocID: Integer;
    procedure SetDocID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    property DocID: Integer read FDocID write SetDocID;
    { Public declarations }
  end;

var
  frmWebEcommInfoDialog: TfrmWebEcommInfoDialog;

implementation

{$R *.dfm}

{ TfrmWebEcommInfoDialog }

procedure TfrmWebEcommInfoDialog.Prepare;
begin
    IBCQuery1.Connection := fIBCConnection;
    IBCQuery1.ParamByName('DOCID').AsInteger := FDocID;
    IBCQuery1.Open;

end;

procedure TfrmWebEcommInfoDialog.SetDocID(const Value: Integer);
begin
  FDocID := Value;
end;

procedure TfrmWebEcommInfoDialog.SetupSecurityItems;
begin
  inherited;

end;

end.
