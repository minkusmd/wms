unit frmPrintEngineWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, frxClass,
  frxIBDACComponents, SWNBaseUnit, DB, DBAccess, IBC, frxRich, frxChBox, frxDCtrl, DialogTitle, frxExportXLS,
  frxExportPDF, frxCross, frxBarcode, frxExportXLSX, frxExportBIFF, frxGradient, frxDesgn, frxGZip,
  frxExportMail, IdMessage, IdAntiFreeze, IdTCPConnection, IdSMTP, IdSSLOpenSSL, frxCellularTextObject, frxMap,
  frxTableObject, frxExportPDFHelpers, System.IOUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdAntiFreezeBase, IdBaseComponent, IdComponent, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, frxExportBaseDialog, frxDACComponents, SWNClasses;

type
  TReportParamItem = class
  private
    { Private declarations }
    fParamName: string;
    fValue: Variant;
    procedure SetValue(const Value: Variant);
  public
    { Public declarations }
    constructor Create(const ParamName: string; const Value: Variant);
    property Value: Variant read FValue write SetValue;
  end;

  TReportParamsList = class
  private
    { Private declarations }
    fParams: TList;
    procedure ClearParamList;
    function GetCount: Integer;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    procedure Clear;
    procedure SetParamValue(const ParamName: string; const Value: Variant);
    function GetParamByName(const ParamName: string): TReportParamItem;
  end;

  TfrmPrintEngine = class(TSWNCustomForm)
    frxReport: TfrxReport;
    frxDialogControls1: TfrxDialogControls;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxRichObject1: TfrxRichObject;
    dtDialogTitle: TDialogTitle;
    frxCrossObject1: TfrxCrossObject;
    frxBarCodeObject1: TfrxBarCodeObject;
    IBCTrUpdate: TIBCTransaction;
    frxGradientObject1: TfrxGradientObject;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxDesigner1: TfrxDesigner;
    frxPDFExport: TfrxPDFExport;
    frxMailExport1: TfrxMailExport;
    IdSMTP1: TIdSMTP;
    IdAntiFreeze1: TIdAntiFreeze;
    IdMessage: TIdMessage;
    frxBIFFExport1: TfrxBIFFExport;
    frxXLSExport1: TfrxXLSExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxReportTableObject1: TfrxReportTableObject;
    frxMapObject1: TfrxMapObject;
    frxReportCellularTextObject1: TfrxReportCellularTextObject;
    SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    frxIBDACComponents1: TfrxIBDACComponents;
    procedure FormShow(Sender: TObject);
    procedure frxReportAfterPrint(Sender: TfrxReportComponent);
    procedure frxReportPreview(Sender: TObject);
    procedure frxReportEndDoc(Sender: TObject);
    procedure frxReportBeginDoc(Sender: TObject);
    procedure frxXLSExport1BeginExport(Sender: TObject);
    procedure frxJPEGExport1BeginExport(Sender: TObject);
    function frxMailExport1SendMail(const Server: string; const Port: Integer; const UserField, PasswordField:
      string; FromField, ToField, SubjectField, CompanyField, TextField: WideString; FileNames: TStringList;
      Timeout: Integer; ConfurmReading: Boolean; MailCc, MailBcc: WideString): string;
    procedure frxPDFExportBeginExport(Sender: TObject);
    procedure frxReportBeforePrint(Sender: TfrxReportComponent);
    procedure frxReportPrintReport(Sender: TObject);
  private
    { Private declarations }
    FReportParams: TReportParamsList;
    fReportIDList: TIntegerList;
    fPrinted: Boolean;
    fReportsLoadedOk: Boolean;
    FMailFocusTimer: TTimer;
    FMailFocusAttempts: Integer;
    // calea PDF-ului pentru trimiterea pe mesagerie; cit e setata, exportul PDF scrie acolo
    fMessengerPdfFile: string;
    procedure StartPrintThread;
    procedure WhenStartToPrint(Sender: TObject);
    procedure WhenReportPreviewClosed(Sender: TObject);
    procedure frxPDFExportBeforeExport(Sender: TObject);
    procedure frxMailExportBeforeExport(Sender: TObject);
    procedure FocusMailAddressTimer(Sender: TObject);
    function GetDocumentPDFFileName: string;
    function LoadReport(const ReportID: Integer): Boolean;
    procedure PrepareMessage(FromField, ToField, BccField, SubjectField, TextField: WideString);
    procedure SetReportParams(const Value: TReportParamsList);
    procedure WhenReportGetValue(const VarName: string; var Value: Variant);
    procedure SetTitle(const Value: string);
    procedure WhenReportRerun(Sender: TObject);
    procedure SaveDesignFormControlValues;
    procedure RestoreDesignFormControlValues;
    procedure SavePageActivityToLog(const ReportID: Integer; const LogText: string);
    procedure SMTPConnect(const Port: Integer; const Server: string; const UserField: string; const
      PasswordField: string);
    procedure PrepareAttachment(FileNames: TStringList);
    procedure SendReportToEmail;
    procedure WhenSendToMessengerButtonClick(Sender: TObject);
    procedure WhenSendToMessengerMenuClick(Sender: TObject);
    procedure SendReportToMessenger(const AMessengerIndex: Integer);
    procedure SMTPDisconnect;
    procedure SMTPSend;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ReportParams: TReportParamsList read FReportParams write SetReportParams;
    property Title: string write SetTitle;
    procedure AddReport(const ReportID: Integer);
    property Printed: Boolean read fPrinted;
    function PrintSilent(const PrinterName: string; const PageCopyCount: Integer = 1): Boolean;
  end;

implementation

uses
  DataModuleDB, Vcl.StdCtrls, Vcl.ComCtrls, SWNDBErrors, ReportControlsUnit, SWNSecurity, SWNValueStorageUnit,
  SWNSecurityFlags, IdAttachmentFile,
  SWNUtils,
  IdGlobal, Vcl.Menus, System.UITypes, System.Types, ReportMessengerSendUnit;

{$R *.dfm}

{ TfrmPrintEngine }

constructor TfrmPrintEngine.Create(AOwner: TComponent);
begin
  inherited;
  FMailFocusTimer := TTimer.Create(Self);
  FMailFocusTimer.Enabled := False;
  FMailFocusTimer.Interval := 50;
  FMailFocusTimer.OnTimer := FocusMailAddressTimer;
  frxPDFExport.OnBeforeExport := frxPDFExportBeforeExport;
  frxMailExport1.OnBeforeExport := frxMailExportBeforeExport;
  fReportIDList := TIntegerList.Create;
  fPrinted := False;
  ClientHeight := MulDiv(64, Screen.PixelsPerInch, 96);
end;

destructor TfrmPrintEngine.Destroy;
begin
  AppUserTempConfigStorage.OpenSection('REPORT');
  try
    AppUserTempConfigStorage.BooleanValues.Clear;
    AppUserTempConfigStorage.TextValues.Clear;
    AppUserTempConfigStorage.DateTimeValues.Clear;
    AppUserTempConfigStorage.IntValues.Clear;
  finally
    AppUserTempConfigStorage.CloseSection;
  end;

  fReportIDList.Free;

  inherited;
end;

procedure TfrmPrintEngine.FormShow(Sender: TObject);
begin
  StartPrintThread;
end;

procedure TfrmPrintEngine.frxJPEGExport1BeginExport(Sender: TObject);
begin
  SavePageActivityToLog(fReportIDList[0], 'Raportul este exportat in JPEG');
end;

procedure TfrmPrintEngine.frxMailExportBeforeExport(Sender: TObject);
begin
  FMailFocusAttempts := 0;
  FMailFocusTimer.Enabled := True;
end;

procedure TfrmPrintEngine.frxPDFExportBeforeExport(Sender: TObject);
begin
  if Sender is TfrxPDFExport then
    if fMessengerPdfFile <> '' then
      TfrxPDFExport(Sender).FileName := fMessengerPdfFile
    else
      TfrxPDFExport(Sender).FileName := GetDocumentPDFFileName;
end;

procedure TfrmPrintEngine.frxPDFExportBeginExport(Sender: TObject);
begin
  SavePageActivityToLog(fReportIDList[0], 'Report exported to PDF');
end;

procedure TfrmPrintEngine.FocusMailAddressTimer(Sender: TObject);
var
  i: Integer;
  MailForm: TCustomForm;
  AddressComponent: TComponent;
  AddressControl: TWinControl;
begin
  Inc(FMailFocusAttempts);
  MailForm := nil;
  for i := Screen.FormCount - 1 downto 0 do
    if SameText(Screen.Forms[i].ClassName, 'TfrxMailExportDialog') and Screen.Forms[i].Visible then
    begin
      MailForm := Screen.Forms[i];
      Break;
    end;

  if Assigned(MailForm) then
  begin
    AddressComponent := MailForm.FindComponent('AddressE');
    if AddressComponent is TWinControl then
    begin
      AddressControl := TWinControl(AddressComponent);
      if AddressControl.CanFocus then
      begin
        MailForm.ActiveControl := AddressControl;
        AddressControl.SetFocus;
        FMailFocusTimer.Enabled := False;
      end;
    end;
  end;

  if FMailFocusAttempts >= 100 then
    FMailFocusTimer.Enabled := False;
end;

function TfrmPrintEngine.GetDocumentPDFFileName: string;
var
  Param: TReportParamItem;
  DocumentID: string;
begin
  Result := '';
  if not Assigned(FReportParams) then
    Exit;

  Param := FReportParams.GetParamByName('DOCID');
  if not Assigned(Param) then
    Exit;
  if VarIsNull(Param.Value) or VarIsEmpty(Param.Value) then
    Exit;

  DocumentID := Trim(VarToStr(Param.Value));
  if DocumentID <> '' then
    Result := DocumentID + '.pdf';
end;

procedure TfrmPrintEngine.frxReportAfterPrint(Sender: TfrxReportComponent);
begin
  if not fPrinted then
    SavePageActivityToLog(fReportIDList[0], 'Raportul este vizualizat');
  fPrinted := True;
end;

procedure TfrmPrintEngine.frxReportBeforePrint(Sender: TfrxReportComponent);
begin
  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Редактировать_сгенерированный_отчет) then
    frxReport.PreviewOptions.Buttons := frxReport.PreviewOptions.Buttons - [pbEdit];
end;

procedure TfrmPrintEngine.frxReportBeginDoc(Sender: TObject);
begin
  RestoreDesignFormControlValues;
end;

procedure TfrmPrintEngine.frxReportEndDoc(Sender: TObject);
begin
  SaveDesignFormControlValues;
end;

procedure TfrmPrintEngine.frxReportPreview(Sender: TObject);
var
  i: Integer;
  ToolBar: TToolBar;
  Btn2, BtnSend: TButton;
  Sep: TBevel;
  SendMenu: TPopupMenu;
  MenuItem: TMenuItem;
  M: TReportMessenger;
begin
  ToolBar := nil;
     // find ToolBar
  for i := 0 to frxReport.PreviewForm.ComponentCount - 1 do
    if (frxReport.PreviewForm.Components[i] is TToolBar) then
    begin
      ToolBar := TToolBar(frxReport.PreviewForm.Components[i]);
      Break;
    end;
  if ToolBar <> nil then
  begin
          // add separator
    Sep := TBevel.Create(ToolBar);
    Sep.Width := 60;
    Sep.Left := 900;
    Sep.Shape := bsSpacer;
    Sep.Parent := ToolBar;
          // add custom button
    Btn2 := TButton.Create(ToolBar);
    Btn2.Caption := 'Setari';
    Btn2.Width := 100;
    Btn2.Left := 900;
    Btn2.TabStop := False;
    Btn2.Parent := ToolBar;
    Btn2.OnClick := WhenReportRerun;

          // trimitere semi-automata pe Viber / WhatsApp / Telegram (ReportMessengerSendUnit)
    SendMenu := TPopupMenu.Create(ToolBar);
    for M := Low(TReportMessenger) to High(TReportMessenger) do
    begin
      MenuItem := TMenuItem.Create(SendMenu);
      MenuItem.Caption := cReportMessengerNames[M];
      MenuItem.Tag := Ord(M);
      MenuItem.OnClick := WhenSendToMessengerMenuClick;
      SendMenu.Items.Add(MenuItem);
    end;
    BtnSend := TButton.Create(ToolBar);
    BtnSend.Caption := 'Trimite pe...';
    BtnSend.Hint := 'Trimite raportul ca PDF pe Viber / WhatsApp / Telegram';
    BtnSend.ShowHint := True;
    BtnSend.Width := 110;
    BtnSend.Left := 1100;
    BtnSend.TabStop := False;
    BtnSend.Parent := ToolBar;
    BtnSend.PopupMenu := SendMenu;
    BtnSend.OnClick := WhenSendToMessengerButtonClick;
  end;
end;

procedure TfrmPrintEngine.WhenSendToMessengerButtonClick(Sender: TObject);
var
  Btn: TButton;
  P: TPoint;
begin
  // click stinga deschide acelasi meniu ca si click dreapta
  if not (Sender is TButton) then
    Exit;
  Btn := TButton(Sender);
  if Assigned(Btn.PopupMenu) then
  begin
    P := Btn.ClientToScreen(Point(0, Btn.Height));
    Btn.PopupMenu.Popup(P.X, P.Y);
  end;
end;

procedure TfrmPrintEngine.WhenSendToMessengerMenuClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    SendReportToMessenger(TMenuItem(Sender).Tag);
end;

// Exporta raportul in PDF, il pune in clipboard ca fisier si deschide conversatia cu numarul
// dat; operatorul lipeste fisierul (Ctrl+V) si trimite. Vezi ReportMessengerSendUnit.
procedure TfrmPrintEngine.SendReportToMessenger(const AMessengerIndex: Integer);
var
  Messenger: TReportMessenger;
  Param: TReportParamItem;
  DocID: Integer;
  Phone, Digits, Dir, BaseName: string;
  OldShowDialog, OldSlaveExport, OldShowProgress, OldOpenAfterExport, Exported: Boolean;
  OldFileName: string;
begin
  if (AMessengerIndex < Ord(Low(TReportMessenger))) or (AMessengerIndex > Ord(High(TReportMessenger))) then
    Exit;
  Messenger := TReportMessenger(AMessengerIndex);

  // telefonul clientului din document, ca propunere
  DocID := 0;
  if Assigned(FReportParams) then
  begin
    Param := FReportParams.GetParamByName('DOCID');
    if Assigned(Param) and not (VarIsNull(Param.Value) or VarIsEmpty(Param.Value)) then
      DocID := StrToIntDef(Trim(VarToStr(Param.Value)), 0);
  end;
  Phone := GetDocumentCustomerPhone(DocID);
  if not InputQuery('Trimite pe ' + cReportMessengerNames[Messenger], 'Numarul de telefon al destinatarului:', Phone) then
    Exit;
  Digits := NormalizePhoneForMessenger(Phone);
  if Digits = '' then
  begin
    MessageDlg('Numarul "' + Phone + '" nu poate fi folosit. Scrieti-l ca 079123456 sau +37379123456.',
      mtError, [mbOK], 0);
    Exit;
  end;

  // fisier cu nume citibil pentru destinatar: <document>_<data>.pdf
  Dir := IncludeTrailingPathDelimiter(System.IOUtils.TPath.GetTempPath) + 'WMS_Rapoarte';
  ForceDirectories(Dir);
  if DocID > 0 then
    BaseName := 'Document_' + IntToStr(DocID)
  else
    BaseName := 'Raport';
  fMessengerPdfFile := IncludeTrailingPathDelimiter(Dir) + BaseName + '_' +
    FormatDateTime('yyyymmdd_hhnnss', Now) + '.pdf';

  OldShowDialog := frxPDFExport.ShowDialog;
  OldSlaveExport := frxPDFExport.SlaveExport;
  OldShowProgress := frxPDFExport.ShowProgress;
  OldOpenAfterExport := frxPDFExport.OpenAfterExport;
  OldFileName := frxPDFExport.FileName;
  try
    frxPDFExport.ShowDialog := False;
    frxPDFExport.SlaveExport := True;
    frxPDFExport.ShowProgress := False;
    frxPDFExport.OpenAfterExport := False;
    frxPDFExport.FileName := fMessengerPdfFile;
    Exported := frxReport.Export(frxPDFExport) and FileExists(fMessengerPdfFile);

    if not Exported then
    begin
      MessageDlg('Raportul nu a putut fi exportat in PDF.', mtError, [mbOK], 0);
      Exit;
    end;

    try
      CopyFileToClipboard(fMessengerPdfFile);
    except
      on E: Exception do
      begin
        MessageDlg('PDF-ul nu a putut fi pus in clipboard: ' + E.Message + sLineBreak + sLineBreak +
          'Fisierul este: ' + fMessengerPdfFile, mtError, [mbOK], 0);
        Exit;
      end;
    end;

    if OpenMessengerChat(Messenger, Digits) then
    begin
      SavePageActivityToLog(fReportIDList[0], 'Raportul este trimis pe ' + cReportMessengerNames[Messenger] +
        ' la +' + Digits);
      MessageDlg('PDF-ul este in clipboard.' + sLineBreak + sLineBreak +
        'In conversatia deschisa in ' + cReportMessengerNames[Messenger] + ' cu +' + Digits +
        ' apasati Ctrl+V, apoi Enter.' + sLineBreak + sLineBreak +
        'Fisierul: ' + fMessengerPdfFile, mtInformation, [mbOK], 0);
    end
    else
      MessageDlg(cReportMessengerNames[Messenger] + ' nu a putut fi deschis pe acest calculator.' + sLineBreak +
        sLineBreak + 'PDF-ul ramine in clipboard si in fisierul:' + sLineBreak + fMessengerPdfFile,
        mtWarning, [mbOK], 0);
  finally
    fMessengerPdfFile := '';
    frxPDFExport.ShowDialog := OldShowDialog;
    frxPDFExport.SlaveExport := OldSlaveExport;
    frxPDFExport.ShowProgress := OldShowProgress;
    frxPDFExport.OpenAfterExport := OldOpenAfterExport;
    frxPDFExport.FileName := OldFileName;
  end;
end;

procedure TfrmPrintEngine.frxXLSExport1BeginExport(Sender: TObject);
begin
  SavePageActivityToLog(fReportIDList[0], 'Raportul este exportat in XLS');
end;

procedure TfrmPrintEngine.AddReport(const ReportID: Integer);
begin
  fReportIDList.Add(ReportID);
end;

function TfrmPrintEngine.frxMailExport1SendMail(const Server: string; const Port: Integer; const UserField,
  PasswordField: string; FromField, ToField, SubjectField, CompanyField, TextField: WideString; FileNames:
  TStringList; Timeout: Integer; ConfurmReading: Boolean; MailCc, MailBcc: WideString): string;
begin
  SavePageActivityToLog(fReportIDList[0], 'Raportul ' + SubjectField + ' a fost transmis pe email: ' + ToField
    + ', from ' + FromField);

  SMTPConnect(Port, Server, UserField, PasswordField);

  PrepareMessage(FromField, ToField, 'web@fantastic.md', SubjectField, TextField);
  PrepareAttachment(FileNames);

  SMTPSend;

  SMTPDisconnect;
end;

procedure TfrmPrintEngine.frxReportPrintReport(Sender: TObject);
begin
  SavePageActivityToLog(fReportIDList[0], 'Raportul este transmis la tipar!');
//  SendReportToEmail;
end;

function TfrmPrintEngine.LoadReport(const ReportID: Integer): Boolean;
var
  Query: TIBCQuery;
  MS, CompressedMS: TMemoryStream;
  ExpandedSize: Integer;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  MS := TMemoryStream.Create;
  CompressedMS := TMemoryStream.Create;
  try
    Query.Connection := dmDB.IBCConnection;
    try
      Query.SQL.Text := 'SELECT * FROM TS_REPORTS2 WHERE (ReportID=:ReportID) AND (GET_FLG_VALUE(FLAGS,0)=0)';
      Query.ParamByName('ReportID').AsInteger := ReportID;
      Query.ExecSQL;
      if not Query.Eof then
      begin
                // load template
        if not Query.FieldByName('REPORT_TEMPLATE').IsNull then
        begin
          ExpandedSize := Query.FieldByName('EXPANDED_SIZE').asInteger;
          if ExpandedSize = 0 then
          begin
                          // load uncompressed
            TBlobField(Query.FieldByName('REPORT_TEMPLATE')).SaveToStream(MS);
          end
          else
          begin
                          // load compressed
            TBlobField(Query.FieldByName('REPORT_TEMPLATE')).SaveToStream(CompressedMS);
            MS.SetSize(ExpandedSize);
                          //ShowMessage(Format('Compressed=%d; Expanded=%d',[CompressedMS.Size,ExpandedSize]));
            UnCompressStream(CompressedMS, MS);
          end;

          MS.Position := 0;
          frxReport.LoadFromStream(MS);
        end;
                // prepare report
        Result := frxReport.PrepareReport(False);

                // set defaults to Export objects
        frxPDFExport.Author := dmDB.CurrentUserFullName;
//                frxPDFExport.Producer:=dmDB.CurrentFirmaName;
        frxPDFExport.Title := Query.FieldByName('TITLE').AsString;
        frxPDFExport.CreationTime := Now;
        frxPDFExport.PDFStandard := psNone;
        frxPDFExport.PDFVersion := pv17;
        frxPDFExport.Background := False;
        frxPDFExport.Transparency := False;
//                frxPDFExport.Creator:=cAPP_Title;
        frxPDFExport.Subject := '';

        frxMailExport1.Subject := Query.FieldByName('TITLE').AsString;
        frxMailExport1.MailBcc := 'web@fantastic.md';
      end
      else
        raise Exception.Create('SYSERROR_REPORTNOTFOUND' + #13#10 + 'Report #' + IntToStr(ReportID));
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
    Query.Close;
  finally
    MS.Free;
    CompressedMS.Free;
    Query.Free;
  end;

end;

procedure TfrmPrintEngine.PrepareMessage(FromField, ToField, BccField, SubjectField, TextField: WideString);
begin
  IdMessage.Clear; // curat mesajul
  IdSMTP1.AuthType := satDefault;
  IdMessage.From.Text := FromField;
  IdMessage.CharSet := 'UTF-8';
  IdMessage.ContentType := 'multipart/mixed';
//  IdMessage.ContentType := 'application/pdf';
//  IdMessage.ContentDisposition:= 'attachment';
//  IdMessage.ContentTransferEncoding := 'base64';
  IdMessage.Encoding := meMIME;
//  IdMessage.Encoding     := mePlainText;
  IdMessage.Recipients.EMailAddresses := ToField;
  IdMessage.BccList.EMailAddresses := BccField;
  IdMessage.Subject := SubjectField + ' - Fantastic.MD'; //UTF8ToString(SubjectField + ' - Fantastic.MD'); //UTF8ToString or UTF8ToWideString
  IdMessage.Body.Add(TextField);  //UTF8ToString or UTF8ToWideString;
//  IdMessage.Body.Add(UTF8ToString(TextField));  //UTF8ToString or UTF8ToWideString;
//   IdMessage.Subject := UTF8Decode(SubjectField + ' - Fantastic.MD'); //UTF8ToString or UTF8ToWideString
//   IdMessage.Body.Add(UTF8Decode(TextField));  //UTF8ToString or UTF8ToWideString;
end;

function TfrmPrintEngine.PrintSilent(const PrinterName: string; const PageCopyCount: Integer): Boolean;
var
  i: Integer;
  Ok: Boolean;
begin
  Result := False;
      // set event for variables
  if Assigned(FReportParams) and (FReportParams.Count > 0) then
    frxReport.OnGetValue := WhenReportGetValue;

     // set descriptive info
     // frxReport.ReportOptions.Author:=Utf8ToAnsi(UTF8Encode(dmDB.CurrentUserFullName));
  frxReport.ReportOptions.CreateDate := Now;

  Ok := True;
  for i := 0 to fReportIDList.Count - 1 do
    Ok := Ok and LoadReport(fReportIDList[i]);

  if Ok then
  begin
    frxReport.PrintOptions.Printer := PrinterName;
    frxReport.PrintOptions.Copies := PageCopyCount;
    frxReport.PrintOptions.ShowDialog := False;
    frxReport.Print;
    Result := True;
  end;
end;

procedure TfrmPrintEngine.SMTPSend;
begin

  IdSMTP1.Send(IdMessage);
end;

procedure TfrmPrintEngine.SMTPDisconnect;
begin
  IdSMTP1.Disconnect;
end;

procedure TfrmPrintEngine.PrepareAttachment(FileNames: TStringList);
var
  I: Integer;
begin
  for I := 0 to FileNames.Count - 1 do
  begin
    TIdAttachmentFile.Create(idMessage.MessageParts, Copy(FileNames[I], 1, Length(FileNames[I]) - 5));
  end;
end;

procedure TfrmPrintEngine.SMTPConnect(const Port: Integer; const Server: string; const UserField: string;
  const PasswordField: string);
begin
  if not IdSMTP1.Connected then
  begin
      IdSMTP1.AuthType := satDefault;
      IdSMTP1.Port := Port;
      IdSMTP1.Host := Server;
      IdSMTP1.Username := UserField;
      IdSMTP1.Password := PasswordField;

    //  IdSMTP1.IOHandler := SSLHandler;
    //  IdSMTP1.UseTLS := utUseExplicitTLS;
    //  SSLHandler.MaxLineAction := maException;
    //  SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    //  SSLHandler.SSLOptions.Mode := sslmUnassigned;
    //  SSLHandler.SSLOptions.VerifyMode := [];
    //  SSLHandler.SSLOptions.VerifyDepth := 0;

      IdSMTP1.Connect;
  end;
end;

procedure TfrmPrintEngine.RestoreDesignFormControlValues;
var
  i, j: Integer;
  Obj: TObject;
  Control: TfrxDialogControl;
begin
     // daca raportul are forme si sunt date salvate,
     // atunci restabilim datele pentru controalele salvate

  AppUserTempConfigStorage.OpenSection('REPORT');
  if AppUserTempConfigStorage.BooleanValues.GetValue('HasData') then
  begin
    AppUserTempConfigStorage.IntValues.SetValue('SYS_REPORT_RERUN', 1);

    for i := 0 to frxReport.PagesCount - 1 do
      if frxReport.Pages[i].GetDescription = 'Dialog form' then
      begin
        for j := 0 to frxReport.Pages[i].AllObjects.Count - 1 do
        begin
          Obj := TObject(frxReport.Pages[i].AllObjects[j]);
          if (Obj <> nil) and (Obj is TfrxDialogControl) then
          begin
            Control := TfrxDialogControl(Obj);

            if (Control is TfrxDateEditControl) then
            begin
              if AppUserTempConfigStorage.DateTimeValues.KeyExists(Control.Name + '_DATE') then
              begin
                TfrxDateEditControl(Control).Date := AppUserTempConfigStorage.DateTimeValues.GetValue(Control.Name
                  + '_DATE', Now);
                TfrxDateEditControl(Control).Time := AppUserTempConfigStorage.DateTimeValues.GetValue(Control.Name
                  + '_TIME', Now);
              end;
            end
            else if (Control is TfrxItemsSelector) then
            begin
              if AppUserTempConfigStorage.BooleanValues.KeyExists(Control.Name) then
              begin
                AppUserTempConfigStorage.OpenSection(Control.Name);
                TfrxItemsSelector(Control).WhenReadFromRepository(AppUserTempConfigStorage);
                AppUserTempConfigStorage.CloseSection;
              end;
            end;
          end;
        end;
      end;
  end;
  AppUserTempConfigStorage.CloseSection;
end;

procedure TfrmPrintEngine.SaveDesignFormControlValues;
var
  i, j: Integer;
  Obj: TObject;
  Control: TfrxDialogControl;
  ControlCount: Integer;
begin
  AppUserTempConfigStorage.OpenSection('REPORT');
     // after report forms are closed and report is generated
     // try to save report forms values
  ControlCount := 0;
  for i := 0 to frxReport.PagesCount - 1 do
    if frxReport.Pages[i].GetDescription = 'Dialog form' then
    begin
      for j := 0 to frxReport.Pages[i].AllObjects.Count - 1 do
      begin
        Obj := TObject(frxReport.Pages[i].AllObjects[j]);
        if (Obj <> nil) and (Obj is TfrxDialogControl) then
        begin
          Control := TfrxDialogControl(Obj);

          if (Control is TfrxDateEditControl) then
          begin
            AppUserTempConfigStorage.DateTimeValues.SetValue(Control.Name + '_DATE', TfrxDateEditControl(Control).Date);
            AppUserTempConfigStorage.DateTimeValues.SetValue(Control.Name + '_TIME', TfrxDateEditControl(Control).Time);
            Inc(ControlCount);
          end
          else if (Control is TfrxItemsSelector) then
          begin
            AppUserTempConfigStorage.BooleanValues.SetValue(Control.Name, True);
            AppUserTempConfigStorage.OpenSection(Control.Name);
            TfrxItemsSelector(Control).WhenSaveToRepository(AppUserTempConfigStorage);
            AppUserTempConfigStorage.CloseSection;
            Inc(ControlCount);
          end;
        end;
      end;
    end;
  if ControlCount > 0 then
    AppUserTempConfigStorage.BooleanValues.SetValue('HasData', True);
  AppUserTempConfigStorage.CloseSection;
end;

procedure TfrmPrintEngine.SavePageActivityToLog(const ReportID: Integer; const LogText: string);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := IBCTrUpdate;
    Query.SQL.Text := 'INSERT INTO TLOG_REPORTS (FIRMAID,REPORTID,LOGTEXT) VALUES (:FIRMA,:ID,:TEXT)';
    Query.ParamByName('FIRMA').AsInteger := dmDB.CurrentFirma;
    Query.ParamByName('ID').AsInteger := ReportID;
    Query.ParamByName('TEXT').AsString := LogText;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      Query.Transaction.Rollback;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmPrintEngine.SendReportToEmail;
var
  tmpFileName: string;
  FileList: TStringList;
begin
  if dmDB.CurrentUserID <> 204 then
  begin
//   deconectat,05.08.2021 creste tare cantitatea de email-uri in Exchange
//
    FileList := TStringList.Create;
    try
      tmpFileName := System.IOUtils.TPath.GetTempFileName;
      tmpFileName := ChangeFileExt(tmpFileName, '.pdf');
     // PDFExport settings
      frxPDFExport.ShowDialog := False;
      frxPDFExport.SlaveExport := True;
      frxPDFExport.ShowProgress := False;
      frxPDFExport.FileName := tmpFileName;
      tmpFileName := ChangeFileExt(tmpFileName, '.pdf.temp');
      FileList.Add(tmpFileName);

      if frxReport.Export(frxPDFExport) then
      begin
        {$DEFINE USE_INDY}

        SMTPConnect(frxMailExport1.SmtpPort, frxMailExport1.SmtpHost, frxMailExport1.Login, frxMailExport1.Password);
        PrepareMessage('marketing@fantastic.md', '', '', 'Raport [' + fReportIDList[0].ToString
          + '] trimis la tipar!', 'Utilizator = ' + dmDB.CurrentUserFullName + #13#10 + 'de pe IP:' + dmDB.GetLocalIP);
        PrepareAttachment(FileList);
        SMTPSend;
        SMTPDisconnect;
      end
      else
      begin
        // can't send email, log the error'
      end;
    finally
      FileList.Free;
    end;
  end;
end;

procedure TfrmPrintEngine.SetReportParams(const Value: TReportParamsList);
begin
  FReportParams := Value;
end;

procedure TfrmPrintEngine.SetTitle(const Value: string);
begin
  dtDialogTitle.Title := Value;
end;

procedure TfrmPrintEngine.StartPrintThread;
begin
  with TDelayThread.Create(100, WhenStartToPrint) do
  begin
    OnTerminate := WhenReportPreviewClosed;
    Start;
  end;
end;

procedure TfrmPrintEngine.WhenReportGetValue(const VarName: string; var Value: Variant);
var
  Param: TReportParamItem;
begin
  Param := FReportParams.GetParamByName(VarName);
  if Assigned(Param) then
    Value := Param.fValue
  else if VarName = 'SYS_REPORT_RERUN' then
  begin
    AppUserTempConfigStorage.OpenSection('REPORT');
    Value := AppUserTempConfigStorage.IntValues.GetValue('SYS_REPORT_RERUN', 0);
    AppUserTempConfigStorage.CloseSection;
  end;
end;

procedure TfrmPrintEngine.WhenReportPreviewClosed(Sender: TObject);
begin
  if fReportsLoadedOk then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TfrmPrintEngine.WhenReportRerun(Sender: TObject);
begin
  frxReport.PrepareReport(True);
  frxReport.ShowPreparedReport;
end;

procedure TfrmPrintEngine.WhenStartToPrint(Sender: TObject);
var
  i: Integer;
  Ok: Boolean;
begin
  Application.ProcessMessages;

     // set event for variables
  if Assigned(FReportParams) and (FReportParams.Count > 0) then
    frxReport.OnGetValue := WhenReportGetValue;

     // set descriptive info
  frxReport.ReportOptions.Author := Utf8ToAnsi(UTF8Encode(dmDB.CurrentUserFullName));
  frxReport.ReportOptions.CreateDate := Now;

     // load current user info
  frxMailExport1.FromMail := SWNSecurityManager.LoggedUser.EMail;
  frxMailExport1.FromName := SWNSecurityManager.LoggedUser.FullName;
  frxMailExport1.FromCompany := dmDB.CurrentFirmaName;
  frxMailExport1.Login := SWNSecurityManager.LoggedUser.LoginName;

  Ok := True;
  for i := 0 to fReportIDList.Count - 1 do
  begin
    Ok := Ok and LoadReport(fReportIDList[i]);
  end;

  if Ok and (fReportIDList.Count > 0) then
  begin
    frxReport.PreviewOptions.OutlineExpand := True;
    frxReport.PreviewOptions.ThumbnailVisible := True;
  end;

  if Ok then
    frxReport.ShowPreparedReport;

  fReportsLoadedOk := Ok;
end;

{ TReportParamItem }

constructor TReportParamItem.Create(const ParamName: string; const Value: Variant);
begin
  fParamName := ParamName;
  fValue := Value;
end;

procedure TReportParamItem.SetValue(const Value: Variant);
begin
  FValue := Value;
end;

{ TReportParamsList }

procedure TReportParamsList.Clear;
var
  i: Integer;
begin
  for i := 0 to fParams.Count - 1 do
    TReportParamItem(fParams[i]).Free;
  fParams.Clear;
end;

procedure TReportParamsList.ClearParamList;
begin
  Clear;
end;

constructor TReportParamsList.Create;
begin
  fParams := TList.Create;
end;

destructor TReportParamsList.Destroy;
begin
  ClearParamList;
  fParams.Free;
  inherited;
end;

function TReportParamsList.GetCount: Integer;
begin
  Result := fParams.Count;
end;

function TReportParamsList.GetParamByName(const ParamName: string): TReportParamItem;
var
  i: Integer;
  Param: TReportParamItem;
  S: string;
begin
  Result := nil;
  S := '';
     // clear input from special chars
  for i := 1 to Length(ParamName) do
    if not CharInSet(ParamName[i], ['<', '>', '[', ']']) then
      S := S + ParamName[i];

  for i := 0 to fParams.Count - 1 do
  begin
    Param := TReportParamItem(fParams[i]);
    if SameText(S, Param.fParamName) then
    begin
      Result := Param;
      Break;
    end;
  end;
end;

procedure TReportParamsList.SetParamValue(const ParamName: string; const Value: Variant);
var
  Param: TReportParamItem;
begin
  Param := GetParamByName(ParamName);
  if Assigned(Param) then
  begin
          // update existing value
    Param.fValue := Value;
  end
  else
  begin
          // add new value
    Param := TReportParamItem.Create(ParamName, Value);
    fParams.Add(Param);
  end;
end;

end.

