unit frmWebCatalogLevel4Dialog;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNBaseUnit, Dialogs, ExtCtrls, DialogTitle, cxDBEdit, StdCtrls,
    cxDropDownEdit, cxButtons, Data.DB, IBC, cxPC, cxDBLookupComboBox, cxLabel,
    dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS,
    cxImage, cxLookupEdit, cxDBLookupEdit, cxMaskEdit, cxCheckBox, cxMemo,
    cxTextEdit, frmPriceTypesUnit, cxScrollBox, dxUIAClasses;

type
    TfrmWebCatalogLevel4Dlg = class(TSWNMasteredFormClass)
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
        Label5: TLabel;
        Label2: TLabel;
        Label1: TLabel;
        Label8: TLabel;
        Label17: TLabel;
        edSlug: TcxDBTextEdit;
        edTITLE: TcxDBTextEdit;
        edTITLE_RUS: TcxDBTextEdit;
        cbFLG_PROMO: TcxDBCheckBox;
        cbFLG_NEW: TcxDBCheckBox;
        ImgCatalog: TcxDBImage;
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
        cxButton3: TcxButton;
        procedure FormShow(Sender: TObject);
        procedure IBCQueryImageBeforeInsert(DataSet: TDataSet);
        procedure btnGenereazaSeoClick(Sender: TObject);
    private
    { Private declarations }
        fCreateNewFolder: Boolean;
        FDataSourceImage: TIBCDataSource;
        fDT: Integer;
        FParentID: Integer;
        procedure SetCreateNewFolder(const Value: Boolean);
        function CheckParams: Boolean;
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

function TfrmWebCatalogLevel4Dlg.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    Result := False;
    ErrorStr := '';

    if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString) = '') then
        AddErrorToStr(ErrorStr, 'Denumirea mapei');
    if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE_RUS').asString) = '') then
        AddErrorToStr(ErrorStr, 'Название папки');

    if fMasterDataSet.FieldByName('REWRITE_URL_ROM').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_ROM').asString) = '') then
        AddErrorToStr(ErrorStr, 'ReWrite URL: În română!')
    else if (Pos(fMasterDataSet.FieldByName('REWRITE_URL_ROM').asString, ' ') > 0) then
        AddErrorToStr(ErrorStr, 'ReWrite URL: În română - без пробелов!');

    if fMasterDataSet.FieldByName('REWRITE_URL_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_RUS').asString) = '') then
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

procedure TfrmWebCatalogLevel4Dlg.btnGenereazaSeoClick(Sender: TObject);
var
    q: TIBCQuery;
    s: string;
begin
    s := fMasterDataSet.FieldByName('TITLE').AsString;

    s := StringReplace(s, ',', '-', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, '/', '-', [rfReplaceAll, rfIgnoreCase]);
    s := string(BestFit(AnsiString(s)));
    fMasterDataSet.FieldByName('REWRITE_URL_ROM').AsString := s.ToLower;
    fMasterDataSet.FieldByName('REWRITE_URL_RUS').AsString := s.ToLower;

    MasterDataSet.Post;

    q := TIBCQuery.Create(nil);

    try
        q.Transaction := MasterDataSet.UpdateTransaction;
        q.SQL.Text := 'Execute PROCEDURE SP_META_CATALOG(:catalogid)';
        q.ParamByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
        q.ExecSQL;
    finally
        q.Free;
    end;

    IBCQuerySeoDescription.Refresh;
end;

procedure TfrmWebCatalogLevel4Dlg.FormShow(Sender: TObject);
begin
    ImgCatalog.DataBinding.DataSource := DataSourceImage;
    imgBIG_IMAGE.DataBinding.DataSource := DataSourceImage;
    edTITLE.SetFocus;
end;

procedure TfrmWebCatalogLevel4Dlg.IBCQueryImageBeforeInsert(DataSet: TDataSet);
begin
    DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
end;

procedure TfrmWebCatalogLevel4Dlg.BindingDataSource;
begin
    inherited;
    fCreateNewFolder := False;
    edTITLE.DataBinding.DataSource := fMasterDataSource;
    edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
    cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
    edSlug.DataBinding.DataSource := fMasterDataSource;
    cbFLG_NEW.DataBinding.DataSource := fMasterDataSource;

    cbFLG_GROUP_IS_LINK.DataBinding.DataSource := fMasterDataSource;
    teURL_RO.DataBinding.DataSource := fMasterDataSource;
    teURL_RU.DataBinding.DataSource := fMasterDataSource;

    teTITLE_RO.DataBinding.DataSource := IBCDS_SeoDescription;
    teTITLE_RU.DataBinding.DataSource := IBCDS_SeoDescription;
    teDescription_RO.DataBinding.DataSource := IBCDS_SeoDescription;
    teDescription_RU.DataBinding.DataSource := IBCDS_SeoDescription;
    cbFLG_LEVEL4.DataBinding.DataSource := fMasterDataSource;
    cbFLG_POPULAR.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebCatalogLevel4Dlg.IsFormDataPosted: Boolean;
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

procedure TfrmWebCatalogLevel4Dlg.Prepare;
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

procedure TfrmWebCatalogLevel4Dlg.SetCreateNewFolder(const Value: Boolean);
begin
    fCreateNewFolder := Value;
end;

procedure TfrmWebCatalogLevel4Dlg.SetDataSourceImage(const Value: TIBCDataSource);
begin
    FDataSourceImage := Value;
end;

procedure TfrmWebCatalogLevel4Dlg.SetDT(const Value: Integer);
begin
    fDT := Value;
end;

procedure TfrmWebCatalogLevel4Dlg.SetParentID(const Value: Integer);
begin
    FParentID := Value;
end;

procedure TfrmWebCatalogLevel4Dlg.WhenCancelForm;
begin
    if IBCQuerySeoDescription.State in (dsEditModes) then
        IBCQuerySeoDescription.Cancel;

    if DataSourceImage.DataSet.State in (dsEditModes) then
        DataSourceImage.DataSet.Cancel;

    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

