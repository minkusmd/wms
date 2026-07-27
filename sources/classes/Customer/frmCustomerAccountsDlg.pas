unit frmCustomerAccountsDlg;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNBaseUnit, Dialogs, DialogTitle, Menus, DB, DBAccess, IBC, MemDS, dxBar,
    cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, ExtCtrls,
    StdCtrls, cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
    cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
    cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxMaskEdit,
    cxCheckBox, cxClasses, cxGridTableView, cxGridCustomView, dxUIAClasses;

type
    TfrmCustomerAccountDialog = class(TSWNMasteredFormClass)
        dtDialogTitle: TDialogTitle;
        btnCancel: TcxButton;
        pnMain: TPanel;
        dxBarDockControl1: TdxBarDockControl;
        cxGridAccounts: TcxGrid;
        cxGridAccountsDB: TcxGridDBTableView;
        cxGridAccountsLevel: TcxGridLevel;
        dxBarManager: TdxBarManager;
        dxBarManager1Bar2: TdxBar;
        bbNew: TdxBarButton;
        bbModify: TdxBarButton;
        bbRemove: TdxBarButton;
        cxGridAccountsDBACCOUNTNUMBER: TcxGridDBColumn;
        cxGridAccountsDBACCOUNTNAME: TcxGridDBColumn;
        cxGridAccountsDBDEFAULT_ACCOUNT: TcxGridDBColumn;
        cxGridAccountsDBBANKNAME: TcxGridDBColumn;
        IBCQueryAccounts: TIBCQuery;
        IBCDataSourceAccounts: TIBCDataSource;
        btnOk: TcxButton;
        procedure DataSourceAccountsDataChange(Sender: TObject; Field: TField);
        procedure bbNewClick(Sender: TObject);
        procedure bbRemoveClick(Sender: TObject);
        procedure bbModifyClick(Sender: TObject);
        procedure cxGridAccountsDBCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridAccountsDBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    private
    { Private declarations }
        procedure SelectionChanged;
        procedure ShowCreateNewAccountDialog;
        procedure ShowModifyCurrentAccountDialog;
        procedure DeleteCurrentAccount;
        procedure LockCustomerBankAccounts;
    protected
        procedure BindingDataSource; override;
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public
    { Public declarations }
    end;

implementation

uses
    frmCustomerAccountsEditorDlg, SWNUtils, SWNDBErrors;

{$R *.dfm}
{ TfrmCustomerAccountDialog }

procedure TfrmCustomerAccountDialog.bbModifyClick(Sender: TObject);
begin
    ShowModifyCurrentAccountDialog;
end;

procedure TfrmCustomerAccountDialog.bbNewClick(Sender: TObject);
begin
    ShowCreateNewAccountDialog;
end;

procedure TfrmCustomerAccountDialog.bbRemoveClick(Sender: TObject);
begin
    DeleteCurrentAccount;
end;

procedure TfrmCustomerAccountDialog.cxGridAccountsDBCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if bbModify.Enabled and (bbModify.Visible = ivAlways) then
    begin
        bbModifyClick(bbModify);
        AHandled := True;
    end;
end;

procedure TfrmCustomerAccountDialog.DataSourceAccountsDataChange(Sender: TObject; Field: TField);
begin
    SelectionChanged;
end;

procedure TfrmCustomerAccountDialog.DeleteCurrentAccount;
begin
    if ShowAskDialog('Sterge inregistrarea', 'Confirmati stergerea contului #' + IBCQueryAccounts.FieldByName('ACCOUNTNUMBER').asString + ' ?') = mrYes then
    begin
        try
            IBCQueryAccounts.Delete;
        except
            on E: Exception do
                if not ProcessSWNError(E) then
                    raise;
        end;
    end;
end;

procedure TfrmCustomerAccountDialog.BindingDataSource;
begin
    inherited;

    IBCQueryAccounts.Connection := fIBCConnection;
    IBCQueryAccounts.Transaction := fMasterDataSet.UpdateTransaction;
    IBCQueryAccounts.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    IBCQueryAccounts.MasterSource := fMasterDataSource;
end;

procedure TfrmCustomerAccountDialog.cxGridAccountsDBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    ProcessCommonKeys(self, cxGridAccountsDB, Key, Shift);
end;

function TfrmCustomerAccountDialog.IsFormDataPosted: Boolean;
begin
    IBCQueryAccounts.UpdateTransaction.Commit;
    Result := True;
end;

procedure TfrmCustomerAccountDialog.LockCustomerBankAccounts;
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCQueryAccounts.Connection;
        Query.Transaction := IBCQueryAccounts.UpdateTransaction;
        Query.SQL.Text := 'SELECT NULL FROM TS_CUST_ACCOUNTS WHERE CUSTOMERID = :CustomerID FOR UPDATE WITH LOCK';
        Query.ParamByName('CustomerID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
        Query.ExecSQL;
    finally
        Query.Free;
    end;
end;

procedure TfrmCustomerAccountDialog.Prepare;
begin
  // setup security

    IBCQueryAccounts.UpdateTransaction.StartTransaction;
    try
        LockCustomerBankAccounts;

        IBCQueryAccounts.Active := True;
    except
        IBCQueryAccounts.UpdateTransaction.Rollback;
        raise;
    end;

end;

procedure TfrmCustomerAccountDialog.SelectionChanged;
var
    f1, f2: Boolean;
begin
    f1 := True; // security
    f2 := False;
    if IBCQueryAccounts.RecordCount > 0 then
    begin
        f2 := True;
    end;
    bbNew.Enabled := f1;
    bbModify.Enabled := f2; // security
    bbRemove.Enabled := f2; // security
end;

procedure TfrmCustomerAccountDialog.ShowCreateNewAccountDialog;
var
    editor: TfrmCustomerAccountEditorDialog;
begin
    editor := TfrmCustomerAccountEditorDialog.Create(Self, IBCQueryAccounts, IBCDataSourceAccounts);
    try
        editor.CreateNewAccount := True;
       if editor.ShowModal = mrOk then
          IBCQueryAccounts.Refresh;
    finally
        editor.Free;
    end;
end;

procedure TfrmCustomerAccountDialog.ShowModifyCurrentAccountDialog;
var
    editor: TfrmCustomerAccountEditorDialog;
begin
    editor := TfrmCustomerAccountEditorDialog.Create(Self, IBCQueryAccounts, IBCDataSourceAccounts);
    try
        editor.CreateNewAccount := False;
        if editor.ShowModal = mrOk then
          IBCQueryAccounts.Refresh;
    finally
        editor.Free;
    end;
end;

procedure TfrmCustomerAccountDialog.WhenCancelForm;
begin
    IBCQueryAccounts.UpdateTransaction.Rollback;
end;

end.

