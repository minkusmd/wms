unit frmDocTypeStatesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Menus, cxTL, cxMaskEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxDBTL, cxTLData, Vcl.StdCtrls, cxButtons, dxBar, dxDateRanges, dxScrollbarAnnotations,
  DataModuleDB;

type
  TfrmDocTypeStatesDlg = class(TSWNCustomForm)
    IBCQueryDoctype_States: TIBCQuery;
    IBCDataSourceDoctype_States: TIBCDataSource;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbNewL1: TdxBarButton;
    bbNewL2: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_STATEID: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1_INT_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1_STR_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1_ORDERNO: TcxGridDBColumn;
    procedure bbNewL1Click(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    FDocTypeID: Integer;
    procedure SetDocTypeID(const Value: Integer);
    procedure ShowDocTypeStatesEditor(IsNewRecord: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property DocTypeID: Integer read FDocTypeID write SetDocTypeID;
    { Public declarations }
  end;

var
  frmDocTypeStatesDlg: TfrmDocTypeStatesDlg;

implementation

uses
  frmDocTypeStatesEditorDialog, DataModuleAdditions;

{$R *.dfm}

procedure TfrmDocTypeStatesDlg.bbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Doriti sa stergeti inregistrarea ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    IBCQueryDoctype_States.Delete;
  end;

end;

procedure TfrmDocTypeStatesDlg.bbEditClick(Sender: TObject);
begin
  ShowDocTypeStatesEditor(False);
end;

procedure TfrmDocTypeStatesDlg.bbNewL1Click(Sender: TObject);
begin
  ShowDocTypeStatesEditor(True);
end;

procedure TfrmDocTypeStatesDlg.Prepare;
begin

  IBCQueryDoctype_States.ParamByName('DOCTYPEID').AsInteger := DocTypeID;
  IBCQueryDoctype_States.Open;
end;

procedure TfrmDocTypeStatesDlg.ShowDocTypeStatesEditor(IsNewRecord: Boolean);
var
  dialog: TfrmDocTypeStatesEditorDlg;
begin
  dialog := TfrmDoctypeStatesEditorDlg.Create(self, IBCQueryDoctype_States, IBCDataSourceDoctype_States);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.DocTypeID := FDocTypeID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmDocTypeStatesDlg.SetDocTypeID(const Value: Integer);
begin
  FDocTypeID := Value;
end;

end.

