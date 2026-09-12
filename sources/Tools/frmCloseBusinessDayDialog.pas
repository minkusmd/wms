unit frmCloseBusinessDayDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  SWNBaseUnit, SWNSearchDocumentTypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxPCdxBarPopupMenu, cxPC, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxContainer, cxCheckListBox, cxCheckBox, cxCurrencyEdit,
  cxLabel, dxBarBuiltInMenu, dxDateRanges, cxCustomListBox, dxScrollbarAnnotations;

type

  TOnCloseBusinessDayOpenDocument = procedure(const DocID:Integer; const Target:TSearchDocumentSearchTarget) of object;

  TfrmCloseBusinessDayDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    pcPages: TcxPageControl;
    tbsVerify: TcxTabSheet;
    tbsDocs: TcxTabSheet;
    tbsOk: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    bbStartVerify: TButton;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    clbDocTypes: TcxCheckListBox;
    cxGridTable: TcxGridTableView;
    cxGridTable_DOCID: TcxGridColumn;
    cxGridTable_DOCTYPE_TITLE: TcxGridColumn;
    cxGridTable_DT_NAME: TcxGridColumn;
    cxGridTable_CT_NAME: TcxGridColumn;
    cxGridTable_SUMA: TcxGridColumn;
    cxGridTable_CURRENCY_NAME: TcxGridColumn;
    cxGridTable_FLG_ACNT: TcxGridColumn;
    cxGridTable_CREATED_BY_NAME: TcxGridColumn;
    procedure bbStartVerifyClick(Sender: TObject);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    fDocTypeList:String;
    FOnOpenDocument: TOnCloseBusinessDayOpenDocument;
    procedure StartVerifyDocs;
    function VerifyBusinessDayDB:Boolean;
    function SubmitCloseBusinessDayDB:Boolean;
    procedure SetOnOpenDocument(const Value: TOnCloseBusinessDayOpenDocument);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property OnOpenDocument:TOnCloseBusinessDayOpenDocument read FOnOpenDocument write SetOnOpenDocument;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, IBC, SWNDBErrors;

procedure TfrmCloseBusinessDayDlg.bbStartVerifyClick(Sender: TObject);
begin
     StartVerifyDocs;
end;

procedure TfrmCloseBusinessDayDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     // navigate to document
     if Assigned(FOnOpenDocument) and Assigned(cxGridTable.Controller.FocusedRow) then
     begin
          FOnOpenDocument(cxGridTable.Controller.FocusedRow.Values[cxGridTable_DOCID.Index],sdstDoc);
          AHandled:=True;
     end;
end;

procedure TfrmCloseBusinessDayDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not AViewInfo.Selected and (AViewInfo.GridRecord.Values[cxGridTable_FLG_ACNT.Index] = 1) then ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

function TfrmCloseBusinessDayDlg.IsFormDataPosted: Boolean;
begin
     Result:=True;
     if Not SubmitCloseBusinessDayDB then
     begin
          Result:=False;
          btnOk.Enabled:=False;
     end;
end;

procedure TfrmCloseBusinessDayDlg.Prepare;
begin
     fDocTypeList:='';
     btnOk.Enabled:=False;
     pcPages.ActivePage:=tbsVerify;
end;

procedure TfrmCloseBusinessDayDlg.SetOnOpenDocument(const Value: TOnCloseBusinessDayOpenDocument);
begin
     FOnOpenDocument := Value;
end;

procedure TfrmCloseBusinessDayDlg.StartVerifyDocs;
var i:integer;
    item:TcxCheckListBoxItem;
    S:String;
begin
     S:='';
     // create doctype list
     if clbDocTypes.Items.Count>0 then
     for i := 0 to clbDocTypes.Items.Count-1 do
     begin
          item:=clbDocTypes.Items[i];
          if (item.Checked) then
          begin
               if (S<>'') then S:=S+',';
               S:=S+IntToStr(item.Tag);
          end;
     end
     else
     begin
          ShowErrorDialog(cMSG_GeneralError_Title,'Selectati tipurile de documente pentru verificare!');
          Exit;
     end;

     fDocTypeList:=S;

     if VerifyBusinessDayDB then
     begin
          pcPages.ActivePage:=tbsOk;
          btnOk.Enabled:=True;
     end
     else
     begin
          pcPages.ActivePage:=tbsDocs;
     end;
end;

function TfrmCloseBusinessDayDlg.SubmitCloseBusinessDayDB: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_BUSINESS_DAY(:dt)';
        Query.ParamByName('dt').AsString:=fDocTypeList;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then ShowErrorDialog(cMSG_GeneralError_Title, E.Message);
           end;
        end;
     finally
        Query.Free;
     end;
end;

function TfrmCloseBusinessDayDlg.VerifyBusinessDayDB: Boolean;
var Query:TIBCQuery;
    N:Integer;
begin
     Result:=True;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM SP_VERIFY_CLOSE_BUSINESS_DAY(:dt)';
        Query.ParamByName('dt').AsString:=fDocTypeList;
        Query.ExecSQL;
        if (Not Query.Eof) then
        begin
             Result:=False;
             cxGridTable.BeginUpdate;
             try
                while Not Query.Eof do
                begin
                     N:=cxGridTable.DataController.AppendRecord;
                     cxGridTable.DataController.Values[N,cxGridTable_DOCID.Index]:=Query.FieldByName('DOCID').AsInteger;
                     cxGridTable.DataController.Values[N,cxGridTable_DOCTYPE_TITLE.Index]:=Query.FieldByName('DOCTYPE_TITLE').AsString;
                     cxGridTable.DataController.Values[N,cxGridTable_DT_NAME.Index]:=Query.FieldByName('DT_NAME').AsString;
                     cxGridTable.DataController.Values[N,cxGridTable_CT_NAME.Index]:=Query.FieldByName('CT_NAME').AsString;
                     cxGridTable.DataController.Values[N,cxGridTable_SUMA.Index]:=Query.FieldByName('SUMA').AsFloat;
                     cxGridTable.DataController.Values[N,cxGridTable_CURRENCY_NAME.Index]:=Query.FieldByName('CURRENCY_NAME').AsString;
                     cxGridTable.DataController.Values[N,cxGridTable_FLG_ACNT.Index]:=Query.FieldByName('FLG_ACNT').AsInteger;
                     cxGridTable.DataController.Values[N,cxGridTable_CREATED_BY_NAME.Index]:=Query.FieldByName('CREATED_BY_NAME').AsString;

                     Query.Next;
                end;
             finally
                cxGridTable.EndUpdate;
             end;
             cxGridTable.ViewData.Expand(True);
        end;
     finally
        Query.Free;
     end;
end;

end.
