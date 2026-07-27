unit frmSalePlansEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, StdCtrls, ExtCtrls, cxCalc, cxDBEdit, cxDropDownEdit, cxCalendar, Vcl.Menus,
  cxButtons;

type
  TfrmSalePlansEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beDT: TcxButtonEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    deDATA: TcxDBDateEdit;
    ceSUMA: TcxDBCalcEdit;
    ceSUMA_SAL: TcxDBCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Label5: TLabel;
    Label6: TLabel;
    ceTRANSACTIONS_QTY: TcxDBCalcEdit;
    ceNumOfSallers: TcxDBCalcEdit;
    procedure beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewPlan: Boolean;
    procedure SetCreateNewPlan(const Value: Boolean);
    procedure SelectDT;
    function CheckInputParams:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewPlan:Boolean read FCreateNewPlan write SetCreateNewPlan;
  end;


implementation

uses SWNUtils, SWNConst, frmCustomersDlg, SWNCustomersTypesUnit, DateUtils;

{$R *.dfm}

{ TfrmSalePlansEditorDlg }

procedure TfrmSalePlansEditorDlg.beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectDT;
end;

function TfrmSalePlansEditorDlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=false;
     Errors:='';

     if fMasterDataSet.FieldByName('DT').IsNull then AddErrorToStr(Errors,'Фирма!');
     if fMasterDataSet.FieldByName('DATA').IsNull then AddErrorToStr(Errors,'Дата!');
     if fMasterDataSet.FieldByName('SUMA').IsNull or (fMasterDataSet.FieldByName('SUMA').AsFloat<0) then AddErrorToStr(Errors,'План продаж!');
     if fMasterDataSet.FieldByName('SUMA_SAL').IsNull or (fMasterDataSet.FieldByName('SUMA_SAL').AsFloat<0) then AddErrorToStr(Errors,'Фонд заплат!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmSalePlansEditorDlg.BindingDataSource;
begin
     deDATA.DataBinding.DataSource:=fMasterDataSource;
     ceSUMA.DataBinding.DataSource:=fMasterDataSource;
     ceSUMA_SAL.DataBinding.DataSource:=fMasterDataSource;
     ceNumOfSallers.DataBinding.DataSource:=fMasterDataSource;
     ceTRANSACTIONS_QTY.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmSalePlansEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmSalePlansEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewPlan then
        begin
             // create new record
             dtDialogTitle.Text:='Создание нового плана';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DATA').AsDateTime:=RecodeDay(DateOf(NOW)+1,1);
             fMasterDataSet.FieldByName('SUMA').AsFloat:=0;
             fMasterDataSet.FieldByName('SUMA_SAL').AsFloat:=0;
        end
        else
        begin
             // modify
             dtDialogTitle.Text:='Изменение информации';
             fMasterDataSet.Edit;
        end;
        beDT.Text:=fMasterDataSet.FieldByName('DT_NAME').AsString;

     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSalePlansEditorDlg.SelectDT;
var dialog:TfrmCustomersDlg;
    dt:integer;
begin
     dt:=-1;
     if Not fMasterDataSet.FieldByName('DT').IsNull then dt:=fMasterDataSet.FieldByName('DT').AsInteger;

     dialog:=TfrmCustomersDlg.Create(Self);
     try
        dialog.CustomFilter:=[cfFirms];
        if dialog.SelectCustomer(dt,false,5209,'Выбор фирмы для Плана продаж') then
        begin
             fMasterDataSet.FieldByName('DT').AsInteger:=dialog.CustomerID;
             beDT.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSalePlansEditorDlg.SetCreateNewPlan(const Value: Boolean);
begin
     fCreateNewPlan := Value;
end;

procedure TfrmSalePlansEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
