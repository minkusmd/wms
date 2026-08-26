unit frmGlobalCallHistoryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, Data.DB, cxDBData, DBAccess,
  IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, RzPanel, RzDlgBtn;

type
  TfrmGlobalCallHistory = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1PHONENUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1NICKNAME: TcxGridDBColumn;
  private
    FPhoneNumber: string;
    procedure SetPhoneNumber(const Value: string);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property PhoneNumber: string read FPhoneNumber write SetPhoneNumber;
    { Public declarations }

  end;

var
  frmGlobalCallHistory: TfrmGlobalCallHistory;

implementation

{$R *.dfm}

procedure TfrmGlobalCallHistory.Prepare;
begin
  inherited;
  ibcquery1.close;
  ibcquery1.ParamByName('phonenumber').AsString := Trim(FPhoneNumber);
  IBCQuery1.Open;
end;

procedure TfrmGlobalCallHistory.SetPhoneNumber(const Value: string);
begin
  FPhoneNumber := Value;
end;

end.
