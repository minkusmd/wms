unit uLoanTypesDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS;

type
  TfrmLoanTypesDlg = class()
    btnOK: TButton;
    Button2: TButton;
    IBCQueryLoanTypes: TIBCQuery;
    IBCDataSourceLoanTypes: TIBCDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1_MinValue: TcxGridDBColumn;
    cxGrid1DBTableView1_MaxValue: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions;

{$R *.dfm}

procedure TfrmLoanTypesDlg.btnOKClick(Sender: TObject);
begin

end;

{ TfrmTipCrediteDlg }

function TfrmLoanTypesDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if IBCQueryLoanTypes.State in [dsEdit, dsInsert] then
  begin
    try
      IBCQueryLoanTypes.Post;
    except on e: Exception do
    begin
      Result := False;
      raise Exception.Create(e.Message);
    end;
    end;
  end;
end;

procedure TfrmLoanTypesDlg.Prepare;
begin
  IBCQueryLoanTypes.Connection := fIBCConnection;
  IBCTrUpdate.DefaultConnection := fIBCConnection;
  IBCQueryLoanTypes.Open;
end;

procedure TfrmLoanTypesDlg.WhenCancelForm;
begin
  if IBCQueryLoanTypes.State in [dsEdit, dsInsert] then
    IBCQueryLoanTypes.Cancel;
end;

end.

