unit uCrediteDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, DBAccess, IBC,
  MemDS, cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmCrediteDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarButton4: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton5: TdxBarButton;
    IBCQueryCredite: TIBCQuery;
    IBCDataSourceCredite: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid1DBTableView1UID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1MIN_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1MAX_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1PERCENT: TcxGridDBColumn;
    cxGrid1DBTableView1BUYER_COMISION: TcxGridDBColumn;
    cxGrid1DBTableView1MIN_MONTH: TcxGridDBColumn;
    cxGrid1DBTableView1MAX_MONTH: TcxGridDBColumn;
    cxGrid1DBTableView1PREPAY_PERCENT: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_ACTIVE: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
  private
    procedure ShowCreditEditor(fIsNewRecord: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;

  public
    { Public declarations }
  end;

implementation

uses
  uCrediteEditorDlg, uCreditePromoGoodsDlg, DataModuleAdditions, SWNUtils;

{$R *.dfm}

procedure TfrmCrediteDlg.dxBarButton1Click(Sender: TObject);
begin
  ShowCreditEditor(True);
end;

procedure TfrmCrediteDlg.dxBarButton2Click(Sender: TObject);
begin
  ShowCreditEditor(False);
end;

procedure TfrmCrediteDlg.dxBarButton3Click(Sender: TObject);
begin
  if (ShowAskDialog('Tipuri de credite', Format('Stergeti tipul de credit %d', [IBCQueryCredite.FieldByName('CREDITID').AsInteger]))=mrYes) then
//
//  if MessageDlg('Stergeti tipul de credit ?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then
  begin
    IBCQueryCredite.Delete;
  end;
end;

procedure TfrmCrediteDlg.dxBarButton4Click(Sender: TObject);
var
  dialog: TfrmCreditePromoGoodsDlg;
begin
  dialog := TfrmCreditePromoGoodsDlg.Create(Self, IBCQueryCredite.Connection);
  try
    dialog.UID := IBCQueryCredite.FieldByName('UID').AsInteger;
    dialog.showModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCrediteDlg.dxBarButton5Click(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfrmCrediteDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IBCQueryCredite.Close;
end;

{ TfrmCrediteDlg }

procedure TfrmCrediteDlg.Prepare;
begin
  inherited;
  IBCTrUpdate.DefaultConnection := fIBCConnection;
  IBCQueryCredite.Connection := fIBCConnection;
  IBCQueryCredite.UpdateTransaction := IBCTrUpdate;

  IBCQueryCredite.Open;
end;

procedure TfrmCrediteDlg.ShowCreditEditor(fIsNewRecord: Boolean);
var
  dialog: TfrmCrediteEditorDlg;
begin
  dialog := TfrmCrediteEditorDlg.Create(Self, IBCQueryCredite, IBCDataSourceCredite);
  try
    dialog.IsNewRecord := fIsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.
