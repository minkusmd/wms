unit frmGoodsTypeEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, ExtCtrls,
  DialogTitle, cxDBEdit, StdCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, cxCheckBox, cxMemo, cxTextEdit, cxImage, Data.DB, DBAccess, IBC, MemDS,
  dxUIAClasses, dxCoreGraphics, cxButtonEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, dxBar, cxClasses;

type
  TfrmGoodsTypeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQueryImage: TIBCQuery;
    IBCDataSourceImage: TIBCDataSource;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label3: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    edTITLE: TcxDBTextEdit;
    beGoodsFolder: TcxButtonEdit;
    chkFeed: TcxDBCheckBox;
    Label8: TLabel;
    btnAttributes: TcxButton;
    Panel1: TPanel;
    procedure beGoodsFolderPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnAttributesClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewType: Boolean;
    procedure SetCreateNewType(const Value: Boolean);
    function CheckParams: Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure LoadImageFromDB;
    procedure SaveImageToDB;
    procedure WhenCancelForm; override;
  public
    { Public declarations }

    property CreateNewType: Boolean read FCreateNewType write SetCreateNewType;
  end;

implementation

uses
  SWNUtils, SWNConst, frmGoods, frmWebDescriptionTemplateDialog,
  frmGoodsTypeFiltersDialog;

{$R *.dfm}

{ TfrmGoodsTypeEditorDlg }

function TfrmGoodsTypeEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';
  if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Denumirea ROM!');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE_RUS').AsString)
    = '') then
    AddErrorToStr(ErrorStr, 'Denumirea RUS!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmGoodsTypeEditorDlg.btnAttributesClick(Sender: TObject);
var
  d: TfrmGoodsTypeFiltersDlg;
  gtid: Integer;
begin
  if FCreateNewType then
  begin
    ShowMessage('Salvati mai intai tipul de produs, apoi adaugati filtre.');
    Exit;
  end;
  gtid := fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger;
  if gtid <= 0 then
  begin
    ShowMessage('Tip de produs invalid.');
    Exit;
  end;
  d := TfrmGoodsTypeFiltersDlg.Create(Self);
  try
    d.GoodsTypeID := gtid;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeEditorDlg.beGoodsFolderPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
    d: TfrmGoodsBrowser;
begin
    d:=TfrmGoodsBrowser.Create(self);
    try
        if d.SelectGoods(-1, true) then
        begin
            if d.GoodsIsFolder then
            begin
                MasterDataSet.Edit;
                MasterDataSet.FieldByName('GOODS_FOLDERID').AsInteger := d.Goodsid;
                beGoodsFolder.Tag := d.GoodsID;
                beGoodsFolder.Text := d.GoodsTitle;
            end;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsTypeEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewType := False;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
//  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
//  edSEARCH_KEYS.DataBinding.DataSource := fMasterDataSource;
//  TeModel.DataBinding.DataSource := fMasterDataSource;
//  teParam.DataBinding.DataSource := fMasterDataSource;
//  teAux.DataBinding.DataSource := fMasterDataSource;
//  edShortTitle.DataBinding.DataSource := fMasterDataSource;
  chkFeed.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmGoodsTypeEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    fMasterDataSet.Post;

    SaveImageToDB;

    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmGoodsTypeEditorDlg.LoadImageFromDB;
var
  ms: TMemoryStream;
begin
//  ms := TMemoryStream.Create;
//  try
//    TBlobField(IBCQueryImage.FieldByName('IMAGE')).SaveToStream(ms);
//    ms.Position := 0;
//    ImgDefault.Picture.LoadFromStream(ms);
//
//    ms.Clear;
//    TBlobField(IBCQueryImage.FieldByName('MENU_IMAGE')).SaveToStream(ms);
//    ms.Position := 0;
//    MenuImage.Picture.LoadFromStream(ms);
//
//  finally
//    ms.Free;
//  end;
end;

procedure TfrmGoodsTypeEditorDlg.Prepare;
begin
  try
    IBCQueryImage.Close;
    IBCQueryImage.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    IBCQueryImage.ParamByName('GOODSTYPEID').AsInteger := fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger;
    IBCQueryImage.Open;

    fMasterDataSet.UpdateTransaction.StartTransaction;

//    IBCQuerySubCategory.Close;
//    IBCQuerySubCategory.UpdateTransaction := MasterDataSet.UpdateTransaction;
//    IBCQuerySubCategory.ParamByName('goodstypeid').AsInteger := MasterDataSet.FieldByName('goodstypeid').AsInteger;
//    IBCQuerySubCategory.Open;

    if FCreateNewType then
    begin
      dtDialogTitle.Text := 'Creare tip produs nou';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_FEED').AsInteger := 1;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      fMasterDataSet.Edit;
    end;

    LoadImageFromDB;

    if IBCQueryImage.RecordCount>0 then
      IBCQueryImage.Edit
    else
      IBCQueryImage.Insert;

    IBCQueryImage.FieldByName('GOODSTYPEID').AsInteger := fMasterDataSet.FieldByName('goodstypeid').AsInteger;
    beGoodsFolder.Tag := MasterDataSet.FieldByName('goods_folderid').AsInteger;
    beGoodsFolder.Text := MasterDataSet.FieldByName('GOODS_FOLDER_TITLE').AsString;
//    beGoodsAttrTemplate.Text := MasterDataSet.FieldByName('goods_attr_template_name_ro').AsString;
//    beGoodsAttrTemplate.Tag := MasterDataSet.FieldByName('goods_attr_templateid').AsInteger;

  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmGoodsTypeEditorDlg.SaveImageToDB;
//var
//  ms: TMemoryStream;
begin
//  ms := TMemoryStream.Create;
//  try
//    ImgDefault.Picture.Graphic.SaveToStream(ms);
//    TBlobField(IBCQueryImage.FieldByName('IMAGE')).LoadFromStream(ms);
//
//    ms.Clear;
//    MenuImage.Picture.Graphic.SaveToStream(ms);
//    TBlobField(IBCQueryImage.FieldByName('MENU_IMAGE')).LoadFromStream(ms);
//
//    IBCQueryImage.Post;
//  finally
//    ms.Free;
//  end;
end;

procedure TfrmGoodsTypeEditorDlg.SetCreateNewType(const Value: Boolean);
begin
  FCreateNewType := Value;
end;

procedure TfrmGoodsTypeEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

