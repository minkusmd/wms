unit frmWebCatalogVirtualFolderEditorDialog;

{
  Editorul unei mape virtuale (TWEB_CATALOG_VIRTUAL, prin VW_TWEB_CATALOG_VIRTUAL).

  O mapa virtuala = pagina categoriei-parinte cu un filtru de atribut
  pre-aplicat (FILTERID + CSV de FILTERPARAMIDS), slug propriu (segmentul 4 din
  ruta /category/...), H1/meta proprii si o imagine pentru grila de tile-uri.

  Imaginea sta in tabelul lateral TWEB_CATALOG_VIRTUAL_IMAGE si se poate
  adauga doar dupa ce mapa a fost salvata o data (ID-ul vine din generator).
}

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    DialogTitle, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
    cxCheckBox, cxDBEdit, cxImage, cxMemo, cxSpinEdit, cxButtons,
    DB, DBAccess, IBC, MemDS;

type
    TfrmWebCatalogVirtualFolderEditorDlg = class(TSWNMasteredFormClass)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        lbTITLE_ROM: TLabel;
        lbTITLE_RUS: TLabel;
        lbH1_ROM: TLabel;
        lbH1_RUS: TLabel;
        lbREWRITE_URL: TLabel;
        lbFilter: TLabel;
        lbORDERNO: TLabel;
        lbMETA_TITLE_ROM: TLabel;
        lbMETA_TITLE_RUS: TLabel;
        lbMETA_DESCRIPTION_ROM: TLabel;
        lbMETA_DESCRIPTION_RUS: TLabel;
        lbImage: TLabel;
        lbImageHint: TLabel;
        edTITLE_ROM: TcxDBTextEdit;
        edTITLE_RUS: TcxDBTextEdit;
        edH1_ROM: TcxDBTextEdit;
        edH1_RUS: TcxDBTextEdit;
        edREWRITE_URL: TcxDBTextEdit;
        edORDERNO: TcxDBSpinEdit;
        edMETA_TITLE_ROM: TcxDBTextEdit;
        edMETA_TITLE_RUS: TcxDBTextEdit;
        edMETA_DESCRIPTION_ROM: TcxDBMemo;
        edMETA_DESCRIPTION_RUS: TcxDBMemo;
        cbFLG_ENABLED: TcxDBCheckBox;
        cbFLG_TILE: TcxDBCheckBox;
        lbFilterValue: TLabel;
        btnChooseFilter: TcxButton;
        btnFillSlug: TcxButton;
        imgBIG_IMAGE: TcxDBImage;
        btnOk: TButton;
        btnCancel: TButton;
        IBCQueryImage: TIBCQuery;
        IBCDataSourceImage: TIBCDataSource;
        procedure btnChooseFilterClick(Sender: TObject);
        procedure btnFillSlugClick(Sender: TObject);
    private
        { Private declarations }
        fCreateNewRecord: Boolean;
        fCatalogID: Integer;
        function CheckValues: Boolean;
        procedure UpdateFilterLabel;
        procedure OpenImageDataSet;
        procedure SetCreateNewRecord(const Value: Boolean);
        procedure SetCatalogID(const Value: Integer);
    protected
        { protected declarations }
        procedure BindingDataSource; override;
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public
        { Public declarations }
        property CreateNewRecord: Boolean read fCreateNewRecord write SetCreateNewRecord;
        property CatalogID: Integer read fCatalogID write SetCatalogID;
    end;

implementation

{$R *.dfm}

uses
    DataModuleDB, SWNUtils, SWNConst, frmSelectCatalogFilterValueDialog;

{ TfrmWebCatalogVirtualFolderEditorDlg }

{ Diacriticele romanesti -> litera de baza. BestFit nu ajuta aici: trece prin
  AnsiString si transforma s-virgula / t-virgula in '?'. }
function DeromanizeChar(const c: Char): Char;
begin
    case Ord(c) of
        $0103, $00E2, $00E3, $00E0, $00E1:
            Result := 'a'; // a-breve, a-circumflex
        $00EE, $00ED, $00EC:
            Result := 'i'; // i-circumflex
        $0219, $015F, $0161:
            Result := 's'; // s-virgula, s-sedila
        $021B, $0163, $0165:
            Result := 't'; // t-virgula, t-sedila
        $00E9, $00E8, $00EA:
            Result := 'e';
        $00F3, $00F2, $00F4:
            Result := 'o';
        $00FA, $00F9, $00FB:
            Result := 'u';
    else
        Result := c;
    end;
end;

{ Slug-ul ajunge direct in URL si are index unic pe (CATALOGID, REWRITE_URL),
  deci acceptam doar [a-z0-9-]. }
function NormalizeSlug(const S: string): string;
var
    i: Integer;
    c: Char;
begin
    Result := '';
    for i := 1 to Length(S) do
    begin
        c := DeromanizeChar(LowerCase(S[i])[1]);
        if CharInSet(c, ['a' .. 'z', '0' .. '9']) then
            Result := Result + c
        else if (Result <> '') and (Result[Length(Result)] <> '-') then
            Result := Result + '-';
    end;
    while (Result <> '') and (Result[Length(Result)] = '-') do
        Delete(Result, Length(Result), 1);
end;

function IsValidSlug(const S: string): Boolean;
var
    i: Integer;
begin
    Result := S <> '';
    for i := 1 to Length(S) do
        if not CharInSet(S[i], ['a' .. 'z', '0' .. '9', '-']) then
        begin
            Result := False;
            Break;
        end;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.BindingDataSource;
begin
    inherited;
    edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
    edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
    edH1_ROM.DataBinding.DataSource := fMasterDataSource;
    edH1_RUS.DataBinding.DataSource := fMasterDataSource;
    edREWRITE_URL.DataBinding.DataSource := fMasterDataSource;
    edORDERNO.DataBinding.DataSource := fMasterDataSource;
    edMETA_TITLE_ROM.DataBinding.DataSource := fMasterDataSource;
    edMETA_TITLE_RUS.DataBinding.DataSource := fMasterDataSource;
    edMETA_DESCRIPTION_ROM.DataBinding.DataSource := fMasterDataSource;
    edMETA_DESCRIPTION_RUS.DataBinding.DataSource := fMasterDataSource;
    cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
    cbFLG_TILE.DataBinding.DataSource := fMasterDataSource;
    imgBIG_IMAGE.DataBinding.DataSource := IBCDataSourceImage;
end;

function TfrmWebCatalogVirtualFolderEditorDlg.CheckValues: Boolean;
var
    ErrorStr: string;
    Slug: string;
begin
    Result := False;
    ErrorStr := '';

    if Trim(fMasterDataSet.FieldByName('TITLE_ROM').AsString) = '' then
        AddErrorToStr(ErrorStr, 'Denumirea in romana!');

    Slug := Trim(fMasterDataSet.FieldByName('REWRITE_URL').AsString);
    if Slug = '' then
        AddErrorToStr(ErrorStr, 'Adresa URL (slug)!')
    else if not IsValidSlug(Slug) then
        AddErrorToStr(ErrorStr, 'Adresa URL: doar litere mici, cifre si "-"!');

    if fMasterDataSet.FieldByName('FILTERID').AsInteger <= 0 then
        AddErrorToStr(ErrorStr, 'Atributul dupa care se filtreaza!');

    if Trim(fMasterDataSet.FieldByName('FILTERPARAMIDS').AsString) = '' then
        AddErrorToStr(ErrorStr, 'Valorile atributului!');

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.btnChooseFilterClick(Sender: TObject);
var
    d: TfrmSelectCatalogFilterValueDlg;
begin
    d := TfrmSelectCatalogFilterValueDlg.Create(Self);
    try
        d.FilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
        d.ParamIDs := fMasterDataSet.FieldByName('FILTERPARAMIDS').AsString;
        if d.ShowModal = mrOk then
        begin
            if not(fMasterDataSet.State in dsEditModes) then
                fMasterDataSet.Edit;
            fMasterDataSet.FieldByName('FILTERID').AsInteger := d.FilterID;
            fMasterDataSet.FieldByName('FILTERPARAMIDS').AsString := d.ParamIDs;
            UpdateFilterLabel;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.btnFillSlugClick(Sender: TObject);
var
    Src: string;
begin
    if not(fMasterDataSet.State in dsEditModes) then
        fMasterDataSet.Edit;

    Src := Trim(fMasterDataSet.FieldByName('TITLE_ROM').AsString);
    if Src = '' then
        Src := TranslitRus2Lat(Trim(fMasterDataSet.FieldByName('TITLE_RUS').AsString));

    fMasterDataSet.FieldByName('REWRITE_URL').AsString := NormalizeSlug(Src);
end;

function TfrmWebCatalogVirtualFolderEditorDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if not CheckValues then
        Exit;

    fMasterDataSet.FieldByName('REWRITE_URL').AsString :=
        Trim(fMasterDataSet.FieldByName('REWRITE_URL').AsString);
    fMasterDataSet.Post;

    { Randul de imagine se scrie doar daca exista efectiv o imagine - altfel am
      umple TWEB_CATALOG_VIRTUAL_IMAGE cu randuri goale. }
    if IBCQueryImage.Active and (IBCQueryImage.State in dsEditModes) then
    begin
        if IBCQueryImage.FieldByName('BIG_IMAGE').IsNull then
            IBCQueryImage.Cancel
        else
        begin
            IBCQueryImage.FieldByName('VIRTUALID').AsInteger :=
                fMasterDataSet.FieldByName('ID').AsInteger;
            IBCQueryImage.Post;
        end;
    end;

    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.OpenImageDataSet;
begin
    { La creare ID-ul nu exista inca (vine din GEN_TWEB_CATALOG_VIRTUAL_ID la
      insert), deci imaginea se poate adauga abia dupa prima salvare. }
    if fCreateNewRecord then
    begin
        imgBIG_IMAGE.Enabled := False;
        lbImageHint.Visible := True;
        Exit;
    end;

    lbImageHint.Visible := False;
    IBCQueryImage.Close;
    IBCQueryImage.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('ID').AsInteger;
    IBCQueryImage.Open;

    if IBCQueryImage.IsEmpty then
    begin
        IBCQueryImage.Append;
        IBCQueryImage.FieldByName('VIRTUALID').AsInteger :=
            fMasterDataSet.FieldByName('ID').AsInteger;
    end
    else
        IBCQueryImage.Edit;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.Prepare;
begin
    IBCQueryImage.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    fMasterDataSet.UpdateTransaction.StartTransaction;
    try
        if fCreateNewRecord then
        begin
            dtDialogTitle.Text := 'Mapa virtuala noua';
            fMasterDataSet.Insert;
            fMasterDataSet.FieldByName('CATALOGID').AsInteger := fCatalogID;
            fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
            fMasterDataSet.FieldByName('FLG_TILE').AsInteger := 1;
            fMasterDataSet.FieldByName('ORDERNO').AsInteger := 0;
            fMasterDataSet.FieldByName('FILTERID').AsInteger := 0;
        end
        else
        begin
            dtDialogTitle.Text := 'Modifica mapa virtuala';
            fMasterDataSet.Edit;
        end;

        OpenImageDataSet;
        UpdateFilterLabel;
    except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
    end;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.SetCatalogID(const Value: Integer);
begin
    fCatalogID := Value;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
    fCreateNewRecord := Value;
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.UpdateFilterLabel;
var
    Query: TIBCQuery;
    FilterID: Integer;
    ParamIDs: string;
    FilterName: string;
    ParamValues: string;
begin
    FilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
    ParamIDs := Trim(fMasterDataSet.FieldByName('FILTERPARAMIDS').AsString);

    if (FilterID <= 0) or (ParamIDs = '') then
    begin
        lbFilterValue.Caption := '<nu este ales nici un atribut>';
        Exit;
    end;

    FilterName := '';
    ParamValues := '';
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultSelect;
        Query.SQL.Text := 'SELECT F.FILTERNAME, ' + '(SELECT LIST(P.PARAM_VALUE, '', '') ' +
            '   FROM TS_FILTER_PARAMS P ' + '   JOIN SPLIT(:PARAMIDS) Z ON Z.ID = P.FILTERPARAMID ' +
            '  WHERE P.FILTERID = F.FILTERID) ' + 'FROM TS_FILTERS F WHERE F.FILTERID = :FILTERID';
        Query.ParamByName('PARAMIDS').AsString := ParamIDs;
        Query.ParamByName('FILTERID').AsInteger := FilterID;
        Query.Open;
        if not Query.Eof then
        begin
            FilterName := Query.Fields[0].AsString;
            ParamValues := Query.Fields[1].AsString;
        end;
    finally
        Query.Free;
    end;

    if FilterName = '' then
        lbFilterValue.Caption := Format('atribut %d (%s)', [FilterID, ParamIDs])
    else
        lbFilterValue.Caption := Format('%s: %s', [FilterName, ParamValues]);
end;

procedure TfrmWebCatalogVirtualFolderEditorDlg.WhenCancelForm;
begin
    if IBCQueryImage.Active and (IBCQueryImage.State in dsEditModes) then
        IBCQueryImage.Cancel;
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
