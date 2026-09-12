unit frmGoodsImageEventDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus,
  cxCalendar, StdCtrls, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit;

type
  TfrmGoodsImageEventDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel8: TLabel;
    cbSpecialImage: TCheckBox;
    lbDateStart: TLabel;
    lbDateEnd: TLabel;
    deDATA_START: TcxDateEdit;
    deDATA_END: TcxDateEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cbSpecialImagePropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetData_End(const Value: TDate);
    procedure SetData_Start(const Value: TDate);
    procedure SetHasEvent(const Value: Boolean);
    function GetData_End: TDate;
    function GetData_Start: TDate;
    function GetHasEvent: Boolean;
    function CheckParams:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property HasEvent:Boolean read GetHasEvent write SetHasEvent;
    property Data_Start:TDate read GetData_Start write SetData_Start;
    property Data_End:TDate read GetData_End write SetData_End;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsImageEventDlg }

procedure TfrmGoodsImageEventDlg.cbSpecialImagePropertiesEditValueChanged(Sender: TObject);
begin
     if cbSpecialImage.Checked then
     begin
          deDATA_START.Enabled:=True;
          deDATA_END.Enabled:=True;
          lbDateStart.Enabled:=True;
          lbDateEnd.Enabled:=True;
     end
     else
     begin
          deDATA_START.Enabled:=False;
          deDATA_END.Enabled:=False;
          lbDateStart.Enabled:=False;
          lbDateEnd.Enabled:=False;
     end;
end;

function TfrmGoodsImageEventDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if cbSpecialImage.Checked then
     begin
          if deDATA_END.EditValue<deDATA_START.EditValue then AddErrorToStr(ErrorStr,'Data de sfarsit a afisarii este mai mica decat data de inceput a afisarii!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsImageEventDlg.FormCreate(Sender: TObject);
begin
     deDATA_START.EditValue:=NOW;
     deDATA_END.EditValue:=NOW+14;
end;

function TfrmGoodsImageEventDlg.GetData_End: TDate;
begin
     Result:=deDATA_END.EditValue;
end;

function TfrmGoodsImageEventDlg.GetData_Start: TDate;
begin
     Result:=deDATA_START.EditValue;
end;

function TfrmGoodsImageEventDlg.GetHasEvent: Boolean;
begin
     Result:=cbSpecialImage.Checked;
end;

function TfrmGoodsImageEventDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckParams;
end;

procedure TfrmGoodsImageEventDlg.Prepare;
begin
     deDATA_START.EditValue:=NOW;
     deDATA_END.EditValue:=NOW;
end;

procedure TfrmGoodsImageEventDlg.SetData_End(const Value: TDate);
begin
     deDATA_START.EditValue:=Value;
end;

procedure TfrmGoodsImageEventDlg.SetData_Start(const Value: TDate);
begin
     deDATA_END.EditValue:=Value;
end;

procedure TfrmGoodsImageEventDlg.SetHasEvent(const Value: Boolean);
begin
     cbSpecialImage.Checked:=Value;
end;


end.
