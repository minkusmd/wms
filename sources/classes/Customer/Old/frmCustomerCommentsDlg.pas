unit frmCustomerCommentsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, SWNBaseUnit,
  Dialogs, DialogTitle, Menus, DBAccess, IBC, MemDS, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit, StdCtrls, ExtCtrls,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmCustomerCommentsDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryComments: TIBCQuery;
    IBCDataSourceComments: TIBCDataSource;
    pnClient: TPanel;
    mmCOMMENTS: TcxDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    edDISPLAYNAME: TcxDBTextEdit;
  private
    { Private declarations }
  protected
    { Protcted declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmCustomerCommentsDialog }

procedure TfrmCustomerCommentsDialog.InitValues;
begin
     inherited;

     IBCQueryComments.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryComments.MasterSource:=fMasterDataSource;
     edDISPLAYNAME.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmCustomerCommentsDialog.IsFormDataPosted: Boolean;
begin
     IBCQueryComments.Post;
     IBCQueryComments.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmCustomerCommentsDialog.Prepare;
begin
     IBCQueryComments.Active:=True;
     IBCQueryComments.UpdateTransaction.StartTransaction;
     try
        if IBCQueryComments.Eof then
        begin
             dtDialogTitle.Text:='Creare comentariu nou';
             IBCQueryComments.Append;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare comentariu';
             IBCQueryComments.Edit;
        end;
     except
        IBCQueryComments.Cancel;
        IBCQueryComments.UpdateTransaction.Rollback;
        raise;
     end;

end;

procedure TfrmCustomerCommentsDialog.WhenCancelForm;
begin
     IBCQueryComments.Cancel;
     IBCQueryComments.UpdateTransaction.Rollback;
end;


end.
