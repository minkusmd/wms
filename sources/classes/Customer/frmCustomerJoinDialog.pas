unit frmCustomerJoinDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, Buttons, StdCtrls, DB, MemDS, DBAccess, IBC, dxGDIPlusClasses, cxStyles,
  cxVGrid, cxDBVGrid, cxInplaceContainer, dxScrollbarAnnotations, Vcl.Menus, cxButtons,
  cxFilter;

type
  TfrmCustomerJoinDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    sbSelectSource: TSpeedButton;
    Label1: TLabel;
    sbSelectTarget: TSpeedButton;
    IBCDataSourceSource: TIBCDataSource;
    IBCQuerySource: TIBCQuery;
    IBCQueryTarget: TIBCQuery;
    IBCDataSourceTarget: TIBCDataSource;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow6: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow8: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow9: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow10: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow11: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow12: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow13: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow14: TcxDBEditorRow;
    cxDBVerticalGrid2: TcxDBVerticalGrid;
    cxDBEditorRow1: TcxDBEditorRow;
    cxDBEditorRow2: TcxDBEditorRow;
    cxDBEditorRow3: TcxDBEditorRow;
    cxDBEditorRow5: TcxDBEditorRow;
    cxDBEditorRow6: TcxDBEditorRow;
    cxDBEditorRow7: TcxDBEditorRow;
    cxDBEditorRow8: TcxDBEditorRow;
    cxDBEditorRow9: TcxDBEditorRow;
    cxDBEditorRow10: TcxDBEditorRow;
    cxDBEditorRow11: TcxDBEditorRow;
    cxDBEditorRow12: TcxDBEditorRow;
    cxDBEditorRow13: TcxDBEditorRow;
    cxDBEditorRow14: TcxDBEditorRow;
    cbShowCreatedNew: TCheckBox;
    cbUpdateName: TCheckBox;
    cbUpdatePhone1: TCheckBox;
    cbUpdatePhone2: TCheckBox;
    cbUpdateEMail: TCheckBox;
    cbUpdateMobile: TCheckBox;
    cbUpdateCity: TCheckBox;
    cbUpdateAddress: TCheckBox;
    cbUpdateIDEN: TCheckBox;
    cbUpdateAddress2: TCheckBox;
    cbUpdateVAT: TCheckBox;
    SpeedButton1: TSpeedButton;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    teSourceID: TcxTextEdit;
    teDestID: TcxTextEdit;
    procedure sbSelectSourceClick(Sender: TObject);
    procedure sbSelectTargetClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure teDestIDExit(Sender: TObject);
    procedure teSourceIDExit(Sender: TObject);
  private

    fSourceCustomerID:integer;
    fTargetCustomerID:integer;

    procedure SelectSource;
    procedure SelectTarget;
    procedure ChangeTargets;
    procedure AnalyzeFields;

    function DoMergeCustomers:Boolean;
    function GetUpdateFlags:integer;
    procedure SetSourceCustomerID(CustomerID: Integer);
    procedure SetTargetCustomerID(CustomerID: Integer);
    procedure OpenDataSet(fDataSet: TIBCQuery; Value: Integer);

  protected

    procedure Prepare;override;
  public

    function ShowTargetCustomer:Boolean;
    property TargetCustomerID:integer read fTargetCustomerID;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, frmCustomersDlg, SWNSecurity, SWNUtils, SWNCustomersTypesUnit,
  SWNDBErrors;

{$R *.dfm}

const
     FLG_UPDATE_NAME      = $01;
     FLG_UPDATE_PHONE1    = $02;
     FLG_UPDATE_PHONE2    = $04;
     FLG_UPDATE_MOBILE    = $08;
     FLG_UPDATE_EMAIL     = $10;
     FLG_UPDATE_CITY      = $20;
     FLG_UPDATE_ADDRESS   = $40;
     FLG_UPDATE_IDEN      = $80;
     FLG_UPDATE_VAT       = $100;
     FLG_UPDATE_ADDRESS2  = $200;

procedure TfrmCustomerJoinDlg.AnalyzeFields;
begin
     if IBCQuerySource.Active and IBCQueryTarget.Active then
     begin
          cbUpdatePhone1.Checked:=(IBCQueryTarget.FieldByName('TELEFON1').IsNull or (IBCQueryTarget.FieldByName('TELEFON1').AsString='')) and Not IBCQuerySource.FieldByName('TELEFON1').IsNull;

          cbUpdateMobile.Checked:=(IBCQueryTarget.FieldByName('MOBILE').IsNull or (IBCQueryTarget.FieldByName('MOBILE').AsString='')) and Not IBCQuerySource.FieldByName('MOBILE').IsNull;
          cbUpdateAddress.Checked:=(IBCQueryTarget.FieldByName('ADDRESS').IsNull or (IBCQueryTarget.FieldByName('ADDRESS').AsString='')) and Not IBCQuerySource.FieldByName('ADDRESS').IsNull;
          cbUpdateIDEN.Checked:=(IBCQueryTarget.FieldByName('IDEN_NUMBER').IsNull or (IBCQueryTarget.FieldByName('IDEN_NUMBER').AsString='')) and Not IBCQuerySource.FieldByName('IDEN_NUMBER').IsNull;
          cbUpdateVAT.Checked:=(IBCQueryTarget.FieldByName('VAT_NUMBER').IsNull or (IBCQueryTarget.FieldByName('VAT_NUMBER').AsString='')) and Not IBCQuerySource.FieldByName('VAT_NUMBER').IsNull;
          cbUpdateAddress2.Checked:=(IBCQueryTarget.FieldByName('ADDRESS2').IsNull or (IBCQueryTarget.FieldByName('ADDRESS2').AsString='')) and Not IBCQuerySource.FieldByName('ADDRESS2').IsNull;
     end;
end;

procedure TfrmCustomerJoinDlg.btnOkClick(Sender: TObject);
begin
     if (fSourceCustomerID=-1) or (fTargetCustomerID=-1) then ShowErrorDialog('Eroare','Selectati contraagentii!')
     else
     if DoMergeCustomers then
     begin
          ShowInfoDialog('Unificare a 2 contraagenti','Unificarea contraagentilor este gata.');
          ModalResult:=mrOk;
     end
end;

procedure TfrmCustomerJoinDlg.ChangeTargets;
var n:integer;
begin
     n:=fSourceCustomerID;
     fSourceCustomerID:=fTargetCustomerID;
     teSourceID.Text := fTargetCustomerID.ToString;
     fTargetCustomerID:=n;
     teDestID.Text := n.ToString;
     IBCQuerySource.Close;
     IBCQueryTarget.Close;

     IBCQuerySource.ParamByName('id').AsInteger:=fSourceCustomerID;
     IBCQuerySource.Open;

     IBCQueryTarget.ParamByName('id').AsInteger:=fTargetCustomerID;
     IBCQueryTarget.Open;

     AnalyzeFields;
end;

function TfrmCustomerJoinDlg.DoMergeCustomers: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_MERGE_CUSTOMERS(:oldID,:newID,:updateFlags)';
        Query.ParamByName('oldID').AsInteger:=fSourceCustomerID;
        Query.ParamByName('newID').AsInteger:=fTargetCustomerID;
        Query.ParamByName('updateFlags').AsInteger:=GetUpdateFlags;
        try
           Query.Transaction.StartTransaction;
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                if Query.Transaction.Active then Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        query.Free;
     end;
end;

function TfrmCustomerJoinDlg.GetUpdateFlags: integer;
begin
     Result:=0;
     if cbUpdateName.Checked then Result:=Result or FLG_UPDATE_NAME;
     if cbUpdatePhone1.Checked then Result:=Result or FLG_UPDATE_PHONE1;
     if cbUpdatePhone2.Checked then Result:=Result or FLG_UPDATE_PHONE2;
     if cbUpdateMobile.Checked then Result:=Result or FLG_UPDATE_MOBILE;
     if cbUpdateEMail.Checked then Result:=Result or FLG_UPDATE_EMAIL;
     if cbUpdateCity.Checked then Result:=Result or FLG_UPDATE_CITY;
     if cbUpdateAddress.Checked then Result:=Result or FLG_UPDATE_ADDRESS;
     if cbUpdateIDEN.Checked then Result:=Result or FLG_UPDATE_IDEN;
     if cbUpdateVAT.Checked then Result:=Result or FLG_UPDATE_VAT;
     if cbUpdateAddress2.Checked then Result:=Result or FLG_UPDATE_ADDRESS2;
end;

procedure TfrmCustomerJoinDlg.Prepare;
begin
     fSourceCustomerID:=-1;
     fTargetCustomerID:=-1;
end;

procedure TfrmCustomerJoinDlg.sbSelectSourceClick(Sender: TObject);
begin
     SelectSource;
end;

procedure TfrmCustomerJoinDlg.sbSelectTargetClick(Sender: TObject);
begin
     SelectTarget;
end;

procedure TfrmCustomerJoinDlg.SelectSource;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if Not SWNSecurityManager.LoggedUser.IsInAdminGroup then dialog.CustomFilter:=[cfCustomers];
        if dialog.SelectCustomer(fSourceCustomerID,false,0,'Selectati contraagentul sursa') then
           SetSourceCustomerID(dialog.CustomerID);
     finally
        dialog.Free;
     end;
end;

procedure TfrmCustomerJoinDlg.SelectTarget;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if Not SWNSecurityManager.LoggedUser.IsInAdminGroup then dialog.CustomFilter:=[cfCustomers];
        if dialog.SelectCustomer(fTargetCustomerID,false,0,'Selectati contraagentul final') then
        begin
             fTargetCustomerID:=dialog.CustomerID;
             OpenDataSet(IBCQueryTarget, fTargetCustomerID);
             AnalyzeFields;
        end;
     finally
        dialog.Free;
     end;
end;

function TfrmCustomerJoinDlg.ShowTargetCustomer: Boolean;
begin
     Result:=cbShowCreatedNew.Checked;
end;

procedure TfrmCustomerJoinDlg.OpenDataSet(fDataSet: TIBCQuery; Value: Integer);
begin
  fDataSet.Close;
  fDataSet.ParamByName('id').AsInteger := Value;
  fDataSet.Open;
end;

procedure TfrmCustomerJoinDlg.SetSourceCustomerID(CustomerID: Integer);
begin
    fSourceCustomerID := CustomerID;
    OpenDataSet(IBCQuerySource, fSourceCustomerID);
    AnalyzeFields;
end;

procedure TfrmCustomerJoinDlg.SetTargetCustomerID(CustomerID: Integer);
begin
    fTargetCustomerID := CustomerID;
    OpenDataSet(IBCQueryTarget, fTargetCustomerID);
    AnalyzeFields;
end;

procedure TfrmCustomerJoinDlg.SpeedButton1Click(Sender: TObject);
begin
     ChangeTargets;
end;

procedure TfrmCustomerJoinDlg.teDestIDExit(Sender: TObject);
begin
  if teDestID.Text<>'' then
  begin
    SetTargetCustomerID(StrToInt(teDestID.Text));
    AnalyzeFields;
  end;
end;

procedure TfrmCustomerJoinDlg.teSourceIDExit(Sender: TObject);
begin
  if teSourceID.Text<>'' then
  begin
    SetSourceCustomerID(StrToInt(teSourceID.Text));
    AnalyzeFields;
  end;
end;

end.

