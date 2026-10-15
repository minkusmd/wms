unit frmGoodsQuickInfoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxStyles, cxCustomData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid,
  ComCtrls, Menus, GoodsDescriptionClasses, GifImg, cxImage, cxButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxMemo, cxContainer, cxClasses, Data.DB, DBAccess, IBC, MemDS, cxTextEdit, cxDBEdit,
  System.ImageList, Vcl.ImgList, cxImageList, cxCurrencyEdit, cxCheckBox, cxDBData, cxGridDBTableView, dxUIAClasses;

type
  TGraphicType = (gtBitmap, gtIcon, gtJpeg);
  TOnAddGoods2Jurnal = procedure(GoodsID: integer) of object;

  TfrmGoodsQuickInfoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pcPageControl: TPageControl;
    tbsDescriptions: TTabSheet;
    tbsFields: TTabSheet;
    cxGridInfo: TcxGrid;
    cxGridInfoTable: TcxGridTableView;
    cxGridInfo_FILTERNAME_RUS: TcxGridColumn;
    cxGridInfo_PARAM_VALUE_RUS: TcxGridColumn;
    cxGridInfoLevel: TcxGridLevel;
    tbsImages: TTabSheet;
    lbImages: TListBox;
    mmDESCRIPTION: TMemo;
    cxGridInfo_FLG_GROUP: TcxGridColumn;
    Bevel1: TBevel;
    pnButtons: TPanel;
    lbWarning: TLabel;
    mmTITLE: TMemo;
    edWEBTYPE: TEdit;
    edVENDOR: TEdit;
    edCODE: TEdit;
    edDETAILS: TEdit;
    edBASE_CODE: TEdit;
    imgImage: TcxImage;
    btnClose: TcxButton;
    tbsUsedFor: TTabSheet;
    IBCQuerySearchkeys: TIBCQuery;
    IBCDataSourceSearchkeys: TIBCDataSource;
    cxDBMemo1: TcxDBMemo;
    cxImageList1: TcxImageList;
    tbsRelatedKey: TTabSheet;
    IBCQueryGoodsRelatedGoods: TIBCQuery;
    IBCDataSourceRelatedGoods: TIBCDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1_GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn;
    cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxDBImage1: TcxDBImage;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure lbImagesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure lbImagesClick(Sender: TObject);
    procedure pcPageControlChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cxGridInfoTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FGoodsID: integer;
    fWorkBMP: TBitmap;
    fDescriptions: TGoodsDescriptionCollection;
    FOnAddGoods2Jurnal: TOnAddGoods2Jurnal;
    procedure SetGoodsID(const Value: integer);

    procedure LoadGoodsInfo;
    procedure ClearImages;

    procedure DisplayDescriptions;
    procedure SetOnAddGoods2Jurnal(const Value: TOnAddGoods2Jurnal);
  protected
    { protected declarations }
    procedure Prepare; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property GoodsID: integer read FGoodsID write SetGoodsID;
    property OnAddGoods2Jurnal: TOnAddGoods2Jurnal read FOnAddGoods2Jurnal write
        SetOnAddGoods2Jurnal;
  end;

implementation

uses
  Math, Types, DataModuleAdditions, DataModuleDB,
  SWNValueStorageUnit, SWNUtils, dxGDIPlusClasses;

{$R *.dfm}

{ TfrmGoodsQuickInfoDlg }

procedure TfrmGoodsQuickInfoDlg.ClearImages;
var
  i: integer;
begin
  lbImages.Items.BeginUpdate;
  try
    for i := 0 to lbImages.Count - 1 do
      TdxSmartImage(lbImages.Items.Objects[i]).Free;
    lbImages.Items.Clear;
  finally
    lbImages.Items.EndUpdate;
  end;
end;

constructor TfrmGoodsQuickInfoDlg.Create(AOwner: TComponent);
begin
  inherited;
  fDescriptions := TGoodsDescriptionCollection.Create;
end;

procedure TfrmGoodsQuickInfoDlg.cxGridInfoTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridInfo_FLG_GROUP.Index] = true then
    AStyle := dmAdditions.cxStyle_ParamGroup; // Group
end;

destructor TfrmGoodsQuickInfoDlg.Destroy;
begin
  ClearImages;
  fWorkBMP.Free;
  fDescriptions.Free;
  inherited;
end;

procedure TfrmGoodsQuickInfoDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
    if (Key = VK_RETURN) and (ssCtrl in Shift) then begin
      if Assigned(FOnAddGoods2Jurnal) then begin
        fOnAddGoods2Jurnal(IBCQueryGoodsRelatedGoods.FieldByName('GoodsID').AsInteger);
      end;
      Key := 0;
      Shift := [];
    end;

    ProcessCommonKeys(self,cxGrid1DBTableView1, Key, Shift);
end;

procedure TfrmGoodsQuickInfoDlg.DisplayDescriptions;
var
  i, N: integer;
  descItem: TGoodsDescriptionItem;
begin
  cxGridInfoTable.BeginUpdate;
  try
    for i := 0 to fDescriptions.Count - 1 do
    begin
      descItem := fDescriptions[i];

      N := cxGridInfoTable.DataController.AppendRecord;
      cxGridInfoTable.DataController.Values[N, cxGridInfo_FLG_GROUP.Index] := descItem.IsGroup;
      if descItem.IsGroup then
      begin
        cxGridInfoTable.DataController.Values[N, cxGridInfo_FILTERNAME_RUS.Index] := descItem.ValueRus;
      end
      else
      begin
        cxGridInfoTable.DataController.Values[N, cxGridInfo_FILTERNAME_RUS.Index] := descItem.TitleRus;
        cxGridInfoTable.DataController.Values[N, cxGridInfo_PARAM_VALUE_RUS.Index] := descItem.ValueRus;
      end

    end;
  finally
    cxGridInfoTable.EndUpdate;
  end;
end;

procedure TfrmGoodsQuickInfoDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if pcPageControl.Visible then
    AppUserTempConfigStorage.IntValues.SetValue('GoodsQuickInfo_LastTabIndex', pcPageControl.ActivePageIndex);
  CanClose := True;
end;

procedure TfrmGoodsQuickInfoDlg.FormCreate(Sender: TObject);
begin
  fWorkBMP := TBitmap.Create;
  pcPageControl.ActivePage := tbsDescriptions;
  lbWarning.Visible := False;
end;

procedure TfrmGoodsQuickInfoDlg.lbImagesClick(Sender: TObject);
begin
  if lbImages.ItemIndex <> -1 then
    imgImage.Picture.Assign(TdxSmartImage(lbImages.Items.Objects[lbImages.ItemIndex]));
end;

procedure TfrmGoodsQuickInfoDlg.lbImagesDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  R0, R: TRect;
  color_back: TColor;
  pen_color_back: TColor;
  Img: TdxSmartImage;
  w, h, w2, h2: integer;
  delta: double;
begin
  Img := TdxSmartImage(lbImages.Items.Objects[Index]);

  if odFocused in State then
  begin
    color_back := $00FAE8C4;
    pen_color_back := clWindow;
  end
  else if odSelected in State then
  begin
    color_back := $00EDEDED;
    pen_color_back := $00C8C8C8;
  end
  else
  begin
    color_back := clWindow;
    pen_color_back := $00C8C8C8;
  end;

  fWorkBMP.Width := Rect.Right - Rect.Left;
  fWorkBMP.Height := Rect.Bottom - Rect.Top;

  R0 := Types.Rect(0, 0, fWorkBMP.Width, fWorkBMP.Height);
  InflateRect(R0, -2, -2);

  with fWorkBMP.Canvas do
  begin
    Brush.Color := clWindow;
    FillRect(Types.Rect(0, 0, fWorkBMP.Width, fWorkBMP.Height));

    Pen.Style := psSolid;
    Pen.Color := pen_color_back;
    Brush.Color := color_back;
    Rectangle(R0);

    R := R0;
    InflateRect(R, -2, -2);
          // image
    w := R.Right - R.Left;
    h := R.Bottom - R.Top;
    if (Img.Width <= w) and (Img.Height <= h) then
    begin
               // image is smaller than display area, draw it in center
      Draw(R.Left + (w - Img.Width) div 2, R.Top + (h - Img.Height) div 2, Img);
    end
    else
    begin
               // image is bigger, stretch it proportionaly
      delta := Max(Img.Width / w, Img.Height / h);
      w2 := Round(Img.Width / delta);
      h2 := Round(Img.Height / delta);
      R := Types.Rect(R.Left + (w - w2) div 2, R.Top + (h - h2) div 2, R.Left + ((w - w2) div 2) + w2, R.Top + ((h - h2) div 2) + h2);
      StretchDraw(R, Img);
    end;

          // event
    if lbImages.Items[Index] <> '' then
    begin
      R := R0;
      InflateRect(R, -2, -2);
      dmAdditions.cxImageList_SWN.Draw(fWorkBMP.Canvas, Rect.Right - 6 - dmAdditions.cxImageList_SWN.Width, Rect.Top + 4, 37);
    end;
  end;
     // copy
  lbImages.Canvas.Draw(Rect.Left, Rect.Top, fWorkBMP);
end;

procedure TfrmGoodsQuickInfoDlg.LoadGoodsInfo;
var
  Query: TIBCQuery;
  S: string;
  MS: TMemoryStream;
  IMG: TdxSmartImage;
  hasDescriptions: Boolean;
  hasImages: Boolean;
  descItem: TGoodsDescriptionItem;
begin
  hasDescriptions := False;
  hasImages := False;

  cxGridInfoTable.DataController.BeginUpdate;
  lbImages.Items.BeginUpdate;
  MS := TMemoryStream.Create;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;

        // 1. general info
    Query.SQL.Clear;
    Query.SQL.Add('SELECT TITLE, BASE_PARAM, CODE, DETAILS, ');
    Query.SQL.Add(' WEBGOODSTYPE_TITLE,');
    Query.SQL.Add(' VENDOR,');
    Query.SQL.Add(' IIF(EXISTS(SELECT DESCRIPTIONID FROM TS_GOODS_DESCRIPTIONS WHERE TS_GOODS_DESCRIPTIONS.GOODSID=VW_TS_GOODS.GOODSID AND GET_FLG_VALUE(TS_GOODS_DESCRIPTIONS.FLAGS,0)=1 ),1,0) FLG_HASDESCRIPTIONS,');
    Query.SQL.Add(' IIF(EXISTS(SELECT GOODS_IMAGE_ID FROM TS_GOODS_IMAGE WHERE TS_GOODS_IMAGE.GOODSID=VW_TS_GOODS.GOODSID),1,0) FLG_HASIMAGES');
    Query.SQL.Add('FROM VW_TS_GOODS');
    Query.SQL.Add('WHERE GOODSID=:GOODSID');
    Query.ParamByName('GOODSID').AsInteger := FGoodsID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      mmTITLE.Text := Query.FieldByName('TITLE').AsString;
      edWEBTYPE.Text := Query.FieldByName('WEBGOODSTYPE_TITLE').AsString;
      edVENDOR.Text := Query.FieldByName('VENDOR').AsString;
      edCODE.Text := Query.FieldByName('CODE').AsString;
      edDETAILS.Text := Query.FieldByName('DETAILS').AsString;
//             mmDESCRIPTION.Text:=Query.FieldByName('DESCRIPTION').AsString;
      edBASE_CODE.Text := Query.FieldByName('BASE_PARAM').AsString;
      hasDescriptions := Query.FieldByName('FLG_HASDESCRIPTIONS').AsInteger >= 1;
      hasImages := Query.FieldByName('FLG_HASIMAGES').AsInteger >= 1;
    end;
    Query.Close;

    tbsDescriptions.TabVisible := mmDESCRIPTION.Text <> '';

        // 2. Goods Info
    if hasDescriptions then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('SELECT');
      Query.SQL.Add(' DESCRIPTIONID, FLG_GROUP, FILTERID, FILTERNAME_ROM, FILTERNAME_RUS, FILTERPARAMID, PARAM_VALUE_ROM, PARAM_VALUE_RUS');
      Query.SQL.Add('FROM VW_TS_GOODS_DESCRIPTIONS');
      Query.SQL.Add('WHERE (GOODSID = :GOODSID) AND (FLG_VISIBLE = 1)');
      Query.SQL.Add('ORDER BY ORDERNO');
      Query.ParamByName('GOODSID').AsInteger := FGoodsID;
      Query.ExecSQL;
      while not Query.Eof do
      begin
        descItem := fDescriptions.AddItem;
        descItem.DescriptionID := Query.Fields[0].AsInteger;
        descItem.IsGroup := Query.Fields[1].AsInteger >= 1;
        descItem.FilterID := Query.Fields[2].AsInteger;
        descItem.TitleRom := Query.Fields[3].AsString;
        descItem.TitleRus := Query.Fields[4].AsString;
        descItem.ParamID := Query.Fields[5].AsInteger;
        descItem.ValueRom := Query.Fields[6].AsString;
        descItem.ValueRus := Query.Fields[7].AsString;

        Query.Next;
      end;
      Query.Close;
    end;

    fDescriptions.OptimizeItems;
    DisplayDescriptions;

    tbsFields.TabVisible := fDescriptions.Count > 0;


        // 2. Goods Images
    if hasImages then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('SELECT IMAGE, DATA_START, DATA_END FROM TS_GOODS_IMAGE WHERE GOODSID=:GOODSID ORDER BY ORDERNO');
      Query.ParamByName('GOODSID').AsInteger := FGoodsID;
      Query.ExecSQL;
      while not Query.Eof do
      begin
        MS.Clear;
        TBlobField(Query.FieldByName('IMAGE')).SaveToStream(MS);
        MS.Position := 0;

        IMG := TdxSmartImage.Create;
        IMG.LoadFromStream(MS);

        S := '';
        if (not Query.Fields[1].IsNull) and (not Query.Fields[2].IsNull) then
          S := FormatDateTime('dd mmm yyyy', Query.Fields[1].AsDateTime) + ' - ' + FormatDateTime('dd mmm yyyy', Query.Fields[2].AsDateTime);
        lbImages.Items.AddObject(S, IMG);
        Query.Next;
      end;
      Query.Close;
    end;

    if lbImages.Count > 0 then
    begin
      lbImages.ItemIndex := 0;
      lbImagesClick(lbImages);
      lbImages.Visible := lbImages.Count > 1;
    end
    else
      tbsImages.TabVisible := False;

    if pcPageControl.ActivePageIndex = -1 then
    begin
      pcPageControl.Visible := False;
      lbWarning.Visible := True;
    end;

    IBCQuerySearchkeys.ParamByName('GOODSID').AsInteger := GoodsID;
    IBCQuerySearchkeys.Open;
    if (IBCQuerySearchkeys.RecordCount>0) and (Trim(IBCQuerySearchkeys.FieldbyName('SEARCHKEYS').AsString)<>'') then
      tbsUsedFor.ImageIndex := 0
    else
      tbsUsedFor.ImageIndex := -1;

    IBCQueryGoodsRelatedGoods.Close;
    IBCQueryGoodsRelatedGoods.ParamByName('GOODSID').AsInteger := GoodsID;
    IBCQueryGoodsRelatedGoods.Open;

    tbsRelatedKey.TabVisible := (IBCQueryGoodsRelatedGoods.RecordCount > 0);



  finally
    Query.Free;
    lbImages.Items.EndUpdate;
    cxGridInfoTable.DataController.EndUpdate;
    MS.Free;
  end;
end;

procedure TfrmGoodsQuickInfoDlg.pcPageControlChange(Sender: TObject);
begin
  if pcPageControl.ActivePage = tbsFields then
    cxGridInfo.SetFocus
  else if pcPageControl.ActivePage = tbsImages then
  begin
    if lbImages.Visible then
      lbImages.SetFocus;
  end;
end;

procedure TfrmGoodsQuickInfoDlg.Prepare;
var
  N: integer;
begin
  dtDialogTitle.Text := Format('Informatia despre produsul nr. %d', [FGoodsID]);
  lbImages.ItemHeight := 120; //lbImages.ClientWidth;
  LoadGoodsInfo;

  pnClient.AutoSize := True;
  AutoSize := True;

  N := AppUserTempConfigStorage.IntValues.GetValue('GoodsQuickInfo_LastTabIndex', 1);
  case N of
    0:
      if tbsDescriptions.TabVisible then
        pcPageControl.ActivePage := tbsDescriptions;
    1:
      if tbsFields.TabVisible then
        pcPageControl.ActivePage := tbsFields;
    2:
      if tbsImages.TabVisible then
        pcPageControl.ActivePage := tbsImages;
    3:
      if tbsUsedFor.TabVisible then
        pcPageControl.ActivePage := tbsUsedFor;
    4:
      if tbsRelatedKey.TabVisible then
        pcPageControl.ActivePage  := tbsRelatedKey;
  end;
end;

procedure TfrmGoodsQuickInfoDlg.SetGoodsID(const Value: integer);
begin
  FGoodsID := Value;
end;

procedure TfrmGoodsQuickInfoDlg.SetOnAddGoods2Jurnal(const Value:
    TOnAddGoods2Jurnal);
begin
  FOnAddGoods2Jurnal := Value;
end;

end.

