unit frmWebCatalogLevel3Dialog;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, ExtCtrls,
   DialogTitle,
   cxDBEdit, StdCtrls, cxDropDownEdit, cxButtons, Data.DB,
   IBC, cxPC, cxDBLookupComboBox, cxLabel, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxImage, cxLookupEdit, cxDBLookupEdit,
  cxMaskEdit, cxCheckBox, cxMemo, cxTextEdit,
  frmPriceTypesUnit, cxScrollBox, dxUIAClasses;

type
   TfrmWebCatalogLevel3Dlg = class(TSWNMasteredFormClass)
      dtDialogTitle: TDialogTitle;
      IBCQuerySeoDescription: TIBCQuery;
      IBCDS_SeoDescription: TIBCDataSource;
      cxPageControl1: TcxPageControl;
      cxTabSheet1: TcxTabSheet;
      IBCQueryPrice: TIBCQuery;
      IBCDataSourcePrice: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label17: TLabel;
    edREWRITE_URL_RUS: TcxDBTextEdit;
    edREWRITE_URL_ROM: TcxDBTextEdit;
    edTITLE: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    cbFLG_CUSTOM_PRICE_COLUMN: TcxDBCheckBox;
    cmbCUSTOM_PRICE_COLUMN: TcxDBComboBox;
    cmbViewMode: TcxComboBox;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxButton2: TcxButton;
    cbFLG_PROMO: TcxDBCheckBox;
    cbFLG_NEW: TcxDBCheckBox;
    ImgCatalog: TcxDBImage;
    cxButton3: TcxButton;
    cxDBCheckBox1: TcxDBCheckBox;
    cbFLG_POPULAR: TcxDBCheckBox;
    imgBIG_IMAGE: TcxDBImage;
    Label19: TLabel;
    cbFLG_LEVEL4: TcxDBCheckBox;
    cbFLG_GROUP_IS_LINK: TcxDBCheckBox;
    lbURL_RO: TLabel;
    teURL_RO: TcxDBTextEdit;
    lbURL_RU: TLabel;
    teURL_RU: TcxDBTextEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    cxScrollBox1: TcxScrollBox;
    Label10: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    teTITLE_RO: TcxDBTextEdit;
    teTITLE_RU: TcxDBTextEdit;
    cxDBMemo4: TcxDBMemo;
    cxDBMemo3: TcxDBMemo;
    teDescription_RU: TcxDBMemo;
    teDescription_RO: TcxDBMemo;
    cxPageControl3: TcxPageControl;
    tbArticleRO: TcxTabSheet;
    tsArticleRU: TcxTabSheet;
    btnGenereazaSeo: TcxButton;
    cxDBMemo1: TcxDBMemo;
    cxDBMemo2: TcxDBMemo;
    lbVirtualFilter: TLabel;
      procedure cbFLG_CUSTOM_PRICE_COLUMNPropertiesChange(Sender: TObject);
      procedure cxButton2Click(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure IBCQueryImageBeforeInsert(DataSet: TDataSet);
    procedure cxButton3Click(Sender: TObject);
    procedure btnGenereazaSeoClick(Sender: TObject);
    procedure cmbViewModePropertiesCloseUp(Sender: TObject);
   private
    { Private declarations }
      fCreateNewFolder: Boolean;
      FDataSourceImage: TIBCDataSource;
      fDT: Integer;
      FParentID: Integer;
      procedure SetCreateNewFolder(const Value: Boolean);
      function CheckParams: Boolean;
      procedure EnableDisableCustomPriceColumn;
      procedure SetDataSourceImage(const Value: TIBCDataSource);
      procedure SetDT(const Value: Integer);
      procedure SetParentID(const Value: Integer);
   protected
    { protected declarations }
      procedure BindingDataSource; override;
      procedure Prepare; override;
      function IsFormDataPosted: Boolean; override;
      procedure WhenCancelForm; override;
   public
    { Public declarations }
      property CreateNewFolder: Boolean read fCreateNewFolder write SetCreateNewFolder;
      property DataSourceImage: TIBCDataSource read FDataSourceImage write SetDataSourceImage;
      property DT: Integer read fDT write SetDT;
      property ParentID: Integer read FParentID write SetParentID;
   end;

implementation

uses
   SWNUtils, SWNConst, DataModuleDB;

{$R *.dfm}
{ TfrmWebCatalogLevel1Dlg }

procedure TfrmWebCatalogLevel3Dlg.cbFLG_CUSTOM_PRICE_COLUMNPropertiesChange(Sender: TObject);
begin
   EnableDisableCustomPriceColumn;
end;

function TfrmWebCatalogLevel3Dlg.CheckParams: Boolean;
var
   ErrorStr: string;
begin
   Result := False;
   ErrorStr := '';

   if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString) = '') then
      AddErrorToStr(ErrorStr, 'Denumirea mapei');
   if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE_RUS').asString)
      = '') then
      AddErrorToStr(ErrorStr, 'Название папки');
   if (cmbViewMode.ItemIndex = -1) then
      AddErrorToStr(ErrorStr, 'View produse');

   if fMasterDataSet.FieldByName('REWRITE_URL_ROM').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_ROM').asString)
      = '') then
      AddErrorToStr(ErrorStr, 'ReWrite URL: In romana!')
   else if (Pos(fMasterDataSet.FieldByName('REWRITE_URL_ROM').asString, ' ') > 0) then
      AddErrorToStr(ErrorStr, 'ReWrite URL: In romana - без пробелов!');

   if fMasterDataSet.FieldByName('REWRITE_URL_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_RUS').asString)
      = '') then
      AddErrorToStr(ErrorStr, 'ReWrite URL: На русском!')
   else if (Pos(fMasterDataSet.FieldByName('REWRITE_URL_RUS').asString, ' ') > 0) then
      AddErrorToStr(ErrorStr, 'ReWrite URL: На русском - без пробелов!');

   // nodul-link nu are mape de produse: singura lui valoare este URL-ul tinta
   if (fMasterDataSet.FieldByName('FLG_GROUP_IS_LINK').AsInteger = 1) and
      (Trim(fMasterDataSet.FieldByName('URL_RO').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Grupa dinamica: completati Link RO');

   if ErrorStr = '' then
      Result := True
   else
      ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebCatalogLevel3Dlg.btnGenereazaSeoClick(Sender: TObject);
var
  q: TIBCQuery;
    s: string;
begin
    s := fMasterDataSet.FieldByName('TITLE').AsString;

    s := StringReplace(S, ',', '-', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(S, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(S, '/', '-', [rfReplaceAll, rfIgnoreCase]);
    s := String(BestFit(AnsiString(s)));
    fMasterDataSet.FieldByName('REWRITE_URL_ROM').AsString := S.ToLower;
    fMasterDataSet.FieldByName('REWRITE_URL_RUS').AsString := S.ToLower;
//    s := fMasterDataSet.FieldByName('TITLE_RUS').AsString;
//    s := StringReplace(S, ', ', ' ', [rfReplaceAll, rfIgnoreCase]);
//    s := StringReplace(S, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
//    s := StringReplace(S, '/', '-', [rfReplaceAll, rfIgnoreCase]);

   MasterDataSet.Post;

   q := TIBCQuery.Create(nil);

   try
     q.Transaction := MasterDataSet.UpdateTransaction;
     q.SQL.Text := 'Execute PROCEDURE SP_META_CATALOG(:catalogid)';
     q.ParamByName('catalogid').AsInteger := fmasterdataset.fieldbyname('catalogid').AsInteger;
     q.ExecSQL;
   finally
     q.Free;
   end;


//  dmdb.executequery('Execute PROCEDURE SP_META_CATALOG(:catalogid)', [fmasterdataset.fieldbyname('catalogid').AsInteger]);
  IBCQuerySeoDescription.Refresh;

//  MasterDataSet.Edit;
end;

procedure TfrmWebCatalogLevel3Dlg.cmbViewModePropertiesCloseUp(Sender: TObject);
begin
  if not (fMasterDataSet.State in dsEditModes) then
    fMasterDataSet.Edit;

  fMasterDataSet.FieldByName('FLG_VIEWMODE_VITRINA').AsInteger := cmbViewMode.ItemIndex;
end;

procedure TfrmWebCatalogLevel3Dlg.cxButton2Click(Sender: TObject);
begin
   fMasterDataSet.FieldByName('PGT_ID').AsVariant := -1;
end;

procedure TfrmWebCatalogLevel3Dlg.cxButton3Click(Sender: TObject);
var
  dialog: TfrmPriceTypesDlg;
begin
  dialog := TfrmPriceTypesDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.PGT_ID := fMasterDataSet.FieldByName('PGT_ID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;
procedure TfrmWebCatalogLevel3Dlg.EnableDisableCustomPriceColumn;
var
   b: Boolean;
 begin
   b := fMasterDataSet.FieldByName('FLG_CUSTOM_PRICE_COLUMN').AsInteger = 1;
   cmbCUSTOM_PRICE_COLUMN.Enabled := b;
end;

procedure TfrmWebCatalogLevel3Dlg.FormShow(Sender: TObject);
begin
   ImgCatalog.DataBinding.DataSource := DataSourceImage;
   imgBIG_IMAGE.DataBinding.DataSource := DataSourceImage;
   edTITLE.SetFocus;
end;

procedure TfrmWebCatalogLevel3Dlg.IBCQueryImageBeforeInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
end;

procedure TfrmWebCatalogLevel3Dlg.BindingDataSource;
begin
   inherited;
   fCreateNewFolder := False;
   edTITLE.DataBinding.DataSource := fMasterDataSource;
   edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
   cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
   cbFLG_CUSTOM_PRICE_COLUMN.DataBinding.DataSource := fMasterDataSource;
   cmbCUSTOM_PRICE_COLUMN.DataBinding.DataSource := fMasterDataSource;
   edREWRITE_URL_ROM.DataBinding.DataSource := fMasterDataSource;
   edREWRITE_URL_RUS.DataBinding.DataSource := fMasterDataSource;
   cxDBLookupComboBox1.DataBinding.DataSource := fMasterDataSource;
   cbFLG_NEW.DataBinding.DataSource := fMasterDataSource;
   cbFLG_PROMO.DataBinding.DataSource := fMasterDataSource;

//   teURL_RO.DataBinding.DataSource :=  fMasterDataSource;
//   teURL_RU.DataBinding.DataSource :=  fMasterDataSource;
   cbFLG_GROUP_IS_LINK.DataBinding.DataSource :=  fMasterDataSource;
   teURL_RO.DataBinding.DataSource := fMasterDataSource;
   teURL_RU.DataBinding.DataSource := fMasterDataSource;

   teTITLE_RO.DataBinding.DataSource := IBCDS_SeoDescription;
   teTITLE_RU.DataBinding.DataSource := IBCDS_SeoDescription;
   teDescription_RO.DataBinding.DataSource := IBCDS_SeoDescription;
   teDescription_RU.DataBinding.DataSource := IBCDS_SeoDescription;
   cbFLG_LEVEL4.DataBinding.DataSource := fMasterDataSource;
   cbFLG_POPULAR.DataBinding.DataSource := fMasterDataSource;

end;

function TfrmWebCatalogLevel3Dlg.IsFormDataPosted: Boolean;
begin
   Result := False;
   if CheckParams then
   begin
      if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Post;

      if IBCQuerySeoDescription.State in [dsEdit, dsInsert] then
      begin
         IBCQuerySeoDescription.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
         IBCQuerySeoDescription.Post;
      end;

      if DataSourceImage.DataSet.State in (dsEditModes) then
      begin
         DataSourceImage.DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
         DataSourceImage.DataSet.Post;
      end;

      fMasterDataSet.UpdateTransaction.Commit;
      Result := True;
   end;
end;

procedure TfrmWebCatalogLevel3Dlg.Prepare;
begin
   DataSourceImage.DataSet.Open;

   IBCQuerySeoDescription.UpdateTransaction := fMasterDataSet.UpdateTransaction;

   fMasterDataSet.UpdateTransaction.StartTransaction;
   IBCQueryPrice.Open;
   try
      if fCreateNewFolder then
      begin
         dtDialogTitle.Text := 'Creare mapa nivelul 3';

         fMasterDataSet.Insert;
         fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
         fMasterDataSet.FieldByName('DT').AsInteger := fDT;
         fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
         fMasterDataSet.FieldByName('FLG_CUSTOM_PRICE_COLUMN').AsInteger := 0;
         fMasterDataSet.FieldByName('CUSTOM_PRICE_COLUMN').AsInteger := 1;
         fMasterDataSet.FieldByName('FLG_VIEWMODE_VITRINA').AsInteger := 0;
      end
      else
      begin
         dtDialogTitle.Text := 'Modifica mapa nivelul 3 #' + fMasterDataSet.FieldByName('CATALOGID').AsString;
         fMasterDataSet.Edit;
      end;

      EnableDisableCustomPriceColumn;
      cmbViewMode.ItemIndex := fMasterDataSet.FieldByName('FLG_VIEWMODE_VITRINA').AsInteger;

      with IBCQuerySeoDescription do
      begin
         Close;
         ParamByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
         Open;
      end;

      cxPageControl1.ActivePageIndex := 0;

   except
      if IBCQuerySeoDescription.State in [dsEdit, dsInsert] then
         IBCQuerySeoDescription.Cancel;

      fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
   end;
end;

procedure TfrmWebCatalogLevel3Dlg.SetCreateNewFolder(const Value: Boolean);
begin
   fCreateNewFolder := Value;
end;

procedure TfrmWebCatalogLevel3Dlg.SetDataSourceImage(const Value: TIBCDataSource);
begin
   FDataSourceImage := Value;
end;

procedure TfrmWebCatalogLevel3Dlg.SetDT(const Value: Integer);
begin
   fDT := Value;
end;

procedure TfrmWebCatalogLevel3Dlg.SetParentID(const Value: Integer);
begin
   FParentID := Value;
end;

procedure TfrmWebCatalogLevel3Dlg.WhenCancelForm;
begin
   if IBCQuerySeoDescription.State in (dsEditModes) then
      IBCQuerySeoDescription.Cancel;

   if DataSourceImage.DataSet.State in (dsEditModes) then
      DataSourceImage.DataSet.Cancel;

   fMasterDataSet.Cancel;
   fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

