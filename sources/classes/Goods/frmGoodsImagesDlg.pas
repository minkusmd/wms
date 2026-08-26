unit frmGoodsImagesDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DBAccess, IBC, MemDS,
  cxCheckComboBox, cxLabel, cxLookAndFeels, cxNavigator, cxGraphics, cxControls, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxImage, Vcl.Menus, dxBar, cxClasses, Vcl.StdCtrls,
  cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  DialogTitle;

type
  TfrmGoodsImagesEditorDialog = class(TSWNMasteredFormClass)
    dxBarDockControl1: TdxBarDockControl;
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbRemove: TdxBarButton;
    cxGridInfo: TcxGrid;
    cxGridInfoTable: TcxGridDBTableView;
    cxGridInfoTableImage: TcxGridDBColumn;
    cxGridInfoLevel: TcxGridLevel;
    cxGridInfoTableID: TcxGridDBColumn;
    bbNewImage: TdxBarButton;
    bbViewImage: TdxBarButton;
    IBCDataSourceGoodsImages: TIBCDataSource;
    IBCQueryGoodsImages: TIBCQuery;
    IBCTrUpdateGoodsImages: TIBCTransaction;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxGridInfoTableColumn1: TcxGridDBColumn;
    cxGridInfoTableColumn2: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    procedure FormShow(Sender: TObject);
    procedure DataSourceGoodsImagesDataChange(Sender: TObject; Field: TField);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbViewImageClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbNewImageClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxGridInfoTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  protected
    procedure InitValues; override;
  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowImageNaturalSize;
    procedure ShowAddNewImageDialog;
    procedure ShowModifyCurrentImageDialog;
    function GetNextImageNO: integer;
  public
    { Public declarations }
  end;

implementation

uses
  frmGoodsImagePreviewDlg, SWNUtils, DataModuleAdditions;

{$R *.dfm}

{ TfrmGoodsImagesEditorDialog }

procedure TfrmGoodsImagesEditorDialog.bbNewImageClick(Sender: TObject);
begin
  ShowAddNewImageDialog;
end;

procedure TfrmGoodsImagesEditorDialog.bbRemoveClick(Sender: TObject);
begin
  if ShowAskDialog('Удаление картинки', 'Удалить картинку?') = mrYes then
    IBCQueryGoodsImages.Delete;
end;

procedure TfrmGoodsImagesEditorDialog.bbViewImageClick(Sender: TObject);
begin
  ShowImageNaturalSize;
end;

procedure TfrmGoodsImagesEditorDialog.btnOkClick(Sender: TObject);
begin
  if IBCQueryGoodsImages.State in dsEditModes then
    IBCQueryGoodsImages.Post;
  IBCTrUpdateGoodsImages.Commit;

  ModalResult := mrOk;
end;

procedure TfrmGoodsImagesEditorDialog.cxGridInfoTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  ShowModifyCurrentImageDialog;
  AHandled := True;
end;

procedure TfrmGoodsImagesEditorDialog.DataSourceGoodsImagesDataChange(Sender: TObject; Field: TField);
begin
  SelectionChanged;
end;

procedure TfrmGoodsImagesEditorDialog.dxBarButton1Click(Sender: TObject);
begin
  ShowModifyCurrentImageDialog;
end;

procedure TfrmGoodsImagesEditorDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    if IBCQueryGoodsImages.State in dsEditModes then
      IBCQueryGoodsImages.Cancel;
    IBCTrUpdateGoodsImages.Rollback;
  end;
end;

procedure TfrmGoodsImagesEditorDialog.FormShow(Sender: TObject);
begin
  IBCQueryGoodsImages.Active := True;
  IBCTrUpdateGoodsImages.StartTransaction;
end;

function TfrmGoodsImagesEditorDialog.GetNextImageNO: integer;
var
  i, N: integer;
begin
  Result := 0;
  for i := 0 to cxGridInfoTable.DataController.RecordCount - 1 do
  begin
    N := cxGridInfoTable.DataController.Values[i, cxGridInfoTableID.Index];
    if N > Result then
      Result := N;
  end;
  Inc(Result);
end;

procedure TfrmGoodsImagesEditorDialog.InitValues;
begin
  inherited;
  IBCQueryGoodsImages.Connection := fIBCConnection;
  IBCTrUpdateGoodsImages.DefaultConnection := fIBCConnection;
  IBCQueryGoodsImages.MasterSource := fMasterDataSource;
end;

procedure TfrmGoodsImagesEditorDialog.SelectionChanged;
var
  f1, f2, f3: Boolean;
begin
  f1 := false;
  f2 := false;
  f3 := false;
  if not (IBCQueryGoodsImages.State in dsEditModes) then
  begin
    f1 := True; // security
    if (IBCQueryGoodsImages.RecordCount > 0) then
    begin
      f2 := True; // security
      f3 := (not IBCQueryGoodsImages.FieldByName('IMAGE').IsNull);
    end;
  end;
  bbNewImage.Enabled := f1;
  bbRemove.Enabled := f2;
  bbViewImage.Enabled := f3;
end;

procedure TfrmGoodsImagesEditorDialog.ShowImageNaturalSize;
var
  dialog: TfrmGoodsImagePreview;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    TBlobField(IBCQueryGoodsImages.FieldByName('IMAGE')).SaveToStream(MS);
    MS.Position := 0;

    dialog := TfrmGoodsImagePreview.Create(Self);
    try
      dialog.ShowImageFromStream(MS);
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  finally
    MS.Free;
  end;
end;

end.

