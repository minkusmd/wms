unit PWCategoriesDialog;

{ WMSPriceWatch - categoriile monitorizate (TWEB_COMPETITOR_CATEGORIES, legate de
  TWEB_CATALOG prin CATALOGID) si URL-ul fiecarei categorii pe fiecare site
  (TWEB_COMPETITOR_CAT_URLS, master-detail). Modificarile se salveaza la OK. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, DBAccess, IBC, MemDS, PWBaseFormUnit, DialogTitle,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxClasses, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons, cxCheckBox, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, dxScrollbarAnnotations, dxDateRanges;

type
  TfrmPWCategoriesDlg = class(TPWBaseFormClass)
    dtDialogTitle: TDialogTitle;
    pnCats: TPanel;
    lbCats: TLabel;
    cxGridCats: TcxGrid;
    cxGridCatsTable: TcxGridDBTableView;
    cxGridCatsLevel: TcxGridLevel;
    colC_CATALOGID: TcxGridDBColumn;
    colC_CATALOG_TITLE: TcxGridDBColumn;
    colC_TITLE: TcxGridDBColumn;
    colC_FLG_ACTIVE: TcxGridDBColumn;
    colC_ORDERNO: TcxGridDBColumn;
    colC_MIN_SCORE: TcxGridDBColumn;
    colC_URLS: TcxGridDBColumn;
    pnCatsButtons: TPanel;
    btnCatAdd: TcxButton;
    btnCatDelete: TcxButton;
    splMain: TSplitter;
    pnUrls: TPanel;
    lbUrls: TLabel;
    cxGridUrls: TcxGrid;
    cxGridUrlsTable: TcxGridDBTableView;
    cxGridUrlsLevel: TcxGridLevel;
    colU_SITEID: TcxGridDBColumn;
    colU_URL: TcxGridDBColumn;
    colU_FLG_ACTIVE: TcxGridDBColumn;
    colU_LAST_SCAN: TcxGridDBColumn;
    colU_LAST_ITEMS: TcxGridDBColumn;
    colU_LAST_ERROR: TcxGridDBColumn;
    pnUrlsButtons: TPanel;
    btnUrlAdd: TcxButton;
    btnUrlDelete: TcxButton;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQueryCats: TIBCQuery;
    IBCDataSourceCats: TIBCDataSource;
    IBCQueryUrls: TIBCQuery;
    IBCDataSourceUrls: TIBCDataSource;
    IBCQuerySites: TIBCQuery;
    IBCDataSourceSites: TIBCDataSource;
    IBCTransactionUpdate: TIBCTransaction;
    procedure btnCatAddClick(Sender: TObject);
    procedure btnCatDeleteClick(Sender: TObject);
    procedure btnUrlAddClick(Sender: TObject);
    procedure btnUrlDeleteClick(Sender: TObject);
    procedure IBCQueryCatsNewRecord(DataSet: TDataSet);
    procedure IBCQueryCatsBeforePost(DataSet: TDataSet);
    procedure IBCQueryUrlsNewRecord(DataSet: TDataSet);
    procedure IBCQueryUrlsBeforePost(DataSet: TDataSet);
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  end;

implementation

uses
  System.UITypes;

{$R *.dfm}

{ TfrmPWCategoriesDlg }

procedure TfrmPWCategoriesDlg.Prepare;
begin
  dtDialogTitle.Text := 'CATALOGID = categoria de pe site-ul nostru (TWEB_CATALOG, ex. 132 = Procesoare). ' +
    'Pentru fiecare categorie, mai jos, adresa paginii ei pe fiecare site concurent.';
  IBCTransactionUpdate.DefaultConnection := FIBCConnection;
  IBCQuerySites.Connection := FIBCConnection;
  IBCQuerySites.Transaction := IBCTransactionUpdate;
  IBCQueryCats.Connection := FIBCConnection;
  IBCQueryCats.Transaction := IBCTransactionUpdate;
  IBCQueryCats.UpdateTransaction := IBCTransactionUpdate;
  IBCQueryUrls.Connection := FIBCConnection;
  IBCQueryUrls.Transaction := IBCTransactionUpdate;
  IBCQueryUrls.UpdateTransaction := IBCTransactionUpdate;
  if not IBCTransactionUpdate.Active then
    IBCTransactionUpdate.StartTransaction;
  IBCQuerySites.Open;
  IBCQueryCats.Open;
  IBCQueryUrls.Open;
end;

function TfrmPWCategoriesDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if IBCQueryUrls.State in dsEditModes then
      IBCQueryUrls.Post;
    if IBCQueryCats.State in dsEditModes then
      IBCQueryCats.Post;
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Commit;
    Result := True;
  except
    on E: Exception do
      MessageDlg('Nu s-a putut salva: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmPWCategoriesDlg.WhenCancelForm;
begin
  try
    if IBCQueryUrls.State in dsEditModes then
      IBCQueryUrls.Cancel;
    if IBCQueryCats.State in dsEditModes then
      IBCQueryCats.Cancel;
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
  except
  end;
end;

procedure TfrmPWCategoriesDlg.IBCQueryCatsNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
  DataSet.FieldByName('ORDERNO').AsInteger := IBCQueryCats.RecordCount + 1;
end;

procedure TfrmPWCategoriesDlg.IBCQueryCatsBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('CATALOGID').AsInteger <= 0 then
    raise Exception.Create('Completati CATALOGID (categoria din TWEB_CATALOG).');
  if Trim(DataSet.FieldByName('TITLE').AsString) = '' then
    DataSet.FieldByName('TITLE').AsString := Trim(DataSet.FieldByName('CATALOG_TITLE').AsString);
end;

procedure TfrmPWCategoriesDlg.IBCQueryUrlsNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('CATID').AsInteger := IBCQueryCats.FieldByName('CATID').AsInteger;
  DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
end;

procedure TfrmPWCategoriesDlg.IBCQueryUrlsBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('SITEID').AsInteger <= 0 then
    raise Exception.Create('Alegeti site-ul.');
  if Trim(DataSet.FieldByName('URL').AsString) = '' then
    raise Exception.Create('Completati URL-ul categoriei pe site.');
end;

procedure TfrmPWCategoriesDlg.btnCatAddClick(Sender: TObject);
begin
  if IBCQueryUrls.State in dsEditModes then
    IBCQueryUrls.Post;
  IBCQueryCats.Append;
  cxGridCats.SetFocus;
end;

procedure TfrmPWCategoriesDlg.btnCatDeleteClick(Sender: TObject);
begin
  if IBCQueryCats.IsEmpty then
    Exit;
  if MessageDlg(Format('Stergeti categoria "%s"? Se sterg si URL-urile ei, produsele gasite si istoricul.',
      [IBCQueryCats.FieldByName('TITLE').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  IBCQueryCats.Delete;
end;

procedure TfrmPWCategoriesDlg.btnUrlAddClick(Sender: TObject);
begin
  if IBCQueryCats.IsEmpty then
    Exit;
  if IBCQueryCats.State in dsEditModes then
    IBCQueryCats.Post;
  IBCQueryUrls.Append;
  cxGridUrls.SetFocus;
end;

procedure TfrmPWCategoriesDlg.btnUrlDeleteClick(Sender: TObject);
begin
  if IBCQueryUrls.IsEmpty then
    Exit;
  if MessageDlg('Stergeti acest URL?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  IBCQueryUrls.Delete;
end;

end.
