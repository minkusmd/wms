unit frmPeremesheniePeredatiTovarDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, ExtCtrls, StdCtrls,
  cxDBEdit, DialogTitle,
  DB, IBC, MemDS, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, cxMemo, cxMaskEdit, cxTextEdit;

type
  TfrmPeremesheniePeredatiTovarDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel4: TLabel;
    cxLabel5: TLabel;
    edDT_NAME: TcxDBTextEdit;
    edCT_NAME: TcxDBTextEdit;
    edDTDEP_NAME: TcxDBTextEdit;
    edCTDEP_NAME: TcxDBTextEdit;
    Bevel1: TBevel;
    cxDBMaskEdit1: TcxDBMaskEdit;
    cxDBMemo1: TcxDBMemo;
    IBCQueryDocAddons: TIBCQuery;
    IBCDataSourceDocAddons: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxDBMemo1Click(Sender: TObject);
  private
    { Private declarations }
    function CheckParams: Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

implementation

uses
  SWNUtils, SWNConst, frmPeremeshenieCommentPeredeatiDialog;

{$R *.dfm}

{ TfrmPeremesheniePeredatiTovarDlg }

function TfrmPeremesheniePeredatiTovarDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if IBCQueryDocAddons.FieldByName('BOX_COUNT').AsInteger <= 0 then
    AddErrorToStr(ErrorStr, 'Indicati cantatea de cutii in transfer');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPeremesheniePeredatiTovarDlg.cxDBMemo1Click(Sender: TObject);
var
  dialog: TfrmPeremeshenieCommentPeredeatiDlg;
begin
  dialog := TfrmPeremeshenieCommentPeredeatiDlg.Create(Self, IBCQueryDocAddons, IBCDataSourceDocAddons);
  try

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPeremesheniePeredatiTovarDlg.BindingDataSource;
begin
  inherited;

  edDT_NAME.DataBinding.DataSource := fMasterDataSource;
  edDTDEP_NAME.DataBinding.DataSource := fMasterDataSource;
  edCT_NAME.DataBinding.DataSource := fMasterDataSource;
  edCTDEP_NAME.DataBinding.DataSource := fMasterDataSource;

     //edDateTime.Text:=FormatDateTime('DD MMMM YYYY, HH:NN',NOW);

  IBCQueryDocAddons.Connection := fMasterDataSet.Connection;
  IBCQueryDocAddons.Transaction := fMasterDataSet.Transaction;
  IBCQueryDocAddons.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryDocAddons.MasterSource := fMasterDataSource;
end;

function TfrmPeremesheniePeredatiTovarDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    IBCQueryDocAddons.Post;
    IBCQueryDocAddons.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmPeremesheniePeredatiTovarDlg.Prepare;
begin
  IBCQueryDocAddons.UpdateTransaction.StartTransaction;
  try
    IBCQueryDocAddons.Active := True;
    if IBCQueryDocAddons.Eof then
    begin
      IBCQueryDocAddons.Insert;
      IBCQueryDocAddons.FieldByName('BOX_COUNT').AsInteger := 1;
    end
    else
    begin
      IBCQueryDocAddons.Edit;
    end;
  except
    IBCQueryDocAddons.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmPeremesheniePeredatiTovarDlg.WhenCancelForm;
begin
  IBCQueryDocAddons.Cancel;
  IBCQueryDocAddons.UpdateTransaction.Rollback;
end;

end.

