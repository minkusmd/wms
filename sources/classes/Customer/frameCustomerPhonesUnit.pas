unit frameCustomerPhonesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxBar, DBAccess, IBC,
  MemDS, cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TframeCustomerPhones = class(TFrame)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNewCustomerPhones: TdxBarButton;
    bbEditCustomerPhones: TdxBarButton;
    bbDeleteCustomerPhones: TdxBarButton;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1_TIP_TELEFON: TcxGridDBColumn;
    cxGridDBTableView1_NUMAR_TELEFON: TcxGridDBColumn;
    cxGridDBTableView1_NOTE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    IBCQueryCustomerPhones: TIBCQuery;
    IBCDataSourceCustomerPhones: TIBCDataSource;
    cxGridDBTableView1_FLG_SMS: TcxGridDBColumn;
    cxGridDBTableView1_ID: TcxGridDBColumn;
    procedure bbNewCustomerPhonesClick(Sender: TObject);
    procedure bbEditCustomerPhonesClick(Sender: TObject);
    procedure bbDeleteCustomerPhonesClick(Sender: TObject);
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    FConnection: TIBCConnection;
    FCustomerID: Integer;
    FSelectTransaction: TIBCTransaction;
    FUpdateTransaction: TIBCTransaction;
    procedure SetConnection(const Value: TIBCConnection);
    procedure SetCustomerID(const Value: Integer);
    procedure SetSelectTransaction(const Value: TIBCTransaction);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);

    { Private declarations }
  protected
    procedure ShowCustomerPhonesEditorDialog(IsNewRecord: Boolean);
  public
    procedure OpenDataSet;
    property Connection: TIBCConnection read FConnection write SetConnection;
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property SelectTransaction: TIBCTransaction read FSelectTransaction write
        SetSelectTransaction;
    property UpdateTransaction: TIBCTransaction read FUpdateTransaction write SetUpdateTransaction;
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions, frmCustomerPhonesEditorDlgUnit, SWNUtils;

{$R *.dfm}

{ TframeCustomerPhones }

procedure TframeCustomerPhones.bbDeleteCustomerPhonesClick(Sender: TObject);
begin
  if ShowAskDialog('Telefoane', 'Stergeti inregistrarea ?')=mrYes then
  begin

    if not IBCQueryCustomerPhones.UpdateTransaction.Active then
      IBCQueryCustomerPhones.UpdateTransaction.StartTransaction;
    try
      IBCQueryCustomerPhones.Delete;
      IBCQueryCustomerPhones.UpdateTransaction.Commit;
    except
    begin
      IBCQueryCustomerPhones.UpdateTransaction.Rollback;
      raise;
    end;

    end;
  end;
end;

procedure TframeCustomerPhones.bbEditCustomerPhonesClick(Sender: TObject);
begin
  ShowCustomerPhonesEditorDialog(False);
end;

procedure TframeCustomerPhones.bbNewCustomerPhonesClick(Sender: TObject);
begin
  ShowCustomerPhonesEditorDialog(True);
end;

procedure TframeCustomerPhones.cxGridDBTableView1KeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  if (((Key=ord('c')) or (Key=ord('C'))) and (ssCtrl in Shift)) then
  begin
    CopyCellToClipboard(cxgrid1);
    Key := 0;
  end;
end;

procedure TframeCustomerPhones.OpenDataSet;
begin
  IBCQueryCustomerPhones.Close;
  IBCQueryCustomerPhones.Connection := FConnection;
  IBCQueryCustomerPhones.UpdateTransaction := FUpdateTransaction;
  IBCQueryCustomerPhones.Transaction := FSelectTransaction;

  IBCQueryCustomerPhones.ParamByName('CUSTOMERID').AsInteger := FCustomerID;
  IBCQueryCustomerPhones.Open;
end;

procedure TframeCustomerPhones.SetConnection(const Value: TIBCConnection);
begin
  FConnection := Value;
end;

procedure TframeCustomerPhones.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TframeCustomerPhones.SetSelectTransaction(const Value:
    TIBCTransaction);
begin
  FSelectTransaction := Value;
end;

procedure TframeCustomerPhones.SetUpdateTransaction(const Value: TIBCTransaction);
begin
  FUpdateTransaction := Value;
end;

procedure TframeCustomerPhones.ShowCustomerPhonesEditorDialog(IsNewRecord:
    Boolean);
var
  dialog: TfrmCustomerPhonesEditorDialog;
  query: TIBCQuery;
begin
  dialog := TfrmCustomerPhonesEditorDialog.Create(Self, IBCQueryCustomerPhones, IBCDataSourceCustomerPhones);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.CustomerID := FCustomerID;
    if dialog.ShowModal=mrOK then
    begin
       if (dialog.FlgSMS = 1) then
       begin
         query := TIBCQuery.Create(Self);
         try
            query.AutoCommit := False;
            query.Transaction := IBCQueryCustomerPhones.UpdateTransaction;

            if not query.Transaction.Active then
               query.Transaction.StartTransaction;

            query.SQL.Text := 'execute procedure update_sms_phones(:phoneid)';
            query.ParamByName('phoneid').AsInteger := IBCQueryCustomerPhones.FieldByName('phoneid').AsInteger;
            query.ExecSQL;
            query.Transaction.Commit;
            IBCQueryCustomerPhones.Refresh;
         finally
            query.Free;
         end;
       end;
    end;
  finally
    dialog.Free;
  end;
end;

end.
