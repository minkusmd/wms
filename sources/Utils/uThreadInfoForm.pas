unit uThreadInfoForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls;

type
  TThreadInfoForm = class(TForm)
    pnlInfo: TPanel;
  private
    FTimer: TTimer;
    procedure TimerTick(Sender: TObject);
  public
    constructor CreateInfo(AOwner: TComponent;
                           const ACaption, AText: string); reintroduce;
    destructor Destroy; override;
  end;

// Procedura globală de apel
procedure ShowThreadInfo(const ACaption, AText: string;
                         AMilliseconds: Integer = 4000);

implementation

{ TThreadInfoForm }

constructor TThreadInfoForm.CreateInfo(AOwner: TComponent;
  const ACaption, AText: string);
begin
  inherited CreateNew(AOwner);

  // Proprietăți formă
  Caption      := ACaption;
  BorderStyle  := bsSingle;
  BorderIcons  := [];            // fără butoane min/max/close
  Width        := 380;
  Height       := 160;
  Position     := poScreenCenter;
  FormStyle    := fsStayOnTop;

  // Panel cu textul informativ
  pnlInfo := TPanel.Create(Self);
  pnlInfo.Parent     := Self;
  pnlInfo.Align      := alClient;
  pnlInfo.BevelOuter := bvNone;
  pnlInfo.Caption    := AText;
  pnlInfo.Font.Size  := 11;
  pnlInfo.Font.Color := clBlack;
  pnlInfo.Color      := clWhite;

  // Timer auto-close
  FTimer          := TTimer.Create(Self);
  FTimer.Interval := 4000;       // 2 secunde implicit
  FTimer.OnTimer  := TimerTick;
  FTimer.Enabled  := False;      // pornit după Show
end;

destructor TThreadInfoForm.Destroy;
begin
  FTimer.Free;
  inherited;
end;

procedure TThreadInfoForm.TimerTick(Sender: TObject);
begin
  FTimer.Enabled := False;
  Close;
end;

{ Procedura globală }

procedure ShowThreadInfo(const ACaption, AText: string;
  AMilliseconds: Integer = 4000);
var
  Frm: TThreadInfoForm;
begin
  Frm := TThreadInfoForm.CreateInfo(nil, ACaption, AText);
  try
    Frm.FTimer.Interval := AMilliseconds;
    Frm.Show;
    Frm.FTimer.Enabled := True;

    // Pompăm mesajele până forma se închide
    while Frm.Visible do
    begin
      Application.ProcessMessages;
      Sleep(10);
    end;
  finally
    Frm.Free;
  end;
end;

end.
