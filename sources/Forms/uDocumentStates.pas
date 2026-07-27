unit uDocumentStates;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxDropDownEdit, cxCalendar, cxDBEdit, cxCheckBox, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Vcl.StdCtrls, cxTextEdit, cxMemo, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmDocumentStatesDlg = class(TSWNMasteredFormClass)
    IBCQuerySysS: TIBCQuery;
    IBCDataSourceSysS: TIBCDataSource;
    Label1: TLabel;
    Label2: TLabel;
    cxDBMemo1: TcxDBMemo;
    Button1: TButton;
    Button2: TButton;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    IBCQueryDocStates: TIBCQuery;
    IBCDataSourceDocStates: TIBCDataSource;
    IBCTrLocalUpdate: TIBCTransaction;
    cxDBCheckBox1: TcxDBCheckBox;
    cxReminderDate: TcxDBDateEdit;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_UID: TcxGridDBColumn;
    cxGrid1DBTableView1_DATA: TcxGridDBColumn;
    cxGrid1DBTableView1_USER: TcxGridDBColumn;
    cxGrid1DBTableView1_STATUS: TcxGridDBColumn;
    cxGrid1DBTableView1_ESTIMATE_FINISH: TcxGridDBColumn;
    cxGrid1DBTableView1_REAL_FINISH: TcxGridDBColumn;
    procedure cxDBLookupComboBox1PropertiesChange(Sender: TObject);
  private
    fCurrentStatus: integer;
    procedure SetCurrentStatus(const Value: integer);
    { Private declarations }
  protected
    procedure Prepare;override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CurrentStatus: integer read fCurrentStatus write SetCurrentStatus;
  end;

var
  frmDocumentStatesDlg: TfrmDocumentStatesDlg;

implementation

uses
  System.DateUtils;

{$R *.dfm}

{ TfrmDocumentStatesDlg }

procedure TfrmDocumentStatesDlg.cxDBLookupComboBox1PropertiesChange(Sender: TObject);
var
  DefaultSysSMinutes: integer;
begin
  if Visible then
  begin
    IBCQueryDocStates.Edit;
      // + valoarea in minute din syss din syss
    DefaultSysSMinutes := 0;
    if IBCQuerySysS.FieldByName('VALUE_INT').AsInteger>0 then
      DefaultSysSMinutes := IBCQuerySysS.FieldByName('VALUE_INT').AsInteger;

    IBCQueryDocStates.FieldByName('REMINDER').AsDateTime := Now + (DefaultSysSMinutes/1440);
  end;
end;

function TfrmDocumentStatesDlg.IsFormDataPosted: Boolean;
begin
  try
  if IBCQueryDocStates.State in [dsEdit, dsInsert] then
    IBCQueryDocStates.Post;

    Result := True;
  except on e: Exception
  do
  begin
     Result := False;
     raise;
  end;
  end;
end;

procedure TfrmDocumentStatesDlg.Prepare;
begin
  IBCQuerySysS.Close;
  IBCQuerySysS.Open;

  IBCQueryDocStates.Close;
  IBCQueryDocStates.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
  IBCQueryDocStates.Open;

  IBCQueryDocStates.Append;
  IBCQueryDocStates.FieldByName('FLG_REMINDER').AsInteger := 0;
end;

procedure TfrmDocumentStatesDlg.SetCurrentStatus(const Value: integer);
begin
  fCurrentStatus := Value;
end;

procedure TfrmDocumentStatesDlg.WhenCancelForm;
begin
  IBCQueryDocStates.Cancel;
end;

end.
