unit frmPrepareMailingContentDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, Vcl.StdCtrls;

type
  TfrmPrepareMailingContentDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edServerPath: TEdit;
    btnStart: TButton;
    mmLog: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    edFolderPath: TEdit;
    Label2: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FMailingID: integer;
    procedure SetMailingID(const Value: integer);
    procedure StartPreparing;
    function CheckServerPaths: Boolean;
    function ReadMailingInfo: Boolean;
    function GenerateContent: Boolean;
    function GenerateTargets: integer;

    procedure GenerateHTMLHeader(const content: TStringList);
    procedure GenerateHTMLContent(const content: TStringList);
    procedure GenerateHTMLFooter(const content: TStringList);
    procedure GenerateHTMLImage(const content: TStringList; const ImageFileName: String; const ImageWidth, ImageHeight: integer;
      const Links: TStringList);

    procedure EmptyDirectory(const PathName: String);
    procedure GetImageLinks(const PAImageBrickID: integer; const Links: TStringList);
    function SaveHTMLContentToDB(const content: TStringList): Boolean;
    procedure MarkAsReadyToSend;
    function ProcessGoodsLink(const Url: String): String;
    function ProcessFooterText(const FooterText: String): String;

  protected
    { protected declarations }
    fServerPath: String;
    fContentPath: String;
    fTargetPath: String;
    fMailing_Title: String;
    fMailing_HeaderText: String;
    fMailing_HeaderImage: Boolean;
    fMailing_FooterText: String;
    fMailing_FooterImage: Boolean;
    fGoogleTag: string;

    procedure Prepare; override;
  public
    { Public declarations }
    property MailingID: integer read FMailingID write SetMailingID;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, IBC, DataModuleDB, DB, SWNDBErrors, SWNUtils;

{ TfrmPrepareMailingContentDlg }

procedure TfrmPrepareMailingContentDlg.btnOkClick(Sender: TObject);
begin
  MarkAsReadyToSend;
end;

procedure TfrmPrepareMailingContentDlg.btnStartClick(Sender: TObject);
begin
  StartPreparing;
end;

function TfrmPrepareMailingContentDlg.CheckServerPaths: Boolean;
var
  dirName: String;
begin
  Result := False;
  mmLog.Lines.Add('Verificare cai...');
  Application.ProcessMessages;
  fServerPath := IncludeTrailingPathDelimiter(edServerPath.Text);
  fContentPath := IncludeTrailingPathDelimiter(edFolderPath.Text);
  if Not DirectoryExists(fServerPath, true) then
  begin
    mmLog.Lines.Add('Nu exista acces sau calea este incorecta "' + fServerPath + '"!');
    Exit;
  end;
  if Not DirectoryExists(fServerPath + fContentPath, true) then
  begin
    mmLog.Lines.Add('Cale incorecta "' + fContentPath + '"!');
    Exit;
  end;

  // pregatim directoriul
  dirName := IncludeTrailingPathDelimiter(Format('%d', [FMailingID]));

  if DirectoryExists(fServerPath + fContentPath + dirName, true) then
  begin
    mmLog.Lines.Add('Stergem continutul vechi...');
    EmptyDirectory(fServerPath + fContentPath + dirName);
  end
  else
  begin
    mmLog.Lines.Add('Cream folderul nou: "' + dirName + '"...');
    if Not CreateDir(fServerPath + fContentPath + dirName) then
    begin
      mmLog.Lines.Add('Nu se poate crea folderul!');
      Exit;
    end;
  end;

  fContentPath := fContentPath + dirName;
  fTargetPath := fServerPath + fContentPath;

  fContentPath := StringReplace(fContentPath, '\', '/', [rfReplaceAll]);

  mmLog.Lines.Add('Totul OK!');
  Result := true;
end;

procedure TfrmPrepareMailingContentDlg.EmptyDirectory(const PathName: String);
var
  sr: TSearchRec;
  N: integer;
begin
  N := FindFirst(PathName + '*.*', faArchive, sr);
  try
    While (N = 0) do
    begin
      DeleteFile(PathName + sr.Name);
      N := FindNext(sr);
    end;
  finally
    FindClose(sr);
  end;
end;

function TfrmPrepareMailingContentDlg.GenerateContent: Boolean;
var
  content: TStringList;
begin
  mmLog.Lines.Add('Generam continutul...');
  Application.ProcessMessages;

  content := TStringList.Create;
  try
    content.Add('<div style="width:700px; margin:0px auto;font-size: 14px; font-family: Arial;text-transform: none;">');
    // header
    GenerateHTMLHeader(content);
    // content
    GenerateHTMLContent(content);
    // footer
    GenerateHTMLFooter(content);

    content.Add('</div>');
    content.SaveToFile('C:\Projects\content.htm');

    // save content to DB
    Result := SaveHTMLContentToDB(content);

  finally
    content.Free;
  end;

  if Result then
    mmLog.Lines.Add('Totul OK!')
  else
    mmLog.Lines.Add('Eroare! Nu se poate genera continutul.');
end;

procedure TfrmPrepareMailingContentDlg.GenerateHTMLContent(const content: TStringList);
var
  Query: TIBCQuery;
  ImageFileName: String;
  Links: TStringList;
begin
  content.Add('<div>');
  Links := TStringList.Create;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT IB.PAIMAGEBRICKID, IB.IMAGE, IB.IMAGE_WIDTH, IB.IMAGE_HEIGHT');
    Query.SQL.Add('FROM TWEB_MAILING_IMAGEBRICKS M');
    Query.SQL.Add('INNER JOIN TWEB_PA_IMAGEBRICKS IB ON IB.PAIMAGEBRICKID = M.PAIMAGEBRICKID');
    Query.SQL.Add('WHERE M.MAILINGID=:id ORDER BY M.ORDERNO');
    Query.ParamByName('id').AsInteger := FMailingID;
    Query.ExecSQL;
    while Not Query.Eof do
    begin
      ImageFileName := Format('%d.png', [Query.Fields[0].AsInteger]);
      TBlobField(Query.Fields[1]).SaveToFile(fTargetPath + ImageFileName);
      mmLog.Lines.Add('"' + ImageFileName + '" - exported.');
      GetImageLinks(Query.Fields[0].AsInteger, Links);
      GenerateHTMLImage(content, ImageFileName, Query.Fields[2].AsInteger, Query.Fields[3].AsInteger, Links);
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
    Links.Free;
  end;
  content.Add('</div>');
end;

procedure TfrmPrepareMailingContentDlg.GenerateHTMLFooter(const content: TStringList);
begin
  if (Length(fMailing_FooterText) > 0) or fMailing_FooterImage then
  begin
    content.Add('<div>');
    if fMailing_FooterImage then
      content.Add('<div style="line-height:0px;margin:0px;padding:0px"><img src="http://www.fantastic.md/' + fContentPath +
        'footer.png" alt="" border="0"/></div>');

    if (Length(fMailing_FooterText) > 0) then
      content.Add('<div style="text-align: center;font-size:9px;padding: 20px;">' + ProcessFooterText(fMailing_FooterText) + '</div>');
    content.Add('</div>');
  end;
end;

procedure TfrmPrepareMailingContentDlg.GenerateHTMLHeader(const content: TStringList);
begin
  if (Length(fMailing_HeaderText) > 0) or fMailing_HeaderImage then
  begin
    content.Add('<div>');
    if (Length(fMailing_HeaderText) > 0) then
      content.Add('<div style="text-align: center;padding: 20px;">' + fMailing_HeaderText + '</div>');

    if fMailing_HeaderImage then
      content.Add('<div style="line-height:0px;margin:0px;padding:0px"><a href="http://www.fantastic.md"><img src="http://www.fantastic.md/' +
        fContentPath + 'header.png" alt="" border="0"/></a></div>');
    content.Add('</div>');
  end;
end;

procedure TfrmPrepareMailingContentDlg.GenerateHTMLImage(const content: TStringList; const ImageFileName: String;
  const ImageWidth, ImageHeight: integer; const Links: TStringList);
var
  mapName: String;
  i, x0, x1, delta: integer;
begin
  mapName := Format('idMap%s', [ImageFileName]);
  mapName := Copy(mapName, 1, Length(mapName) - 4);
  content.Add('<div style="line-height:0px;margin:0px;padding:0px">');
  content.Add(Format('<img src="http://www.fantastic.md/%s%s%s" usemap="#%s" border="0" alt="" />', [fContentPath, ImageFileName, fGoogleTag, mapName]));
  content.Add('</div>');
  content.Add('<map name="' + mapName + '">');
  x0 := 0;
  delta := round(ImageWidth / Links.Count);
  for i := 0 to Links.Count - 1 do
  begin
    x1 := x0 + delta - 1;
    if (i = Links.Count - 1) then
    begin
      if (x1 > (ImageWidth - 1)) or (x1 < (ImageWidth - 1)) then
        x1 := ImageWidth - 1;
    end;
    content.Add(Format('<area shape="rect" coords="%d,%d,%d,%d" href="%s" target="_blank" />',
      [x0, 0, x1, ImageHeight - 1, ProcessGoodsLink(Links[i])]));
    x0 := x0 + delta;
  end;
  content.Add('</map>');
end;

function TfrmPrepareMailingContentDlg.GenerateTargets: integer;
var
  Query: TIBCQuery;
begin
  Result := 0;
  mmLog.Lines.Add('Construim lista clientilor...');
  Application.ProcessMessages;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'SELECT EMAIL_COUNT FROM SP_WEB_CREATETARGETS(:id)';
    Query.ParamByName('id').AsInteger := FMailingID;
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
  if (Result > 0) then
    mmLog.Lines.Add(Format('Total destinatari: %d!', [Result]))
  else
    mmLog.Lines.Add('Nu sunt destinatari!');
end;

procedure TfrmPrepareMailingContentDlg.GetImageLinks(const PAImageBrickID: integer; const Links: TStringList);
var
  Query: TIBCQuery;
begin
  Links.Clear;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT NAV_URL FROM TWEB_PA_IB_LINKS WHERE PAIMAGEBRICKID=:id ORDER BY ORDERNO';
    Query.ParamByName('id').AsInteger := PAImageBrickID;
    Query.ExecSQL;
    While Not Query.Eof do
    begin
      Links.Add(Query.Fields[0].AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmPrepareMailingContentDlg.MarkAsReadyToSend;
var
  Query: TIBCQuery;
begin
  if ShowAskDialog('Trimiterea este gata', 'Doriti sa marcati aceasta trimitere ca gata pentru expediere?') <> mrYes then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_WEB_MAILING_MARKREADY(:id)';
    Query.ParamByName('id').AsInteger := FMailingID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      ModalResult := mrOk;
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

procedure TfrmPrepareMailingContentDlg.Prepare;
begin
  btnOk.Enabled := False;
end;

function TfrmPrepareMailingContentDlg.ProcessFooterText(const FooterText: String): String;
begin
  Result := FooterText;
end;

function TfrmPrepareMailingContentDlg.ProcessGoodsLink(const Url: String): String;
begin
  Result := Url;
  // Append MailingID to navigate url
  if (pos('?', Result) > 0) then
    Result := Format('%s&mid=%d', [Result, FMailingID])
  else
    Result := Format('%s?mid=%d', [Result, FMailingID])
end;

function TfrmPrepareMailingContentDlg.ReadMailingInfo: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  mmLog.Lines.Add('Verificare trimitere...');
  Application.ProcessMessages;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT * FROM TWEB_MAILINGS WHERE MAILINGID=:id';
    Query.ParamByName('id').AsInteger := FMailingID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      fMailing_Title := Query.FieldByName('TITLE').AsString;
      fMailing_HeaderText := Query.FieldByName('HEADER_TEXT').AsString;
      fMailing_FooterText := Query.FieldByName('FOOTER_TEXT').AsString;
      fGoogleTag := Query.FieldByName('GOOGLETAG').AsString;
      mmLog.Lines.Add('Trimitere: "' + fMailing_Title + '"');

      fMailing_HeaderImage := False;
      if Not Query.FieldByName('HEADER_IMAGE').IsNull then
      begin
        TBlobField(Query.FieldByName('HEADER_IMAGE')).SaveToFile(fTargetPath + 'header.png');
        fMailing_HeaderImage := true;
        mmLog.Lines.Add('"header.png" - exported.');
      end;
      fMailing_FooterImage := False;
      if Not Query.FieldByName('FOOTER_IMAGE').IsNull then
      begin
        TBlobField(Query.FieldByName('FOOTER_IMAGE')).SaveToFile(fTargetPath + 'footer.png');
        fMailing_FooterImage := true;
        mmLog.Lines.Add('"footer.png" - exported.');
      end;

      mmLog.Lines.Add('Totul OK!');
      Result := true;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

function TfrmPrepareMailingContentDlg.SaveHTMLContentToDB(const content: TStringList): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_WEB_MAILING_SETHTMLCONTENT(:id,:data)';
    Query.ParamByName('id').AsInteger := FMailingID;
    Query.ParamByName('data').AsString := content.Text;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := true;
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

procedure TfrmPrepareMailingContentDlg.SetMailingID(const Value: integer);
begin
  FMailingID := Value;
end;

procedure TfrmPrepareMailingContentDlg.StartPreparing;
begin
  mmLog.Lines.Clear;
  Application.ProcessMessages;
  if FMailingID = 0 then
  begin
    mmLog.Lines.Add('MailingID is unknown!');
    Exit;
  end;

  try
    if Not CheckServerPaths then
      Exit;
    if Not ReadMailingInfo then
      Exit;
    if Not GenerateContent then
      Exit;
    if GenerateTargets = 0 then
      Exit;

    mmLog.Lines.Add('Gata!');

    btnStart.Enabled := False;
    btnOk.Enabled := true;
    btnOk.SetFocus;

  except
    on E: Exception do
    begin
      mmLog.Lines.Add('Eroare!');
      mmLog.Lines.Add(E.Message);
    end;
  end;
end;

end.
