unit frmPricelistImportUnit;

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
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  dxCoreClasses,
  dxHashUtils,
  dxSpreadSheetCore,
  dxSpreadSheetCoreFormulas,
  dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles,
  dxSpreadSheetCoreStrs,
  dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetClasses,
  dxSpreadSheetContainers,
  dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions,
  dxSpreadSheetStyles,
  dxSpreadSheetGraphics,
  dxSpreadSheetPrinting,
  dxSpreadSheetUtils,
  dxSpreadSheetFormattedTextUtils,
  dxBarBuiltInMenu,
  dxSpreadSheetFormulaBar,
  dxSpreadSheet,
  cxButtonEdit,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  dxCustomWizardControl,
  dxWizardControl,
  Vcl.Menus,
  cxButtons,
  DBAccess,
  IBC,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Data.DB,
  cxDBData,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  MemDS,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxProgressBar,
  dxScrollbarAnnotations,
  dxBar,
  cxDBEdit,
  Vcl.Clipbrd,
  dxStatusBar,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  dxSpreadSheetTypes,
  dxUIAClasses;

type
  TfrmPriceListImportDlg = class(TSWNBaseFormClass)
    dxWizardControl1: TdxWizardControl;
    dxWizardControlPage1: TdxWizardControlPage;
    Panel1: TPanel;
    Label1: TLabel;
    cxDateEdit1: TcxDateEdit;
    Panel2: TPanel;
    dxSpreadSheet1: TdxSpreadSheet;
    dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar;
    dxWizardControlPage2: TdxWizardControlPage;
    IBCTrWrite: TIBCTransaction;
    IBCQueryImportedGoods: TIBCQuery;
    IBCDataSourceImportedGoods: TIBCDataSource;
    cxProgressBar1: TcxProgressBar;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbOpenFile: TdxBarButton;
    bbSave: TdxBarButton;
    Label3: TLabel;
    teMentiuni: TcxTextEdit;
    dxBarButton1: TdxBarButton;
    dxStatusBar1: TdxStatusBar;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    bbCurrencyRRP: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    procedure dxWizardControl1ButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure dxWizardControl1PageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
    procedure bbSaveClick(Sender: TObject);
    procedure bbOpenFileClick(Sender: TObject);
    procedure bbCurrencyRRPClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);

  private
    { Private declarations }
    fPLID: Integer;
    FPriceCategoryID: Integer;
    procedure SetPriceCategoryID(const Value: Integer);
    procedure UpdateCurrencyName(AColumnIndex: Integer; DefaultCurrencyName: string);
    procedure ImportJsonToDxSpreadSheet;
  protected
    procedure PopulateSpreadSheet;
    procedure AddToDB;
    { Protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure PrepareStep1;
    function ValidateData: Boolean;
  public
    SupplierID: Integer;
    SupplierName: string;
    Mentiuni: string;
    property PriceCategoryID: Integer read FPriceCategoryID write SetPriceCategoryID;
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions,
  DataModuleDB,
  SWNUtils,
  SWNValueStorageUnit,
  frmCustomersDlg,
  frmImportPricelistErrorUnit,
  System.JSON,
  System.Math,
  System.UITypes,
  System.IOUtils;

{$R *.dfm}

procedure TfrmPriceListImportDlg.bbCurrencyRRPClick(Sender: TObject);
begin
  UpdateCurrencyName(4, 'MDL');
end;

procedure TfrmPriceListImportDlg.bbOpenFileClick(Sender: TObject);
var
  dialog: TOpenDialog;
begin
  dialog := TOpenDialog.Create(self);
  dialog.DefaultExt := 'xlsx';
  try
    if dialog.Execute then
    begin
      dxSpreadSheet1.LoadFromFile(dialog.FileName);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPriceListImportDlg.bbSaveClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  dialog := TSaveDialog.Create(self);
  dialog.DefaultExt := 'xlsx';
  try
    if dialog.Execute then
    begin
      dxSpreadSheet1.SaveToFile(dialog.FileName);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPriceListImportDlg.dxBarButton2Click(Sender: TObject);
begin
  UpdateCurrencyName(6, 'USD');
end;

procedure TfrmPriceListImportDlg.dxBarButton3Click(Sender: TObject);
begin
  inherited;
  ImportJsonToDxSpreadSheet;
end;

procedure TfrmPriceListImportDlg.ImportJsonToDxSpreadSheet;
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  JSONObj, CaractObj: TJSONObject;
  ImgArray: TJSONArray;
  Sheet: TdxSpreadSheetTableView;
  I, J, RowIndex: Integer;
  ImgUrls, InStockStr: string;
  AJsonString: string;
begin
  var d:=TOpenDialog.Create(self);

  try
    if d.Execute then
    begin
      if TFile.Exists(d.filename) then
      begin
    // Citim fișierul. TEncoding.UTF8 este recomandat, mai ales pentru JSON-uri.
        AJsonString := TFile.ReadAllText(d.filename, TEncoding.UTF8);

    // Aici poți folosi variabila Continut
    // ShowMessage(Continut);
      end;
    end;
  finally
    d.free;
  end;

  // 1. Parsăm string-ul JSON
  JSONValue := TJSONObject.ParseJSONValue(AJsonString);
  if not Assigned(JSONValue) then
    raise Exception.Create('Format JSON invalid.');

  try
    // Verificăm dacă avem un Array de obiecte sau un singur Obiect
    if JSONValue is TJSONArray then
      JSONArray := JSONValue as TJSONArray
    else if JSONValue is TJSONObject then
    begin
      JSONArray := TJSONArray.Create;
      JSONArray.AddElement(JSONValue.Clone as TJSONObject);
    end
    else
      raise Exception.Create('Structură JSON nesuportată. Se așteaptă Array sau Object.');

    try
      // 2. Pregătim documentul TdxSpreadSheet
      dxSpreadSheet1.ClearAll;
      Sheet := dxSpreadSheet1.ActiveSheetAsTable;

      // 3. Setăm antetul (Capul de tabel)
//      Sheet.Cells[0, 1].AsString := 'Articol';
//      Sheet.Cells[0, 2].AsString := 'Denumire';
//
//      Sheet.Cells[0, 2].AsString := 'Preț';
//      Sheet.Cells[0, 3].AsString := 'Preț Vechi';
//      Sheet.Cells[0, 4].AsString := 'În Stoc?';

      // Facem antetul Bold
//      for I := 0 to 9 do
//        Sheet.Cells[0, I].Style.Font.Style := [fsBold];

      // 4. Populăm rândurile cu datele din JSON
      RowIndex := 1;
      for I := 0 to JSONArray.Count - 1 do
      begin
        JSONObj := JSONArray.Items[I] as TJSONObject;

        // Câmpuri text simple
        Sheet.Cells[RowIndex, 1].AsString := JSONObj.GetValue<string>('articol', '');
        Sheet.Cells[RowIndex, 2].AsString := JSONObj.GetValue<string>('denumire', '');
        Sheet.Cells[RowIndex, 4].AsString := JSONObj.GetValue<string>('pret_nou', '0');
        Sheet.Cells[RowIndex, 5].AsString := '498';


        // Câmp boolean
        if JSONObj.GetValue<Boolean>('in_stock', False) then
          InStockStr := 'Da'
        else
          InStockStr := 'Nu';
//        Sheet.Cells[RowIndex, 4].AsString := InStockStr;
//
//        Sheet.Cells[RowIndex, 5].AsString := JSONObj.GetValue<string>('stoc_text', '');

        // Sub-obiectul "caracteristici"
//        if JSONObj.TryGetValue<TJSONObject>('caracteristici', CaractObj) then
//        begin
//          Sheet.Cells[RowIndex, 6].AsString := CaractObj.GetValue<string>('Dimensiuni', '');
//          Sheet.Cells[RowIndex, 7].AsString := CaractObj.GetValue<string>('Color', '');
//        end;
//
//        // Array-ul "url_imagini"
//        ImgUrls := '';
//        if JSONObj.TryGetValue<TJSONArray>('url_imagini', ImgArray) then
//        begin
//          for J := 0 to ImgArray.Count - 1 do
//          begin
//            if ImgUrls <> '' then
//              ImgUrls := ImgUrls + #13#10; // Le separăm pe rânduri noi în aceeași celulă
//            ImgUrls := ImgUrls + ImgArray.Items[J].Value;
//          end;
//        end;
//        Sheet.Cells[RowIndex, 8].AsString := ImgUrls;
        // Setăm WrapText pentru a afișa imaginile una sub alta în celulă
//        Sheet.Cells[RowIndex, 8].Style.DataFormat.WrapText := True;

        // URL Produs
//        Sheet.Cells[RowIndex, 9].AsString := JSONObj.GetValue<string>('url_produs', '');

        Inc(RowIndex);
      end;

      // Auto-fit la coloane pentru un aspect mai curat
      for I := 0 to 9 do
        Sheet.Columns[I].ApplyBestFit;

    finally
      // Dacă am creat un TJSONArray temporar pentru un singur obiect, îl eliberăm
      if JSONValue is TJSONObject then
        JSONArray.Free;
    end;

  finally
    JSONValue.Free;
  end;
end;

procedure TfrmPriceListImportDlg.dxWizardControl1ButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var
  AHandled: Boolean);
begin
  case AKind of
    wcbkNext:
      begin
        if SupplierID <= 0 then
        begin
          AHandled := False;
          MessageDlg('Nu este ales furnizorul!', mtError, [mbClose], 0);
        end
        else
        begin
//          bbSaveClick(Sender);
          PrepareStep1;
          dxSpreadSheet1.SaveToFile('last_imported_pricelist.xlsx');
        end;
      end;
    wcbkCancel:
      begin
        AHandled := True;
        ModalResult := mrCancel;
      end;
    wcbkFinish:
      begin
        AHandled := True;
        ModalResult := mrOK;
      end;
  end;
end;

procedure TfrmPriceListImportDlg.dxWizardControl1PageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var
  AAllow: Boolean);
begin

  case ANewPage.PageIndex of
    0:
      AAllow := True;
    1:
      begin
        AAllow := False;
        cxProgressBar1.Visible := True;
        cxProgressBar1.Properties.Marquee := True;
        cxProgressBar1.Properties.BarStyle := cxbsAnimationLEDs;
        cxProgressBar1.Properties.AnimationPath := cxapCycle;
        cxProgressBar1.Properties.AnimationSpeed := 5;
        if ValidateData then
        begin
          AddToDB;
          AAllow := True;
        end;
        cxProgressBar1.Properties.Marquee := False;
        cxProgressBar1.Visible := True;
      end;
  end;
end;

function TfrmPriceListImportDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
end;

procedure TfrmPriceListImportDlg.PopulateSpreadSheet;
var
  ATable: TdxSpreadSheetTableView;
begin
  ATable := dxSpreadSheet1.ActiveSheetAsTable;

  with ATable.CreateCell(0, 0) do
  begin
    AsString := 'CPF';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 120;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 1) do
  begin
    AsString := 'Denumire produs';
    Column.Style.AlignHorz := ssahLeft;
    Column.Size := 450;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 2) do
  begin
    AsString := 'Pret 0';
    Column.Style.AlignHorz := ssahRight;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 3) do
  begin
    AsString := 'Pret Vinz.';
    Column.Style.AlignHorz := ssahRight;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 4) do
  begin
    AsString := 'Val. Vinz.';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 62;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 5) do
  begin
    AsString := 'Pret 7';
    Column.Style.AlignHorz := ssahRight;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 6) do
  begin
    AsString := 'Val. 7';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 62;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 7) do
  begin
    AsString := 'Disp';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 50;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 8) do
  begin
    AsString := 'Garantie';
    Column.Size := 60;
    Column.Style.AlignHorz := ssahRight;
    Style.Font.Style := [fsBold];
  end;
   // brand
  with ATable.CreateCell(0, 9) do
  begin
    AsString := 'Producator';
    Column.Size := 100;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;
   // model
  with ATable.CreateCell(0, 10) do
  begin
    AsString := 'Model';
    Column.Size := 120;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;
   // Tip produs
  with ATable.CreateCell(0, 11) do
  begin
    AsString := 'Categorie';
    Column.Size := 120;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;

   // Tip produs
  with ATable.CreateCell(0, 12) do
  begin
    AsString := 'Product link';
    Column.Size := 100;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 13) do
  begin
    AsString := 'Caracteristici / descriere';
    Column.Size := 200;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;
  with ATable.CreateCell(0, 14) do
  begin
    AsString := 'COMPATIBILITATE';
    Column.Size := 300;
    Column.Style.AlignHorz := ssahLeft;
    Style.Font.Style := [fsBold];
  end;
  with ATable.CreateCell(0, 15) do
  begin
    AsString := 'TVA';
    Column.Size := 60;
    Column.Style.AlignHorz := ssahCenter;
    Style.Font.Style := [fsBold];
  end;

  ATable.Selection.FocusedColumn := 0;
  ATable.Selection.FocusedRow := 1;

  cxDateEdit1.Date := Now;
end;

procedure TfrmPriceListImportDlg.AddToDB;
var
  ATable: TdxSpreadSheetTableView;
  ErrorStr: TStringList;
  ibcsql: TIBCSQL;
  Query: TIBCQuery;
  I: Integer;
  len: Integer;
  s: string;
  supplier_goods_code: string;
begin
   //  Populate ts_pricelist
  Query := TIBCQuery.Create(Self);
  ibcsql := TIBCSQL.Create(Self);
  ErrorStr := TStringList.Create;
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrWrite;
    Query.AutoCommit := False;
    Query.CachedUpdates := True;

    if not IBCTrWrite.Active then
      IBCTrWrite.StartTransaction;

    Query.SQL.Clear;
    Query.SQL.Add('select plid from sp_add_pricelist(:supplierid, :price_categoryid, :data, :mentiuni)');
    Query.ParamByName('supplierid').AsInteger := SupplierID;
    Query.ParamByName('price_categoryid').AsInteger := PriceCategoryID;
    Query.ParamByName('Data').AsDateTime := cxDateEdit1.Date;
    Query.ParamByName('mentiuni').AsString := teMentiuni.Text;
    Query.Open;
    fPLID := Query.FieldByName('PLID').AsInteger;

    ATable := dxSpreadSheet1.ActiveSheetAsTable;

    ibcsql.Transaction := IBCTrWrite;
    ibcsql.DescribeParams := True;
    ibcsql.AutoCommit := False;
    ibcsql.SQL.Clear;
    ibcsql.sql.add('insert into TS_PRICELIST_ITEMS (PLID,');
    ibcsql.sql.add('SUPPLIER_GOODS_CODE,');
    ibcsql.sql.add('GOODSID,');
    ibcsql.sql.add('SUPPLIER_GOODS_NAME,');
    ibcsql.sql.add('STOCK_QTY,');
    ibcsql.sql.add('FLAGS,');
    ibcsql.sql.add('PRICE3,');
    ibcsql.sql.add('CURRENCY3ID,');
    ibcsql.sql.add('PRICE0,');
    ibcsql.sql.add('CURRENCY0ID,');
    ibcsql.sql.add('PRICE7,');
    ibcsql.sql.add('CURRENCY7ID,');
    ibcsql.sql.add('WARANTY,');
    ibcsql.sql.add('supplier_goods_BRAND,');
    ibcsql.sql.add('supplier_goods_MODEL,');
    ibcsql.sql.add('COMPATIBILITATE,');
    ibcsql.sql.add('supplier_category,');

//        ibcsql.sql.add('GOODSTYPEID,');
//        ibcsql.sql.add('VENDOR_NAME,');
    ibcsql.sql.add('PRODUCT_LINK,');
//        ibcsql.sql.add('DESCRIERE)');
    ibcsql.sql.add('tva)');

    ibcsql.sql.add('values (:PLID,');
    ibcsql.sql.add(':SUPPLIER_GOODS_CODE,');
    ibcsql.sql.add(':GOODSID,');
    ibcsql.sql.add(':SUPPLIER_GOODS_NAME,');
    ibcsql.sql.add(':STOCK_QTY,');
    ibcsql.sql.add(':FLAGS,');
    ibcsql.sql.add(':PRICE3,');
    ibcsql.sql.add(':CURRENCY3ID,');
    ibcsql.sql.add(':PRICE0,');
    ibcsql.sql.add(':CURRENCY0ID,');
    ibcsql.sql.add(':PRICE7,');
    ibcsql.sql.add(':CURRENCY7ID,');
    ibcsql.sql.add(':WARANTY,');
    ibcsql.sql.add(':SUPPLIER_GOODS_BRAND,');
    ibcsql.sql.add(':SUPPLIER_GOODS_MODEL,');
    ibcsql.sql.add(':COMPATIBILITATE,');
    ibcsql.sql.add(':SUPPLIER_CATEGORY,');
    ibcsql.sql.add(':PRODUCT_LINK,');
    ibcsql.sql.add(':TVA)');

    ibcsql.Transaction := IBCTrWrite;

    if not IBCTrWrite.Active then
      IBCTrWrite.StartTransaction;

    ibcsql.Prepare;
    ErrorStr.Clear;
    for I := 1 to ATable.Rows.Count - 1 do
    begin
      with ibcsql do
      begin
        ParamByName('PLID').AsInteger := fPLID;
        if Assigned(ATable.Cells[I, 0]) then
        begin
          supplier_goods_code := ATable.Cells[I, 0].DisplayText;
          ParamByName('SUPPLIER_GOODS_CODE').AsString := supplier_goods_code;
        end;

        s := '';
        if Assigned(ATable.Cells[I, 1]) then
        begin

          if ATable.Cells[I, 1].AsString <> '' then
            s := Split(ATable.Cells[I, 1].AsString, char($A))[0]
          else
            s := '';

          if Trim(s) <> '' then
            s := ATable.Cells[I, 1].AsString;

          ParamByName('SUPPLIER_GOODS_NAME').AsString := copy(s, 1, 255);
        end;

        if Assigned(ATable.Cells[I, 2]) then
          ParamByName('PRICE0').AsString := iif(stringreplace(ATable.Cells[I, 2].DisplayText, ' ', '', [rfReplaceAll]) =
            '', '0', ATable.Cells[I, 2].AsFloat)
        else
          ParamByName('PRICE0').Value := null;

        if Assigned(ATable.Cells[I, 3]) then
          ParamByName('PRICE3').AsString := iif(stringreplace(ATable.Cells[I, 3].DisplayText, ' ', '', [rfReplaceAll]) =
            '', '0', ATable.Cells[I, 3].AsString)
        else
          ParamByName('PRICE3').Value := null;

        if Assigned(ATable.Cells[I, 4]) then
          ParamByName('CURRENCY3ID').AsString := iif(ATable.Cells[I, 4].DisplayText = '', '498', GetCurrencyID(ATable.Cells
            [I, 4].DisplayText))
        else
          ParamByName('CURRENCY3ID').Value := null;

        if Assigned(ATable.Cells[I, 5]) then
          ParamByName('PRICE7').AsString := iif(stringreplace(ATable.Cells[I, 5].DisplayText, ' ', '', [rfReplaceAll]) =
            '', '0', ATable.Cells[I, 5].AsString)
        else
          ParamByName('PRICE7').Value := null;

        if Assigned(ATable.Cells[I, 6]) then
        begin
          ParamByName('CURRENCY7ID').AsString := iif(ATable.Cells[I, 6].DisplayText = '', '498', GetCurrencyID(ATable.Cells
            [I, 6].DisplayText));
          ParamByName('CURRENCY0ID').AsString := iif(ATable.Cells[I, 6].DisplayText = '', '498', GetCurrencyID(ATable.Cells
            [I, 6].DisplayText));
        end
        else
        begin
          ParamByName('CURRENCY7ID').Value := null;
          ParamByName('CURRENCY0ID').Value := null;
        end;

        if Assigned(ATable.Cells[I, 7]) then
          ParamByName('STOCK_QTY').AsString := ATable.Cells[I, 7].DisplayText;

        if Assigned(ATable.Cells[I, 8]) then
          ParamByName('WARANTY').AsString := iif(ATable.Cells[I, 8].DisplayText = '', '12', ATable.Cells[I, 8].DisplayText);

        if Assigned(ATable.Cells[I, 9]) then
          ParamByName('SUPPLIER_GOODS_BRAND').AsString := stringreplace(ATable.Cells[I, 9].DisplayText, #$D#$A, ' ', [rfReplaceAll]);

        if Assigned(ATable.Cells[I, 10]) then
        begin

          if pos(#$A, ATable.Cells[I, 10].AsString, 1) > 0 then
            s := Split(ATable.Cells[I, 10].AsString, #$A)[0]
          else
            s := ATable.Cells[I, 10].AsString;

          if s <> '' then
            s := ATable.Cells[I, 10].AsString;
          ParamByName('sUPPLIER_GOODS_MODEL').AsString := s;
        end;

        if Assigned(ATable.Cells[I, 11]) then
          ParamByName('SUPPLIER_CATEGORY').AsString := ATable.Cells[I, 11].DisplayText;

        if Assigned(ATable.Cells[I, 12]) then
          ParamByName('PRODUCT_LINK').AsString := ATable.Cells[I, 12].DisplayText;

        if Assigned(ATable.Cells[I, 9]) then
          ParamByName('SUPPLIER_GOODS_BRAND').AsString := ATable.Cells[I, 9].DisplayText;

//                if Assigned(ATable.Cells[I, 13]) then
//                    ParamByName('DESCRIERE').AsString := StringReplace(trim(ATable.Cells[I, 13].DisplayText), #$D#$A, ' ', [rfReplaceAll]);

        if Assigned(ATable.Cells[I, 14]) then
        begin
          s := '';
          if (ATable.Cells[I, 14].AsString <> '') then
            s := Split(ATable.Cells[I, 14].AsString, #$A)[0];
          if s <> '' then
            s := ATable.Cells[I, 14].AsString;

          ParamByName('COMPATIBILITATE').AsString := s;
        end;

        if Assigned(ATable.Cells[I, 15]) then
          ParamByName('TVA').AsString := ATable.Cells[I, 15].DisplayText
        else
          ParamByName('TVA').AsString := '20';

        try
          Execute;
        except
          on e: Exception do
          begin
            if assigned(ATable.Cells[I, 0]) then
              ErrorStr.Add(ATable.Cells[I, 0].DisplayText + #9 + e.Message);
          end;
        end;
        Application.ProcessMessages;
      end;
    end;

    if ErrorStr.Count > 0 then
    begin
      MessageDlg('Codurile produselor cu eroare:'#13#10 + ErrorStr.Text, mtError, [mbOK], 0);
      Clipboard.AsText := ErrorStr.Text;
    end;

    Query.ApplyUpdates;

    try
      IBCTrWrite.Commit;
    except
//      ShowMessage('SUPPLIER_GOODS_CODE = ' + ATable.Cells[I, 0].DisplayText);
      MessageDlg('Codurile produselor cu eroare:'#13#10 + ErrorStr.Text, mtError, [mbOK], 0);
      Clipboard.AsText := ErrorStr.Text;
      IBCTrWrite.Rollback;
    end;
  finally
    ibcsql.Free;
    Query.Free;
    ErrorStr.Free;
  end;

end;

procedure TfrmPriceListImportDlg.FormActivate(Sender: TObject);
begin
  dxSpreadSheet1.SetFocus;
end;

{ TfrmPriceList }

procedure TfrmPriceListImportDlg.Prepare;
begin
  PopulateSpreadSheet;
  dxWizardControlPage1.PageIndex := 0;
  teMentiuni.Text := Mentiuni;
end;

procedure TfrmPriceListImportDlg.PrepareStep1;
begin
  IBCQueryImportedGoods.Close;
  IBCQueryImportedGoods.ParamByName('PLID').AsInteger := fPLID;
  IBCQueryImportedGoods.Open;
end;

procedure TfrmPriceListImportDlg.SetPriceCategoryID(const Value: Integer);
begin
  FPriceCategoryID := Value;
end;

procedure TfrmPriceListImportDlg.UpdateCurrencyName(AColumnIndex: Integer; DefaultCurrencyName: string);
var
  ATable: TdxSpreadSheetTableView;
  Cell: TdxSpreadSheetCell;
  CurrencyName: string;
begin
  // Save Default CurrencyName for Supplier
  AppUserConfigStorage.OpenSection('SUPPLIER_IMPORT_PRICES');
  try
    DefaultCurrencyName := AppUserConfigStorage.TextValues.GetValue('Supplier' + SupplierID.ToString + '_' +
      PriceCategoryID.ToString + '-' + AColumnIndex.ToString, 'MDL');
    CurrencyName := InputBox('Valuta RRP', '(USD, MDL, EUR)', DefaultCurrencyName);
    AppUserConfigStorage.TextValues.SetValue('Supplier' + SupplierID.ToString + '_' + PriceCategoryID.ToString + '-' +
      AColumnIndex.ToString, CurrencyName);
  finally
    AppUserConfigStorage.CloseSection;
  end;
  // End of Save Default CurrencyName for Supplier


  ATable := dxSpreadSheet1.ActiveSheetAsTable;
  ATable.BeginUpdate;
  for var I := 1 to ATable.Rows.Count - 1 do
  begin
    if not Assigned(ATable.Cells[I, AColumnIndex]) then
    begin
      Cell := ATable.CreateCell(I, AColumnIndex);
    end
    else
    begin
      Cell := ATable.Cells[I, AColumnIndex];
    end;
    Cell.SetTExt(CurrencyName);
  end;
  ATable.EndUpdate;
end;

function TfrmPriceListImportDlg.ValidateData: Boolean;
var
  ATable: TdxSpreadSheetTableView;
  I: Integer;
  tmpPrice: string;
  ErrorMsg: string;
begin
  Result := True;
  ErrorMsg := '';
  ATable := dxSpreadSheet1.ActiveSheetAsTable;
   //   verificam datele.
   //   dxSpreadSheet1.BeginUpdate
  ATable.BeginUpdate;
  for I := 1 to ATable.Rows.Count - 1 do
  begin
    if (Assigned(ATable.Cells[I, 0])) and (ATable.Cells[I, 0].DisplayText = '') then
    begin
      ATable.Cells[I, 0].Style.Brush.BackgroundColor := clRed;
      ATable.Cells[I, 0].Style.Brush.ForegroundColor := clWhite;
      Result := False;
      ErrorMsg := ErrorMsg + 'Nu este indicat codul produsului pentru in rindul: ' + I.ToString + #13#10;
    end;

    //  cell[i,5] -> Price7

    if Assigned(ATable.Cells[I, 5]) and (StrToFloatDef(ATable.Cells[I, 5].AsString, -1) = -1) then
    begin
      tmpPrice := ATable.Cells[I, 5].AsString;
      if tmpPrice <> '' then
      begin
        tmpPrice := StringReplace(tmpPrice, ',', '.', [rfReplaceAll, rfIgnoreCase]);
        tmpPrice := StringReplace(tmpPrice, ' ', '', [rfReplaceAll, rfIgnoreCase]);
        if (StrToFloatDef(tmpPrice, -1) <> -1) then
        begin
          ATable.Cells[I, 5].AsString := tmpPrice;
        end
        else
        begin
          // a omite marfa cu indicativ zero ?
          ATable.Cells[I, 0].Style.Brush.BackgroundColor := clRed;
          ATable.Cells[I, 0].Style.Brush.ForegroundColor := clWhite;
          Result := False;
          ErrorMsg := ErrorMsg + 'Pretul nu este corect la produsul din rindul: ' + I.ToString + #13#10;
        end;
      end
      else
      begin
        ATable.Cells[I, 0].Style.Brush.BackgroundColor := clRed;
        ATable.Cells[I, 0].Style.Brush.ForegroundColor := clWhite;
        Result := False;
        ErrorMsg := ErrorMsg + 'Pretul lipseste la produsul din rindul: ' + I.ToString + #13#10;
      end;
    end;
    Application.ProcessMessages;
  end;
  ATable.EndUpdate;

  if not Result then
  begin
    var dialog := TfrmImportPricelistErrorDlg.Create(Self);
    try
      dialog.MemoLog.Lines.Clear;
      dialog.MemoLog.Lines.Add(ErrorMsg);
      dialog.ShowModal;
    finally

    end;
  end;
//        MessageDlg(ErrorMsg, mtError, [mbClose], 0)
end;

end.

