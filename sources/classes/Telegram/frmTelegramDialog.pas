unit frmTelegramDialog;

(* ============================================================================
   Notificari Telegram - canalele (TELEGRAM_CHANNELS) si istoricul cozii
   (TELEGRAM_MESSAGES). Trimiterea o face SWNService (TelegramServiceUnit);
   schema si sursele mesajelor: DB Model/telegram_messages.sql.

   Tab "Canale": codul canalului (WEB_ORDERS, ERRORS, ...) -> CHAT_ID (+ topic).
     Canal fara CHAT_ID / necunoscut -> DEFAULT_CHAT_ID din TS_API_CONFIG.
     Modificarile se salveaza la OK (o tranzactie), Renunta le anuleaza.
     "Trimite test" / "Verifica botul" / "Afla chat ID" merg direct la Telegram
     cu BOT_TOKEN din TS_API_CONFIG (API_CODE = 'TELEGRAM').
   Tab "Istoric": ultimele mesaje; "Retrimite" readuce randurile selectate in
     coada (triggerul AU face POST_EVENT, serviciul le trimite imediat).
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, ComCtrls, DBCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxCheckBox,
    cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
    TfrmTelegramDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pcMain: TPageControl;
        tsChannels: TTabSheet;
        pnChannelsTop: TPanel;
        lbConfig: TLabel;
        lbConfigHint: TLabel;
        cxGridChannels: TcxGrid;
        cxGridChannelsTable: TcxGridDBTableView;
        cxGridChannelsLevel: TcxGridLevel;
        colCH_CHANNEL_CODE: TcxGridDBColumn;
        colCH_TITLE: TcxGridDBColumn;
        colCH_CHAT_ID: TcxGridDBColumn;
        colCH_THREAD_ID: TcxGridDBColumn;
        colCH_FLG_SILENT: TcxGridDBColumn;
        colCH_FLG_ACTIVE: TcxGridDBColumn;
        colCH_NOTE: TcxGridDBColumn;
        pnChannelsBottom: TPanel;
        btnChannelAdd: TcxButton;
        btnChannelDelete: TcxButton;
        btnTestSend: TcxButton;
        btnCheckBot: TcxButton;
        btnFindChats: TcxButton;
        tsHistory: TTabSheet;
        pnHistoryTop: TPanel;
        lbPeriod: TLabel;
        cbPeriod: TComboBox;
        lbStatus: TLabel;
        cbStatus: TComboBox;
        btnRefresh: TcxButton;
        btnResend: TcxButton;
        cxGridHistory: TcxGrid;
        cxGridHistoryTable: TcxGridDBTableView;
        cxGridHistoryLevel: TcxGridLevel;
        colH_TGMSGID: TcxGridDBColumn;
        colH_DATA_CREATED: TcxGridDBColumn;
        colH_CHANNEL_CODE: TcxGridDBColumn;
        colH_STATUS_NAME: TcxGridDBColumn;
        colH_RETRY_COUNT: TcxGridDBColumn;
        colH_DATA_DELIVERED: TcxGridDBColumn;
        colH_NEXT_SEND_TIME: TcxGridDBColumn;
        colH_SOURCE: TcxGridDBColumn;
        colH_LAST_ERROR: TcxGridDBColumn;
        colH_TEXT_PREVIEW: TcxGridDBColumn;
        splHistory: TSplitter;
        mmText: TDBMemo;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        IBCQueryChannels: TIBCQuery;
        IBCDataSourceChannels: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        IBCQueryHistory: TIBCQuery;
        IBCDataSourceHistory: TIBCDataSource;
        IBCTransactionRead: TIBCTransaction;
        procedure btnChannelAddClick(Sender: TObject);
        procedure btnChannelDeleteClick(Sender: TObject);
        procedure btnTestSendClick(Sender: TObject);
        procedure btnCheckBotClick(Sender: TObject);
        procedure btnFindChatsClick(Sender: TObject);
        procedure btnRefreshClick(Sender: TObject);
        procedure btnResendClick(Sender: TObject);
        procedure cbFilterChange(Sender: TObject);
        procedure pcMainChange(Sender: TObject);
        procedure IBCQueryChannelsNewRecord(DataSet: TDataSet);
        procedure IBCQueryChannelsBeforePost(DataSet: TDataSet);
    private
        fToken: string;
        fDefaultChat: string;
        procedure LoadConfig;
        function CheckToken: Boolean;
        procedure OpenHistory;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    System.StrUtils, System.UITypes, DataModuleDB, TelegramApiUnit;

{$R *.dfm}

const
    // cbStatus.ItemIndex -> filtrul pe SENT_STATUS (-1 = toate, 9 = in coada)
    cStatusFilter: array[0..4] of Integer = (-1, 9, 1, 3, 4);
    // cbPeriod.ItemIndex -> zile inapoi (0 = azi, -1 = tot istoricul)
    cPeriodDays: array[0..3] of Integer = (0, 7, 30, -1);

{ TfrmTelegramDlg }

procedure TfrmTelegramDlg.Prepare;
begin
    dtDialogTitle.Text := 'Canalele si istoricul notificarilor Telegram trimise de SWNService';

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    IBCQueryChannels.Connection := dmDB.IBCConnection;
    IBCQueryChannels.Transaction := IBCTransactionUpdate;
    IBCQueryChannels.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryChannels.Open;

    IBCQueryHistory.Connection := dmDB.IBCConnection;
    IBCQueryHistory.Transaction := IBCTransactionRead;

    pcMain.ActivePage := tsChannels;
    LoadConfig;
end;

{ Tokenul si chat-ul implicit stau in TS_API_CONFIG (Setari > Configurari API). }
procedure TfrmTelegramDlg.LoadConfig;
var
    q: TIBCQuery;
begin
    fToken := '';
    fDefaultChat := '';
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.Transaction := IBCTransactionRead;
        q.SQL.Text :=
            'SELECT UPPER(TRIM(PARAM_NAME)) AS PARAM_NAME, TRIM(PARAM_VALUE) AS PARAM_VALUE ' +
            'FROM TS_API_CONFIG WHERE API_CODE = ''TELEGRAM'' AND FLG_ACTIVE = 1';
        q.Open;
        while not q.Eof do
        begin
            if q.FieldByName('PARAM_NAME').AsString = 'BOT_TOKEN' then
                fToken := q.FieldByName('PARAM_VALUE').AsString
            else if q.FieldByName('PARAM_NAME').AsString = 'DEFAULT_CHAT_ID' then
                fDefaultChat := q.FieldByName('PARAM_VALUE').AsString;
            q.Next;
        end;
        q.Close;
    finally
        q.Free;
    end;
    if IBCTransactionRead.Active then
        IBCTransactionRead.Commit;

    lbConfig.Caption := Format('Token bot: %s;   chat implicit (DEFAULT_CHAT_ID): %s',
        [IfThen(fToken = '', 'NECOMPLETAT', 'completat'),
         IfThen(fDefaultChat = '', 'necompletat', fDefaultChat)]);
    if fToken = '' then
        lbConfig.Font.Color := clRed
    else
        lbConfig.Font.Color := clWindowText;
end;

function TfrmTelegramDlg.CheckToken: Boolean;
begin
    LoadConfig;
    Result := fToken <> '';
    if not Result then
        MessageDlg('Completati BOT_TOKEN in Setari > Configurari API (Cod API = TELEGRAM).',
            mtWarning, [mbOK], 0);
end;

procedure TfrmTelegramDlg.btnChannelAddClick(Sender: TObject);
begin
    IBCQueryChannels.Append;
    cxGridChannels.SetFocus;
end;

procedure TfrmTelegramDlg.btnChannelDeleteClick(Sender: TObject);
begin
    if IBCQueryChannels.IsEmpty then
        Exit;
    if MessageDlg(Format('Stergeti canalul %s? Mesajele lui vor merge in chat-ul implicit.',
        [IBCQueryChannels.FieldByName('CHANNEL_CODE').AsString]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    IBCQueryChannels.Delete;
end;

procedure TfrmTelegramDlg.IBCQueryChannelsNewRecord(DataSet: TDataSet);
begin
    DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
    DataSet.FieldByName('FLG_SILENT').AsInteger := 0;
end;

{ Codul canalului e cheia folosita de proceduri (SP_TELEGRAM_SEND('ERRORS', ...)). }
procedure TfrmTelegramDlg.IBCQueryChannelsBeforePost(DataSet: TDataSet);
var
    code: string;
begin
    code := UpperCase(Trim(DataSet.FieldByName('CHANNEL_CODE').AsString));
    if code = '' then
        raise Exception.Create('Completati codul canalului (coloana "Cod").');
    DataSet.FieldByName('CHANNEL_CODE').AsString := code;
    DataSet.FieldByName('CHAT_ID').AsString := Trim(DataSet.FieldByName('CHAT_ID').AsString);
end;

procedure TfrmTelegramDlg.btnTestSendClick(Sender: TObject);
var
    chat, code: string;
    res: TTelegramSendResult;
begin
    if IBCQueryChannels.IsEmpty or not CheckToken then
        Exit;
    if IBCQueryChannels.State in dsEditModes then
        IBCQueryChannels.Post;

    code := IBCQueryChannels.FieldByName('CHANNEL_CODE').AsString;
    chat := Trim(IBCQueryChannels.FieldByName('CHAT_ID').AsString);
    if chat = '' then
        chat := fDefaultChat;
    if chat = '' then
    begin
        MessageDlg('Canalul nu are CHAT_ID si nici DEFAULT_CHAT_ID nu e completat.', mtWarning, [mbOK], 0);
        Exit;
    end;

    Screen.Cursor := crHourGlass;
    try
        res := TelegramSendMessage(fToken, chat, IBCQueryChannels.FieldByName('THREAD_ID').AsInteger,
            Format('Test WMS: canalul %s, trimis de %s la %s',
                [code, dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)]),
            '', IBCQueryChannels.FieldByName('FLG_SILENT').AsInteger = 1);
    finally
        Screen.Cursor := crDefault;
    end;

    if res.Ok then
        MessageDlg(Format('Mesajul de test a ajuns in chat-ul %s (message_id %d).', [chat, res.MessageId]),
            mtInformation, [mbOK], 0)
    else
        MessageDlg(Format('Telegram a refuzat mesajul (HTTP %d): %s' + sLineBreak + sLineBreak +
            'Verificati CHAT_ID-ul si ca botul e administrator in canal / membru in grup.',
            [res.HttpCode, res.Description]), mtError, [mbOK], 0);
end;

procedure TfrmTelegramDlg.btnCheckBotClick(Sender: TObject);
var
    info: string;
    ok: Boolean;
begin
    if not CheckToken then
        Exit;
    Screen.Cursor := crHourGlass;
    try
        ok := TelegramGetMe(fToken, info);
    finally
        Screen.Cursor := crDefault;
    end;
    if ok then
        MessageDlg('Botul raspunde: ' + info, mtInformation, [mbOK], 0)
    else
        MessageDlg('Botul nu raspunde: ' + info, mtError, [mbOK], 0);
end;

procedure TfrmTelegramDlg.btnFindChatsClick(Sender: TObject);
var
    text: string;
    ok: Boolean;
begin
    if not CheckToken then
        Exit;
    Screen.Cursor := crHourGlass;
    try
        ok := TelegramGetRecentChats(fToken, text);
    finally
        Screen.Cursor := crDefault;
    end;
    if ok then
        MessageDlg('Chat-urile vazute recent de bot (ID, tip, titlu):' + sLineBreak + sLineBreak + text +
            sLineBreak + 'Copiati ID-ul (cu minus) in coloana "Chat ID".', mtInformation, [mbOK], 0)
    else
        MessageDlg('Nu s-au putut citi update-urile: ' + text, mtError, [mbOK], 0);
end;

procedure TfrmTelegramDlg.pcMainChange(Sender: TObject);
begin
    if (pcMain.ActivePage = tsHistory) and not IBCQueryHistory.Active then
        OpenHistory;
end;

procedure TfrmTelegramDlg.cbFilterChange(Sender: TObject);
begin
    OpenHistory;
end;

procedure TfrmTelegramDlg.btnRefreshClick(Sender: TObject);
begin
    OpenHistory;
end;

procedure TfrmTelegramDlg.OpenHistory;
var
    days: Integer;
    keepId: Variant;
begin
    keepId := Null;
    if IBCQueryHistory.Active and not IBCQueryHistory.IsEmpty then
        keepId := IBCQueryHistory.FieldByName('TGMSGID').Value;

    days := cPeriodDays[cbPeriod.ItemIndex];
    IBCQueryHistory.Close;
    // read committed: redeschiderea vede ce a trimis serviciul intre timp
    if IBCTransactionRead.Active then
        IBCTransactionRead.Commit;
    if days < 0 then
        IBCQueryHistory.ParamByName('DFROM').AsDateTime := EncodeDate(2000, 1, 1)
    else
        IBCQueryHistory.ParamByName('DFROM').AsDateTime := Date - days;
    IBCQueryHistory.ParamByName('ST').AsInteger := cStatusFilter[cbStatus.ItemIndex];
    IBCQueryHistory.Open;

    if not VarIsNull(keepId) then
        IBCQueryHistory.Locate('TGMSGID', keepId, []);
end;

{ Randurile selectate revin in coada; triggerul TRG_TELEGRAM_MESSAGES_AU
  face POST_EVENT, deci serviciul le trimite imediat. }
procedure TfrmTelegramDlg.btnResendClick(Sender: TObject);
var
    ids: TStringList;
    i: Integer;
    v: Variant;
    q: TIBCQuery;
    tr: TIBCTransaction;
begin
    ids := TStringList.Create;
    try
        with cxGridHistoryTable.Controller do
            for i := 0 to SelectedRecordCount - 1 do
            begin
                v := SelectedRecords[i].Values[colH_TGMSGID.Index];
                if not VarIsNull(v) then
                    ids.Add(IntToStr(Integer(v)));
            end;
        if ids.Count = 0 then
            Exit;
        if MessageDlg(Format('Retrimiteti %d mesaj(e)?', [ids.Count]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
            Exit;

        tr := TIBCTransaction.Create(nil);
        q := TIBCQuery.Create(nil);
        try
            tr.DefaultConnection := dmDB.IBCConnection;
            q.Connection := dmDB.IBCConnection;
            q.Transaction := tr;
            ids.Delimiter := ',';
            ids.StrictDelimiter := True;
            q.SQL.Text :=
                'UPDATE TELEGRAM_MESSAGES SET FLG_SENT = 0, SENT_STATUS = 0, RETRY_COUNT = 0, ' +
                '  NEXT_SEND_TIME = CURRENT_TIMESTAMP, LAST_ERROR = NULL ' +
                'WHERE TGMSGID IN (' + ids.DelimitedText + ')';
            tr.StartTransaction;
            try
                q.Execute;
                tr.Commit;
            except
                tr.Rollback;
                raise;
            end;
        finally
            q.Free;
            tr.Free;
        end;
    finally
        ids.Free;
    end;
    OpenHistory;
end;

function TfrmTelegramDlg.IsFormDataPosted: Boolean;
begin
    if IBCQueryChannels.State in dsEditModes then
        IBCQueryChannels.Post;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;

    Result := True;
end;

procedure TfrmTelegramDlg.WhenCancelForm;
begin
    if IBCQueryChannels.State in dsEditModes then
        IBCQueryChannels.Cancel;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
