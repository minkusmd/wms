unit frmFisaTehnicaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxVGrid, cxDBVGrid, DB, DBAccess, IBC, MemDS, cxInplaceContainer, cxClasses, dxBar, ExtCtrls, StdCtrls,
  cxContainer, cxTextEdit, cxMemo, cxDBEdit, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmFisaTehnicaDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    IBCQueryFisa: TIBCQuery;
    IBCDataSourceFisa: TIBCDataSource;
    cxDBVerticalGrid1CategoryRow1: TcxCategoryRow;
    IBCTrUpdate: TIBCTransaction;
    pnGoods: TPanel;
    Label1: TLabel;
    mmInfo: TcxDBMemo;
    cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow3: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow4: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow5: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow6: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow7: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow8: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow9: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow10: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow11: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow12: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow13: TcxDBMultiEditorRow;
    cxDBVerticalGrid1CategoryRow2: TcxCategoryRow;
    cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGrid1CategoryRow3: TcxCategoryRow;
    cxDBVerticalGrid1DBEditorRow6: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow8: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow9: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow10: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow11: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow12: TcxDBEditorRow;
    btnOk: TcxButton;
    btnCancel: TcxButton;
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

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmFisaTehnicaDlg }

procedure TfrmFisaTehnicaDlg.BindingDataSource;
begin
     mmInfo.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryFisa.ParamByName('GoodsID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
end;

function TfrmFisaTehnicaDlg.IsFormDataPosted: Boolean;
begin
     IBCQueryFisa.Post;
     IBCQueryFisa.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmFisaTehnicaDlg.Prepare;
begin
     IBCTrUpdate.StartTransaction;
     try
        IBCQueryFisa.Active:=True;
        if IBCQueryFisa.Eof then
        begin
             IBCQueryFisa.Insert;
             IBCQueryFisa.FieldByName('GOODSID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        end
        else IBCQueryFisa.Edit;

     except
        IBCTrUpdate.Rollback;
        raise;
     end;
end;

procedure TfrmFisaTehnicaDlg.WhenCancelForm;
begin
     IBCQueryFisa.Cancel;
     IBCQueryFisa.UpdateTransaction.Rollback;
end;

end.
