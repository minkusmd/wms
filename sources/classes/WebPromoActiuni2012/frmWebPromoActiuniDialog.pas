unit frmWebPromoActiuniDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxCheckBox, cxLabel, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, frmPrintEngineWindow,
  dxDateRanges, dxScrollbarAnnotations, frmWebPromoBannerDialog, dxUIAClasses;

type
  TfrmWebPromoActiuniDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbBanner: TdxBarButton;
    bbGoods: TdxBarButton;
    bbBricks: TdxBarButton;
    IBCQueryActiuni: TIBCQuery;
    IBCDataSourceActiuni: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_PROMOACTIONID: TcxGridDBColumn;
    cxGrid_START_DATE: TcxGridDBColumn;
    cxGrid_END_DATE: TcxGridDBColumn;
    cxGrid_TITLE: TcxGridDBColumn;
    cxGrid_FLG_SHOW_BANNER: TcxGridDBColumn;
    cxGrid_FLG_SHOW_GOODS: TcxGridDBColumn;
    cxGrid_FLG_SHOW_BRICKS: TcxGridDBColumn;
    cxGrid_FLG_ENABLED: TcxGridDBColumn;
    cxGrid_DAYS_REMAIN: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton3: TdxBarButton;
    cxGrid_FLG_FAKE_PROMOTION: TcxGridDBColumn;
    btnClose: TButton;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    bbRefresh: TdxBarButton;
    btnOK: TButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbStartStopPromo: TdxBarButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbBannerClick(Sender: TObject);
    procedure bbGoodsClick(Sender: TObject);
    procedure bbBricksClick(Sender: TObject);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure bbRefreshClick(Sender: TObject);
    procedure bbStartStopPromoClick(Sender: TObject);
  private
    FFirmaID: Integer;
    FKeyFieldValue: Integer;
    FPromoID: Integer;
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowCreateNewActionDialog;
    procedure ShowModifyActionDialog;
    procedure DeleteAction;
    procedure SetFirmaID(const Value: Integer);
    procedure SetKeyFieldValue(const Value: Integer);
    procedure SetPromoID(const Value: Integer);
    procedure ShowBannersDialog;
    procedure ShowGoodsDialog;
    procedure ShowReclamaDialog;
    procedure SetupReportParams(const ReportParams: TReportParamsList);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;

    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    constructor Create(AOwner: TComponent); override;
    function SelectPromotion: boolean;
    procedure SelectPromotionDialog;
    property FirmaID: Integer read FFirmaID write SetFirmaID;
    property KeyFieldValue: Integer read FKeyFieldValue write SetKeyFieldValue;
    { Public declarations }
  published
    property PromoID: Integer read FPromoID write SetPromoID;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, frmWebPromoActiuneEditorDialog, SWNUtils, SWNDBErrors,
  frmWebPromoGoodsDialog, frmWebPromoBricksDialog, SWNValueStorageUnit, frmWebPromoSortingActiuniDialog,
  frmWebPromoIssueGoodsUnit, frmPrintWizardDialog, uWebPromoSuppliersDlg;

{ TfrmWebPromoActiuniDlg }

procedure TfrmWebPromoActiuniDlg.bbBannerClick(Sender: TObject);
begin
  ShowBannersDialog;
end;

procedure TfrmWebPromoActiuniDlg.bbBricksClick(Sender: TObject);
begin
  ShowReclamaDialog;
end;

procedure TfrmWebPromoActiuniDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteAction;
end;

procedure TfrmWebPromoActiuniDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyActionDialog;
end;

procedure TfrmWebPromoActiuniDlg.bbGoodsClick(Sender: TObject);
begin
  ShowGoodsDialog;
end;

procedure TfrmWebPromoActiuniDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewActionDialog;
end;

procedure TfrmWebPromoActiuniDlg.bbRefreshClick(Sender: TObject);
begin
  IBCQueryActiuni.Refresh;
end;

procedure TfrmWebPromoActiuniDlg.bbStartStopPromoClick(Sender: TObject);
begin

   if not IBCQueryActiuni.UpdateTransaction.Active then
     IBCQueryActiuni.UpdateTransaction.StartTransaction;

   try
       IBCQueryActiuni.Edit;
       IBCQueryActiuni.FieldByName('FLG_ENABLED').AsInteger := abs(1 - IBCQueryActiuni.FieldByName('FLG_ENABLED').AsInteger);
       IBCQueryActiuni.Post;
       IBCQueryActiuni.UpdateTransaction.Commit;
   except
   begin
      if IBCQueryActiuni.State in dsEditModes then
          IBCQueryActiuni.Cancel;
      if IBCQueryActiuni.UpdateTransaction.Active then
          IBCQueryActiuni.UpdateTransaction.Rollback;
     raise;
   end;
   end;
end;

constructor TfrmWebPromoActiuniDlg.Create(AOwner: TComponent);
begin
  inherited;
  KeyFieldValue := -1;
end;

procedure TfrmWebPromoActiuniDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGrid_FLG_ENABLED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGrid_FLG_ENABLED.index] = 0 then
    begin
      if not AViewInfo.Selected then
        ACanvas.Font.Color := dmAdditions.cxStyle_TextGray.TextColor;
    end
  end;
end;

procedure TfrmWebPromoActiuniDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebPromoActiuniDlg.DeleteAction;
begin
  if ShowAskDialog('Promotii web-site', Format('Sterge promotia "%s"?', [IBCQueryActiuni.FieldByName('TITLE').AsString]))
    <> mrYes then
    Exit;

  IBCQueryActiuni.UpdateTransaction.StartTransaction;
  try
    IBCQueryActiuni.Delete;
    IBCQueryActiuni.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryActiuni.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebPromoActiuniDlg.dxBarButton1Click(Sender: TObject);
var
  frmWebPromoSortingActiuniDlg: TfrmWebPromoSortingActiuniDlg;
begin
  frmWebPromoSortingActiuniDlg := TfrmWebPromoSortingActiuniDlg.Create(Self, dmDB.IBCConnection);

  try
    frmWebPromoSortingActiuniDlg.ShowModal;
    IBCQueryActiuni.Refresh;
  finally
    frmWebPromoSortingActiuniDlg.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.dxBarButton2Click(Sender: TObject);
var
  dialog: TfrmWebPromoIssueGoodsDlg;
begin
  dialog := TfrmWebPromoIssueGoodsDlg.Create(Self);
  try
    dialog.PromoActionID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    dialog.UpdateTransaction := IBCQueryActiuni.UpdateTransaction;
    dialog.TitleRo := IBCQueryActiuni.FieldByName('META_TITLE_RO').AsString;
    dialog.TitleRu := IBCQueryActiuni.FieldByName('META_TITLE_RU').AsString;
    dialog.DescriptionRo:= IBCQueryActiuni.FieldByName('META_DESCRIPTION_RO').AsString;
    dialog.DescriptionRu:= IBCQueryActiuni.FieldByName('META_DESCRIPTION_RU').AsString;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.dxBarButton3Click(Sender: TObject);
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(28); // 28 - PROMOTII
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;

function TfrmWebPromoActiuniDlg.IsFormDataPosted: boolean;
begin
  Result := false;
  if modalResult = mrOK then begin
    promoID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    Result := True;
  end;
end;

procedure TfrmWebPromoActiuniDlg.SetupReportParams(const ReportParams: TReportParamsList);
var
  N: integer;
begin
  N := -1;
  if Assigned(cxGridTable.Controller.FocusedRow) then
    N := cxGridTable.Controller.FocusedRow.Values[cxGrid_PROMOACTIONID.Index];
  // setup here general params
  ReportParams.SetParamValue('PROMOACTIONID', N);
end;

procedure TfrmWebPromoActiuniDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form position
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
      (Self) then
      Self.Position := poDesigned;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoActiuniDlg.Prepare;
begin
  IBCQueryActiuni.ParamByName('DT').AsInteger := fFirmaID;
  IBCQueryActiuni.Active := True;
  if KeyFieldValue>0 then
    IBCQueryActiuni.Locate('PROMOACTIONID', KeyFieldValue, []);
  SelectionChanged;
end;

procedure TfrmWebPromoActiuniDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoActiuniDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
  fBanner, fGoods, fBricks: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;
  fBanner := False;
  fGoods := False;
  fBricks := False;
  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
    fBanner := True;
    fGoods := True;
    fBricks := True;
  end;
  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbBanner.Enabled := fBanner;
  bbGoods.Enabled := fGoods;
  bbBricks.Enabled := fBricks;
end;

function TfrmWebPromoActiuniDlg.SelectPromotion: boolean;
begin
  Result := False;
  btnOK.Visible := True;
  if ShowModal = mrOK then begin
    fPromoID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    Result := True;
  end;

  btnOK.Visible := False;
end;

procedure TfrmWebPromoActiuniDlg.SelectPromotionDialog;
begin
  if (ShowModal = mrClose) then
  begin
    fPromoID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
  end;
end;

procedure TfrmWebPromoActiuniDlg.SetFirmaID(const Value: Integer);
begin
  FFirmaID := Value;
end;

procedure TfrmWebPromoActiuniDlg.SetKeyFieldValue(const Value: Integer);
begin
  FKeyFieldValue := Value;
end;

procedure TfrmWebPromoActiuniDlg.SetPromoID(const Value: Integer);
begin
  FPromoID := Value;
end;

procedure TfrmWebPromoActiuniDlg.ShowBannersDialog;
var
  dialog: TfrmWebPromoBannerDlg;
begin
  dialog := TfrmWebPromoBannerDlg.Create(Self);
  try
    dialog.PromoActionID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    dialog.UpdateTransaction := IBCQueryActiuni.UpdateTransaction;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.ShowCreateNewActionDialog;
var
  dialog: TfrmWebPromoActiuneEditorDlg;
begin
  dialog := TfrmWebPromoActiuneEditorDlg.Create(Self, IBCQueryActiuni, IBCDataSourceActiuni);
  try
    dialog.DT := 5213; //dmdb.CurrentFirma;
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.ShowGoodsDialog;
var
  dialog: TfrmWebPromoGoodsDlg;

begin
  dialog := TfrmWebPromoGoodsDlg.Create(Self, dmdb.IBCConnection);
  try
    dialog.GoodsReadOnly := False;
    if IBCQueryActiuni.FieldByName('FLG_ENABLED').AsInteger = 1 then
      dialog.GoodsReadOnly := True;

    dialog.PromoActionID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    dialog.UpdateTransaction := IBCTrUpdate;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.ShowModifyActionDialog;
var
  dialog: TfrmWebPromoActiuneEditorDlg;
begin
  dialog := TfrmWebPromoActiuneEditorDlg.Create(Self, IBCQueryActiuni, IBCDataSourceActiuni);
  try
    dialog.DT := dmdb.CurrentFirma;
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.ShowReclamaDialog;
var
  dialog: TfrmWebPromoBricksDlg;
begin
  dialog := TfrmWebPromoBricksDlg.Create(Self);
  try
    dialog.PromoActionID := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
    dialog.UpdateTransaction := IBCQueryActiuni.UpdateTransaction;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoActiuniDlg.WhenCancelForm;
begin
  inherited;

end;

end.

