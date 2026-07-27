unit frm82DocumentEditUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxCalendar, cxDBEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.StdCtrls, DialogTitle,
  SWNBaseUnit, Vcl.ExtCtrls;

type
  Tfrm82DocumentEditDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    Button1: TButton;
    Button2: TButton;
    IBCQueryTransport: TIBCQuery;
    IBCDataSourceTransport: TIBCDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    beCustomer: TcxButtonEdit;
    deData: TcxDBDateEdit;
    lcbTransport: TcxDBLookupComboBox;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    procedure SelectCT;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    IsNewRecord: Boolean;
    ReadOnly: Boolean;

    { Public declarations }
  end;

var
  frm82DocumentEditDlg: Tfrm82DocumentEditDlg;

implementation

uses
  DataModuleAdditions, frmCustomersDlg;

{$R *.dfm}

{ Tfrm82DocumentEditDlg }

procedure Tfrm82DocumentEditDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure Tfrm82DocumentEditDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CURIERID').asInteger, False, 0, 'Selecteaza curierul') then
    begin
      fMasterDataSet.FieldByName('CURIERID').asInteger := dialog.CustomerID;
      beCustomer.Text := dialog.CustomerTitle;
      fMasterDataSet.FieldByName('CURIER_NAME').AsString := dialog.CustomerTitle;
      beCustomer.Tag := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm82DocumentEditDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in (dsEditModes) then
    fMasterDataSet.Cancel;
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure Tfrm82DocumentEditDlg.BindingDataSource;
begin
  inherited;
  lcbTransport.DataBinding.DataSource := fMasterDataSource;
  deData.DataBinding.DataSource := fMasterDataSource;

end;

function Tfrm82DocumentEditDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if fMasterDataSet.State in (dsEditModes) then
    fMasterDataSet.Post;
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Commit;

end;

procedure Tfrm82DocumentEditDlg.Prepare;
begin
  IBCQueryTransport.Open;
  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('DATA').AsDateTime := now;
    beCustomer.Text := '';
    beCustomer.Tag := 0;
  end
  else
  begin
    fMasterDataSet.Edit;
    beCustomer.Text := fMasterDataSet.FieldByName('CURIER_NAME').AsString;
    beCustomer.Tag := fMasterDataSet.FieldByName('CURIERID').AsInteger;
  end;
end;

end.

