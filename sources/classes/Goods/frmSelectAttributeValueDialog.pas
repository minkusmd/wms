unit frmSelectAttributeValueDialog;

(* Dialog de selectie a unei valori din dictionarul TS_ATTRIBUTE_VALUE pentru
   un atribut dat (AttrID). Returneaza textul ales (SelectedValueRo/Ru).

   Pe langa "Valoare noua", dialogul permite si gestionarea dictionarului:
   - Modifica valoarea (editeaza randul curent);
   - Sterge valoarea (scoate randul din dictionar);
   - Uneste valorile (selectie multipla): valorile produselor care folosesc
     valorile-sursa (text VALUE_RO in TS_GOODS_ATTRIBUTE) sunt mutate pe valoarea
     tinta (randul focusat), iar valorile-sursa se sterg din dictionar.

   "Valoare manuala" returneaza un text introdus de utilizator FARA a-l adauga
   in dictionar (util cand valoarea e unicat pentru un singur produs). *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
    cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData;

type
    TfrmSelectAttributeValueDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryValues: TIBCQuery;
        IBCDataSourceValues: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        cxGridVal: TcxGrid;
        cxGridValTable: TcxGridDBTableView;
        cxGridValLevel: TcxGridLevel;
        cxGridVal_VALUEID: TcxGridDBColumn;
        cxGridVal_VALUE_RO: TcxGridDBColumn;
        cxGridVal_VALUE_RU: TcxGridDBColumn;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        btnNewValue: TcxButton;
        btnEditValue: TcxButton;
        btnDeleteValue: TcxButton;
        btnMergeValues: TcxButton;
        btnManualValue: TcxButton;
        procedure cxGridValTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
        procedure btnNewValueClick(Sender: TObject);
        procedure btnEditValueClick(Sender: TObject);
        procedure btnDeleteValueClick(Sender: TObject);
        procedure btnMergeValuesClick(Sender: TObject);
        procedure btnManualValueClick(Sender: TObject);
    private
        FAttrID: Integer;
        FAttrName: string;
        FSelectedValueRo: string;
        FSelectedValueRu: string;
        FManualEntered: Boolean;
        procedure ExecUpdSql(const ASql: string; const AParams: array of Variant);
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        property AttrID: Integer read FAttrID write FAttrID;
        property AttrName: string read FAttrName write FAttrName;
        property SelectedValueRo: string read FSelectedValueRo;
        property SelectedValueRu: string read FSelectedValueRu;
    end;

implementation

uses
    DataModuleDB, frmAttributeValueEditorDialog, frmManualAttributeValueDialog;

{$R *.dfm}

{ TfrmSelectAttributeValueDlg }

procedure TfrmSelectAttributeValueDlg.Prepare;
begin
    FManualEntered := False;
    dtDialogTitle.Text := 'Valori pentru atributul: ' + FAttrName;
    IBCQueryValues.Close;
    IBCQueryValues.Connection := dmDB.IBCConnection;
    IBCQueryValues.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryValues.ParamByName('attrid').AsInteger := FAttrID;
    IBCQueryValues.Open;
end;

{ Executa un statement in tranzactia de update a dialogului. Parametrii se
  atribuie pozitional, in ordinea aparitiei in SQL. }
procedure TfrmSelectAttributeValueDlg.ExecUpdSql(const ASql: string;
    const AParams: array of Variant);
var
    q: TIBCSQL;
    i: Integer;
begin
    q := TIBCSQL.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.Transaction := IBCTransactionUpdate;
        q.SQL.Text := ASql;
        for i := 0 to High(AParams) do
            q.Params[i].Value := AParams[i];
        if not IBCTransactionUpdate.Active then
            IBCTransactionUpdate.StartTransaction;
        q.Execute;
    finally
        q.Free;
    end;
end;

procedure TfrmSelectAttributeValueDlg.btnNewValueClick(Sender: TObject);
var
    d: TfrmAttributeValueEditorDlg;
begin
    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    d := TfrmAttributeValueEditorDlg.Create(Self, IBCQueryValues, IBCDataSourceValues);
    try
        d.AttrID := FAttrID;
        d.CreateNewItem := True;
        if d.ShowModal = mrOk then
        begin
            { valoarea noua devine imediat disponibila in dictionar }
            if IBCTransactionUpdate.Active then
                IBCTransactionUpdate.Commit;
            IBCQueryValues.Refresh;
            IBCQueryValues.Last;
        end
        else
        begin
            if IBCTransactionUpdate.Active then
                IBCTransactionUpdate.Rollback;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmSelectAttributeValueDlg.btnEditValueClick(Sender: TObject);
var
    d: TfrmAttributeValueEditorDlg;
    editedId: Integer;
begin
    if IBCQueryValues.IsEmpty then
        Exit;
    editedId := IBCQueryValues.FieldByName('VALUEID').AsInteger;

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    d := TfrmAttributeValueEditorDlg.Create(Self, IBCQueryValues, IBCDataSourceValues);
    try
        d.AttrID := FAttrID;
        d.CreateNewItem := False;
        if d.ShowModal = mrOk then
        begin
            if IBCTransactionUpdate.Active then
                IBCTransactionUpdate.Commit;
            IBCQueryValues.Refresh;
            IBCQueryValues.Locate('VALUEID', editedId, []);
        end
        else
        begin
            if IBCTransactionUpdate.Active then
                IBCTransactionUpdate.Rollback;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmSelectAttributeValueDlg.btnDeleteValueClick(Sender: TObject);
begin
    if IBCQueryValues.IsEmpty then
        Exit;
    if MessageDlg(Format('Stergeti valoarea "%s" din dictionar?',
        [IBCQueryValues.FieldByName('VALUE_RO').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;
    try
        IBCQueryValues.Delete;
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Commit;
    except
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Rollback;
        raise;
    end;
end;

{ Uneste valorile selectate (>= 2) in valoarea tinta = randul focusat.
  Valorile produselor (text VALUE_RO in TS_GOODS_ATTRIBUTE) care folosesc o
  valoare-sursa sunt mutate pe valoarea tinta, apoi valorile-sursa se sterg din
  dictionar. }
procedure TfrmSelectAttributeValueDlg.btnMergeValuesClick(Sender: TObject);
var
    cnt, i, n: Integer;
    targetId: Integer;
    targetRo, targetRu: string;
    rec: TcxCustomGridRecord;
    srcIds: array of Integer;
    srcRos: array of string;
    vid: Integer;
begin
    cnt := cxGridValTable.Controller.SelectedRecordCount;
    if cnt < 2 then
    begin
        ShowMessage('Selectati cel putin doua valori pentru unire ' +
            '(Ctrl/Shift + click pe randuri).');
        Exit;
    end;

    { valoarea tinta = randul curent (focusat) din dictionar }
    targetId := IBCQueryValues.FieldByName('VALUEID').AsInteger;
    targetRo := IBCQueryValues.FieldByName('VALUE_RO').AsString;
    targetRu := IBCQueryValues.FieldByName('VALUE_RU').AsString;

    { colecteaza sursele (toate selectate, mai putin tinta) inainte de a
      modifica datele, ca sa nu invalidam recordurile grilei }
    SetLength(srcIds, cnt);
    SetLength(srcRos, cnt);
    n := 0;
    for i := 0 to cnt - 1 do
    begin
        rec := cxGridValTable.Controller.SelectedRecords[i];
        vid := rec.Values[cxGridVal_VALUEID.Index];
        if vid = targetId then
            Continue;
        srcIds[n] := vid;
        srcRos[n] := VarToStr(rec.Values[cxGridVal_VALUE_RO.Index]);
        Inc(n);
    end;

    if n = 0 then
    begin
        ShowMessage('Selectia contine doar valoarea tinta.');
        Exit;
    end;

    if MessageDlg(Format(
        'Uniti %d valori in valoarea "%s"?'#13#10 +
        'Valorile produselor vor fi mutate pe aceasta valoare, iar celelalte ' +
        'valori vor fi sterse din dictionar.', [n, targetRo]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;
    try
        { INTAI: muta valorile TUTUROR produselor de pe valorile-sursa pe
          valoarea tinta (migrarea atributelor vechi pe cea noua) }
        for i := 0 to n - 1 do
            ExecUpdSql(
                'UPDATE TS_GOODS_ATTRIBUTE SET VALUE_RO = :tro, VALUE_RU = :tru ' +
                'WHERE ATTRID = :aid AND VALUE_RO = :sro',
                [targetRo, targetRu, FAttrID, srcRos[i]]);
        { ABIA DUPA ce toate produsele sunt migrate, sterge valorile-sursa din
          dictionar }
        for i := 0 to n - 1 do
            ExecUpdSql('DELETE FROM TS_ATTRIBUTE_VALUE WHERE VALUEID = :vid',
                [srcIds[i]]);
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Commit;
    except
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Rollback;
        raise;
    end;

    IBCQueryValues.Refresh;
    IBCQueryValues.Locate('VALUEID', targetId, []);
end;

{ Valoare introdusa manual: se returneaza direct apelantului, fara a fi salvata
  in dictionarul TS_ATTRIBUTE_VALUE. }
procedure TfrmSelectAttributeValueDlg.btnManualValueClick(Sender: TObject);
var
    d: TfrmManualAttributeValueDlg;
begin
    d := TfrmManualAttributeValueDlg.Create(Self);
    try
        d.AttrName := FAttrName;
        if d.ShowModal = mrOk then
        begin
            FSelectedValueRo := d.ValueRo;
            FSelectedValueRu := d.ValueRu;
            FManualEntered := True;
            ModalResult := mrOk;
        end;
    finally
        d.Free;
    end;
end;

function TfrmSelectAttributeValueDlg.IsFormDataPosted: Boolean;
begin
    { valoarea manuala e deja stabilita, dictionarul nu mai conteaza }
    if FManualEntered then
    begin
        Result := True;
        Exit;
    end;

    Result := False;
    if IBCQueryValues.IsEmpty then
    begin
        ShowMessage('Atributul nu are valori definite. Adaugati valori in editorul tipului de produs.');
        Exit;
    end;
    FSelectedValueRo := IBCQueryValues.FieldByName('VALUE_RO').AsString;
    FSelectedValueRu := IBCQueryValues.FieldByName('VALUE_RU').AsString;
    Result := True;
end;

procedure TfrmSelectAttributeValueDlg.cxGridValTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    AHandled := True;
    ModalResult := mrOk;
end;

end.
