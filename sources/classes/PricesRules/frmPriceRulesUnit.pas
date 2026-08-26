unit frmPriceRulesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxBar, cxClasses, DBAccess, IBC, MemDS;

type
  TfrmPricesRulesDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    IBCQueryPriceRules: TIBCQuery;
    IBCDataSourcePriceRules: TIBCDataSource;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    bbClone: TdxBarButton;
    IBCTrLocalUpdate: TIBCTransaction;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbCloneClick(Sender: TObject);
  private
    FPGT_ID: Integer;
    procedure SetPGT_ID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property PGT_ID: Integer read FPGT_ID write SetPGT_ID;
    { Public declarations }
  end;

var
  frmPricesRulesDlg: TfrmPricesRulesDlg;

implementation

uses
  DataModuleAdditions, frmPriceRulesEditorUnit, System.UITypes, DataModuleDB, UtilsUnit, SWNUtils;

{$R *.dfm}

{ TfrmPricesRulesDlg }

procedure TfrmPricesRulesDlg.bbCloneClick(Sender: TObject);
var
  OLD_PGT: string;
begin
  if ShowAskDialog('Formarea preturilor', 'Datele curente vor fi sterse! Continuam ?') = mrYes then
  begin
    if InputQuery('Codul politiicii pentru tipul produsului:', 'Cod: ', OLD_PGT) then
    begin
      dmDB.ExecuteQuery('execute procedure SP_IMPORT_PRICE_RULES(:old_pgt, :new_pgt)', [OLD_PGT.ToInteger, PGT_ID]);
      IBCQueryPriceRules.Refresh;
    end;
  end;
end;

procedure TfrmPricesRulesDlg.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Formarea preturilor','Stergeti inregistrarea?') = mrYes then
    IBCQueryPriceRules.Delete;
end;

procedure TfrmPricesRulesDlg.bbEditClick(Sender: TObject);
var
  dialog: TfrmPriceRulesEditorDlg;
begin
  dialog := TfrmPriceRulesEditorDlg.Create(Self, IBCQueryPriceRules, IBCDataSourcePriceRules);
  try
    dialog.IsNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPricesRulesDlg.bbNewClick(Sender: TObject);
var
  dialog: TfrmPriceRulesEditorDlg;
begin
  dialog := TfrmPriceRulesEditorDlg.Create(Self, IBCQueryPriceRules, IBCDataSourcePriceRules);
  try
    dialog.IsNewRecord := True;
    dialog.PGT_ID := PGT_ID;
    dialog.LastPriceColumn := IBCQueryPriceRules.FieldValues['PRICECOLUMN'];
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPricesRulesDlg.Prepare;
begin
  inherited;
  IBCTrLocalUpdate.DefaultConnection := fIBCConnection;
  IBCQueryPriceRules.Transaction := fIBCConnection.DefaultTransaction;
  IBCQueryPriceRules.UpdateTransaction := IBCTrLocalUpdate;
  IBCQueryPriceRules.Close;
  IBCQueryPriceRules.ParamByName('PGT_ID').AsInteger := PGT_ID;
  IBCQueryPriceRules.Open;
end;

procedure TfrmPricesRulesDlg.SetPGT_ID(const Value: Integer);
begin
  FPGT_ID := Value;
end;

end.

