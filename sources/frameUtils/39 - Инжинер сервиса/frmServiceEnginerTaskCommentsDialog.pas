unit frmServiceEnginerTaskCommentsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls, cxMemo,
  cxDBEdit, cxTextEdit, ExtCtrls, DialogTitle, DB, DBAccess, IBC, MemDS;

type
  TfrmServiceEnginerTaskCommentsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTASKTYPE_TITLE: TcxDBTextEdit;
    mmCOMMENTS: TcxDBMemo;
    Label2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryComm: TIBCQuery;
    IBCDataSourceComm: TIBCDataSource;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions;

{$R *.dfm}

{ TfrmServiceEnginerTaskCommentsDlg }

procedure TfrmServiceEnginerTaskCommentsDlg.BindingDataSource;
begin
     edTASKTYPE_TITLE.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryComm.MasterSource:=fMasterDataSource;
end;

function TfrmServiceEnginerTaskCommentsDlg.IsFormDataPosted: Boolean;
begin
     IBCQueryComm.Post;
     IBCQueryComm.UpdateTransaction.Commit;
end;

procedure TfrmServiceEnginerTaskCommentsDlg.Prepare;
begin
     IBCQueryComm.UpdateTransaction.StartTransaction;
     try
        IBCQueryComm.Active:=True;
        IBCQueryComm.Edit;
     except
        IBCQueryComm.Cancel;
        IBCQueryComm.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmServiceEnginerTaskCommentsDlg.WhenCancelForm;
begin
     IBCQueryComm.Cancel;
     IBCQueryComm.UpdateTransaction.Rollback;
end;

end.
