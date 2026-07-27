unit frmDocTypeDefaultsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, StdCtrls,

  cxDBLookupComboBox,
  cxButtonEdit, DB, IBC, Buttons, cxDBEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxCheckBox, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxTextEdit,
  cxMaskEdit;

type
  TfrmDocTypeDefaultsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edDocType: TEdit;
    gbDT: TGroupBox;
    beDT_NAME: TcxButtonEdit;
    gbCT: TGroupBox;
    beCT_NAME: TcxButtonEdit;
    gbGeneral: TGroupBox;
    IBCQueryDefaults: TIBCQuery;
    IBCDataSourceDefaults: TIBCDataSource;
    lcbSC: TcxDBLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    lcbCURRENCYID: TcxDBLookupComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    Label7: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    Label8: TLabel;
    lcbCTDEP: TcxDBLookupComboBox;
    Label10: TLabel;
    edFirma: TEdit;
    sbClearDT: TSpeedButton;
    sbClearCT: TSpeedButton;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbClearDTClick(Sender: TObject);
    procedure sbClearCTClick(Sender: TObject);
  private
    { Private declarations }
    fDocTypeID: integer;
    FFirmaID: integer;
    procedure SetDocTypeID(const Value: integer);
    procedure SetDocTypeTitle(const Value: string);
    procedure SetFirmaID(const Value: integer);
    function CheckParams: Boolean;
    procedure SelectDT;
    procedure SelectCT;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property DocTypeID: integer read FDocTypeID write SetDocTypeID;
    property DocTypeTitle: string write SetDocTypeTitle;
    property FirmaID: integer read FFirmaID write SetFirmaID;
  end;

implementation

uses
  DataModuleDB, frmCustomersDlg, SWNCustomersTypesUnit;

{$R *.dfm}

{ TfrmDocTypeDefaultsDlg }

procedure TfrmDocTypeDefaultsDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmDocTypeDefaultsDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmDocTypeDefaultsDlg.CheckParams: Boolean;
begin
  Result := True;
end;

function TfrmDocTypeDefaultsDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    IBCQueryDefaults.FieldByName('DOCTYPEID').AsInteger := fDocTypeID;
    IBCQueryDefaults.FieldByName('FIRMA').AsInteger := dmDB.CurrentFirma;
    IBCQueryDefaults.Post;
    IBCQueryDefaults.UpdateTransaction.Commit;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmDocTypeDefaultsDlg.Prepare;
begin
  inherited;

  edFirma.Text := dmDB.CurrentFirmaName;

     // open data
  IBCQueryDefaults.UpdateTransaction.StartTransaction;
  try
    IBCQueryDefaults.ParamByName('doctype').AsInteger := fDocTypeID;
    IBCQueryDefaults.ParamByName('firma').AsInteger := dmDB.CurrentFirma;
    IBCQueryDefaults.Active := True;
    IBCQueryDefaults.Edit;
    if IBCQueryDefaults.FieldByName('SC').IsNull then
      IBCQueryDefaults.FieldByName('SC').AsInteger := -1;
    if IBCQueryDefaults.FieldByName('CURRENCYID').IsNull then
      IBCQueryDefaults.FieldByName('CURRENCYID').asInteger := 498;
    if IBCQueryDefaults.FieldByName('DT').IsNull then
    begin
      IBCQueryDefaults.FieldByName('DT').asInteger := dmDB.CurrentFirma;
      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.CurrentFirma);
    end
    else
      beDT_NAME.Text := IBCQueryDefaults.FieldByName('DT_NAME').AsString;

    if IBCQueryDefaults.FieldByName('FLG_ACNT').IsNull then
      IBCQueryDefaults.FieldByName('FLG_ACNT').AsInteger := 0;
    if IBCQueryDefaults.FieldByName('FLG_ACNT_DISABLED').IsNull then
      IBCQueryDefaults.FieldByName('FLG_ACNT_DISABLED').AsInteger := 0;


        // open data sources
    dmDB.OpenAnalyticsDataSource(fDocTypeID);
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.IBCQueryStocks.Active := True;
        // DT
    beCT_NAME.Text := IBCQueryDefaults.FieldByName('CT_NAME').AsString;

  except
    IBCQueryDefaults.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmDocTypeDefaultsDlg.sbClearCTClick(Sender: TObject);
begin
  IBCQueryDefaults.FieldByName('CT').Value := Null;
  beCT_NAME.Text := '';
end;

procedure TfrmDocTypeDefaultsDlg.sbClearDTClick(Sender: TObject);
begin
  IBCQueryDefaults.FieldByName('DT').Value := Null;
  beDT_NAME.Text := '';
end;

procedure TfrmDocTypeDefaultsDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(IBCQueryDefaults.FieldByName('CT').asInteger, False, 0, 'Alege clientul implicit') then
    begin
      IBCQueryDefaults.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmDocTypeDefaultsDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(IBCQueryDefaults.FieldByName('DT').asInteger, False, 0, 'Alege organizatia implicita') then
    begin
      IBCQueryDefaults.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmDocTypeDefaultsDlg.SetDocTypeID(const Value: integer);
begin
  FDocTypeID := Value;
end;

procedure TfrmDocTypeDefaultsDlg.SetDocTypeTitle(const Value: string);
begin
  edDocType.Text := Value;
end;

procedure TfrmDocTypeDefaultsDlg.SetFirmaID(const Value: integer);
begin
  FFirmaID := Value;
end;

procedure TfrmDocTypeDefaultsDlg.WhenCancelForm;
begin
  IBCQueryDefaults.Cancel;
  IBCQueryDefaults.UpdateTransaction.Rollback;
end;

end.

