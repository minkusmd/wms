unit frmCustomerWorkRulesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Data.DB, DBAccess, IBC, MemDS, cxTextEdit, cxMemo, cxDBEdit, swnbaseUnit, Vcl.Menus, Vcl.StdCtrls, cxButtons;

type
  TfrmCustomerWorkRules = class(TSWNMasteredFormClass)
    cxDBMemo1: TcxDBMemo;
    IBCQueryCustomerWorkRules: TIBCQuery;
    IBCDataSourceCustomerWorkRules: TIBCDataSource;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCTrUpdate: TIBCTransaction;
    Label1: TLabel;
    Label2: TLabel;
    cxDBMemo2: TcxDBMemo;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

var
  frmCustomerWorkRules: TfrmCustomerWorkRules;

implementation

{$R *.dfm}

{ TfrmCustomerWorkRules }

function TfrmCustomerWorkRules.IsFormDataPosted: boolean;
begin
  result := True;
    if IBCQueryCustomerWorkRules.State in dsEditModes then begin
      try
        IBCQueryCustomerWorkRules.Post;
      except on e: exception do
        begin
           result := false;
           raise;
        end;
      end;
    end;
end;

procedure TfrmCustomerWorkRules.Prepare;
begin
  inherited;
  ibctrUpdate.DefaultConnection := Tibcquery(fMasterDataSet).Connection;
  IBCQueryCustomerWorkRules.MasterSource := fMasterDataSource;
  IBCQueryCustomerWorkRules.DetailFields := 'CUSTOMERID';
  IBCQueryCustomerWorkRules.MasterFields := 'CUSTOMERID';
  IBCQueryCustomerWorkRules.Open;
end;

procedure TfrmCustomerWorkRules.WhenCancelForm;
begin
  inherited;
  if IBCQueryCustomerWorkRules.State in dsEditModes then begin
    IBCQueryCustomerWorkRules.Cancel;
  end;
end;

end.
