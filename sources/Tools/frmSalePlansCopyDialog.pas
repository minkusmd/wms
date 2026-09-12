unit frmSalePlansCopyDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridLevel, cxGrid, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmSalePlansCopyDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxGridSLevel: TcxGridLevel;
    cxGridS: TcxGrid;
    cxGridT: TcxGrid;
    cxGridTLevel: TcxGridLevel;
    cxGridSTable: TcxGridTableView;
    cxGridTTable: TcxGridTableView;
    cxGridS_MONTHSTR: TcxGridColumn;
    cxGridS_YEAR: TcxGridColumn;
    cxGridT_MONTHSTR: TcxGridColumn;
    cxGridT_YEAR: TcxGridColumn;
    cxGridS_DATE: TcxGridColumn;
    cxGridT_DATE: TcxGridColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    FSelectedDate: TDateTime;
    fMaxDateTime: TDateTime;
    procedure SetSelectedDate(const Value: TDateTime);
    procedure ReadDates;
    procedure PrepareFutureDates;
    function GetSourceData: TDateTime;
    function GetTargetData: TDateTime;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    property SelectedDate: TDateTime read FSelectedDate write SetSelectedDate;
    property SourceData: TDateTime read GetSourceData;
    property TargetData: TDateTime read GetTargetData;
  end;

implementation

uses
  DataModuleAdditions, IBC, DataModuleDB, DateUtils, SWNUpdateClientDBClass,
  SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmSalePlansCopyDlg }

function TfrmSalePlansCopyDlg.GetSourceData: TDateTime;
begin
  if Assigned(cxGridSTable.Controller.FocusedRow) then
  begin
    Result := cxGridSTable.Controller.FocusedRow.Values[cxGridS_DATE.Index];
  end
  else
    Result := 0;
end;

function TfrmSalePlansCopyDlg.GetTargetData: TDateTime;
begin
  if Assigned(cxGridTTable.Controller.FocusedRow) then
  begin
    Result := cxGridTTable.Controller.FocusedRow.Values[cxGridT_DATE.Index];
  end
  else
    Result := 0;
end;

function TfrmSalePlansCopyDlg.IsFormDataPosted: Boolean;
begin
  if Assigned(cxGridSTable.Controller.FocusedRow) and Assigned(cxGridTTable.Controller.FocusedRow) then
  begin
    Result := True;
  end
  else
  begin
    ShowErrorDialog(cMSG_GeneralInputError_Title, 'Selectati datele corespunzatoare!');
    Result := False;
  end;
end;

procedure TfrmSalePlansCopyDlg.Prepare;
begin
  ReadDates;
  PrepareFutureDates;
end;

procedure TfrmSalePlansCopyDlg.PrepareFutureDates;
var
  D: TDateTime;
  i, N: integer;
begin
  D := fMaxDateTime;
  cxGridTTable.BeginUpdate;
  try
    for i := 1 to 12 do
    begin
      D := IncMonth(D, 1);

      N := cxGridTTable.DataController.AppendRecord;
      cxGridTTable.DataController.Values[N, cxGridT_DATE.Index] := D;
      cxGridTTable.DataController.Values[N, cxGridT_YEAR.Index] := YearOf(D);
      cxGridTTable.DataController.Values[N, cxGridT_MONTHSTR.Index] := FormatDateTime('mmmm', D);
    end;
  finally
    cxGridTTable.EndUpdate;
  end;
  cxGridTTable.DataController.Groups.FullExpand;
end;

procedure TfrmSalePlansCopyDlg.ReadDates;
var
  Query: TIBCQuery;
  N: integer;
  D: TDateTime;
begin
  fMaxDateTime := 0;
  cxGridSTable.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT DISTINCT ' + 'EXTRACT(MONTH FROM DATA),EXTRACT(YEAR FROM DATA) ' + 'FROM TDB_BUGET_VINZARI ORDER BY DATA DESC';
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridSTable.DataController.AppendRecord;
      cxGridSTable.DataController.Values[N, cxGridS_YEAR.Index] := Query.Fields[1].AsInteger;
      D := EncodeDate(Query.Fields[1].AsInteger, Query.Fields[0].AsInteger, 1);
      cxGridSTable.DataController.Values[N, cxGridS_DATE.Index] := D;
      cxGridSTable.DataController.Values[N, cxGridS_MONTHSTR.Index] := FormatDateTime('mmmm', D);

      if (D > fMaxDateTime) then
        fMaxDateTime := D;

      Query.Next;
    end;
  finally
    Query.Free;
    cxGridSTable.EndUpdate;
  end;
  cxGridSTable.DataController.Groups.FullExpand;
end;

procedure TfrmSalePlansCopyDlg.SetSelectedDate(const Value: TDateTime);
begin
  FSelectedDate := Value;
end;

end.

