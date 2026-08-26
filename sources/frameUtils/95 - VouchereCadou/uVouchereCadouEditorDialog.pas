unit uVouchereCadouEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxLabel, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxCalc, cxCheckBox,
  Data.DB;

type
  TfrmVouchereCadouEditorDialog = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxLabel1: TcxLabel;
    deData1: TcxDBDateEdit;
    deData2: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    teCODE: TcxDBTextEdit;
    cbUsed: TcxDBCheckBox;
    cxLabel3: TcxLabel;
    ceAmount: TcxDBCalcEdit;
    teWebDocID: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    teRezervDocID: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    teBalanceDocID: TcxDBTextEdit;
    cxButton3: TcxButton;
    cbFLG_ACTIVE: TcxDBCheckBox;
    procedure cxButton3Click(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams: Boolean;

  protected
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function GenerateVoucherCode: string;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    { Public declarations }
  end;

var
  frmVouchereCadouEditorDialog: TfrmVouchereCadouEditorDialog;

implementation

uses
  md5hash, DataModuleDB, IBC, System.UITypes;

{$R *.dfm}

procedure TfrmVouchereCadouEditorDialog.BindingDataSource;
begin
  deData1.DataBinding.DataSource := fMasterDataSource;
  deData2.DataBinding.DataSource := fMasterDataSource;
  ceAmount.DataBinding.DataSource := fMasterDataSource;
  teCODE.DataBinding.DataSource := fMasterDataSource;
  cbUsed.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACTIVE.DataBinding.DataSource := fMasterDataSource;
  teBalanceDocID.DataBinding.DataSource := fMasterDataSource;
  teRezervDocID.DataBinding.DataSource := fMasterDataSource;
  teWebDocID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmVouchereCadouEditorDialog.CheckParams: Boolean;
var
  q: TIBCQuery;
  ErrorStr: string;  
begin
  Result := false;
  ErrorStr := '';
  
  q := TIBCQuery.Create(self);
  try
    q.sql.Text := 'select code from mk_vouchere_cadou where code = :code and flg_used=0 and flg_active = 1';
    q.ParamByName('code').AsString := teCODE.Text;
    q.Open;
    if q.RecordCount > 0 then
    begin
      ErrorStr := 'Exista asa cod! Introduceti alt cod!';  
      MessageDlg(ErrorStr, mtError, [mbOK], 0);
    end;
    
    result := not (q.RecordCount > 0);
  finally
    q.Free;
  end;
end;

procedure TfrmVouchereCadouEditorDialog.cxButton3Click(Sender: TObject);
//var
//  code: string;
begin
  fMasterDataSet.FieldByName('CODE').AsString := GenerateVoucherCode;
end;

function TfrmVouchereCadouEditorDialog.GenerateVoucherCode: string;
begin
  Result := md5hash.MD5DigestToStr(MD5String(fMasterDataSet.FieldByName('VOUCHERID').AsString + DateTimeToStr(now) +
    fMasterDataSet.FieldByName('Data2').AsString + dmdb.CurrentUserID.ToString));
end;                                                       

function TfrmVouchereCadouEditorDialog.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    if fMasterDataSet.UpdateTransaction.Active then
    begin
      try
        if fMasterDataSet.State in dsEditModes then
          fMasterDataSet.Post;
        if fMasterDataSet.UpdateTransaction.Active then
          fMasterDataSet.UpdateTransaction.Commit;

        Result := true;
      except
        on e: Exception do
        begin
          Result := false;
          if fMasterDataSet.State in dsEditModes then
            fMasterDataSet.Cancel;
          if fMasterDataSet.UpdateTransaction.Active then
            fMasterDataSet.UpdateTransaction.Rollback;

          raise;
        end;
      end;
    end;
  end;
end;

procedure TfrmVouchereCadouEditorDialog.Prepare;
begin
  if not fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  if FCreateNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('DATA1').AsDateTime := Date;
    fMasterDataSet.FieldByName('DATA2').AsDateTime := Date + 180;
    fMasterDataSet.FieldByName('FLG_USED').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
  end
  else
    fMasterDataSet.Edit;

end;

procedure TfrmVouchereCadouEditorDialog.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmVouchereCadouEditorDialog.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
    
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
