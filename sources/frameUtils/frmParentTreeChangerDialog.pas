unit frmParentTreeChangerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, ComCtrls, dxtree, dxdbtree, DB,
  DBAccess, IBC, MemDS, cxGraphics, cxLookAndFeels;

type
  TfrmParentTreeChangerDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    dxDBTreeView1: TdxDBTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParentTreeChangerDlg: TfrmParentTreeChangerDlg;

implementation

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

end.
