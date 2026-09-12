unit frmWebCatalogLevel1Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, StdCtrls, cxCheckBox, cxImage, IBC,
  dxUIAClasses, cxMaskEdit, cxDropDownEdit, cxCalc;

type
  TfrmWebCatalogLevel1Dlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    ImgCatalog: TcxDBImage;
    Label3: TLabel;
    cbFLG_PROMO: TcxDBCheckBox;
    cbFLG_NEW: TcxDBCheckBox;
    cbFLG_POPULAR: TcxDBCheckBox;
    teURL_RO: TcxDBTextEdit;
    Label4: TLabel;
    Label5: TLabel;
    teURL_RU: TcxDBTextEdit;
    BigImage: TcxDBImage;
    Label6: TLabel;
    ceOrderNo: TcxDBCalcEdit;
    procedure FormShow(Sender: TObject);
    procedure pnClientDblClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewFolder: Boolean;
    FDataSourceImage: TIBCDataSource;
    fDT: integer;
    procedure SetCreateNewFolder(const Value: Boolean);

    function CheckParams: Boolean;
    procedure SetDataSourceImage(const Value: TIBCDataSource);
    procedure SetDT(const Value: integer);

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
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst, DB;

{$R *.dfm}
{ TfrmWebCatalogLevel1Dlg }

function TfrmWebCatalogLevel1Dlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString) = '') then
    AddErrorToStr(ErrorStr, 'Denumirea mapei');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE_RUS').asString) = '') then
    AddErrorToStr(ErrorStr, 'Denumirea folderului');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebCatalogLevel1Dlg.FormShow(Sender: TObject);
begin
   ImgCatalog.DataBinding.DataSource := DataSourceImage;
   BigImage.DataBinding.Datasource := DataSourceImage;
end;

procedure TfrmWebCatalogLevel1Dlg.BindingDataSource;
begin
  inherited;
  FCreateNewFolder := False;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  cbFLG_NEW.DataBinding.DataSource := fMasterDataSource;
  cbFLG_PROMO.DataBinding.DataSource := fMasterDataSource;
  cbFLG_POPULAR.DataBinding.DataSource := fMasterDataSource;
  teURL_RO.DataBinding.DataSource := fMasterDataSource;
  teURL_RU.DataBinding.DataSource := fMasterDataSource;
  ceOrderNo.DataBinding.DataSource := MasterDataSource;
end;

function TfrmWebCatalogLevel1Dlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    if DataSourceImage.DataSet.State in (dsEditModes) then
    begin
       DataSourceImage.DataSet.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
       DataSourceImage.DataSet.Post;
    end;

    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmWebCatalogLevel1Dlg.pnClientDblClick(Sender: TObject);
begin
  ShowMessage(ImgCatalog.DataBinding.DataSource.DataSet.Name);
end;

procedure TfrmWebCatalogLevel1Dlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewFolder then
    begin
      dtDialogTitle.Text := 'Creare mapa nivelul 1';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := 0; // root
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('DT').AsInteger := fDT;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica mapa nivelul 1';
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebCatalogLevel1Dlg.SetCreateNewFolder(const Value: Boolean);
begin
  FCreateNewFolder := Value;
end;

procedure TfrmWebCatalogLevel1Dlg.SetDataSourceImage(const Value:
    TIBCDataSource);
begin
   FDataSourceImage := Value;
end;

procedure TfrmWebCatalogLevel1Dlg.SetDT(const Value: integer);
begin
  fDT := Value;
end;

procedure TfrmWebCatalogLevel1Dlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
