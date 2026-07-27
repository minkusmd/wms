unit uSelectIncidentStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxControls, cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, cxMemo,
  cxDBEdit, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, DialogTitle;

type
  TfmSelectIncidentStatus = class(TSWNMasteredFormClass)
    btnOK: TcxButton;
    btnCancel: TcxButton;
    dtDialogTitle: TDialogTitle;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    IBC_Status: TIBCQuery;
    IBCDS_Status: TIBCDataSource;
    memComments: TcxMemo;
    lcbIncidentState: TcxLookupComboBox;
  private
    { Private declarations }
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
  end;

var
  fmSelectIncidentStatus: TfmSelectIncidentStatus;

implementation

{$R *.dfm}
{ TfmSelectIncidentStatus }

procedure TfmSelectIncidentStatus.BindingDataSource;
begin
  inherited;
  memComments.Lines.Clear;

end;

function TfmSelectIncidentStatus.IsFormDataPosted: Boolean;
begin
  try
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    fMasterDataSet.RefreshRecord;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TfmSelectIncidentStatus.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  IBC_Status.Open;

end;

procedure TfmSelectIncidentStatus.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

