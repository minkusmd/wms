unit frmKitTemplateEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls, DB, cxDBEdit,
  ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxCheckBox,
  cxMemo, cxTextEdit, dxUIAClasses;

type
  TfrmKitTemplateEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnKit: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxDBTextEdit;
    cxLabel2: TLabel;
    edDESCRIPTION: TcxDBMemo;
    cbFLG_PUBLIC: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;



implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmKitTemplateEditorDlg }

function TfrmKitTemplateEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if (fMasterDataSet.FieldByName('TITLE').IsNull) or (fMasterDataSet.FieldByName('TITLE').AsWideString='') then AddErrorToStr(ErrorStr,'Denumirea sablonului!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmKitTemplateEditorDlg.BindingDataSource;
begin
     inherited;
     FCreateNewRecord := False;
     edTitle.DataBinding.DataSource:=fMasterDataSource;
     edDESCRIPTION.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_PUBLIC.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmKitTemplateEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmKitTemplateEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Creeaza sablon nou';

             fMasterDataSet.Append;
             fMasterDataSet.FieldByName('FLG_PUBLIC').AsInteger:=0;
             fMasterDataSet.FieldByName('USERID').AsInteger:=UserID;
        end
        else
        begin
             dtDialogTitle.Text:='Modifica sablonul';
             fMasterDataSet.Edit;
        end;
     except on E:Exception do
        begin
             if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmKitTemplateEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmKitTemplateEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
