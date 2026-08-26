unit frmOrdinaryFilterValueDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit, cxDBEdit, Vcl.Menus, cxButtons, db;

type
  TfrmOrdinaryFilterValueDlg = class(TSWNMasteredFormClass)
    edtSimpleFilterValueRo: TcxDBTextEdit;
    edtSimpleFilterValueRu: TcxDBTextEdit;
    Label8: TLabel;
    Label4: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
  end;

//var
//  frmOrdinaryFilterValueDlg: TfrmOrdinaryFilterValueDlg;

implementation

{$R *.dfm}

{ TfrmOrdinaryFilterValueDlg }

procedure TfrmOrdinaryFilterValueDlg.BindingDataSource;
begin
  inherited;
  edtSimpleFilterValueRo.DataBinding.DataSource :=  fMasterDataSource;
  edtSimpleFilterValueRu.DataBinding.DataSource :=  fMasterDataSource;
end;

function TfrmOrdinaryFilterValueDlg.IsFormDataPosted: boolean;
begin
  Result := False;
    try
    if fMasterDataSet.State in dsEditModes then
    begin
        fMasterDataSet.Post;
        Result := True;
    end;
    except
      raise;
    end;
end;

procedure TfrmOrdinaryFilterValueDlg.Prepare;
begin
  inherited;
    fMasterDataSet.Edit;

end;

end.
