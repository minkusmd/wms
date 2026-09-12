unit frmCopyReportDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  cxTextEdit, Menus, StdCtrls, cxButtons,
  Buttons, ExtCtrls, DialogTitle, IBC, DBAccess, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit;

type

  TOnCopyReport = procedure (const ReportID,DT,TargetDT,DocTypeID:integer; const Transaction:TIBCTransaction; var NewReportID:integer) of object;

  TfrmCopyReportDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnTop: TPanel;
    cxLabel1: TLabel;
    edReportTitle: TcxTextEdit;
    edReportID: TcxTextEdit;
    IBCTrUpdate: TIBCTransaction;
    cbDontCopyFirmsRights: TCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fReportID:integer;
    fNewReportID:integer;
    procedure SetReportTitle(const Value: String);
    procedure SetReportID(const Value: integer);

    function DoCopyReport:Boolean;
    function CopyReport:Boolean;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;


  public
    { Public declarations }
    property ReportID:integer read fReportID write SetReportID;
    property ReportTitle:String write SetReportTitle;
    property NewReportID:Integer read fNewReportID;
  end;


implementation

uses DB, SWNUtils,
  SWNDBErrors;

{$R *.dfm}

{ TfrmCloneReportDlg }


function TfrmCopyReportDlg.CopyReport:Boolean;
var Query:TIBCQuery;
begin
     Result:=false;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        IBCTrUpdate.StartTransaction;
        try
           Query.SQL.Text:='SELECT NEWREPORTID FROM SP_CREATE_REPORT_COPY2(:REPORTID, :COPY_FIRMS_RIGHTS)';
           Query.ParamByName('REPORTID').AsInteger:=fReportID;
           Query.ParamByName('COPY_FIRMS_RIGHTS').AsInteger:=Ord(Not cbDontCopyFirmsRights.Checked);
           Query.ExecSQL;
           if Not Query.Eof then fNewReportID:=Query.Fields[0].AsInteger;
           IBCTrUpdate.Commit;
           Result:=True;
        except on E:Exception do
           begin
                IBCTrUpdate.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

function TfrmCopyReportDlg.DoCopyReport:Boolean;
begin
     Result:=(ShowAskDialog('Copiere raport','Doriti sa faceti o copie a raportului?')=mrYes) and CopyReport;
end;

function TfrmCopyReportDlg.IsFormDataPosted: Boolean;
begin
     Result:=DoCopyReport;
end;

procedure TfrmCopyReportDlg.Prepare;
begin
end;

procedure TfrmCopyReportDlg.SetReportID(const Value: integer);
begin
     fReportID := Value;
     edReportID.Text:=IntToStr(Value);
end;

procedure TfrmCopyReportDlg.SetReportTitle(const Value: String);
begin
     edReportTitle.Text:=Value;
end;

end.
