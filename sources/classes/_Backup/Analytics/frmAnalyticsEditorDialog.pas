unit frmAnalyticsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit, cxCheckBox;

type
  TfrmAnalyticsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    cbFLG_CHANGE_BALANS: TcxDBCheckBox;
    cbFLG_EXPENSES: TcxDBCheckBox;
    cbFLG_CALC_SALDO: TcxDBCheckBox;
  private
    fCreateNewAnalytics: Boolean;
    fParentID: integer;
    { Private declarations }
    function CheckInputParams:Boolean;
    procedure SetCreateNewAnalytics(const Value: Boolean);
    procedure SetParentID(const Value: integer);
  protected
    { protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewAnalytics:Boolean read fCreateNewAnalytics write SetCreateNewAnalytics;
    property ParentID:integer read FParentID write SetParentID;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmAnalyticsEditorDlg }

function TfrmAnalyticsEditorDlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=False;

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString='') then AddErrorToStr(Errors,'Denumirea analiticii!');

     if Errors='' then Result:=true
     else
         ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmAnalyticsEditorDlg.InitValues;
begin
     inherited;

     fParentID := 0;
     fCreateNewAnalytics:=false;

     edTITLE.DataBinding.DataSource := fMasterDataSource;
     cbFLG_CHANGE_BALANS.DataBinding.DataSource := fMasterDataSource;
     cbFLG_EXPENSES.DataBinding.DataSource := fMasterDataSource;
     cbFLG_CALC_SALDO.DataBinding.DataSource := fMasterDataSource;
     mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmAnalyticsEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end
     else Result:=false;
end;

procedure TfrmAnalyticsEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     if fCreateNewAnalytics then
     begin
          dtDialogTitle.Text:='Creare analitica noua';
          fMasterDataSet.Insert;
          fMasterDataSet.FieldByName('PARENTID').AsInteger:=fParentID;
          fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=0;
          fMasterDataSet.FieldByName('FLG_NOT_CHANGE_BALANS').AsInteger:=0;
          fMasterDataSet.FieldByName('FLG_CHANGE_BALANS').AsInteger:=0;
          fMasterDataSet.FieldByName('FLG_EXPENSES').AsInteger:=0;
          fMasterDataSet.FieldByName('FLG_CALC_SALDO').AsInteger:=0;
     end
     else
     begin
          dtDialogTitle.Text:='Modificare analitica';
          fMasterDataSet.Edit;
     end;
end;

procedure TfrmAnalyticsEditorDlg.SetCreateNewAnalytics(const Value: Boolean);
begin
     fCreateNewAnalytics := Value;
end;

procedure TfrmAnalyticsEditorDlg.SetParentID(const Value: integer);
begin
     FParentID := Value;
end;

procedure TfrmAnalyticsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
