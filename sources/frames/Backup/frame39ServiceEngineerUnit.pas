unit frame39ServiceEngineerUnit;
{
 (39) ÑÅÐÂÈÑ - Èíæèíåð ñåðâèñà
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, SWNBaseFrameUnit, ComCtrls,
  ExtCtrls, cxStyles, DBAccess, IBC, MemDS, cxCheckListBox, cxDBCheckListBox, StdCtrls, cxContainer, cxTextEdit, cxMemo,
  cxDBEdit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxEdit, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Data.DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid;

type
  Tframe39ServiceEngineer = class(TSWNBaseFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    cxGridTasksTable: TcxGridDBTableView;
    cxGridTasksLevel: TcxGridLevel;
    cxGridTasks: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    IBCQueryTasks: TIBCQuery;
    IBCDataSourceTasks: TIBCDataSource;
    cxGridTasksTable_I_TYPE_TITLE: TcxGridDBColumn;
    cxGridTasksTable_I_DATA: TcxGridDBColumn;
    cxGridTasksTable_I_DATA_ESTIMATED_FINISH: TcxGridDBColumn;
    cxGridTasksTable_IID: TcxGridDBColumn;
    cxDBMemo1: TcxDBMemo;
    Label15: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    clbFLAGS_COMPLECT: TcxDBCheckListBox;
    cxDBMemo2: TcxDBMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    edSN: TcxDBTextEdit;
    edGOODS_MODEL: TcxDBTextEdit;
    Label8: TLabel;
    edDATA: TcxDBTextEdit;
    Label9: TLabel;
    edDATA_FINISHED: TcxDBTextEdit;
    cxGridCalls: TcxGrid;
    cxGridCallsDBTableView: TcxGridDBTableView;
    cxGridCallsDB_CALL_TIME: TcxGridDBColumn;
    cxGridCallsDB_PHONE: TcxGridDBColumn;
    cxGridCallsDB_CALL_RESULT_TEXT: TcxGridDBColumn;
    cxGridCallsDB_COMMENTS: TcxGridDBColumn;
    cxGridCallsLevel: TcxGridLevel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarButton3: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    IBCQueryIncident: TIBCQuery;
    IBCDataSourceIncident: TIBCDataSource;
  private
    { Private declarations }
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow; override;
    procedure DoFrameHide; override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions;

{$R *.dfm}

{ Tframe39ServiceEngineer }

procedure Tframe39ServiceEngineer.DoFrameHide;
begin
  IBCQueryIncident.Active := False;
  IBCQueryTasks.Active := False;

  inherited;
end;

procedure Tframe39ServiceEngineer.DoFrameShow;
begin
  inherited;

  IBCQueryTasks.ParamByName('UserID').AsInteger := dmDb.CurrentUserID;
  IBCQueryTasks.Active := True;
  IBCQueryIncident.Active := True;
end;

function Tframe39ServiceEngineer.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe39ServiceEngineer.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

function Tframe39ServiceEngineer.InitFrameID: integer;
begin
  Result := 39; // SERVICE - Inginer service
end;

end.

