unit frmWebMailingsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar, cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS,
  cxImageComboBox, StdCtrls, cxCheckBox, frmPrintEngineWindow, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TfrmWebMailingsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManagerBar1: TdxBar;
    bbNewEmpty: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbPrepareMailing: TdxBarButton;
    IBCQueryMailing: TIBCQuery;
    IBCDataSourceMailing: TIBCDataSource;
    cxGrid_MAILINGID: TcxGridDBColumn;
    cxGrid_TITLE: TcxGridDBColumn;
    cxGrid_STATE: TcxGridDBColumn;
    btnClose: TButton;
    dxBarSubItem1: TdxBarSubItem;
    IBCTrUpdate: TIBCTransaction;
    bbPrint: TdxBarButton;
    cxGrid_CREATED: TcxGridDBColumn;
    bbTestSend: TdxBarButton;
    bbNew: TdxBarSubItem;
    bbNewTemplated: TdxBarButton;
    bbStopMailing: TdxBarButton;
    bbStartSending: TdxBarButton;
    IBCQueryMailingContent: TIBCQuery;
    dsMailingContent: TIBCDataSource;
    IBCQueryEmailMessages: TIBCQuery;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewEmptyClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbPrepareMailingClick(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure cxGrid_CREATEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
    procedure bbTestSendClick(Sender: TObject);
    procedure bbStartSendingClick(Sender: TObject);
    procedure bbStopMailingClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddNewMailingDialog(const Templated: Boolean);
    function CreateNewMailing(const Templated: Boolean): Integer;
    procedure ShowModifyMailingDialog;
    procedure DeleteMailing;
    procedure PrepareMailing;
    procedure RunMailing;
    procedure SendTestMailing;
    procedure SendAllMessages;
    procedure MarkForModify;

    procedure ShowReports;
    procedure SetupReportParams(const ReportParams: TReportParamsList);

  protected
    { protected declarations }
    procedure Prepare; override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmWebMailingEditorDialog, SWNUtils, SWNDBErrors, frmPrintWizardDialog,
  frmPrepareMailingContentDialog, WebMailingSenderUnit, frmWebMailingsSelectTestEmailsDialog,
  frmWebMailingSenderProcessWindow;

{$R *.dfm}
{ TfrmWebMailingsDlg }

procedure TfrmWebMailingsDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteMailing;
end;

procedure TfrmWebMailingsDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyMailingDialog;
end;

procedure TfrmWebMailingsDlg.bbNewEmptyClick(Sender: TObject);
begin
  ShowAddNewMailingDialog(TdxBarButton(Sender).Tag = 2);
end;

procedure TfrmWebMailingsDlg.bbPrintClick(Sender: TObject);
begin
  ShowReports;
end;

procedure TfrmWebMailingsDlg.bbStartSendingClick(Sender: TObject);
begin
  RunMailing;
end;

procedure TfrmWebMailingsDlg.bbStopMailingClick(Sender: TObject);
begin
  MarkForModify;
end;

procedure TfrmWebMailingsDlg.bbPrepareMailingClick(Sender: TObject);
begin
  PrepareMailing;
end;

procedure TfrmWebMailingsDlg.bbTestSendClick(Sender: TObject);
begin
  SendTestMailing;
end;

function TfrmWebMailingsDlg.CreateNewMailing(const Templated: Boolean): Integer;
var
  Query: TIBCQuery;
begin
  Result := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDb.IBCConnection;
    Query.Transaction := IBCTrUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'SELECT MAILINGID FROM SP_WEB_MAILING_CREATE(:template)';
    Query.ParamByName('template').AsInteger := Ord(Templated);
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Result := Query.Fields[0].AsInteger;
      Query.Transaction.Commit;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebMailingsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbEdit.Enabled and (AButton = mbLeft) then
  begin
    bbEditClick(bbEdit);
    AHandled := True;
  end;

end;

procedure TfrmWebMailingsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebMailingsDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGrid_STATE.Index]) then
  begin
    if (ARecord.Values[cxGrid_STATE.Index] = 3) then
      AStyle := dmAdditions.cxStyle_TextGrayStrike;
  end;
end;

procedure TfrmWebMailingsDlg.cxGrid_CREATEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGrid_CREATED.Index]) and (ARecord.Values[cxGrid_CREATED.Index] > 0) then
    AText := FormatDateTime('dd.mm.yyyy', ARecord.Values[cxGrid_CREATED.Index])
  else
    AText := '';
end;

procedure TfrmWebMailingsDlg.DeleteMailing;
begin
  if ShowAskDialog('Stergere trimitere', Format('Doriti sa stergeti trimiterea "%s"?', [IBCQueryMailing.FieldByName('TITLE').AsString])) = mrYes
  then
  begin
    IBCQueryMailing.UpdateTransaction.StartTransaction;
    try
      IBCQueryMailing.Delete;
      IBCQueryMailing.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryMailing.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebMailingsDlg.MarkForModify;
var
  Query: TIBCQuery;
begin
  if ShowAskDialog('Inapoi in modul de editare', 'Doriti sa readuceti trimiterea in modul de editare?') <> mrYes then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDb.IBCConnection;
    Query.Transaction := IBCTrUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'UPDATE TWEB_MAILINGS SET STATE=0 WHERE MAILINGID=:id';
    Query.ParamByName('id').AsInteger := IBCQueryMailing.FieldByName('MAILINGID').AsInteger;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      IBCQueryMailing.Refresh;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebMailingsDlg.SendAllMessages;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDb.IBCConnection;
    Query.Transaction := IBCTrUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_WEB_MAILING_RUN(:id)';
    Query.ParamByName('id').AsInteger := IBCQueryMailing.FieldByName('MAILINGID').AsInteger;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      IBCQueryMailing.Refresh;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebMailingsDlg.Prepare;
begin
  IBCQueryMailing.Active := True;
  SelectionChanged;
end;

procedure TfrmWebMailingsDlg.PrepareMailing;
var
  dialog: TfrmPrepareMailingContentDlg;
begin
  dialog := TfrmPrepareMailingContentDlg.Create(Self, IBCQueryMailing, IBCDataSourceMailing);
  try
    dialog.MailingID := IBCQueryMailing.FieldByName('MAILINGID').AsInteger;
    if dialog.ShowModal = mrOK then
      IBCQueryMailing.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebMailingsDlg.RunMailing;
begin
  if ShowAskDialog('Lansare trimitere', 'Doriti sa lansati expedierea trimiterii?') <> mrYes then
    Exit;
  SendAllMessages;
end;

procedure TfrmWebMailingsDlg.SelectionChanged;
var
  fNew, fEdit, fDelete, fCheck, fStart, fStop: Boolean;
  State: Integer;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;
  fCheck := False;
  fStart := False;
  fStop := False;
  if cxGridTable.DataController.RecNo > 0 then
  begin
    State := IBCQueryMailing.FieldByName('STATE').AsInteger;
    {
      State:
      0 - new mailing
      1 - ready to send
      2 - sending
      3 - done
    }

    fEdit := True; // ( (State=0) or (State=3) );
    fDelete := (State = 0);
    fCheck := (State = 0);
    fStart := (State = 1);
    fStop := (State = 1) or (State = 2);
  end;
  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbPrepareMailing.Enabled := fCheck;
  bbTestSend.Enabled := fStart;
  bbStartSending.Enabled := fStart;
  bbStopMailing.Enabled := fStop;
end;

procedure TfrmWebMailingsDlg.SendTestMailing;
var
  Sender: TWebMailingSender;
  dialog: TfrmWebMailingsSelectTestEmailsDlg;
  i: Integer;
begin
  dialog := TfrmWebMailingsSelectTestEmailsDlg.Create(Self);
  try
    if dialog.ShowModal = mrOK then
    begin
        IBCQueryMailingContent.Close;
        IBCQueryMailingContent.ParamByName('MAILINGID').AsInteger := IBCQueryMailing.FieldByName('MAILINGID').AsInteger;
        IBCQueryMailingContent.Open;

        IBCQueryEmailMessages.Open;
        for i :=0  to dialog.mmEMails.Lines.Count-1 do
        begin
          with IBCQueryEmailMessages do
          begin
            Insert;
            FieldByName('EMAIL').AsString := dialog.mmEMails.Lines[i];
            FieldByName('SUBJECT').AsString := IBCQueryMailing.FieldByName('TITLE').AsString;
            FieldByName('BODY').AsString := IBCQueryMailingContent.FieldByName('HTML_CONTENT').AsString;
            FieldByName('FLG_ERROR').AsInteger := 0;
            Post;
          end;
        end;
        IBCQueryEmailMessages.Close;
//      Sender := TWebMailingSender.Create(dmDb.IBCConnection);
//      try
//        Sender.TestMode := True;
//        if Sender.LoadMailing(IBCQueryMailing.FieldByName('MAILINGID').AsInteger, dialog.mmEMails.Lines) then
//        begin
//          Sender.Start;
//          Sender.WaitFor;
//          ShowInfoDialog('Trimitere de test', 'Trimiterea de test s-a finalizat.'#13#10 + Format('Scrisori trimise: %d din %d.',
//            [Sender.GetTotalSent, Sender.GetTotalRecipients]) + #13#10 + 'Eroare:' + Sender.Error);
//        end;
//      finally
//        Sender.Free;
//      end;

    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebMailingsDlg.SetupReportParams(const ReportParams: TReportParamsList);
var
  N: Integer;
begin
  N := -1;
  if Assigned(cxGridTable.Controller.FocusedRow) then
    N := cxGridTable.Controller.FocusedRow.Values[cxGrid_MAILINGID.Index];
  // setup here general params
  ReportParams.SetParamValue('MAILINGID', N);
end;

procedure TfrmWebMailingsDlg.ShowAddNewMailingDialog(const Templated: Boolean);
var
  dialog: TfrmWebMailingEditorDlg;
  MailingID: Integer;
begin
  // create record in DB
  MailingID := CreateNewMailing(Templated);
  if (MailingID <= 0) then
    Exit;

  // refresh grid
  IBCQueryMailing.Refresh;
  IBCQueryMailing.Locate('MAILINGID', MailingID, []);

  // show editor
  dialog := TfrmWebMailingEditorDlg.Create(Self, IBCQueryMailing, IBCDataSourceMailing);
  try
    dialog.CreateNewMailing := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebMailingsDlg.ShowModifyMailingDialog;
var
  dialog: TfrmWebMailingEditorDlg;
begin
  dialog := TfrmWebMailingEditorDlg.Create(Self, IBCQueryMailing, IBCDataSourceMailing);
  try
    dialog.CreateNewMailing := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebMailingsDlg.ShowReports;
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDb.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(11); // Mailing
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;

end.
