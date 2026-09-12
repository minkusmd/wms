unit frameGoodsAttributesUnit;

(* ============================================================================
  Frame pentru completarea FILTRELOR pe un PRODUS concret.
  Se embedeaza intr-un TabSheet al editorului de continut (frmContentGoodsEditorDialog).

  ATENTIE la denumire: unitatea, clasa si metodele publice si-au pastrat numele
  vechi ("Attributes"), desi acum lucreaza cu filtre. Motivul e practic - asa nu
  trebuie atins frmContentGoodsEditorDialog (fisier UTF-8 cu BOM) doar ca sa
  schimbam un nume. Redenumirea se poate face separat, cand se retrag definitiv
  tabelele de atribute.

  Sursa datelor, dupa mutarea functionalului atributelor in filtre
  (vezi DB Model\plan_migrare_atribute_in_filtre.md):
  - randurile = SABLONUL tipului de produs: TS_GOODS_TYPE_FILTERS + TS_FILTERS;
  - valoarea de pe produs = TS_GOODS_FILTERS (LEFT JOIN -> gol daca lipseste),
    textul valorii venind din TS_FILTER_PARAMS.

  Diferenta importanta fata de vechiul sistem de atribute: produsul se leaga de
  valoare prin FILTERPARAMID, nu prin text. De aceea valorile introduse manual
  se adauga intai in dictionarul filtrului si abia apoi se leaga la produs.

  - Filtrele cu FLG_MULTI accepta mai multe valori (cate un rand per valoare,
    ORDERNO da ordinea); "Alege valoarea" ADAUGA, "Sterge valoarea" scoate doar
    randul curent.
  - Sablonul e sugestie: filtrele cu FLG_RECOMMENDED necompletate produc doar un
    avertisment la salvare, nu blocheaza.
  - Scrierile folosesc tranzactia editorului de produs -> "Renunta" le anuleaza.
  ============================================================================ *)

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxClasses,
    cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons,
    dxScrollbarAnnotations, dxDateRanges, Vcl.Menus, cxDBData;

type
    TframeGoodsAttributes = class(TFrame)
        IBCQueryAttrs: TIBCQuery;
        IBCDataSourceAttrs: TIBCDataSource;
        pnTop: TPanel;
        pnPreview: TPanel;
        lbPreviewRo: TLabel;
        lbPreviewRu: TLabel;
        cxGridAttrs: TcxGrid;
        cxGridAttrsTable: TcxGridDBTableView;
        cxGridAttrsLevel: TcxGridLevel;
        cxGridAttrs_FILTERID: TcxGridDBColumn;
        cxGridAttrs_NAME_RO: TcxGridDBColumn;
        cxGridAttrs_VALUE_RO: TcxGridDBColumn;
        cxGridAttrs_VALUE_RU: TcxGridDBColumn;
        cxGridAttrs_FLG_VARIATION: TcxGridDBColumn;
        cxGridAttrs_FLG_RECOMMENDED: TcxGridDBColumn;
        btnSetValue: TcxButton;
        btnClearValue: TcxButton;
        btnManualValue: TcxButton;
        procedure btnSetValueClick(Sender: TObject);
        procedure btnClearValueClick(Sender: TObject);
        procedure btnManualValueClick(Sender: TObject);
        procedure cxGridAttrsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
            var AHandled: Boolean);
    private
        FGoodsID: Integer;
        FGoodsTypeID: Integer;
        FTransaction: TIBCTransaction;
        function NewQuery: TIBCQuery;
        function NextParamID: Integer;
        function EnsureParamID(const AFilterID: Integer; const Vro, Vru: string): Integer;
        procedure ApplyValue(const AFilterID: Integer; const IsMulti: Boolean;
            const AParamID: Integer);
        procedure RefreshData;
    public
        { Incarca filtrele sablonului pentru produsul/tipul dat, in tranzactia editorului. }
        procedure LoadData(const AGoodsID, AGoodsTypeID: Integer; const ATr: TIBCTransaction);
        procedure RefreshPreview;
        { Lista filtrelor recomandate fara valoare (goala daca totul e completat). }
        function GetMissingRecommended: string;
    end;

{ Verificare independenta de frame: filtrele recomandate necompletate ale unui
  produs (pentru avertisment neblocant la salvare). }
function GetMissingRecommendedAttributes(const AGoodsID, AGoodsTypeID: Integer;
    const ATr: TIBCTransaction): string;

implementation

uses
    DataModuleDB, SWNAttributeNameUnit, frmSelectFilterValueDialog,
    frmManualAttributeValueDialog;

{$R *.dfm}

{ TframeGoodsAttributes }

procedure TframeGoodsAttributes.LoadData(const AGoodsID, AGoodsTypeID: Integer;
    const ATr: TIBCTransaction);
begin
    FGoodsID := AGoodsID;
    FGoodsTypeID := AGoodsTypeID;
    FTransaction := ATr;

    btnSetValue.Enabled := (FGoodsID > 0);
    btnClearValue.Enabled := (FGoodsID > 0);
    btnManualValue.Enabled := (FGoodsID > 0);

    if FGoodsID <= 0 then
    begin
        lbPreviewRo.Caption := 'Salvati mai intai produsul, apoi completati filtrele.';
        lbPreviewRu.Caption := '';
        IBCQueryAttrs.Close;
        Exit;
    end;

    RefreshData;
    RefreshPreview;
end;

procedure TframeGoodsAttributes.RefreshData;
begin
    IBCQueryAttrs.Close;
    IBCQueryAttrs.Connection := dmDB.IBCConnection;
    { IBDAC citeste pe Transaction si scrie pe UpdateTransaction. Daca a doua
      lipseste, scrierile pleaca in ALTA tranzactie, iar la Read Committed
      randurile inca necomise nu se vad din prima - exact motivul pentru care
      pica FK_TS_GOODS_FILTERS_2. Le legam pe amandoua la tranzactia editorului. }
    IBCQueryAttrs.Transaction := FTransaction;
    IBCQueryAttrs.UpdateTransaction := FTransaction;
    IBCQueryAttrs.ParamByName('gid').AsInteger := FGoodsID;
    IBCQueryAttrs.ParamByName('gtid').AsInteger := FGoodsTypeID;
    IBCQueryAttrs.Open;
end;

procedure TframeGoodsAttributes.RefreshPreview;
begin
    if FGoodsID <= 0 then
        Exit;
    lbPreviewRo.Caption := ComposeGoodsName(FGoodsID, cNameContext_Catalog, False, FTransaction);
    lbPreviewRu.Caption := ComposeGoodsName(FGoodsID, cNameContext_Catalog, True, FTransaction);
end;

{ Query cu AMBELE tranzactii legate la tranzactia editorului: citirea si
  scrierea trebuie sa vada acelasi context, altfel valoarea proaspat inserata nu
  e vizibila cand o legam de produs. }
function TframeGoodsAttributes.NewQuery: TIBCQuery;
begin
    if not FTransaction.Active then
        FTransaction.StartTransaction;
    Result := TIBCQuery.Create(nil);
    Result.Connection := dmDB.IBCConnection;
    Result.Transaction := FTransaction;
    Result.UpdateTransaction := FTransaction;
end;

{ Id nou pentru valoare. Generatorul e acelasi pe care il foloseste si triggerul
  TRG_TS_FILTER_PARAMS_BI (care completeaza doar cand campul vine NULL). }
function TframeGoodsAttributes.NextParamID: Integer;
var
    q: TIBCQuery;
begin
    q := NewQuery;
    try
        q.SQL.Text := 'SELECT NEXT VALUE FOR SQ_TS_FILTER_PARAMS_ID AS NEWID FROM RDB$DATABASE';
        q.Open;
        Result := q.FieldByName('NEWID').AsInteger;
    finally
        q.Free;
    end;
end;

{ Gaseste valoarea in dictionarul filtrului dupa text; daca lipseste, o adauga.
  Produsul se leaga de valoare prin id, deci o valoare manuala trebuie sa existe
  intai ca rand in TS_FILTER_PARAMS. }
function TframeGoodsAttributes.EnsureParamID(const AFilterID: Integer;
    const Vro, Vru: string): Integer;
var
    q: TIBCQuery;
begin
    Result := 0;
    if Trim(Vro) = '' then
        Exit;

    q := NewQuery;
    try
        q.SQL.Text :=
            'SELECT FILTERPARAMID, FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY ' +
            'FROM TS_FILTER_PARAMS ' +
            'WHERE FILTERID = :fid AND UPPER(TRIM(PARAM_VALUE)) = UPPER(TRIM(:vro))';
        q.SQLInsert.Text :=
            'INSERT INTO TS_FILTER_PARAMS ' +
            '(FILTERPARAMID, FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY) ' +
            'VALUES (:FILTERPARAMID, :FILTERID, :PARAM_VALUE, :PARAM_VALUE_RUS, :CREATED_BY)';
        q.SQLDelete.Text :=
            'DELETE FROM TS_FILTER_PARAMS ' +
            'WHERE FILTERID = :FILTERID AND FILTERPARAMID = :FILTERPARAMID';
        q.SQLRefresh.Text :=
            'SELECT FILTERPARAMID, FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY ' +
            'FROM TS_FILTER_PARAMS ' +
            'WHERE FILTERID = :FILTERID AND FILTERPARAMID = :FILTERPARAMID';
        { PK-ul tabelei e compus }
        q.KeyFields := 'FILTERID;FILTERPARAMID';

        q.ParamByName('fid').AsInteger := AFilterID;
        q.ParamByName('vro').AsString := Vro;
        q.Open;

        if not q.IsEmpty then
        begin
            Result := q.FieldByName('FILTERPARAMID').AsInteger;
            Exit;
        end;

        Result := NextParamID;
        q.Append;
        q.FieldByName('FILTERPARAMID').AsInteger := Result;
        q.FieldByName('FILTERID').AsInteger := AFilterID;
        q.FieldByName('PARAM_VALUE').AsString := Trim(Vro);
        if Trim(Vru) <> '' then
            q.FieldByName('PARAM_VALUE_RUS').AsString := Trim(Vru)
        else
            q.FieldByName('PARAM_VALUE_RUS').AsString := Trim(Vro);
        q.FieldByName('CREATED_BY').AsInteger := dmDB.CurrentUserID;
        q.Post;
    finally
        q.Free;
    end;
end;

{ Leaga valoarea de produs. Multi -> ADAUGA un rand (fara duplicate);
  single -> inlocuieste valoarea existenta. Totul pe acelasi query, deci pe
  aceeasi pereche de tranzactii. }
procedure TframeGoodsAttributes.ApplyValue(const AFilterID: Integer;
    const IsMulti: Boolean; const AParamID: Integer);
var
    q: TIBCQuery;
    nextOrd: Integer;
begin
    if AParamID <= 0 then
        Exit;

    q := NewQuery;
    try
        q.SQL.Text :=
            'SELECT GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY ' +
            'FROM TS_GOODS_FILTERS ' +
            'WHERE GOODSID = :gid AND FILTERID = :fid ORDER BY ORDERNO';
        q.SQLInsert.Text :=
            'INSERT INTO TS_GOODS_FILTERS ' +
            '(GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY) ' +
            'VALUES (:GOODSID, :FILTERID, :FILTERPARAMID, :ORDERNO, :FLAGS, :CREATEDBY)';
        q.SQLDelete.Text :=
            'DELETE FROM TS_GOODS_FILTERS ' +
            'WHERE GOODSID = :GOODSID AND FILTERID = :FILTERID ' +
            '  AND FILTERPARAMID = :FILTERPARAMID';
        q.SQLRefresh.Text :=
            'SELECT GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY ' +
            'FROM TS_GOODS_FILTERS ' +
            'WHERE GOODSID = :GOODSID AND FILTERID = :FILTERID ' +
            '  AND FILTERPARAMID = :FILTERPARAMID';
        q.KeyFields := 'GOODSID;FILTERID;FILTERPARAMID';

        q.ParamByName('gid').AsInteger := FGoodsID;
        q.ParamByName('fid').AsInteger := AFilterID;
        q.Open;

        nextOrd := 1;
        if IsMulti then
        begin
            while not q.Eof do
            begin
                if q.FieldByName('FILTERPARAMID').AsInteger = AParamID then
                begin
                    ShowMessage('Valoarea este deja adaugata la acest filtru.');
                    Exit;
                end;
                if q.FieldByName('ORDERNO').AsInteger >= nextOrd then
                    nextOrd := q.FieldByName('ORDERNO').AsInteger + 1;
                q.Next;
            end;
        end
        else
            { single: scoatem valorile vechi ale filtrului }
            while not q.IsEmpty do
                q.Delete;

        q.Append;
        q.FieldByName('GOODSID').AsInteger := FGoodsID;
        q.FieldByName('FILTERID').AsInteger := AFilterID;
        q.FieldByName('FILTERPARAMID').AsInteger := AParamID;
        q.FieldByName('ORDERNO').AsInteger := nextOrd;
        q.FieldByName('FLAGS').AsInteger := 0;
        q.FieldByName('CREATEDBY').AsInteger := dmDB.CurrentUserID;
        q.Post;
    finally
        q.Free;
    end;

    RefreshData;
    IBCQueryAttrs.Locate('FILTERID', AFilterID, []);
    RefreshPreview;
end;

procedure TframeGoodsAttributes.btnSetValueClick(Sender: TObject);
var
    d: TfrmSelectFilterValueDlg;
    filterId, paramId: Integer;
    isMulti: Boolean;
begin
    if (FGoodsID <= 0) or IBCQueryAttrs.IsEmpty then
        Exit;

    { filtru cu valoare libera -> nu are dictionar, mergem direct pe introducere manuala }
    if IBCQueryAttrs.FieldByName('FLG_FREE_VALUE').AsInteger = 1 then
    begin
        btnManualValueClick(Sender);
        Exit;
    end;

    filterId := IBCQueryAttrs.FieldByName('FILTERID').AsInteger;
    isMulti := IBCQueryAttrs.FieldByName('FLG_MULTI').AsInteger = 1;

    if not FTransaction.Active then
        FTransaction.StartTransaction;

    d := TfrmSelectFilterValueDlg.Create(Self);
    try
        { aceeasi tranzactie ca a editorului: o valoare adaugata din picker trebuie
          sa fie vizibila cand o legam de produs, altfel pica FK_TS_GOODS_FILTERS_2 }
        d.ExternalTransaction := FTransaction;
        d.FilterID := filterId;
        d.FilterName := IBCQueryAttrs.FieldByName('FILTERNAME').AsString;
        if d.ShowModal = mrOk then
        begin
            paramId := d.SelectedParamID;
            { 0 = valoare noua tastata in picker: o cream acum, in ACEEASI
              tranzactie in care o vom lega de produs }
            if paramId = 0 then
                paramId := EnsureParamID(filterId, d.SelectedValueRo, d.SelectedValueRu);
            ApplyValue(filterId, isMulti, paramId);
        end;
    finally
        d.Free;
    end;
end;

{ Valoare introdusa manual: se adauga in dictionarul filtrului (daca lipseste)
  si abia apoi se leaga la produs. }
procedure TframeGoodsAttributes.btnManualValueClick(Sender: TObject);
var
    d: TfrmManualAttributeValueDlg;
    filterId, paramId: Integer;
    isMulti: Boolean;
begin
    if (FGoodsID <= 0) or IBCQueryAttrs.IsEmpty then
        Exit;

    filterId := IBCQueryAttrs.FieldByName('FILTERID').AsInteger;
    isMulti := IBCQueryAttrs.FieldByName('FLG_MULTI').AsInteger = 1;

    d := TfrmManualAttributeValueDlg.Create(Self);
    try
        d.AttrName := IBCQueryAttrs.FieldByName('FILTERNAME').AsString;
        if not isMulti then
        begin
            d.ValueRo := IBCQueryAttrs.FieldByName('PARAM_VALUE').AsString;
            d.ValueRu := IBCQueryAttrs.FieldByName('PARAM_VALUE_RUS').AsString;
        end;
        if d.ShowModal = mrOk then
        begin
            paramId := EnsureParamID(filterId, d.ValueRo, d.ValueRu);
            ApplyValue(filterId, isMulti, paramId);
        end;
    finally
        d.Free;
    end;
end;

procedure TframeGoodsAttributes.btnClearValueClick(Sender: TObject);
var
    q: TIBCQuery;
    filterId, valOrd: Integer;
begin
    if (FGoodsID <= 0) or IBCQueryAttrs.IsEmpty then
        Exit;
    if IBCQueryAttrs.FieldByName('VAL_ORDERNO').IsNull then
        Exit; { filtrul nu are valoare pe randul curent }

    filterId := IBCQueryAttrs.FieldByName('FILTERID').AsInteger;
    valOrd := IBCQueryAttrs.FieldByName('VAL_ORDERNO').AsInteger;

    q := NewQuery;
    try
        q.SQL.Text :=
            'SELECT GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY ' +
            'FROM TS_GOODS_FILTERS ' +
            'WHERE GOODSID = :gid AND FILTERID = :fid AND ORDERNO = :ord';
        q.SQLDelete.Text :=
            'DELETE FROM TS_GOODS_FILTERS ' +
            'WHERE GOODSID = :GOODSID AND FILTERID = :FILTERID ' +
            '  AND FILTERPARAMID = :FILTERPARAMID';
        q.KeyFields := 'GOODSID;FILTERID;FILTERPARAMID';
        q.ParamByName('gid').AsInteger := FGoodsID;
        q.ParamByName('fid').AsInteger := filterId;
        q.ParamByName('ord').AsInteger := valOrd;
        q.Open;
        while not q.IsEmpty do
            q.Delete;
    finally
        q.Free;
    end;

    RefreshData;
    IBCQueryAttrs.Locate('FILTERID', filterId, []);
    RefreshPreview;
end;

procedure TframeGoodsAttributes.cxGridAttrsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    btnSetValueClick(btnSetValue);
    AHandled := True;
end;

function GetMissingRecommendedAttributes(const AGoodsID, AGoodsTypeID: Integer;
    const ATr: TIBCTransaction): string;
var
    q: TIBCQuery;
begin
    Result := '';
    if AGoodsID <= 0 then
        Exit;
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        if Assigned(ATr) then
            q.Transaction := ATr;
        q.SQL.Text :=
            'SELECT f.FILTERNAME FROM TS_GOODS_TYPE_FILTERS t ' +
            'JOIN TS_FILTERS f ON f.FILTERID = t.FILTERID ' +
            'LEFT JOIN TS_GOODS_FILTERS gf ON gf.FILTERID = t.FILTERID AND gf.GOODSID = :gid ' +
            'WHERE t.GOODSTYPEID = :gtid AND t.FLG_RECOMMENDED = 1 AND gf.GOODSID IS NULL ' +
            'ORDER BY t.ORDERNO';
        q.ParamByName('gid').AsInteger := AGoodsID;
        q.ParamByName('gtid').AsInteger := AGoodsTypeID;
        q.Open;
        while not q.Eof do
        begin
            if Result <> '' then
                Result := Result + ', ';
            Result := Result + q.FieldByName('FILTERNAME').AsString;
            q.Next;
        end;
    finally
        q.Free;
    end;
end;

function TframeGoodsAttributes.GetMissingRecommended: string;
begin
    Result := GetMissingRecommendedAttributes(FGoodsID, FGoodsTypeID, FTransaction);
end;

end.
