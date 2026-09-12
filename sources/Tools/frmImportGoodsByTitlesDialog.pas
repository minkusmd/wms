unit frmImportGoodsByTitlesDialog;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, StdCtrls, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Data.DB, MemDS, DBAccess, IBC, ComCtrls,
  cxCheckBox, cxBarEditItem, dxCore, dxCoreClasses, dxHashUtils,
  dxSpreadSheetCore, dxSpreadSheetPrinting, dxSpreadSheetFormulas,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetClasses,
  dxSpreadSheetTypes, dxBarBuiltInMenu, dxBar, dxBarExtItems, cxClasses,
  dxSpreadSheet, dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting, dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetContainers, dxSpreadSheetHyperlinks, dxSpreadSheetUtils, dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs,
  dxSpreadSheetStyles, dxSpreadSheetFormattedTextUtils, dxSpreadSheetCoreFormulas, Vcl.Menus, cxButtons,
  dxSpreadSheetFormulaBar,
  frmGoodsTypeDialog,
  frmSyssEditorWindow;

type
  TfrmImportGoodsByTitlesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Notebook: TNotebook;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    beGoodsFolder: TcxButtonEdit;
    lcbVENDOR: TcxLookupComboBox;
    lcbCURRENCY7: TcxLookupComboBox;
    lcbSERIALTYPE: TcxLookupComboBox;
    pnStep1: TPanel;
    pnWelcome: TPanel;
    pnProgress: TPanel;
    pnButtons: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarStatic1: TdxBarStatic;
    dxBarButton1: TdxBarButton;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    dxBarStatic2: TdxBarStatic;
    cxLabel19: TLabel;
    cxLabel20: TLabel;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    dxBarStatic3: TdxBarStatic;
    bbCreateGoods: TdxBarButton;
    mmLog: TMemo;
    bbLoadFromFile: TdxBarButton;
    bbOptions: TdxBarSubItem;
    bbHasColumnTitles: TdxBarButton;
    Label8: TLabel;
    edGoodsCount: TcxTextEdit;
    lcbUM: TcxLookupComboBox;
    cbWARRANTY: TcxComboBox;
    IBCDataSourceUM: TIBCDataSource;
    IBCQueryUM: TIBCQuery;
    IBCQueryGST: TIBCQuery;
    IBCDataSourceGST: TIBCDataSource;
    IBCDataSourceVendors: TIBCDataSource;
    IBCQueryVendors: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    IBCQueryCurrency: TIBCQuery;
    Label9: TLabel;
    beCustomerID: TcxButtonEdit;
    pnFinish: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    lbTotalGoods: TLabel;
    dxBarSubItem1: TdxBarSubItem;
    bbDeleteRow: TdxBarButton;
    bbCheckForeignCode: TdxBarButton;
    lcbGoodsType: TcxLookupComboBox;
    Label12: TLabel;
    IBCDataSourceWebGoodsType: TIBCDataSource;
    IBCQueryWebGoodsType: TIBCQuery;
    dxBarSubItem2: TdxBarSubItem;
    bbPaste_Foxtrot: TdxBarButton;
    bbPaste_NIPPON: TdxBarButton;
    dxBarEdit1: TdxBarEdit;
    beCustomer: TcxBarEditItem;
    cxSpreadSheet: TdxSpreadSheet;
    btnClose: TcxButton;
    btnPrev: TcxButton;
    btnNext: TcxButton;
    Label13: TLabel;
    lcbCURRENCY4: TcxLookupComboBox;
    Label14: TLabel;
    lcbTipProdus: TcxLookupComboBox;
    IBCQueryTipProdus: TIBCQuery;
    IBCDataSourceTipProdus: TIBCDataSource;
    dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Label15: TLabel;
    lcbCURRENCY3: TcxLookupComboBox;
    Label16: TLabel;
    lcbCURRENCY5: TcxLookupComboBox;
    lcbCURRENCY6: TcxLookupComboBox;
    Label17: TLabel;
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure bbLoadFromFileClick(Sender: TObject);
    procedure beGoodsFolderPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbCreateGoodsClick(Sender: TObject);
    procedure beCustomerIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbDeleteRowClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbCheckForeignCodeClick(Sender: TObject);
    procedure bbPaste_FoxtrotClick(Sender: TObject);
    procedure bbPaste_NIPPONClick(Sender: TObject);
    procedure cxBarEditItem1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    { Private declarations }
    fTargetFolder: Integer;
    fForeignCustomerID: Integer;
    fTotalInsertedGoods: Integer;
    fCustomerID: Integer;
    procedure OpenData;
    procedure ProcessSteps(const NextStep: Integer);
    procedure CreateSheetDefaultInfo;
    function CheckInputGoods: Boolean;
    procedure SelectTargetFolder;
    function CheckDefaultParams: Boolean;
    procedure SelectCustomerID;
    function DoCreateGoodsDB: Boolean;
    procedure VerifyGoodsByForeignCode;
    function GoodsByForeignCodeExistsDB(const Code: string; fCustomerID: Integer): Boolean;
    procedure PasteFrom_Foxtrot;
    procedure PasteFrom_Nippon;
  protected
    procedure LoadDefaultValues;
    { protected declarations }
    procedure Prepare; override;
    procedure SaveDefaultValues;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, frmGoods, SWNConst, SWNDBErrors,
  frmCustomersDlg, Vcl.Clipbrd, System.StrUtils, System.Types, System.Generics.Collections, SWNValueStorageUnit;

{$R *.dfm}

type
  TImportNipponItem = class
  public
    ID: string;
    Title: string;
  end;

  { TfrmImportsGoodsByTitlesDlg }

procedure TfrmImportGoodsByTitlesDlg.bbCheckForeignCodeClick(Sender: TObject);
begin
  if ShowAskDialog('Verificare dupa codul producatorului', 'Doriti sa verificati existenta marfurilor dupa codul producatorului?') = mrYes then
    VerifyGoodsByForeignCode;
end;

procedure TfrmImportGoodsByTitlesDlg.bbCreateGoodsClick(Sender: TObject);
begin
  mmLog.Lines.Clear;
  if DoCreateGoodsDB then
  begin
    btnNext.Enabled := True;
    btnNext.SetFocus;
  end
  else
    btnPrev.SetFocus;
end;

procedure TfrmImportGoodsByTitlesDlg.bbDeleteRowClick(Sender: TObject);
var
  rct: TRect;
begin
  rct := Rect(0, 1, cxSpreadSheet.ActiveSheetAsTable.Selection.FocusedColumn, cxSpreadSheet.ActiveSheetAsTable.Selection.FocusedRow);
  cxSpreadSheet.ActiveSheetAsTable.ClearCells(rct, True, True);

end;

procedure TfrmImportGoodsByTitlesDlg.bbLoadFromFileClick(Sender: TObject);
var
  dialog: TFileOpenDialog;
  ft: TFileTypeItem;
begin
  dialog := TFileOpenDialog.Create(Self);
  try
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Excel files';
    ft.FileMask := '*.xls';

    if dialog.Execute then
      cxSpreadSheet.LoadFromFile(dialog.FileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.bbPaste_FoxtrotClick(Sender: TObject);
begin
  PasteFrom_Foxtrot;
end;

procedure TfrmImportGoodsByTitlesDlg.bbPaste_NIPPONClick(Sender: TObject);
begin
  PasteFrom_Nippon;
end;

procedure TfrmImportGoodsByTitlesDlg.beCustomerIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomerID;
end;

procedure TfrmImportGoodsByTitlesDlg.beGoodsFolderPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectTargetFolder;
end;

procedure TfrmImportGoodsByTitlesDlg.btnNextClick(Sender: TObject);
begin
  ProcessSteps(Notebook.PageIndex + 1);
end;

procedure TfrmImportGoodsByTitlesDlg.btnPrevClick(Sender: TObject);
begin
  ProcessSteps(Notebook.PageIndex - 1);
end;

function TfrmImportGoodsByTitlesDlg.CheckDefaultParams: Boolean;
var
  Errors: TStringList;
begin
  Result := False;
  Errors := TStringList.Create;
  try
    if fForeignCustomerID = -1 then
      Errors.Add('Furnizorul produselor!');
    if fTargetFolder = -1 then
      Errors.Add('Grupa pentru produsele noi!');
    if VarIsNull(lcbVENDOR.EditValue) then
      Errors.Add('Producator!');
    if VarIsNull(lcbCURRENCY4.EditValue) then
      Errors.Add('Valuta de baza!');
    if VarIsNull(lcbCURRENCY7.EditValue) then
      Errors.Add('Valuta indicativ!');

    if VarIsNull(lcbUM.EditValue) then
      Errors.Add('Unitate metrica!');
    if StrToIntDef(cbWARRANTY.Text, -1) < 0 then
      Errors.Add('Garantia!');
    if VarIsNull(lcbSERIALTYPE.EditValue) then
      Errors.Add('Tipul evidentei!');

    if Errors.Count = 0 then
      Result := True
    else
      ShowErrorDialog(cMSG_GeneralInputError_Title, Errors.Text);

  finally
    Errors.Free;
  end;
end;

function TfrmImportGoodsByTitlesDlg.GoodsByForeignCodeExistsDB(const Code: string; fCustomerID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT COUNT(GOODSID) FROM TS_GOODS_FOREIGN WHERE GOODS_CODE=:code and CUSTOMERID=:CUSTOMERID';
    Query.ParamByName('code').AsString := Code;
    Query.ParamByName('CUSTOMERID').AsInteger := fCustomerID;
    if (fCustomerID <= 0) then
    begin
      ShowErrorDialog(cMSG_GeneralInputError_Title, 'Nu este indicat furnizorul!');
    end
    else
    begin
      Query.ExecSQL;
      Result := Query.Fields[0].AsInteger > 0;
    end;
  finally
    Query.Free;
  end;
end;

function TfrmImportGoodsByTitlesDlg.CheckInputGoods: Boolean;
var
  i, N: Integer;
  goodsCount: Integer;
  errorCount: Integer;
  existsCount: Integer;
  cell1, cell2: TdxSpreadSheetCell;
begin
  Result := False;
  N := 0;
  if bbHasColumnTitles.Down then
    N := 1;

  if ((cxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex - N) < 0) or (cxSpreadSheet.ActiveSheetAsTable.Columns.LastIndex < 2) then
  begin
    ShowErrorDialog(cMSG_GeneralInputError_Title, 'Date insufuciente!'#13#10'grula 1 - cod producator, grila 2 - denumirea produsului.');
    Exit;
  end;

  errorCount := 0;
  goodsCount := 0;
  existsCount := 0;
  for i := N to cxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
  begin
    // vendor code
    cell1 := cxSpreadSheet.ActiveSheetAsTable.Cells[i, 0];
    // cell1.Style.Format := 1; // text
    if (Trim(cell1.AsString) = '') then
    begin
      cell1.Style.Brush.BackgroundColor := 15; // no value
    end
    else if (pos('(exists)', cell1.DisplayText) > 0) then
    begin
      cell1.Style.Brush.BackgroundColor := 15; // exists
      inc(existsCount);
    end;

    // goods title
    cell2 := cxSpreadSheet.ActiveSheetAsTable.Cells[i, 1];
    // cell1.Style.Format := 1; // text
    if (Trim(cell2.AsString) = '') then
    begin
      cell2.Style.Brush.BackgroundColor := 8;
      cell2.Style.Font.Color := 1;
      inc(errorCount);
    end
    else
      inc(goodsCount);
  end;

  edGoodsCount.Text := IntToStr(goodsCount);

  Result := (errorCount = 0) and (existsCount = 0);
  if (errorCount > 0) or (existsCount > 0) then
    ShowErrorDialog(cMSG_GeneralInputError_Title, 'Au fost gasite produse fara denumire sau produse care sunt prezente.');

end;

procedure TfrmImportGoodsByTitlesDlg.CreateSheetDefaultInfo;
var
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
begin
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  Sheet.Caption := 'Produse';

  cell := Sheet.CreateCell(0, 0);
  cell.Style.DataFormat.FormatCodeID := $01; // text
  cell.column.Size := 120; // foreign code
  cell.SetText('Cod produs');

  cell := Sheet.CreateCell(0, 1);
  cell.column.Size := 350; // title
  cell.SetText('Denumire interna a produsului');

  cell := Sheet.CreateCell(0, 2);
  cell.column.Size := 260;
  cell.SetText('Model RO');

  cell := Sheet.CreateCell(0, 3);
  cell.column.Size := 260;
  cell.SetText('Model RU');

  cell := Sheet.CreateCell(0, 4);
  cell.column.Size := 250;
  cell.SetText('Parametru de baza RO');

  cell := Sheet.CreateCell(0, 5);
  cell.column.Size := 250;
  cell.SetText('Parametru de baza RU');

  cxSpreadSheet.ActiveSheetAsTable.Selection.SelectCell(1, 0);
end;

procedure TfrmImportGoodsByTitlesDlg.cxBarEditItem1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    // dialog.CustomFilter:=[cfCustomers,cfFirms,cfDiler,cfFranchises,cfVendors];
    if dialog.SelectCustomer(fCustomerID, False, 0, 'Alegeti furnizorul') then
    begin
      fCustomerID := dialog.CustomerID;
      beCustomer.EditValue := Format('#%d - %s', [dialog.CustomerID, dialog.CustomerTitle]);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.cxButton1Click(Sender: TObject);
var
  editor: TfrmGoodsTypeDlg;
begin
  editor := TfrmGoodsTypeDlg.Create(Self);
  try
//    if not IBCDataSourceGoods.DataSet.FieldByName('WEBGOODSTYPE_ID').IsNull then
//      editor.DefaultGoodsTypeID := IBCDataSourceGoods.DataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger;

    editor.ShowModal;
    IBCQueryWebGoodsType.Refresh;
//    IBCQueryWebGoodsType.Locate('goodstypeid', editor.Goodstypeid, []);
  finally
    editor.Free;
  end;
//  IBCQueryWebGoodsType.Refresh;
end;

procedure TfrmImportGoodsByTitlesDlg.cxButton2Click(Sender: TObject);
var
  syssEditor: TfrmSelectSyssEditorWin;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try

//    if not IBCDataSourceGoods.DataSet.FieldByName('VENDOR_ID').IsNull then
//      syssEditor.SYSSID := IBCDataSourceGoods.DataSet.FieldByName('VENDOR_ID').AsInteger;

    syssEditor.SetDefaultGroup(1); // Producatori
    syssEditor.ShowModal;
    IBCQueryVendors.Refresh;
  finally
    syssEditor.Free;
  end;
end;

function TfrmImportGoodsByTitlesDlg.DoCreateGoodsDB: Boolean;
var
  Query: TIBCQuery;
  i, N: Integer;
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  foreignCode: string;
  goodsTitle: string;
  p0, p1, p2, p3, p4, p5, p6, p7: Double;
  Currency4ID, Currency7ID: Integer;
  ModelRO, ModelRu: string;
  BaseParamRO, BaseParamRU: string;
begin
  Result := False;
  N := 0;
  if bbHasColumnTitles.Down then
    N := 1;

  Application.ProcessMessages;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Debug := True;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Add('EXECUTE PROCEDURE SP_CREATE_GOODS_FROM_TITLE(:TITLE, :PARENTID, :WEBTYPEID, :VENDORID, :UMID, :WARRANTY, :SNTYPE, :FOREIGN_CUSTOMERID, :FOREIGN_CODE, ');
    Query.SQL.Add(':CURRENCY4ID, :CURRENCY7ID, :GOODSTYPEID, :MODEL_RO, :MODEL_RU, :BASE_PARAM_RO, :BASE_PARAM_RU, :price4, :price5, :price7, :currency3id, :currency5id, :currency6id)');
    Query.ParamByName('PARENTID').AsInteger := fTargetFolder;
    Query.ParamByName('WEBTYPEID').AsInteger := lcbGoodsType.EditValue;
    Query.ParamByName('VENDORID').AsInteger := lcbVENDOR.EditValue;
    Query.ParamByName('UMID').AsInteger := lcbUM.EditValue;
    Query.ParamByName('WARRANTY').AsInteger := StrToInt(cbWARRANTY.Text);
    Query.ParamByName('SNTYPE').AsInteger := lcbSERIALTYPE.EditValue;
    Query.ParamByName('FOREIGN_CUSTOMERID').AsInteger := fForeignCustomerID;
    Query.ParamByName('CURRENCY4ID').AsInteger := lcbCURRENCY4.EditValue;
    Query.ParamByName('CURRENCY7ID').AsInteger := lcbCURRENCY7.EditValue;
    Query.ParamByName('GOODSTYPEID').AsInteger := lcbTipProdus.EditValue;
    Query.ParamByName('PRICE4').AsFloat := 0;
    Query.ParamByName('PRICE5').AsFloat := 0;
    Query.ParamByName('PRICE7').AsFloat := 0;
    Query.ParamByName('CURRENCY3ID').AsInteger := lcbCURRENCY3.EditValue;
    Query.ParamByName('CURRENCY5ID').AsInteger := lcbCURRENCY5.EditValue;
    Query.ParamByName('CURRENCY6ID').AsInteger := lcbCURRENCY6.EditValue;
    try
      Query.Transaction.StartTransaction;
      Sheet := cxSpreadSheet.ActiveSheetAsTable;
      for i := N to cxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin
        // get code
        cell := Sheet.Cells[i, 0];

        if assigned(cell) then
        begin
//          cell.Style.dataformat.FormatCode := 'TEXT';
          foreignCode := cell.DisplayText;
        end;
        if (foreignCode = '') then
          Query.ParamByName('FOREIGN_CODE').Value := Null
        else
          Query.ParamByName('FOREIGN_CODE').AsString := foreignCode;

        // get goods titile
        cell := Sheet.Cells[i, 1];
        if assigned(cell) then
          goodsTitle := Trim(cell.AsString);
        Query.ParamByName('TITLE').AsString := goodsTitle;

        // Model RO
        cell := Sheet.Cells[i, 2];
        if assigned(cell) then
          ModelRO := Trim(cell.AsString);
        // Model RU
        cell := Sheet.Cells[i, 3];
        if assigned(cell) then
          ModelRU := Trim(cell.AsString);

        // BASE_ PARAM RO
        cell := Sheet.Cells[i, 4];
        if assigned(cell) then
          BaseParamRO := Trim(cell.AsString);
        // BASE_ PARAM RU
        cell := Sheet.Cells[i, 5];
        if assigned(cell) then
          BaseParamRU := Trim(cell.AsString);


        Query.ParamByName('MODEL_RO').AsString := ModelRO;
        Query.ParamByName('MODEL_RU').AsString := ModelRU;

        Query.ParamByName('BASE_PARAM_RO').AsString := BaseParamRO;
        Query.ParamByName('BASE_PARAM_RU').AsString := BaseParamRU;

        mmLog.Lines.Add(Format('[%s]- %s', [foreignCode, goodsTitle{, p0, P7, P6, p5, p4, p3, p2, p1}]));
        Query.ExecSQL;
        inc(fTotalInsertedGoods);

        Application.ProcessMessages;
      end;
      mmLog.Lines.Add('');
      mmLog.Lines.Add('Finisat!');

      Query.Transaction.Commit;
      Result := True;

    except
      on E: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        mmLog.Lines.Add('');
        mmLog.Lines.Add('Eroare!');
        mmLog.Lines.Add('>> ' + E.Message);
        // if Not ProcessSWNError(E) then raise;
      end;
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.dxBarButton1Click(Sender: TObject);
begin
  cxSpreadSheet.ClearAll;
end;

procedure TfrmImportGoodsByTitlesDlg.LoadDefaultValues;
begin
      if IBCQueryWebGoodsType.Active then IBCQueryWebGoodsType.Refresh
      else IBCQueryWebGoodsType.Active := True;

      if (IBCQueryVendors.Active) then IBCQueryVendors.Refresh
      else IBCQueryVendors.Active := True;



      lcbVENDOR.Properties.ListSource.DataSet.Active := True;
      lcbCURRENCY7.Properties.ListSource.DataSet.Active := True;
      lcbCURRENCY4.Properties.ListSource.DataSet.Active := True;
      lcbUM.Properties.ListSource.DataSet.Active := True;
      lcbSERIALTYPE.Properties.ListSource.DataSet.Active := True;
      lcbTipProdus.Properties.ListSource.DataSet.Active := True;

      beCustomerID.Tag := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_TTITLE_SUPPLIERID');
      fForeignCustomerID := beCustomerID.Tag;
      beCustomerID.Text := AppUserTempConfigStorage.TextValues.GetValue('ImportGoods_TTITLE_SUPPLIER_NAME');

      beGoodsFolder.Tag := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_TTITLE_FOLDERID');
      fTargetFolder := beGoodsFolder.Tag;
      beGoodsFolder.Text := AppUserTempConfigStorage.TextValues.GetValue('ImportGoods_TTITLE_FOLDER_NAME');

      lcbGoodsType.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_GOODSTYPEID');
      lcbVENDOR.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_VENDORID');
      lcbCURRENCY3.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_CURRENCY3ID');
      lcbCURRENCY4.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_CURRENCY4ID');
      lcbCURRENCY5.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_CURRENCY5ID');
      lcbCURRENCY6.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_CURRENCY6ID');
      lcbCURRENCY7.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_CURRENCY7ID');

      lcbUM.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_UMID');
      lcbUM.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_UMID');
      cbWARRANTY.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_WARANTY');
      cbWARRANTY.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_WARANTY');
      lcbSERIALTYPE.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_SERIALTYPEID');
      lcbTipProdus.EditValue := AppUserTempConfigStorage.IntValues.GetValue('ImportGoods_TIPPRODUS');

end;

procedure TfrmImportGoodsByTitlesDlg.OpenData;
begin
  IBCQueryGST.Active := True;
  IBCQueryUM.Active := True;
  IBCQueryCurrency.Active := True;
  IBCQueryVendors.Active := True;
  IBCQueryWebGoodsType.Active := True;
  IBCQueryTipProdus.Active := True;

  beGoodsFolder.Text := '';
  beCustomerID.Text := '';

  lcbGoodsType.EditValue := 1; // none
  lcbVENDOR.EditValue := 1001; // unknown vendor
  lcbCURRENCY7.EditValue := 840; // USD
  lcbCURRENCY4.EditValue := 840; // USD
  lcbUM.EditValue := 1; // buk
  cbWARRANTY.Text := '24';
  lcbSERIALTYPE.EditValue := 4403; // serials
  lcbTipProdus.EditValue := 4201; // Marfa
end;

procedure TfrmImportGoodsByTitlesDlg.PasteFrom_Foxtrot;
var
  List: TStringList;
  i: Integer;
  items: TStringDynArray;

  function GetTextFromDynArray: string;
  var
    j: Integer;
  begin
    Result := '';
    for j := 0 to Length(items) - 2 do
    begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + Trim(items[j]);
    end;
  end;

begin
  if ShowAskDialog('Inserare din lista de preturi FOKSTROT', 'Coloana 1+2+3 -> Denumirea marfii'#13#10'Coloana 4 -> codul producatorului.'#13#10#13#10'Doriti sa inserati datele?') <> mrYes then
    Exit;

  // rearanjam datele din price Foxtrot
  // colonita 1+2+3 = denumirea produsului
  // colonita 4 = codul producatorului

  List := TStringList.Create;
  try
    // get data
    List.Text := Clipboard.AsText;
    for i := 0 to List.Count - 1 do
    begin
      items := SplitString(List[i], #9);
      if Length(items) = 4 then
      begin
        List[i] := Format('%s'#9'%s', [items[Length(items) - 1], GetTextFromDynArray]);
      end;
    end;
    Clipboard.AsText := List.Text;
    // era asa
    // cxSpreadSheet.ActiveSheetAsTable.Paste(cxSpreadSheet.Sheet.SelectionRect.Location);
    cxSpreadSheet.ActiveSheetAsTable.PasteFromClipboard;
  finally
    List.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.PasteFrom_Nippon;
var
  List: TStringList;
  i, k: Integer;
  S, s1, s2: string;
  needMore: Boolean;
  outData: TObjectList<TImportNipponItem>;
  Data: TImportNipponItem;

  function GetDataText: string;
  var
    j: Integer;
  begin
    Result := '';
    for j := 0 to outData.Count - 1 do
    begin
      if Result <> '' then
        Result := Result + #13#10;
      Result := Result + Format('%s'#9'%s', [outData[j].ID, outData[j].Title]);
    end;
  end;

begin
  if ShowAskDialog('Inserare din lista de preturi NIPPON', 'Coloana 1 -> codul producatorului, 2 - > Denumirea marfii'#13#10'Doriti sa inserati datele?') <> mrYes then
    Exit;

  List := TStringList.Create;
  try
    // get data
    List.Text := Clipboard.AsText;
    outData := TObjectList<TImportNipponItem>.Create;
    needMore := False;
    for i := 0 to List.Count - 1 do
    begin
      S := List[i];
      k := pos(#9, S);
      if (k > 0) and (k < 10) then
      begin
        s1 := Trim(Copy(S, 1, k - 1));
        s2 := Trim(ReplaceText(Copy(S, k + 1, Length(S)), #13#10, ' '));
        needMore := (Length(s2) > 0) and (s2[1] = '"');

        Data := TImportNipponItem.Create;
        Data.ID := s1;
        Data.Title := s2;
        outData.Add(Data);
      end
      else if (needMore) then
      begin
        s2 := Trim(ReplaceText(S, #13#10, ' '));
        k := Length(s2);
        needMore := (k > 0) and (s2[k] <> '"');
        Data := outData[outData.Count - 1];

        s1 := Format('%s %s', [Data.Title, s2]);
        if needMore then
          Data.Title := s1
        else
        begin
          // remove extra chars
          s1 := ReplaceText(s1, '""', '"');
          Delete(s1, 1, 1);
          Delete(s1, Length(s1), 1);
          Data.Title := s1;
        end;
      end;
    end;
    Clipboard.AsText := GetDataText;
    // cxSpreadSheet.Sheet.Paste(cxSpreadSheet.Sheet.SelectionRect.Location);
    cxSpreadSheet.ActiveSheetAsTable.PasteFromClipboard;
  finally
    List.Free;
    outData.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.Prepare;
begin
  fTargetFolder := -1;
  fForeignCustomerID := -1;
  fTotalInsertedGoods := 0;

  ProcessSteps(0); // first page
  CreateSheetDefaultInfo;
  OpenData;
end;

procedure TfrmImportGoodsByTitlesDlg.ProcessSteps(const NextStep: Integer);
var
  isForward: Boolean;
  // isBackward:Boolean;
  Result: Boolean;
  N: Integer;
begin
  if (NextStep = 0) then
  begin
    btnPrev.Enabled := False;
    btnNext.Enabled := True;
    Notebook.PageIndex := 0;
  end
  else
  begin
    isForward := NextStep > Notebook.PageIndex;
    // isBackward:=NextStep<Notebook.PageIndex;
    if (NextStep = 1) then
    begin
      N := 0;
      if bbHasColumnTitles.Down then
        N := 1;

      btnPrev.Enabled := True;
      btnNext.Enabled := True;
      Notebook.PageIndex := 1;
      if (cxSpreadSheet.ActiveSheetAsTable.Rows.Count - N) <= 0 then
        cxSpreadSheet.SetFocus;
    end
    else if (NextStep = 2) then
    begin
      Result := True;
      if isForward then
      begin
        Result := CheckInputGoods;
        LoadDefaultValues;
      end;

      if Result then
      begin
        btnPrev.Enabled := True;
        btnNext.Enabled := True;
        Notebook.PageIndex := 2;
      end;
    end
    else if (NextStep = 3) then
    begin
      Result := True;

      if isForward then
      begin
        Result := CheckDefaultParams;
        SaveDefaultValues;
      end;

      if Result then
      begin
        btnPrev.Enabled := True;
        btnNext.Enabled := False;
        Notebook.PageIndex := 3;
      end;

    end
    else if (NextStep = 4) then
    begin
      btnPrev.Enabled := True;
      btnNext.Enabled := False;
      Notebook.PageIndex := 4;

      lbTotalGoods.Caption := Format('Total produse adaugate: %d', [fTotalInsertedGoods]);
    end
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.SaveDefaultValues;
begin
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_TTITLE_SUPPLIERID', beCustomerID.Tag);
      AppUserTempConfigStorage.TextValues.SetValue('ImportGoods_TTITLE_SUPPLIER_NAME', beCustomerID.Text);

      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_TTITLE_FOLDERID', beGoodsFolder.Tag);
      AppUserTempConfigStorage.TextValues.SetValue('ImportGoods_TTITLE_FOLDER_NAME', beGoodsFolder.Text);

      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_GOODSTYPEID', lcbGoodsType.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_VENDORID', lcbVENDOR.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_CURRENCY3ID', lcbCURRENCY3.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_CURRENCY4ID', lcbCURRENCY4.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_CURRENCY5ID', lcbCURRENCY5.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_CURRENCY6ID', lcbCURRENCY6.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_CURRENCY7ID', lcbCURRENCY7.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_UMID', lcbUM.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_WARANTY', cbWARRANTY.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_WARANTY', cbWARRANTY.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_SERIALTYPEID', lcbSERIALTYPE.EditValue);
      AppUserTempConfigStorage.IntValues.SetValue('ImportGoods_TIPPRODUS', lcbTipProdus.EditValue);

end;

procedure TfrmImportGoodsByTitlesDlg.SelectCustomerID;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fForeignCustomerID, False, 0, 'Alegeti furnizorul') then
    begin
      fForeignCustomerID := dialog.CustomerID;
      beCustomerID.Tag := fForeignCustomerID;
      beCustomerID.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.SelectTargetFolder;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(fTargetFolder, True, 0, 'Mapa pentru produsele noi') then
    begin
      if dialog.GoodsIsFolder then
      begin
        fTargetFolder := dialog.GoodsID;
        beGoodsFolder.Tag := fTargetFolder;
        beGoodsFolder.Text := dialog.goodsTitle;
      end
      else
        ShowErrorDialog('Eroare', 'Alegeti doar mapa!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsByTitlesDlg.VerifyGoodsByForeignCode;
var
  N, i: Integer;
  cell1, cell2: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  error: Boolean;
  S: string;
begin
  N := 0;
  if bbHasColumnTitles.Down then
    N := 1;
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  if ((cxSpreadSheet.ActiveSheetAsTable.Rows.Count - N) > 0) and (cxSpreadSheet.ActiveSheetAsTable.Columns.Count > 1) then
  begin
    for i := N to Sheet.Rows.Count - 1 do
    begin
      error := False;
      // vendor code
      cell1 := Sheet.Cells[i, 0];

//      cell1.DataType // text
      S := cell1.DisplayText;
      if (pos('(exists)', S) > 0) then
      begin
        cell1.SetText(Copy(S, 10, Length(S)));
        cell1.Style.Brush.BackgroundColor := clWebRed;
        cell1.Style.Font.Color := clWebLightYellow;
      end;

      if (Trim(cell1.DisplayText) = '') then
      begin
        cell1.Style.Brush.BackgroundColor := clWebCoral; // no value
        error := True;
      end;

      // goods title
      cell2 := Sheet.Cells[i, 1];
      if not Assigned(cell2) then
      begin
        raise Exception.Create('Pentru a Adauga produse noi, trebuie complectat cimpul denumirea!');
      end
      else
        if (Trim(cell2.DisplayText) = '') then
        begin
          cell2.Style.Brush.BackgroundColor := clWebYellowGreen;
          cell2.Style.Font.Color := clBlack;
          error := True;
        end;

      if not error then
      begin
        S := cell1.DisplayText;
        if GoodsByForeignCodeExistsDB(Trim(S), fCustomerID) then
        begin
          cell1.SetText(Format('(exists) %s', [cell1.DisplayText]));
          cell1.Style.Brush.BackgroundColor := clWebRed;
          cell1.Style.Font.Color := clWebLightYellow;
        end;
      end;

    end;
  end
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, 'Date insufuciente!'#13#10'grila 1 - cod furnizor, grila 2 - denumire produse.');
end;

end.

