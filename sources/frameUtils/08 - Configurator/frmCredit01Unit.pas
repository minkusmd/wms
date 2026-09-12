unit frmCredit01Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLabel, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  dxUIAClasses;

type
  TfrmCredit01Dlg = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    cxLabel1: TcxLabel;
    cbmMonthQty: TcxComboBox;
  private
    { Private declarations }
  private
    function IsFormDataPosted: boolean; override;
  protected
    procedure UpdateGoodsPrices(DOCID, MonthQty: Integer);
  public
    { Public declarations }
  end;

var
  frmCredit01Dlg: TfrmCredit01Dlg;

implementation

uses
  DataModuleDB;

{$R *.dfm}

{ TfrmCredit01Dlg }

function TfrmCredit01Dlg.IsFormDataPosted: boolean;
begin
  UpdateGoodsPrices(dmdb.ibcquerydocs.fieldbyname('docid').Asinteger, StrToInt(cbmMonthQty.EditValue));
  Result := True;
end;

procedure TfrmCredit01Dlg.UpdateGoodsPrices(DOCID, MonthQty: Integer);
begin
  dmdb.ExecuteQuery('execute procedure credit_update_price(:docid, :monthqty)', [docid, monthqty]);
  dmdb.IBCQueryJurnal.Refresh;
end;

end.
