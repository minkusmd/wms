unit frmChangeMoneyReceiverDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, DBAccess, IBC, MemDS;

type
  TfrmChangeMoneyReceiverDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edUserName: TcxTextEdit;
    edFirmaName: TcxTextEdit;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryFirme: TIBCQuery;
    IBCDataSourceFirme: TIBCDataSource;
    btnOk: TButton;
    btnCancel: TButton;
    lcbUser: TcxLookupComboBox;
    lcbFirma: TcxLookupComboBox;
  private
    FCT: integer;
    FUserID: integer;
    FJurnalID: integer;
    FDT_UserName: String;
    FDT_Name: String;
    FShowCurrentUsed: Boolean;
    { Private declarations }
    function CheckValues:Boolean;
    procedure SetCT(const Value: integer);
    procedure SetJurnalID(const Value: integer);
    procedure SetUserID(const Value: integer);
    procedure SetDT_Name(const Value: String);
    procedure SetDT_UserName(const Value: String);
    procedure SetShowCurrentUsed(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    function SaveValues:Boolean;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    property DT_UserName:String read FDT_UserName write SetDT_UserName;
    property DT_Name:String read FDT_Name write SetDT_Name;
    property JurnalID:integer read FJurnalID write SetJurnalID;
    property CT:integer read FCT write SetCT;
    property UserID:integer read FUserID write SetUserID;
    property ShowCurrentUsed:Boolean read FShowCurrentUsed write SetShowCurrentUsed;
  end;


implementation

{$R *.dfm}

uses SWNUtils, SWNConst, DataModuleDB, SWNDBErrors;

{ TfrmChangeMoneyReceiverDlg }

function TfrmChangeMoneyReceiverDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     if VarIsNull(lcbUser.EditValue) or (lcbUser.EditValue<=0) then AddErrorToStr(ErrorStr,'Destinatar nou!');
     if VarIsNull(lcbFirma.EditValue) or (lcbFirma.EditValue<=0) then AddErrorToStr(ErrorStr,'Firma!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

constructor TfrmChangeMoneyReceiverDlg.Create(AOwner: TComponent);
begin
     inherited;
     FShowCurrentUsed:=False;
end;

function TfrmChangeMoneyReceiverDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues and SaveValues;
end;

procedure TfrmChangeMoneyReceiverDlg.Prepare;
begin
     edUserName.Text:=FDT_UserName;
     edFirmaName.Text:=FDT_Name;

     IBCQueryUsers.ParamByName('SCU').AsInteger:=Ord(FShowCurrentUsed);
     IBCQueryUsers.Active:=True;
     IBCQueryFirme.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryFirme.Active:=True;

     lcbUser.EditValue:=FUserID;
     lcbFirma.EditValue:=FCT;
end;

function TfrmChangeMoneyReceiverDlg.SaveValues: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='UPDATE TDB_CASH_JURNAL SET CT=:CT, USER_CT=:USERID WHERE ID=:ID';
        Query.ParamByName('CT').AsInteger:=lcbFirma.EditValue;
        Query.ParamByName('USERID').AsInteger:=lcbUser.EditValue;
        Query.ParamByName('ID').AsInteger:=FJurnalID;
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
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

procedure TfrmChangeMoneyReceiverDlg.SetCT(const Value: integer);
begin
  FCT := Value;
end;

procedure TfrmChangeMoneyReceiverDlg.SetDT_Name(const Value: String);
begin
     FDT_Name := Value;
end;

procedure TfrmChangeMoneyReceiverDlg.SetDT_UserName(const Value: String);
begin
     FDT_UserName := Value;
end;

procedure TfrmChangeMoneyReceiverDlg.SetJurnalID(const Value: integer);
begin
  FJurnalID := Value;
end;

procedure TfrmChangeMoneyReceiverDlg.SetShowCurrentUsed(const Value: Boolean);
begin
     FShowCurrentUsed := Value;
end;

procedure TfrmChangeMoneyReceiverDlg.SetUserID(const Value: integer);
begin
  FUserID := Value;
end;


end.
