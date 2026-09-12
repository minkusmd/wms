unit frmUserWorkBonusEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxMemo, cxDBEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxCalendar, Data.DB, DBAccess,
  IBC, MemDS;

type
  TfrmUserWorkBonusEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    deDATA: TcxDBDateEdit;
    lcbCT: TcxDBLookupComboBox;
    mmDESCRIPTION: TcxDBMemo;
    Label5: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    edBONUS_VALUE: TcxDBTextEdit;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;

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

uses DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB;

{ TfrmUserWorkBonusEditorDlg }

function TfrmUserWorkBonusEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('DATA').IsNull then AddErrorToStr(ErrorStr,'Data!');
     if fMasterDataSet.FieldByName('CT').IsNull or (fMasterDataSet.FieldByName('CT').AsInteger=-1) then AddErrorToStr(ErrorStr,'Contraagent!');
     if fMasterDataSet.FieldByName('BONUS_VALUE').IsNull or (fMasterDataSet.FieldByName('BONUS_VALUE').AsInteger=0) then AddErrorToStr(ErrorStr,'Bonus!');
     if fMasterDataSet.FieldByName('DESCRIPTION').IsNull or (Trim(fMasterDataSet.FieldByName('DESCRIPTION').AsString)='') then AddErrorToStr(ErrorStr,'Descriere!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmUserWorkBonusEditorDlg.BindingDataSource;
begin
     deDATA.DataBinding.DataSource:=fMasterDataSource;
     lcbCT.DataBinding.DataSource:=fMasterDataSource;
     edBONUS_VALUE.DataBinding.DataSource:=fMasterDataSource;
     mmDESCRIPTION.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmUserWorkBonusEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmUserWorkBonusEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Creare inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DATA').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('BONUS_VALUE').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             fMasterDataSet.Edit;
        end;
        IBCQueryUsers.Active:=True;

     except on E:Exception do
        begin
             fMasterDataSet.Cancel;
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmUserWorkBonusEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     fCreateNewRecord := Value;
end;

procedure TfrmUserWorkBonusEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
