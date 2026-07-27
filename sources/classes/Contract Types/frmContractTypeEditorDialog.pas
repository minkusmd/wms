unit frmContractTypeEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxCheckBox;

type
  TfrmContractTypeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    FParentID: Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetParentID(const Value: Integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property ParentID:Integer read FParentID write SetParentID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst;

{ TfrmContractTypeEditorDlg }

function TfrmContractTypeEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString='')
       then AddErrorToStr(ErrorStr,'Denumire!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmContractTypeEditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmContractTypeEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmContractTypeEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('PARENTID').AsInteger:=FParentID;
             fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare tip contract';
             fMasterDataSet.Edit;
        end;
     except on E:Exception do
        begin
             fMasterDataSet.Cancel;
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmContractTypeEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     fCreateNewRecord := Value;
end;

procedure TfrmContractTypeEditorDlg.SetParentID(const Value: Integer);
begin
     FParentID := Value;
end;

procedure TfrmContractTypeEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
