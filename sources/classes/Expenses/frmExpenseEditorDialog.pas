unit frmExpenseEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDBEdit, cxMemo, cxTextEdit, cxMaskEdit,
  cxButtonEdit, Vcl.StdCtrls, DBAccess, IBC, MemDS, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TfrmExpenseEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    beDocID: TcxButtonEdit;
    beDT: TcxButtonEdit;
    beCT: TcxButtonEdit;
    Label5: TLabel;
    Label6: TLabel;
    mmDETAILS: TcxDBMemo;
    edSUMA: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    IBCQueryExpAnalytics: TIBCQuery;
    IBCDataSourceExpAnalytics: TIBCDataSource;
    procedure beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beDocIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    FCT: integer;
    FDocID: integer;
    FDT: integer;
    FDoc_Info: String;
    FCT_Name: String;
    FDT_Name: String;
    procedure SetCreateNewRecord(const Value: Boolean);

    function CheckValues:Boolean;
    procedure SetCT(const Value: integer);
    procedure SetDocID(const Value: integer);
    procedure SetDT(const Value: integer);
    procedure SetCT_Name(const Value: String);
    procedure SetDoc_Info(const Value: String);
    procedure SetDT_Name(const Value: String);

    procedure SelectDocument;
    procedure SelectDT;
    procedure SelectCT;
    procedure LoadDocInfo(const DocID:integer);

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property DocID:integer read FDocID write SetDocID;
    property DT:integer read FDT write SetDT;
    property CT:integer read FCT write SetCT;
    property Doc_Info:String read FDoc_Info write SetDoc_Info;
    property DT_Name:String read FDT_Name write SetDT_Name;
    property CT_Name:String read FCT_Name write SetCT_Name;
    procedure DisableDocID;
    procedure DisableDT;
    procedure DisableCT;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst, frmCustomersDlg, frmSearchDocumentByIdDialog, DataModuleDB;

{ TfrmExpenseEditorDlg }

procedure TfrmExpenseEditorDlg.beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectCT;
end;

procedure TfrmExpenseEditorDlg.beDocIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectDocument;
end;

procedure TfrmExpenseEditorDlg.beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectDT;
end;

function TfrmExpenseEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('DOCID').IsNull then AddErrorToStr(ErrorStr,'Документ!');
     if fMasterDataSet.FieldByName('DT').IsNull then AddErrorToStr(ErrorStr,'Фирма!');
     if fMasterDataSet.FieldByName('CT').IsNull then AddErrorToStr(ErrorStr,'Контрагент!');
     if fMasterDataSet.FieldByName('ANALITICAID').IsNull or (fMasterDataSet.FieldByName('ANALITICAID').asInteger<=0) then AddErrorToStr(ErrorStr,'Аналитика!');
     //if fMasterDataSet.FieldByName('DETAILS').IsNull then AddErrorToStr(ErrorStr,'Описание расходов!');
     if fMasterDataSet.FieldByName('SUMA').IsNull or (fMasterDataSet.FieldByName('SUMA').AsInteger<=0) then AddErrorToStr(ErrorStr,'Сумма, лей!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmExpenseEditorDlg.DisableCT;
begin
     beCT.Enabled:=False;
end;

procedure TfrmExpenseEditorDlg.DisableDocID;
begin
     beDocID.Enabled:=False;
end;

procedure TfrmExpenseEditorDlg.DisableDT;
begin
     beDT.Enabled:=False;
end;

procedure TfrmExpenseEditorDlg.BindingDataSource;
begin
     fDocID:=-1;
     fDT:=-1;
     fCT:=-1;
     mmDETAILS.DataBinding.DataSource:=fMasterDataSource;
     edSUMA.DataBinding.DataSource:=fMasterDataSource;
     lcbAnalytics.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmExpenseEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmExpenseEditorDlg.LoadDocInfo(const DocID: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT DOCID, DT, DT_NAME, CT, CT_NAME, DOCTYPE_NAME FROM VW_TDB_DOCS WHERE DOCID=:ID';
        Query.ParamByName('ID').AsInteger:=DocID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             fMasterDataSet.FieldByName('DT').AsInteger:=Query.Fields[1].AsInteger;                     
             fMasterDataSet.FieldByName('CT').AsInteger:=Query.Fields[3].AsInteger;                     
             beDT.Text:=Query.Fields[2].AsString;
             beCT.Text:=Query.Fields[4].AsString;
             beDocID.Text:=Format('%d. %s',[Query.Fields[0].AsInteger,Query.Fields[5].AsString]);
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmExpenseEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание новой записи';
             fMasterDataSet.Insert;

             fMasterDataSet.FieldByName('DOCID').AsInteger:=FDocID;
             if (FDocID<>-1) then beDocID.Text:=FDoc_Info;
             if (FDT<>-1) then
             begin
                  fMasterDataSet.FieldByName('DT').AsInteger:=FDT;
                  beDT.Text:=FDT_Name;
             end;
             if (FCT<>-1) then
             begin
                  fMasterDataSet.FieldByName('CT').AsInteger:=FCT;
                  beCT.Text:=FCT_Name;
             end;
             fMasterDataSet.FieldByName('SUMA').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;

             if fMasterDataSet.FieldByName('DOCID').AsInteger<>-1 then
             begin
                  beDocID.Text:=fMasterDataSet.FieldByName('DOC_INFO').AsString;
                  beDT.Enabled:=False;
                  beCT.Enabled:=False;
             end
             else beDocID.Text:='Нет привязки к документу.';
             if fMasterDataSet.FieldByName('DT').AsInteger<>-1
               then beDT.Text:=fMasterDataSet.FieldByName('DT_NAME').AsString
               else beDT.Text:='Нет фирмы.';
             if fMasterDataSet.FieldByName('CT').AsInteger<>-1
               then beCT.Text:=fMasterDataSet.FieldByName('CT_NAME').AsString
               else beCT.Text:='Нет контрагента.';
        end;
        IBCQueryExpAnalytics.Active:=True;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmExpenseEditorDlg.SelectCT;
var dialog:TfrmCustomersDlg;
    custID:integer;
begin
     custID:=0;
     if fMasterDataSet.FieldByName('CT').AsInteger<>-1 then custID:=fMasterDataSet.FieldByName('CT').AsInteger;

     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(custID,false,0,'Выберите контрагента...') then
        begin
             fMasterDataSet.FieldByName('CT').AsInteger:=dialog.CustomerID;
             beCT.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmExpenseEditorDlg.SelectDocument;
var dialog:TfrmSearchDocumentByIdDlg;
begin
     dialog:=TfrmSearchDocumentByIdDlg.Create(self);
     try
        if dialog.ShowModal=mrOk then
        begin
             fMasterDataSet.FieldByName('DOCID').AsInteger:=dialog.DocID;
             LoadDocInfo(dialog.DocID);
             beDT.Enabled:=False;
             beCT.Enabled:=False;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmExpenseEditorDlg.SelectDT;
var dialog:TfrmCustomersDlg;
    custID:integer;
begin
     custID:=0;
     if fMasterDataSet.FieldByName('DT').AsInteger<>-1 then custID:=fMasterDataSet.FieldByName('DT').AsInteger;

     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(custID,false,0,'Выберите фирму...') then
        begin
             fMasterDataSet.FieldByName('DT').AsInteger:=dialog.CustomerID;
             beDT.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmExpenseEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmExpenseEditorDlg.SetCT(const Value: integer);
begin
  FCT := Value;
end;

procedure TfrmExpenseEditorDlg.SetCT_Name(const Value: String);
begin
  FCT_Name := Value;
end;

procedure TfrmExpenseEditorDlg.SetDocID(const Value: integer);
begin
  FDocID := Value;
end;

procedure TfrmExpenseEditorDlg.SetDoc_Info(const Value: String);
begin
  FDoc_Info := Value;
end;

procedure TfrmExpenseEditorDlg.SetDT(const Value: integer);
begin
  FDT := Value;
end;

procedure TfrmExpenseEditorDlg.SetDT_Name(const Value: String);
begin
  FDT_Name := Value;
end;

procedure TfrmExpenseEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
