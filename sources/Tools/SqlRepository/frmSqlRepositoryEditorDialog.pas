unit frmSqlRepositoryEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxMemo, cxDBEdit,
  cxTextEdit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle;

type
  TfrmSqlRepositoryEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    mmSQL_TEXT: TcxDBMemo;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function VerifyInput:Boolean;
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

{$R *.dfm}

uses DataModuleAdditions, DB, SWNUtils, SWNConst;

{ TfrmSqlRepositoryEditorDlg }

procedure TfrmSqlRepositoryEditorDlg.BindingDataSource;
begin
     FCreateNewRecord := False;

     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     mmSQL_TEXT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmSqlRepositoryEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if VerifyInput then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmSqlRepositoryEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание нового SQL-я';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('SQL_TEXT').AsString:='SELECT * FROM <table>';
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
        end;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSqlRepositoryEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

function TfrmSqlRepositoryEditorDlg.VerifyInput: Boolean;
var Errors:String;
begin
     Result:=False;
     if (fMasterDataSet.FieldByName('TITLE').IsNull) or (fMasterDataSet.FieldByName('TITLE').AsString='')
       then AddErrorToStr(Errors,'Название!');
     if (fMasterDataSet.FieldByName('SQL_TEXT').IsNull) or (fMasterDataSet.FieldByName('SQL_TEXT').AsString='')
       then AddErrorToStr(Errors,'SQL текст!');

     if (Errors='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmSqlRepositoryEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
