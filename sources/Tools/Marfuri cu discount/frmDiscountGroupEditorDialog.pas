unit frmDiscountGroupEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, System.Types,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxDropDownEdit, cxMaskEdit, cxCalendar, cxDBEdit, cxTextEdit, cxMemo, Buttons, Menus,
  DBAccess, IBC;

type
  TfrmDiscountGroupEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    Label2: TLabel;
    Label4: TLabel;
    cmbDISCOUNT_TYPE: TcxComboBox;
    Label6: TLabel;
    mmSMS: TcxDBMemo;
    sbTags: TSpeedButton;
    pmTags: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    sbSendTestSMS: TSpeedButton;
    IBCTrSMSUpdate: TIBCTransaction;
    Label3: TLabel;
    procedure sbTagsClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure sbSendTestSMSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewGroup: Boolean;
    procedure SetCreateNewGroup(const Value: Boolean);
    function CheckInputParams:Boolean;
    function SendTestSMS(const PhoneNumber,SMSText:String):Boolean;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewGroup:Boolean read FCreateNewGroup write SetCreateNewGroup;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst, SWNSecurity, SWNDBErrors, DataModuleDB;

{$R *.dfm}

{ TfrmDiscountGroupEditorDlg }

function TfrmDiscountGroupEditorDlg.CheckInputParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString='') then AddErrorToStr(ErrorStr,'Denumirea actiunii!');
     if fMasterDataSet.FieldByName('START_DATE').IsNull or fMasterDataSet.FieldByName('END_DATE').IsNull then AddErrorToStr(ErrorStr,'Perioada actiunii!');
     if cmbDISCOUNT_TYPE.ItemIndex=-1 then AddErrorToStr(ErrorStr,'Tipul discountului!');
     if fMasterDataSet.FieldByName('SMS_TEMPLATE').IsNull or (fMasterDataSet.FieldByName('SMS_TEMPLATE').AsString='') then AddErrorToStr(ErrorStr,'Textul notificarii SMS!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmDiscountGroupEditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     deSTART_DATE.DataBinding.DataSource:=fMasterDataSource;
     deEND_DATE.DataBinding.DataSource:=fMasterDataSource;
     mmSMS.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmDiscountGroupEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.FieldByName('DISCOUNT_TYPE').AsInteger:=cmbDISCOUNT_TYPE.ItemIndex+1;
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmDiscountGroupEditorDlg.N2Click(Sender: TObject);
var menu:TMenuItem;
begin
     menu:=TMenuItem(Sender);
     case menu.Tag of
     1: mmSMS.SelText:='$CODE';
     2: mmSMS.SelText:='$DISCOUNT';
     end;
end;

procedure TfrmDiscountGroupEditorDlg.Prepare;
begin
     sbSendTestSMS.Enabled:=Length(SWNSecurityManager.LoggedUser.Telefon)>=8;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewGroup then
        begin
             dtDialogTitle.Text:='Creare grup nou';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DISCOUNT_TYPE').AsInteger:=1;
             fMasterDataSet.FieldByName('START_DATE').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('END_DATE').AsDateTime:=NOW+14;
        end
        else
        begin
             dtDialogTitle.Text:='';
             fMasterDataSet.Edit;
        end;

        cmbDISCOUNT_TYPE.ItemIndex:=fMasterDataSet.FieldByName('DISCOUNT_TYPE').AsInteger-1;

     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmDiscountGroupEditorDlg.sbSendTestSMSClick(Sender: TObject);
var phoneNumber:String;
    text:String;
begin
     phoneNumber:=SWNSecurityManager.LoggedUser.Telefon;
     if ShowAskDialog('SMS',Format('Trimiteti un SMS de test la numarul %s ?',[phoneNumber]))<>mrYes then Exit;

     text:=mmSMS.Text;
     text:=StringReplace(text,'$CODE','XXX-XXX-XXX',[rfReplaceAll]);
     if (cmbDISCOUNT_TYPE.ItemIndex=2) then text:=StringReplace(text,'$DISCOUNT','0000',[rfReplaceAll])
     else text:=StringReplace(text,'$DISCOUNT','00',[rfReplaceAll]);
     text:=StringReplace(text,'~',#13,[rfReplaceAll]);

     text:=Copy(text,1,160);
     if SendTestSMS(phoneNumber,text) then ShowInfoDialog('SMS trimis','SMS trimis la numarul dvs. Timp de sosire pana la 30 secunde.');
end;

procedure TfrmDiscountGroupEditorDlg.sbTagsClick(Sender: TObject);
var P:TPoint;
begin
     P:=Point(sbTags.Left,sbTags.Top+sbTags.Height+4);
     P:=pnClient.ClientToScreen(P);
     pmTags.Popup(P.X,P.Y);
end;

function TfrmDiscountGroupEditorDlg.SendTestSMS(const PhoneNumber, SMSText: String):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=True;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCTrSMSUpdate;
        Query.SQL.Text:='INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT) VALUES (:phone,:text)';
        Query.ParamByName('phone').AsString:=PhoneNumber;
        Query.ParamByName('text').AsString:=SMSText;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmDiscountGroupEditorDlg.SetCreateNewGroup(const Value: Boolean);
begin
     fCreateNewGroup := Value;
end;

procedure TfrmDiscountGroupEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
