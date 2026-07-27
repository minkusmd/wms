unit frmNakladnaiaPNExpenseDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, DB, IBC, MemDS, cxDBVGrid, StdCtrls,
  cxDBLookupComboBox, ExtCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  dxScrollbarAnnotations, cxLabel, Vcl.Menus, DBAccess, cxVGrid, cxInplaceContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit;

type
  TfrmNakladnaiaPNExpenseDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    lcbEXPENSE_ID: TcxDBLookupComboBox;
    cxLabel3: TLabel;
    IBCQueryExpense: TIBCQuery;
    IBCDataSourceExpense: TIBCDataSource;
    vgExpDoc: TcxDBVerticalGrid;
    vgExpDocDBEditorRow1: TcxDBEditorRow;
    vgExpDocDBEditorRow2: TcxDBEditorRow;
    vgExpDocDBEditorRow3: TcxDBEditorRow;
    vgExpDocDBEditorRow4: TcxDBEditorRow;
    vgExpDocDBEditorRow5: TcxDBEditorRow;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    btnSelectDoc: TcxButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure btnSelectDocClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewExpense: Boolean;
    procedure SetCreateNewExpense(const Value: Boolean);
    function CheckParams:Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewExpense:Boolean read fCreateNewExpense write SetCreateNewExpense;
  end;



implementation

uses SWNUtils, SWNConst, frmDocumentBrowserDialog;

{$R *.dfm}

{ TfrmNakladnaiaPNExpenseDlg }

procedure TfrmNakladnaiaPNExpenseDlg.btnSelectDocClick(Sender: TObject);
var dialog:TfrmDocumentBrowserDlg;
begin
     dialog:=TfrmDocumentBrowserDlg.Create(Self,fIBCConnection);
     try
        if Not fMasterDataSet.FieldByName('EXPENSE_DOC_ID').IsNull then
        begin
             dialog.DocID:=fMasterDataSet.FieldByName('EXPENSE_DOC_ID').asInteger;
        end;

        if dialog.ShowModal=mrOk then
        begin
             fMasterDataSet.FieldByName('EXPENSE_DOC_ID').asInteger:=dialog.DocID;
             IBCQueryDocs.Close;
             IBCQueryDocs.Open;
//             fMasterDataSet.FieldByName('EXPENSE_DOC_SUMA').AsCurrency:=dialog.DocSuma;
//             fMasterDataSet.FieldByName('EXPENSE_DOC_RATE').asFloat:=dialog.DocRate;
//             fMasterDataSet.FieldByName('EXPENSE_DOC_CURRENCY_NAME').AsWideString:=dialog.DocCurrency_Name;
//             fMasterDataSet.FieldByName('EXPENSE_DOC_DOCTYPE_TITLE').AsWideString:=dialog.DocDocTypeName;
        end;
     finally
        dialog.Free;
     end;
end;

function TfrmNakladnaiaPNExpenseDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('EXPENSE_ID').IsNull then AddErrorToStr(ErrorStr,'Denumirea articolului de cheltuieli!');
     if fMasterDataSet.FieldByName('EXPENSE_DOC_ID').IsNull then AddErrorToStr(ErrorStr,'Documentul cu descrierea cheltuielelor!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmNakladnaiaPNExpenseDlg.BindingDataSource;
begin
     inherited;

     fCreateNewExpense := False;

     IBCQueryDocs.MasterSource:=fMasterDataSource;
     lcbEXPENSE_ID.DataBinding.DataSource:=fMasterDataSource;

     //vgExpDoc.DataController.DataSource:=fMasterDataSource;
end;

function TfrmNakladnaiaPNExpenseDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.FieldByName('MODIFIED_BY').AsInteger:=UserID;

          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmNakladnaiaPNExpenseDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewExpense then
        begin
             dtDialogTitle.Text:='Inregistrarea noua';
             fMasterDataSet.Append;
             // set defaults
        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;
        end;
        IBCQueryExpense.Active:=True;
        IBCQueryDocs.Active:=True;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;

        IBCQueryDocs.Active:=False;
        IBCQueryExpense.Active:=False;

        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmNakladnaiaPNExpenseDlg.SetCreateNewExpense(const Value: Boolean);
begin
     FCreateNewExpense := Value;
end;

procedure TfrmNakladnaiaPNExpenseDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
