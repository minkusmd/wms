unit frmDispatchZonesDialog;

(* ============================================================================
   Dispecerat: nomenclatorul zonelor logistice (TS_LOGISTIC_ZONE, plan sect. 4).

   O zona e un sector, o localitate sau o grupare convenita de dispecer
   (Ciocana, Buiucani, Durlesti, Ialoveni ...). Adresele livrarilor si punctele
   de preluare primesc zona explicit; repartizarea curierilor merge pe zone.
   Codul e unic (se scrie cu majuscule de trigger). O zona folosita nu se
   sterge - se dezactiveaza.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxCheckBox, cxSpinEdit,
    cxDBData, dxScrollbarAnnotations, dxDateRanges, Vcl.Menus;

type
    TfrmDispatchZonesDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryZones: TIBCQuery;
        IBCDataSourceZones: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        cxGridZones: TcxGrid;
        cxGridZonesTable: TcxGridDBTableView;
        cxGridZonesLevel: TcxGridLevel;
        colZONEID: TcxGridDBColumn;
        colCODE: TcxGridDBColumn;
        colNAME: TcxGridDBColumn;
        colORDERNO: TcxGridDBColumn;
        colFLG_ACTIVE: TcxGridDBColumn;
        colNOTE: TcxGridDBColumn;
        btnAdd: TcxButton;
        btnDelete: TcxButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure btnAddClick(Sender: TObject);
        procedure btnDeleteClick(Sender: TObject);
        procedure IBCQueryZonesNewRecord(DataSet: TDataSet);
        procedure IBCQueryZonesBeforePost(DataSet: TDataSet);
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    DataModuleDB, DispatchCommonUnit, System.UITypes;

{$R *.dfm}

{ TfrmDispatchZonesDlg }

procedure TfrmDispatchZonesDlg.Prepare;
begin
    dtDialogTitle.Text := 'Zonele in care se grupeaza adresele de livrare si punctele de preluare';

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    IBCQueryZones.Connection := dmDB.IBCConnection;
    IBCQueryZones.Transaction := IBCTransactionUpdate;
    IBCQueryZones.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryZones.Open;
end;

procedure TfrmDispatchZonesDlg.btnAddClick(Sender: TObject);
begin
    if IBCQueryZones.State in dsEditModes then
        IBCQueryZones.Post;
    IBCQueryZones.Append;
    cxGridZones.SetFocus;
    colCODE.Focused := True;
end;

procedure TfrmDispatchZonesDlg.btnDeleteClick(Sender: TObject);
var
    used: Integer;
begin
    if IBCQueryZones.IsEmpty then
        Exit;
    if IBCQueryZones.State = dsInsert then
    begin
        IBCQueryZones.Cancel;
        Exit;
    end;

    used := VarAsType(DispatchExec(
        'SELECT (SELECT COUNT(*) FROM TDB_DISPATCH_STOP WHERE ZONEID = :Z1) + ' +
        '(SELECT COUNT(*) FROM TDB_DISPATCH_DELIVERY WHERE ZONEID = :Z2) + ' +
        '(SELECT COUNT(*) FROM TS_PICKUP_POINT WHERE ZONEID = :Z3) FROM RDB$DATABASE',
        ['Z1', 'Z2', 'Z3'],
        [IBCQueryZones.FieldByName('ZONEID').AsInteger, IBCQueryZones.FieldByName('ZONEID').AsInteger,
         IBCQueryZones.FieldByName('ZONEID').AsInteger]), varInteger);
    if used > 0 then
    begin
        ShowMessage('Zona este folosita in trasee, livrari sau puncte de preluare. ' +
            'Debifati "Activa" in loc sa o stergeti.');
        Exit;
    end;

    if MessageDlg(Format('Stergeti zona %s?', [IBCQueryZones.FieldByName('NAME').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    IBCQueryZones.Delete;
end;

procedure TfrmDispatchZonesDlg.IBCQueryZonesNewRecord(DataSet: TDataSet);
var
    maxOrder: Integer;
begin
    maxOrder := 0;
    with IBCQueryZones do
        if not IsEmpty then
            maxOrder := VarAsType(DispatchExec(
                'SELECT COALESCE(MAX(ORDERNO), 0) FROM TS_LOGISTIC_ZONE', [], []), varInteger);
    DataSet.FieldByName('ORDERNO').AsInteger := maxOrder + 10;
    DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
end;

procedure TfrmDispatchZonesDlg.IBCQueryZonesBeforePost(DataSet: TDataSet);
begin
    if Trim(DataSet.FieldByName('NAME').AsString) = '' then
        raise Exception.Create('Scrieti denumirea zonei.');
    if Trim(DataSet.FieldByName('CODE').AsString) = '' then
        DataSet.FieldByName('CODE').AsString := UpperCase(Copy(Trim(DataSet.FieldByName('NAME').AsString), 1, 32));
end;

function TfrmDispatchZonesDlg.IsFormDataPosted: Boolean;
begin
    if IBCQueryZones.State in dsEditModes then
        IBCQueryZones.Post;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;

    Result := True;
end;

procedure TfrmDispatchZonesDlg.WhenCancelForm;
begin
    if IBCQueryZones.State in dsEditModes then
        IBCQueryZones.Cancel;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
