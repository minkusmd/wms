unit frm20PaymentPeriodDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit;

type
  Tfrm20PaymentPeriodDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    dePAYMENT_ENDDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    function CheckValues:Boolean;
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

uses SWNUtils, SWNConst;

{$R *.dfm}

{ Tfrm20PaymentPeriodDlg }

function Tfrm20PaymentPeriodDlg.CheckValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if MasterDataSet.FieldByName('PAYMENT_ENDDATA').IsNull or (MasterDataSet.FieldByName('PAYMENT_ENDDATA').AsDateTime<NOW)
       then AddErrorToStr(Errors,'Termen de plata!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure Tfrm20PaymentPeriodDlg.BindingDataSource;
begin
     inherited;
     dePAYMENT_ENDDATA.DataBinding.DataSource:=fMasterDataSource;
end;

function Tfrm20PaymentPeriodDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure Tfrm20PaymentPeriodDlg.Prepare;
begin
     if fMasterDataSet.Eof
      then fMasterDataSet.Insert
      else fMasterDataSet.Edit;
end;

procedure Tfrm20PaymentPeriodDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
