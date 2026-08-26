unit frmContentGoodsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, JPEG, PngImage, Types, Dialogs,
  cxStyles, cxLabel, DB, dxBar, ExtDlgs, DBAccess, IBC, MemDS, cxDBEdit, StdCtrls, cxGridDBTableView, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGrid, ExtCtrls, ComCtrls, cxGridPopupMenu, dxPSCore, dxPScxGridLnk, GifImg,
  dxBarExtItems, cxButtons, frameGoodsEditDescriptionUnit, frameGoodsAttributesUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxDBData, cxImageComboBox, cxCheckBox, Vcl.Menus, dxBarBuiltInMenu, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLayoutViewLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPScxCommon, cxGridCustomPopupMenu, cxClasses, cxGridCustomView, cxMemo, cxPC, System.Actions,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, cxDBLabel, dxUIAClasses, SynEdit, SynDBEdit, SynEditHighlighter, SynHighlighterHtml,
  Vcl.WebpImage;

type
  TImageFieldStatus = (ifSNew, ifsInUse, ifsUpdated, ifsDeleted, ifsReordered);

  TImageField = class
  private
    FCreatedBy: string;
    { Private declarations }
    fDateEnd: TDateTime;
    fImage: TPngImage;
    fID: Integer;
    fStatus: TImageFieldStatus;
    fDateStart: TDateTime;
    fImageSize: Integer;
    FImageType: Integer;
    FOrderNo: Integer;
    procedure SetOrderNo(const Value: Integer);
    function GetHasEvent: Boolean;
    procedure SetCreatedBy(const Value: string);
    procedure SetImageType(const Value: Integer);
  public    { Public declarations }
    constructor Create(const AID: Integer; const AStatus: TImageFieldStatus);
    destructor Destroy; override;
    property CreatedBy: string read FCreatedBy write SetCreatedBy;
    property ID: Integer read fID;
    property Image: TPngImage read fImage;
    property HasEvent: Boolean read GetHasEvent;
    property DateStart: TDateTime read fDateStart;
    property DateEnd: TDateTime read fDateEnd;
    property Status: TImageFieldStatus read fStatus;
    property OrderNo: Integer read FOrderNo write SetOrderNo;
    property ImageSize: Integer read fImageSize;
    property ImageType: Integer read FImageType write SetImageType;
    procedure SetDates(const ADateStart, ADateEnd: TDateTime);
    procedure ClearDates;
    procedure LoadFromStream(const Stream: TStream);
    procedure LoadFromFile(const FileName: string);
    procedure PasteFromClipboard;
    procedure MarkDeleted;
  end;

  TfrmContentGoodsEditorDlg = class(TSWNMasteredFormClass)
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    bbDeleteImage: TdxBarButton;
    bbNewInfo: TdxBarButton;
    bbModifyInfo: TdxBarButton;
    bbDeleteInfo: TdxBarButton;
    bbPasteFields: TdxBarButton;
    bbImageEvent: TdxBarButton;
    bbDeleteAllInfo: TdxBarButton;
    OpenPictureDialog: TOpenPictureDialog;
    bbMoveImageUp: TdxBarButton;
    bbMoveImageDown: TdxBarButton;
    dxBarButton1: TdxBarButton;
    bbAddNewImage: TdxBarButton;
    pnGoods: TPanel;
    bbDescription_Paste: TdxBarButton;
    bbMoveTextUp: TdxBarButton;
    bbMoveTextDown: TdxBarButton;
    bbShowFullSize: TdxBarButton;
    bbFieldTemplates: TdxBarSubItem;
    bbCopyFields: TdxBarButton;
    bbSaveFieldsAsTemplate: TdxBarButton;
    dxBarManagerBar4: TdxBar;
    bbDeleteAllProperties: TdxBarButton;
    bbFilterEdit: TdxBarButton;
    bbFilterTemplates: TdxBarButton;
    bbFilterSort: TdxBarButton;
    bbSaveFields: TdxBarButton;
    IBCQueryFilters: TIBCQuery;
    IBCDataSourceFilters: TIBCDataSource;
    cxGridPopupMenu: TcxGridPopupMenu;
    dxBarPopupMenuFilters: TdxBarPopupMenu;
    bbChangeFilterVisibility: TdxBarButton;
    IBCQueryDSC: TIBCQuery;
    IBCDataSourceDSC: TIBCDataSource;
    pnButtons: TPanel;
    bbPrint: TdxBarButton;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLink1: TdxGridReportLink;
    bbGotoButtons: TdxBarButton;
    bbFilterClone: TdxBarButton;
    bbFilterAdd: TdxBarButton;
    dxBarManagerBar5: TdxBar;
    bbDescriptionRo_Paste: TdxBarButton;
    dxBarButton2: TdxBarButton;
    bbP: TdxBarButton;
    bbB: TdxBarButton;
    bbDiv: TdxBarButton;
    bbImg: TdxBarButton;
    bbYouTube: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarStatic1: TdxBarStatic;
    bsiInstrumente: TdxBarSubItem;
    bbImport: TdxBarButton;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    IBCTrLog: TIBCTransaction;
    bbImportImageFromGoods: TdxBarButton;
    IBCDataSourceWebGoods: TIBCDataSource;
    IBCQueryWebGoods: TIBCQuery;
    dxBarManagerBar6: TdxBar;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxcmbBarcode: TdxBarCombo;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarPopupMenuImages: TdxBarPopupMenu;
    mmTITLE: TcxDBMemo;
    bbHistory: TdxBarButton;
    bbDeleteGoodsProperty: TdxBarButton;
    pcPageControl: TcxPageControl;
    tbWebName: TcxTabSheet;
    dxBarDockControl4: TdxBarDockControl;
    tbsDescriptions: TcxTabSheet;
    pcDescriptions: TPageControl;
    tbsDescription: TTabSheet;
    dxBarDockControl3: TdxBarDockControl;
    TabSheet3: TTabSheet;
    cxDBMemo1: TcxDBMemo;
    tbsFilters: TcxTabSheet;
    dxBarDockFilters: TdxBarDockControl;
    cxGridFilters: TcxGrid;
    cxGridFiltersTable: TcxGridDBTableView;
    cxGridFilters_FLG_GROUP: TcxGridDBColumn;
    cxGridFilters_FILTERID: TcxGridDBColumn;
    cxGridFilters_FILTERNAME_ROM: TcxGridDBColumn;
    cxGridFilters_FILTERPARAMID: TcxGridDBColumn;
    cxGridFilters_PARAM_VALUE_ROM: TcxGridDBColumn;
    cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn;
    cxGridFilters_PARAM_VALUE_RUS: TcxGridDBColumn;
    cxGridFilters_FLG_VISIBLE: TcxGridDBColumn;
    cxGridFilters_FLG_COMPATIBILITY: TcxGridDBColumn;
    cxGridFilters_FLG_COMPARE: TcxGridDBColumn;
    cxGridFilters_FLG_GOODS_LINK: TcxGridDBColumn;
    cxGridFilters_ORDERNO: TcxGridDBColumn;
    cxGridFilters_CREATE_BY_NAME: TcxGridDBColumn;
    cxGridFiltersLevel: TcxGridLevel;
    tbsImages: TcxTabSheet;
    dxBarDockControl1: TdxBarDockControl;
    lbImages: TListBox;
    bbSave: TdxBarButton;
    ActionList1: TActionList;
    actSaveImages: TAction;
    bbRefresh: TdxBarButton;
    bbModifyGoodsTitle: TdxBarButton;
    IBCTrImage: TIBCTransaction;
    bbFilterProperties: TdxBarButton;
    cxGridFilters_FLG_ORDINARY_FILTER: TcxGridDBColumn;
    IBCQuerySearchkeys: TIBCQuery;
    IBCDataSourceSearchkeys: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    tbsSearchKeys: TcxTabSheet;
    cxDBMemo2: TcxDBMemo;
    ActionList2: TActionList;
    actSaveSearchKeys: TAction;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    bbSaveSearchKeys: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarManagerBar7: TdxBar;
    bbNewFilter: TdxBarButton;
    bbAddFilterParam: TdxBarButton;
    bbDeleteFilter: TdxBarButton;
    bbDeleteFilterParams: TdxBarButton;
    cxDBLabel1: TcxDBLabel;
    mmGOODS_Description: TDBSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    mmGOODS_Description_RO: TDBSynEdit;
    dxBarButton9: TdxBarButton;
    tsSEO: TcxTabSheet;
    cxLabel1: TcxLabel;
    teTitleRO: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    teTitleRU: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    teKeysRO: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    teKeysRU: TcxDBTextEdit;
    teDescRO: TcxDBMemo;
    teDescRU: TcxDBMemo;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel7: TcxLabel;
    teSlugRO: TcxDBTextEdit;
    teSlugRU: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    cxLabel9: TcxLabel;
    teH1RU: TcxDBTextEdit;
    teH1RO: TcxDBTextEdit;
    btnGenSlug: TcxButton;
    Panel1: TPanel;
    frameGoodsEditDescription1: TframeGoodsEditDescription;
    tbsVideo: TcxTabSheet;
    lbYouTubeCaption: TcxLabel;
    edYouTubeURL: TcxTextEdit;
    lbYouTubeHint: TcxLabel;
    imgYouTube: TImage;
    btnOpenYouTube: TcxButton;
    tbsAttributes: TcxTabSheet;
    frameGoodsAttributes1: TframeGoodsAttributes;
    procedure actSaveImagesExecute(Sender: TObject);
    procedure actSaveImagesUpdate(Sender: TObject);
    procedure actSaveSearchKeysExecute(Sender: TObject);
    procedure actSaveSearchKeysUpdate(Sender: TObject);
    procedure bbMoveImageUpClick(Sender: TObject);
    procedure bbMoveImageDownClick(Sender: TObject);
    procedure bbAddNewImageClick(Sender: TObject);
    procedure bbDeleteImageClick(Sender: TObject);
    procedure bbImageEventClick(Sender: TObject);
    procedure lbImagesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure lbImagesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbImagesClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bbShowFullSizeClick(Sender: TObject);
    procedure cxGridFiltersTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbFilterTemplatesClick(Sender: TObject);
    procedure bbFilterAddClick(Sender: TObject);
    procedure bbFilterEditClick(Sender: TObject);
    procedure bbDeleteAllPropertiesClick(Sender: TObject);
    procedure bbFilterSortClick(Sender: TObject);
    procedure cxGridFilters_PARAM_VALUE_RUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure cxGridFilters_FILTERNAME_RUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure cxGridFilters_PARAM_VALUE_ROMGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure cxGridFilters_FILTERNAME_ROMGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure cxGridFiltersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarPopupMenuFiltersPopup(Sender: TObject);
    procedure bbChangeFilterVisibilityClick(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure bbGotoButtonsClick(Sender: TObject);
    procedure bbFilterCloneClick(Sender: TObject);
    procedure cxGridFiltersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbBClick(Sender: TObject);
    procedure bbPClick(Sender: TObject);
    procedure bbImgClick(Sender: TObject);
    procedure bbDivClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure bbImportImageFromGoodsClick(Sender: TObject);
    procedure bbRefreshClick(Sender: TObject);
    procedure dxBarButton7Click(Sender: TObject);
    procedure dxBarButton8Click(Sender: TObject);
    procedure frameGoodsEditDescription2edBASE_PARAM_RUDblClick(Sender: TObject);
    procedure frameGoodsEditDescription2edBASE_PARAM_RUKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frameGoodsEditDescription2edCODE_RUDblClick(Sender: TObject);
    procedure frameGoodsEditDescription2edCODE_RUKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbHistoryClick(Sender: TObject);
    procedure bbDeleteGoodsPropertyClick(Sender: TObject);
    procedure pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure tbsImagesShow(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure bbModifyGoodsTitleClick(Sender: TObject);
    procedure bbFilterPropertiesClick(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbYouTubeClick(Sender: TObject);
    procedure dxBarButton9Click(Sender: TObject);
    procedure btnGenSlugClick(Sender: TObject);
    procedure edYouTubeURLPropertiesChange(Sender: TObject);
    procedure btnOpenYouTubeClick(Sender: TObject);
  private
    FActiveTabsheetIndex: Integer;
    { Private declarations }
    fWorkBMP: TBitmap;
    fClipboardList: TList;
    fImageList: TList;
    fParamsList: TList;
    fContentChanged: Boolean;
    FGoodsID: Integer;
    fIsFolder: Boolean;
    IsImagesLoaded: Boolean;
    IsImagesModified: Boolean;
    StartTime: TDateTime;
    fLastThumbnailID: string;
    function GetNextOrderNoForImage: Integer;
    procedure SelectionImagesChanged;
    procedure ClearClipboardList;
    procedure ClearImageList;
    function AddNewImageFromFile: Boolean;
//    procedure AddNewImageFromClipboard;
//    procedure AddNewImageFromStream(const Stream: TMemoryStream);
    procedure DeleteSelectedImage;
    function GetNewImageID: Integer;
    procedure ShowCurrentImageEventDialog;
    procedure MoveCurrentImageUp;
    procedure MoveCurrentImageDown;
    procedure LoadImagesFromDB;
    procedure CreateImageGrid;
    procedure SaveImagesToDB;
    procedure LoadYouTubeFromDB;
    procedure SaveYouTubeToDB;
    procedure UpdateYouTubeHint;
    procedure UpdateYouTubeThumbnail;
    function ExtractYouTubeID(const AUrl: string): string;
//        procedure LockEditRecords;
    procedure AdjustImagesItemHeight;

    // filters
    procedure FilterSelectionChanged;
    procedure ShowSelectTemplateDialog;
    procedure ShowAddFilterDialog;
    procedure ShowModifyFilterDialog;
    procedure DoDeleteFilter;
    procedure ShowSortFiltersDialog;
    procedure ChangeItemVisibility;
    procedure ClearFilterClone;
    procedure DoImportDescritpionTemplate(const GoodsID, TemplateID: Integer);
    procedure FillSupplierCodes;
    procedure ImportFilters(GoodsID: Integer);
    procedure RefreshImageList;
    procedure ShowDescriptionGotoButtonsDialog;
    procedure Prepare_tbWebName;
    procedure SetActiveTabsheetIndex(const Value: Integer);
    procedure ModifyFilterParams;
  protected    { Protected declarations }
    procedure SetupSecurityItems; override;
    procedure BindingDataSource; override;
    function GetDefaultTemplateID(GoodsID: Integer): Integer;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure LoadStates; override;
    procedure ProceedPenalityForUser(UserID: integer; Mentiuni: string; Suma: Integer);
    procedure SaveStates; override;
    procedure DoImportFilters(IntoGoodsID, FromGoodsID: Integer);
  public    { Public declarations }
    destructor Destroy; override;
    procedure SaveToLog(UserAction: Integer);
    constructor Create(const AOwner: TComponent; const MasterDataSet: TCustomIBCDataSet; const MasterDataSource:
      TIBCDataSource); override;
    procedure RemoveSpecialCharacters;
  published
    property ActiveTabsheetIndex: Integer read FActiveTabsheetIndex write SetActiveTabsheetIndex;
    property GoodsID: Integer read FGoodsID write FGoodsID;
  end;

implementation

uses
  DateUtils, DataModuleAdditions, Math, ClipBrd, SWNUtils, frmGoodsImageEventDialog, SWNValueStorageUnit, SWNDBErrors,
  frmGoodsImagePreviewDlg, frmChangeOrderNoDialog, frmGoodsFilterTemplateSelectorDialog, SWNConst,
  frmWebDescriptionElementEditorDialog, frmGoodsDescFilterButtonsDialog, DataModuleDB, frmGoodsSelectUnit, ShellApi,
  frmHistoryGoodsFiltersUnit, SWNSecurity, SWNGoodsUtils, frmWebFiltersDialog, SWNSecurityFlags, frmWebSelectFiltersDialog,
  frmOrdinaryFilterValueDialog, System.UITypes, System.Net.HttpClient;

{$R *.dfm}
{ TfrmGoodsDescriptionsDlg }

type
  PClipboardRow = ^TClipboardRow;

  TClipboardRow = record
    Field: string;
    Value: string;
  end;

function TfrmContentGoodsEditorDlg.AddNewImageFromFile: Boolean;
var
  imgItem: TImageField;
  fileExt: string;
  hasImage: Boolean;
  JPEG: TJPEGImage;
  bmp: TBitmap;
  gif: TGIFImage;
begin
  hasImage := False;
  Result := False;
  imgItem := nil;
  if OpenPictureDialog.Execute then
  begin
    fileExt := LowerCase(ExtractFileExt(OpenPictureDialog.FileName));
    if fileExt = '.png' then
    begin
      imgItem := TImageField.Create(GetNewImageID, ifSNew);
      imgItem.LoadFromFile(OpenPictureDialog.FileName);
      hasImage := True;
    end
    else if (fileExt = '.jpg') or (fileExt = '.jpeg') then
    begin
      JPEG := TJPEGImage.Create;
      bmp := TBitmap.Create;
      try
        JPEG.LoadFromFile(OpenPictureDialog.FileName);
        bmp.Assign(JPEG);
        imgItem := TImageField.Create(GetNewImageID, ifSNew);
        imgItem.fImage.Assign(bmp);
        hasImage := True;
      finally
        bmp.Free;
        JPEG.Free;
      end;
    end
    else if (fileExt = '.gif') then
    begin
      gif := TGIFImage.Create;
      bmp := TBitmap.Create;
      try
        gif.LoadFromFile(OpenPictureDialog.FileName);
        bmp.Assign(gif);
        imgItem := TImageField.Create(GetNewImageID, ifSNew);
        imgItem.fImage.Assign(bmp);
        hasImage := True;
      finally
        bmp.Free;
        gif.Free;
      end;
    end
  end;

  if hasImage then
  begin
    imgItem.OrderNo := GetNextOrderNoForImage;
    imgItem.ImageType := 0;
    fImageList.Add(imgItem);
    // add to list
    lbImages.Items.BeginUpdate;
    try
      lbImages.ItemIndex := lbImages.Items.AddObject('', imgItem);
      fContentChanged := True;
      Result := True;
    finally
      lbImages.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.bbAddNewImageClick(Sender: TObject);
begin
  if AddNewImageFromFile then
  begin
    AdjustImagesItemHeight;
    SelectionImagesChanged;
    IsImagesModified := True;
  end;
end;

procedure TfrmContentGoodsEditorDlg.bbChangeFilterVisibilityClick(Sender: TObject);
begin
  ChangeItemVisibility;
end;

procedure TfrmContentGoodsEditorDlg.bbDeleteImageClick(Sender: TObject);
begin
  if SWNSecurityManager.UserIsPartOfGroup(5) then
  begin
//    var SumaAmenda := '30';
//    if InputQuery('Introduceri marimea amenzii', 'Amenda', SumaAmenda) then
//    begin
//      ProceedPenalityForUser(ResponsableContentUserID, 'Imagine gresita', SumaAmenda.ToInteger);
//    end;
//      ProceedPenalityForUser(ResponsableContentUserID, 'Imagine gresita', 0);
  end;
  DeleteSelectedImage;
  AdjustImagesItemHeight;
  SelectionImagesChanged;
  IsImagesModified := True;
end;

procedure TfrmContentGoodsEditorDlg.bbDivClick(Sender: TObject);
var
  control: TDBSynEdit;
begin
  if mmGOODS_Description_RO.Focused then
    control := mmGOODS_Description_RO
  else
    control := mmGOODS_DESCRIPTION;

  control.SelText := Format('<p>%s</p>'#13#10, [control.SelText]);
end;

procedure TfrmContentGoodsEditorDlg.bbFilterAddClick(Sender: TObject);
begin
  ShowAddFilterDialog;
end;

procedure TfrmContentGoodsEditorDlg.bbFilterCloneClick(Sender: TObject);
begin
  ClearFilterClone;
end;

procedure TfrmContentGoodsEditorDlg.bbDeleteAllPropertiesClick(Sender: TObject);
begin
  DoDeleteFilter;
end;

procedure TfrmContentGoodsEditorDlg.bbFilterEditClick(Sender: TObject);
begin
//  ShowModifyFilterDialog;
  ModifyFilterParams;
end;

procedure TfrmContentGoodsEditorDlg.bbFilterSortClick(Sender: TObject);
begin
  ShowSortFiltersDialog;
end;

procedure TfrmContentGoodsEditorDlg.bbFilterTemplatesClick(Sender: TObject);
begin
  ShowSelectTemplateDialog;
end;

procedure TfrmContentGoodsEditorDlg.bbGotoButtonsClick(Sender: TObject);
begin
  ShowDescriptionGotoButtonsDialog;
end;

procedure TfrmContentGoodsEditorDlg.bbImageEventClick(Sender: TObject);
begin
  ShowCurrentImageEventDialog;
  IsImagesModified := True;
end;

procedure TfrmContentGoodsEditorDlg.bbMoveImageDownClick(Sender: TObject);
begin
  MoveCurrentImageDown;
  SelectionImagesChanged;
  IsImagesModified := True;
end;

procedure TfrmContentGoodsEditorDlg.bbMoveImageUpClick(Sender: TObject);
begin
  MoveCurrentImageUp;
  SelectionImagesChanged;
  IsImagesModified := True;
end;

procedure TfrmContentGoodsEditorDlg.bbPrintClick(Sender: TObject);
begin
  dxComponentPrinter.Preview;
end;

procedure TfrmContentGoodsEditorDlg.bbSaveClick(Sender: TObject);
begin
  SaveImagesToDB;
end;

procedure TfrmContentGoodsEditorDlg.bbShowFullSizeClick(Sender: TObject);
var
  imageItem: TImageField;
  dialog: TfrmGoodsImagePreview;
  MS: TMemoryStream;
begin
//   ShowImageFullFize
  if lbImages.ItemIndex <> -1 then
  begin
    imageItem := TImageField(lbImages.Items.Objects[lbImages.ItemIndex]);

    MS := TMemoryStream.Create;
    dialog := TfrmGoodsImagePreview.Create(Self);
    try
      imageItem.fImage.SaveToStream(MS);
      dialog.ShowImageFromStream(MS);
      dialog.ShowModal;
    finally
      dialog.Free;
      MS.Free;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.bbYouTubeClick(Sender: TObject);
var
  control: TDBSynEdit;
begin
  if mmGOODS_Description_RO.Focused then
    control := mmGOODS_Description_RO
  else
    control := mmGOODS_DESCRIPTION;

  control.SelText := Format('<iframe width="800" height="415" src="%s" frameborder="0" allowfullscreen=""></iframe>'#13#10, [control.SelText]);
end;

procedure TfrmContentGoodsEditorDlg.edYouTubeURLPropertiesChange(Sender: TObject);
begin
  UpdateYouTubeHint;
  UpdateYouTubeThumbnail;
end;

procedure TfrmContentGoodsEditorDlg.btnOpenYouTubeClick(Sender: TObject);
var
  id: string;
begin
  id := ExtractYouTubeID(edYouTubeURL.Text);
  if id = '' then
  begin
    MessageDlg('URL YouTube nevalid.', mtWarning, [mbOK], 0);
    Exit;
  end;
  ShellExecute(0, 'open', PChar('https://www.youtube.com/watch?v=' + id), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmContentGoodsEditorDlg.UpdateYouTubeThumbnail;
var
  id: string;
  http: THTTPClient;
  MS: TMemoryStream;
  jpg: TJPEGImage;
begin
  id := ExtractYouTubeID(edYouTubeURL.Text);
  if id = fLastThumbnailID then
    Exit;
  fLastThumbnailID := id;

  imgYouTube.Picture.Graphic := nil;
  if id = '' then
    Exit;

  MS := TMemoryStream.Create;
  http := THTTPClient.Create;
  jpg := TJPEGImage.Create;
  try
    http.ConnectionTimeout := 4000;
    http.ResponseTimeout := 4000;
    try
      http.Get('https://i.ytimg.com/vi/' + id + '/mqdefault.jpg', MS);
      if MS.Size > 0 then
      begin
        MS.Position := 0;
        jpg.LoadFromStream(MS);
        imgYouTube.Picture.Graphic := jpg;
      end;
    except
      // preview indisponibil (fără internet sau ID inexistent) — ignorăm
      imgYouTube.Picture.Graphic := nil;
    end;
  finally
    jpg.Free;
    http.Free;
    MS.Free;
  end;
end;

function TfrmContentGoodsEditorDlg.ExtractYouTubeID(const AUrl: string): string;
const
  cValidChars = ['A'..'Z', 'a'..'z', '0'..'9', '_', '-'];
var
  S, LowUrl: string;
  P, i: Integer;

  function TakeIDFrom(AStart: Integer): string;
  var
    j: Integer;
  begin
    Result := '';
    j := AStart;
    while (j <= Length(S)) and CharInSet(S[j], cValidChars) do
    begin
      Result := Result + S[j];
      Inc(j);
    end;
  end;

begin
  Result := '';
  S := Trim(AUrl);
  if S = '' then
    Exit;
  LowUrl := LowerCase(S);

  // https://www.youtube.com/watch?v=ID  sau  ...&v=ID
  P := Pos('v=', LowUrl);
  if P > 0 then
    Result := TakeIDFrom(P + 2)
  else
  begin
    // https://youtu.be/ID
    P := Pos('youtu.be/', LowUrl);
    if P > 0 then
      Result := TakeIDFrom(P + Length('youtu.be/'))
    else
    begin
      // https://www.youtube.com/embed/ID
      P := Pos('/embed/', LowUrl);
      if P > 0 then
        Result := TakeIDFrom(P + Length('/embed/'))
      else
      begin
        // https://www.youtube.com/shorts/ID
        P := Pos('/shorts/', LowUrl);
        if P > 0 then
          Result := TakeIDFrom(P + Length('/shorts/'))
        else
        begin
          // fără URL: acceptăm doar dacă textul este el însuși un ID valid
          Result := S;
          for i := 1 to Length(S) do
            if not CharInSet(S[i], cValidChars) then
            begin
              Result := '';
              Break;
            end;
        end;
      end;
    end;
  end;

  if Length(Result) > 11 then
    Result := Copy(Result, 1, 11);
  // ID-urile YouTube au exact 11 caractere
  if Length(Result) <> 11 then
    Result := '';
end;

procedure TfrmContentGoodsEditorDlg.UpdateYouTubeHint;
var
  id: string;
begin
  if Trim(edYouTubeURL.Text) = '' then
    lbYouTubeHint.Caption := 'Niciun video setat (spotul va fi șters la salvare).'
  else
  begin
    id := ExtractYouTubeID(edYouTubeURL.Text);
    if id <> '' then
      lbYouTubeHint.Caption := 'ID video: ' + id
    else
      lbYouTubeHint.Caption := 'URL YouTube nevalid — verificați linkul.';
  end;
end;

procedure TfrmContentGoodsEditorDlg.LoadYouTubeFromDB;
var
  Query: TIBCQuery;
  id: string;
begin
  edYouTubeURL.Text := '';
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fIBCConnection;
    Query.SQL.Text :=
      'SELECT FIRST 1 YOUTUBEID FROM TS_GOODS_YOUTUBE_VIDEO ' +
      'WHERE (GOODSID=:GOODSID) AND (FLG_VISIBLE=1) ORDER BY ORDERNO';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      id := Trim(Query.FieldByName('YOUTUBEID').AsString);
      if id <> '' then
        edYouTubeURL.Text := 'https://www.youtube.com/watch?v=' + id;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
  UpdateYouTubeHint;
  fLastThumbnailID := #1;
  UpdateYouTubeThumbnail;
end;

procedure TfrmContentGoodsEditorDlg.SaveYouTubeToDB;
var
  Query: TIBCQuery;
  id: string;
  goodsId: Integer;
begin
  goodsId := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  id := ExtractYouTubeID(edYouTubeURL.Text);

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    // spot unic: ștergem rândul existent, apoi inserăm cel curent (dacă există)
    Query.SQL.Text := 'DELETE FROM TS_GOODS_YOUTUBE_VIDEO WHERE GOODSID=:GOODSID';
    Query.ParamByName('GOODSID').AsInteger := goodsId;
    Query.ExecSQL;

    if id <> '' then
    begin
      Query.SQL.Text :=
        'INSERT INTO TS_GOODS_YOUTUBE_VIDEO (GOODSID, YOUTUBEID, ORDERNO, FLG_VISIBLE) ' +
        'VALUES (:GOODSID, :YOUTUBEID, 1, 1)';
      Query.ParamByName('GOODSID').AsInteger := goodsId;
      Query.ParamByName('YOUTUBEID').AsString := id;
      Query.ExecSQL;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ChangeItemVisibility;
var
  Value: Integer;
begin
  IBCQueryFilters.Edit;
  try
    Value := IBCQueryFilters.FieldByName('FLG_VISIBLE').AsInteger;
    if Value = 1 then
      Value := 0
    else
      Value := 1;
    IBCQueryFilters.FieldByName('FLG_VISIBLE').AsInteger := Value;
    IBCQueryFilters.Post;
  except
    on E: Exception do
    begin
      IBCQueryFilters.Cancel;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ClearClipboardList;
var
  i: Integer;
begin
  for i := 0 to fClipboardList.Count - 1 do
    Dispose(PClipboardRow(fClipboardList[i]));
  fClipboardList.Clear;
end;

procedure TfrmContentGoodsEditorDlg.ClearFilterClone;
var
  dialog: TfrmWebDescriptionElementEditorDlg;
  filterID, OrderNo: Integer;
  FLG_VISIBLE, FLG_COMPATIBILITY, FLG_COMPARE: Integer;
begin
  // get selected values
  filterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
  FLG_VISIBLE := IBCQueryFilters.FieldByName('FLG_VISIBLE').AsInteger;
  FLG_COMPATIBILITY := IBCQueryFilters.FieldByName('FLG_COMPATIBILITY').AsInteger;
  FLG_COMPARE := IBCQueryFilters.FieldByName('FLG_COMPARE').AsInteger;
  OrderNo := IBCQueryFilters.FieldByName('ORDERNO').AsInteger;

  dialog := TfrmWebDescriptionElementEditorDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewDescription := True;
    dialog.InGoodsDescription := True;
    dialog.IsCloning := True;
    // appy values
    dialog.Clone_FilterID := filterID;
    dialog.Clone_FLG_VISIBLE := FLG_VISIBLE;
    dialog.Clone_FLG_COMPATIBILITY := FLG_COMPATIBILITY;
    dialog.Clone_FLG_COMPARE := FLG_COMPARE;
    dialog.Clone_OrderNO := OrderNo;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ClearImageList;
var
  i: Integer;
  imageItem: TImageField;
begin
  for i := 0 to fImageList.Count - 1 do
  begin
    imageItem := TImageField(fImageList[i]);
    imageItem.Free;
  end;
  fImageList.Clear;
end;

constructor TfrmContentGoodsEditorDlg.Create(const AOwner: TComponent; const MasterDataSet: TCustomIBCDataSet; const
  MasterDataSource: TIBCDataSource);
begin
  inherited;
  ActiveTabsheetIndex := 0;
end;

procedure TfrmContentGoodsEditorDlg.ModifyFilterParams;
var
//    dlgSelectFilter: TfrmWebSelectFiltersDlg;
  dlgSelectFilterParam: TfrmWebFiltersDlg;
  defaultFilterID: Integer;
  defaultFilterParamID: Integer;
begin
//    defaultFilterID := -1;
//    defaultFilterParamID := -1;
//    if not IBCQueryFilters.FieldByName('FILTERID').IsNull then
//        defaultFilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
//    if not IBCQueryFilters.FieldByName('FILTERPARAMID').IsNull then
//        defaultFilterParamID := IBCQueryFilters.FieldByName('FILTERPARAMID').AsInteger;
//    if IBCQueryFilters.FieldByName('FLG_ORDINARY_FILTER').AsInteger = 1 then
//    begin
//        dlgSelectFilter := TfrmWebSelectFiltersDlg.Create(Self, dmdb.IBCConnection);
//        try
//            if dlgSelectFilter.SelectFilter(defaultFilterID) then
//            begin
//                IBCQueryFilters.Edit;
//                IBCQueryFilters.FieldByName('FILTERID').AsInteger := dlgSelectFilter.FilterID;
//                IBCQueryFilters.FieldByName('FILTERPARAMID').AsInteger := -1;
//                IBCQueryFilters.FieldByName('FILTERNAME_ROM').AsString := dlgSelectFilter.FilterNameRo;
//                IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString := dlgSelectFilter.FilterNameRu;
//                IBCQueryFilters.Post;
//            end;
//        finally
//            dlgSelectFilter.Free;
//        end;
//    end
//    else
  begin
    dlgSelectFilterParam := TfrmWebFiltersDlg.Create(Self, dmDB.IBCConnection);
    try
      defaultFilterID := -1;
      defaultFilterParamID := -1;
      if not IBCQueryFilters.FieldByName('FILTERID').IsNull then
        defaultFilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
      if not IBCQueryFilters.FieldByName('FILTERPARAMID').IsNull then
        defaultFilterParamID := IBCQueryFilters.FieldByName('FILTERPARAMID').AsInteger;
        //    if (defaultFilterID = -1) and (FLastOpenedFilterID > 0) then
        //    begin
        //      defaultFilterID := FLastOpenedFilterID;
        //      // defaultFilterParamID:=FLastOpenedFilterParamID;
        //    end;
      if dlgSelectFilterParam.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
      begin
        IBCQueryFilters.Edit;
        IBCQueryFilters.FieldByName('FILTERID').AsInteger := dlgSelectFilterParam.FilterID;
        IBCQueryFilters.FieldByName('FILTERPARAMID').AsInteger := dlgSelectFilterParam.FilterParamID;
        IBCQueryFilters.FieldByName('PARAM_VALUE_ROM').AsString := dlgSelectFilterParam.FilterParamValueRom;
        IBCQueryFilters.FieldByName('PARAM_VALUE_RUS').AsString := dlgSelectFilterParam.FilterParamValueRus;
        IBCQueryFilters.FieldByName('FILTERNAME_ROM').AsString := dlgSelectFilterParam.FilterNameRom;
        IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString := dlgSelectFilterParam.FilterNameRus;
        IBCQueryFilters.Post;
          //      edFILTER_NAME_ROM.Text := dialog.FilterNameRom;
          //      edFILTER_NAME_RUS.Text := dialog.FilterNameRus;
          //      mmPARAM_VALUE_ROM.Text := dialog.FilterParamValueRom;
          //      mmPARAM_VALUE_RUS.Text := dialog.FilterParamValueRus;
          //      btnChangeFilter.Default := False;
        btnOk.Default := True;
      end;
    finally
      dlgSelectFilterParam.Free;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.CreateImageGrid;
var
  i: Integer;
  imageItem: TImageField;
begin
  lbImages.Items.BeginUpdate;
  try
    lbImages.Items.Clear;
    for i := 0 to fImageList.Count - 1 do
    begin
      imageItem := TImageField(fImageList[i]);
      lbImages.Items.AddObject('', imageItem);
    end;
    lbImages.Columns := 3;
    if lbImages.Items.Count > 0 then
      lbImages.ItemIndex := 0;
    AdjustImagesItemHeight;
  finally
    lbImages.Items.EndUpdate;
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFiltersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and bbFilterEdit.Enabled then
  begin
    bbFilterEditClick(bbFilterEdit);
    AHandled := True;
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFiltersTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  FilterSelectionChanged;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFiltersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridFilters_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridFilters_FLG_GROUP.Index] = 1 then
      AStyle := dmAdditions.cxStyle_BoldYellowBack;
    if ARecord.Values[cxGridFilters_FLG_VISIBLE.Index] = 0 then
      AStyle := dmAdditions.cxStyle_TextGray
    else if ARecord.Values[cxGridFilters_FLG_GOODS_LINK.Index] = 1 then
      AStyle := dmAdditions.cxStyle_Link;
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFilters_FILTERNAME_ROMGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridFilters_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridFilters_FLG_GROUP.Index] = 1 then
    begin
      if not VarIsNull(ARecord.Values[cxGridFilters_PARAM_VALUE_ROM.Index]) then
        AText := ARecord.Values[cxGridFilters_PARAM_VALUE_ROM.Index];
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFilters_FILTERNAME_RUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridFilters_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridFilters_FLG_GROUP.Index] = 1 then
    begin
      if not VarIsNull(ARecord.Values[cxGridFilters_PARAM_VALUE_RUS.Index]) then
        AText := ARecord.Values[cxGridFilters_PARAM_VALUE_RUS.Index];
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFilters_PARAM_VALUE_ROMGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridFilters_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridFilters_FLG_GROUP.Index] = 1 then
      AText := '';
  end;
end;

procedure TfrmContentGoodsEditorDlg.cxGridFilters_PARAM_VALUE_RUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridFilters_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridFilters_FLG_GROUP.Index] = 1 then
      AText := '';
  end;
end;

procedure TfrmContentGoodsEditorDlg.DeleteSelectedImage;
var
  imageItem: TImageField;
  N: Integer;
begin
  N := lbImages.ItemIndex;
  if N = -1 then
    Exit;

  if ShowAskDialog('Sterge imaginea', 'Stergeti imagininea selectata?') <> mrYes then
    Exit;

  imageItem := TImageField(lbImages.Items.Objects[N]);
  imageItem.MarkDeleted;

  // delete item
  lbImages.Items.BeginUpdate;
  try
    lbImages.Items.Delete(N);
    if (N >= lbImages.Items.Count) then
      Dec(N);
    if (N >= 0) and (N < lbImages.Items.Count) then
      lbImages.ItemIndex := N;

    fContentChanged := True;
  finally
    lbImages.Items.EndUpdate;
  end;
  // remove object
  if imageItem.Status = ifSNew then
  begin
    fImageList.Remove(imageItem);
    imageItem.Free;
  end;
end;

destructor TfrmContentGoodsEditorDlg.Destroy;
begin
  try
    ClearClipboardList;
    ClearImageList;

  finally
    fParamsList.Free;
    fClipboardList.Free;
    fImageList.Free;
    fWorkBMP.Free;
    inherited;
  end;
end;

procedure TfrmContentGoodsEditorDlg.actSaveImagesExecute(Sender: TObject);
begin
  SaveImagesToDB;
end;

procedure TfrmContentGoodsEditorDlg.actSaveImagesUpdate(Sender: TObject);
begin
  actSaveImages.Enabled := IsImagesModified;
end;

procedure TfrmContentGoodsEditorDlg.actSaveSearchKeysExecute(Sender: TObject);
begin
  IBCQuerySearchkeys.Post;
end;

procedure TfrmContentGoodsEditorDlg.actSaveSearchKeysUpdate(Sender: TObject);
begin
  actSaveSearchKeys.Enabled := (IBCQuerySearchkeys.State in dsEditModes);
end;

procedure TfrmContentGoodsEditorDlg.DoDeleteFilter;
begin
//  if SWNSecurityManager.UserIsPartOfGroup(5) then
//  begin
//    var SumaAmenda := '30';
//    if InputQuery('Introduceri marimea amenzii', 'Amenda', SumaAmenda) then
//    begin
//      ProceedPenalityForUser(ResponsableContentUserID, 'Imagine gresita', SumaAmenda.ToInteger);
//    end;
//  end;
  ProceedPenalityForUser(ResponsableContentUserID, 'Imagine gresita', 0);
  IBCQueryFilters.First;
  while not IBCQueryFilters.Eof do
  begin
    IBCQueryFilters.Delete;
  end;

end;

procedure TfrmContentGoodsEditorDlg.DoImportDescritpionTemplate(const GoodsID, TemplateID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    // era localupdate
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_GOODS_DESC_TEMPLATE(:GoodsID, :TemplateID)';
    Query.ParamByName('GoodsID').AsInteger := GoodsID;
    Query.ParamByName('TemplateID').AsInteger := TemplateID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.bbDeleteGoodsPropertyClick(Sender: TObject);
begin
  if MessageDlg('Sterge inregistrarea?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryFilters.Delete;
end;

procedure TfrmContentGoodsEditorDlg.bbModifyGoodsTitleClick(Sender: TObject);
begin
  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edCODE) then
  begin
    SelectNext(frameGoodsEditDescription1.edCode, True, True);
    SelectNext(frameGoodsEditDescription1.edCode, False, True);
  end;

  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edBASE_PARAM) then
  begin
    SelectNext(frameGoodsEditDescription1.edBASE_PARAM, True, True);
    SelectNext(frameGoodsEditDescription1.edBASE_PARAM, False, True);
  end;

  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edDETAILS) then
  begin
    SelectNext(frameGoodsEditDescription1.edDETAILS, True, True);
    SelectNext(frameGoodsEditDescription1.edDETAILS, False, True);
  end;

//  if (ActiveControl.ClassName.ToLower = 'tcxdbtextedit') then  begin
//    SelectNext(ActiveControl, True, True);
//    SelectNext(ActiveControl, False, True);
//  end;

//  if (dmdb.CurrentUserID=204) and (MessageDlg('Modifica denumirea de sistema ?', mtConfirmation, [mbYes, mbNO], 0)=mrYes) then begin

  if (fMasterDataSet.Active) and not (fMasterDataSet.State in [dsEdit, dsInsert]) then
    fMasterDataSet.Edit;
  fMasterDataSet.fieldByName('TITLE').AsString := frameGoodsEditDescription1.lbWebNameRo.Caption;
//  end;
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton2Click(Sender: TObject);
var
  imgItem: TImageField;
  bmp: TBitmap;
  png: TPngImage;
  hMem: THandle;
  pData: Pointer;
  ms: TMemoryStream;
  CF_PNG: Word;
begin
  CF_PNG := RegisterClipboardFormat('PNG');

  bmp := TBitmap.Create;
  try
    if Clipboard.HasFormat(CF_PNG) then
    begin
      // Preluăm PNG din clipboard (păstrează alpha)
      png := TPngImage.Create;
      ms := TMemoryStream.Create;
      try
        Clipboard.Open;
        try
          hMem := Clipboard.GetAsHandle(CF_PNG);
          pData := GlobalLock(hMem);
          try
            ms.WriteBuffer(pData^, GlobalSize(hMem));
            ms.Position := 0;
          finally
            GlobalUnlock(hMem);
          end;
        finally
          Clipboard.Close;
        end;

        png.LoadFromStream(ms);

        // Desenăm PNG pe fundal alb
        bmp.SetSize(png.Width, png.Height);
        bmp.PixelFormat := pf24bit;
        bmp.Canvas.Brush.Color := clWhite;
        bmp.Canvas.FillRect(Rect(0, 0, bmp.Width, bmp.Height));
        bmp.Canvas.Draw(0, 0, png);
      finally
        ms.Free;
        png.Free;
      end;
    end
    else
    begin
      // Fallback la CF_BITMAP dacă PNG nu e disponibil
      bmp.LoadFromClipboardFormat(CF_BITMAP, Clipboard.GetAsHandle(CF_BITMAP), 0);
    end;

    imgItem := TImageField.Create(GetNewImageID, ifSNew);
    imgItem.fImage.Assign(bmp);
    imgItem.OrderNo := GetNextOrderNoForImage;
    fImageList.Add(imgItem);

    lbImages.Items.BeginUpdate;
    try
      lbImages.ItemIndex := lbImages.Items.AddObject('', imgItem);
      fContentChanged := True;
    finally
      lbImages.Items.EndUpdate;
    end;
    IsImagesModified := True;
  finally
    bmp.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton3Click(Sender: TObject);
begin
  TImageField(lbImages.Items.Objects[lbImages.ItemIndex]).fStatus := ifsUpdated;
  TImageField(lbImages.Items.Objects[lbImages.ItemIndex]).ImageType := 1;
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton4Click(Sender: TObject);
begin
  ibcqueryFilters.Edit;
  ibcqueryFilters.FieldByName('FLG_Visible').AsInteger := Abs(ibcqueryFilters.FieldByName('FLG_Visible').AsInteger - 1);
  ibcqueryFilters.Post;
end;

procedure TfrmContentGoodsEditorDlg.bbImportClick(Sender: TObject);
begin
  ImportFilters(fMasterDataSet.FieldByName('GoodsID').AsInteger);
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton7Click(Sender: TObject);
begin
  if (MessageDlg('Sigur doriti sa stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    IBCQueryWebGoods.Delete;
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton8Click(Sender: TObject);
var
  url: string;
//    paurl: PAnsiChar;
//    isize: Integer;
begin
  if dxcmbBarcode.Text <> '' then
    url := 'https://www.google.com/search?tbm=isch&q=' + dxcmbBarcode.Text
  else
  begin
    url := 'https://www.google.com/search?tbm=isch&q=' + fMasterDataSet.FieldByName('TITLE').Asstring
  end;

  ShellExecute(0, 'open', PChar(UrlDecode(url)), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmContentGoodsEditorDlg.bbFilterPropertiesClick(Sender: TObject);
begin
  ShowModifyFilterDialog;
end;

procedure TfrmContentGoodsEditorDlg.bbHistoryClick(Sender: TObject);
var
  dialog: TfrmHistoryGoodsFiltersDlg;
begin
  dialog := TfrmHistoryGoodsFiltersDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.bbPClick(Sender: TObject);
var
  control: TDBSynEdit;
begin
  if mmGOODS_Description_RO.Focused then
    control := mmGOODS_Description_RO
  else
    control := mmGOODS_DESCRIPTION;

  control.SelText := Format('<p>%s</p>'#13#10, [control.SelText]);
end;

procedure TfrmContentGoodsEditorDlg.bbBClick(Sender: TObject);
var
  control: TDBSynEdit;
begin
  if mmGOODS_Description_RO.Focused then
    control := mmGOODS_Description_RO
  else
    control := mmGOODS_DESCRIPTION;

  control.SelText := Format('<b>%s</b>'#13#10, [control.SelText]);
end;

procedure TfrmContentGoodsEditorDlg.bbImgClick(Sender: TObject);
var
  control: TDBSynEdit;
begin
  if mmGOODS_Description_RO.Focused then
    control := mmGOODS_Description_RO
  else
    control := mmGOODS_DESCRIPTION;

  control.SelText := '<img src="images/..." alt="" />'#13#10;
end;

procedure TfrmContentGoodsEditorDlg.bbImportImageFromGoodsClick(Sender: TObject);
var
  GoodsID: string;
  query: TIBCQuery;
begin
  if InputQuery('Import din alt produs', 'Introduceri codul produsului:', GoodsID) then
  begin
    query := TIBCQuery.Create(nil);

    query.Transaction := IBCTrImage;
    query.SQL.Text := 'execute procedure copygoodsimages(:from_goodsid, :to_goodsid)';
    query.ParamByName('from_goodsid').AsString := GoodsID;
    query.ParamByName('TO_GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    IBCTrImage.StartTransaction;
    try
      query.Execute;
      IBCTrImage.Commit;
    except
      on e: Exception do
      begin
        IBCTrImage.Rollback;
        raise;
      end;
    end;


//    dmDB.ExecuteQuery('execute procedure CopyGoodsImages(:from_goodsid, :to_goodsid)', [GoodsID,
//      fMasterDataSet.FieldByName('GOODSID').AsInteger]);
    RefreshImageList;
  end;

end;

procedure TfrmContentGoodsEditorDlg.dxBarPopupMenuFiltersPopup(Sender: TObject);
begin
  if cxGridFiltersTable.DataController.Values[cxGridFiltersTable.Controller.FocusedRecordIndex, cxGridFilters_FLG_VISIBLE.Index]
    = 1 then
    bbChangeFilterVisibility.Caption := 'Ascunde caracterice'
  else
    bbChangeFilterVisibility.Caption := 'Arata caracterice';
end;

procedure TfrmContentGoodsEditorDlg.AdjustImagesItemHeight;
begin
  // horizontal scrolling only
  lbImages.ItemHeight := lbImages.ClientHeight
end;

procedure TfrmContentGoodsEditorDlg.bbRefreshClick(Sender: TObject);
begin
  RefreshImageList;
end;

procedure TfrmContentGoodsEditorDlg.DoImportFilters(IntoGoodsID, FromGoodsID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := fMasterDataSet.UpdateTransaction; //IBCTrLocalUpdate2;
    if not Query.Transaction.Active then
      Query.Transaction.StartTransaction;

    Query.SQL.TeXt := 'EXECUTE PROCEDURE CLONE_GOODS_FILTERS(:FROM_GOODSID, :INTO_GOODSID)';
    Query.ParamByName('INTO_GOODSID').AsInteger := IntoGoodsID;
    Query.ParamByName('FROM_GOODSID').AsInteger := FromGoodsID;
    Query.ExecSQL;

//        Query.SQL.Add('DELETE FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=:NEW_GOODSID');
//        Query.ParamByName('NEW_GOODSID').AsInteger := IntoGoodsID;
//        Query.ExecSQL;
//
//        Query.SQL.Clear;
//        Query.SQL.Add('insert into VW_TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERNAME_ROM, FILTERNAME_RUS,');
//        Query.SQL.Add('FILTERPARAMID, PARAM_VALUE_ROM, PARAM_VALUE_RUS, FLG_VISIBLE, FLG_COMPATIBILITY,');
//        Query.SQL.Add('FLG_COMPARE, FLG_GOODS_LINK, ORDERNO, BUTTONS_LIST)');
//        Query.SQL.Add('select :NEW_GOODSID, FLG_GROUP, FILTERID, FILTERNAME_ROM, FILTERNAME_RUS, FILTERPARAMID, PARAM_VALUE_ROM,');
//        Query.SQL.Add('PARAM_VALUE_RUS, FLG_VISIBLE, FLG_COMPATIBILITY, FLG_COMPARE, FLG_GOODS_LINK, ORDERNO, BUTTONS_LIST');
//        Query.SQL.Add('from VW_TS_GOODS_DESCRIPTIONS');
//        Query.SQL.Add('where goodsid = :old_goodsid');
//        Query.ParamByName('new_goodsid').AsInteger := IntoGoodsID;
//        Query.ParamByName('old_goodsid').AsInteger := FromGoodsID;
//        Query.ExecSQL;
//
//        Query.SQL.Clear;
//        Query.SQL.Add('DELETE FROM TS_GOODS_IMAGE WHERE GOODSID=:NEW_GOODSID');
//        Query.ParamByName('NEW_GOODSID').AsInteger := IntoGoodsID;
//        Query.ExecSQL;
//
//      // ts_goods_image
//        Query.SQL.Clear;
//        Query.SQL.Add('insert into TS_GOODS_IMAGE (GOODSID, GOODS_IMAGE_ID, IMAGE, DATA_START, DATA_END, ORDERNO, CREATED_BY, CREATED_DATE, FLAGS)');
//        Query.SQL.Add('select :NEW_GOODSID, GOODS_IMAGE_ID, IMAGE, DATA_START, DATA_END, ORDERNO, CREATED_BY, CREATED_DATE, FLAGS');
//        Query.SQL.Add('from TS_GOODS_IMAGE');
//        Query.SQL.Add('where goodsid = :old_goodsid');
//
//        Query.ParamByName('new_goodsid').AsInteger := IntoGoodsID;
//        Query.ParamByName('old_goodsid').AsInteger := FromGoodsID;
//        Query.ExecSQL;
//
//      // ts_goods_dsc
//        Query.SQL.Clear;
//        Query.SQL.Add('DELETE FROM TS_GOODS_DSC WHERE GOODSID=:NEW_GOODSID');
//        Query.ParamByName('NEW_GOODSID').AsInteger := IntoGoodsID;
//        Query.ExecSQL;
//
//        Query.SQL.Clear;
//        Query.SQL.Add('insert into TS_GOODS_DSC (GOODSID, DESCRIPTION, DESCRIPTION_RO, DESCRIERE_MOBILA)');
//        Query.SQL.Add('select :NEW_GOODSID, DESCRIPTION, DESCRIPTION_RO, DESCRIERE_MOBILA');
//        Query.SQL.Add('from TS_GOODS_DSC');
//        Query.SQL.Add('WHERE GOODSID=:OLD_GOODSID');
//        Query.ParamByName('new_goodsid').AsInteger := IntoGoodsID;
//        Query.ParamByName('old_goodsid').AsInteger := FromGoodsID;
//        Query.ExecSQL;
      // commit changes
    Query.Transaction.Commit;

    IBCQueryFilters.Refresh;
  finally
    Query.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.FillSupplierCodes;
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(Self);
  try
    q.SQL.Text := 'select goods_code, barcode from ts_goods_foreign where goodsid = :goodsid';
    q.ParamByName('goodsid').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    q.Open;
    while not q.eof do
    begin
      dxcmbBarcode.Items.Add(q.FieldByName('BARCODE').AsString);
      q.Next;
    end;
    if dxcmbBarcode.Items.Count > 0 then
      dxcmbBarcode.Text := dxcmbBarcode.Items[0]
    else
      dxcmbBarcode.Text := '';
  finally
    q.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.FilterSelectionChanged;
var
  fEdit, fDelete, fSort, fGotoButtons, fClone: Boolean;
  FLG_FOLDER: Boolean;
begin
  fEdit := False;
  fDelete := False;
  fClone := False;
  fSort := cxGridFiltersTable.DataController.RecordCount > 1;
  fGotoButtons := False;

  if Assigned(cxGridFiltersTable.Controller.FocusedRecord) then
  begin
    FLG_FOLDER := IBCQueryFilters.FieldByName('FLG_GROUP').AsInteger = 1;

    fEdit := True;
    fDelete := True;
    fGotoButtons := True;
    fClone := not FLG_FOLDER;
  end;

  bbFilterEdit.Enabled := fEdit;
  bbFilterProperties.Enabled := fEdit;
  bbFilterClone.Enabled := fClone;
  bbDeleteGoodsProperty.Enabled := fDelete;
  bbFilterSort.Enabled := fSort;
  bbGotoButtons.Enabled := fGotoButtons;
end;

procedure TfrmContentGoodsEditorDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (ModalResult <> mrOk) and fContentChanged then
    CanClose := ShowAskDialog('Datele au fost modificate!', 'Doriti sa iesiti fara a salva datele?') = mrYes;
end;

procedure TfrmContentGoodsEditorDlg.frameGoodsEditDescription2edBASE_PARAM_RUKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if (Key = VK_RETURN) and (ssAlt in Shift) then
  begin
    fMasterDataSet.Edit;
    fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString := fMasterDataSet.FieldByName('BASE_PARAM').AsString;
  end;

end;

procedure TfrmContentGoodsEditorDlg.frameGoodsEditDescription2edCODE_RUKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if (Key = VK_RETURN) and (ssAlt in Shift) then
  begin
    fMasterDataSet.Edit;
    fMasterDataSet.FieldByName('CODE_RU').AsString := fMasterDataSet.FieldByName('CODE').AsString;
  end;
end;

function TfrmContentGoodsEditorDlg.GetNewImageID: Integer;
var
  i: Integer;
  imageItem: TImageField;
begin
  Result := 0;
  for i := 0 to fImageList.Count - 1 do
  begin
    imageItem := TImageField(fImageList[i]);
    if imageItem.fID > Result then
      Result := imageItem.fID;
  end;
  Inc(Result);
end;

function TfrmContentGoodsEditorDlg.GetNextOrderNoForImage: Integer;
var
  i: Integer;
  imageItem: TImageField;
begin
  Result := 0;
  for i := 0 to lbImages.Items.Count - 1 do
  begin
    imageItem := TImageField(lbImages.Items.Objects[i]);
    if imageItem.OrderNo > Result then
      Result := imageItem.OrderNo;
  end;
  Inc(Result);
end;

procedure TfrmContentGoodsEditorDlg.ImportFilters(GoodsID: Integer);
var
  dialog: TfrmGoodsSelectDlg;
begin
  dialog := TfrmGoodsSelectDlg.Create(Self, dmDB.IBCConnection);
  try
    if dialog.ShowModal = mrOk then
      DoImportFilters(GoodsID, dialog.GoodsID);
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.BindingDataSource;
begin
//  IBCTrLocalUpdate.DefaultConnection := fMasterDataSet.Connection;

  fWorkBMP := TBitmap.Create;

  fClipboardList := TList.Create;
  fImageList := TList.Create;
  fParamsList := TList.Create;
  fContentChanged := False;

//  fMasterDataSet.Transaction := fMasterDataSet.Transaction;
//  fMasterDataSet.UpdateTransaction := FUpdateTransaction;

  if Assigned(fMasterDataSet.FindParam('GOODSID')) then
    fMasterDataSet.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;

  fMasterDataSet.Open;

  IBCQueryFilters.Transaction := fMasterDataSet.Transaction;
  IBCQueryFilters.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryFilters.MasterSource := fMasterDataSource;

  IBCQueryDSC.Transaction := fMasterDataSet.Transaction;
  IBCQueryDSC.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryDSC.MasterSource := frameGoodsEditDescription1.IBCDataSourceGOODS;


  mmTITLE.DataBinding.DataSource := fMasterDataSource;

  pcDescriptions.ActivePageIndex := 0;
end;

procedure TfrmContentGoodsEditorDlg.btnGenSlugClick(Sender: TObject);
var
    slug: string;
begin
  // generate slug
  slug := GenerateSlug(
    frameGoodsEditDescription1.IBCDataSourceWebGoodsType.DataSet.FieldByName('TITLE').AsString + ' ' +
    frameGoodsEditDescription1.IBCQueryVendors.FieldByName('TITLE').AsString + ' ' +
    frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('CODE').AsString + ' ' +
    frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString + ' ' +
    frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('DETAILS').AsString + ' ' +
    frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('GOODSID').AsString
  );
end;

procedure TfrmContentGoodsEditorDlg.dxBarButton9Click(Sender: TObject);
var
  url: string;
  imgItem: TImageField;
  bmp: TBitmap;
  hasImage: Boolean;
  ms: TMemoryStream;
begin
  if InputQuery('Download image', 'URL', url) then
  begin
    var httpclient := THTTPClient.Create;
    ms := TMemoryStream.Create;
    httpclient.Get(url, ms);
    ms.Position := 0;


    bmp := TBitmap.Create;
    try
      bmp.LoadFromStream(ms);
      hasImage := True;
      imgItem := TImageField.Create(GetNewImageID, ifSNew);
      imgItem.fImage.Assign(bmp);

      if hasImage then
      begin
        imgItem.OrderNo := GetNextOrderNoForImage;
        fImageList.Add(imgItem);
      end;

      lbImages.Items.BeginUpdate;
      try
        lbImages.ItemIndex := lbImages.Items.AddObject('', imgItem);
        fContentChanged := True;
      finally
        lbImages.Items.EndUpdate;
      end;
      IsImagesModified := True;
    finally
      bmp.Free;
      httpclient.Free;
      ms.Free;
    end;
  end;
end;

function TfrmContentGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    // avertisment neblocant: atribute recomandate necompletate
    var missingAttrs := GetMissingRecommendedAttributes(
      fMasterDataSet.FieldByName('GOODSID').AsInteger,
      fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger,
      fMasterDataSet.UpdateTransaction);
    if missingAttrs <> '' then
      MessageDlg('Atribute recomandate necompletate: ' + missingAttrs + #13#10 +
        'Produsul se salveaza oricum.', mtWarning, [mbOK], 0);

    if not (fMasterDataSet.State in dsEditModes) then
      fMasterDataSet.Edit;

//    if fMasterDataSet.FieldByName('CODE_RU').AsString = '' then
//      fMasterDataSet.FieldByName('CODE_RU').AsString := fMasterDataSet.FieldByName('CODE').AsString;

    if fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString = '' then
      fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString := fMasterDataSet.FieldByName('BASE_PARAM').AsString;


//    if (fMasterDataSet.FieldByName('TITLE').AsString <> frameGoodsEditDescription2.lbWebNameRo.Caption) then
//      if MessageDlg('Denumirea noua creata difera de cea veche, '#13#10' Modificati ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//      begin
//        fMasterDataSet.fieldByName('TITLE').AsString := frameGoodsEditDescription2.lbWebNameRo.Caption;
//      end;

    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    if IBCQueryDSC.State in dsEditModes then
      IBCQueryDSC.Post;
    if IBCQueryWebGoods.State in dsEditModes then
      IBCQueryWebGoods.Post;

    SaveImagesToDB;
    SaveYouTubeToDB;

    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;
    // Generate SEO data

    try
      if not fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.StartTransaction;

      if (fMasterDataSet.fieldByName('TITLE').AsString <> frameGoodsEditDescription1.lbWebNameRo.Caption) then
      begin
        // genereaza denumirea de sistema
        if (fMasterDataSet.Active) and not (fMasterDataSet.State in [dsEdit, dsInsert]) then
          fMasterDataSet.Edit;
        fMasterDataSet.fieldByName('TITLE').AsString := frameGoodsEditDescription1.lbWebNameRo.Caption;
      end;
      GenerateSeoData(fMasterDataSet.FieldByName('GOODSID').AsInteger, fMasterDataSet.UpdateTransaction);

      if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Post;

      fMasterDataSet.UpdateTransaction.Commit;
    except
      on e: Exception do
      begin
        MessageDlg('Eroare la crearea datelor SEO', mtError, [mbOK], 0);
        raise;
      end;
    end;

    SaveToLog(1);
    AppUserTempConfigStorage.IntValues.SetValue('GoodsDescriptions_LastTabIndex', pcPageControl.ActivePageIndex);

    Result := True;
  except
    begin
      if fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.Rollback;
      raise
    end;
  end;

end;

procedure TfrmContentGoodsEditorDlg.lbImagesClick(Sender: TObject);
begin
  SelectionImagesChanged;
end;

procedure TfrmContentGoodsEditorDlg.lbImagesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept:
  Boolean);
begin
  Accept := Source = lbImages;
end;

procedure TfrmContentGoodsEditorDlg.lbImagesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  R, R2: TRect;
  color_back: TColor;
  S: string;
  imageItem: TImageField;
  w, h, w2, h2: Integer;
  delta: Double;
begin
  imageItem := TImageField(lbImages.Items.Objects[Index]);

  if odFocused in State then
    color_back := $00FF9933 // clActiveCaption
  else if odSelected in State then
    color_back := $00FEECD9 // $00F0F0F0 // clHighlight
  else
    color_back := clWindow;

  fWorkBMP.Width := Rect.Right - Rect.Left;
  fWorkBMP.Height := Rect.Bottom - Rect.Top;

  R := Types.Rect(0, 0, fWorkBMP.Width, fWorkBMP.Height);
  InflateRect(R, -4, -4);
  R2 := R;

  with fWorkBMP.Canvas do
  begin
    Brush.Color := color_back;
    FillRect(Types.Rect(0, 0, fWorkBMP.Width, fWorkBMP.Height));

    // selection
    Pen.Style := psClear;
    Brush.Color := clWindow;
    Brush.Style := bsSolid;
    Rectangle(R);

    InflateRect(R, -1, -1);
    // header
    R.Bottom := R.Top + 23;
    if odFocused in State then
    begin
      Brush.Color := $00F0F0F0;
      FillRect(R);
    end;

    InflateRect(R, -2, -2);

    Brush.Style := bsClear;
    // header text
    // 1. OrderNo
    Inc(R.Left, 8);
    R.Right := R.Left + 20;
    Font.Name := 'Tahoma';
    Font.Style := [fsBold];
    Font.Size := 12;

    S := IntToStr(Index + 1);
    Font.Color := clWindowText;
    DrawText(fWorkBMP.Canvas.Handle, PWideChar(S) + ' ' + PWideChar(imageItem.CreatedBy), Length(S), R, DT_SINGLELINE or
      DT_VCENTER);

    if odFocused in State then
      Font.Color := clWindowText
    else
      Font.Color := clGrayText;
    // 2. geometrical size
    R.Left := R.Right;
    R.Right := R.Left + 60;
    Font.Style := [];
    Font.Size := 8;
    S := Format('%dx%d', [imageItem.Image.Width, imageItem.Image.Height]);
    DrawText(fWorkBMP.Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER);
    // 3. image size
    R.Left := R.Right;
    R.Right := R.Left + 60;
    Font.Style := [];
    Font.Size := 8;
    S := Format('%d KB', [imageItem.ImageSize div 1024]);
    DrawText(fWorkBMP.Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER);

       // 5. username
    R.Left := R.Right;
    R.Right := R.Left + 90;
    DrawText(fWorkBMP.Canvas.Handle, PWideChar(imageItem.CreatedBy), Length(imageItem.CreatedBy), R, DT_SINGLELINE or DT_VCENTER);

    // 4. event
    R.Right := fWorkBMP.Width - 14;
    R.Left := R.Right - 140;
    if imageItem.HasEvent then
    begin
      Font.Style := [];
      Font.Size := 8;
      Font.Style := [fsBold];
      S := FormatDateTime('dd.mm.yyyy', imageItem.fDateStart) + ' - ' + FormatDateTime('dd.mm.yyyy', imageItem.fDateEnd);
      DrawText(fWorkBMP.Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER);
      // 4.1. event image
      dmAdditions.cxImageList_SWN.Draw(fWorkBMP.Canvas, R.Left - dmAdditions.cxImageList_SWN.Width - 4, R.Top + (R.Bottom - R.Top
        - dmAdditions.cxImageList_SWN.Height) div 2, 37);
    end;
    // image
    R := R2;
    R.Top := R2.Top + 24;
    InflateRect(R, -1, -1);
    w := R.Right - R.Left;
    h := R.Bottom - R.Top;
    if (imageItem.Image.Width <= w) and (imageItem.Image.Height <= h) then
    begin
      // image is smaller than display area, draw it in center
      Draw(R.Left + (w - imageItem.Image.Width) div 2, R.Top + (h - imageItem.Image.Height) div 2, imageItem.Image);
    end
    else
    begin
      // image is bigger, stretch it proportionaly
      delta := Max(imageItem.Image.Width / w, imageItem.Image.Height / h);
      {
        if imageItem.Image.Width>=imageItem.Image.Height
        then delta:=imageItem.Image.Width/Min(w,h)
        else delta:=imageItem.Image.Height/Min(w,h);
      }

      w2 := Round(imageItem.Image.Width / delta);
      h2 := Round(imageItem.Image.Height / delta);

      R := Types.Rect(R.Left + (w - w2) div 2, R.Top + (h - h2) div 2, R.Left + ((w - w2) div 2) + w2, R.Top + ((h - h2) div
        2) + h2);
      StretchDraw(R, imageItem.Image);
    end;
  end;

  lbImages.Canvas.Draw(Rect.Left, Rect.Top, fWorkBMP);
end;

procedure TfrmContentGoodsEditorDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    // form position
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
      (Self) then
      Self.Position := poDesigned;
    // read column visibility and width
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridFiltersTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmContentGoodsEditorDlg.MoveCurrentImageDown;
var
  N, temp: Integer;
  img1, img2: TImageField;
begin
  N := lbImages.ItemIndex;
  if (N = -1) or ((N + 1) > (lbImages.Count - 1)) then
    Exit;

  img1 := TImageField(lbImages.Items.Objects[N]);
  img2 := TImageField(lbImages.Items.Objects[N + 1]);

  lbImages.Items.BeginUpdate;
  try
    // swap ID
    temp := img1.OrderNo;
    img1.OrderNo := img2.OrderNo;
    img2.OrderNo := temp;

    // swap objects
    lbImages.Items.Objects[N] := lbImages.Items.Objects[N + 1];
    lbImages.Items.Objects[N + 1] := img1;
    // move focus
    lbImages.ItemIndex := N + 1;

    fContentChanged := True;
  finally
    lbImages.Items.EndUpdate;
  end;
end;

procedure TfrmContentGoodsEditorDlg.MoveCurrentImageUp;
var
  N, temp: Integer;
  img1, img2: TImageField;
begin
  N := lbImages.ItemIndex;
  if (N = -1) or ((N - 1) < 0) then
    Exit;

  img1 := TImageField(lbImages.Items.Objects[N]);
  img2 := TImageField(lbImages.Items.Objects[N - 1]);

  lbImages.Items.BeginUpdate;
  try
    // swap ID
    temp := img1.OrderNo;
    img1.OrderNo := img2.OrderNo;
    img2.OrderNo := temp;

    // swap objects
    lbImages.Items.Objects[N] := lbImages.Items.Objects[N - 1];
    lbImages.Items.Objects[N - 1] := img1;
    // move focus
    lbImages.ItemIndex := N - 1;

    fContentChanged := True;
  finally
    lbImages.Items.EndUpdate;
  end;
end;

procedure TfrmContentGoodsEditorDlg.Prepare;
//var
//    AllowChange: Boolean;
begin
  try
    if not fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.StartTransaction;

    frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet := fMasterDataSet;
    pcPageControl.ActivePageIndex := ActiveTabsheetIndex;
    Caption := Format('Produs #%d', [fMasterDataSet.FieldByName('GOODSID').AsInteger]);
    if Assigned(fMasterDataSet.Fields.FindField('FLG_FOLDER')) then
      fIsFolder := fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger = 1
    else
      fIsFolder := False;
    FilterSelectionChanged;
    SelectionImagesChanged;
    StartTime := Now;
    RemoveSpecialCharacters;
    frameGoodsEditDescription1.UpdatelbWebName;
    IsImagesLoaded := False;
    IsImagesModified := False;
    Prepare_tbWebName;
    IBCQueryDSC.Active := True;
    IBCQueryFilters.Active := True;
    LoadYouTubeFromDB;
  except
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmContentGoodsEditorDlg.LoadImagesFromDB;
var
  Query: TIBCQuery;
  imageItem: TImageField;
  MS: TMemoryStream;
begin
  Query := TIBCQuery.Create(Self);
  MS := TMemoryStream.Create;
  fImageList.Clear;
  try
    Query.Connection := fIBCConnection;
    Query.SQL.Add('SELECT gi.*, u.full_name FROM TS_GOODS_IMAGE gi');
    Query.SQL.Add('inner join ts_users u on u.userid = gi.created_by');
    Query.SQL.Add('WHERE (GOODSID=:GoodsID) ORDER BY ORDERNO');
    Query.ParamByName('GoodsID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      imageItem := TImageField.Create(Query.FieldByName('GOODS_IMAGE_ID').AsInteger, ifsInUse);
      imageItem.FOrderNo := Query.FieldByName('ORDERNO').AsInteger;
      imageItem.ImageType := Query.FieldByName('FLAGS').AsInteger;
      imageItem.CreatedBy := Query.FieldByName('FULL_NAME').AsString;
      MS.Clear;
      TBlobField(Query.FieldByName('IMAGE')).SaveToStream(MS);
      MS.Position := 0;
      imageItem.LoadFromStream(MS);

      if (not Query.FieldByName('DATA_START').IsNull) and (not Query.FieldByName('DATA_END').IsNull) then
        imageItem.SetDates(Query.FieldByName('DATA_START').AsDateTime, Query.FieldByName('DATA_END').AsDateTime);

      fImageList.Add(imageItem);
      Query.Next;
    end;
    Query.Close;
  finally
    MS.Free;
    Query.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.RefreshImageList;
begin
  ClearImageList;
  LoadImagesFromDB;
  CreateImageGrid;

  AdjustImagesItemHeight;
  FillSupplierCodes;

  FilterSelectionChanged;
  SelectionImagesChanged;
  IsImagesLoaded := True;
end;

procedure TfrmContentGoodsEditorDlg.ShowAddFilterDialog;
var
  dialog: TfrmWebDescriptionElementEditorDlg;
begin
  dialog := TfrmWebDescriptionElementEditorDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewDescription := True;
    dialog.InGoodsDescription := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ShowCurrentImageEventDialog;
var
  dialog: TfrmGoodsImageEventDlg;
  imageItem: TImageField;
  N: Integer;
begin
  N := lbImages.ItemIndex;
  if N = -1 then
    Exit;

  imageItem := TImageField(lbImages.Items.Objects[N]);

  dialog := TfrmGoodsImageEventDlg.Create(Self);
  try
    if imageItem.HasEvent then
    begin
      dialog.HasEvent := True;
      dialog.Data_Start := imageItem.DateStart;
      dialog.Data_End := imageItem.DateEnd;
    end;

    if dialog.ShowModal = mrOk then
    begin
      if dialog.HasEvent then
        imageItem.SetDates(dialog.Data_Start, dialog.Data_End)
      else if imageItem.HasEvent then
        imageItem.ClearDates;
      fContentChanged := True;
      lbImages.Repaint;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ShowDescriptionGotoButtonsDialog;
var
  dialog: TfrmGoodsDescFilterButtonsDlg;
begin

  begin
    dialog := TfrmGoodsDescFilterButtonsDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
    try
      dialog.ShowModal;
      if dialog.ButtonsChanged then
        IBCQueryFilters.Refresh;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ShowModifyFilterDialog;
var
  dialog: TfrmWebDescriptionElementEditorDlg;
  frmOrdinaryFilterValueDlg: TfrmOrdinaryFilterValueDlg;
begin
  if IBCQueryFilters.FieldByName('FLG_ORDINARY_FILTER').AsInteger = 1 then
  begin
    frmOrdinaryFilterValueDlg := TfrmOrdinaryFilterValueDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
    try
      frmOrdinaryFilterValueDlg.ShowModal;
    finally
      frmOrdinaryFilterValueDlg.Free;
    end;
  end
  else
  begin
    dialog := TfrmWebDescriptionElementEditorDlg.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
    try
      dialog.CreateNewDescription := False;
      dialog.InGoodsDescription := True;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ShowSelectTemplateDialog;
var
  dialog: TfrmGoodsFilterTemplateSelectorDlg;
  TemplateID: Integer;
begin
//  IBCQueryWebGoods.FieldByName('goodsid').GoodsID
  TemplateID := GetDefaultTemplateID(fMasterDataSet.FieldByName('GOODSID').AsInteger);
  if (TemplateID > 0) then
  begin
    if (MessageDlg('Datele curente vor fi sterse, continuam>', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      DoImportDescritpionTemplate(fMasterDataSet.FieldByName('GOODSID').AsInteger, TemplateID);

      fMasterDataSet.UpdateTransaction.Commit;
      fMasterDataSet.UpdateTransaction.StartTransaction;

      IBCQueryFilters.Refresh;
    end;
  end
  else
  begin
    dialog := TfrmGoodsFilterTemplateSelectorDlg.Create(Self);
    try
      if dialog.ShowModal = mrOk then
      begin
        if ShowAskDialog('Descrierea produselor', Format('Adaugare din sablon "%s"?', [dialog.TemplateTitleRus]),
          'Atentie! toate caracteristicile curente vor fi sterse') = mrYes then
        begin
          DoImportDescritpionTemplate(fMasterDataSet.FieldByName('GOODSID').AsInteger, dialog.TemplateID);

          fMasterDataSet.UpdateTransaction.Commit;
          fMasterDataSet.UpdateTransaction.StartTransaction;

          IBCQueryFilters.Refresh;
        end;
      end;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmContentGoodsEditorDlg.ShowSortFiltersDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self, fMasterDataSet.UpdateTransaction{IBCTrLocalUpdate});
  try
    dialog.DBTable := cosGoodsDescriptions;
    dialog.ParentID := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFilters.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.SaveImagesToDB;
var
  Query: TIBCQuery;
  imageItem: TImageField;
  MS: TMemoryStream;
  i: Integer;
begin
  Query := TIBCQuery.Create(Self);
  MS := TMemoryStream.Create;
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction; //IBCTrLocalUpdate;
    // delete images
    Query.SQL.Text := 'DELETE FROM TS_GOODS_IMAGE WHERE (GOODSID=:GOODSID) AND (GOODS_IMAGE_ID=:IMAGEID)';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    for i := 0 to fImageList.Count - 1 do
    begin
      imageItem := TImageField(fImageList[i]);
      if imageItem.Status = ifsDeleted then
      begin
        Query.ParamByName('IMAGEID').AsInteger := imageItem.ID;
        Query.ExecSQL;
      end;
    end;

    // insert new images
    Query.SQL.Text := 'INSERT INTO TS_GOODS_IMAGE (GOODSID, GOODS_IMAGE_ID, IMAGE, DATA_START, DATA_END, ORDERNO, FLAGS) ' +
      'VALUES (:GOODSID, :imageID, :IMAGE, :DATA_START, :DATA_END, :ORDERNO, :FLAGS)';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;

    for i := 0 to fImageList.Count - 1 do
    begin
      imageItem := TImageField(fImageList[i]);
      if imageItem.Status = ifSNew then
      begin
        Query.ParamByName('IMAGEID').AsInteger := imageItem.ID;
        Query.ParamByName('FLAGS').AsInteger := imageItem.ImageType;
        imageItem.Image.SaveToStream(MS);
        MS.Position := 0;
        Query.ParamByName('IMAGE').LoadFromStream(MS, ftBlob);
        MS.Clear;
        if imageItem.HasEvent then
        begin
          Query.ParamByName('DATA_START').AsDate := imageItem.DateStart;
          Query.ParamByName('DATA_END').AsDate := imageItem.DateEnd;
        end
        else
        begin
          Query.ParamByName('DATA_START').Value := Null;
          Query.ParamByName('DATA_END').Value := Null;
        end;
        Query.ParamByName('ORDERNO').AsInteger := imageItem.OrderNo;
        Query.ExecSQL;
      end;
    end;

    // update
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE TS_GOODS_IMAGE SET DATA_START=:DATA_START, DATA_END=:DATA_END, IMAGE=:IMAGE, ORDERNO=:ORDERNO, FLAGS=:FLAGS ');
    Query.SQL.Add('WHERE (GOODSID=:GoodsID) AND (GOODS_IMAGE_ID=:imageID)');
    Query.ParamByName('GoodsID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    for i := 0 to fImageList.Count - 1 do
    begin
      imageItem := TImageField(fImageList[i]);
      if imageItem.Status = ifsUpdated then
      begin
        Query.ParamByName('imageID').AsInteger := imageItem.ID;
        Query.ParamByName('FLAGS').AsInteger := imageItem.ImageType;
        if imageItem.HasEvent then
        begin
          Query.ParamByName('DATA_START').AsDate := imageItem.DateStart;
          Query.ParamByName('DATA_END').AsDate := imageItem.DateEnd;
        end
        else
        begin
          Query.ParamByName('DATA_START').Value := Null;
          Query.ParamByName('DATA_END').Value := Null;
        end;
        Query.ParamByName('ORDERNO').AsInteger := imageItem.OrderNo;

        imageItem.Image.SaveToStream(MS);
        MS.Position := 0;
        Query.ParamByName('IMAGE').LoadFromStream(MS, ftBlob);
        MS.Clear;

        Query.ExecSQL;
      end;
    end;

    // update ID only (reorder)
    Query.SQL.Text := 'UPDATE TS_GOODS_IMAGE SET ORDERNO=:ORDERNO WHERE (GOODSID=:GoodsID) AND (GOODS_IMAGE_ID=:imageID)';
    Query.ParamByName('GoodsID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    for i := 0 to fImageList.Count - 1 do
    begin
      imageItem := TImageField(fImageList[i]);
      if imageItem.Status = ifsReordered then
      begin
        Query.ParamByName('IMAGEID').AsInteger := imageItem.ID;
        Query.ParamByName('ORDERNO').AsInteger := imageItem.OrderNo;
        Query.ExecSQL;
      end;
    end;
    IsImagesModified := True;

//    // Force reorder Images
//    Query.Active := false;
//    Query.SQL.Text := 'execute procedure update_good_image_id(:goodsid)';
//    Query.ParamByName('goodsid').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
//    Query.ExecSQL;

  finally
    MS.Free;
    Query.Free;
  end;

  try
  finally

  end;

end;

procedure TfrmContentGoodsEditorDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    // store column visibility and width
//    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridFiltersTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmContentGoodsEditorDlg.SaveToLog(UserAction: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  Query.AutoCommit := False;
  try
    Query.SQL.Text :=
      'insert into tlog_goods_description (goodsid, start_timestamp, end_timestamp, user_action) values(:goodsid, :start_timestamp, :end_timestamp, :user_action)';
    Query.ParamByName('goodsid').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ParamByName('start_timestamp').AsDateTime := StartTime;
    Query.ParamByName('end_timestamp').AsDateTime := Now;
    Query.paramByname('user_action').Asinteger := UserAction;
    Query.Transaction := IBCTrLog;
    if not IBCTrLog.Active then
      IBCTrLog.StartTransaction;

    try
      Query.ExecSQL;
      if IBCTrLog.Active then
        IBCTrLog.Commit;
    except
      on e: Exception do
      begin
        IBCTrLog.Rollback;
        raise;
      end;
    end;
  finally
    Query.Free;
  end;

end;

procedure TfrmContentGoodsEditorDlg.frameGoodsEditDescription2edBASE_PARAM_RUDblClick(Sender: TObject);
begin
  fMasterDataSet.Edit;
  fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString := fMasterDataSet.FieldByName('BASE_PARAM').AsString;
end;

procedure TfrmContentGoodsEditorDlg.frameGoodsEditDescription2edCODE_RUDblClick(Sender: TObject);
begin
  fMasterDataSet.Edit;
  fMasterDataSet.FieldByName('CODE_RU').AsString := fMasterDataSet.FieldByName('CODE').AsString;
end;


function TfrmContentGoodsEditorDlg.GetDefaultTemplateID(GoodsID: Integer): Integer;
var
  query: TIBCQuery;
begin
  Result := -1;
  query := TIBCQuery.Create(Self);
  try
    query.SQL.Text := 'select g1.templateid from ts_goods g1 ' +
      ' join ts_goods g2 on g2.parentid = g1.goodsid and g2.goodsid = :goodsid';
    query.ParamByName('goodsid').AsInteger := GoodsID;
    query.Open;

    if query.RecordCount > 0 then
      Result := query.FieldByName('templateid').AsInteger;
  finally
    query.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  if NewPage = tbWebName then
  begin
    Prepare_tbWebName;
  end;

  if NewPage = tbsImages then
  begin

  end;

  if NewPage = tbsFilters then
  begin
    IBCQueryFilters.Active := True;
  end;

  if NewPage = tbsDescriptions then
  begin
    IBCQueryDSC.Active := True;
  end;

  if NewPage = tbsAttributes then
  begin
    frameGoodsAttributes1.LoadData(fMasterDataSet.FieldByName('GOODSID').AsInteger,
      fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger, fMasterDataSet.UpdateTransaction);
  end;
end;

procedure TfrmContentGoodsEditorDlg.Prepare_tbWebName;
begin
  IBCQueryWebGoods.Active := False;
  IBCQueryWebGoods.MasterSource := frameGoodsEditDescription1.IBCDataSourceGOODS;
  IBCQueryWebGoods.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryWebGoods.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  IBCQueryWebGoods.Active := True;
  IBCQuerySearchkeys.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySearchkeys.MasterSource := fMasterDataSource;
  IBCQuerySearchkeys.Active := True;
end;

procedure TfrmContentGoodsEditorDlg.ProceedPenalityForUser(UserID: integer; Mentiuni: string; Suma: Integer);
var
  q: TIBCQuery;
  EmployerID: Integer;
begin
  q := TIBCQuery.Create(Self);

  q.SQL.Text := 'select customerid from ts_users where userid = :userid';
  q.ParamByName('USERID').AsInteger := UserID;
  q.Open;
  EmployerID := q.FieldByName('customerid').AsInteger;
  q.Close;

  try
    q.SQL.Text := 'insert into TDB_USER_WORK_BONUS (data, CT, BONUS_VALUE, DESCRIPTION) ' +
      'values (:data, :CT, :BONUS_VALUE, :DESCRIPTION)';
    q.AutoCommit := False;
    q.Transaction := fMasterDataSet.UpdateTransaction;
    q.ParamByName('DATA').AsDateTime := Now;
    q.ParamByName('CT').AsInteger := EmployerID;
    q.ParamByName('BONUS_VALUE').AsInteger := -Suma;
    q.ParamByName('DESCRIPTION').AsString := Mentiuni + ' #' + fMasterDataSet.FieldByName('GOODSID').AsString;
    q.ExecSQL;
  finally
    q.Free;
  end;
end;

procedure TfrmContentGoodsEditorDlg.RemoveSpecialCharacters;
begin
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.Edit;
  var s: string;
  s := frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('CODE').AsString;
  s := StringReplace(s, #$A, '', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, #$D, '', [rfReplaceAll, rfIgnoreCase]);
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('CODE').AsString := DeleteRepeatedSpaces(s);

  s := frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('CODE_RU').AsString;
  s := StringReplace(s, #$A, '', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, #$D, '', [rfReplaceAll, rfIgnoreCase]);
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('CODE_RU').AsString := DeleteRepeatedSpaces(s);

  s := frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString;
  s := StringReplace(s, #$A, '', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, #$D, '', [rfReplaceAll, rfIgnoreCase]);
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString := DeleteRepeatedSpaces(s);

  s := frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString;
  s := StringReplace(s, #$A, '', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, #$D, '', [rfReplaceAll, rfIgnoreCase]);
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString := DeleteRepeatedSpaces(s);

  s := frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('DETAILS').AsString;
  s := StringReplace(s, #$A, '', [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, #$D, '', [rfReplaceAll, rfIgnoreCase]);
  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet.FieldByName('DETAILS').AsString := DeleteRepeatedSpaces(s);
end;

procedure TfrmContentGoodsEditorDlg.SelectionImagesChanged;
var
  f1, f2, f3, f4, f5: Boolean;
begin
  f1 := True; // New + Security
  f2 := False;
  f3 := False;
  f4 := False;
  f5 := False;

  if (lbImages.Items.Count > 0) and (lbImages.ItemIndex <> -1) then
  begin
    f2 := True; // Image Events + Security
    f3 := True; // Delete + Security
    f4 := (lbImages.ItemIndex > 0) and (lbImages.Items.Count > 1);
    f5 := (lbImages.ItemIndex < (lbImages.Items.Count - 1)) and (lbImages.Items.Count > 1);
  end;

  bbAddNewImage.Enabled := f1;
  bbImageEvent.Enabled := f2;
  bbDeleteImage.Enabled := f3;
  bbMoveImageUp.Enabled := f4;
  bbMoveImageDown.Enabled := f5;
  bbShowFullSize.Enabled := f2;
end;

procedure TfrmContentGoodsEditorDlg.SetActiveTabsheetIndex(const Value: Integer);
begin
  FActiveTabsheetIndex := Value;
end;

procedure TfrmContentGoodsEditorDlg.SetupSecurityItems;
begin
  if SWNSecurityManager.IsLimitedUser then
  begin
    bbDeleteGoodsProperty.Enabled := False;
    bbDeleteAllProperties.Enabled := False;
    bbHistory.Enabled := False;
    bbPrint.Enabled := False;
    bbFilterAdd.Visible := ivNever;
    bsiInstrumente.Visible := ivNever;
    bbFilterClone.Visible := ivNever;
    bbGotoButtons.Visible := ivNever;
    bbFilterSort.Visible := ivNever;
    bbImport.Visible := ivNever;
    bbHistory.Visible := ivNever;
    bbPrint.Visible := ivNever;
    bbModifyGoodsTitle.Enabled := False;
    bbImport.Visible := ivNever;
  end;

  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Фильтры_Crearea_filtrelor) then
  begin
    bbFilterSort.Visible := ivAlways;
    bbFilterAdd.Visible := ivAlways;
    bsiInstrumente.Visible := ivAlways;
  end;
end;

procedure TfrmContentGoodsEditorDlg.tbsImagesShow(Sender: TObject);
begin
  if not IsImagesLoaded then
    RefreshImageList;
end;

procedure TfrmContentGoodsEditorDlg.WhenCancelForm;
begin
//  SaveToLog(0);

  if IBCQueryDSC.State in dsEditModes then
    IBCQueryDSC.Cancel;
  if IBCQueryWebGoods.State in dsEditModes then
    IBCQueryWebGoods.Cancel;
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;


//  IBCTrLocalUpdate.Rollback;
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

{ TImageField }

procedure TImageField.ClearDates;
begin
  fDateStart := 0;
  fDateEnd := 0;
  if (fStatus <> ifSNew) then
    fStatus := ifsUpdated;
end;

constructor TImageField.Create(const AID: Integer; const AStatus: TImageFieldStatus);
begin
  fID := AID;
  fImage := TPngImage.Create;
  fStatus := AStatus;
  fDateStart := 0;
  fDateEnd := 0;
end;

destructor TImageField.Destroy;
begin
  fImage.Free;
  inherited;
end;

function TImageField.GetHasEvent: Boolean;
begin
  Result := (fDateStart <> 0) and (fDateEnd <> 0);
end;

procedure TImageField.LoadFromStream(const Stream: TStream);
begin
  fImageSize := Stream.Size;
  Stream.Position := 0;
  fImage.LoadFromStream(Stream);
end;

procedure TImageField.MarkDeleted;
begin
  if (fStatus <> ifSNew) then
    fStatus := ifsDeleted;
end;

procedure TImageField.LoadFromFile(const FileName: string);
var
  MS: TFileStream;
begin
  MS := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(MS);
    if (fStatus <> ifSNew) then
      fStatus := ifsUpdated;
  finally
    MS.Free;
  end;
end;

procedure TImageField.PasteFromClipboard;
begin
  fImage.Assign(Clipboard);
  if (fStatus <> ifSNew) then
    fStatus := ifsUpdated;
end;

procedure TImageField.SetCreatedBy(const Value: string);
begin
  FCreatedBy := Value;
end;

procedure TImageField.SetDates(const ADateStart, ADateEnd: TDateTime);
begin
  fDateStart := DateOf(ADateStart);
  fDateEnd := DateOf(ADateEnd);
  if (fStatus <> ifSNew) then
    fStatus := ifsUpdated;
end;

procedure TImageField.SetImageType(const Value: Integer);
begin
  FImageType := Value;
end;

procedure TImageField.SetOrderNo(const Value: Integer);
begin
  if Value <> FOrderNo then
  begin
    FOrderNo := Value;
    if (fStatus <> ifSNew) then
      fStatus := ifsReordered;
  end;
end;

//  if (Key=VK_TAB) and (Shift=[]) then
//  begin
//    frameGoodsEditDescription2.edCODE.SetFocus;
//    Key := 0;
//  end;

//  if Key=#9 then
//  begin
//    frameGoodsEditDescription2.edCODE.SetFocus;
//    Key := #0;
//  end;

end.

