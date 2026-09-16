unit frmSupplierOrderRulesDialog;

(* ============================================================================
   Reguli de comanda prin intermediar - tabela TS_SUPPLIER_ORDER_RULE.

   La unii furnizori vedem stocul, dar comanda o plasam prin alt furnizor
   (pentru volum de achizitii si pret mai bun). Ex.: stoc la Ultra, comanda
   prin Furnizor-Prim. O regula = un furnizor cu stoc:

     STOCK_SUPPLIERID -> ORDER_SUPPLIERID (intermediarul implicit)
     PICKUP_FROM      0 = soferul ridica de la furnizorul cu stoc
                      1 = soferul ridica de la intermediar

   Regula da doar valorile implicite in TfrmSupplierPickupConfirmDlg;
   operatorul le poate schimba pentru fiecare ridicare.

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
    cxImageComboBox, cxDBData, dxScrollbarAnnotations, dxDateRanges, Vcl.Menus;

type
    TfrmSupplierOrderRulesDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryRules: TIBCQuery;
        IBCDataSourceRules: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        pnTop: TPanel;
        lbHint: TLabel;
        cxGridRules: TcxGrid;
        cxGridRulesTable: TcxGridDBTableView;
        cxGridRulesLevel: TcxGridLevel;
        colRULEID: TcxGridDBColumn;
        colSTOCK_SUPPLIER_NAME: TcxGridDBColumn;
        colORDER_SUPPLIER_NAME: TcxGridDBColumn;
        colPICKUP_FROM: TcxGridDBColumn;
        colFLG_ACTIVE: TcxGridDBColumn;
        colNOTE: TcxGridDBColumn;
        colUPDATED_AT: TcxGridDBColumn;
        colUPDATED_BY: TcxGridDBColumn;
        btnAdd: TcxButton;
        btnChangeStock: TcxButton;
        btnChangeOrder: TcxButton;
        btnDelete: TcxButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure btnAddClick(Sender: TObject);
        procedure btnChangeStockClick(Sender: TObject);
        procedure btnChangeOrderClick(Sender: TObject);
        procedure btnDeleteClick(Sender: TObject);
        procedure IBCQueryRulesNewRecord(DataSet: TDataSet);
        procedure IBCQueryRulesBeforePost(DataSet: TDataSet);
    private
        function SelectSupplier(const ACurrentID: Integer; const ATitle: string;
            out AID: Integer): Boolean;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    DataModuleDB, frmCustomersDlg, System.UITypes;

{$R *.dfm}

{ TfrmSupplierOrderRulesDlg }

procedure TfrmSupplierOrderRulesDlg.Prepare;
begin
    dtDialogTitle.Text := 'Furnizori la care vedem stocul, dar comandam prin alt furnizor';

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    IBCQueryRules.Connection := dmDB.IBCConnection;
    IBCQueryRules.Transaction := IBCTransactionUpdate;
    IBCQueryRules.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryRules.Open;
end;

function TfrmSupplierOrderRulesDlg.SelectSupplier(const ACurrentID: Integer; const ATitle: string;
    out AID: Integer): Boolean;
var
    dialog: TfrmCustomersDlg;
begin
    AID := 0;
    dialog := TfrmCustomersDlg.Create(Self);
    try
        Result := dialog.SelectCustomer(ACurrentID, False, 0, ATitle) and (dialog.CustomerID > 0);
        if Result then
            AID := dialog.CustomerID;
    finally
        dialog.Free;
    end;
end;

procedure TfrmSupplierOrderRulesDlg.btnAddClick(Sender: TObject);
var
    stockID, orderID: Integer;
begin
    if IBCQueryRules.State in dsEditModes then
        IBCQueryRules.Post;

    if not SelectSupplier(0, 'Furnizorul la care vedem stocul', stockID) then
        Exit;

    if IBCQueryRules.Locate('STOCK_SUPPLIERID', stockID, []) then
    begin
        ShowMessage('Pentru acest furnizor exista deja o regula - modificati-o pe cea existenta.');
        Exit;
    end;

    if not SelectSupplier(0, 'Furnizorul prin care comandam (intermediar)', orderID) then
        Exit;

    IBCQueryRules.Append;
    IBCQueryRules.FieldByName('STOCK_SUPPLIERID').AsInteger := stockID;
    IBCQueryRules.FieldByName('ORDER_SUPPLIERID').AsInteger := orderID;
    IBCQueryRules.Post;
end;

procedure TfrmSupplierOrderRulesDlg.btnChangeStockClick(Sender: TObject);
var
    id: Integer;
begin
    if IBCQueryRules.IsEmpty then
        Exit;
    if not SelectSupplier(IBCQueryRules.FieldByName('STOCK_SUPPLIERID').AsInteger,
        'Furnizorul la care vedem stocul', id) then
        Exit;

    IBCQueryRules.Edit;
    IBCQueryRules.FieldByName('STOCK_SUPPLIERID').AsInteger := id;
    IBCQueryRules.Post;
end;

procedure TfrmSupplierOrderRulesDlg.btnChangeOrderClick(Sender: TObject);
var
    id: Integer;
begin
    if IBCQueryRules.IsEmpty then
        Exit;
    if not SelectSupplier(IBCQueryRules.FieldByName('ORDER_SUPPLIERID').AsInteger,
        'Furnizorul prin care comandam (intermediar)', id) then
        Exit;

    IBCQueryRules.Edit;
    IBCQueryRules.FieldByName('ORDER_SUPPLIERID').AsInteger := id;
    IBCQueryRules.Post;
end;

procedure TfrmSupplierOrderRulesDlg.btnDeleteClick(Sender: TObject);
begin
    if IBCQueryRules.IsEmpty then
        Exit;

    if MessageDlg(Format('Stergeti regula pentru furnizorul %s?',
        [IBCQueryRules.FieldByName('STOCK_SUPPLIER_NAME').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    IBCQueryRules.Delete;
end;

procedure TfrmSupplierOrderRulesDlg.IBCQueryRulesNewRecord(DataSet: TDataSet);
begin
    DataSet.FieldByName('PICKUP_FROM').AsInteger := 0;
    DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
end;

procedure TfrmSupplierOrderRulesDlg.IBCQueryRulesBeforePost(DataSet: TDataSet);
begin
    if DataSet.FieldByName('STOCK_SUPPLIERID').AsInteger <= 0 then
        raise Exception.Create('Alegeti furnizorul la care vedem stocul.');
    if DataSet.FieldByName('ORDER_SUPPLIERID').AsInteger <= 0 then
        raise Exception.Create('Alegeti furnizorul prin care comandam.');
    if DataSet.FieldByName('STOCK_SUPPLIERID').AsInteger = DataSet.FieldByName('ORDER_SUPPLIERID').AsInteger then
        raise Exception.Create('Furnizorul intermediar trebuie sa fie diferit de furnizorul cu stoc.');

    DataSet.FieldByName('UPDATED_BY').AsString := Copy(dmDB.CurrentUserFullName, 1, 64);
end;

function TfrmSupplierOrderRulesDlg.IsFormDataPosted: Boolean;
begin
    if IBCQueryRules.State in dsEditModes then
        IBCQueryRules.Post;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;

    Result := True;
end;

procedure TfrmSupplierOrderRulesDlg.WhenCancelForm;
begin
    if IBCQueryRules.State in dsEditModes then
        IBCQueryRules.Cancel;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
