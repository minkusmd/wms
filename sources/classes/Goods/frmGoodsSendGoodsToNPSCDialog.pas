unit frmGoodsSendGoodsToNPSCDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Data.DB,
  DBAccess, IBC, MemDS, cxLabel;

type
  TfrmGoodsSendGoodsToNPSCDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lbInfo: TLabel;
    lcbOperator: TcxLookupComboBox;
    IBCQueryOP: TIBCQuery;
    IBCDataSourceOP: TIBCDataSource;
    cxLabel1: TcxLabel;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryUsers: TIBCQuery;
  private
    { Private declarations }
    function CheckValues: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    procedure SetGoodsQty(const Qty: Integer);
    function GetOperatorID: Integer;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils;

{ TfrmGoodsSendGoodsToNPSCDlg }

function TfrmGoodsSendGoodsToNPSCDlg.CheckValues: Boolean;
var
  Error: string;
begin
  Result := False;
  Error := '';

  if VarIsNull(lcbOperator.EditValue) or (lcbOperator.EditValue <= 0) then
    AddErrorToStr(Error, 'Оператор NPSC!');

  if Error = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Error);
end;

function TfrmGoodsSendGoodsToNPSCDlg.GetOperatorID: Integer;
begin
  if VarIsNull(lcbOperator.EditValue) then
    Result := -1
  else
    Result := lcbOperator.EditValue;
end;

function TfrmGoodsSendGoodsToNPSCDlg.IsFormDataPosted: Boolean;
begin
  Result := CheckValues;
end;

procedure TfrmGoodsSendGoodsToNPSCDlg.Prepare;
begin
  IBCQueryOP.Active := True;
end;

procedure TfrmGoodsSendGoodsToNPSCDlg.SetGoodsQty(const Qty: Integer);
begin
  lbInfo.Caption := Format('Всего товаров: %d', [Qty]);
end;

end.

