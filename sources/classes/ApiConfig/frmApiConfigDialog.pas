unit frmApiConfigDialog;

(* ============================================================================
   Configurari API externe - tabela TS_API_CONFIG.

   O linie = un parametru al unui API, identificat prin (API_CODE, PARAM_NAME).
   Aici stau credentialele care inainte erau hardcodate in cod:

     ULTRA_ESHOP -> BASE_URL / USERNAME / PASSWORD  (eshop.ultra.md/api)
     SCOP        -> BASE_URL / USERNAME / PASSWORD  (api.scop.md)

   Citite din WMS de TfrmGoodsForeignCodeDlg (dialogul de coduri furnizor).
   Valorile parametrilor "sensibili" (PASSWORD / TOKEN / SECRET / API_KEY) se
   afiseaza mascate; bifa "Arata valorile ascunse" le descopera.

   Modificarile se salveaza la OK (o singura tranzactie); Renunta le anuleaza.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxCheckBox,
    cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
    TfrmApiConfigDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryConfig: TIBCQuery;
        IBCDataSourceConfig: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        pnTop: TPanel;
        lbHint: TLabel;
        chkShowSecrets: TcxCheckBox;
        cxGridConfig: TcxGrid;
        cxGridConfigTable: TcxGridDBTableView;
        cxGridConfigLevel: TcxGridLevel;
        colCONFIGID: TcxGridDBColumn;
        colAPI_CODE: TcxGridDBColumn;
        colPARAM_NAME: TcxGridDBColumn;
        colPARAM_VALUE: TcxGridDBColumn;
        colSUPPLIERID: TcxGridDBColumn;
        colFLG_ACTIVE: TcxGridDBColumn;
        colNOTE: TcxGridDBColumn;
        colUPDATED_AT: TcxGridDBColumn;
        colUPDATED_BY: TcxGridDBColumn;
        btnAdd: TcxButton;
        btnDelete: TcxButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure btnAddClick(Sender: TObject);
        procedure btnDeleteClick(Sender: TObject);
        procedure chkShowSecretsPropertiesChange(Sender: TObject);
        procedure IBCQueryConfigNewRecord(DataSet: TDataSet);
        procedure IBCQueryConfigBeforePost(DataSet: TDataSet);
        procedure colPARAM_VALUEGetDataText(Sender: TcxCustomGridTableItem;
            ARecordIndex: Integer; var AText: string);
    private
        function IsSecretParam(const AParamName: string): Boolean;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    DataModuleDB;

{$R *.dfm}

const
    cMaskedValue = '********';

{ TfrmApiConfigDlg }

procedure TfrmApiConfigDlg.Prepare;
begin
    dtDialogTitle.Text := 'Parametrii si credentialele API-urilor externe (TS_API_CONFIG)';

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    IBCQueryConfig.Connection := dmDB.IBCConnection;
    IBCQueryConfig.Transaction := IBCTransactionUpdate;
    IBCQueryConfig.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryConfig.Open;
end;

{ Parametrii al caror continut nu trebuie sa se vada pe ecran. }
function TfrmApiConfigDlg.IsSecretParam(const AParamName: string): Boolean;
var
    name: string;
begin
    name := UpperCase(AParamName);
    Result := (Pos('PASSWORD', name) > 0) or (Pos('SECRET', name) > 0) or
              (Pos('TOKEN', name) > 0) or (Pos('API_KEY', name) > 0);
end;

{ Mascarea se face la afisare; valoarea reala ramane in camp si se vede in
  editor cand utilizatorul intra in celula. }
procedure TfrmApiConfigDlg.colPARAM_VALUEGetDataText(Sender: TcxCustomGridTableItem;
    ARecordIndex: Integer; var AText: string);
var
    paramName: Variant;
begin
    if chkShowSecrets.Checked or (AText = '') then
        Exit;

    paramName := Sender.GridView.DataController.Values[ARecordIndex, colPARAM_NAME.Index];
    if VarIsNull(paramName) or VarIsEmpty(paramName) then
        Exit;

    if IsSecretParam(VarToStr(paramName)) then
        AText := cMaskedValue;
end;

procedure TfrmApiConfigDlg.chkShowSecretsPropertiesChange(Sender: TObject);
begin
    cxGridConfigTable.LayoutChanged;
end;

procedure TfrmApiConfigDlg.btnAddClick(Sender: TObject);
begin
    IBCQueryConfig.Append;
    cxGridConfig.SetFocus;
end;

procedure TfrmApiConfigDlg.btnDeleteClick(Sender: TObject);
begin
    if IBCQueryConfig.IsEmpty then
        Exit;

    if MessageDlg(Format('Stergeti parametrul %s / %s?',
        [IBCQueryConfig.FieldByName('API_CODE').AsString,
         IBCQueryConfig.FieldByName('PARAM_NAME').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    IBCQueryConfig.Delete;
end;

procedure TfrmApiConfigDlg.IBCQueryConfigNewRecord(DataSet: TDataSet);
begin
    DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
end;

{ Codul API si numele parametrului se normalizeaza la majuscule: codul le cauta
  exact asa (API_CODE = 'ULTRA_ESHOP', PARAM_NAME = 'PASSWORD'). }
procedure TfrmApiConfigDlg.IBCQueryConfigBeforePost(DataSet: TDataSet);
var
    apiCode: string;
    paramName: string;
begin
    apiCode := UpperCase(Trim(DataSet.FieldByName('API_CODE').AsString));
    paramName := UpperCase(Trim(DataSet.FieldByName('PARAM_NAME').AsString));

    if apiCode = '' then
        raise Exception.Create('Completati codul API-ului (coloana "Cod API").');
    if paramName = '' then
        raise Exception.Create('Completati numele parametrului (coloana "Parametru").');

    DataSet.FieldByName('API_CODE').AsString := apiCode;
    DataSet.FieldByName('PARAM_NAME').AsString := paramName;
    DataSet.FieldByName('UPDATED_BY').AsString := Copy(dmDB.CurrentUserFullName, 1, 64);
end;

function TfrmApiConfigDlg.IsFormDataPosted: Boolean;
begin
    if IBCQueryConfig.State in dsEditModes then
        IBCQueryConfig.Post;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;

    Result := True;
end;

procedure TfrmApiConfigDlg.WhenCancelForm;
begin
    if IBCQueryConfig.State in dsEditModes then
        IBCQueryConfig.Cancel;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
