unit frmContentPackage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCalc, cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Menus, cxButtons,
  Data.DB, DBAccess, IBC, MemDS, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxMemo, cxCheckBox, RzPanel, RzDlgBtn,
  dxUIAClasses;

type
  TfrmContentPackageDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    Label1: TLabel;
    deDATA_END: TcxDBDateEdit;
    Label2: TLabel;
    cePrice: TcxDBCalcEdit;
    Label3: TLabel;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    lcbUser: TcxDBLookupComboBox;
    meComments: TcxDBMemo;
    RzDialogButtons1: TRzDialogButtons;
    cbNoSalary: TcxDBCheckBox;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

var
  frmContentPackageDlg: TfrmContentPackageDlg;

implementation

{$R *.dfm}

{ TfrmContentPackageDlg }

function TfrmContentPackageDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if (int(MasterDataSet.FieldByName('DATA_START').AsDateTime) > Int(MasterDataSet.FieldByName('DATA_END').AsDateTime)) then
    begin
      MasterDataSet.FieldByName('DATA_END').AsDateTime := Now;
    end;

    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;

    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  except on e: Exception do
    begin
       fMasterDataSet.UpdateTransaction.Rollback;
    end;
  end;
end;

procedure TfrmContentPackageDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  fMasterDataSet.Edit;

  deDATA_END.DataBinding.DataSource := fMasterDataSource;
  cePrice.DataBinding.DataSource := fMasterDataSource;
  meComments.DataBinding.DataSource := fMasterDataSource;
  cbNoSalary.DataBinding.DataSource := fMasterDataSource;

  IBCQueryUsers.Open;
  lcbUser.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmContentPackageDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditmodes then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;

end;

end.
