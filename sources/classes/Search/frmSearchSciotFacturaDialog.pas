unit frmSearchSciotFacturaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxStyles, cxCustomData, cxGraphics, DB,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  IBC,
  cxButtons, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCheckBox, cxCurrencyEdit, cxLabel, MemDS, DBAccess,
  cxClasses, cxGridCustomView;

type
  TfrmSearchSciotFacturaDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnSearch: TPanel;
    Label1: TLabel;
    edSeachText: TEdit;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_FACTURANO: TcxGridDBColumn;
    cxGridTable_DATA_ELIBERARII: TcxGridDBColumn;
    cxGridTable_DT_NAME: TcxGridDBColumn;
    cxGridTable_CT_NAME: TcxGridDBColumn;
    cxGridTable_SUMA: TcxGridDBColumn;
    cxGridTable_VAT: TcxGridDBColumn;
    cxGridTable_CURRENCY_NAME: TcxGridDBColumn;
    cxGridTable_RATE: TcxGridDBColumn;
    cxGridTable_USER_NAME: TcxGridDBColumn;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_PROCURA_NO: TcxGridDBColumn;
    cxGridTable_DELEGAT: TcxGridDBColumn;
    cxGridTable_DATA_START: TcxGridDBColumn;
    cxGridTable_DATA_END: TcxGridDBColumn;
    cxGridTable_TRANSPORTATOR_NAME: TcxGridDBColumn;
    cxGridTable_NRMATRICULARE: TcxGridDBColumn;
    IBCDataSourceSearch: TIBCDataSource;
    IBCQuerySearch: TIBCQuery;
    cxGridTable_NRFOAIEDEPARCURS: TcxGridDBColumn;
    cxGridTable_FLG_CANCELED: TcxGridDBColumn;
    cxGridTable_FLG_CLOSED: TcxGridDBColumn;
    cxGridTable_FLG_ACNT: TcxGridDBColumn;
    btnSearch: TcxButton;
    btnCancel: TcxButton;
    procedure btnSearchClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTable_DATA_ELIBERARIIGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
  private
    { Private declarations }
    fGotoDocID: integer;
    fGotoDocDate: TDateTime;
    procedure DoSearch(const SearchText: String);
  public
    { Public declarations }
    property GotoDocID: integer read fGotoDocID;
    property GotoDocDate: TDateTime read fGotoDocDate;
    procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView);
  end;

implementation

uses DataModuleAdditions, clipbrd, System.UITypes;

{$R *.dfm}

procedure TfrmSearchSciotFacturaDlg.btnSearchClick(Sender: TObject);
begin
  DoSearch(edSeachText.Text);
end;

procedure TfrmSearchSciotFacturaDlg.CopyGridCellTextToClipboard(const Grid: TcxGridTableView);
var
  RecordIndex: integer;
  i, j: integer;
  MS: TStringList;
  S: String;
begin
  if Grid.OptionsSelection.CellMultiSelect = true then
  begin
    MS := TStringList.Create;
    try
      // multiple cells
      for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
      begin
        S := '';
        for j := 0 to Grid.Controller.SelectedColumnCount - 1 do
        begin
          if S <> '' then
            S := S + #9;
          S := S + Trim(Grid.DataController.GetDisplayText(Grid.Controller.SelectedRecords[i].RecordIndex,
            Grid.Controller.SelectedColumns[j].Index));
        end;
        MS.Add(S);
      end;
      Clipboard.asText := MS.Text;
    finally
      MS.Free;
    end;
  end
  else if Grid.DataController.FocusedRowIndex >= 0 then
  begin
    // single cell
    RecordIndex := Grid.DataController.GetRowInfo(Grid.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
  end;
end;

procedure TfrmSearchSciotFacturaDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  fGotoDocID := IBCQuerySearch.FieldByName('DOCID').AsInteger;
  fGotoDocDate := IBCQuerySearch.FieldByName('DATA').AsDateTime;
  ModalResult := mrOk;
end;

procedure TfrmSearchSciotFacturaDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridTable_FLG_CLOSED.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridTable_FLG_CLOSED.Index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if Not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridTable_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008B8BC5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end
    else
    begin
      if Not AViewInfo.Selected then
      begin
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridTable_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end;
  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure TfrmSearchSciotFacturaDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
    // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGridTable);
    Key := 0;
    Shift := [];
  end
end;

procedure TfrmSearchSciotFacturaDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridTable_FLG_CANCELED.Index] = 1 then
    AStyle := dmAdditions.cxStyle_TextColorRed;
end;

procedure TfrmSearchSciotFacturaDlg.cxGridTable_DATA_ELIBERARIIGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridTable_DATA_ELIBERARII.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridTable_DATA_ELIBERARII.Index]);
end;

procedure TfrmSearchSciotFacturaDlg.DoSearch(const SearchText: String);
begin
  IBCQuerySearch.Close;

  IBCQuerySearch.ParamByName('FACTURANO').AsString := '%' + SearchText + '%';
  IBCQuerySearch.Active := true;
  edSeachText.SelectAll;
end;

end.
