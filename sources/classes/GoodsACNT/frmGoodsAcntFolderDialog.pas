unit frmGoodsAcntFolderDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus, StdCtrls, cxButtons,
  cxDBEdit, ExtCtrls, DialogTitle,
  Data.DB,
  IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit;

type
  TfrmGoodsAcntFolderDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edNAMEACNT: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    FParentID: integer;
    FCreateNewFolder: Boolean;
    procedure SetParentID(const Value: integer);
    procedure SetCreateNewFolder(const Value: Boolean);
    function CheckParams:Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property ParentID:integer read FParentID write SetParentID;
    property CreateNewFolder:Boolean read FCreateNewFolder write SetCreateNewFolder;
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsAcntFolderDlg }

function TfrmGoodsAcntFolderDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     with fMasterDataSet do
     begin
          if FieldByName('NAMEACNT').IsNull or (FieldByName('NAMEACNT').AsString='') then AddErrorToStr(ErrorStr,'Название папки!');
     end;
     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsAcntFolderDlg.BindingDataSource;
begin
     inherited;
     FParentID := 0;
     FCreateNewFolder := False;
     edNAMEACNT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsAcntFolderDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmGoodsAcntFolderDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewFolder then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('PARENTID').AsInteger:=FParentID;
             fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=1;
             fMasterDataSet.FieldByName('PERCENT_BOUNDS').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;
        end;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmGoodsAcntFolderDlg.SetCreateNewFolder(const Value: Boolean);
begin
     FCreateNewFolder := Value;
end;

procedure TfrmGoodsAcntFolderDlg.SetParentID(const Value: integer);
begin
     FParentID := Value;
end;

procedure TfrmGoodsAcntFolderDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
