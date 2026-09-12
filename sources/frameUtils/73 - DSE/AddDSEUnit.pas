unit AddDSEUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Data.DB, MemDS, DBAccess, IBC, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxDBEdit, cxCalc, DialogTitle, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel;

type
  TfrmDSE = class(TSWNCustomForm)
    qSysS: TIBCQuery;
    DSSysS: TIBCDataSource;
    cbDSEType: TcxDBLookupComboBox;
    edQty: TcxDBCalcEdit;
    edAmount: TcxDBCalcEdit;
    dtDialogTitle: TDialogTitle;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    edOrgID: TcxDBTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fDataSet : TIBCQuery;
    fDataSource : TIBCDataSource;
    fAddDSE:  boolean;
    procedure SetupQtyFields;
    function CheckParams: Boolean;
    procedure SetAddDSE(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const ADataSet: TIBCQuery; const ADataSource: TIBCDataSource; const ParentGoodsID: integer = -1); reintroduce;

    property AddDSE: Boolean read fAddDSE write SetAddDSE;
  end;

var
  frmDSE: TfrmDSE;

implementation

uses
  DataModuleDB, SWNSecurity, SWNValueStorageUnit, SWNConst, SWNUtils, SWNDBErrors;

{$R *.dfm}

{ TfrmDSE }

constructor TfrmDSE.Create(const AOwner: TComponent; const ADataSet: TIBCQuery; const ADataSource: TIBCDataSource;
  const ParentGoodsID: integer);
begin
inherited Create(AOwner);


  fDataSet := ADataSet;
  fDataSource := ADataSource;

  cbDSEType.DataBinding.DataSource := fDataSource;

  edQTY.DataBinding.DataSource := fDataSource;
//  edQTY2.DataBinding.DataSource := JurnalDataSource;
//  edQTY.Visible := False;
//  edQTY2.Visible := False;

  edAmount.DataBinding.DataSource := fDataSource;
  edOrgID.DataBinding.DataSource := fDataSource;
end;

procedure TfrmDSE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qSysS.Close;
end;

function TfrmDSE.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  with fDataSet do
  begin
      if (FieldByName('QTY').AsFloat <= 0) then
      begin
        AddErrorToStr(ErrorStr, 'Cantitatea trebuie sa fie mai mare ca 0!');
        edQTY.SetFocus;
      end;
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmDSE.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    try
      fDataSet.Post;
      fDataSet.UpdateTransaction.Commit;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmDSE.Prepare;
begin

  SetupQtyFields;


  fDataSet.UpdateTransaction.StartTransaction;
  try
    qSysS.Open;

    if FAddDSE then
    begin
      dtDialogTitle.Text := 'Introduce diapazonul de numere primite pentru DSE!';
      fDataSet.Append;
      fDataSet.FieldByName('ORGID').AsInteger := dmDB.GetOrgID(dmdb.CurrentFirma);
      fDataSet.FieldByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger;


      fDataSet.FieldByName('QTY').asFloat := 1;
      fDataSet.FieldByName('AMOUNT').AsCurrency := 0;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
    end;
  except
    if fDataSet.State in dsEditModes then
      fDataSet.Cancel;
    fDataSet.UpdateTransaction.Rollback;

    raise;
  end;
end;

procedure TfrmDSE.SetAddDSE(const Value: Boolean);
begin
  fAddDSE := Value;
end;

procedure TfrmDSE.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
  TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmDSE.SetupSecurityItems;
begin
  inherited;
end;

procedure TfrmDSE.WhenCancelForm;
begin

  if fDataSet.State in dsEditModes then
    fDataSet.Cancel;
  fDataSet.UpdateTransaction.Rollback;
end;

end.
