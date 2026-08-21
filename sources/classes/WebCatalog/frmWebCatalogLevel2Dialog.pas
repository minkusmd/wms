unit frmWebCatalogLevel2Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle,
  cxDBEdit, StdCtrls, cxButtons, Data.DB,
  IBC, cxPC, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, MemDS, DBAccess, cxImage, cxMemo, cxMaskEdit, cxButtonEdit, cxCheckBox, cxTextEdit, dxUIAClasses;

type
  TfrmWebCatalogLevel2Dlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    IBCDS_SeoDescription: TIBCDataSource;
    IBCQuerySeoDescription: TIBCQuery;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edTITLE: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    edREWRITE_URL_ROM: TcxDBButtonEdit;
    edREWRITE_URL_RUS: TcxDBButtonEdit;
    cxButton1: TcxButton;
    cxDBMemo1: TcxDBMemo;
    cxDBMemo2: TcxDBMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Label8: TLabel;
    teTITLE_RO: TcxDBTextEdit;
    Label9: TLabel;
    teTITLE_RU: TcxDBTextEdit;
    Label10: TLabel;
    cxDBMemo3: TcxDBMemo;
    Label11: TLabel;
    cxDBMemo4: TcxDBMemo;
    teURL_RO: TcxDBTextEdit;
    teURL_RU: TcxDBTextEdit;
    ScrollBox1: TScrollBox;
    ImgCatalog: TcxDBImage;
    Label3: TLabel;
    cxDBImage1: TcxDBImage;
    Label12: TLabel;
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IBCQueryImageBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
    FCreateNewFolder: Boolean;
    FDataSourceImage: TIBCDataSource;
    fDT: integer;
    FParentID: integer;
    procedure SetCreateNewFolder(const Value: Boolean);

    function CheckParams: Boolean;
    procedure SetDataSourceImage(const Value: TIBCDataSource);
    procedure SetDT(const Value: integer);
    procedure SetParentID(const Value: integer);

  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewFolder: Boolean read FCreateNewFolder write SetCreateNewFolder;
    property DataSourceImage: TIBCDataSource read FDataSourceImage write
        SetDataSourceImage;
    property DT: integer read fDT write SetDT;
    property ParentID: integer read FParentID write SetParentID;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmWebCatalogLevel1Dlg }

function TfrmWebCatalogLevel2Dlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString) = '') then
    AddErrorToStr(ErrorStr, 'Denumirea mapei');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE_RUS').asString) = '') then
    AddErrorToStr(ErrorStr, 'Название папки');

  if fMasterDataSet.FieldByName('REWRITE_URL_ROM').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_ROM').asString) = '') then
    AddErrorToStr(ErrorStr, 'SEO ROM');
  if fMasterDataSet.FieldByName('REWRITE_URL_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('REWRITE_URL_RUS').asString) = '') then
    AddErrorToStr(ErrorStr, 'SEO RUS');


  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebCatalogLevel2Dlg.cxButton1Click(Sender: TObject);
begin
  fMasterDataSet.FieldByName('REWRITE_URL_ROM').AsString := stringreplace(fMasterDataSet.FieldByName('TITLE').AsString, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
  fMasterDataSet.FieldByName('REWRITE_URL_RUS').AsString := TranslitRus2Lat(stringreplace(fMasterDataSet.FieldByName('TITLE_RUS').AsString, ' ', '-', [rfReplaceAll, rfIgnoreCase]));
  fMasterDataSet.FieldByName('URL_RO').AsString := fMasterDataSet.FieldByName('REWRITE_URL_ROM').AsString;
  fMasterDataSet.FieldByName('URL_RU').AsString := fMasterDataSet.FieldByName('REWRITE_URL_RUS').AsString;
end;

procedure TfrmWebCatalogLevel2Dlg.FormShow(Sender: TObject);
begin
   ImgCatalog.DataBinding.DataSource := DataSourceImage;
   cxDBImage1.DataBinding.DataSource := DataSourceImage;
end;

procedure TfrmWebCatalogLevel2Dlg.IBCQueryImageBeforeInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
end;

procedure TfrmWebCatalogLevel2Dlg.BindingDataSource;
begin
  inherited;
  FCreateNewFolder := False;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;

  edREWRITE_URL_ROM.DataBinding.DataSource := fMasterDataSource;
  edREWRITE_URL_RUS.DataBinding.DataSource := fMasterDataSource;

  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  teURL_RO.DataBinding.DataSource := fMasterDataSource;
  teURL_RU.DataBinding.DataSource := fMasterDataSource;
//  teTITLE_RO.DataBinding.DataSource := fMasterDataSource;
//  teTITLE_RU.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebCatalogLevel2Dlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    try
      fMasterDataSet.Post;

      if IBCQuerySeoDescription.State in [dsEdit, dsInsert] then
      begin
        IBCQuerySeoDescription.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
        IBCQuerySeoDescription.Post;
      end;

     if DataSourceImage.DataSet.State in [dsEdit, dsInsert] then
     begin
       DataSourceImage.DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
       DataSourceImage.DataSet.Post;
     end;

      fMasterDataSet.UpdateTransaction.Commit;
      Result := True;
    except on e: Exception do
      raise;
    end;
  end;
end;

procedure TfrmWebCatalogLevel2Dlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;

  try
    if FCreateNewFolder then
    begin
      dtDialogTitle.Text := 'Creare mapa nivelul 2';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('DT').AsInteger := fDT;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare mapa nivelul 2';
      fMasterDataSet.Edit;
    end;
      // SeoDescription Query
    IBCQuerySeoDescription.Close;
    IBCQuerySeoDescription.ParamByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
    IBCQuerySeoDescription.Open;

      //  Image Query
    DataSourceImage.DataSet.Open;
  except
    if IBCQuerySeoDescription.State in [dsEdit, dsInsert] then
      IBCQuerySeoDescription.Cancel;

    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebCatalogLevel2Dlg.SetCreateNewFolder(const Value: Boolean);
begin
  FCreateNewFolder := Value;
end;

procedure TfrmWebCatalogLevel2Dlg.SetDataSourceImage(const Value:
    TIBCDataSource);
begin
   FDataSourceImage := Value;
end;

procedure TfrmWebCatalogLevel2Dlg.SetDT(const Value: integer);
begin
  fDT := Value;
end;

procedure TfrmWebCatalogLevel2Dlg.SetParentID(const Value: integer);
begin
  FParentID := Value;
end;

procedure TfrmWebCatalogLevel2Dlg.WhenCancelForm;
begin
  if IBCQuerySeoDescription.State in [dsEdit, dsInsert] then
    IBCQuerySeoDescription.Cancel;

   if DataSourceImage.DataSet.State in [dsEdit, dsInsert] then
   DataSourceImage.DataSet.Cancel;

  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
