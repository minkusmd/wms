unit frmMoneyAcceptDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxDBEdit,
  cxCurrencyEdit, frameMoneyCounterUnit,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxMemo,
  cxCheckBox, cxTextEdit;

type
  TfrmMoneyAcceptDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edUSER_DT_NAME: TcxDBTextEdit;
    edDT_NAME: TcxDBTextEdit;
    Label2: TLabel;
    cbFLG_ACNT_DT: TcxDBCheckBox;
    Label4: TLabel;
    ceSUMA_DT: TcxDBCurrencyEdit;
    Label5: TLabel;
    edUSER_CT_NAME: TcxDBTextEdit;
    Label6: TLabel;
    edCT_NAME: TcxDBTextEdit;
    Label7: TLabel;
    ceSUMA_CT: TcxCurrencyEdit;
    Label3: TLabel;
    Label8: TLabel;
    edCURRENCY_CT_NAME: TcxDBTextEdit;
    edCURRENCY_DT_NAME: TcxDBTextEdit;
    frameMoneyCounter: TframeMoneyCounter;
    Label9: TLabel;
    mmCOMMENT: TcxDBMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    function CheckParams:Boolean;
    function CheckTargetCredentials(const UserID:integer):Boolean;
    function DoTransferAcceptDB:Boolean;

    procedure WhenCalculatorSumaChanged(Sender:TObject);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
  end;

implementation

uses SWNUtils, DataModuleDB, IBC, SWNDBErrors, frmPasswordDlg, SWNSecurity;

{$R *.dfm}

{ TfrmMoneyAcceptDlg }

function TfrmMoneyAcceptDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if VarIsNull(ceSUMA_CT.EditValue) or (ceSUMA_CT.EditValue<=0) then AddErrorToStr(ErrorStr,'Укажите сумму денег!');

     if (ErrorStr='') then Result:=True
     else ShowErrorDialog('Ошибка данных',ErrorStr);
end;

function TfrmMoneyAcceptDlg.CheckTargetCredentials(const UserID: integer): Boolean;
var dialog:TfrmPasswordDialog;
begin
     Result:=False;
     dialog:=TfrmPasswordDialog.Create(Self,pdmAskPassword);
     try
        if dialog.ShowModal=mrOk then Result:=SWNSecurityManager.TestUserPassword(UserID,dialog.Password);
     finally
        dialog.Free;
     end;
end;

function TfrmMoneyAcceptDlg.DoTransferAcceptDB: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='UPDATE VW_TDB_CASH_JURNAL SET FLG_CT_CONFIRMED=:FLG_CT_CONFIRMED, SUMA_CT=:SUMA_CT, DATA_CT=:DATA_CT'+
                           ' WHERE (ID=:ID)';

           Query.ParamByName('FLG_CT_CONFIRMED').AsInteger:=1;
           Query.ParamByName('SUMA_CT').AsCurrency:=ceSUMA_CT.EditValue;
           Query.ParamByName('DATA_CT').AsDateTime:=NOW;
           Query.ParamByName('ID').AsInteger:=fMasterDataSet.FieldByName('ID').AsInteger;
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

procedure TfrmMoneyAcceptDlg.BindingDataSource;
begin
     inherited;

     edUSER_DT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edDT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edUSER_CT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edCT_NAME.DataBinding.DataSource:=fMasterDataSource;
     ceSUMA_DT.DataBinding.DataSource:=fMasterDataSource;
     edCURRENCY_DT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edCURRENCY_CT_NAME.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_ACNT_DT.DataBinding.DataSource:=fMasterDataSource;
     mmCOMMENT.DataBinding.DataSource:=fMasterDataSource;

     frameMoneyCounter.OnTotalSumChanged:=WhenCalculatorSumaChanged;
end;

function TfrmMoneyAcceptDlg.IsFormDataPosted: Boolean;
var S:String;
begin
     Result:=False;
     if CheckParams then
     begin
          if (ceSUMA_CT.EditValue=fMasterDataSet.FieldByName('SUMA_DT').AsCurrency) then
          begin
               S:=Format('Вы хотите принять сумму в %f %s от %s на фирму %s?',[Currency(ceSUMA_CT.EditValue),fMasterDataSet.FieldByName('CURRENCY_DT_NAME').asString,fMasterDataSet.FieldByName('USER_DT_NAME').asString,fMasterDataSet.FieldByName('CT_NAME').asString]);

               if ShowAskDialog('Принять деньги',S+#13#10+#13#10+'Для продолжения операции понадобится пароль для '+fMasterDataSet.FieldByName('USER_CT_NAME').asString)=mrYes then
               begin
                    if CheckTargetCredentials(fMasterDataSet.FieldByName('USER_CT').asInteger) then
                    begin
                         if DoTransferAcceptDB then Result:=True;
                    end
                    else ShowErrorDialog('Неправильный пароль','Пароль неверен!');
               end;
          end
          else ShowErrorDialog('Неправильнная сумма','Отправленная и принятая сумма несовподают!');
     end;
end;

procedure TfrmMoneyAcceptDlg.Prepare;
begin

end;

procedure TfrmMoneyAcceptDlg.WhenCalculatorSumaChanged(Sender: TObject);
begin
     ceSUMA_CT.EditValue := frameMoneyCounter.TotalSum;
end;

end.
