unit frmSelectFilterValueDialog;

{ Picker pentru valorile unui filtru (TS_FILTER_PARAMS).
  Se deschide din tab-ul de filtre al editorului de produs.

  Spre deosebire de vechiul picker de atribute, aici se intoarce
  FILTERPARAMID - produsul se leaga de valoare prin id, nu prin text
  (TS_GOODS_FILTERS tine FILTERPARAMID). Textul se intoarce doar pentru afisare.

  Butonul "Valoare noua" adauga valoarea in dictionarul filtrului si o
  selecteaza imediat. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
  cxGrid, cxButtons, cxTextEdit, cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
  TfrmSelectFilterValueDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTransactionSelect: TIBCTransaction;
    IBCQueryValues: TIBCQuery;
    IBCDataSourceValues: TIBCDataSource;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnNewValue: TcxButton;
    cxGridVal: TcxGrid;
    cxGridValTable: TcxGridDBTableView;
    cxGridValLevel: TcxGridLevel;
    cxGridVal_PARAM_VALUE: TcxGridDBColumn;
    cxGridVal_PARAM_VALUE_RUS: TcxGridDBColumn;
    procedure btnNewValueClick(Sender: TObject);
    procedure cxGridValTableDblClick(Sender: TObject);
  private
    FFilterID: Integer;
    FFilterName: string;
    FSelectedParamID: Integer;
    FSelectedValueRo: string;
    FSelectedValueRu: string;
    FExternalTr: TIBCTransaction;
    FNewValueEntered: Boolean;
    function ActiveTr: TIBCTransaction;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Tranzactia in care se lucreaza. Cine deschide pickerul din editorul de produs
      TREBUIE sa o dea pe a editorului: valoarea noua se insereaza in
      TS_FILTER_PARAMS, iar legarea ei la produs se face in aceeasi tranzactie.
      Altfel legatura pica pe FK_TS_GOODS_FILTERS_2 (FILTERID, FILTERPARAMID),
      pentru ca valoarea inca nu e vizibila din afara tranzactiei pickerului. }
    property ExternalTransaction: TIBCTransaction read FExternalTr write FExternalTr;
    property FilterID: Integer read FFilterID write FFilterID;
    property FilterName: string read FFilterName write FFilterName;
    property SelectedParamID: Integer read FSelectedParamID;
    property SelectedValueRo: string read FSelectedValueRo;
    property SelectedValueRu: string read FSelectedValueRu;
  end;

implementation

uses
  SWNUtils, DataModuleDB, System.UITypes;

{$R *.dfm}

{ TfrmSelectFilterValueDlg }

function TfrmSelectFilterValueDlg.ActiveTr: TIBCTransaction;
begin
  if Assigned(FExternalTr) then
    Result := FExternalTr
  else
    Result := IBCTransactionSelect;
end;

procedure TfrmSelectFilterValueDlg.Prepare;
var
  tr: TIBCTransaction;
begin
  FSelectedParamID := 0;
  FSelectedValueRo := '';
  FSelectedValueRu := '';
  FNewValueEntered := False;

  tr := ActiveTr;
  if not tr.Active then
    tr.StartTransaction;
  IBCQueryValues.Transaction := tr;

  IBCQueryValues.ParamByName('fid').AsInteger := FFilterID;
  IBCQueryValues.Open;

  DialogTitle1.Text := 'Valorile filtrului: ' + FFilterName;
end;

procedure TfrmSelectFilterValueDlg.btnNewValueClick(Sender: TObject);
var
  vro, vru: string;
begin
  { Pickerul NU mai scrie in baza. Intoarce doar textul, iar cel care l-a deschis
    (frame-ul produsului) creeaza valoarea in dictionar SI o leaga de produs in
    aceeasi tranzactie, prin EnsureParamID.
    Motivul: cand inserarea se facea aici, valoarea ajungea intr-o tranzactie,
    iar legatura la produs in alta, si insertul in TS_GOODS_FILTERS pica pe
    FK_TS_GOODS_FILTERS_2 - valoarea inca nu era vizibila. }
  vro := '';
  if not InputQuery('Valoare noua', 'Valoarea (RO):', vro) then
    Exit;
  vro := Trim(vro);
  if vro = '' then
    Exit;

  vru := vro;
  InputQuery('Valoare noua', 'Valoarea (RU):', vru);

  FSelectedParamID := 0;          { 0 = valoare noua, inca inexistenta in dictionar }
  FSelectedValueRo := vro;
  FSelectedValueRu := Trim(vru);
  FNewValueEntered := True;
  ModalResult := mrOk;
end;

procedure TfrmSelectFilterValueDlg.cxGridValTableDblClick(Sender: TObject);
begin
  if IBCQueryValues.Active and (not IBCQueryValues.IsEmpty) then
    ModalResult := mrOk;
end;

function TfrmSelectFilterValueDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if FNewValueEntered then
  begin
    Result := True;   { textul introdus manual are prioritate fata de randul focusat }
    Exit;
  end;
  if (not IBCQueryValues.Active) or IBCQueryValues.IsEmpty then
  begin
    ShowMessage('Selectati o valoare din lista.');
    Exit;
  end;
  FSelectedParamID := IBCQueryValues.FieldByName('FILTERPARAMID').AsInteger;
  FSelectedValueRo := IBCQueryValues.FieldByName('PARAM_VALUE').AsString;
  FSelectedValueRu := IBCQueryValues.FieldByName('PARAM_VALUE_RUS').AsString;
  Result := True;
end;

procedure TfrmSelectFilterValueDlg.WhenCancelForm;
begin
  FSelectedParamID := 0;
  { tranzactia externa apartine editorului de produs - nu o atingem }
  if (not Assigned(FExternalTr)) and IBCTransactionSelect.Active then
    IBCTransactionSelect.Rollback;
end;

end.
