unit frmIncidentStatusDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxStyles,
  DB, cxClasses, DBAccess, IBC, MemDS, StdCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, ExtCtrls, cxControls, cxGraphics, cxEdit, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmIncidentStatusDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    IBCQueryIncidentStatus: TIBCQuery;
    IBCDataSourceIncidentStatus: TIBCDataSource;
    btnOk: TButton;
    btnCancel: TButton;
    pnClient: TPanel;
    lcmbStatuses: TcxDBLookupComboBox;
    Label1: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure InitValues; override;
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils;

{$R *.dfm}

{ TfrmIncidentStatusDlg }

procedure TfrmIncidentStatusDlg.btnOkClick(Sender: TObject);
begin
  if fMasterDataSet.FieldByName('STATUS_ID').IsNull then
    ShowErrorDialog('Ошибка', 'Выберите статус инцидента!')
  else
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    ModalResult := mrOk;
  end;
end;

procedure TfrmIncidentStatusDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmIncidentStatusDlg.InitValues;
begin
  inherited;
  lcmbStatuses.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmIncidentStatusDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    fMasterDataSet.Edit;
    IBCQueryIncidentStatus.Active := True;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

end.

