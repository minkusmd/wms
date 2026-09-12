unit frmDocumentDiscountDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxTextEdit, cxCurrencyEdit, cxDBEdit, DB, IBC,
  cxDropDownEdit, cxCalc, Vcl.Menus, cxButtons, DBAccess, MemDS;

type
  TfrmDocumentDiscountDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    pnTop: TPanel;
    rbBySuma: TRadioButton;
    rbByPercent: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnButtons: TPanel;
    Label8: TLabel;
    edSUMA: TcxDBCurrencyEdit;
    edSUMA_FINAL: TcxCurrencyEdit;
    edDiscount_Suma: TcxCurrencyEdit;
    IBCQueryDisc: TIBCQuery;
    IBCDataSourceDisc: TIBCDataSource;
    edDiscount_Percent: TcxCurrencyEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure rbBySumaClick(Sender: TObject);
    procedure edDiscount_SumaPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    procedure CalcFinalSum;
    procedure ApplyValues;
    function CheckInputParams:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmDocumentDiscountDlg }

procedure TfrmDocumentDiscountDlg.ApplyValues;
begin
     if rbBySuma.Checked then
     begin
          IBCQueryDisc.FieldByName('DISCOUNT_SUM').AsFloat:=edDiscount_Suma.Value;
          IBCQueryDisc.FieldByName('DISCOUNT_PERCENT').Value:=Null;
          IBCQueryDisc.FieldByName('DISCOUNT_FLG').AsInteger:=0;
     end
     else
     begin
          IBCQueryDisc.FieldByName('DISCOUNT_PERCENT').AsFloat:=edDiscount_Percent.Value;
          IBCQueryDisc.FieldByName('DISCOUNT_SUM').Value:=Null;
          IBCQueryDisc.FieldByName('DISCOUNT_FLG').AsInteger:=1;
     end;
end;

procedure TfrmDocumentDiscountDlg.CalcFinalSum;
var suma:Double;
    percent:double;
    discount:double;
begin
     suma:=fMasterDataSet.FieldByName('SUMA').AsFloat;

     if rbBySuma.Checked then discount:=edDiscount_Suma.Value
     else
     begin
          percent:=edDiscount_Percent.Value;
          discount:=suma/100*percent;
     end;

     edSUMA_FINAL.Value:=suma-discount;
end;

function TfrmDocumentDiscountDlg.CheckInputParams: Boolean;
var ErrorStr:String;
    discPercent:double;
begin
     ErrorStr:='';
     Result:=False;

     CalcFinalSum;

     if (Not rbBySuma.Checked) and (Not rbByPercent.Checked) then AddErrorToStr(ErrorStr,'Indicati tipul discountului!');

     discPercent:=100-edSUMA_FINAL.Value*100/fMasterDataSet.FieldByName('SUMA').AsFloat;
     if discPercent>15 then AddErrorToStr(ErrorStr,'Valoarea discountului este depasita!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmDocumentDiscountDlg.edDiscount_SumaPropertiesEditValueChanged(Sender: TObject);
begin
     CalcFinalSum;
end;

procedure TfrmDocumentDiscountDlg.BindingDataSource;
begin
     inherited;
     edSUMA.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmDocumentDiscountDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          ApplyValues;

          IBCQueryDisc.Post;
          IBCQueryDisc.UpdateTransaction.Commit;

          Result:=True;
     end;
end;

procedure TfrmDocumentDiscountDlg.Prepare;
var bySuma:Boolean;
begin
     edDiscount_Suma.Enabled:=False;
     edDiscount_Percent.Enabled:=False;

     try
        IBCQueryDisc.UpdateTransaction.StartTransaction;

        IBCQueryDisc.ParamByName('docID').AsInteger:=fMasterDataSet.FieldByName('DOCID').AsInteger;
        IBCQueryDisc.Active:=True;
        IBCQueryDisc.Edit;

        if Not IBCQueryDisc.Eof then
        begin
             // has record

             bySuma:=IBCQueryDisc.FieldByName('DISCOUNT_FLG').AsInteger=0;

             rbBySuma.Checked:=bySuma;
             rbByPercent.Checked:=Not bySuma;

             edDiscount_Suma.Value:=IBCQueryDisc.FieldByName('DISCOUNT_SUM').AsFloat;
             edDiscount_Percent.Value:=IBCQueryDisc.FieldByName('DISCOUNT_PERCENT').AsFloat;
        end
        else
        begin
             IBCQueryDisc.FieldByName('DOCID').AsInteger:=fMasterDataSet.FieldByName('DOCID').AsInteger;
             edDiscount_Suma.Value:=0;
             edDiscount_Percent.Value:=0;
        end;

        CalcFinalSum;

     except
        IBCQueryDisc.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmDocumentDiscountDlg.rbBySumaClick(Sender: TObject);
var bySuma:Boolean;
begin
     bySuma:=rbBySuma.Checked;

     edDiscount_Suma.Enabled:=bySuma;
     Label5.Enabled:=bySuma;
     edDiscount_Percent.Enabled:=Not bySuma;
     Label8.Enabled:=Not bySuma;

     CalcFinalSum;
end;

procedure TfrmDocumentDiscountDlg.WhenCancelForm;
begin
     IBCQueryDisc.UpdateTransaction.Rollback;
end;

end.
