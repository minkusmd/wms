unit frmSalaryInfoEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDBEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, Data.DB, DBAccess, IBC, MemDS;

type
  TfrmSalaryInfoEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    cmbMonth: TcxComboBox;
    cmbYear: TcxComboBox;
    Label2: TLabel;
    lcbCUSTOMERID: TcxDBLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    edBASE_SALARY: TcxDBMaskEdit;
    edQTY_WORK_HOURS: TcxDBMaskEdit;
    IBCQueryCust: TIBCQuery;
    IBCDataSourceCust: TIBCDataSource;
    Label5: TLabel;
    edK_Grad: TcxDBMaskEdit;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    FDefaultYear: integer;
    FDefaultMonth: integer;
    fNewYear: integer;
    fNewMonth: integer;

    function CheckValues:Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetDefaultMonth(const Value: integer);
    procedure SetDefaultYear(const Value: integer);
    procedure PrepareDateSelectors;
    procedure UpdateDataSelectors;
    procedure EncodeSelectedDate;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property DefaultYear:integer read FDefaultYear write SetDefaultYear;
    property DefaultMonth:integer read FDefaultMonth write SetDefaultMonth;
    property NewYear:integer read fNewYear;
    property NewMonth:integer read fNewMonth;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst, DateUtils;

{ TfrmSalaryInfoEditorDlg }

function TfrmSalaryInfoEditorDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;
     Error:='';

     if (cmbMonth.ItemIndex=-1) or (cmbYear.ItemIndex=-1) then AddErrorToStr(Error,'Месяц!');

     if fMasterDataSet.FieldByName('CUSTOMERID').IsNull or (fMasterDataSet.FieldByName('CUSTOMERID').AsInteger=-1)
       then AddErrorToStr(Error,'Контрагент!');

     if fMasterDataSet.FieldByName('BASE_SALARY').IsNull or (fMasterDataSet.FieldByName('BASE_SALARY').AsInteger<0)
       then AddErrorToStr(Error,'Ставка!');

     if fMasterDataSet.FieldByName('QTY_WORK_HOURS').IsNull or (fMasterDataSet.FieldByName('QTY_WORK_HOURS').AsInteger<0)
       then AddErrorToStr(Error,'Рабочие часы!');


     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmSalaryInfoEditorDlg.EncodeSelectedDate;
begin
     fNewYear:=StrToInt(cmbYear.Text);
     fNewMonth:=cmbMonth.ItemIndex+1;
     fMasterDataSet.FieldByName('DATA').AsDateTime:=EncodeDate(fNewYear,fNewMonth,1);
end;

procedure TfrmSalaryInfoEditorDlg.BindingDataSource;
begin
     inherited;
     lcbCUSTOMERID.DataBinding.DataSource:=fMasterDataSource;
     edBASE_SALARY.DataBinding.DataSource:=fMasterDataSource;
     edQTY_WORK_HOURS.DataBinding.DataSource:=fMasterDataSource;
     edK_Grad.DataBinding.DataSource:=fMasterDataSource;
     FDefaultYear:=YearOf(Now);
     FDefaultMonth:=MonthOf(Now);
end;

function TfrmSalaryInfoEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          EncodeSelectedDate;
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmSalaryInfoEditorDlg.Prepare;
begin
     PrepareDateSelectors;
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание новой записи';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('BASE_SALARY').AsInteger:=0;
             fMasterDataSet.FieldByName('QTY_WORK_HOURS').AsInteger:=0;
             fMasterDataSet.FieldByName('DATA').AsDateTime:=EncodeDate(FDefaultYear,FDefaultMonth,1);
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
        end;
        IBCQueryCust.Active:=True;
        UpdateDataSelectors;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSalaryInfoEditorDlg.PrepareDateSelectors;
var i:integer;
begin
     for i := 1 to 12 do cmbMonth.Properties.Items.Add(FormatSettings.LongMonthNames[i]);
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now)-1));
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now)));
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now)+1));
end;

procedure TfrmSalaryInfoEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     fCreateNewRecord := Value;
end;

procedure TfrmSalaryInfoEditorDlg.SetDefaultMonth(const Value: integer);
begin
     FDefaultMonth := Value;
end;

procedure TfrmSalaryInfoEditorDlg.SetDefaultYear(const Value: integer);
begin
     FDefaultYear := Value;
end;

procedure TfrmSalaryInfoEditorDlg.UpdateDataSelectors;
var d:TDateTime;
begin
     if fMasterDataSet.FieldByName('DATA').IsNull then
     begin
          cmbMonth.ItemIndex:=-1;
          cmbYear.ItemIndex:=-1;
     end
     else
     begin
          d:=fMasterDataSet.FieldByName('DATA').AsDateTime;
          cmbMonth.ItemIndex:=MonthOf(d)-1;
          cmbYear.ItemIndex:=cmbYear.Properties.Items.IndexOf(IntToStr(YearOf(d)));
     end;
end;

procedure TfrmSalaryInfoEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
