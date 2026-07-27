unit frmGoodsWebDiscountDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, DB, DBAccess, IBC, MemDS, cxCalendar,
  Buttons, Menus, Vcl.ComCtrls, dxCore, cxDateUtils;

type
  TfrmGoodsWebDiscountDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    cmbVALUE_INT: TcxComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    deSTART_DATE: TcxDateEdit;
    Label2: TLabel;
    deEND_DATE: TcxDateEdit;
    Label4: TLabel;
    sbPopupMenu: TSpeedButton;
    lbMulti: TLabel;
    pmPeriods: TPopupMenu;
    N71: TMenuItem;
    N141: TMenuItem;
    N301: TMenuItem;
    procedure sbPopupMenuClick(Sender: TObject);
    procedure N301Click(Sender: TObject);
  private
    { Private declarations }
    fEndDate: TDate;
    fDiscount: integer;
    fStartDate: TDate;
    fMultiSelect: Boolean;

    function CheckInputParams:Boolean;
    procedure SaveValues;
    procedure SetDiscount(const Value: integer);
    procedure SetEndDate(const Value: TDate);
    procedure SetStartDate(const Value: TDate);
    procedure SetMultiSelect(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property MultiSelect:Boolean read FMultiSelect write SetMultiSelect;
    property Discount:integer read FDiscount write SetDiscount;
    property StartDate:TDate read FStartDate write SetStartDate;
    property EndDate:TDate read FEndDate write SetEndDate;
  end;


implementation

uses DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions;

{$R *.dfm}

{ TfrmGoodsWebDiscountDlg }

function TfrmGoodsWebDiscountDlg.CheckInputParams: Boolean;
var Errors:String;
    N:integer;
begin
     Result:=False;
     Errors:='';

     N:=StrToIntDef(cmbVALUE_INT.Text,-1);
     if (N<=0) or (N>=100) then AddErrorToStr(Errors,'Скидка, %!');

     if VarIsNullDate(deSTART_DATE.EditValue) then AddErrorToStr(Errors,'Inceputul perioadei!');
     if VarIsNullDate(deEND_DATE.EditValue) then AddErrorToStr(Errors,'Sfirsitul perioadei!');

     if (Errors='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

function TfrmGoodsWebDiscountDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckInputParams then
     begin
          SaveValues;
          Result:=True;
     end;
end;

procedure TfrmGoodsWebDiscountDlg.N301Click(Sender: TObject);
var N:integer;
begin
     N:=TMenuItem(Sender).Tag;
     if Not VarIsNull(deSTART_DATE.EditValue) then deEND_DATE.EditValue:=TDate(deSTART_DATE.EditValue)+N;
end;

procedure TfrmGoodsWebDiscountDlg.Prepare;
begin
     lbMulti.Visible:=FMultiSelect;

     if FMultiSelect
       then dtDialogTitle.Text:='Seteaza reducerea pentru mapa'
       else dtDialogTitle.Text:='Seteaza reducerea';

     cmbVALUE_INT.Text:=IntToStr(fDiscount);
     deSTART_DATE.EditValue:=fStartDate;
     deEND_DATE.EditValue:=fEndDate;
end;

procedure TfrmGoodsWebDiscountDlg.SaveValues;
begin
     fDiscount:=StrToInt(cmbVALUE_INT.Text);
     fStartDate:=deSTART_DATE.EditValue;
     fEndDate:=deEND_DATE.EditValue;
end;

procedure TfrmGoodsWebDiscountDlg.sbPopupMenuClick(Sender: TObject);
var P:TPoint;
begin
     P.X:=sbPopupMenu.Left;
     P.Y:=sbPopupMenu.Top;
     P:=pnClient.ClientToScreen(P);
     pmPeriods.Popup(P.X,P.Y);
end;

procedure TfrmGoodsWebDiscountDlg.SetDiscount(const Value: integer);
begin
     FDiscount := Value;
end;

procedure TfrmGoodsWebDiscountDlg.SetEndDate(const Value: TDate);
begin
     FEndDate := Value;
end;

procedure TfrmGoodsWebDiscountDlg.SetMultiSelect(const Value: Boolean);
begin
     FMultiSelect := Value;
end;

procedure TfrmGoodsWebDiscountDlg.SetStartDate(const Value: TDate);
begin
     FStartDate := Value;
end;


end.
