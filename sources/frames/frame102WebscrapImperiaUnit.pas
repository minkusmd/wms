unit frame102WebscrapImperiaUnit;

// imperia.md Parser
// Frame Index = 102

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB,
  cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls,
  DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, dxBarBuiltInMenu,
  MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.Menus, cxButtons,
  MSHTML, Vcl.ComCtrls, dxUIAClasses;

  const
    SupplierID = 74852;

type
  Tframe102WebScrapImperia = class(TSWNBaseFrame)
    dxBarManager1: TdxBarManager;
    cxGridPopupMenu: TcxGridPopupMenu;
    pmPopupMenuDoc: TdxBarPopupMenu;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    bbDocComments: TdxBarButton;
    bbCustomerDebts: TdxBarButton;
    dxBarButton1: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    btnStart: TcxButton;
    cbFlgNoImage: TCheckBox;
    cbFlgInPRICE: TCheckBox;
    cbUpdateAllImages: TCheckBox;
    cxButton3: TcxButton;
    ProgressBar1: TProgressBar;
    cxGridMuncitorulGoods: TcxGrid;
    cxGridMuncitorulGoodsDBTableView1: TcxGridDBTableView;
    cxGridMuncitorulGoodsDBTableView1GOODSID: TcxGridDBColumn;
    cxGridMuncitorulGoodsDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridMuncitorulGoodsDBTableView1GOODSNAME: TcxGridDBColumn;
    cxGridMuncitorulGoodsLevel1: TcxGridLevel;
    btnStop: TcxButton;
    procedure cxGridMuncitorulGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnStartClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure SaveImageToDB(ImageURL: string);


  protected    { Protected declarations }
    Doc: IHTMLDocument2;
//    Body: OleVariant;
//    HttpClient: THTTPClient;
    htmlSource: TStringList;
    FDocumentProductPage: IHTMLDocument2;
    FDocumentBody: OleVariant;

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
    procedure DoParse(ProductCode: string);
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors,
  SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, System.IOUtils, parser,
  Winapi.ActiveX;

{$R *.dfm}

procedure Tframe102WebScrapImperia.btnStopClick(Sender: TObject);
begin
  inherited;
  btnStop.Enabled := false;
end;

procedure Tframe102WebScrapImperia.CreateNewRecord;
begin
end;

procedure Tframe102WebScrapImperia.DoParse(ProductCode: string);
var
  ms: TMemoryStream;
  vs, vp: OleVariant;
  alldivs: OleVariant;
  cc: Integer;
  el2: OleVariant;
  elements: OleVariant;
  I: Integer;
  ImageList: TStringList;
  j: Integer;
  ProductUrl: string;
  s: string;
  k: Integer;
  ProductDescription: string;
  ProductPageURL: string;
begin
  ms := TMemoryStream.Create;
  try
    NetHTTPClient1.Get(format('https://imperia.md/ro/search/?search=%s', [ProductCode]), ms);
    ms.Position := 0;
    htmlSource.LoadfromStream(ms);
  finally
    ms.free;
  end;

  FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  FDocumentProductPage.designMode := 'on';
  vs := VarArrayCreate([0, 0], varVariant);
  vs[0] := htmlSource.Text;
  FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
  FDocumentBody := FDocumentProductPage.body;

  alldivs := FDocumentBody.All.Tags('div');
  for j := 0 to alldivs.Length - 1 do begin
    if string(alldivs.item(j).ClassName).Contains('product-thumb transition') then begin
      elements := alldivs.item(j).getElementsByTagName('a');
      if elements.Length > 0 then begin
        ProductPageURL := elements.item(0).href;
        Memo1.Lines.Add(ProductPageURL);
        Application.ProcessMessages;
        Break;
      end;
    end;
  end;

  // product detail page
  if (ProductPageURL <> '') then begin
    ms := TMemoryStream.Create;
    try
  //    NetHTTPClient1.Get('https://lumeainstrumentelor.md/hecht-1289-masina-de-gaurit-cu-acumulator.html?search_query=HECHT+1289&results=1', ms);
      NetHTTPClient1.Get(ProductPageURL, ms);
      ms.Position := 0;
      htmlSource.LoadfromStream(ms);
    finally
      ms.free;
    end;
    FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    FDocumentProductPage.designMode := 'on';
    vp := VarArrayCreate([0, 0], varVariant);
    vp[0] := htmlSource.Text;
    FDocumentProductPage.Write(PSafeArray(TVarData(vp).VArray)); // write data from IdHTTP
    FDocumentBody := FDocumentProductPage.body;

    alldivs := FDocumentBody.All.Tags('div');
    s := '';
    for j := 0 to alldivs.Length - 1 do begin
      cc := 0;
      if (alldivs.item(j).ClassName = 'main-img') then begin
        el2 := alldivs.item(j).getElementsByTagName('img');
        ImageList := TStringList.create;
        try
//          for I := 0 to el2.Length - 1 do begin
//            if el2.item(I).ClassName = 'thumbnail' then begin
              ImageList.Add(UTF8Encode(el2.item(0).src));
              Memo1.Lines.add(UTF8Encode(el2.item(0).src));
              SaveImageToDB(UTF8Encode(el2.item(0).src));
//              Break;
//            end;
//          end;
        finally
          ImageList.Free;
        end;
        Break;
      end;

    end;

//    alldivs := FDocumentBody.All.Tags('div');
//    for I := 0 to alldivs.length - 1 do begin
//      if string(alldivs.item(I).ID).contains('tab-specification') then begin
//        ProductDescription := UTF8Decode(alldivs.item(I).InnerHTML);
//        Break;
//      end;
//    end;
//    Memo1.Lines.Add(ProductDescription);
//    SaveDescriptionToDB(ProductDescription, ProductDescription);
  end
  else begin
    Memo1.Lines.Add('No information for goods: '+ProductCode);
  end;
end;

procedure Tframe102WebScrapImperia.SaveImageToDB(ImageURL: string);
var
  imagePath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  imgExt: string;
  pngImage: TPngImage;
begin
  ImageStream := TMemoryStream.Create;
  pngImage := TPngImage.Create;
  jpegImage := TJPEGImage.Create;

  imagePath := Trim(ImageURL);
  try
    if imagePath <> '' then begin
      NetHTTPClient1.Get(imagePath, ImageStream);
      Application.ProcessMessages;

      ImageStream.Position := 0;
      imgExt := TPath.GetExtension(imagePath);
      if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
        try
          ImageStream.SaveToFile('tmp.jpeg');
          jpegImage.loadfromFile('tmp.jpeg');
        except
          on e: Exception do begin
            IBCQueryGoods.Next;
            Memo1.Lines.Add(E.Message);
          end;
        end;
      end;

      if imgExt = '.png' then begin
        ImageStream.SaveToFile('tmp.png');
        pngImage := TPngImage.Create;
        pngImage.loadfromFile('tmp.png');
      end;

      bmpImage := TBitMap.Create;
      try
        bmpImage.Assign(jpegImage);
        try
          if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
            pngImage.Assign(bmpImage);
            pngImage.SaveToFile('tmp.png');
          end;
        except
          on e: Exception do begin
            Memo1.Lines.Add(e.Message);
          end;
        end;
      finally
        bmpImage.Free;
      end;

      if not IBCtrLocalUpdate.Active then
        IBCtrLocalUpdate.StartTransaction;
      try
        IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').ASInteger;
        IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
        IBCSQL1.Execute;
        IBCtrLocalUpdate.Commit;
        DeleteFile('tmp.png');
      except
        on e: Exception do begin
          Memo1.LInes.Add(e.Message);
          IBCtrLocalUpdate.Rollback;
        end;
      end;
    end;
  finally
    Application.ProcessMessages;
    FreeAndNil(jpegImage);
    FreeAndNil(pngImage);
    ImageStream.Free;
  end;
end;



procedure Tframe102WebScrapImperia.btnStartClick(Sender: TObject);
var
  url: string;
  ImageStream: TMemoryStream;
  ImagePath: string;
  jpegImage: TJpegImage;
  bmpImage: TBitMap;
  imgExt: string;
  pngImage: TpngImage;
begin
//  IBCQueryGoods.First;
  btnStop.Enabled := True;
  btnStart.Enabled := False;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := ibcquerygoods.RecordCount - 1;
  try
  while not IBCQueryGoods.Eof and btnStop.Enabled do begin
    url := 'https://imperia.md/ro/search/?search=' + IBCQueryGoods.FieldByName('GOODS_CODE').AsString;
    try
      DoParse(IBCQueryGoods.FieldByName('GOODS_CODE').AsString);
    except
      Memo1.Lines.Add('Error parsing goods: '+IBCQueryGoods.FieldByName('GOODS_CODE').AsString);
    end;
    IBCQueryGoods.Next;
    ProgressBar1.Position := ibcquerygoods.RecNo;
    Application.ProcessMessages;
  end;
  finally
    btnStop.Enabled := false;
    btnStart.Enabled := True;
  end;
end;

procedure Tframe102WebScrapImperia.cxButton3Click(Sender: TObject);
begin
  inherited;
  IBCQueryGoods.Close;
  if cbFlgNoImage.Checked then begin
    IBCQueryGoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    IBCQueryGoods.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then begin
    IBCQueryGoods.MacroByName('FlgInPrice').Value := ' and get_flg_value(flags,3)=1'
  end
  else
    IBCQueryGoods.MacroByName('FlgInPrice').Value := '';

  IBCQueryGoods.ParamByName('supplierid').AsInteger := SupplierID;
  IBCQueryGoods.Open;
end;

procedure Tframe102WebScrapImperia.cxGridMuncitorulGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridMuncitorulGoodsDBTableView1, Key, Shift);
end;

procedure Tframe102WebScrapImperia.DeleteRecord;
begin
end;

procedure Tframe102WebScrapImperia.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQueryGoods.Close;

  inherited;
end;

procedure Tframe102WebScrapImperia.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  IBCQueryGoods.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  SelectionChanged;

  Memo1.Lines.Clear;
  htmlSource := TStringList.Create;
end;

function Tframe102WebScrapImperia.GetCurrentSearchContext: TSearchContextValue;
begin
end;

function Tframe102WebScrapImperia.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe102WebScrapImperia.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
end;

function Tframe102WebScrapImperia.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

procedure Tframe102WebScrapImperia.GetParamsListForReport(const ParamsList: TStringList);
begin
//    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe102WebScrapImperia.GetParamValueForReport(const ParamName: string): Variant;
begin
//    if ParamName = 'FAST_MONEY_TRANSFER' then
//    begin
//        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
//            Result := '1'
//        else
//            Result := '0';
//    end;
end;

function Tframe102WebScrapImperia.InitFrameID: Integer;
begin
  Result := 102;
end;

procedure Tframe102WebScrapImperia.ModifyRecord;
begin
end;

procedure Tframe102WebScrapImperia.WhenPopupMenuPopup;
begin

end;

procedure Tframe102WebScrapImperia.ReadFrameStates;
begin
end;

procedure Tframe102WebScrapImperia.RefreshData;
begin
  inherited;
  IBCQueryGoods.Refresh;
end;

procedure Tframe102WebScrapImperia.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;
end;

procedure Tframe102WebScrapImperia.SelectionChanged;
var
  fDocNew, fDocModify, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin
  fDocNew := fSYS_Add;     // New Document + Security
  fDocModify := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fCalcComs := False;

  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocModify);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbProvesti.Enabled := fCloseDoc;
  bbCancelProvodca.Enabled := fOpenDoc;
end;

procedure Tframe102WebScrapImperia.SetupSecurityItems;
begin
  inherited;
end;

procedure Tframe102WebScrapImperia.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.

