unit frmWebMailingEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxImage, cxDBEdit, Vcl.ComCtrls,
  cxTextEdit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS, cxLabel, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TfrmWebMailingEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    pcPages: TPageControl;
    tbsHeader: TTabSheet;
    tbsBanners: TTabSheet;
    tbsFooter: TTabSheet;
    edHEADER_TEXT: TcxDBTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    imgHEADER_IMAGE: TcxDBImage;
    Label5: TLabel;
    imgFOOTER_IMAGE: TcxDBImage;
    Label4: TLabel;
    edFOOTER_TEXT: TcxDBTextEdit;
    cxGridContentTable: TcxGridDBTableView;
    cxGridContentLevel: TcxGridLevel;
    cxGridContent: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbAddBanner: TdxBarButton;
    bbRemoveBanner: TdxBarButton;
    cxGridContentTableColumn1: TcxGridDBColumn;
    cxGridContentTableColumn2: TcxGridDBColumn;
    IBCQueryImages: TIBCQuery;
    IBCDataSourceImages: TIBCDataSource;
    Label6: TLabel;
    edGoogleTag: TcxDBTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridContentTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddBannerClick(Sender: TObject);
    procedure bbRemoveBannerClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNew: Boolean;
    fFileList: TStringList;
    procedure SetCreateNew(const Value: Boolean);

    function CheckParams: Boolean;
    procedure BannerSelectionChanged;

    procedure ShowAddNewBannerDialog;
    procedure RegisterNewBannerImage(const PAImageIDList: TIntegerArray);
    procedure DeleteBanner;

  protected
    { protected declarations }

    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewMailing: Boolean read FCreateNew write SetCreateNew;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB, StrUtils, frmSelectBannerDialog, SWNDBErrors;

{$R *.dfm}
{ TfrmWebMailingEditorDlg }

procedure TfrmWebMailingEditorDlg.BannerSelectionChanged;
var
  fAdd, fRemove: Boolean;
begin
  fAdd := True;
  fRemove := False;
  if cxGridContentTable.DataController.RecNo > 0 then
  begin
    fRemove := True;
  end;
  bbAddBanner.Enabled := fAdd;
  bbRemoveBanner.Enabled := fRemove;
end;

procedure TfrmWebMailingEditorDlg.bbAddBannerClick(Sender: TObject);
begin
  ShowAddNewBannerDialog;
end;

procedure TfrmWebMailingEditorDlg.bbRemoveBannerClick(Sender: TObject);
begin
  DeleteBanner;
end;

function TfrmWebMailingEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('HEADER_TEXT').IsNull and fMasterDataSet.FieldByName('HEADER_IMAGE').IsNull then
    AddErrorToStr(ErrorStr, 'Текст или картинка заголовка!');
  if cxGridContentTable.DataController.RecordCount = 0 then
    AddErrorToStr(ErrorStr, 'Баннеры!');
  if fMasterDataSet.FieldByName('FOOTER_TEXT').IsNull and fMasterDataSet.FieldByName('FOOTER_IMAGE').IsNull then
    AddErrorToStr(ErrorStr, 'Текст или картинка подвала!');

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebMailingEditorDlg.cxGridContentTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  BannerSelectionChanged;
end;

procedure TfrmWebMailingEditorDlg.DeleteBanner;
begin
  try
    IBCQueryImages.Delete;
  except
    on E: Exception do
    begin
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebMailingEditorDlg.FormCreate(Sender: TObject);
begin
  fFileList := TStringList.Create;
end;

procedure TfrmWebMailingEditorDlg.FormDestroy(Sender: TObject);
begin
  fFileList.Free;
end;

procedure TfrmWebMailingEditorDlg.BindingDataSource;
begin
  FCreateNew := True;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  edHEADER_TEXT.DataBinding.DataSource := fMasterDataSource;
  imgHEADER_IMAGE.DataBinding.DataSource := fMasterDataSource;
  edFOOTER_TEXT.DataBinding.DataSource := fMasterDataSource;
  edGoogleTag.DataBinding.DataSource := fMasterDataSource;
  imgFOOTER_IMAGE.DataBinding.DataSource := fMasterDataSource;

  IBCQueryImages.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryImages.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryImages.MasterSource := fMasterDataSource;

end;

function TfrmWebMailingEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmWebMailingEditorDlg.Prepare;
begin
  pcPages.ActivePage := tbsHeader;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNew then
    begin
      dtDialogTitle.Text := 'Создание новой рассылки';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FOOTER_TEXT').AsString :=
        'Daca nu mai doresti sa primesti acest newsletter, te rugam sa te <a href="http://www.fantastic.md/unsubscribe.aspx?tid=$TARGETUIC">dezabonezi</a>.';
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';
      fMasterDataSet.Edit;
    end;
    IBCQueryImages.Active := True;

    BannerSelectionChanged;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebMailingEditorDlg.RegisterNewBannerImage(const PAImageIDList: TIntegerArray);
var
  i: integer;
begin
  for i := 0 to Length(PAImageIDList) - 1 do
  begin
    try
      IBCQueryImages.Append;
      IBCQueryImages.FieldByName('MAILINGID').AsInteger := fMasterDataSet.FieldByName('MAILINGID').AsInteger;
      IBCQueryImages.FieldByName('PAIMAGEBRICKID').AsInteger := PAImageIDList[i];
      IBCQueryImages.Post;
    except
      on E: Exception do
      begin
        IBCQueryImages.Cancel;
        if Not ProcessSWNError(E) then
          raise;
        break;
      end;
    end;
  end;
end;

procedure TfrmWebMailingEditorDlg.SetCreateNew(const Value: Boolean);
begin
  FCreateNew := Value;
end;

procedure TfrmWebMailingEditorDlg.ShowAddNewBannerDialog;
var
  dialog: TfrmSelectBannerDlg;
begin
  dialog := TfrmSelectBannerDlg.Create(Self);
  try
    if dialog.ShowModal = mrOK then
    begin
      RegisterNewBannerImage(dialog.GetPAImageIDList);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebMailingEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
