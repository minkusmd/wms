unit frmSchedulerDaemonUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxStyles, cxEdit, cxScheduler,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerAgendaView, cxSchedulerDateNavigator,
  cxSchedulerHolidays, cxSchedulerTimeGridView, cxSchedulerUtils,
  cxSchedulerWeekView, cxSchedulerYearView, cxSchedulerGanttView,
  cxSchedulerRecurrence, dxBarBuiltInMenu, cxSchedulerTreeListBrowser,
  cxSchedulerRibbonStyleEventEditor;

type
  TfrmSchedulerDaemon = class(TForm)
    cxScheduler1: TcxScheduler;
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    procedure BindStorage;
  end;

var
  frmSchedulerDaemon: TfrmSchedulerDaemon;

implementation

uses
    DataModuleDB;

{$R *.dfm}

{ TForm3 }

procedure TfrmSchedulerDaemon.BindStorage;
begin
  cxScheduler1.Storage := dmdb.cxSchedulerDBStorage;
  cxScheduler1.Visible := False;
  cxScheduler1.Align := alNone;
end;

procedure TfrmSchedulerDaemon.CreateParams(var Params: TCreateParams);
begin
  inherited;
   // делаем «служебное» окно: без бордюров, не показывается в таскбаре
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
  Params.WndParent := Application.Handle;      // привязываем к приложению
end;

end.
