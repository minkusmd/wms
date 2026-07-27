unit frmOportunitatiDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxDBEdit, cxDBLookupComboBox, ExtCtrls,
  Menus, StdCtrls, DB, DBAccess, IBC, cxButtonEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox,
  cxCalendar, cxMemo, cxDropDownEdit, cxTextEdit, cxMaskEdit, cxCalc, MemDS,
  cxLookupEdit, cxDBLookupEdit, dxRatingControl, dxDBRatingControl, cxTrackBar,
  cxDBTrackBar;

type
  TfrmOportunitatiDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    cxLabel5: TLabel;
    Subiect: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    cxDataEst: TcxDBDateEdit;
    Label3: TLabel;
    cxVenit: TcxDBCalcEdit;
    cxSubiect: TcxDBTextEdit;
    cxClientInfo: TcxDBTextEdit;
    Label4: TLabel;
    cxProbabilitate: TcxDBTrackBar;
    Label5: TLabel;
    dxEvaluare: TdxDBRatingControl;
    edComentariu: TcxDBMemo;
    cbResponsabil: TcxDBLookupComboBox;
    Label6: TLabel;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    Label7: TLabel;
    teTelefon: TcxDBTextEdit;
    Label8: TLabel;
    lcbFirma: TcxDBLookupComboBox;
    IBCQueryFirms: TIBCQuery;
    IBCDataSourceFirms: TIBCDataSource;
    Label9: TLabel;
    lcbStatus: TcxDBLookupComboBox;
    IBCQuerySysS: TIBCQuery;
    IBCDataSourceSysS: TIBCDataSource;
    procedure edComentariuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCreateNewDocument: boolean;
    fSECURITY_CanSetupPastDate, fSECURITY_ALLOW_CONTRACT: Boolean;
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SetCreateNewDocument(const Value: boolean);
  protected
    procedure BindDataSource;
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;

  public

    property CreateNewDocument: boolean read FCreateNewDocument write SetCreateNewDocument;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg, SWNSecurityFlags,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, SWNDBErrors,
  frmCustomerContractsDialog, SWNSecurity;

{$R *.dfm}

procedure TfrmOportunitatiDlg.BindDataSource;
begin
  IBCQueryUsers.Active := True;
  IBCQueryFirms.Open;
  IBCQuerySysS.Open;

  deDATA.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  deDATA.DataBinding.DataField := 'DATA';
  cxSubiect.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cxSubiect.DataBinding.DataField := 'SUBIECT';
  cxClientInfo.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cxClientInfo.DataBinding.DataField := 'CLIENT_POTENTIAL';
  cxDataEst.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cxDataEst.DataBinding.DataField := 'DATA_ESTIMATA';
  cxVenit.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cxVenit.DataBinding.DataField := 'VENIT_ESTIMAT';
  cxProbabilitate.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cxProbabilitate.DataBinding.DataField := 'PROBABILITATE';
  dxEvaluare.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  dxEvaluare.DataBinding.DataField := 'EVALUARE';
  edComentariu.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  edComentariu.DataBinding.DataField := 'COMENTARIU';
  cbResponsabil.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  cbResponsabil.DataBinding.DataField := 'RESPONSABIL';

  teTelefon.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  lcbFirma.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;
  lcbStatus.DataBinding.DataSource := dmDB.IBCDataSourceOportunitati;

end;

function TfrmOportunitatiDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryOportunitati do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data document!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmOportunitatiDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmOportunitatiDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
    dmDB.IBCQueryOportunitati.Post;
    dmDB.IBCQueryOportunitati.UpdateTransaction.Commit;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmOportunitatiDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  BindDataSource;

  dmDB.IBCQueryOportunitati.UpdateTransaction.StartTransaction;
  try

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      dmDB.IBCQueryOportunitati.Append;
      dmDB.IBCQueryOportunitati.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryOportunitati.FieldByName('DT').AsInteger := dmDB.FirmaInfo.FirmaID;
    end
    else
    begin
      dmDB.IBCQueryOportunitati.Edit;
    end;

  except
    if dmDB.IBCQueryOportunitati.State in dsEditModes then
      dmDB.IBCQueryOportunitati.Cancel;
    dmDB.IBCQueryOportunitati.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmOportunitatiDlg.SetupSecurityItems;
begin

end;

procedure TfrmOportunitatiDlg.WhenCancelForm;
begin
  dmDB.IBCQueryOportunitati.Cancel;
  dmDB.IBCQueryOportunitati.UpdateTransaction.Rollback;
end;

procedure TfrmOportunitatiDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
end;
procedure TfrmOportunitatiDlg.edComentariuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  DateStr: string;
  Pt: TPoint;
  Pos: Integer;
begin
  if ( (Key = ORD('d')) or (Key = Ord('D')) and (ssCtrl in Shift)) then
  begin
//    Pt := edComentariu.ScreenToClient(Mouse.CursorPos);
//    if (Pt.X >= 0) and (Pt.Y >= 0) then
//    begin
//      Pos := LoWord(edComentariu.Perform(EM_CHARFROMPOS, 0, MakeLong(Pt.x, Pt.Y)));
      edComentariu.SelLength := 0;
//      edComentariu.SelStart := Pos;
      DateStr := DateTimeToStr(Now) +' - ';
      edComentariu.SelText := DateStr;
      edComentariu.SelStart := edComentariu.SelStart + length(DateTimeToStr(Now) +' - ') + 1;
//    end;
  end;
end;

procedure TfrmOportunitatiDlg.SetCreateNewDocument(const Value: boolean);
begin
  FCreateNewDocument := Value;
end;

end.

