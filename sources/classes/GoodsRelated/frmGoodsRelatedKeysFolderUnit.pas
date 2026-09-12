unit frmGoodsRelatedKeysFolderUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus, StdCtrls, cxButtons,
  cxDBEdit, ExtCtrls, DialogTitle,
  Data.DB,
  IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit;

type
  TfrmGoodsRelatedKeysFolderDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    edKey: TcxDBTextEdit;
    Label1: TLabel;
  private
    { Private declarations }
    FParentKey: string;
    FCreateNewFolder: Boolean;
    procedure SetParentKey(const Value: string);
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
    property ParentKey: string read FParentKey write SetParentKey;
    property CreateNewFolder:Boolean read FCreateNewFolder write SetCreateNewFolder;
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsAcntFolderDlg }

function TfrmGoodsRelatedKeysFolderDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     with fMasterDataSet do
     begin
          if FieldByName('TITLE').IsNull or (FieldByName('TITLE').AsString='') then AddErrorToStr(ErrorStr,'Denumirea folderului!');
     end;
     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsRelatedKeysFolderDlg.BindingDataSource;
begin
     inherited;
     FParentKey := '';
     FCreateNewFolder := False;
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     edKey.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsRelatedKeysFolderDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmGoodsRelatedKeysFolderDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewFolder then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('PARENT_KEY').AsString := FParentKey;
             fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=1;
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

procedure TfrmGoodsRelatedKeysFolderDlg.SetCreateNewFolder(const Value: Boolean);
begin
     FCreateNewFolder := Value;
end;

procedure TfrmGoodsRelatedKeysFolderDlg.SetParentKey(const Value: string);
begin
     FParentKey := Value;
end;

procedure TfrmGoodsRelatedKeysFolderDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
