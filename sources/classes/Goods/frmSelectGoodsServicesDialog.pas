unit frmSelectGoodsServicesDialog;

(* ============================================================================
  Alegerea SERVICIILOR ADIACENTE la adaugarea unui produs intr-un document de
  vanzare. Lista vine din SP_GET_GOODS_SERVICES (vezi SWNGoodsServicesUnit):
    - serviciile "implicite" vin bifate;
    - cele "obligatorii" sunt bifate si nu pot fi debifate;
    - pretul (in moneda documentului) poate fi corectat inainte de adaugare.
  Dialogul nu scrie in baza: apelantul citeste bifele si preturile.
  Grila e nelegata (unbound).
  ============================================================================ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Vcl.Menus, System.UITypes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons,
  dxScrollbarAnnotations, dxDateRanges, cxCheckBox, cxCurrencyEdit, cxTextEdit;

type
  TfrmSelectGoodsServicesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    lbInfo: TLabel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridLevel: TcxGridLevel;
    colSelected: TcxGridColumn;
    colTitle: TcxGridColumn;
    colPrice: TcxGridColumn;
    colServiceID: TcxGridColumn;
    colUMID: TcxGridColumn;
    colRequired: TcxGridColumn;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxGridTableEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
  private
    FGoodsTitle: string;
    FCurrencyTitle: string;
    FQty: Double;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    procedure AddService(const AServiceID, AUMID: Integer; const ATitle: string;
      const APrice: Double; const ADefault, ARequired: Boolean);
    function ServiceCount: Integer;
    function IsSelected(const AIndex: Integer): Boolean;
    function ServiceID(const AIndex: Integer): Integer;
    function UMID(const AIndex: Integer): Integer;
    function Price(const AIndex: Integer): Double;
    property GoodsTitle: string read FGoodsTitle write FGoodsTitle;
    property CurrencyTitle: string read FCurrencyTitle write FCurrencyTitle;
    { cantitatea produsului = cantitatea fiecarui serviciu adaugat }
    property Qty: Double read FQty write FQty;
  end;

implementation

{$R *.dfm}

function VarIsTrue(const V: Variant): Boolean;
begin
  Result := (not (VarIsNull(V) or VarIsEmpty(V))) and (V = True);
end;

{ TfrmSelectGoodsServicesDlg }

procedure TfrmSelectGoodsServicesDlg.AddService(const AServiceID, AUMID: Integer;
  const ATitle: string; const APrice: Double; const ADefault, ARequired: Boolean);
var
  r: Integer;
  dc: TcxCustomDataController;
begin
  dc := cxGridTable.DataController;
  r := dc.AppendRecord;
  dc.Values[r, colServiceID.Index] := AServiceID;
  dc.Values[r, colUMID.Index] := AUMID;
  dc.Values[r, colRequired.Index] := ARequired;
  dc.Values[r, colSelected.Index] := ADefault or ARequired;
  if ARequired then
    dc.Values[r, colTitle.Index] := ATitle + '  (obligatoriu)'
  else
    dc.Values[r, colTitle.Index] := ATitle;
  dc.Values[r, colPrice.Index] := APrice;
end;

procedure TfrmSelectGoodsServicesDlg.Prepare;
begin
  DialogTitle1.Text := 'Produs: ' + FGoodsTitle;
  if FCurrencyTitle <> '' then
    colPrice.Caption := 'Pret, ' + FCurrencyTitle;
  lbInfo.Caption := Format('Bifati serviciile de adaugat in document. Cantitatea fiecarui ' +
    'serviciu = cantitatea produsului (%s).', [FormatFloat('0.##', FQty)]);
end;

{ serviciile obligatorii nu pot fi debifate }
procedure TfrmSelectGoodsServicesDlg.cxGridTableEditing(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; var AAllow: Boolean);
var
  rec: Integer;
begin
  if AItem <> colSelected then
    Exit;
  rec := cxGridTable.DataController.FocusedRecordIndex;
  if (rec >= 0) and VarIsTrue(cxGridTable.DataController.Values[rec, colRequired.Index]) then
    AAllow := False;
end;

function TfrmSelectGoodsServicesDlg.IsFormDataPosted: Boolean;
var
  i: Integer;
  dc: TcxCustomDataController;
  v: Variant;
begin
  Result := False;
  dc := cxGridTable.DataController;
  dc.PostEditingData;
  for i := 0 to dc.RecordCount - 1 do
  begin
    if VarIsTrue(dc.Values[i, colRequired.Index]) then
      dc.Values[i, colSelected.Index] := True;
    if not VarIsTrue(dc.Values[i, colSelected.Index]) then
      Continue;
    v := dc.Values[i, colPrice.Index];
    if VarIsNull(v) or VarIsEmpty(v) or (Double(v) < 0) then
    begin
      MessageDlg(Format('Pret invalid la serviciul [%s].', [VarToStr(dc.Values[i, colTitle.Index])]),
        mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
  Result := True;
end;

function TfrmSelectGoodsServicesDlg.ServiceCount: Integer;
begin
  Result := cxGridTable.DataController.RecordCount;
end;

function TfrmSelectGoodsServicesDlg.IsSelected(const AIndex: Integer): Boolean;
begin
  Result := VarIsTrue(cxGridTable.DataController.Values[AIndex, colSelected.Index]);
end;

function TfrmSelectGoodsServicesDlg.ServiceID(const AIndex: Integer): Integer;
begin
  Result := cxGridTable.DataController.Values[AIndex, colServiceID.Index];
end;

function TfrmSelectGoodsServicesDlg.UMID(const AIndex: Integer): Integer;
var
  v: Variant;
begin
  v := cxGridTable.DataController.Values[AIndex, colUMID.Index];
  if VarIsNull(v) or VarIsEmpty(v) then
    Result := 5 { UM "serviciu" }
  else
    Result := v;
end;

function TfrmSelectGoodsServicesDlg.Price(const AIndex: Integer): Double;
var
  v: Variant;
begin
  v := cxGridTable.DataController.Values[AIndex, colPrice.Index];
  if VarIsNull(v) or VarIsEmpty(v) then
    Result := 0
  else
    Result := v;
end;

end.
