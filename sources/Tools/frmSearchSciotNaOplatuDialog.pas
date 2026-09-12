unit frmSearchSciotNaOplatuDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, System.UITypes, Dialogs, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, dxBar,
  dxBarExtItems, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, ExtCtrls, IBC,
  StdCtrls, cxCurrencyEdit, cxLabel, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxCheckBox, cxNavigator, dxBarBuiltInMenu, Vcl.Menus, cxButtons, cxCustomData,
  cxFilter, cxData, dxDateRanges, dxScrollbarAnnotations, DBAccess, MemDS, dxUIAClasses;

type
  TfrmSearchSciotNaOplatuDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_DATA: TcxGridDBColumn;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    edSearchText: TEdit;
    Label1: TLabel;
    cxGridTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridTable_CT_NAME: TcxGridDBColumn;
    cxGridTable_CURRENCY_NAME: TcxGridDBColumn;
    cxGridTable_SUMA: TcxGridDBColumn;
    cxGridTable_RATE: TcxGridDBColumn;
    cxGridTable_RATEUSD: TcxGridDBColumn;
    cxGridTable_FLG_PAID: TcxGridDBColumn;
    cxGridTable_FLG_INVOICE: TcxGridDBColumn;
    pnButtons: TPanel;
    cxGridTable_DT: TcxGridDBColumn;
    dxBarPopupMenu: TdxBarPopupMenu;
    cxGridPopupMenu: TcxGridPopupMenu;
    bbPrihod: TdxBarButton;
    bbCreateRashod: TdxBarButton;
    bbGotoDocument: TdxBarButton;
    btnSearch: TcxButton;
    btnCancel: TcxButton;
    procedure btnSearchClick(Sender: TObject);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure bbPrihodClick(Sender: TObject);
    procedure bbCreateRashodClick(Sender: TObject);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoDocumentClick(Sender: TObject);
  private
    { Private declarations }
    fDocID: integer;
    fDocData: TDateTime;

    procedure DoSearch(const DocID: integer);
    procedure WhenDocumentPopupMenuOpen;

    procedure DoPrihodDenegNaSceot;
    procedure CreateRashodnaiaNakladnaia;
    procedure CopyCellTextToClipboard;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property DOCID: integer read fDocID;
    property DocData: TDateTime read fDocData;
  end;

implementation

uses
  DataModuleDB, SWNUtils, frmMoneyIncomeDialog, ClipBrd;

{$R *.dfm}

{ TfrmSearchDocByDocNoDlg }

procedure TfrmSearchSciotNaOplatuDlg.bbCreateRashodClick(Sender: TObject);
begin
  CreateRashodnaiaNakladnaia;
end;

procedure TfrmSearchSciotNaOplatuDlg.bbGotoDocumentClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmSearchSciotNaOplatuDlg.bbPrihodClick(Sender: TObject);
begin
  DoPrihodDenegNaSceot;
end;

procedure TfrmSearchSciotNaOplatuDlg.btnSearchClick(Sender: TObject);
var
  N: integer;
begin
  edSearchText.Text := Trim(edSearchText.Text);
  N := StrToIntDef(edSearchText.Text, -1);
  if N > 0 then begin
    DoSearch(N);
    edSearchText.SelectAll;
  end
  else
    ShowErrorDialog('Eroare', 'Indicat numarul documentlui corect.');
end;

procedure TfrmSearchSciotNaOplatuDlg.CreateRashodnaiaNakladnaia;
var
  DocID: integer;
begin
  DocID := IBCQueryDocs.FieldByName('DOCID').AsInteger;
  if ShowAskDialog('Creare document', 'Doriti sa creati un document de vinzare?') = mrYes then begin
    if (dmDB.CreateRashodnaiaNakladnaia_DB(DocID) <> -1) then
      ShowInfoDialog('Document de Vinzare', 'Document de vinzare a fost creat cu succes!');
  end;
end;

procedure TfrmSearchSciotNaOplatuDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridTable_FLG_INVOICE.Index]) then begin
    if AViewInfo.GridRecord.Values[cxGridTable_FLG_INVOICE.Index] = 1 then begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clGrayText;
    end;
    if AViewInfo.GridRecord.Values[cxGridTable_FLG_PAID.Index] = 1 then begin
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clTeal;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure TfrmSearchSciotNaOplatuDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if Assigned(AFocusedRecord) then begin
    fDocID := AFocusedRecord.Values[cxGridTable_DOCID.Index];
    fDocData := AFocusedRecord.Values[cxGridTable_DATA.Index];
  end;
end;

procedure TfrmSearchSciotNaOplatuDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then begin
          // copy cell content in clipboard
    Clipboard.AsText := cxGridTable.DataController.GetDisplayText(cxGridTable.Controller.FocusedRow.RecordIndex, cxGridTable.Controller.FocusedColumn.Index);
          //CopyCellTextToClipboard;
    Key := 0;
    Shift := [];
  end
//     CopyGridCellTextToClipboard(cxGridTable);
end;

procedure TfrmSearchSciotNaOplatuDlg.CopyCellTextToClipboard;
begin
end;

procedure TfrmSearchSciotNaOplatuDlg.DoPrihodDenegNaSceot;
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Incasare bani in cont
  dialog := TfrmMoneyIncomeDlg.Create(Self, IBCQueryDocs, IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Document bancar', 'Intrare mijloace financiare in cont bancar');

    if dialog.ShowModal = mrOk then begin
             // Incasare bani in cont
      if dmDB.CreateProhodDenegNaSciot(IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger, dialog.Rate, dialog.SUMA) then begin
        IBCQueryDocs.Refresh;
        ShowInfoDialog('Incasare in cont', 'Documentul de incasare in cont bancar a fost creat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSearchSciotNaOplatuDlg.DoSearch(const DocID: integer);
begin
  IBCQueryDocs.Close;
  IBCQueryDocs.ParamByName('docID').AsInteger := DocID;
  IBCQueryDocs.Active := True;
  if cxGridTable.DataController.RecordCount > 0 then begin
    cxGrid.SetFocus;
  end;
end;

procedure TfrmSearchSciotNaOplatuDlg.dxBarPopupMenuPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure TfrmSearchSciotNaOplatuDlg.Prepare;
begin
  inherited;
end;

procedure TfrmSearchSciotNaOplatuDlg.WhenDocumentPopupMenuOpen;
var
  fPrihod, fRashod: Boolean;
begin
  fPrihod := False;
  fRashod := False;

  if (cxGridTable.DataController.RecNo > 0) and (IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger = 1) then begin
    fPrihod := True;                // Incasare bani in cont + Security
    fRashod := IBCQueryDocs.FieldByName('FLG_PAID').AsInteger = 1;
  end;

     // popup menu
  bbPrihod.Enabled := fPrihod;
  bbCreateRashod.Enabled := fRashod;
end;

end.

