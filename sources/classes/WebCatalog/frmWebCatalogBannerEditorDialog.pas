unit frmWebCatalogBannerEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxButtonEdit, Vcl.StdCtrls, cxRadioGroup, cxCheckBox,
  cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, cxTextEdit, cxImage;

type
  TfrmWebCatalogBannerEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    edBACK_COLOR: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    cbFLG_HAS_BACKGROUND: TcxDBCheckBox;
    cbFLG_BACK_COLOR: TcxDBCheckBox;
    imgBACK_IMAGE: TcxDBImage;
    Label3: TLabel;
    imgFRONT_IMAGE: TcxDBImage;
    Label5: TLabel;
    edURL: TcxDBTextEdit;
    Label6: TLabel;
    edURL_RU: TcxDBTextEdit;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    fCatalogID: integer;
    function CheckValues: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetCatalogID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read fCreateNewRecord
      write SetCreateNewRecord;
    property CatalogID: integer read fCatalogID write SetCatalogID;
  end;

implementation

{$R *.dfm}

uses
  SWNUpdateClientDBClass, SWNUtils, SWNConst;

{ TfrmWebCatalogBannerEditorDlg }

function TfrmWebCatalogBannerEditorDlg.CheckValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or
    (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire!');
  if fMasterDataSet.FieldByName('START_DATE').IsNull or
    fMasterDataSet.FieldByName('END_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Perioada!');
  if fMasterDataSet.FieldByName('FLG_HAS_BACKGROUND').AsInteger = 1 then
  begin
    if fMasterDataSet.FieldByName('FLG_BACK_COLOR').AsInteger = 1 then
    begin
      if fMasterDataSet.FieldByName('BACK_COLOR').IsNull or
        (fMasterDataSet.FieldByName('BACK_COLOR').AsString = '') then
        AddErrorToStr(ErrorStr, 'Culoare background!');
    end
    else if fMasterDataSet.FieldByName('BACK_IMAGE').IsNull then
      AddErrorToStr(ErrorStr, 'Imagine background!');
  end
  else if fMasterDataSet.FieldByName('FRONT_IMAGE').IsNull then
    AddErrorToStr(ErrorStr, 'Imagine frontala!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmWebCatalogBannerEditorDlg.BindingDataSource;
begin
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_HAS_BACKGROUND.DataBinding.DataSource := fMasterDataSource;
  cbFLG_BACK_COLOR.DataBinding.DataSource := fMasterDataSource;
  imgBACK_IMAGE.DataBinding.DataSource := fMasterDataSource;
  imgFRONT_IMAGE.DataBinding.DataSource := fMasterDataSource;
  edBACK_COLOR.DataBinding.DataSource := fMasterDataSource;

  edURL.DataBinding.DataSource := fMasterDataSource;
  edURL.DataBinding.DataField := 'URL';

  edURL_RU.DataBinding.DataSource := fMasterDataSource;
  edURL_RU.DataBinding.DataField := 'URL_RU';

end;

function TfrmWebCatalogBannerEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmWebCatalogBannerEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Creare baner';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('CATALOGID').AsInteger := fCatalogID;
      fMasterDataSet.FieldByName('START_DATE').AsDateTime := NOW;
      fMasterDataSet.FieldByName('END_DATE').AsDateTime := NOW;
      fMasterDataSet.FieldByName('FLG_HAS_BACKGROUND').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_BACK_COLOR').AsInteger := 1;
      fMasterDataSet.FieldByName('BACK_COLOR').AsString := 'red';
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica baner';
      fMasterDataSet.Edit;
    end;

  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebCatalogBannerEditorDlg.SetCatalogID(const Value: integer);
begin
  fCatalogID := Value;
end;

procedure TfrmWebCatalogBannerEditorDlg.SetCreateNewRecord
  (const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmWebCatalogBannerEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
