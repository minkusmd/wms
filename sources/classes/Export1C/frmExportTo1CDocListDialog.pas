unit frmExportTo1CDocListDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DialogTitle, DBAccess,
  IBC, MemDS, cxCheckBox, cxNavigator, Vcl.ComCtrls, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmExportTo1CDocListDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_DATA: TcxGridDBColumn;
    cxGridTable_DT: TcxGridDBColumn;
    cxGridTable_DT_NAME: TcxGridDBColumn;
    cxGridTable_CT: TcxGridDBColumn;
    cxGridTable_CT_NAME: TcxGridDBColumn;
    cxGridTable_SUMA: TcxGridDBColumn;
    cxGridTable_FLG_ACNT: TcxGridDBColumn;
    cxGridTable_FLG_CLOSED: TcxGridDBColumn;
    cxGridTable_DOCTYPEID: TcxGridDBColumn;
    cxGridTable_DOCTYPE_NAME: TcxGridDBColumn;
    PageControl1: TPageControl;
    tbsExported: TTabSheet;
    tbsNotExported: TTabSheet;
    cxGridExp: TcxGrid;
    cxGridExpTable: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridLevelExp: TcxGridLevel;
    IBCQueryExp: TIBCQuery;
    IBCDataSourceExp: TIBCDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FExportedDocList: String;
    FCTList: String;
    FDTList: String;
    FDateEnd: TDate;
    FExportPrih: Boolean;
    FExportCek: Boolean;
    FExportPeremesh: Boolean;
    FExportSF: Boolean;
    FDateStart: TDate;
    FDocList: String;
    procedure SetCTList(const Value: String);
    procedure SetDTList(const Value: String);
    procedure SetExportedDocList(const Value: String);

    procedure LoadData;
    procedure SetDateEnd(const Value: TDate);
    procedure SetDateStart(const Value: TDate);
    procedure SetExportCek(const Value: Boolean);
    procedure SetExportPeremesh(const Value: Boolean);
    procedure SetExportPrih(const Value: Boolean);
    procedure SetExportSF(const Value: Boolean);
    procedure SetDocList(const Value: String);
  public
    { Public declarations }
    property ExportedDocList:String read FExportedDocList write SetExportedDocList;
    property DTList:String read FDTList write SetDTList;
    property CTList:String read FCTList write SetCTList;
    property ExportSF:Boolean read FExportSF write SetExportSF;
    property ExportCek:Boolean read FExportCek write SetExportCek;
    property ExportPrih:Boolean read FExportPrih write SetExportPrih;
    property ExportPeremesh:Boolean read FExportPeremesh write SetExportPeremesh;
    property DateStart:TDate read FDateStart write SetDateStart;
    property DateEnd:TDate read FDateEnd write SetDateEnd;
    property DocList:String read FDocList write SetDocList;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, DataModuleAdditions, MainForm, SWNUtils, System.UITypes, SWNSearchDocumentTypes;

{ TfrmExportTo1CDocListDlg }

procedure TfrmExportTo1CDocListDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     // navigate to record
     if Not VarIsNull(ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridTable_DOCID.Index])
        then frmMainForm.GotoDocument(ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridTable_DOCID.Index],sdstDoc);
end;

procedure TfrmExportTo1CDocListDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridTable_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridTable_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridTable_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridTable_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
                    else ACanvas.Font.Color:=clGrayText;
               end;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure TfrmExportTo1CDocListDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          // copy cell content in clipboard
          CopyGridCellTextToClipboard(cxGridTable);
          Key:=0;
          Shift:=[];
     end
end;

procedure TfrmExportTo1CDocListDlg.cxGridTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridTable_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy HH:NN',ARecord.Values[cxGridTable_DATA.Index]);
end;

procedure TfrmExportTo1CDocListDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TfrmExportTo1CDocListDlg.FormShow(Sender: TObject);
begin
     LoadData;
end;

procedure TfrmExportTo1CDocListDlg.LoadData;
begin
     IBCQueryExp.FilterSQL:='DOCID IN ('+FExportedDocList+')';

     IBCQueryDocs.ParamByName('DATE1').AsDate:=FDateStart;
     IBCQueryDocs.ParamByName('DATE2').AsDate:=FDateEnd;
     IBCQueryDocs.ParamByName('EXPORTED_DOCS_LIST').AsString:=FExportedDocList;

     if (FDTList<>'')
        then IBCQueryDocs.ParamByName('DT_LIST').AsString:=FDTList
        else IBCQueryDocs.ParamByName('DT_LIST').Value:=null;
     if (FCTList<>'')
        then IBCQueryDocs.ParamByName('CT_LIST').AsString:=FCTList
        else IBCQueryDocs.ParamByName('CT_LIST').Value:=null;

     IBCQueryDocs.ParamByName('FLG_EXPORT_SF').AsInteger:=Ord(FExportSF);
     IBCQueryDocs.ParamByName('FLG_EXPORT_CEK').AsInteger:=Ord(FExportCek);
     IBCQueryDocs.ParamByName('FLG_EXPORT_PRIHOD').AsInteger:=Ord(FExportPrih);
     IBCQueryDocs.ParamByName('FLG_EXPORT_PER').AsInteger:=Ord(FExportPeremesh);

     if FDocList<>''
        then IBCQueryDocs.ParamByName('DOC_LIST').AsString:=FDocList
        else IBCQueryDocs.ParamByName('DOC_LIST').Value:=null;


     IBCQueryExp.Open;
     IBCQueryDocs.Open;
     cxGridExpTable.DataController.Groups.FullExpand;
     cxGridTable.DataController.Groups.FullExpand;
end;

procedure TfrmExportTo1CDocListDlg.SetCTList(const Value: String);
begin
  FCTList := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetDateEnd(const Value: TDate);
begin
  FDateEnd := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetDateStart(const Value: TDate);
begin
  FDateStart := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetDocList(const Value: String);
begin
     FDocList := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetDTList(const Value: String);
begin
  FDTList := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetExportCek(const Value: Boolean);
begin
  FExportCek := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetExportedDocList(const Value: String);
begin
  FExportedDocList := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetExportPeremesh(const Value: Boolean);
begin
  FExportPeremesh := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetExportPrih(const Value: Boolean);
begin
  FExportPrih := Value;
end;

procedure TfrmExportTo1CDocListDlg.SetExportSF(const Value: Boolean);
begin
  FExportSF := Value;
end;

end.
