unit frmSupplierGroupsUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
    cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, DBAccess, IBC, MemDS, dxBar, cxClasses, Vcl.StdCtrls, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit,
    uSupplierGroupsEditor, cxCheckBox, frmCustomersDlg;

type
    TfrmSupplierGroupsDlg = class(TSWNBaseFormClass)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        pnButtons: TPanel;
        btnSelect: TButton;
        btnClose: TButton;
        dxBarManager1: TdxBarManager;
        dxBarManager1Bar1: TdxBar;
        bbNew: TdxBarButton;
        bbModify: TdxBarButton;
        bbDelete: TdxBarButton;
        IBCQuerySupplierGroups: TIBCQuery;
        IBCDataSourceSupplierGroups: TIBCDataSource;
        IBCTrGGUpdate: TIBCTransaction;
        Panel1: TPanel;
        cxGridSupplierGroups: TcxGrid;
        cxGridSupplierGroupsTable: TcxGridDBTableView;
        cxGridSupplierGroupsTable_GG_ID: TcxGridDBColumn;
        cxGridSupplierGroupsTable_TITLE: TcxGridDBColumn;
        cxGridSupplierGroupsLevel: TcxGridLevel;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager1Bar2: TdxBar;
        dxBarButton2: TdxBarButton;
        dxBarButton4: TdxBarButton;
        dxBarButton5: TdxBarButton;
        IBCQuerySupplierGroupItems: TIBCQuery;
        IBCDataSourceSupplierGroupItems: TIBCDataSource;
        cxGridSupplierGroupsTableColumn1: TcxGridDBColumn;
        cxGridSupplierGroupsTableColumn2: TcxGridDBColumn;
        Panel2: TPanel;
        cxGrid1: TcxGrid;
        cxGridDBTableView1: TcxGridDBTableView;
        cxGridDBColumn1: TcxGridDBColumn;
        cxGridDBColumn2: TcxGridDBColumn;
        cxGridLevel1: TcxGridLevel;
        dxBarDockControl2: TdxBarDockControl;
        Panel3: TPanel;
        cxGrid2DBTableView1: TcxGridDBTableView;
        cxGrid2Level1: TcxGridLevel;
        cxGrid2: TcxGrid;
        procedure btnSelectClick(Sender: TObject);
        procedure bbNewClick(Sender: TObject);
        procedure bbModifyClick(Sender: TObject);
        procedure bbDeleteClick(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
        procedure dxBarButton4Click(Sender: TObject);
        procedure dxBarButton5Click(Sender: TObject);
    private
        FSupplierGroupsID: Integer;
        FSupplierGroupsTitle: string;
        procedure SetSupplierGroupsID(const Value: Integer);
        procedure SetSupplierGroupsTitle(const Value: string);
    { Private declarations }
    protected
        procedure AddSupplierToGroup(NewRecord: Boolean);
        function SelectSupplier(): integer;
        procedure Prepare; override;
    public
        property SupplierGroupsID: Integer read FSupplierGroupsID write SetSupplierGroupsID;
        property SupplierGroupsTitle: string read FSupplierGroupsTitle write SetSupplierGroupsTitle;
    { Public declarations }
    end;

var
    frmSupplierGroupsDlg: TfrmSupplierGroupsDlg;

implementation

uses
    DataModuleDB, System.UITypes;

{$R *.dfm}

procedure TfrmSupplierGroupsDlg.AddSupplierToGroup(NewRecord: Boolean);
var
    SupplierID: integer;
begin
    SupplierID := SelectSupplier;
  // Item was seleccted
    if SupplierID > 1 then
    begin
        if NewRecord then
            IBCQuerySupplierGroupItems.Append
        else
            IBCQuerySupplierGroupItems.Edit;

        IBCQuerySupplierGroupItems.FieldByName('SUPPLIERID').AsInteger := SupplierID;
        IBCQuerySupplierGroupItems.Post;
    end;
end;

procedure TfrmSupplierGroupsDlg.bbDeleteClick(Sender: TObject);
begin
    if MessageDlg('Stergeti inregistrarea ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        IBCQuerySupplierGroups.Delete;
end;

procedure TfrmSupplierGroupsDlg.bbModifyClick(Sender: TObject);
var
    d: TfrmSupplierGroupsEditorDlg;
begin
    d := TfrmSupplierGroupsEditorDlg.Create(self, IBCQuerySupplierGroups, IBCDataSourceSupplierGroups);
    try
        d.NewRecord := False;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmSupplierGroupsDlg.bbNewClick(Sender: TObject);
var
    d: TfrmSupplierGroupsEditorDlg;
begin
    d := TfrmSupplierGroupsEditorDlg.Create(self, IBCQuerySupplierGroups, IBCDataSourceSupplierGroups);
    try
        d.NewRecord := True;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmSupplierGroupsDlg.btnSelectClick(Sender: TObject);
begin
    if Assigned(cxGridSupplierGroupsTable.Controller.FocusedRecord) then
    begin
        fSupplierGroupsID := IBCQuerySupplierGroups.FieldByName('SGID').AsInteger;
        fSupplierGroupsTitle := IBCQuerySupplierGroups.FieldByName('TITLE').AsString;
        ModalResult := mrOk;
    end;
end;

procedure TfrmSupplierGroupsDlg.dxBarButton2Click(Sender: TObject);
begin
    AddSupplierToGroup(True);
end;

procedure TfrmSupplierGroupsDlg.dxBarButton4Click(Sender: TObject);
begin
    AddSupplierToGroup(False);
end;

procedure TfrmSupplierGroupsDlg.dxBarButton5Click(Sender: TObject);
begin
    if MessageDlg('Stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        IBCQuerySupplierGroupItems.Delete;
    end;
end;

function TfrmSupplierGroupsDlg.SelectSupplier: integer;
var
    d: TfrmCustomersDlg;
begin
    Result := -1;
    d := TfrmCustomersDlg.Create(self);
    try
        if d.SelectCustomer(IBCQuerySupplierGroupItems.FieldByName('supplierid').AsInteger, False) then
        begin
//      IBCQuerySupplierGroupItems.FieldByName('supplierid').AsInteger := d.CustomerID;
//      IBCQuerySupplierGroupItems.FieldByName('supplier_name').AsString := d.CustomerTitle;
            Result := d.CustomerID;
        end;
    finally
        d.Free;
    end;
end;

{ TfrmSupplierGroupsDlg }

procedure TfrmSupplierGroupsDlg.Prepare;
begin
    IBCQuerySupplierGroups.Open;
    IBCQuerySupplierGroupItems.Open;
end;

procedure TfrmSupplierGroupsDlg.SetSupplierGroupsID(const Value: Integer);
begin
    FSupplierGroupsID := Value;
end;

procedure TfrmSupplierGroupsDlg.SetSupplierGroupsTitle(const Value: string);
begin
    FSupplierGroupsTitle := Value;
end;

end.

