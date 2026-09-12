unit frmExportTo1CDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, MemDS, DBAccess, IBC,
  Xml.XMLDoc, Xml.XMLIntf, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckComboBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid,
  cxCurrencyEdit, cxCheckBox, cxNavigator, Vcl.Menus, cxButtons, cxMemo, dxCore, cxDateUtils, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TfrmExportTo1CDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TPageControl;
    TabSheet1: TTabSheet;
    btnGenerate: TButton;
    btnClose: TButton;
    IBCQueryOst: TIBCQuery;
    tbsExport: TTabSheet;
    Label1: TLabel;
    btnGenDocs: TButton;
    IBCQuerySF: TIBCQuery;
    IBCQueryJurnal: TIBCQuery;
    IBCQueryP: TIBCQuery;
    IBCQueryPrihod: TIBCQuery;
    Label2: TLabel;
    Label3: TLabel;
    IBCQuerySF_Goods: TIBCQuery;
    cbPostuplenia: TCheckBox;
    cbPeremeshenie: TCheckBox;
    Label4: TLabel;
    IBCQueryReceipt: TIBCQuery;
    IBCQueryReceiptGoods: TIBCQuery;
    cbRealizatia_SF: TCheckBox;
    cbRealizatia_Cek: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ccbFirmaStart: TcxCheckComboBox;
    ccbFirmaEnd: TcxCheckComboBox;
    tbsErrors: TTabSheet;
    cxGridErrorsLevel: TcxGridLevel;
    cxGridErrors: TcxGrid;
    cxGridErrorsTable: TcxGridTableView;
    cxGridErrors_DOCID: TcxGridColumn;
    cxGridErrors_DT: TcxGridColumn;
    cxGridErrors_CT: TcxGridColumn;
    cxGridErrors_SUMA: TcxGridColumn;
    cxGridErrors_CREATEDBY: TcxGridColumn;
    cxGridErrors_ERROR: TcxGridColumn;
    Label9: TLabel;
    pbProgress: TProgressBar;
    lbProgressTitle: TLabel;
    cbDocList: TCheckBox;
    edDocList: TcxTextEdit;
    Label10: TLabel;
    edOstatkiDocID: TEdit;
    btnOstatkiDoc: TButton;
    IBCQueryOstDoc: TIBCQuery;
    IBCQueryPrinhodInfo: TIBCQuery;
    cbTestOnly: TCheckBox;
    IBCQuerySF_Complecte: TIBCQuery;
    IBCQuerySF_ComplecteGoods: TIBCQuery;
    dtpDataStart: TcxDateEdit;
    dtpDataEnd: TcxDateEdit;
    CheckBox1: TCheckBox;
    cxButton1: TcxButton;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnGenDocsClick(Sender: TObject);
    procedure cxGridErrorsTableKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure cbDocListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOstatkiDocClick(Sender: TObject);
  private
    { Private declarations }
    fDocList: TStringList;
    procedure LoadFirmaList;
    procedure GenerateOstatki2;
    function DateTimeTo1CTime(const DateTime: TDateTime): string;
    function DateTimeTo1CTime8Morning(const DateTime: TDateTime): string;
    function DateTimeTo1CTime18Evening(const DateTime: TDateTime): string;
    function GetSaveFileName(const FileName: string): string;
    procedure GetFacturaNumberComponents(const SourceText: string; var
      FacrturaSeria, FacturaNumar: string);
    function GetFirmaStartIDList: string;
    function GetFirmaEndIDList: string;
    function CheckInputValues: Boolean;
    function ParseDocList: Boolean;
    procedure VerifyПоступления(const DTList, CTList: string; const DateStart,
      DateEnd: TDateTime);
    procedure VerifyРеализацияСчетфактуры(const DTList, CTList: string; const
      DateStart, DateEnd: TDateTime);
    procedure VerifyРеализацияКассовыечеки(const DTList, CTList: string; const
      DateStart, DateEnd: TDateTime);
    procedure VerifyПеремещение(const DTList, CTList: string; const DateStart,
      DateEnd: TDateTime);
    function CheckDataBeforeExport: Boolean;
    procedure GenerateDocs;
    function Generate_Реализация_товаров1(const Node: IXMLNode; const DocList:
      TStringList): Integer;
    function Generate_Реализация_товаров2(const Node: IXMLNode; const DocList:
      TStringList): Integer;
    function Generate_Перемещение_товаров(const Node: IXMLNode; const DocList:
      TStringList): Integer;
    function Generate_Поступление_товаров(const Node: IXMLNode; const DocList:
      TStringList): Integer;
    procedure Generate_Списание_Материалов_В_Производстве(const Node: IXMLNode);
    function MarkDocumentsAsExported(const DocList: string): Boolean;
    procedure GenerateOstatkiByDocID;
    function VerifyOstatkiByDocID(const DocID: integer): Boolean;
    procedure GenerateOstatkiFromDocID(const DocID: integer);
    procedure ShowNotExportedDos(const ExportedDocList, DTList, CTList: string);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, ClipBrd,
  frmExportTo1CDocListDialog, SWNSecurity;

{ TfrmExportTo1CDlg }

procedure TfrmExportTo1CDlg.btnGenDocsClick(Sender: TObject);
begin
  if CheckInputValues then
  begin
    if CheckDataBeforeExport then
      GenerateDocs
  end;
end;

procedure TfrmExportTo1CDlg.btnGenerateClick(Sender: TObject);
begin
  GenerateOstatki2;
end;

procedure TfrmExportTo1CDlg.btnOstatkiDocClick(Sender: TObject);
begin
  GenerateOstatkiByDocID;
end;

procedure TfrmExportTo1CDlg.cbDocListClick(Sender: TObject);
begin
     // date
  dtpDataStart.Enabled := not cbDocList.Checked;
  dtpDataEnd.Enabled := not cbDocList.Checked;
  Label5.Enabled := not cbDocList.Checked;
  Label6.Enabled := not cbDocList.Checked;
     // DocList
  edDocList.Enabled := cbDocList.Checked;
end;

function TfrmExportTo1CDlg.CheckDataBeforeExport: Boolean;
var
  DTList, CTList: string;
  Date1, Date2: TDateTime;
begin
  Result := False;

  DTList := GetFirmaStartIDList;
  CTList := GetFirmaEndIDList;
  Date1 := dtpDataStart.Date;
  Date2 := dtpDataEnd.Date;

  cxGridErrorsTable.DataController.BeginUpdate;
     // clear grid
  while (cxGridErrorsTable.DataController.RecordCount > 0) do
    cxGridErrorsTable.DataController.DeleteRecord(0);

  try
        // Intrari
    if cbPostuplenia.Checked then
      VerifyПоступления(DTList, CTList, Date1, Date2);

        // Realizare: Facturi fiscale
    if cbRealizatia_SF.Checked then
      VerifyРеализацияСчетфактуры(DTList, CTList, Date1, Date2);

        // Realizare: Bonuri de casa
    if cbRealizatia_Cek.Checked then
      VerifyРеализацияКассовыечеки(DTList, CTList, Date1, Date2);

        // Transfer
    if cbPeremeshenie.Checked then
      VerifyПеремещение(DTList, CTList, Date1, Date2);
  finally
    cxGridErrorsTable.DataController.EndUpdate;
  end;

  if cxGridErrorsTable.DataController.RecordCount = 0 then
    Result := True
  else
  begin
    tbsErrors.TabVisible := True;
    pcPageControl.ActivePage := tbsErrors;
    cxGridErrorsTable.DataController.Groups.FullExpand;
  end;
end;

function TfrmExportTo1CDlg.CheckInputValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  fDocList.Clear;

  if not (cbPostuplenia.Checked or cbRealizatia_SF.Checked or cbRealizatia_Cek.Checked
    or cbPeremeshenie.Checked) then
    AddErrorToStr(ErrorStr, 'Selectati tipul documentului pentru export!');

  if cbDocList.Checked then
  begin
    if not ParseDocList then
      AddErrorToStr(ErrorStr, 'Lista documentelor!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmExportTo1CDlg.cxGridErrorsTableKeyDown(Sender: TObject; var Key:
  Word; Shift: TShiftState);
begin
     // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
          // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGridErrorsTable);
    Key := 0;
    Shift := [];
  end
end;

function TfrmExportTo1CDlg.DateTimeTo1CTime(const DateTime: TDateTime): string;
begin
  if DateTime = 0 then
    Result := ''
  else
    Result := FormatDateTime('yyyymmddhhnnss', DateTime);
end;

function TfrmExportTo1CDlg.DateTimeTo1CTime8Morning(const DateTime: TDateTime): string;
begin
  if DateTime = 0 then
    Result := ''
  else
    Result := FormatDateTime('yyyymmdd040000', DateTime);
end;

function TfrmExportTo1CDlg.DateTimeTo1CTime18Evening(const DateTime: TDateTime): string;
begin
  if DateTime = 0 then
    Result := ''
  else
    Result := FormatDateTime('yyyymmdd190000', DateTime);
end;

procedure TfrmExportTo1CDlg.FormCreate(Sender: TObject);
begin
  fDocList := TStringList.Create;
end;

procedure TfrmExportTo1CDlg.FormDestroy(Sender: TObject);
begin
  fDocList.Free;
end;

procedure TfrmExportTo1CDlg.GenerateDocs;
var
  XML: TXMLDocument;
  node: IXMLNode;
  fileName: string;
  DTList, CTList: string;
  Summary: TStringList;
  DocList: TStringList;
begin
  DTList := GetFirmaStartIDList;
  CTList := GetFirmaEndIDList;

  lbProgressTitle.Visible := True;
  pbProgress.Visible := True;
  pbProgress.Max := 3;
  pbProgress.Position := 0;
  Application.ProcessMessages;

  XML := TXMLDocument.Create(Self);
  XML.Active := True;
  XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
  XML.Version := '1.0';
  XML.Encoding := 'UTF-8';

  node := XML.AddChild('ОбменДанными');
  node.SetAttributeNS('Дата', '', DateTimeTo1CTime(NOW));
  node.SetAttributeNS('ТипВыгрузки', '', 'Ручная');

  Summary := TStringList.Create;
  Summary.Add('Documentele au fost exportate in fisier.');
  Summary.Add('');

  DocList := TStringList.Create;
  DocList.Sorted := True;
  DocList.Duplicates := dupIgnore;

  try
     // 1. Intrare marfa
    if cbPostuplenia.Checked then
    begin
      IBCQueryPrihod.Close;
      try
        IBCQueryPrihod.ParamByName('DATA1').AsDate := dtpDataStart.Date;
        IBCQueryPrihod.ParamByName('DATA2').AsDate := dtpDataEnd.Date;
        IBCQueryPrihod.ParamByName('DT').AsString := DTList;
        IBCQueryPrihod.ParamByName('CT').AsString := CTList;
        if fDocList.Count > 0 then
          IBCQueryPrihod.ParamByName('DOCLIST').AsString := fDocList.CommaText
        else
          IBCQueryPrihod.ParamByName('DOCLIST').Value := Null;

        IBCQueryPrihod.Open;
        Summary.Add(Format('Intrare marfa: %d documente.', [Generate_Поступление_товаров
          (node, DocList)]));

      finally
        IBCQueryPrihod.Close;
      end;
    end;
    pbProgress.Position := 1;
    Application.ProcessMessages;

     // 2. Realizare marfa
    if cbRealizatia_SF.Checked or cbRealizatia_Cek.Checked then
    begin
      if cbRealizatia_SF.Checked then
      begin
        // Facturi fiscale
        IBCQuerySF.Close;
        try
          IBCQuerySF.ParamByName('DATA1').AsDate := dtpDataStart.Date;
          IBCQuerySF.ParamByName('DATA2').AsDate := dtpDataEnd.Date;
          IBCQuerySF.ParamByName('DT').AsString := DTList;
          IBCQuerySF.ParamByName('CT').AsString := CTList;
          if fDocList.Count > 0 then
            IBCQuerySF.ParamByName('DOCLIST').AsString := fDocList.CommaText
          else
            IBCQuerySF.ParamByName('DOCLIST').Value := Null;
          IBCQuerySF.ParamByName('FLG_NO_FILTER').AsInteger := Ord(cbTestOnly.Checked);
            // !!! for testing only

          IBCQuerySF.Open;
          Summary.Add(Format('Facturi fiscale: %d documente.', [Generate_Реализация_товаров1
            (node, DocList)]));
        finally
          IBCQuerySF.Close;
        end;
      end;

      if cbRealizatia_Cek.Checked then
      begin
               // Realizare pe bonuri
        IBCQueryReceipt.Close;
        try
          IBCQueryReceipt.ParamByName('DATA1').AsDate := dtpDataStart.Date;
          IBCQueryReceipt.ParamByName('DATA2').AsDate := dtpDataEnd.Date;
          IBCQueryReceipt.ParamByName('DT').AsString := DTList;
          IBCQueryReceipt.ParamByName('CT').AsString := CTList;
          if fDocList.Count > 0 then
            IBCQueryReceipt.ParamByName('DOCLIST').AsString := fDocList.CommaText
          else
            IBCQueryReceipt.ParamByName('DOCLIST').Value := Null;
          IBCQueryReceipt.ParamByName('FLG_NO_FILTER').AsInteger := Ord(cbTestOnly.Checked);
            // !!! for testing only

          IBCQueryReceipt.Open;
          Summary.Add(Format('Realizare pe bonuri: %d documente.', [Generate_Реализация_товаров2
            (node, DocList)]));
        finally
          IBCQueryReceipt.Close;
          IBCQueryReceiptGoods.Close;
        end;
      end;
    end;
    pbProgress.Position := 2;
    Application.ProcessMessages;


     // 3. Transfer marfa
    if cbPeremeshenie.Checked then
    begin
      IBCQueryP.Close;
      try
        IBCQueryP.ParamByName('DATA1').AsDate := dtpDataStart.Date;
        IBCQueryP.ParamByName('DATA2').AsDate := dtpDataEnd.Date;
        IBCQueryP.ParamByName('DT').AsString := DTList;
        IBCQueryP.ParamByName('CT').AsString := CTList;
        if fDocList.Count > 0 then
          IBCQueryP.ParamByName('DOCLIST').AsString := fDocList.CommaText
        else
          IBCQueryP.ParamByName('DOCLIST').Value := Null;

        IBCQueryP.Open;
        Summary.Add(Format('Transfer marfa: %d documente.', [Generate_Перемещение_товаров
          (node, DocList)]));
      finally
        IBCQueryP.Close;
      end;
    end;
    pbProgress.Position := 3;
    Application.ProcessMessages;

    Clipboard.asText := DocList.CommaText;

     // save to file
    if cbDocList.Checked then
      fileName := GetSaveFileName('PPR custom')
    else
      fileName := GetSaveFileName('PPR ' + FormatDateTime('yyyy.mm.dd',
        dtpDataStart.Date));
    if (fileName <> '') then
    begin
      XML.SaveToFile(fileName);
      ShowInfoDialog('Готово', Summary.Text);

      if (DocList.Count > 0) then
      begin
        ShowNotExportedDos(DocList.CommaText, DTList, CTList);

        if not cbTestOnly.Checked and (ShowAskDialog('Marcheaza documentele',
          'Marcati documentele exportate in baza de date?' + #13#10 +
          'Total documente: ' + IntToStr(DocList.Count)) = mrYes) then
        begin
          if MarkDocumentsAsExported(DocList.CommaText) then
          begin
            ShowInfoDialog('Marcheaza documentele', 'Gata!');
          end;
        end;
      end;
    end;
  finally
    Summary.Free;
    DocList.Free;
  end;

  lbProgressTitle.Visible := False;
  pbProgress.Visible := False;
end;

procedure TfrmExportTo1CDlg.GenerateOstatki2;
var
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT, FirmaAddress, FirmaPhone,
    FirmaScladCod, FirmaScladName, FirmaScladType: string;
  AcntID: integer;
  AcntTitle: string;
  qty: integer;
  price, suma: string;
  UMID: integer;
  UMTitle: string;
  FLG_SERVICIU: integer;
  XML: TXMLDocument;
  lastFirmaCod, lastFirmaScladCod: string;
  root, node, node2, node3, node4: IXMLNode;
  fileName: string;
begin
  XML := TXMLDocument.Create(Self);
  XML.Active := True;
  XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
  XML.Version := '1.0';
  XML.Encoding := 'UTF-8';

  node := XML.AddChild('ОбменДанными');
  node.SetAttributeNS('Дата', '', DateTimeTo1CTime(NOW));
  node.SetAttributeNS('ТипВыгрузки', '', 'Ручная');

  root := node.AddChild('ОприходованиеТоваров');
  root.SetAttributeNS('Тип', '', 'мОприходованиеТоваров');

  lastFirmaCod := '';
  lastFirmaScladCod := '';
  try
    IBCQueryOst.Open;
    while not IBCQueryOst.Eof do
    begin
             // prepare
      FirmaCod := IBCQueryOst.Fields[0].AsString;
      FirmaName := IBCQueryOst.Fields[1].AsString;
      FirmaIDEN := IBCQueryOst.Fields[2].AsString;
      FirmaVAT := IBCQueryOst.Fields[3].AsString;
      FirmaAddress := IBCQueryOst.Fields[4].AsString;
      FirmaPhone := IBCQueryOst.Fields[5].AsString;
      FirmaScladCod := IBCQueryOst.Fields[6].AsString;
      FirmaScladName := IBCQueryOst.Fields[7].AsString;
      FirmaScladType := IBCQueryOst.Fields[8].AsString;

      AcntID := IBCQueryOst.Fields[9].AsInteger;
      AcntTitle := IBCQueryOst.Fields[10].AsString;
      price := IBCQueryOst.Fields[11].AsString;
      qty := IBCQueryOst.Fields[12].AsInteger;
      suma := IBCQueryOst.Fields[13].AsString;
      FLG_SERVICIU := IBCQueryOst.Fields[14].AsInteger;
      UMID := IBCQueryOst.Fields[15].AsInteger;
      UMTitle := IBCQueryOst.Fields[16].AsString;

      if (FirmaCod <> lastFirmaCod) or (FirmaScladCod <> lastFirmaScladCod) then
      begin
        node := root.AddChild('ОприходованиеТоваров');
        node.SetAttributeNS('Тип', '', 'ОприходываниеТоваров');
        node.SetAttributeNS('Дата', '', DateTimeTo1CTime(NOW));
        node.SetAttributeNS('Номер', '', '');
        node.SetAttributeNS('Комментарий', '', '');
        node.SetAttributeNS('Основание', '', '');

        node2 := node.AddChild('Организация');
        node2.SetAttributeNS('Тип', '', 'СправочникОрганизация');
        node2.SetAttributeNS('Код', '', FirmaCod);
        node2.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
        node2.SetAttributeNS('НаименованиеПолное', '', FirmaName);
        node2.SetAttributeNS('ФискальныйКод', '', FirmaIDEN);
        node2.SetAttributeNS('КодНДС', '', FirmaVAT);
        node2.SetAttributeNS('ЮридическийАдрес', '', FirmaAddress);
        node2.SetAttributeNS('Телефон', '', FirmaPhone);

        node2 := node.AddChild('Склад');
        node2.SetAttributeNS('Тип', '', 'СправочникСклады');
        node2.SetAttributeNS('Код', '', FirmaScladCod);
        node2.SetAttributeNS('Наименование', '', FirmaScladName);

        node3 := node2.AddChild('ВидСклада');
        node3.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
        node3.SetAttributeNS('ВидСклада', '', FirmaScladType);

        node2 := node.AddChild('ВалютаДокумента');
        node2.SetAttributeNS('Тип', '', 'СправочникВалюты');
        node2.SetAttributeNS('Код', '', '498');
        node2.SetAttributeNS('Наименование', '', 'MDL');
        node2.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

        node := node.AddChild('Товары');
        node.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

        lastFirmaCod := FirmaCod;
        lastFirmaScladCod := FirmaScladCod;
      end;



             // write
      node2 := node.AddChild('СтрокаТЧ');
      node2.SetAttributeNS('Тип', '', 'СтрокаТЧ');
      node2.SetAttributeNS('Количество', '', IntToStr(qty));
      node2.SetAttributeNS('Цена', '', price);
      node2.SetAttributeNS('Сумма', '', suma);

      node3 := node2.AddChild('Номенклатура');
      node3.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
      node3.SetAttributeNS('Код', '', IntToStr(AcntID));
      node3.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
      node3.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
      node3.SetAttributeNS('ЭтоГруппа', '', '0');

      node4 := node3.AddChild('БазоваяЕдиницаИзмерения');
      node4.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
      node4.SetAttributeNS('Код', '', IntToStr(UMID));
      node4.SetAttributeNS('Наименование', '', UMTitle);
      node4.SetAttributeNS('НаименованиеГос', '', UMTitle);
      node4.SetAttributeNS('НаименованиеРус', '', '');

      node4 := node3.AddChild('СтавкаНДС');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
      node4.SetAttributeNS('Ставка', '', '20');

      node4 := node3.AddChild('Родитель');
      node4.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
      if (FLG_SERVICIU = 1) then
        node4.SetAttributeNS('Код', '', '00000000003')
      else
        node4.SetAttributeNS('Код', '', '00000000001');
      node4.SetAttributeNS('ЭтоГруппа', '', '1');

      node3 := node2.AddChild('Склад');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      IBCQueryOst.Next;
    end;
  finally
    IBCQueryOst.Close;
  end;

  fileName := GetSaveFileName('Ostatki');
  if (fileName <> '') then
  begin
    XML.SaveToFile(fileName);
    ShowInfoDialog('Готово', 'Stocurile au fost exportate in fisier.');
  end;
end;

procedure TfrmExportTo1CDlg.GenerateOstatkiByDocID;
var
  N: integer;
begin
  N := StrToIntDef(edOstatkiDocID.Text, -1);
  if (N > 0) then
  begin
    if VerifyOstatkiByDocID(N) then
      GenerateOstatkiFromDocID(N)
  end
  else
    ShowErrorDialog('Eroare!', 'Introduceti numarul corect al documentului.');
end;

procedure TfrmExportTo1CDlg.GenerateOstatkiFromDocID(const DocID: integer);
var
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT, FirmaAddress, FirmaPhone,
    FirmaScladCod, FirmaScladName, FirmaScladType: string;
  AcntID: integer;
  AcntTitle: string;
  qty: integer;
  price, suma: string;
  UMID: integer;
  UMTitle: string;
  FLG_SERVICIU: integer;
  XML: TXMLDocument;
  root, node, node2, node3, node4: IXMLNode;
  fileName: string;
begin
  XML := TXMLDocument.Create(Self);
  XML.Active := True;
  XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
  XML.Version := '1.0';
  XML.Encoding := 'UTF-8';

  node := XML.AddChild('ОбменДанными');
  node.SetAttributeNS('Дата', '', DateTimeTo1CTime(NOW));
  node.SetAttributeNS('ТипВыгрузки', '', 'Ручная');

  root := node.AddChild('ОприходованиеТоваров');
  root.SetAttributeNS('Тип', '', 'мОприходованиеТоваров');

  try
    IBCQueryOstDoc.ParamByName('DOCID').AsInteger := DocID;
    IBCQueryOstDoc.Open;
    if not IBCQueryOstDoc.Eof then
    begin
             // prepare
      FirmaCod := IBCQueryOstDoc.Fields[0].AsString;
      FirmaName := IBCQueryOstDoc.Fields[1].AsString;
      FirmaIDEN := IBCQueryOstDoc.Fields[2].AsString;
      FirmaVAT := IBCQueryOstDoc.Fields[3].AsString;
      FirmaAddress := IBCQueryOstDoc.Fields[4].AsString;
      FirmaPhone := IBCQueryOstDoc.Fields[5].AsString;
      FirmaScladCod := IBCQueryOstDoc.Fields[6].AsString;
      FirmaScladName := IBCQueryOstDoc.Fields[7].AsString;
      FirmaScladType := IBCQueryOstDoc.Fields[8].AsString;

      node := root.AddChild('ОприходованиеТоваров');
      node.SetAttributeNS('Тип', '', 'ОприходываниеТоваров');
      node.SetAttributeNS('Дата', '', DateTimeTo1CTime(NOW));
      node.SetAttributeNS('Номер', '', '');
      node.SetAttributeNS('Комментарий', '', '');
      node.SetAttributeNS('Основание', '', '');

      node2 := node.AddChild('Организация');
      node2.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node2.SetAttributeNS('Код', '', FirmaCod);
      node2.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node2.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node2.SetAttributeNS('ФискальныйКод', '', FirmaIDEN);
      node2.SetAttributeNS('КодНДС', '', FirmaVAT);
      node2.SetAttributeNS('ЮридическийАдрес', '', FirmaAddress);
      node2.SetAttributeNS('Телефон', '', FirmaPhone);

      node2 := node.AddChild('Склад');
      node2.SetAttributeNS('Тип', '', 'СправочникСклады');
      node2.SetAttributeNS('Код', '', FirmaScladCod);
      node2.SetAttributeNS('Наименование', '', FirmaScladName);

      node3 := node2.AddChild('ВидСклада');
      node3.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node3.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node2 := node.AddChild('ВалютаДокумента');
      node2.SetAttributeNS('Тип', '', 'СправочникВалюты');
      node2.SetAttributeNS('Код', '', '498');
      node2.SetAttributeNS('Наименование', '', 'MDL');
      node2.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

      node := node.AddChild('Товары');
      node.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

      while not IBCQueryOstDoc.Eof do
      begin
        AcntID := IBCQueryOstDoc.Fields[9].AsInteger;
        AcntTitle := IBCQueryOstDoc.Fields[10].AsString;
        price := IBCQueryOstDoc.Fields[11].AsString;
        qty := IBCQueryOstDoc.Fields[12].AsInteger;
        suma := IBCQueryOstDoc.Fields[13].AsString;
        FLG_SERVICIU := IBCQueryOstDoc.Fields[14].AsInteger;
        UMID := IBCQueryOstDoc.Fields[15].AsInteger;
        UMTitle := IBCQueryOstDoc.Fields[16].AsString;

                  // write
        node2 := node.AddChild('СтрокаТЧ');
        node2.SetAttributeNS('Тип', '', 'СтрокаТЧ');
        node2.SetAttributeNS('Количество', '', IntToStr(qty));
        node2.SetAttributeNS('Цена', '', price);
        node2.SetAttributeNS('Сумма', '', suma);

        node3 := node2.AddChild('Номенклатура');
        node3.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
        node3.SetAttributeNS('Код', '', IntToStr(AcntID));
        node3.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
        node3.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
        node3.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
        node3.SetAttributeNS('ЭтоГруппа', '', '0');

        node4 := node3.AddChild('БазоваяЕдиницаИзмерения');
        node4.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
        node4.SetAttributeNS('Код', '', IntToStr(UMID));
        node4.SetAttributeNS('Наименование', '', UMTitle);
        node4.SetAttributeNS('НаименованиеГос', '', UMTitle);
        node4.SetAttributeNS('НаименованиеРус', '', '');

        node4 := node3.AddChild('СтавкаНДС');
        node4.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
        node4.SetAttributeNS('Ставка', '', '20');

        node4 := node3.AddChild('Родитель');
        node4.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
        if (FLG_SERVICIU = 1) then
          node4.SetAttributeNS('Код', '', '00000000003')
        else
          node4.SetAttributeNS('Код', '', '00000000001');
        node4.SetAttributeNS('ЭтоГруппа', '', '1');

        node3 := node2.AddChild('Склад');
        node3.SetAttributeNS('Тип', '', 'СправочникСклады');
        node3.SetAttributeNS('Код', '', FirmaScladCod);
        node3.SetAttributeNS('Наименование', '', FirmaScladName);

        node4 := node3.AddChild('ВидСклада');
        node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
        node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

        IBCQueryOstDoc.Next;
      end;
    end;
  finally
    IBCQueryOstDoc.Close;
  end;

  fileName := GetSaveFileName('Ostatki #' + IntToStr(DocID));
  if (fileName <> '') then
  begin
    XML.SaveToFile(fileName);
    ShowInfoDialog('Готово', 'Stocurile au fost exportate in fisierul "' + fileName + '".');
  end;
end;

function TfrmExportTo1CDlg.Generate_Перемещение_товаров(const Node: IXMLNode;
  const DocList: TStringList): Integer;
var
  root, node2, node3, node4, node5, node6: IXMLNode;
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT: string;
  FirmaScladCod, FirmaScladName, FirmaScladType: string;
  CTScladCod, CTScladName, CTScladType: string;
  docData: TDateTime;
  AcntID, GoodsQTY, FLG_SERVICIU, UMID: integer;
  GoodsSUMA, GoodsSUMAVAT: Currency;
  AcntTitle, UMTitle: string;
  RecordCount: Integer;
begin
  RecordCount := 0;

  if not IBCQueryP.Eof then
  begin

    root := Node.AddChild('ПеремещениеТоваров');
    root.SetAttributeNS('Тип', '', 'мПеремещениеТоваров');

    while not IBCQueryP.Eof do
    begin
      DocList.Add(IBCQueryP.Fields[0].AsString);

//      docData := StrToDate(DateTimeTo1CTime18Evening(IBCQueryP.Fields[1].AsDateTime));
      FirmaCod := IBCQueryP.Fields[2].AsString;
      FirmaName := IBCQueryP.Fields[3].AsString;
      FirmaIDEN := IBCQueryP.Fields[4].AsString;
      FirmaVAT := IBCQueryP.Fields[5].AsString;
      FirmaScladCod := IBCQueryP.Fields[6].AsString;
      FirmaScladName := IBCQueryP.Fields[7].AsString;
      FirmaScladType := IBCQueryP.Fields[8].AsString;

      CTScladCod := IBCQueryP.Fields[9].AsString;
      CTScladName := IBCQueryP.Fields[10].AsString;
      CTScladType := IBCQueryP.Fields[11].AsString;

          // write xml
      node2 := root.AddChild('ПеремещениеТоваров');
      node2.SetAttributeNS('Тип', '', 'ПеремещениеТоваров');
      node2.SetAttributeNS('Комментарий', '', '');
      node2.SetAttributeNS('Дата', '', DateTimeTo1CTime18Evening(IBCQueryP.Fields
        [1].AsDateTime));

      node3 := node2.AddChild('Организация');
      node3.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node3.SetAttributeNS('Код', '', FirmaCod);
      node3.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node3.SetAttributeNS('ИНН', '', FirmaIDEN);
      node3.SetAttributeNS('КодНДС', '', FirmaVAT);

      node3 := node2.AddChild('СкладОтправитель');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node3 := node2.AddChild('СкладПолучатель');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', CTScladCod);
      node3.SetAttributeNS('Наименование', '', CTScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', CTScladType);

      node3 := node2.AddChild('Товары');
      node3.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

          // goods dataset
      IBCQueryJurnal.Close;
      try
        IBCQueryJurnal.ParamByName('DOCID').AsInteger := IBCQueryP.Fields[0].AsInteger;
          // DocID
        IBCQueryJurnal.Open;
        while not IBCQueryJurnal.Eof do
        begin
                  // get data
          AcntID := IBCQueryJurnal.Fields[1].AsInteger;
          GoodsQTY := IBCQueryJurnal.Fields[2].AsInteger;
          GoodsSUMA := IBCQueryJurnal.Fields[3].AsCurrency;
          AcntTitle := IBCQueryJurnal.Fields[4].AsString;
          FLG_SERVICIU := IBCQueryJurnal.Fields[5].AsInteger;
          UMID := IBCQueryJurnal.Fields[6].AsInteger;
          UMTitle := IBCQueryJurnal.Fields[7].AsString;
          GoodsSUMAVAT := IBCQueryJurnal.Fields[8].AsCurrency;

                  // write XML
          node4 := node3.AddChild('СтрокаТЧ');
          node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
          node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
          node4.SetAttributeNS('Сумма', '', GoodsSUMA);
          node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

          node5 := node4.AddChild('Номенклатура');
          node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          node5.SetAttributeNS('Код', '', IntToStr(AcntID));
          node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
          node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
          node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
          node5.SetAttributeNS('ЭтоГруппа', '', '0');

          node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
          node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
          node6.SetAttributeNS('Код', '', IntToStr(UMID));
          node6.SetAttributeNS('Наименование', '', UMTitle);
          node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
          node6.SetAttributeNS('НаименованиеРус', '', '');

          node6 := node5.AddChild('СтавкаНДС');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
          node6.SetAttributeNS('Ставка', '', '20');

          node6 := node5.AddChild('Родитель');
          node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          if (FLG_SERVICIU = 1) then
            node6.SetAttributeNS('Код', '', '00000000003')
          else
            node6.SetAttributeNS('Код', '', '00000000001');
          node6.SetAttributeNS('ЭтоГруппа', '', '1');

          node5 := node4.AddChild('Склад');
          node5.SetAttributeNS('Тип', '', 'СправочникСклады');
          node5.SetAttributeNS('Код', '', FirmaScladCod);
          node5.SetAttributeNS('Наименование', '', FirmaScladName);

          node6 := node5.AddChild('ВидСклада');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
          node6.SetAttributeNS('ВидСклада', '', FirmaScladType);

          IBCQueryJurnal.Next;
        end;
      finally
        IBCQueryJurnal.Close;
      end;
          // doc, next record
      IBCQueryP.Next;
      Inc(RecordCount);
    end;
  end;
  IBCQueryP.Close;

  Result := RecordCount;
end;

function TfrmExportTo1CDlg.Generate_Поступление_товаров(const Node: IXMLNode;
  const DocList: TStringList): Integer;
var
  root, node2, node3, node4, node5, node6: IXMLNode;
  facturaData: TDateTime;
  facturaSeria, facturaNumar: string;
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT: string;
  FirmaScladCod, FirmaScladName, FirmaScladType: string;
  IDEN, CT_NAME, CT_ADDR1, CT_ADDR2, CT_VAT: string;
  FLG_NEREZIDENT, FLG_JURIDIC: Integer;
  AcntID, GoodsQTY, FLG_SERVICIU, UMID: integer;
  GoodsSUMA, GoodsSUMAVAT: Currency;
  AcntTitle, UMTitle: string;
  RecordCount: Integer;
begin
  RecordCount := 0;

  if not IBCQueryPrihod.Eof then
  begin
    root := Node.AddChild('ДокументыПоступлениеТоваров');
    root.SetAttributeNS('Тип', '', 'мДокументыПоступлениеТоваров');

    while not IBCQueryPrihod.Eof do
    begin
      DocList.Add(IBCQueryPrihod.Fields[0].AsString);

          // get data
      facturaSeria := '';
      facturaNumar := '';
      if not IBCQueryPrihod.Fields[1].IsNull then
        GetFacturaNumberComponents(UpperCase(IBCQueryPrihod.Fields[1].AsString),
          facturaSeria, facturaNumar);
      if IBCQueryPrihod.Fields[2].IsNull then
        facturaData := 0
      else
        facturaData := IBCQueryPrihod.Fields[2].AsDateTime;

      FirmaCod := IBCQueryPrihod.Fields[3].AsString;
      FirmaName := IBCQueryPrihod.Fields[4].AsString;
      FirmaIDEN := IBCQueryPrihod.Fields[5].AsString;
      FirmaVAT := IBCQueryPrihod.Fields[6].AsString;
      FirmaScladCod := IBCQueryPrihod.Fields[7].AsString;
      FirmaScladName := IBCQueryPrihod.Fields[8].AsString;
      FirmaScladType := IBCQueryPrihod.Fields[9].AsString;

      IDEN := IBCQueryPrihod.Fields[10].AsString;
      CT_NAME := IBCQueryPrihod.Fields[11].AsString;
      CT_ADDR1 := IBCQueryPrihod.Fields[12].AsString;
      CT_ADDR2 := IBCQueryPrihod.Fields[13].AsString;
      FLG_NEREZIDENT := IBCQueryPrihod.Fields[14].AsInteger;
      CT_VAT := IBCQueryPrihod.Fields[15].AsString;
      FLG_JURIDIC := IBCQueryPrihod.Fields[16].AsInteger;

          // write xml
      node2 := root.AddChild('ДокументПоступлениеТоваров');
      node2.SetAttributeNS('Тип', '', 'ДокументПоступлениеТоваров');
      node2.SetAttributeNS('Комментарий', '', '');
      node2.SetAttributeNS('DOCID', '', IBCQueryPrihod.Fields[0].AsString);
      node2.SetAttributeNS('НомерСФ', '', facturaNumar);
      node2.SetAttributeNS('СерияСФ', '', facturaSeria);
      node2.SetAttributeNS('ДатаСФ', '', DateTimeTo1CTime8Morning(facturaData));
        // ora este 04:00
      node2.SetAttributeNS('Дата', '', DateTimeTo1CTime8Morning(facturaData));   // ora este 04:00
      node2.SetAttributeNS('УчитыватьНДС', '', '1');
      node2.SetAttributeNS('СуммаВключаетНДС', '', '1');

      node3 := node2.AddChild('Организация');
      node3.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node3.SetAttributeNS('Код', '', FirmaCod);
      node3.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node3.SetAttributeNS('ИНН', '', FirmaIDEN);
      node3.SetAttributeNS('КодНДС', '', FirmaVAT);

      node3 := node2.AddChild('Склад');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node3 := node2.AddChild('ВалютаДокумента');
      node3.SetAttributeNS('Тип', '', 'СправочникВалюты');
      node3.SetAttributeNS('Код', '', '498');
      node3.SetAttributeNS('Наименование', '', 'MDL');
      node3.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

      node3 := node2.AddChild('Контрагент');
      node3.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node3.SetAttributeNS('ФискальныйКод', '', IDEN);
      node3.SetAttributeNS('Наименование', '', Copy(CT_NAME, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', CT_NAME);
      node3.SetAttributeNS('Комментарий', '', '');
      node3.SetAttributeNS('ЭтоГруппа', '', '0');
      node3.SetAttributeNS('ПочтовыйАдрес', '', CT_ADDR1);
      node3.SetAttributeNS('ЮридическийАдрес', '', CT_ADDR2);
      node3.SetAttributeNS('ДокументУдостоверяющийЛичность', '', '');
      node3.SetAttributeNS('НеРезидент', '', IntToStr(FLG_NEREZIDENT));
      node3.SetAttributeNS('КодНДС', '', CT_VAT);
      if FLG_JURIDIC = 1 then
        node3.SetAttributeNS('ВидКонтрагента', '', 'Persoana juridica')
      else
        node3.SetAttributeNS('ВидКонтрагента', '', 'Persoana fizica');

      node4 := node3.AddChild('Родитель');
      node4.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node4.SetAttributeNS('Наименование', '', 'Покупатели');
      node4.SetAttributeNS('Код', '', '000000001');
      node4.SetAttributeNS('ЭтоГруппа', '', '1');

      node3 := node2.AddChild('Товары');
      node3.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

          // goods dataset
      IBCQueryJurnal.Close;
      try
        IBCQueryJurnal.ParamByName('DOCID').AsInteger := IBCQueryPrihod.Fields[0].AsInteger;
          // DocID
        IBCQueryJurnal.Open;
        while not IBCQueryJurnal.Eof do
        begin
                  // get data
          AcntID := IBCQueryJurnal.Fields[1].AsInteger;
          GoodsQTY := IBCQueryJurnal.Fields[2].AsInteger;
          GoodsSUMA := IBCQueryJurnal.Fields[3].AsCurrency;
          AcntTitle := IBCQueryJurnal.Fields[4].AsString;
          FLG_SERVICIU := IBCQueryJurnal.Fields[5].AsInteger;
          UMID := IBCQueryJurnal.Fields[6].AsInteger;
          UMTitle := IBCQueryJurnal.Fields[7].AsString;
          GoodsSUMAVAT := IBCQueryJurnal.Fields[8].AsCurrency;

                  // write XML
          node4 := node3.AddChild('СтрокаТЧ');
          node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
          node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
          node4.SetAttributeNS('Сумма', '', GoodsSUMA);
          node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

          node5 := node4.AddChild('Номенклатура');
          node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          node5.SetAttributeNS('Код', '', IntToStr(AcntID));
          node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
          node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
          node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
          node5.SetAttributeNS('ЭтоГруппа', '', '0');

          node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
          node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
          node6.SetAttributeNS('Код', '', IntToStr(UMID));
          node6.SetAttributeNS('Наименование', '', UMTitle);
          node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
          node6.SetAttributeNS('НаименованиеРус', '', '');

          node6 := node5.AddChild('СтавкаНДС');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
          node6.SetAttributeNS('Ставка', '', '20');

          node6 := node5.AddChild('Родитель');
          node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          if (FLG_SERVICIU = 1) then
            node6.SetAttributeNS('Код', '', '00000000003')
          else
            node6.SetAttributeNS('Код', '', '00000000001');
          node6.SetAttributeNS('ЭтоГруппа', '', '1');

          node5 := node4.AddChild('Склад');
          node5.SetAttributeNS('Тип', '', 'СправочникСклады');
          node5.SetAttributeNS('Код', '', FirmaScladCod);
          node5.SetAttributeNS('Наименование', '', FirmaScladName);

          node6 := node5.AddChild('ВидСклада');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
          node6.SetAttributeNS('ВидСклада', '', FirmaScladType);

          IBCQueryJurnal.Next;
        end;
      finally
        IBCQueryJurnal.Close;
      end;

          // done, goto next record
      IBCQueryPrihod.Next;
      Inc(RecordCount);
    end;
  end;
  Result := RecordCount;
end;

function TfrmExportTo1CDlg.Generate_Реализация_товаров1(const Node: IXMLNode;
  const DocList: TStringList): Integer;
var
  root, node2, node3, node4, node5, node6: IXMLNode;
  facturaData: TDateTime;
  facturaSeria, facturaNumar: string;
  docDT, docCT: integer;
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT: string;
  FirmaScladCod, FirmaScladName, FirmaScladType: string;
  IDEN, CT_NAME, CT_ADDR1, CT_ADDR2, CT_VAT: string;
  FLG_NEREZIDENT, FLG_JURIDIC: Integer;
  AcntID, GoodsQTY, FLG_SERVICIU, UMID, FLG_COMPLECT: integer;
  GoodsSUMA, docVAT, GoodsSUMAVAT: Currency;
  AcntTitle, UMTitle: string;
  docData: TDateTime;
  RecordCount: Integer;
  dinNeuronInGama: Boolean;
  node2_2, node3_2, nodePostuplenie: IXMLNode;
  FirmaCod2, FirmaName2, FirmaIDEN2, FirmaVAT2: string;
  FirmaScladCod2, FirmaScladName2, FirmaScladType2: string;
  IDEN2, CT_NAME2, CT_ADDR12, CT_ADDR22, CT_VAT2: string;
  FLG_NEREZIDENT2, FLG_JURIDIC2: Integer;
begin
  RecordCount := 0;

  if not IBCQuerySF.Eof then
  begin
    root := Node.AddChild('ДокументыРеализацияТоваров');
    root.SetAttributeNS('Тип', '', 'мДокументыРеализацияТоваров');

    while not IBCQuerySF.Eof do
    begin
      DocList.Add(IBCQuerySF.Fields[0].AsString);
          // get data
      facturaSeria := '';
      facturaNumar := '';
      GetFacturaNumberComponents(UpperCase(IBCQuerySF.Fields[1].AsString),
        facturaSeria, facturaNumar);
      facturaData := IBCQuerySF.Fields[2].AsDateTime;

      FirmaCod := IBCQuerySF.Fields[3].AsString;
      FirmaName := IBCQuerySF.Fields[4].AsString;
      FirmaIDEN := IBCQuerySF.Fields[5].AsString;
      FirmaVAT := IBCQuerySF.Fields[6].AsString;
      FirmaScladCod := IBCQuerySF.Fields[7].AsString;
      FirmaScladName := IBCQuerySF.Fields[8].AsString;
      FirmaScladType := IBCQuerySF.Fields[9].AsString;

      IDEN := IBCQuerySF.Fields[10].AsString;
      CT_NAME := IBCQuerySF.Fields[11].AsString;
      CT_ADDR1 := IBCQuerySF.Fields[12].AsString;
      CT_ADDR2 := IBCQuerySF.Fields[13].AsString;
      FLG_NEREZIDENT := IBCQuerySF.Fields[14].AsInteger;
      CT_VAT := IBCQuerySF.Fields[15].AsString;
      FLG_JURIDIC := IBCQuerySF.Fields[16].AsInteger;

      docVAT := IBCQuerySF.Fields[17].AsCurrency;

      // write xml
      node2 := root.AddChild('ДокументРеализацияТоваров');
      node2.SetAttributeNS('Тип', '', 'ДокументРеализацияТоваров');
      node2.SetAttributeNS('Комментарий', '', '');
      node2.SetAttributeNS('НомерСФ', '', facturaNumar);
      node2.SetAttributeNS('СерияСФ', '', facturaSeria);
      node2.SetAttributeNS('ДатаСФ', '', DateTimeTo1CTime(facturaData));
      node2.SetAttributeNS('Дата', '', DateTimeTo1CTime18Evening(IBCQuerySF.Fields
        [18].AsDateTime));
      if (docVAT > 0) then
      begin
        node2.SetAttributeNS('УчитыватьНДС', '', '1');
        node2.SetAttributeNS('СуммаВключаетНДС', '', '1');
      end
      else
      begin
        node2.SetAttributeNS('УчитыватьНДС', '', '0');
        node2.SetAttributeNS('СуммаВключаетНДС', '', '0');
      end;

      node3 := node2.AddChild('Организация');
      node3.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node3.SetAttributeNS('Код', '', FirmaCod);
      node3.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node3.SetAttributeNS('ИНН', '', FirmaIDEN);
      node3.SetAttributeNS('КодНДС', '', FirmaVAT);

      node3 := node2.AddChild('Склад');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node3 := node2.AddChild('ВалютаДокумента');
      node3.SetAttributeNS('Тип', '', 'СправочникВалюты');
      node3.SetAttributeNS('Код', '', '498');
      node3.SetAttributeNS('Наименование', '', 'MDL');
      node3.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

      node3 := node2.AddChild('Контрагент');
      node3.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node3.SetAttributeNS('ФискальныйКод', '', IDEN);
      node3.SetAttributeNS('Наименование', '', Copy(CT_NAME, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', CT_NAME);
      node3.SetAttributeNS('Комментарий', '', '');
      node3.SetAttributeNS('ЭтоГруппа', '', '0');
      node3.SetAttributeNS('ПочтовыйАдрес', '', CT_ADDR1);
      node3.SetAttributeNS('ЮридическийАдрес', '', CT_ADDR2);
      node3.SetAttributeNS('ДокументУдостоверяющийЛичность', '', '');
      node3.SetAttributeNS('НеРезидент', '', IntToStr(FLG_NEREZIDENT));
      node3.SetAttributeNS('КодНДС', '', CT_VAT);

      if FLG_JURIDIC = 1 then
        node3.SetAttributeNS('ВидКонтрагента', '', 'Persoana juridica')
      else
        node3.SetAttributeNS('ВидКонтрагента', '', 'Persoana fizica');

      node4 := node3.AddChild('Родитель');
      node4.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node4.SetAttributeNS('Наименование', '', 'Покупатели');
      node4.SetAttributeNS('Код', '', '000000001');
      node4.SetAttributeNS('ЭтоГруппа', '', '1');

      dinNeuronInGama := false;
          {
          // caz special: Realizarea Neuron spre Gama*, creaza un document aditional de Intrare a produselor in Gama*
          dinNeuronInGama:=(docDT=5213) and ((docCT=12057) OR (docCT=72699));
          node3_2:=nil;

          if (dinNeuronInGama) then
          begin
               // verificam daca exista nodul pentru Intrare Marfa
               nodePostuplenie:=Node.ChildNodes.FindNode('ДокументыПоступлениеТоваров');
               if (nodePostuplenie=nil) then
               begin
                    // create node "Intrare Marfa"
                    nodePostuplenie:=Node.AddChild('ДокументыПоступлениеТоваров');
                    nodePostuplenie.SetAttributeNS('Тип','','мДокументыПоступлениеТоваров');
               end;
               IBCQueryPrinhodInfo.Close;
               IBCQueryPrinhodInfo.ParamByName('DT').AsInteger:=docCT;
               IBCQueryPrinhodInfo.ParamByName('CT').AsInteger:=docDT;
               IBCQueryPrinhodInfo.ExecSQL;
               if IBCQueryPrinhodInfo.Eof then raise Exception.Create('Nu pot obtine informatia pespre contribuabili la momentul crearii "Intrare Marfa" din "Realizare marfa SF"!');

               // citim datele
               FirmaCod2:=IBCQueryPrinhodInfo.Fields[0].AsString;
               FirmaName2:=IBCQueryPrinhodInfo.Fields[1].AsString;
               FirmaIDEN2:=IBCQueryPrinhodInfo.Fields[2].AsString;
               FirmaVAT2:=IBCQueryPrinhodInfo.Fields[3].AsString;
               FirmaScladCod2:=IBCQueryPrinhodInfo.Fields[4].AsString;
               FirmaScladName2:=IBCQueryPrinhodInfo.Fields[5].AsString;
               FirmaScladType2:=IBCQueryPrinhodInfo.Fields[6].AsString;

               IDEN2:=IBCQueryPrinhodInfo.Fields[7].AsString;
               CT_NAME2:=IBCQueryPrinhodInfo.Fields[8].AsString;
               CT_ADDR12:=IBCQueryPrinhodInfo.Fields[9].AsString;
               CT_ADDR22:=IBCQueryPrinhodInfo.Fields[10].AsString;
               FLG_NEREZIDENT2:=IBCQueryPrinhodInfo.Fields[11].AsInteger;
               CT_VAT2:=IBCQueryPrinhodInfo.Fields[12].AsString;
               FLG_JURIDIC2:=IBCQueryPrinhodInfo.Fields[13].AsInteger;

               IBCQueryPrinhodInfo.Close;

               // add new document
               node2_2:=nodePostuplenie.AddChild('ДокументПоступлениеТоваров');
               node2_2.SetAttributeNS('Тип','','ДокументПоступлениеТоваров');
               node2_2.SetAttributeNS('Комментарий','','');
               node2_2.SetAttributeNS('НомерСФ','',facturaNumar);
               node2_2.SetAttributeNS('СерияСФ','',facturaSeria);
               node2_2.SetAttributeNS('ДатаСФ','',DateTimeTo1CTime(facturaData));
               node2_2.SetAttributeNS('Дата','',DateTimeTo1CTime(facturaData));
               node2_2.SetAttributeNS('УчитыватьНДС','','1');
               node2_2.SetAttributeNS('СуммаВключаетНДС','','1');

               node3:=node2_2.AddChild('Организация');
               node3.SetAttributeNS('Тип','','СправочникОрганизация');
               node3.SetAttributeNS('Код','',FirmaCod2);
               node3.SetAttributeNS('Наименование','',Copy(FirmaName2,1,50));
               node3.SetAttributeNS('НаименованиеПолное','',FirmaName2);
               node3.SetAttributeNS('ИНН','',FirmaIDEN2);
               node3.SetAttributeNS('КодНДС','',FirmaVAT2);

               node3:=node2_2.AddChild('Склад');
               node3.SetAttributeNS('Тип','','СправочникСклады');
               node3.SetAttributeNS('Код','',FirmaScladCod2);
               node3.SetAttributeNS('Наименование','',FirmaScladName2);

               node4:=node3.AddChild('ВидСклада');
               node4.SetAttributeNS('Тип','','ПеречислениеВидыСкладов');
               node4.SetAttributeNS('ВидСклада','',FirmaScladType2);

               node3:=node2_2.AddChild('ВалютаДокумента');
               node3.SetAttributeNS('Тип','','СправочникВалюты');
               node3.SetAttributeNS('Код','','498');
               node3.SetAttributeNS('Наименование','','MDL');
               node3.SetAttributeNS('НаименованиеПолное','','Leu moldovenesc');

               node3:=node2_2.AddChild('Контрагент');
               node3.SetAttributeNS('Тип','','СправочникКонтрагенты');
               node3.SetAttributeNS('ФискальныйКод','',IDEN2);
               node3.SetAttributeNS('Наименование','',Copy(CT_NAME2,1,50));
               node3.SetAttributeNS('НаименованиеПолное','',CT_NAME2);
               node3.SetAttributeNS('Комментарий','','');
               node3.SetAttributeNS('ЭтоГруппа','','0');
               node3.SetAttributeNS('ПочтовыйАдрес','',CT_ADDR12);
               node3.SetAttributeNS('ЮридическийАдрес','',CT_ADDR22);
               node3.SetAttributeNS('ДокументУдостоверяющийЛичность','','');
               node3.SetAttributeNS('НеРезидент','',IntToStr(FLG_NEREZIDENT2));
               node3.SetAttributeNS('КодНДС','',CT_VAT2);
               if FLG_JURIDIC2=1
                  then node3.SetAttributeNS('ВидКонтрагента','','Persoana juridica')
                  else node3.SetAttributeNS('ВидКонтрагента','','Persoana fizica');

               node4:=node3.AddChild('Родитель');
               node4.SetAttributeNS('Тип','','СправочникКонтрагенты');
               node4.SetAttributeNS('Наименование','','Покупатели');
               node4.SetAttributeNS('Код','','000000001');
               node4.SetAttributeNS('ЭтоГруппа','','1');

               node3_2:=node2_2.AddChild('Товары');
               node3_2.SetAttributeNS('Тип','','ТабличнаяЧастьТовары');
          end;
          }

      node3 := node2.AddChild('Товары');
      node3.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

          // goods dataset
      IBCQuerySF_Goods.Close;
      try
        IBCQuerySF_Goods.ParamByName('DOCID').AsInteger := IBCQuerySF.Fields[0].AsInteger;
          // DocID
        IBCQuerySF_Goods.Open;
        while not IBCQuerySF_Goods.Eof do
        begin
                  // get data
          AcntID := IBCQuerySF_Goods.Fields[1].AsInteger;
          GoodsQTY := IBCQuerySF_Goods.Fields[2].AsInteger;
          GoodsSUMA := IBCQuerySF_Goods.Fields[3].AsCurrency;
          AcntTitle := IBCQuerySF_Goods.Fields[4].AsString;
          FLG_SERVICIU := IBCQuerySF_Goods.Fields[5].AsInteger;
          UMID := IBCQuerySF_Goods.Fields[6].AsInteger;
          UMTitle := IBCQuerySF_Goods.Fields[7].AsString;
          GoodsSUMAVAT := IBCQuerySF_Goods.Fields[8].AsCurrency;
          FLG_COMPLECT := IBCQuerySF_Goods.Fields[9].AsInteger;

                  // write XML
          node4 := node3.AddChild('СтрокаТЧ');
          node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
          node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
          node4.SetAttributeNS('Сумма', '', GoodsSUMA);
          node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

          node5 := node4.AddChild('Номенклатура');
          node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          node5.SetAttributeNS('Код', '', IntToStr(AcntID));
          node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
          node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
          node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
          node5.SetAttributeNS('Комплект', '', IntToStr(FLG_COMPLECT));
          node5.SetAttributeNS('ЭтоГруппа', '', '0');

          node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
          node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
          node6.SetAttributeNS('Код', '', IntToStr(UMID));
          node6.SetAttributeNS('Наименование', '', UMTitle);
          node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
          node6.SetAttributeNS('НаименованиеРус', '', '');

          node6 := node5.AddChild('СтавкаНДС');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
          if (docVAT > 0) then
            node6.SetAttributeNS('Ставка', '', '20')
          else
            node6.SetAttributeNS('Ставка', '', '0');

          node6 := node5.AddChild('Родитель');
          node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          if (FLG_SERVICIU = 1) then
            node6.SetAttributeNS('Код', '', '00000000003')
          else
            node6.SetAttributeNS('Код', '', '00000000001');
          node6.SetAttributeNS('ЭтоГруппа', '', '1');

          node5 := node4.AddChild('Склад');
          node5.SetAttributeNS('Тип', '', 'СправочникСклады');
          node5.SetAttributeNS('Код', '', FirmaScladCod);
          node5.SetAttributeNS('Наименование', '', FirmaScladName);

          node6 := node5.AddChild('ВидСклада');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
          node6.SetAttributeNS('ВидСклада', '', FirmaScladType);

                  // fix
          if dinNeuronInGama and (node3_2 <> nil) then
          begin
            node4 := node3_2.AddChild('СтрокаТЧ');
            node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
            node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
            node4.SetAttributeNS('Сумма', '', GoodsSUMA);
            node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

            node5 := node4.AddChild('Номенклатура');
            node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
            node5.SetAttributeNS('Код', '', IntToStr(AcntID));
            node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
            node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
            node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
            node5.SetAttributeNS('ЭтоГруппа', '', '0');

            node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
            node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
            node6.SetAttributeNS('Код', '', IntToStr(UMID));
            node6.SetAttributeNS('Наименование', '', UMTitle);
            node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
            node6.SetAttributeNS('НаименованиеРус', '', '');

            node6 := node5.AddChild('СтавкаНДС');
            node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
            if (docVAT > 0) then
              node6.SetAttributeNS('Ставка', '', '20')
            else
              node6.SetAttributeNS('Ставка', '', '0');

            node6 := node5.AddChild('Родитель');
            node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
            if (FLG_SERVICIU = 1) then
              node6.SetAttributeNS('Код', '', '00000000003')
            else
              node6.SetAttributeNS('Код', '', '00000000001');
            node6.SetAttributeNS('ЭтоГруппа', '', '1');

            node5 := node4.AddChild('Склад');
            node5.SetAttributeNS('Тип', '', 'СправочникСклады');
            node5.SetAttributeNS('Код', '', FirmaScladCod2);
            node5.SetAttributeNS('Наименование', '', FirmaScladName2);

            node6 := node5.AddChild('ВидСклада');
            node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
            node6.SetAttributeNS('ВидСклада', '', FirmaScladType2);
          end;

          IBCQuerySF_Goods.Next;
        end;
      finally
        IBCQuerySF_Goods.Close;
      end;

          // done, goto next record
      IBCQuerySF.Next;
      Inc(RecordCount);
    end;
  end;
  Result := RecordCount;
end;

function TfrmExportTo1CDlg.Generate_Реализация_товаров2(const Node: IXMLNode;
  const DocList: TStringList): Integer;
var
  root, node2, node3, node4, node5, node6: IXMLNode;
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT: string;
  FirmaScladCod, FirmaScladName, FirmaScladType: string;
  IDEN, CT_NAME, CT_ADDR1, CT_ADDR2, CT_VAT: string;
  FLG_NEREZIDENT: Integer;
  AcntID, GoodsQTY, FLG_SERVICIU, UMID, FLG_COMPLECT: integer;
  GoodsSUMA, GoodsSUMAVAT: Currency;
  AcntTitle, UMTitle: string;
  docData: TDateTime;
  RecordCount: Integer;
begin
  RecordCount := DocList.Count;

  if not IBCQueryReceipt.Eof then
  begin
    root := Node.AddChild('ДокументыРеализацияТоваров');
    root.SetAttributeNS('Тип', '', 'мДокументыРеализацияТоваров');

    while not IBCQueryReceipt.Eof do
    begin
          // get data
      FirmaCod := IBCQueryReceipt.Fields[2].AsString;
      FirmaName := IBCQueryReceipt.Fields[3].AsString;
      FirmaIDEN := IBCQueryReceipt.Fields[4].AsString;
      FirmaVAT := IBCQueryReceipt.Fields[5].AsString;
      FirmaScladCod := IBCQueryReceipt.Fields[6].AsString;
      FirmaScladName := IBCQueryReceipt.Fields[7].AsString;
      FirmaScladType := IBCQueryReceipt.Fields[8].AsString;
      IDEN := IBCQueryReceipt.Fields[9].AsString;
      CT_NAME := IBCQueryReceipt.Fields[10].AsString;

      CT_ADDR1 := '';
      CT_ADDR2 := '';
      FLG_NEREZIDENT := 0;
      CT_VAT := '';

      docData := IBCQueryReceipt.Fields[1].AsDateTime;

          // write xml
      node2 := root.AddChild('ДокументРеализацияТоваров');
      node2.SetAttributeNS('Тип', '', 'ДокументРеализацияТоваров');
      node2.SetAttributeNS('Комментарий', '', '');
      node2.SetAttributeNS('НомерСФ', '', '');
      node2.SetAttributeNS('СерияСФ', '', '');
      node2.SetAttributeNS('ДатаСФ', '', '');
      node2.SetAttributeNS('Дата', '', DateTimeTo1CTime(docData));
      node2.SetAttributeNS('УчитыватьНДС', '', '1');
      node2.SetAttributeNS('СуммаВключаетНДС', '', '1');

      node3 := node2.AddChild('Организация');
      node3.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node3.SetAttributeNS('Код', '', FirmaCod);
      node3.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node3.SetAttributeNS('ИНН', '', FirmaIDEN);
      node3.SetAttributeNS('КодНДС', '', FirmaVAT);

      node3 := node2.AddChild('Склад');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node3 := node2.AddChild('ВалютаДокумента');
      node3.SetAttributeNS('Тип', '', 'СправочникВалюты');
      node3.SetAttributeNS('Код', '', '498');
      node3.SetAttributeNS('Наименование', '', 'MDL');
      node3.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

      node3 := node2.AddChild('Контрагент');
      node3.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node3.SetAttributeNS('ФискальныйКод', '', IDEN);
      node3.SetAttributeNS('Наименование', '', Copy(CT_NAME, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', CT_NAME);
      node3.SetAttributeNS('Комментарий', '', '');
      node3.SetAttributeNS('ЭтоГруппа', '', '0');
      node3.SetAttributeNS('ПочтовыйАдрес', '', CT_ADDR1);
      node3.SetAttributeNS('ЮридическийАдрес', '', CT_ADDR2);
      node3.SetAttributeNS('ДокументУдостоверяющийЛичность', '', '');
      node3.SetAttributeNS('НеРезидент', '', IntToStr(FLG_NEREZIDENT));
      node3.SetAttributeNS('КодНДС', '', CT_VAT);
      //  implicit persoana care cumprara cu numerar este persoana fizica
      node3.SetAttributeNS('ВидКонтрагента', '', 'Persoana fizica');

      node4 := node3.AddChild('Родитель');
      node4.SetAttributeNS('Тип', '', 'СправочникКонтрагенты');
      node4.SetAttributeNS('Наименование', '', 'Покупатели');
      node4.SetAttributeNS('Код', '', '000000001');
      node4.SetAttributeNS('ЭтоГруппа', '', '1');

      node3 := node2.AddChild('Товары');
      node3.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

          // goods dataset
      IBCQueryReceiptGoods.Close;
      try
        IBCQueryReceiptGoods.ParamByName('FIRMA').AsInteger := IBCQueryReceipt.Fields
          [0].AsInteger; // DT
        IBCQueryReceiptGoods.ParamByName('DATA').AsDateTime := IBCQueryReceipt.Fields
          [1].AsDateTime; // DATA
        IBCQueryReceiptGoods.ParamByName('DOCLIST').AsString := fDocList.CommaText;
          // lista presetata de documente
        IBCQueryReceiptGoods.ParamByName('FLG_NO_FILTER').AsInteger := Ord(cbTestOnly.Checked);
          // !!! test only

        IBCQueryReceiptGoods.Open;
        while not IBCQueryReceiptGoods.Eof do
        begin
          DocList.Add(IBCQueryReceiptGoods.Fields[9].AsString);
          AcntID := IBCQueryReceiptGoods.Fields[1].AsInteger;
          GoodsQTY := IBCQueryReceiptGoods.Fields[2].AsInteger;
          GoodsSUMA := IBCQueryReceiptGoods.Fields[3].AsCurrency;
          AcntTitle := IBCQueryReceiptGoods.Fields[4].AsString;
          FLG_SERVICIU := IBCQueryReceiptGoods.Fields[5].AsInteger;
          UMID := IBCQueryReceiptGoods.Fields[6].AsInteger;
          UMTitle := IBCQueryReceiptGoods.Fields[7].AsString;
          GoodsSUMAVAT := IBCQueryReceiptGoods.Fields[8].AsCurrency;
          FLG_COMPLECT := IBCQueryReceiptGoods.Fields[10].AsInteger;

                  // write XML
          node4 := node3.AddChild('СтрокаТЧ');
          node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
          node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
          node4.SetAttributeNS('Сумма', '', GoodsSUMA);
          node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

          node5 := node4.AddChild('Номенклатура');
          node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          node5.SetAttributeNS('Код', '', IntToStr(AcntID));
          node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
          node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
          node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
          node5.SetAttributeNS('Комплект', '', IntToStr(FLG_COMPLECT));
          node5.SetAttributeNS('ЭтоГруппа', '', '0');

          node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
          node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
          node6.SetAttributeNS('Код', '', IntToStr(UMID));
          node6.SetAttributeNS('Наименование', '', UMTitle);
          node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
          node6.SetAttributeNS('НаименованиеРус', '', '');

          node6 := node5.AddChild('СтавкаНДС');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
          node6.SetAttributeNS('Ставка', '', '20');

          node6 := node5.AddChild('Родитель');
          node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          if (FLG_SERVICIU = 1) then
            node6.SetAttributeNS('Код', '', '00000000003')
          else
            node6.SetAttributeNS('Код', '', '00000000001');
          node6.SetAttributeNS('ЭтоГруппа', '', '1');

          node5 := node4.AddChild('Склад');
          node5.SetAttributeNS('Тип', '', 'СправочникСклады');
          node5.SetAttributeNS('Код', '', FirmaScladCod);
          node5.SetAttributeNS('Наименование', '', FirmaScladName);

          node6 := node5.AddChild('ВидСклада');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
          node6.SetAttributeNS('ВидСклада', '', FirmaScladType);

          IBCQueryReceiptGoods.Next;
        end;
      finally
        IBCQueryReceiptGoods.Close;
      end;

          // done, goto next record
      IBCQueryReceipt.Next;
    end;
  end;
  Result := DocList.Count - RecordCount;
end;

procedure TfrmExportTo1CDlg.Generate_Списание_Материалов_В_Производстве(const
  Node: IXMLNode);
var
  root, node2, node3, node4, node5, node6: IXMLNode;
  facturaData: TDateTime;
  facturaSeria, facturaNumar: string;
  FirmaCod, FirmaName, FirmaIDEN, FirmaVAT: string;
  FirmaScladCod, FirmaScladName, FirmaScladType: string;
  docVAT: Currency;
  docData: TDateTime;
  AcntID, GoodsQTY, FLG_SERVICIU, UMID, FLG_COMPLECT: integer;
  GoodsSUMA, GoodsSUMAVAT: Currency;
  AcntTitle, UMTitle: string;
begin
  if not IBCQuerySF_Complecte.Eof then
  begin
    root := Node.AddChild('ДокументыСписаниеМатериаловВПроизводстве');
    root.SetAttributeNS('Тип', '', 'мДокументыСписаниеМатериаловВПроизводстве');

    while not IBCQuerySF_Complecte.Eof do
    begin
      facturaSeria := '';
      facturaNumar := '';
      GetFacturaNumberComponents(UpperCase(IBCQuerySF_Complecte.Fields[1].AsString),
        facturaSeria, facturaNumar);
      facturaData := IBCQuerySF_Complecte.Fields[2].AsDateTime;

      FirmaCod := IBCQuerySF_Complecte.Fields[3].AsString;
      FirmaName := IBCQuerySF_Complecte.Fields[4].AsString;
      FirmaIDEN := IBCQuerySF_Complecte.Fields[5].AsString;
      FirmaVAT := IBCQuerySF_Complecte.Fields[6].AsString;
      FirmaScladCod := IBCQuerySF_Complecte.Fields[7].AsString;
      FirmaScladName := IBCQuerySF_Complecte.Fields[8].AsString;
      FirmaScladType := IBCQuerySF_Complecte.Fields[9].AsString;

      docVAT := IBCQuerySF_Complecte.Fields[17].AsCurrency;
      docData := IBCQuerySF_Complecte.Fields[18].AsDateTime;

               // write in xml
      node2 := root.AddChild('ДокументСписаниеМатериаловВПроизводстве');
      node2.SetAttributeNS('Тип', '', 'ДокументСписаниеМатериаловВПроизводстве');
      node2.SetAttributeNS('НомерСФ', '', facturaNumar);
      node2.SetAttributeNS('СерияСФ', '', facturaSeria);
      node2.SetAttributeNS('ДатаСФ', '', DateTimeTo1CTime(facturaData));
      node2.SetAttributeNS('Дата', '', DateTimeTo1CTime(docData));
      if (docVAT > 0) then
      begin
        node2.SetAttributeNS('УчитыватьНДС', '', '1');
        node2.SetAttributeNS('СуммаВключаетНДС', '', '1');
      end
      else
      begin
        node2.SetAttributeNS('УчитыватьНДС', '', '0');
        node2.SetAttributeNS('СуммаВключаетНДС', '', '0');
      end;

      node3 := node2.AddChild('Организация');
      node3.SetAttributeNS('Тип', '', 'СправочникОрганизация');
      node3.SetAttributeNS('Код', '', FirmaCod);
      node3.SetAttributeNS('Наименование', '', Copy(FirmaName, 1, 50));
      node3.SetAttributeNS('НаименованиеПолное', '', FirmaName);
      node3.SetAttributeNS('ИНН', '', FirmaIDEN);
      node3.SetAttributeNS('КодНДС', '', FirmaVAT);

      node3 := node2.AddChild('Склад');
      node3.SetAttributeNS('Тип', '', 'СправочникСклады');
      node3.SetAttributeNS('Код', '', FirmaScladCod);
      node3.SetAttributeNS('Наименование', '', FirmaScladName);

      node4 := node3.AddChild('ВидСклада');
      node4.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
      node4.SetAttributeNS('ВидСклада', '', FirmaScladType);

      node3 := node2.AddChild('ВалютаДокумента');
      node3.SetAttributeNS('Тип', '', 'СправочникВалюты');
      node3.SetAttributeNS('Код', '', '498');
      node3.SetAttributeNS('Наименование', '', 'MDL');
      node3.SetAttributeNS('НаименованиеПолное', '', 'Leu moldovenesc');

               // ----- Marfuri -------
      node3 := node2.AddChild('Товары');
      node3.SetAttributeNS('Тип', '', 'ТабличнаяЧастьТовары');

               // goods dataset
      IBCQuerySF_ComplecteGoods.Close;
      try
        IBCQuerySF_ComplecteGoods.ParamByName('DOCID').AsInteger :=
          IBCQuerySF_Complecte.Fields[0].AsInteger; // DocID
        IBCQuerySF_ComplecteGoods.Open;
        while not IBCQuerySF_ComplecteGoods.Eof do
        begin
                       // goods data
          AcntID := IBCQuerySF_ComplecteGoods.Fields[1].AsInteger;
          GoodsQTY := IBCQuerySF_ComplecteGoods.Fields[2].AsInteger;
          GoodsSUMA := IBCQuerySF_ComplecteGoods.Fields[3].AsCurrency;
          AcntTitle := IBCQuerySF_ComplecteGoods.Fields[4].AsString;
          FLG_SERVICIU := IBCQuerySF_ComplecteGoods.Fields[5].AsInteger;
          UMID := IBCQuerySF_ComplecteGoods.Fields[6].AsInteger;
          UMTitle := IBCQuerySF_ComplecteGoods.Fields[7].AsString;
          GoodsSUMAVAT := IBCQuerySF_ComplecteGoods.Fields[8].AsCurrency;
          FLG_COMPLECT := IBCQuerySF_ComplecteGoods.Fields[9].AsInteger;

                       // write in XML
          node4 := node3.AddChild('СтрокаТЧ');
          node4.SetAttributeNS('Тип', '', 'СтрокаТЧ');
          node4.SetAttributeNS('Количество', '', IntToStr(GoodsQTY));
          node4.SetAttributeNS('Сумма', '', GoodsSUMA);
          node4.SetAttributeNS('СуммаНДС', '', GoodsSUMAVAT);

          node5 := node4.AddChild('Номенклатура');
          node5.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          node5.SetAttributeNS('Код', '', IntToStr(AcntID));
          node5.SetAttributeNS('Наименование', '', Copy(AcntTitle, 1, 50));
          node5.SetAttributeNS('НаименованиеПолное', '', AcntTitle);
          node5.SetAttributeNS('Услуга', '', IntToStr(FLG_SERVICIU));
          node5.SetAttributeNS('Комплект', '', IntToStr(FLG_COMPLECT));
          node5.SetAttributeNS('ЭтоГруппа', '', '0');

          node6 := node5.AddChild('БазоваяЕдиницаИзмерения');
          node6.SetAttributeNS('Тип', '', 'СправочникЕдиницыИзмерения');
          node6.SetAttributeNS('Код', '', IntToStr(UMID));
          node6.SetAttributeNS('Наименование', '', UMTitle);
          node6.SetAttributeNS('НаименованиеГос', '', UMTitle);
          node6.SetAttributeNS('НаименованиеРус', '', '');

          node6 := node5.AddChild('СтавкаНДС');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеСтавкиНДС');
          if (docVAT > 0) then
            node6.SetAttributeNS('Ставка', '', '20')
          else
            node6.SetAttributeNS('Ставка', '', '0');

          node6 := node5.AddChild('Родитель');
          node6.SetAttributeNS('Тип', '', 'СправочникНоменклатура');
          if (FLG_SERVICIU = 1) then
            node6.SetAttributeNS('Код', '', '00000000003')
          else
            node6.SetAttributeNS('Код', '', '00000000001');
          node6.SetAttributeNS('ЭтоГруппа', '', '1');

          node5 := node4.AddChild('Склад');
          node5.SetAttributeNS('Тип', '', 'СправочникСклады');
          node5.SetAttributeNS('Код', '', FirmaScladCod);
          node5.SetAttributeNS('Наименование', '', FirmaScladName);

          node6 := node5.AddChild('ВидСклада');
          node6.SetAttributeNS('Тип', '', 'ПеречислениеВидыСкладов');
          node6.SetAttributeNS('ВидСклада', '', FirmaScladType);

                       // next record
          IBCQuerySF_ComplecteGoods.Next;
        end;
      finally

      end;
               // next record
      IBCQuerySF_Complecte.Next;
    end;
  end;
end;

{$WARN SYMBOL_PLATFORM OFF }
procedure TfrmExportTo1CDlg.GetFacturaNumberComponents(const SourceText: string;
  var FacrturaSeria, FacturaNumar: string);
var
  i: integer;
begin
  i := 1;
  while (i < Length(SourceText)) and CharInSet(SourceText[i], ['A'..'Z']) do
    Inc(i);
  FacrturaSeria := Copy(SourceText, 1, i - 1);
  FacturaNumar := Copy(SourceText, i, Length(SourceText));
end;

function TfrmExportTo1CDlg.GetFirmaEndIDList: string;
var
  i: integer;
  item: TcxCheckComboBoxItem;
begin
  Result := '';
  for i := 0 to ccbFirmaEnd.Properties.Items.Count - 1 do
  begin
    item := ccbFirmaEnd.Properties.Items[i];
    if Pos(IntToStr(item.Index), ccbFirmaEnd.EditValue) > 0 then
    begin
      if (Result <> '') then
        Result := Result + ',';
      Result := Result + IntToStr(item.Tag);
    end;
  end;
  Result := StringReplace(Result, ';', '', [rfReplaceAll]);
end;

function TfrmExportTo1CDlg.GetFirmaStartIDList: string;
var
  i: integer;
  item: TcxCheckComboBoxItem;
begin
  Result := '';
  for i := 0 to ccbFirmaStart.Properties.Items.Count - 1 do
  begin
    item := ccbFirmaStart.Properties.Items[i];
    if Pos(IntToStr(item.Index), ccbFirmaStart.EditValue) > 0 then
    begin
      if (Result <> '') then
        Result := Result + ',';
      Result := Result + IntToStr(item.Tag);
    end;
  end;
  Result := StringReplace(Result, ';', '', [rfReplaceAll]);
end;

function TfrmExportTo1CDlg.GetSaveFileName(const FileName: string): string;
var
  dialog: TFileSaveDialog;
  ft: TFileTypeItem;
begin
  Result := '';
  dialog := TFileSaveDialog.Create(Self);
  try
    dialog.DefaultExtension := 'xml';
    dialog.FileName := FileName;
    dialog.Title := 'Selectati fisierul unde vor fi scrise datele...';
    dialog.Options := dialog.Options + [fdoOverWritePrompt, fdoStrictFileTypes,
      fdoPathMustExist, fdoNoReadOnlyReturn, fdoDontAddToRecent];
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'XML files';
    ft.FileMask := '*.xml';
    if dialog.Execute then
      Result := dialog.FileName;
  finally
    dialog.Free;
  end;
end;

procedure TfrmExportTo1CDlg.LoadFirmaList;
var
  Query: TIBCQuery;
  item: TcxCheckComboBoxItem;
begin
  ccbFirmaStart.Properties.Items.BeginUpdate;
  ccbFirmaEnd.Properties.Items.BeginUpdate;
  ccbFirmaStart.Properties.Items.Clear;
  ccbFirmaEnd.Properties.Items.Clear;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT CUSTOMERID,DISPLAYNAME FROM GET_FIRMS_BY_USER2';
    Query.ExecSQL;
    while not Query.Eof do
    begin
      item := ccbFirmaStart.Properties.Items.AddCheckItem(Query.Fields[1].AsString);
      item.Tag := Query.Fields[0].AsInteger;

      item := ccbFirmaEnd.Properties.Items.AddCheckItem(Query.Fields[1].AsString);
      item.Tag := Query.Fields[0].AsInteger;

      Query.Next;
    end;
  finally
    Query.Free;
    ccbFirmaStart.Properties.Items.EndUpdate;
    ccbFirmaEnd.Properties.Items.EndUpdate;
  end;
end;

function TfrmExportTo1CDlg.MarkDocumentsAsExported(const DocList: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_EXPORT1C_MARK_EXPORTED(:DOCS)';
    Query.ParamByName('DOCS').AsString := DocList;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

{$WARN SYMBOL_PLATFORM ON }

function TfrmExportTo1CDlg.ParseDocList: Boolean;
var
  S, S2: string;
  K: integer;
begin
  Result := True;
     // extract IDs
  S := edDocList.Text;
  K := Pos(',', S);
  while (K > 0) do
  begin
    S2 := Trim(Copy(S, 1, K - 1));
    if S2 <> '' then
      fDocList.Add(S2);
    Delete(S, 1, K);
    K := Pos(',', S);
  end;
  S2 := Trim(S);
  if S2 <> '' then
    fDocList.Add(S2);

     // verify IDs
  for K := 0 to fDocList.Count - 1 do
    if StrToIntDef(fDocList[K], 0) <= 0 then
    begin
      Result := False;
      Break;
    end;

  Result := Result and (fDocList.Count > 0);
end;

procedure TfrmExportTo1CDlg.Prepare;
begin
//  ClientHeight := 528;

  cbTestOnly.Checked := False;
  tbsErrors.TabVisible := False;
  pcPageControl.ActivePage := tbsExport;
  pbProgress.Visible := False;
  lbProgressTitle.Visible := False;
  dtpDataStart.Date := Now - 1;
  dtpDataEnd.Date := Now - 1;
  cbDocList.Checked := False;
  edDocList.Enabled := False;

  LoadFirmaList;
end;

procedure TfrmExportTo1CDlg.SetupSecurityItems;
begin
  if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
    cbTestOnly.Visible := False;
end;

procedure TfrmExportTo1CDlg.ShowNotExportedDos(const ExportedDocList, DTList,
  CTList: string);
var
  dialog: TfrmExportTo1CDocListDlg;
begin
  dialog := TfrmExportTo1CDocListDlg.Create(Application.MainForm);
  dialog.ExportedDocList := ExportedDocList;
  dialog.DTList := DTList;
  dialog.CTList := CTList;
  dialog.ExportSF := cbRealizatia_SF.Checked;
  dialog.ExportCek := cbRealizatia_Cek.Checked;
  dialog.ExportPrih := cbPostuplenia.Checked;
  dialog.ExportPeremesh := cbPeremeshenie.Checked;
  dialog.DateStart := dtpDataStart.Date;
  dialog.DateEnd := dtpDataEnd.Date;
  dialog.DocList := fDocList.CommaText;

  dialog.Show;
end;

function TfrmExportTo1CDlg.VerifyOstatkiByDocID(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
  noAcntCount, zeroCount: integer;
begin
  noAcntCount := 0;
  zeroCount := 0;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('(SELECT COUNT(TDB_JURNAL.GOODSID) FROM TDB_JURNAL');
    Query.SQL.Add('INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_JURNAL.GOODSID)');
    Query.SQL.Add('WHERE (DOCID=:DOCID) AND (TS_GOODS.GOODS_ACNT_ID=-1)),');
    Query.SQL.Add('(SELECT COUNT(TDB_JURNAL.GOODSID) FROM TDB_JURNAL');
    Query.SQL.Add('WHERE (DOCID=:DOCID) AND (TDB_JURNAL.PRICE=0))');
    Query.SQL.Add('FROM RDB$DATABASE');
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      noAcntCount := Query.Fields[0].AsInteger;
      zeroCount := Query.Fields[1].AsInteger;
    end;
  finally
    Query.Free;
  end;

  if (noAcntCount > 0) or (zeroCount > 0) then
    ShowErrorDialog('Eroare!', 'Documentul contine erori.' + #13#10 +
      'Marfuri fara denumire pe nakladnie: ' + IntToStr(noAcntCount) + #13#10 +
      'Marfuri cu pret zero: ' + IntToStr(zeroCount));
  Result := (noAcntCount = 0) and (zeroCount = 0);
end;

procedure TfrmExportTo1CDlg.VerifyПеремещение(const DTList, CTList: string;
  const DateStart, DateEnd: TDateTime);
var
  Query: TIBCQuery;
  N: integer;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;

        // 1. Verificam daca sunt facturi eliberate deschise
    Query.SQL.Add('SELECT VW_TDB_DOCS.DOCID, DT_NAME, CT_NAME, SUMA, CREATED_BY_NAME');
    Query.SQL.Add('FROM VW_TDB_DOCS');
    Query.SQL.Add('INNER JOIN TDB_INVOICES ON (TDB_INVOICES.DOCID=VW_TDB_DOCS.DOCID AND TDB_INVOICES.FLG_CANCELED=0)');
    Query.SQL.Add('WHERE (DOCTYPEID IN (112,2016)) AND (FLG_CLOSED=0) AND (FLG_EXPORTED=0)');
    if (DTList <> '') then
      Query.SQL.Add('AND DT IN (' + DTList + ')');
    if (CTList <> '') then
      Query.SQL.Add('AND CT IN (' + CTList + ')');
    if fDocList.Count > 0 then
      Query.SQL.Add('AND VW_TDB_DOCS.DOCID IN (' + fDocList.CommaText + ')')
    else
      Query.SQL.Add('AND (CAST(DATA AS DATE)>=:DATA1) AND (CAST(DATA AS DATE)<=:DATA2)');

        // params
    if fDocList.Count = 0 then
    begin
      Query.ParamByName('DATA1').AsDate := DateStart;
      Query.ParamByName('DATA2').AsDate := DateEnd;
    end;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridErrorsTable.DataController.AppendRecord;
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DOCID.Index] :=
        Query.Fields[0].AsInteger; // DOCID
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DT.Index] := Query.Fields
        [1].AsString; // DT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CT.Index] := Query.Fields
        [2].AsString; // CT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_SUMA.Index] :=
        Query.Fields[3].AsFloat; // SUMA
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CREATEDBY.Index]
        := Query.Fields[4].AsString;
      // CREATED_BY_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_ERROR.Index] :=
        'Facturi fiscale neinchise';
      Query.Next;
    end;
    Query.Close;

  finally
    Query.Free;
  end;
end;

procedure TfrmExportTo1CDlg.VerifyПоступления(const DTList, CTList: string;
  const DateStart, DateEnd: TDateTime);
var
  Query: TIBCQuery;
  N: integer;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;

        // 1. Verificam daca sunt prihoade deschise
    Query.SQL.Add('SELECT DOCID, DT_NAME, CT_NAME, SUMA, CREATED_BY_NAME');
    Query.SQL.Add('FROM VW_TDB_DOCS');
    Query.SQL.Add('WHERE (DOCTYPEID=109) AND (FLG_CLOSED=0) AND (FLG_EXPORTED=0)');
    if (DTList <> '') then
      Query.SQL.Add('AND DT IN (' + DTList + ')');
    if (CTList <> '') then
      Query.SQL.Add('AND CT IN (' + CTList + ')');
    if fDocList.Count > 0 then
      Query.SQL.Add('AND DOCID IN (' + fDocList.CommaText + ')')
    else
      Query.SQL.Add('AND (CAST(DATA AS DATE)>=:DATA1) AND (CAST(DATA AS DATE)<=:DATA2)');

        // params
    if fDocList.Count = 0 then
    begin
      Query.ParamByName('DATA1').AsDate := DateStart;
      Query.ParamByName('DATA2').AsDate := DateEnd;
    end;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridErrorsTable.DataController.AppendRecord;
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DOCID.Index] :=
        Query.Fields[0].AsInteger; // DOCID
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DT.Index] := Query.Fields
        [1].AsString; // DT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CT.Index] := Query.Fields
        [2].AsString; // CT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_SUMA.Index] :=
        Query.Fields[3].AsFloat; // SUMA
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CREATEDBY.Index]
        := Query.Fields[4].AsString;
        // CREATED_BY_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_ERROR.Index] :=
        'Intrari neinchise';
      Query.Next;
    end;
    Query.Close;

  finally
    Query.Free;
  end;
end;

procedure TfrmExportTo1CDlg.VerifyРеализацияКассовыечеки(const DTList, CTList:
  string; const DateStart, DateEnd: TDateTime);
var
  Query: TIBCQuery;
  N: integer;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;

        // 1. Verificam daca sunt cecuri anulate
    Query.SQL.Add('SELECT DOCID, DT_NAME, CT_NAME, SUMA, CREATED_BY_NAME');
    Query.SQL.Add('FROM VW_TDB_DOCS');
    Query.SQL.Add('WHERE (DOCTYPEID=112) AND (FLG_CLOSED=0) AND (FLG_EXPORTED=0)');
    Query.SQL.Add('AND NOT EXISTS(SELECT INVOICEID FROM TDB_INVOICES WHERE TDB_INVOICES.DOCID=VW_TDB_DOCS.DOCID)');
    Query.SQL.Add('AND EXISTS(SELECT NUMAR_BON FROM TDB_DOCS_RECEIPT WHERE TDB_DOCS_RECEIPT.DOCID=VW_TDB_DOCS.DOCID AND GET_FLG_VALUE(TDB_DOCS_RECEIPT.FLAGS,3)=1)');
    if (DTList <> '') then
      Query.SQL.Add('AND DT IN (' + DTList + ')');
    if (CTList <> '') then
      Query.SQL.Add('AND CT IN (' + CTList + ')');
    if fDocList.Count > 0 then
      Query.SQL.Add('AND DOCID IN (' + fDocList.CommaText + ')')
    else
      Query.SQL.Add('AND (CAST(DATA AS DATE)>=:DATA1) AND (CAST(DATA AS DATE)<=:DATA2)');

        // params
    if fDocList.Count = 0 then
    begin
      Query.ParamByName('DATA1').AsDate := DateStart;
      Query.ParamByName('DATA2').AsDate := DateEnd;
    end;

    Query.ExecSQL;

    while not Query.Eof do
    begin
      N := cxGridErrorsTable.DataController.AppendRecord;
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DOCID.Index] :=
        Query.FieldByName('DOCID').AsInteger; // DOCID
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DT.Index] :=
        Query.FieldByName('DT_NAME').AsString; // DT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CT.Index] :=
        Query.FieldByName('CT_NAME').AsString; // CT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_SUMA.Index] :=
        Query.FieldByName('SUMA').AsFloat; // SUMA
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CREATEDBY.Index]
        := Query.FieldByName('CREATED_BY_NAME').AsString;
        // CREATED_BY_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_ERROR.Index] :=
        'Bonuri anulate';
      Query.Next;
    end;
    Query.Close;

  finally
    Query.Free;
  end;
end;

procedure TfrmExportTo1CDlg.VerifyРеализацияСчетфактуры(const DTList, CTList:
  string; const DateStart, DateEnd: TDateTime);
var
  Query: TIBCQuery;
  N: integer;
  groupTitle: string;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;

        // 1. Verificam daca sunt facturi eliberate deschise
    Query.SQL.Add('SELECT DOCID, DT_NAME, CT_NAME, SUMA, CREATED_BY_NAME, DOCTYPEID');
    Query.SQL.Add('FROM VW_TDB_DOCS');
    Query.SQL.Add('WHERE (DOCTYPEID IN (112,2016)) AND (FLG_CLOSED=0) AND (FLG_EXPORTED=0)');
    if (DTList <> '') then
      Query.SQL.Add('AND DT IN (' + DTList + ')');
    if (CTList <> '') then
      Query.SQL.Add('AND CT IN (' + CTList + ')');
    if fDocList.Count > 0 then
      Query.SQL.Add('AND DOCID IN (' + fDocList.CommaText + ')')
    else
      Query.SQL.Add('AND (CAST(DATA AS DATE)>=:DATA1) AND (CAST(DATA AS DATE)<=:DATA2)');

        // params
    if fDocList.Count = 0 then
    begin
      Query.ParamByName('DATA1').AsDate := DateStart;
      Query.ParamByName('DATA2').AsDate := DateEnd;
    end;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridErrorsTable.DataController.AppendRecord;
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DOCID.Index] :=
        Query.Fields[0].AsInteger; // DOCID
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_DT.Index] := Query.Fields
        [1].AsString; // DT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CT.Index] := Query.Fields
        [2].AsString; // CT_NAME
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_SUMA.Index] :=
        Query.Fields[3].AsFloat; // SUMA
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_CREATEDBY.Index]
        := Query.Fields[4].AsString;
        // CREATED_BY_NAME
      case Query.Fields[5].AsInteger of
        112:
          groupTitle := 'Facturi fiscale neinchise';
        2016:
          groupTitle := 'Nakladnie marfa-transport neinchise';
      end;
      cxGridErrorsTable.DataController.Values[N, cxGridErrors_ERROR.Index] := groupTitle;
      Query.Next;
    end;
    Query.Close;

  finally
    Query.Free;
  end;
end;

end.

