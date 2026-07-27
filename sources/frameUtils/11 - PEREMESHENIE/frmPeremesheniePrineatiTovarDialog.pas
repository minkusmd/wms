unit frmPeremesheniePrineatiTovarDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, StdCtrls, ExtCtrls, DialogTitle, cxMemo, cxMaskEdit, DB, DBAccess, IBC, MemDS, Vcl.Menus, cxButtons;

type
  TfrmPeremesheniePrineatiTovarDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edDT_NAME: TcxDBTextEdit;
    Label2: TLabel;
    edCT_NAME: TcxDBTextEdit;
    Label3: TLabel;
    edDTDEP_NAME: TcxDBTextEdit;
    edCTDEP_NAME: TcxDBTextEdit;
    cxLabel1: TLabel;
    edBOX_COUNT: TcxDBMaskEdit;
    cxLabel2: TLabel;
    mmCOMMENTS: TcxDBMemo;
    Label4: TLabel;
    edCurrUser: TcxTextEdit;
    IBCQueryDocAddons: TIBCQuery;
    IBCDataSourceDocAddons: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }
  end;



implementation

uses DataModuleDB, DataModuleAdditions;

{$R *.dfm}

{ TfrmPeremesheniePrineatiTovarDlg }

procedure TfrmPeremesheniePrineatiTovarDlg.BindingDataSource;
begin
     inherited;

     IBCQueryDocAddons.Transaction:=fMasterDataSet.Transaction;
     IBCQueryDocAddons.MasterSource:=fMasterDataSource;

     edDT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edCT_NAME.DataBinding.DataSource:=fMasterDataSource;
     edDTDEP_NAME.DataBinding.DataSource:=fMasterDataSource;
     edCTDEP_NAME.DataBinding.DataSource:=fMasterDataSource;


end;

procedure TfrmPeremesheniePrineatiTovarDlg.Prepare;
begin
     edCurrUser.Text:=dmDB.CurrentUserFullName;
     IBCQueryDocAddons.Active:=True;
end;

end.
