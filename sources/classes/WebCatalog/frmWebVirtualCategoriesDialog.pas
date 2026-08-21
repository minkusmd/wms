unit frmWebVirtualCategoriesDialog;

(* Manager pentru categoriile VIRTUALE ale meniului web
   (TWEB_VIRTUAL_CATEGORIES): denumire RO/RU + imagine.
   Tranzactie proprie: OK -> Commit, Renunta -> Rollback. *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
    cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData;

type
    TfrmWebVirtualCategoriesDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCTransactionUpdate: TIBCTransaction;
        IBCQueryCategories: TIBCQuery;
        IBCDataSourceCategories: TIBCDataSource;
        cxGridCat: TcxGrid;
        cxGridCatTable: TcxGridDBTableView;
        cxGridCatLevel: TcxGridLevel;
        cxGridCat_NAME_RO: TcxGridDBColumn;
        cxGridCat_NAME_RU: TcxGridDBColumn;
        pnButtons: TPanel;
        btnNew: TcxButton;
        btnEdit: TcxButton;
        btnDelete: TcxButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure btnNewClick(Sender: TObject);
        procedure btnEditClick(Sender: TObject);
        procedure btnDeleteClick(Sender: TObject);
        procedure cxGridCatTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    SWNUtils, DataModuleDB, System.UITypes, frmWebVirtualCategoryEditorDialog;

{$R *.dfm}

{ TfrmWebVirtualCategoriesDlg }

procedure TfrmWebVirtualCategoriesDlg.Prepare;
begin
    try
        IBCTransactionUpdate.StartTransaction;
        IBCQueryCategories.Open;
    except
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Rollback;
        raise;
    end;
end;

function TfrmWebVirtualCategoriesDlg.IsFormDataPosted: Boolean;
begin
    if IBCQueryCategories.State in dsEditModes then
        IBCQueryCategories.Post;
    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;
    Result := True;
end;

procedure TfrmWebVirtualCategoriesDlg.WhenCancelForm;
begin
    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

procedure TfrmWebVirtualCategoriesDlg.btnNewClick(Sender: TObject);
var
    d: TfrmWebVirtualCategoryEditorDlg;
begin
    d := TfrmWebVirtualCategoryEditorDlg.Create(Self, IBCQueryCategories, IBCDataSourceCategories);
    try
        d.CreateNewItem := True;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmWebVirtualCategoriesDlg.btnEditClick(Sender: TObject);
var
    d: TfrmWebVirtualCategoryEditorDlg;
begin
    if IBCQueryCategories.IsEmpty then
        Exit;
    d := TfrmWebVirtualCategoryEditorDlg.Create(Self, IBCQueryCategories, IBCDataSourceCategories);
    try
        d.CreateNewItem := False;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmWebVirtualCategoriesDlg.btnDeleteClick(Sender: TObject);
begin
    if IBCQueryCategories.IsEmpty then
        Exit;
    if MessageDlg(Format('Stergeti categoria virtuala [%s]?',
        [IBCQueryCategories.FieldByName('NAME_RO').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        IBCQueryCategories.Delete;
end;

procedure TfrmWebVirtualCategoriesDlg.cxGridCatTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    btnEditClick(btnEdit);
    AHandled := True;
end;

end.
