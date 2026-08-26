unit uSelectDateDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCalendars, Vcl.StdCtrls;

type
  TfrmSelectDateDialog = class(TForm)
    CalendarView1: TCalendarView;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DateInputDialog(var Date: TDate): Boolean;
var
  frmSelectDateDialog: TfrmSelectDateDialog;

implementation

{$R *.dfm}

function DateInputDialog(var Date: TDate): Boolean;
begin
   frmSelectDateDialog := TfrmSelectDateDialog.Create(Application);
   try
      frmSelectDateDialog.CalendarView1.Date := Date;
      Result := False;
      if frmSelectDateDialog.ShowModal = mrOk then
      begin
        Date := frmSelectDateDialog.CalendarView1.Date;
        Result := True;
      end;
   finally
     frmSelectDateDialog.Free;
   end;
end;

end.
