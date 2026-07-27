unit frmWebPromoIssueGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, SWNBaseUnit, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  IBC, cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, cxDBEdit, cxTextEdit,
  Vcl.StdCtrls, cxCheckBox, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, dxBar, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, DBAccess, MemDS, cxImageComboBox, cxNavigator, cxMaskEdit,
  cxDropDownEdit, dxColorEdit, dxDBColorEdit, dxGalleryControl, dxColorGallery,
  dxDBColorGallery, dxCore, cxLabel, cxDBLabel, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Menus, cxButtons,
  System.ImageList, Vcl.ImgList, cxImageList, dximctrl, Vcl.Buttons, RzPanel, RzDlgBtn,
  dxUIAClasses;

type
  TfrmWebPromoIssueGoodsDlg = class(TSWNCustomForm)
    dxBarManager1: TdxBarManager;
    IBCQueryInfo: TIBCQuery;
    IBCDataSourceInfo: TIBCDataSource;
    cxImageList1: TcxImageList;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    edTITLE_ROM: TcxDBTextEdit;
    edTEXT_RUS: TcxDBTextEdit;
    edTEXT_ROM: TcxDBTextEdit;
    edCATALOG_BTN_RUS: TcxDBTextEdit;
    edCATALOG_BTN_ROM: TcxDBTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    pnSample: TPanel;
    pnSampleInner: TPanel;
    cxDBLabel1: TcxDBLabel;
    cxDBLabel2: TcxDBLabel;
    cxDBImage1: TcxDBImage;
    cmbBackgroundColor: TdxDBColorEdit;
    cmbFontColor: TdxDBColorEdit;
    cxImageComboBox1: TcxImageComboBox;
    cxDBImage2: TcxDBImage;
    RzDialogButtons1: TRzDialogButtons;
    dxBarSubItem1: TdxBarSubItem;
    dxBarManager1Bar1: TdxBar;
    bbImportaDinDescriere: TdxBarButton;
    bbImportaDinAltaPromotie: TdxBarButton;
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cgColorGalleryGetCustomColorSet(Sender: TObject; var ASet: TColors);
    procedure cgColorGalleryChange(Sender: TObject);
    procedure dxDBColorEdit1PropertiesCloseUp(Sender: TObject);
    procedure dxDBColorEdit2PropertiesCloseUp(Sender: TObject);
    procedure cxImageComboBox1PropertiesCloseUp(Sender: TObject);
    procedure bbImportaDinDescriereClick(Sender: TObject);
    procedure bbImportaDinAltaPromotieClick(Sender: TObject);
  private
    FDescriptionRo: string;
    FDescriptionRu: string;
    { Private declarations }
    FPromoActionID: Integer;
    FTitleRo: string;
    FTitleRu: string;
    procedure SetPromoActionID(const Value: Integer);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);
    function CheckValues: Boolean;
    procedure SetDescriptionRo(const Value: string);
    procedure SetDescriptionRu(const Value: string);
    procedure SetTitleRo(const Value: string);
    procedure SetTitleRu(const Value: string);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure LoadStates; override;
    procedure PerformImport(PromoActionID: string);
    procedure SaveStates; override;
  public
    procedure ShowModifyEditorDlg;
    property DescriptionRo: string read FDescriptionRo write SetDescriptionRo;
    property DescriptionRu: string read FDescriptionRu write SetDescriptionRu;
    { Public declarations }
    property PromoActionID: Integer read FPromoActionID write SetPromoActionID;
    property TitleRo: string read FTitleRo write SetTitleRo;
    property TitleRu: string read FTitleRu write SetTitleRu;
    property UpdateTransaction: TIBCTransaction write SetUpdateTransaction;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, frmGoods,
  SWNValueStorageUnit, SWNDBErrors, Vcl.Clipbrd, dxGDIPlusClasses;

function TfrmWebPromoIssueGoodsDlg.CheckValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if IBCQueryInfo.FieldByName('TITLE_RUS').IsNull or (IBCQueryInfo.FieldByName('TITLE_RUS').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire (рус)!');
  if IBCQueryInfo.FieldByName('TITLE_ROM').IsNull or (IBCQueryInfo.FieldByName('TITLE_ROM').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire (rom)!');
  if IBCQueryInfo.FieldByName('TEXT_RUS').IsNull or (IBCQueryInfo.FieldByName('TEXT_RUS').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire (русс)!');
  if IBCQueryInfo.FieldByName('TEXT_ROM').IsNull or (IBCQueryInfo.FieldByName('TEXT_ROM').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire (rom)!');

  if IBCQueryInfo.FieldByName('FLG_HIDE_CATALOG_BUTTON').asInteger = 0 then begin
    if IBCQueryInfo.FieldByName('CATALOG_BTN_RUS').IsNull or (IBCQueryInfo.FieldByName('CATALOG_BTN_RUS').AsString = '') then
      AddErrorToStr(ErrorStr, 'Denumire button in catalog (рус)!');
    if IBCQueryInfo.FieldByName('CATALOG_BTN_ROM').IsNull or (IBCQueryInfo.FieldByName('CATALOG_BTN_ROM').AsString = '') then
      AddErrorToStr(ErrorStr, 'Denumire button in catalog (rom)!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebPromoIssueGoodsDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure TfrmWebPromoIssueGoodsDlg.cxImageComboBox1PropertiesCloseUp(Sender: TObject);
var
  ABitmap: TcxAlphaBitmap;
  APNGImage: TdxPNGImage;
  imageStream: TMemoryStream;
begin
  imageStream := TMemoryStream.Create;
  ABitmap := TcxAlphaBitmap.Create;
  APNGImage := TdxPNGImage.Create;
  try
    cxImageList1.GetImage(cxImageComboBox1.SelectedItem, ABitmap);
    APNGImage.SetBitmap(ABitmap);
    APNGImage.SaveToStream(imageStream);
    imageStream.Position := 0;
    TBlobField(IBCQueryInfo.FieldByName('IMAGE_ICON')).LoadFromStream(imageStream);
  finally
    ABitmap.Free;
    APNGImage.Free;
    imageStream.Free;
  end;

end;

procedure TfrmWebPromoIssueGoodsDlg.dxDBColorEdit1PropertiesCloseUp(Sender: TObject);
begin
  cmbBackgroundColor.PostEditValue;
  pnSample.Color := IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger;
  cxDBImage1.Style.Color := IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger;
end;

procedure TfrmWebPromoIssueGoodsDlg.dxDBColorEdit2PropertiesCloseUp(Sender: TObject);
begin
//  pnSample.Font.Color := IBCQueryInfo.FieldByName('FONT_COLOR').AsInteger;
//  pnSample.Font.Color := cmbFontColor.ColorValue;
  cxDBLabel1.Style.TextColor := cmbFontColor.ColorValue;
  cxDBLabel2.Style.TextColor := cmbFontColor.ColorValue;

//  cxDBImage1.Style.Font.Color := IBCQueryInfo.FieldByName('FONT_COLOR').AsInteger;
end;

procedure TfrmWebPromoIssueGoodsDlg.bbImportaDinAltaPromotieClick(Sender: TObject);
var
  PromoActionID: string;
begin
  PromoActionID := InputBox('codul promotiei', 'cod', '01');
  PerformImport(PromoActionID);
end;


procedure TfrmWebPromoIssueGoodsDlg.bbImportaDinDescriereClick(Sender: TObject);
begin
  IBCQueryInfo.FieldByName('TITLE_ROM').AsString := TitleRo;
  IBCQueryInfo.FieldByName('TITLE_RUS').AsString := TitleRu;
  IBCQueryInfo.FieldByName('TEXT_ROM').AsString := DescriptionRo;
  IBCQueryInfo.FieldByName('TEXT_RUS').AsString := DescriptionRu;
  IBCQueryInfo.FieldByName('CATALOG_BTN_ROM').AsString := 'Promo';
  IBCQueryInfo.FieldByName('CATALOG_BTN_RUS').AsString := 'Акция';
end;

procedure TfrmWebPromoIssueGoodsDlg.cgColorGalleryChange(Sender: TObject);
begin
//  imgIMAGE_ICON.Style.Color := IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger;
//  pnSample.Color := IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger;
//  cxDBImage1.Style.Color := IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger;
end;

procedure TfrmWebPromoIssueGoodsDlg.cgColorGalleryGetCustomColorSet(Sender: TObject; var ASet: TColors);
//var
//  i: Integer;
begin
//  SetLength(ASet, cWebActiuniColorCount);
//  for i := Low(cWebActiuniColors) to High(cWebActiuniColors) do
//    ASet[i] := cWebActiuniColors[i];
end;

function TfrmWebPromoIssueGoodsDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then begin
    if (IBCQueryInfo.State in dsEditModes) then
      IBCQueryInfo.Post;

    IBCQueryInfo.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmWebPromoIssueGoodsDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form position
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
      Self.Position := poDesigned;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoIssueGoodsDlg.PerformImport(PromoActionID: string);
var
  CurrentPromoActionID: string;
  q: TIBCQuery;
begin
  //read from table where id = PromoactionID
  CurrentPromoActionID := IBCQueryInfo.FieldByName('promoactionid').AsString;
  q := TIBCQuery.Create(Self);
  try
    q.SQL.Text := 'select * from vw_tweb_pa_tovar where promoactionid = :promoactionid';
    q.ParamByName('promoactionid').AsString := PromoActionID;
    q.Open;

    with IBCQueryInfo do begin
      Edit;
      FieldByName('image_icon').AsString := q.FieldByName('image_icon').AsString;
      FieldByName('title_rom').AsString := q.FieldByName('title_rom').AsString;
      FieldByName('text_rom').AsString := q.FieldByName('text_rom').AsString;
      FieldByName('title_rus').AsString := q.FieldByName('title_rus').AsString;
      FieldByName('text_rus').AsString := q.FieldByName('text_rus').AsString;
      FieldByName('catalog_btn_rom').AsString := q.FieldByName('catalog_btn_rom').AsString;
      FieldByName('catalog_btn_rus').AsString := q.FieldByName('catalog_btn_rus').AsString;
      FieldByName('background_color').AsString := q.FieldByName('background_color').AsString;
      FieldByName('font_color').AsString := q.FieldByName('font_color').AsString;
      Post;
    end;
  finally
    q.Free;
  end;

end;

procedure TfrmWebPromoIssueGoodsDlg.Prepare;
begin
//  pcPages.ActivePage := tbsInfo;

  if not IBCQueryInfo.UpdateTransaction.Active then
    IBCQueryInfo.UpdateTransaction.StartTransaction;

  try
    IBCQueryInfo.ParamByName('ID').AsInteger := FPromoActionID;
    IBCQueryInfo.Active := True;
    if IBCQueryInfo.EOF then begin
             // new
      IBCQueryInfo.Insert;

      IBCQueryInfo.FieldByName('FONT_COLOR').AsInteger := rgb(255, 255, 255);
      IBCQueryInfo.FieldByName('BACKGROUND_COLOR').AsInteger := rgb(192, 0, 0);

      IBCQueryInfo.FieldByName('PROMOACTIONID').AsInteger := FPromoActionID;
      IBCQueryInfo.FieldByName('FLG_HIDE_CATALOG_BUTTON').AsInteger := 0;
    end
    else begin
             // edit
      IBCQueryInfo.Edit;

//    cmbFontColor.ColorValue := IBCQueryInfo.FieldByName('FONT_COLOR').AsInteger;
      dxDBColorEdit2PropertiesCloseUp(Self);
    end;
  except
    IBCQueryInfo.Cancel;
    IBCQueryInfo.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebPromoIssueGoodsDlg.SaveStates;
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

procedure TfrmWebPromoIssueGoodsDlg.SetDescriptionRo(const Value: string);
begin
  FDescriptionRo := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.SetDescriptionRu(const Value: string);
begin
  FDescriptionRu := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.SetPromoActionID(const Value: Integer);
begin
  FPromoActionID := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.SetTitleRo(const Value: string);
begin
  FTitleRo := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.SetTitleRu(const Value: string);
begin
  FTitleRu := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.SetUpdateTransaction(const Value: TIBCTransaction);
begin
  IBCQueryInfo.UpdateTransaction := Value;
end;

procedure TfrmWebPromoIssueGoodsDlg.ShowModifyEditorDlg;
begin

end;

procedure TfrmWebPromoIssueGoodsDlg.WhenCancelForm;
begin
  IBCQueryInfo.Cancel;
  IBCQueryInfo.UpdateTransaction.Rollback;
end;

end.

