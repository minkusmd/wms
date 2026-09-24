unit frmPromoCodesEditorUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  SWNBaseUnit,
  DialogTitle,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxPCdxBarPopupMenu,
  cxContainer,
  cxEdit,
  cxMemo,
  cxDBEdit,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  Vcl.StdCtrls,
  cxPC,
  cxCheckListBox,
  cxDBCheckListBox,
  cxCheckBox,
  cxButtonEdit,
  cxCalc,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  dxBarBuiltInMenu,
  cxCustomListBox,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Data.DB,
  cxDBData,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridLevel,
  cxGridCustomView,
  cxGrid,
  cxClasses,
  dxBar,
  Vcl.ExtCtrls,
  dxDateRanges,
  DBAccess,
  IBC,
  MemDS,
  dxScrollbarAnnotations,
  cxLabel,
  cxImage,
  cxBarEditItem,
  dxBarExtItems,
  cxListBox,
  dxCoreGraphics;

type
  TfrmPromoCodesEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    edTitleRo: TcxDBTextEdit;
    deEND_DATE: TcxDBDateEdit;
    btnOk: TButton;
    Button2: TButton;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNewGoods: TdxBarButton;
    bbDelete: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    bbNewDiscountRange: TdxBarButton;
    bbDeleteDiscountRange: TdxBarButton;
    Label21: TLabel;
    bePROMO_GOODS_GROUP_ID: TcxButtonEdit;
    Label22: TLabel;
    ceDiscountValue: TcxDBCalcEdit;
    Label2: TLabel;
    Label4: TLabel;
    ceDiscountPercent: TcxDBCalcEdit;
    edTicketCode: TcxDBTextEdit;
    Label5: TLabel;
    imgBanerRo: TcxDBImage;
    Label6: TLabel;
    Label7: TLabel;
    bbGenerate: TdxBarButton;
    dxBarManager1Bar3: TdxBar;
    bbGenQty: TdxBarSpinEdit;
    beTemplatePromoCode: TcxBarEditItem;
    bbClearAll: TdxBarButton;
    imgBanerRu: TcxDBImage;
    Label8: TLabel;
    Label9: TLabel;
    edTitleRu: TcxDBTextEdit;
    Label10: TLabel;
    IBCQueryTicketType: TIBCQuery;
    IBCDataSourceTicketType: TIBCDataSource;
    lcbTICKET_TYPE: TcxDBLookupComboBox;
    cbFLG_Active: TcxDBCheckBox;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbGenerateClick(Sender: TObject);
    procedure bbClearAllClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputValues: Boolean;
    procedure SelectPromoGoods;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure GeneratePromoTicketsIDs;
    function GenerateRandomNumber: string;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions,
  DataModuleDB,
  SWNConst,
  SWNUtils,
  System.Math,
  frmGoodsGroupsManagerDialog;

function TfrmPromoCodesEditorDlg.CheckInputValues: Boolean;
var
  Errors: string;
begin
  Result := False;
  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmPromoCodesEditorDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectPromoGoods;
end;

procedure TfrmPromoCodesEditorDlg.bbClearAllClick(Sender: TObject);
begin
//  cxListBox1.Items.Clear;
end;

procedure TfrmPromoCodesEditorDlg.bbGenerateClick(Sender: TObject);
begin
  GeneratePromoTicketsIDs;
end;

procedure TfrmPromoCodesEditorDlg.BindingDataSource;
begin
  edTitleRo.DataBinding.DataSource := fMasterDataSource;
  edTitleRu.DataBinding.DataSource := fMasterDataSource;

  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;

  ceDiscountValue.DataBinding.DataSource := fMasterDataSource;
  ceDiscountPercent.DataBinding.DataSource := fMasterDataSource;
  edTicketCode.DataBinding.DataSource := fMasterDataSource;
  imgBanerRo.DataBinding.DataSource := fMasterDataSource;
  imgBanerRu.DataBinding.DataSource := fMasterDataSource;

  lcbTICKET_TYPE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_Active.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmPromoCodesEditorDlg.GeneratePromoTicketsIDs;
var
  slist: TStringList;
  ItemsCount: Integer;
begin
  ItemsCount := Trunc(bbGenQty.Value);
  slist := TStringList.Create;
  try
    slist.Duplicates := dupIgnore;
    Randomize;
    while ItemsCount > slist.Count do
    begin
      slist.Add(GenerateRandomNumber);
    end;

//    cxListBox1.Items.Assign(slist);
  finally
    slist.Free;
  end;
end;

function TfrmPromoCodesEditorDlg.GenerateRandomNumber: string;
begin
  Result := edTicketCode.Text + format('%.3d', [Random(999)]);
end;

function TfrmPromoCodesEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputValues then
  begin
    fMasterDataSet.Post;
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmPromoCodesEditorDlg.Prepare;
begin
  pcPageControl.ActivePage := tbsGeneral;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('DATA1').AsDateTime := NOW;
      fMasterDataSet.FieldByName('DATA2').AsDateTime := NOW;

      bePROMO_GOODS_GROUP_ID.Text := '';
      bePROMO_GOODS_GROUP_ID.Tag := -1;

    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      fMasterDataSet.Edit;

      bePROMO_GOODS_GROUP_ID.Text := fMasterDataSet.FieldByName('GOODS_GROUP_TITLE').AsString;
      bePROMO_GOODS_GROUP_ID.Tag := fMasterDataSet.FieldByName('GG_ID').AsInteger;
    end;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmPromoCodesEditorDlg.SelectPromoGoods;
var
  dialog: TfrmGoodsGroupsManagerDlg;
begin
  dialog := TfrmGoodsGroupsManagerDlg.Create(Self);
  try
    if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('GG_ID').AsInteger) then
    begin
      fMasterDataSet.FieldByName('GG_ID').AsInteger := dialog.GG_ID;
      bePROMO_GOODS_GROUP_ID.Tag := fMasterDataSet.FieldByName('GG_ID').AsInteger;
      bePROMO_GOODS_GROUP_ID.Text := dialog.GG_Title;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPromoCodesEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmPromoCodesEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

