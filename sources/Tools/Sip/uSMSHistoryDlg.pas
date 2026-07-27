unit uSMSHistoryDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxContainer, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMemo, cxDBEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, DBAccess, IBC, MemDS, frameSmsHistoryUnit;

type
  TfrmSMSHistoryDlg = class(TSWNCustomForm)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    frameSMSHistory1: TframeSMSHistory;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    PhoneNumber: string;
    { Public declarations }
  end;

var
  frmSMSHistoryDlg: TfrmSMSHistoryDlg;

implementation

{$R *.dfm}

{ TfrmSMSHistoryDlg }

procedure TfrmSMSHistoryDlg.Prepare;
begin
  framesmshistory1.IBCQuerySMS_History.Close;
  framesmshistory1.IBCQuerySMS_History.ParamByName('PHONE').AsString := PhoneNumber;
  framesmshistory1.IBCQuerySMS_History.Open;
end;

end.
