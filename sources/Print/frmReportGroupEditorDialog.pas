unit frmReportGroupEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls,
  cxTextEdit, cxDBEdit, ExtCtrls, DialogTitle;

type
  TfrmReportGroupEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    edCODE: TcxDBTextEdit;
  private
    { Private declarations }

    fCreateNewGroup: Boolean;
    procedure SetCreateNewGroup(const Value: Boolean);
    function CheckParams:Boolean;


  protected
    { protected declarations }

    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }

    property CreateNewGroup:Boolean read FCreateNewGroup write SetCreateNewGroup;
  end;


implementation
Uses DB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmReportGroupEditorDlg }

function TfrmReportGroupEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString='') then AddErrorToStr(ErrorStr,'Название группы!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmReportGroupEditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     edCODE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmReportGroupEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmReportGroupEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewGroup then
        begin
             dtDialogTitle.Text:='Создание новой группы';
             fMasterDataSet.Insert;
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

procedure TfrmReportGroupEditorDlg.SetCreateNewGroup(const Value: Boolean);
begin
     fCreateNewGroup := Value;
end;

procedure TfrmReportGroupEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
