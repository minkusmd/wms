unit frmBPPLComissionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalc;

type
  TfrmBPPLComissionDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    edSUMA: TcxDBCurrencyEdit;
    Label3: TLabel;
    cePercent: TcxCalcEdit;
    edCalcSuma: TcxTextEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure cePercentPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    fSuma:Double;
    fPercent:Double;
    procedure CalcSuma;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    property Suma:Double read fSuma;
    property Percent:Double read fPercent;
  end;



implementation

uses DataModuleAdditions, DataModuleDB, Math, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmBPPLComissionDlg }

procedure TfrmBPPLComissionDlg.CalcSuma;
begin
     fSuma:=0;
     fPercent:=0;
     if VarIsNumeric(cePercent.EditValue) then
     begin
          fPercent:=cePercent.EditValue;
          fSuma:=RoundTo(fMasterDataSet.FieldByName('SUMA').AsFloat/100*fPercent, -2);
     end;
     edCalcSuma.Text:=FloatToStr(fSuma);
end;

procedure TfrmBPPLComissionDlg.cePercentPropertiesEditValueChanged(Sender: TObject);
begin
     CalcSuma;
end;

procedure TfrmBPPLComissionDlg.BindingDataSource;
begin
     edSUMA.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmBPPLComissionDlg.IsFormDataPosted: Boolean;
begin
     if (fSuma>0) and (fPercent>0) then Result:=True
     else
     begin
          ShowErrorDialog(cMSG_GeneralError_Title,'Comisionul!');
          Result:=False;
     end;
end;

procedure TfrmBPPLComissionDlg.Prepare;
begin
     cePercent.EditValue:=1;
     CalcSuma;
end;

end.
