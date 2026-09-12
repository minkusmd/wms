unit frmWebBigBannerEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxPCdxBarPopupMenu, Vcl.StdCtrls, Vcl.Buttons,
  cxImage, dxCore, cxDBEdit, cxPC, cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, Data.DB, DBAccess, IBC, MemDS,
  cxCheckBox, dxBarBuiltInMenu;

type
  TfrmWebBigBannerEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edTITLE: TcxDBTextEdit;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    edNAV_URL: TcxDBTextEdit;
    pcPageControlImages: TcxPageControl;
    tbsBackImage: TcxTabSheet;
    tbsImageRO: TcxTabSheet;
    tbsImageRU: TcxTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    imgIMAGE_BG: TcxImage;
    imgIMAGE_RO: TcxImage;
    imgIMAGE_RU: TcxImage;
    imgIMAGE_BG_RO: TcxImage;
    imgIMAGE_BG_RU: TcxImage;
    cbFLG_IMAGES_URL: TcxDBCheckBox;
    Label5: TLabel;
    edIMAGES_URL: TcxDBTextEdit;
    procedure imgIMAGE_BGPropertiesChange(Sender: TObject);
    procedure imgIMAGE_ROPropertiesChange(Sender: TObject);
    procedure imgIMAGE_RUPropertiesChange(Sender: TObject);
    procedure cbFLG_IMAGES_URLPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    fImageChanged: Boolean;
    fCreateNewBanner: Boolean;
    procedure SetCreateNewBanner(const Value: Boolean);
    function CheckValues: Boolean;
    procedure LoadImages(const BannerID: integer);
    procedure SaveImages(const BannerID: integer);
    procedure CheckImagesURLChanged;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewBanner: Boolean read fCreateNewBanner write SetCreateNewBanner;
  end;

implementation

{$R *.dfm}

uses SWNConst, SWNUtils, DataModuleDB, dxGDIPlusClasses, Vcl.Imaging.pngimage;

{ TfrmWebBigBannerEditorDlg }

procedure TfrmWebBigBannerEditorDlg.cbFLG_IMAGES_URLPropertiesChange(Sender: TObject);
begin
  CheckImagesURLChanged;
end;

procedure TfrmWebBigBannerEditorDlg.CheckImagesURLChanged;
var
  B: Boolean;
begin
  B := fMasterDataSet.FieldByName('FLG_IMAGES_URL').AsInteger = 1;
  tbsImageRO.TabVisible := Not B;
  tbsImageRU.TabVisible := Not B;
  Label5.Enabled := B;
  edIMAGES_URL.Enabled := B;
  if B then
    pcPageControlImages.ActivePage := tbsBackImage;
end;

function TfrmWebBigBannerEditorDlg.CheckValues: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').asString = '') then
    AddErrorToStr(ErrorStr, 'Denumirea bannerului!');
  if fMasterDataSet.FieldByName('START_DATE').IsNull or fMasterDataSet.FieldByName('END_DATE').IsNull or
    (fMasterDataSet.FieldByName('START_DATE').AsDateTime > fMasterDataSet.FieldByName('END_DATE').AsDateTime) then
    AddErrorToStr(ErrorStr, 'Perioada de afisare!');

  if Not Assigned(imgIMAGE_BG.Picture.Graphic) or (imgIMAGE_BG.Picture.Graphic.ClassName <> 'TPngImage') or
    TdxPngImage(imgIMAGE_BG.Picture.Graphic).Empty then
    AddErrorToStr(ErrorStr, 'Imaginea de fundal!');

  if (fMasterDataSet.FieldByName('FLG_IMAGES_URL').AsInteger = 0) then
  begin
    if Not Assigned(imgIMAGE_RO.Picture.Graphic) or (imgIMAGE_RO.Picture.Graphic.ClassName <> 'TPngImage') or
      TdxPngImage(imgIMAGE_RO.Picture.Graphic).Empty then
      AddErrorToStr(ErrorStr, 'Imaginea RO!');

    if Not Assigned(imgIMAGE_RU.Picture.Graphic) or (imgIMAGE_RU.Picture.Graphic.ClassName <> 'TPngImage') or
      TdxPngImage(imgIMAGE_RU.Picture.Graphic).Empty then
      AddErrorToStr(ErrorStr, 'Imaginea RU!');
  end
  else
  begin
    if fMasterDataSet.FieldByName('IMAGES_URL').IsNull or (fMasterDataSet.FieldByName('IMAGES_URL').asString = '') then
      AddErrorToStr(ErrorStr, 'Adresa serviciului web pentru imagini!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebBigBannerEditorDlg.imgIMAGE_BGPropertiesChange(Sender: TObject);
begin
  fImageChanged := True;
  if Assigned(imgIMAGE_BG.Picture) and Assigned(imgIMAGE_BG.Picture.Graphic) then
  begin
    imgIMAGE_BG_RO.Picture.Assign(imgIMAGE_BG.Picture.Graphic);
    imgIMAGE_BG_RU.Picture.Assign(imgIMAGE_BG.Picture.Graphic);
  end;
end;

procedure TfrmWebBigBannerEditorDlg.imgIMAGE_ROPropertiesChange(Sender: TObject);
begin
  fImageChanged := True;
end;

procedure TfrmWebBigBannerEditorDlg.imgIMAGE_RUPropertiesChange(Sender: TObject);
begin
  fImageChanged := True;
end;

procedure TfrmWebBigBannerEditorDlg.BindingDataSource;
begin
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;
  edNAV_URL.DataBinding.DataSource := fMasterDataSource;
  cbFLG_IMAGES_URL.DataBinding.DataSource := fMasterDataSource;
  edIMAGES_URL.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebBigBannerEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    if fImageChanged then
      SaveImages(fMasterDataSet.FieldByName('BANNERID').AsInteger);

    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end;
end;

procedure TfrmWebBigBannerEditorDlg.LoadImages(const BannerID: integer);
var
  Query: TIBCQuery;
  MS: TMemoryStream;
  PNG: TPngImage;
begin
  Query := TIBCQuery.Create(Self);
  MS := TMemoryStream.Create;
  PNG := TPngImage.Create;
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'SELECT IMAGE_BG, IMAGE_RO, IMAGE_RU FROM TWEB_BIGBANNERS WHERE BANNERID=:ID';
    Query.ParamByName('ID').AsInteger := BannerID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      TBlobField(Query.Fields[0]).SaveToStream(MS);
      MS.Position := 0;
      PNG.LoadFromStream(MS);
      imgIMAGE_BG.Picture.Assign(PNG);
      imgIMAGE_BG_RO.Picture.Assign(PNG);
      imgIMAGE_BG_RU.Picture.Assign(PNG);

      if (Not Query.Fields[1].IsNull) then
      begin
        MS.Clear;
        TBlobField(Query.Fields[1]).SaveToStream(MS);
        MS.Position := 0;
        PNG.LoadFromStream(MS);
        imgIMAGE_RO.Picture.Assign(PNG);
      end;

      if (Not Query.Fields[2].IsNull) then
      begin
        MS.Clear;
        TBlobField(Query.Fields[2]).SaveToStream(MS);
        MS.Position := 0;
        PNG.LoadFromStream(MS);
        imgIMAGE_RU.Picture.Assign(PNG);
      end;
    end;
  finally
    Query.Free;
    MS.Free;
    PNG.Free;
  end;
end;

procedure TfrmWebBigBannerEditorDlg.Prepare;
begin
  pcPageControlImages.ActivePage := tbsImageRU;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewBanner then
    begin
      dtDialogTitle.Text := 'Creare inregistrare noua';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_IMAGES_URL').AsInteger := 0;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare inregistrare';
      fMasterDataSet.Edit;
      LoadImages(fMasterDataSet.FieldByName('BANNERID').AsInteger);
    end;
    fImageChanged := False;
    CheckImagesURLChanged;
  except
    on E: Exception do
    begin
      if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmWebBigBannerEditorDlg.SaveImages(const BannerID: integer);
var
  Query: TIBCQuery;
  MS: TMemoryStream;
  PNG: TdxPngImage;
  hasService: Boolean;
begin
  hasService := fMasterDataSet.FieldByName('FLG_IMAGES_URL').AsInteger = 1;

  Query := TIBCQuery.Create(Self);
  MS := TMemoryStream.Create;
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'UPDATE TWEB_BIGBANNERS SET IMAGE_BG=:BG, IMAGE_RO=:RO, IMAGE_RU=:RU WHERE BANNERID=:ID';
    Query.ParamByName('ID').AsInteger := BannerID;

    PNG := TdxPngImage(imgIMAGE_BG.Picture.Graphic);
    PNG.SaveToStream(MS);
    Query.ParamByName('BG').LoadFromStream(MS, ftBlob);

    if hasService then
      Query.ParamByName('RO').Value := Null
    else
    begin
      MS.Clear;
      PNG := TdxPngImage(imgIMAGE_RO.Picture.Graphic);
      PNG.SaveToStream(MS);
      Query.ParamByName('RO').LoadFromStream(MS, ftBlob);
    end;

    if hasService then
      Query.ParamByName('RU').Value := Null
    else
    begin
      MS.Clear;
      PNG := TdxPngImage(imgIMAGE_RU.Picture.Graphic);
      PNG.SaveToStream(MS);
      Query.ParamByName('RU').LoadFromStream(MS, ftBlob);
    end;

    Query.ExecSQL;

  finally
    Query.Free;
    MS.Free;
  end;
end;

procedure TfrmWebBigBannerEditorDlg.SetCreateNewBanner(const Value: Boolean);
begin
  fCreateNewBanner := Value;
end;

procedure TfrmWebBigBannerEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
