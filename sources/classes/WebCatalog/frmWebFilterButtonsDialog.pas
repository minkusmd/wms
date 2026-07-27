unit frmWebFilterButtonsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxClasses, dxBar, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, DBAccess,
  IBC, MemDS, cxCheckBox, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TfrmWebFilterButtonsDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManagerBar1: TdxBar;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryButtons: TIBCQuery;
    IBCDataSourceButtons: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_FILTER_BUTTON_ID: TcxGridDBColumn;
    cxGrid_SYS_TITLE: TcxGridDBColumn;
    cxGrid_TITLE_ROM: TcxGridDBColumn;
    cxGrid_TITLE_RUS: TcxGridDBColumn;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid_ORDERNO: TcxGridDBColumn;
    cxGrid_FLG_ACTIVE: TcxGridDBColumn;
    cxGrid_FLG_USE_FILTERS: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure FormShow(Sender: TObject);
  private
    FCurrentFilterButtonID: Integer;
    { Private declarations }
    fSelectMode: Boolean;
    fFilterButtonTitle: String;
    fFilterButtonID: integer;
    procedure SelectionChanged;

    procedure ShowAddNewButtonDialog;
    procedure ShowModifyButtonDialog;
    procedure DoDeleteButton;

    function HasSelectedButton: Boolean;
    procedure SetCurrentFilterButtonID(const Value: Integer);
    procedure SetSelectMode(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;

    property CurrentFilterButtonID: Integer read FCurrentFilterButtonID write
        SetCurrentFilterButtonID;
    property SelectMode: Boolean read fSelectMode write SetSelectMode;

    property FilterButtonID: integer read fFilterButtonID;
    property FilterButtonTitle: String read fFilterButtonTitle;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmWebFilterButtonEditorDialog, SWNUtils, SWNDBErrors;

{$R *.dfm}
{ TfrmWebFilterButtonsDlg }

procedure TfrmWebFilterButtonsDlg.bbDeleteClick(Sender: TObject);
begin
  DoDeleteButton;
end;

procedure TfrmWebFilterButtonsDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyButtonDialog;
end;

procedure TfrmWebFilterButtonsDlg.bbNewClick(Sender: TObject);
begin
  ShowAddNewButtonDialog;
end;

constructor TfrmWebFilterButtonsDlg.Create(const AOwner: TComponent; const
    IBCConnection: TIBCConnection);
begin
  inherited;
  fSelectMode := False;
  fFilterButtonID := -1;
  fFilterButtonTitle := '';
end;

procedure TfrmWebFilterButtonsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if fSelectMode then
  begin
    if HasSelectedButton then
      ModalResult := mrOk;
  end
  else if bbModify.Enabled then
  begin
    bbModifyClick(bbModify);
    AHandled := True;
  end;
end;

procedure TfrmWebFilterButtonsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebFilterButtonsDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGrid_FLG_ACTIVE.Index]) then
  begin
    if ARecord.Values[cxGrid_FLG_ACTIVE.Index] <> 1 then
      AStyle := dmAdditions.cxStyle_TextGray;
  end;
end;

procedure TfrmWebFilterButtonsDlg.DoDeleteButton;
begin
  if ShowAskDialog('Buton Filtre Web', Format('Stergeti butonul de trecere "%s" ?', [IBCQueryButtons.FieldByName('SYS_TITLE').AsString]),
    'Toate linkurile spre butonul de trecere vor fi sterse!') = mrYes then
  begin
    IBCQueryButtons.UpdateTransaction.StartTransaction;
    try
      IBCQueryButtons.Delete;
      IBCQueryButtons.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryButtons.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebFilterButtonsDlg.FormShow(Sender: TObject);
begin
   IBCQueryButtons.Locate('FILTER_BUTTON_ID', CurrentFilterButtonID, []);
end;

function TfrmWebFilterButtonsDlg.HasSelectedButton: Boolean;
begin
  Result := False;
  if Assigned(cxGridTable.Controller.FocusedRecord) then
  begin
    fFilterButtonID := cxGridTable.Controller.FocusedRecord.Values[cxGrid_FILTER_BUTTON_ID.Index];
    fFilterButtonTitle := cxGridTable.Controller.FocusedRecord.Values[cxGrid_SYS_TITLE.Index];
    Result := True;
  end;
end;

procedure TfrmWebFilterButtonsDlg.BindingDataSource;
begin

end;

function TfrmWebFilterButtonsDlg.IsFormDataPosted: Boolean;
begin
  Result := HasSelectedButton;
end;

procedure TfrmWebFilterButtonsDlg.Prepare;
begin
  if Not fSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Default := True;
    btnCancel.Caption := 'Inchide';
  end;

  IBCQueryButtons.Active := True;

  SelectionChanged;
end;

procedure TfrmWebFilterButtonsDlg.SelectionChanged;
var
  fAdd, fEdit, fDelete: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbNew.Enabled := fAdd;
  bbModify.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
end;

procedure TfrmWebFilterButtonsDlg.SetCurrentFilterButtonID(const Value:
    Integer);
begin
   FCurrentFilterButtonID := Value;
end;

procedure TfrmWebFilterButtonsDlg.SetSelectMode(const Value: Boolean);
begin
  fSelectMode := Value;
end;

procedure TfrmWebFilterButtonsDlg.ShowAddNewButtonDialog;
var
  dialog: TfrmWebFilterButtonEditorDlg;
begin
  dialog := TfrmWebFilterButtonEditorDlg.Create(Self, IBCQueryButtons, IBCDataSourceButtons);
  try
    dialog.CreateNewButton := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFilterButtonsDlg.ShowModifyButtonDialog;
var
  dialog: TfrmWebFilterButtonEditorDlg;
begin
  dialog := TfrmWebFilterButtonEditorDlg.Create(Self, IBCQueryButtons, IBCDataSourceButtons);
  try
    dialog.CreateNewButton := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.
