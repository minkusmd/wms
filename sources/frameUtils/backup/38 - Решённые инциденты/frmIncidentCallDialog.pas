unit frmIncidentCallDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, IBC, Dialogs, DialogTitle,
  ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxMemo, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxGraphics, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, DBAccess, MemDS, ComCtrls, Buttons,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxLabel, cxCurrencyEdit, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator;

type
  TfrmIncidentCallDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    edSN: TcxDBTextEdit;
    edGOODS_MODEL: TcxDBTextEdit;
    Label1: TLabel;
    edCUSTOMER_FULLNAME: TcxDBTextEdit;
    mmCOMMENTS: TcxDBMemo;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dePICKUP_DATE: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    lcbCALL_RESULT: TcxDBLookupComboBox;
    IBCQueryResults: TIBCQuery;
    IBCDataSourceResults: TIBCDataSource;
    cmbPhones: TComboBox;
    Label9: TLabel;
    Label13: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    Label14: TLabel;
    sbMoreDetails: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_K_UM: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridComments: TcxGrid;
    cxGridCommentsDB: TcxGridDBTableView;
    cxGridCommentsLevel: TcxGridLevel;
    cxGridCommentsDB_1: TcxGridDBColumn;
    cxGridCommentsDB_2: TcxGridDBColumn;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    IBCQueryComments: TIBCQuery;
    IBCDataSourceComments: TIBCDataSource;
    procedure sbMoreDetailsClick(Sender: TObject);
  private
    { Private declarations }
    fIncidentDataSet, fCallDataSet: TIBCQuery;
    FCreateNewCall: Boolean;
    fShowMoreInfo: Boolean;
    procedure SetCreateNewCall(const Value: Boolean);
    function CheckParams: Boolean;
    procedure PrepareCustomerPhoneList(const CustomerID: integer);
    procedure AddPhone(const Phone: string; const ImageIndex: integer);
    procedure ProcessShowMoreInfo;
    procedure ShowAdditionalInfo;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const IncidentDataSet, CallDataSet: TIBCQuery; const IncidentDataSource,
      CallDataSource: TIBCDataSource); reintroduce;
    property CreateNewCall: Boolean read FCreateNewCall write SetCreateNewCall;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmIncidentCallDlg }

procedure TfrmIncidentCallDlg.AddPhone(const Phone: string; const ImageIndex: integer);
begin
  cmbPhones.Items.Add(Phone);
end;

function TfrmIncidentCallDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if cmbPhones.ItemIndex = -1 then
    AddErrorToStr(ErrorStr, 'Номер телефона!')
  else
    fCallDataSet.FieldByName('PHONE').AsString := cmbPhones.Text;

  if fCallDataSet.FieldByName('CALL_RESULT').IsNull then
    AddErrorToStr(ErrorStr, 'Результат звонка!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

constructor TfrmIncidentCallDlg.Create(const AOwner: TComponent; const IncidentDataSet, CallDataSet: TIBCQuery; const
  IncidentDataSource, CallDataSource: TIBCDataSource);
begin
  inherited Create(AOwner);

  FCreateNewCall := False;
  fShowMoreInfo := False;
  ClientWidth := 563;

  fIncidentDataSet := IncidentDataSet;
  fCallDataSet := CallDataSet;

  edTYPE_TITLE.DataBinding.DataSource := IncidentDataSource;
  edGOODS_NAME.DataBinding.DataSource := IncidentDataSource;
  edGOODS_MODEL.DataBinding.DataSource := IncidentDataSource;
  edSN.DataBinding.DataSource := IncidentDataSource;
  edCUSTOMER_FULLNAME.DataBinding.DataSource := IncidentDataSource;

  lcbCALL_RESULT.DataBinding.DataSource := CallDataSource;
  dePICKUP_DATE.DataBinding.DataSource := CallDataSource;
  mmCOMMENTS.DataBinding.DataSource := CallDataSource;
end;

function TfrmIncidentCallDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fCallDataSet.Post;
    fCallDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmIncidentCallDlg.Prepare;
begin
  fCallDataSet.UpdateTransaction.StartTransaction;
  try
    PrepareCustomerPhoneList(fIncidentDataSet.FieldByName('CUSTOMERID').AsInteger);

    if FCreateNewCall then
    begin
      dtDialogTitle.Text := 'Новый звонок контрагенту';

      fCallDataSet.Append;
      fCallDataSet.FieldByName('USERID').AsInteger := UserID;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';

      fCallDataSet.Edit;
    end;

    IBCQueryResults.Active := True;

  except
    fCallDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmIncidentCallDlg.PrepareCustomerPhoneList(const CustomerID: integer);
var
  Query: TIBCQuery;
begin
  cmbPhones.Items.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    cmbPhones.Items.Clear;

    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT TELEFON1,TELEFON2,MOBILE,FAX FROM TS_CUST_INFO WHERE CUSTOMERID=:CUSTOMERID';
    Query.ParamByName('CUSTOMERID').AsInteger := CustomerID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      if (not Query.Fields[0].IsNull) and (Query.Fields[0].AsString <> '') then
        AddPhone(Query.Fields[0].AsString, 47);
      if (not Query.Fields[1].IsNull) and (Query.Fields[1].AsString <> '') then
        AddPhone(Query.Fields[1].AsString, 47);
      if (not Query.Fields[2].IsNull) and (Query.Fields[2].AsString <> '') then
        AddPhone(Query.Fields[2].AsString, 48);
      if (not Query.Fields[3].IsNull) and (Query.Fields[3].AsString <> '') then
        AddPhone(Query.Fields[3].AsString, 49);
    end;
    Query.Close;
    if cmbPhones.Items.Count > 0 then
      cmbPhones.ItemIndex := 0;
  finally
    Query.Free;
    cmbPhones.Items.EndUpdate;
  end;
end;

procedure TfrmIncidentCallDlg.ProcessShowMoreInfo;
begin
  fShowMoreInfo := not fShowMoreInfo;
  if fShowMoreInfo then
  begin
    ClientWidth := 1115;
    Left := Screen.WorkAreaLeft + (Screen.WorkAreaWidth - Width) div 2;
    sbMoreDetails.Caption := '<';
    ShowAdditionalInfo;
  end
  else
  begin
    ClientWidth := 563;
    Left := Screen.WorkAreaLeft + (Screen.WorkAreaWidth - Width) div 2;
    sbMoreDetails.Caption := '>';
  end;
end;

procedure TfrmIncidentCallDlg.sbMoreDetailsClick(Sender: TObject);
begin
  ProcessShowMoreInfo;
end;

procedure TfrmIncidentCallDlg.SetCreateNewCall(const Value: Boolean);
begin
  FCreateNewCall := Value;
end;

procedure TfrmIncidentCallDlg.ShowAdditionalInfo;
begin
  if not IBCQueryJurnal.Active then
  begin
    IBCQueryJurnal.ParamByName('IID').AsInteger := fIncidentDataSet.FieldByName('IID').AsInteger;
    IBCQueryJurnal.Active := True;
    IBCQueryComments.ParamByName('IID').AsInteger := fIncidentDataSet.FieldByName('IID').AsInteger;
    IBCQueryComments.Active := True;
  end;
end;

procedure TfrmIncidentCallDlg.WhenCancelForm;
begin
  fCallDataSet.Cancel;
  fCallDataSet.UpdateTransaction.Rollback;
end;

end.

