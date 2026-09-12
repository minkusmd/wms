unit frmExchangeRateEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, Menus, cxButtons, StdCtrls, ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmExchangeRateEditorDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    btnCancel: TcxButton;
    edRate: TEdit;
    edSourceRate: TEdit;
    Label3: TLabel;
    edSourceSuma: TEdit;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edSourceCurrency: TEdit;
    edTargetCurrency: TEdit;
    btnOk: TcxButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fRate: double;
    procedure SetRate(const Value: double);
  protected
    { protected declarations }
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property Rate:double read fRate write SetRate;
  end;

  function ShowModifyCurrencyExchangeRateDialog(const inRate:Double; var outRate:Double):Boolean;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

function ShowModifyCurrencyExchangeRateDialog(const inRate:Double; var outRate:Double):Boolean;
var dialog:TfrmExchangeRateEditorDlg;
begin
     Result:=False;
     dialog:=TfrmExchangeRateEditorDlg.Create(nil);
     try
        dialog.Rate:=inRate;
        if dialog.ShowModal=mrOk then
        begin
             Result:=True;
        end;
        outRate:=dialog.Rate;
     finally
        dialog.Free;
     end;
end;


procedure TfrmExchangeRateEditorDlg.FormCreate(Sender: TObject);
begin
     fRate:=1;
end;

function TfrmExchangeRateEditorDlg.IsFormDataPosted: Boolean;
var n:double;
begin
     Result:=False;
     n:=StrToFloatDef(edRate.Text,-1);
     if n>=1 then
     begin
          fRate:=n;
          Result:=True;
     end
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,'Cursul valutar!');
end;

procedure TfrmExchangeRateEditorDlg.SetRate(const Value: double);
begin
     fRate:=Value;
     edRate.Text:=FloatToStr(Value);
end;

end.
