unit frmCustomerWebDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit,
  Dialogs, DialogTitle, Menus, DBAccess, IBC, DB, MemDS, StdCtrls,
  cxDBEdit,
  ExtCtrls, Vcl.ComCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit;

type
  TfrmCustomerWebDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnWeb: TPanel;
    IBCQueryWEB: TIBCQuery;
    IBCDataSourceWEB: TIBCDataSource;
    Label1: TLabel;
    edDISPLAYNAME: TcxDBTextEdit;
    pcPages: TPageControl;
    tbsGeneral: TTabSheet;
    tbsDoNotShow: TTabSheet;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edLOGIN: TcxDBTextEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    cbFLG_NO_COMERCIALS: TcxDBCheckBox;
    tbsGoods: TTabSheet;
    cbFLG_PRICE_USD: TcxDBCheckBox;
    cbFLG_PRICE_BY_CLIENT: TcxDBCheckBox;
    cbFLG_VIEW_REAL_STOCKS: TcxDBCheckBox;
    cbFLG_NO_FACEBOOK: TcxDBCheckBox;
    cbFLG_NO_CHAT: TcxDBCheckBox;
    tbsAdmin: TTabSheet;
    cbFLG_NPSC: TcxDBCheckBox;
    cbFLG_EDIT_GOODS: TcxDBCheckBox;
    Label3: TLabel;
    cbFLG_NO_CREDIT: TcxDBCheckBox;
    cbFLG_NO_ADDS_GOODS: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnSetPassword: TcxButton;
    btnRandomPass: TcxButton;
    cxButton1: TcxButton;
    cbRegisterNewCustomer: TcxCheckBox;
    cbChangePassword: TcxCheckBox;
    Label2: TLabel;
    cbLanguage: TcxDBComboBox;
    Label4: TLabel;
    edEMail: TcxDBTextEdit;
    procedure btnSetPasswordClick(Sender: TObject);
    procedure btnRandomPassClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
    function CheckParams: Boolean;
    function GetExistsingCustomerEMail(const CustomerID: integer): String;
    function GetRandomPass: string;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SendEmailRegisterNewCustomerAccount(CustomerName, Email,
        DefaultPassword, Language: string);
    procedure WhenCancelForm; override;

    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    function EditWebAccess: Boolean;
  end;

implementation

uses SWNUtils, frmPasswordDlg, SWNSecurityUtils, SWNConst,
  SWNSecurity, DataModuleDB;

{$R *.dfm}
{ TfrmCustomerWebDialog }

function TfrmCustomerWebDialog.CheckParams: Boolean;
var
  ErrorStr: String;
  S: String;
begin
  Result := False;
  ErrorStr := '';
  if (IBCQueryWEB.FieldByName('LOGIN').IsNull) or
    (IBCQueryWEB.FieldByName('LOGIN').asString = '') then
    AddErrorToStr(ErrorStr, 'Логин!')
  else
  begin
    S := IBCQueryWEB.FieldByName('LOGIN').asString;
    if (Length(S) < 6) or (Pos('@', S) = 0) then
      AddErrorToStr(ErrorStr, 'Логин (Е-Мэйл)!');
  end;
  if (IBCQueryWEB.FieldByName('PASSWORD_HASH').IsNull) then
    AddErrorToStr(ErrorStr, 'Пароль!');
  if (IBCQueryWEB.FieldByName('FLG_ENABLED').IsNull) then
    AddErrorToStr(ErrorStr, 'Интернет доступ!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmCustomerWebDialog.cxButton1Click(Sender: TObject);
begin
  if cbRegisterNewCustomer.Checked then
  begin
    if IBCQueryWEB.FieldByName('PASSWORD_HASH').AsString <> '' then
    begin
      SendEmailRegisterNewCustomerAccount(fMasterDataSet.FieldByName('NAME').AsString,
                  IBCQueryWEB.FieldByName('LOGIN').AsString,
                  'fantastic',
                  IBCQueryWEB.FieldByName('PREFFERED_LANGUAGE').AsString);
      ShowMessage('Transmis spre expediere...');
    end
    else
      MessageDlg('Parola nu este setata!', mtError, [mbOK], 0);
  end;

  if cbChangePassword.Checked then
  begin
//  SendEmailChangePasswordWebAccount()
    ShowMessage('Transmis spre expediere...');
  end;
end;

procedure TfrmCustomerWebDialog.btnRandomPassClick(Sender: TObject);
begin
//  IBCQueryWEB.FieldByName('PASSWORD_HASH').asString := CreateHashPassword(GetRandomPass);
  IBCQueryWEB.FieldByName('PASSWORD_HASH').asString := CreateHashPassword('fantastic');
end;

procedure TfrmCustomerWebDialog.btnSetPasswordClick(Sender: TObject);
var
  passDialog: TfrmPasswordDialog;
begin
  passDialog := TfrmPasswordDialog.Create(Self, pdmNewPassword);
  try
    if passDialog.ShowModal = mrOk then
    begin
      IBCQueryWEB.FieldByName('PASSWORD_HASH').asString :=
        CreateHashPassword(passDialog.Password);
    end;
  finally
    passDialog.Free;
  end;
end;

function TfrmCustomerWebDialog.EditWebAccess: Boolean;
begin
  Result := ShowModal = mrOk;
end;

function TfrmCustomerWebDialog.GetExistsingCustomerEMail(const CustomerID
  : integer): String;
var
  Query: TIBCQuery;
begin
  Result := '';

  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text :=
      'SELECT EMAIL FROM TS_CUST_EMAILS WHERE CUSTOMERID=:id AND UNSUBSCRIBED=0';
    Query.ParamByName('id').AsInteger := CustomerID;
    Query.ExecSQL;
    if Not Query.Eof then
      Result := Query.Fields[0].asString;
  finally
    Query.Free;
  end;
end;

function TfrmCustomerWebDialog.GetRandomPass: string;
const
  data = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()';
var
  i: integer;
begin
  Result := '';
  Randomize;
  for i := 1 to 10 do
    Result := Result + data[Random(Length(data)) + 1];
end;

procedure TfrmCustomerWebDialog.BindingDataSource;
begin
  inherited;

  IBCQueryWEB.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryWEB.MasterSource := fMasterDataSource;
  edDISPLAYNAME.DataBinding.DataSource := fMasterDataSource;

end;

function TfrmCustomerWebDialog.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    IBCQueryWEB.Post;
    IBCQueryWEB.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmCustomerWebDialog.Prepare;
var
  S: string;
begin
  pcPages.ActivePage := tbsGeneral;

  IBCQueryWEB.UpdateTransaction.StartTransaction;
  try
    IBCQueryWEB.Active := True;

    if IBCQueryWEB.RecordCount>1 then
      raise Exception.Create('Sunt mai multe emailuri inregistrare pentru logare la acest utilizator!');

    if IBCQueryWEB.RecordCount=0 then
    begin
      dtDialogTitle.Text := 'Создание новой записи';
      dtDialogTitle.Color := clWebLightCoral;

      IBCQueryWEB.Append;
      IBCQueryWEB.FieldByName('FLG_ENABLED').AsInteger := 1;
      IBCQueryWEB.FieldByName('FLG_NO_COMERCIALS').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_VIEW_REAL_STOCKS').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_NPSC').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_EDIT_GOODS').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_NO_FACEBOOK').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_NO_CHAT').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_NO_CREDIT').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_NO_ADDS_GOODS').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_PRICE_BY_CLIENT').AsInteger := 0;
      IBCQueryWEB.FieldByName('FLG_PRICE_USD').AsInteger := 0;

      S := GetExistsingCustomerEMail(fMasterDataSet.FieldByName('CUSTOMERID')
        .AsInteger);
      if S <> '' then
        IBCQueryWEB.FieldByName('LOGIN').AsString := S;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';
      dtDialogTitle.Color := clWebLightSkyBlue;
      IBCQueryWEB.Edit;
    end;
  except
    IBCQueryWEB.Cancel;
    IBCQueryWEB.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmCustomerWebDialog.SendEmailRegisterNewCustomerAccount(
    CustomerName, Email, DefaultPassword, Language: string);
const
  EmailTemplateRo = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' +
                    '<html xmlns="http://www.w3.org/1999/xhtml">' +
                    '<head>' +
                    '<title>Bun venit în internet-magazin %s</title>' +
                    '</head>' +
                    '<body>' +
                    '<div style="font-family: Arial; font-size: 16px; padding: 16px;">' +
                    '<div style="width:700px;">' +
                    '<img src="%s/img/webOrder-Header.png" />' +
                    '<div>' +
                    '<br />' +
                    '<div>Bună ziua, <b>%s</b>!</div>' +
                    '<br />' +
                    '<div>Bun venit în internet-magazin %s</div>' +
                    '<br />' +
                    '<div>Contul d-stră a fost creat — acum puteți face cumpărături online din magazinul nostru.</div>' +
                    '<br />' +
                    '<div>E-Mail: <b>%s</b></div>' +
                    '<div>Parola: <b>%s</b></div>' +
                    '<br />' +
                    '<div>Pe site, în meniul personal, puteți să modificați parola sau să completați informația personală.</div>' +
                    '<br/>' +
                    '<div>Dacă aveți întrebări sau dificultăți în utilizarea contului %s, vă rugăm să apelați la telefonul %s.</div>' +
                    '<br />' +
                    '<div>Mulțumim, al vostru <a href="%s">%s</a>.</div><br />' +
                    '</div>' +
                    '<br/>' +
                    '<img src="%s/img/webOrder-Footer.png" />' +
                    '</div>' +
                    '</div>' +
                    '</body>' +
                    '</html>';

  EmailTemplateRu = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' +
                    '<html xmlns="http://www.w3.org/1999/xhtml">' +
                    '<head>' +
                    '<title>Добро пожаловать в интернет-магазин %s</title>' +
                    '</head>' +
                    '<body>' +
                    '<div style="font-family: Arial; font-size: 16px; padding: 16px;">' +
                    '<div style="width:700px;">' +
                    '<img src="%s/images/webOrder-Header.png" />' +
                    '<div>' +
                    '<br />' +
                    '<div>Здравствуйте, <b>%s</b>!</div>' +
                    '<br />' +
                    '<div>Добро пожаловать в наш интернет-магазин %s.</div>' +
                    '<br />' +
                    '<div>Ваш аккаунт создан — теперь вы легко сможете делать покупки в нашем интернет-магазине.</div>' +
                    '<br />' +
                    '<div>Ваш логин: <b>%s</b></div>' +
                    '<div>Ваш пароль: <b>%s</b></div>' +
                    '<br />' +
                    '<div>Вы можете изменить пароль и дополнить персональную информацию в "Личном кабинете".</div>' +
                    '<br/>' +
                    '<div>Если есть вопросы или возникли трудности в использование аккаунта %s - позвоните по телефону %s.</div>' +
                    '<br />' +
                    '<div>Спасибо, ваш <a href="%s">%s</a>.</div>' +
                    '<br />' +
                    '</div>' +
                    '<br/>' +
                    '<img src="%s/images/webOrder-Footer.png" />' +
                    '</div>' +
                    '</div>' +
                    '</body>' +
                    '</html>';

   SubjectTemplateRo = 'Bun venit în internet-magazin Fantastic.MD';
   SubjectTemplateRu = 'Добро пожаловать в интернет-магазин Fantastic.MD';
var
  Body: string;
  subject: string;
begin
    if UpperCase(Language) = 'RO' then
    begin
      Body := EmailTemplateRo;
      Subject := SubjectTemplateRo;
    end
    else
    begin
        Body := EmailTemplateRu;
        Subject := SubjectTemplateRu;
    end;

    Body := Format(Body, [
                'Fantastic.MD',
                'https://www.fantastic.md',
                CustomerName,
                'Fantastic.md',
                Email,
                DefaultPassword,
                'Fantastic.md',
                '(022)90-30-90',
                'https://www.fantastic.md',
                'Fantastic.md',
                'https://www.fantastic.md']);


    dmdb.SendSWNMail(email, subject, body);
end;

procedure TfrmCustomerWebDialog.SetupSecurityItems;
begin
  // este Administrator
  if Not SWNSecurityManager.UserIsPartOfGroup(1) then
  begin
    tbsDoNotShow.TabVisible := False;
    tbsGoods.TabVisible := False;
    tbsAdmin.TabVisible := False;
  end;
end;

procedure TfrmCustomerWebDialog.WhenCancelForm;
begin
  IBCQueryWEB.Cancel;
  IBCQueryWEB.UpdateTransaction.Rollback;
end;

end.
