unit frame105VoltaUnit;

// Volta.md Parser
// Frame Index = 105

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, Vcl.ExtCtrls, DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, Vcl.Menus, cxButtons, MSHTML, cxContainer,
  Vcl.ComCtrls, cxProgressBar, dxUIAClasses;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe105Volta = class(TSWNBaseFrame)
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCSQLGoods: TIBCSQL;
    cxGridVolta: TcxGrid;
    cxGridVoltaDBTableView1: TcxGridDBTableView;
    cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn;
    cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridVoltaLevel1: TcxGridLevel;
    Panel1: TPanel;
    Memo1: TMemo;
    Panel2: TPanel;
    btnStart: TcxButton;
    cbFlgNoImage: TCheckBox;
    cbFlgInPRICE: TCheckBox;
    Label1: TLabel;
    IBCSQLDelete: TIBCSQL;
    cbUpdateAllImages: TCheckBox;
    btnRefresh: TcxButton;
    pbMain: TcxProgressBar;
    lbRecordsNumber: TLabel;
    btnStop: TButton;
    procedure btnStopClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbNoImagesPropertiesChange(Sender: TObject);
    procedure cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private    { Private declarations }
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

    Doc: IHTMLDocument2;
//    d: HTMLLIElement;
    Body: OleVariant;
    StopPress: Boolean;

    procedure LoadDom(htmlcode: string);
    procedure LoadPage(url: string; var HtmlStrings: TStringList);
    procedure StopButtonEnable(AStopState: Boolean);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems; override;

  public    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
    procedure ParseDetailPage(var DescriptionRo: string);
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.IOUtils, System.Variants,
  Winapi.ActiveX, frmVoltaParserUnit, Vcl.WebpImage, Winapi.GDIPOBJ, WebpHelpers, libwebp;

{$R *.dfm}

procedure Tframe105Volta.btnStopClick(Sender: TObject);
begin
  inherited;
  StopButtonEnable(false);
end;

procedure Tframe105Volta.cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  ibcquery1.Close;
//  if cbFlgInPRICE.Checked then begin
//    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := 'AND GET_FLG_VALUE(GF.FLAGS, 3) = 1';
//  end
//  else
//    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := '';
//  ibcquery1.Open;
end;

procedure Tframe105Volta.cbNoImagesPropertiesChange(Sender: TObject);
begin
  inherited;
//  ibcquery1.Close;
//  if cbFlgNoImage.Checked then begin
//    ibcquery1.MacroByName('HasNoImage').Value := 'and not exists(select * from TS_GOODS_IMAGE GI where GI.GOODSID = GF.GOODSID and coalesce(octet_length(GI.IMAGE), 0) > 0)';
//  end
//  else
//    ibcquery1.MacroByName('HasNoImage').Value := '';
//  ibcquery1.Open;
end;

procedure Tframe105Volta.CreateNewRecord;
begin
end;

procedure Tframe105Volta.btnStartClick(Sender: TObject);
var
  aRowIndex: Integer;
  Parser: TVoltaParser;
  url: string;
  ImageStream: TMemoryStream;
  ImagesUrl: TStringList;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  I: Integer;
  imgExt: string;
  pngImage: TPngImage;
  ProductDetailUrl: string;
  webpImage: TWebpImage;
  bmp: TGPBitMap;
  dat: PByte;
  fs: TFileStream;
  GoodsCode: string;
  GoodsID: Integer;
  k: Integer;
begin
  StopButtonEnable(True);

  pbMain.Properties.Max := cxGridVoltaDBTableView1.Controller.SelectedRowCount - 1;
  pbMain.Properties.Min := 0;
  for k := 0 to cxGridVoltaDBTableView1.Controller.SelectedRowCount - 1 do
  begin
    if StopPress then
      break;
    pbMain.Position := k;
    Application.ProcessMessages;
    lbRecordsNumber.Caption := format('[%d din %d]', [k, cxGridVoltaDBTableView1.Controller.SelectedRowCount - 1]);
    aRowIndex := cxGridVoltaDBTableView1.ViewData.Records[cxGridVoltaDBTableView1.Controller.SelectedRecords
      [k].Index].RecordIndex;

    GoodsCode := cxGridVoltaDBTableView1.DataController.Values[aRowIndex,
      cxGridVoltaDBTableView1GOODS_CODE.Index];
    GoodsID := cxGridVoltaDBTableView1.DataController.Values[aRowIndex,
      cxGridVoltaDBTableView1GOODSID.Index];
    url := 'https://volta.md/cautare/' + GoodsCode;
    Parser := TVoltaParser.Create(Self, url);
    ImageStream := TMemoryStream.Create;
    try
      Parser.DoParse;
      ProductDetailUrl := Trim(Parser.ProductDetailUrl);
      ImagesUrl := Parser.ImagesUrl;
      Memo1.Lines.Add(ProductDetailUrl);
      Memo1.Lines.AddStrings(ImagesUrl);
      sleep(Random(6000));
      if (cbUpdateAllImages.Checked and (ImagesUrl.Count - 1 > 0)) then
      begin
      // daca sunt imagini pe site atunci stergem imaginile locale
        Memo1.Lines.Add('delete current images...');
        if not IBCSQLDelete.Transaction.Active then
          IBCSQLDelete.Transaction.StartTransaction;

        ibcsqldelete.SQL.Text := 'delete from ts_goods_image where goodsid = :goodsid';
        ibcsqldelete.ParamByName('goodsid').AsInteger := GoodsID;
        ibcsqlDelete.Execute;

        ibcsqldelete.SQL.Text := 'delete from ts_goods_dsc where goodsid = :goodsid';
        ibcsqldelete.ParamByName('goodsid').AsInteger := GoodsID;
        ibcsqlDelete.Execute;

        ibcsqlDelete.Transaction.Commit;
      end;

      for I := 0 to ImagesUrl.Count - 1 do
      begin
      // convert image to png
        pngImage := TPngImage.Create;
        jpegImage := TJPEGImage.Create;
        webpImage := TWebpImage.Create(Panel2);
//
        try
          if ImagesUrl[I] <> '' then
          begin
            NetHTTPClient1.Get(ImagesUrl[I], ImageStream);
            Application.ProcessMessages;

            ImageStream.Position := 0;
            {$REGION 'Save image to PNG file' }
            imgExt := TPath.GetExtension(ImagesUrl[I]).tolower;
            if (imgExt = '.jpeg') or (imgExt = '.jpg') then
            begin
              try
                ImageStream.SaveToFile('tmp.jpeg');
                jpegImage := TJPEGImage.Create;
                jpegImage.loadfromFile('tmp.jpeg');
              except
                on e: Exception do
                begin
                  IBCQuery1.Next;
                  Continue;
                end;
              end;
            end
            else if imgExt = '.png' then
            begin
              ImageStream.SaveToFile('tmp.png');
              pngImage.loadfromFile('tmp.png');
            end
            else if imgExt = '.webp' then
            begin
              try
                ImageStream.SaveToFile('tmp.webp');
                fs := TFileStream.Create('tmp.webp', fmOpenRead);
                WebpDecode(ImageStream, dat, bmp);
                bmp.Save('tmp.png', gPNG);
              finally
                bmp.Free;
                WebPFree(dat);
                fs.Free;
              end;
            end;
            {$ENDREGION}

//            bmpImage := TBitMap.Create;
//            try
//              bmpImage.Assign(jpegImage);
//              try
//                if (imgExt = '.jpeg') or (imgExt = '.jpg') then
//                begin
//                  pngImage.Assign(bmpImage);
//                  pngImage.SaveToFile('tmp.png');
//                end;
//              except
//              end;
//            finally
//              bmpImage.Free;
//            end;

            if not IBCtrLocalUpdate.Active then
              IBCtrLocalUpdate.StartTransaction;
            try
              IBCSQL1.ParamByName('GOODSID').AsInteger := GoodsID;
              IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
              IBCSQL1.Execute;
              IBCtrLocalUpdate.Commit;
              DeleteFile('tmp.png');
            except
              begin
                IBCtrLocalUpdate.Rollback;
                DeleteFile('tmp.png');
              end;
            end;
          end;
        finally
          FreeAndNil(jpegImage);
          FreeAndNil(pngImage);
        end;
      end;

      if ProductDetailUrl <> '' then
      begin
        Parser.DoParseDetailPageRO(ProductDetailUrl);
        ProductDetailUrl := StringReplace(ProductDetailUrl, 'https://volta.md',
          'https://volta.md/ru', []);
        Parser.DoParseDetailPageRU(ProductDetailUrl);
        if (Trim(Parser.DescriptionRo) <> '') or (Trim(Parser.DescriptionRu) <> '')then
        begin
          if not IBCtrLocalUpdate.Active then
            IBCtrLocalUpdate.StartTransaction;
          try
            IBCSQLGoods.ParamByName('GOODSID').AsInteger := GoodsID;
            IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := UTF8ToString(Parser.DescriptionRO);
            IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := UTF8ToString(Parser.DescriptionRU);
            Memo1.Lines.Add('Descrierea in romana...........');
            Memo1.Lines.Add(UTF8ToString(Parser.DescriptionRO));
            Memo1.Lines.Add('Descrierea in rusa..............');
            Memo1.Lines.Add(UTF8ToString(Parser.DescriptionRU));
            IBCSQLGoods.Execute;
            IBCtrLocalUpdate.Commit;
          except
            IBCtrLocalUpdate.Rollback;
          end;
        end;
      end
      else
        Memo1.Lines.Add('Product: ' + GoodsCode + '-' + cxGridVoltaDBTableView1.DataController.Values
          [aRowIndex, cxGridVoltaDBTableView1_GOODS_TITLE.Index] + ' not found on www.volta.md...');
    finally
      Application.ProcessMessages;
      FreeAndNil(ImageStream);
      FreeAndNil(Parser);
    end;
    Memo1.Lines.Add('------------------------------------------');
  end;
end;

procedure Tframe105Volta.btnRefreshClick(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgNoImage.Checked then
    IBCQuery1.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  else
    IBCQuery1.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then
    IBCQuery1.MacroByName('FlgInPrice').Value := ' and get_flg_in_price(gf.goodsid)=1'
  else
    IBCQuery1.MacroByName('FlgInPrice').Value := '';

  ibcquery1.Open;
end;

procedure Tframe105Volta.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe105Volta.DeleteRecord;
begin
end;

procedure Tframe105Volta.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe105Volta.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  IBCQuery1.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;
end;

function Tframe105Volta.GetCurrentSearchContext: TSearchContextValue;
begin
end;

function Tframe105Volta.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe105Volta.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
end;

function Tframe105Volta.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

procedure Tframe105Volta.GetParamsListForReport(const ParamsList: TStringList);
begin
//    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe105Volta.GetParamValueForReport(const ParamName: string): Variant;
begin
//    if ParamName = 'FAST_MONEY_TRANSFER' then
//    begin
//        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
//            Result := '1'
//        else
//            Result := '0';
//    end;
end;

procedure Tframe105Volta.LoadDom(htmlcode: string);
var
  v: OleVariant;
begin
  Doc := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  Doc.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := htmlcode;
  Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  Body := Doc.body;
end;

procedure Tframe105Volta.LoadPage(URL: string; var HtmlStrings: TStringList);
var
  MS: TMemoryStream;
//  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.GET(URL, MS);
    MS.Position := 0;
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    FreeAndNil(NetHTTPClient);
  end;
end;

function Tframe105Volta.GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
var
//  detail: TProductDetailInfo;
  htmlbody: TStringList;
begin
  htmlbody := TStringList.Create;
  try
    LoadPage(ProductDetailUrl, htmlbody);
    LoadDom(htmlbody.Text);
    ParseDetailPage(result.DescriptionRo);
  finally
    htmlbody.Free;
  end;
end;

function Tframe105Volta.InitFrameID: Integer;
begin
  Result := 105;
end;

procedure Tframe105Volta.ModifyRecord;
begin
end;

procedure Tframe105Volta.ParseDetailPage(var DescriptionRo: string);
var
//  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  cc: Integer;
//  dd: IHTMLElement;
  i: Integer;
  s: string;
  j: Integer;
//  cnt: Integer;
begin
  allDivs := Body.All.Tags('div');
  s := '';
//  ImagePath := '';
  for j := 0 to allDivs.Length - 1 do
  begin
    cc := 0;
    if (allDivs.item(j).ClassName = 'sidebar-right') then
    begin
      Elements := allDivs.item(j).getElementsByTagName('div');
//      cnt := Elements.Length - 1;
      for i := 0 to (Elements.Length - 1) do
      begin
//        // get imagelink
//        if (Elements.item(i).ClassName = 'img_link') then begin
//          aHrefTags := Elements.item(i).getElementsByTagName('a');
//          if aHrefTags.Length > 0 then begin
//            s := aHrefTags.item(0).href;
//            ProductDetailUrl := s;
//          end;
//
//          aHrefTags := Elements.item(i).getElementsByTagName('img');
//          if aHrefTags.Length > 0 then begin
//            s := aHrefTags.item(0).href;
//            s := Copy(s, pos('&image=', s) + 7, length(s));
//            s := 'https://muncitorul.md' + s;
//            ImagePath := s;
//          end;
//        end;
        // DescriptionRO
        s := Elements.item(i).id;
        if (Elements.item(i).id = 'item_view_desc') then
        begin

          if (cc > 0) then
            DescriptionRo := Elements.item(i).InnerText;
          Inc(cc);
        end;
      end;
    end;
  end;
end;

procedure Tframe105Volta.StopButtonEnable(AStopState: Boolean);
begin
  StopPress := not AStopState;
  btnStart.Enabled := not AStopState;
  btnRefresh.Enabled := not AStopState;
  btnStop.Enabled := AStopState;
end;

procedure Tframe105Volta.ReadFrameStates;
begin
end;

procedure Tframe105Volta.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe105Volta.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;
end;

procedure Tframe105Volta.SetupSecurityItems;
begin
  inherited;
end;

end.

