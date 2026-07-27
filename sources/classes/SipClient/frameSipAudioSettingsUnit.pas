unit frameSipAudioSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TframeSipAudioSettings = class(TFrame)
    Label16: TLabel;
    Image1: TImage;
    waveInDevice: TComboBox;
    waveOutDevice: TComboBox;
    Image2: TImage;
    Label17: TLabel;
    Image3: TImage;
    waveRingDevice: TComboBox;
    Label1: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetSipAudioSettings;
    procedure LoadSipAudioSettings;
    procedure SaveSipAudioSettings;
  end;

implementation

uses
  SWNValueStorageUnit, mmsystem;

{$R *.dfm}

{ TframeSipAudioSettings }

procedure TframeSipAudioSettings.FrameEnter(Sender: TObject);
begin
      LoadSipAudioSettings;
end;

procedure TframeSipAudioSettings.FrameExit(Sender: TObject);
begin
  SaveSipAudioSettings;
end;

procedure TframeSipAudioSettings.GetSipAudioSettings;
var
  DevOutCaps: TWaveOutCaps;
  DevInCaps: TWaveInCaps;
  n, i: Integer;
  s: String;
begin
  waveOutDevice.Items.Clear;
  waveOutDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveOutGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveOutGetDevCaps(i, @DevOutCaps, SizeOf(DevOutCaps));
    s := PChar(@DevOutCaps.szPname);
    waveOutDevice.Items.Add(s);
  end;
  waveInDevice.Items.Clear;
  waveInDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveInGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveInGetDevCaps(i, @DevInCaps, SizeOf(DevInCaps));
    s := PChar(@DevInCaps.szPname);
    waveInDevice.Items.Add(s);
  end;
  waveRingDevice.Items.Clear;
  waveRingDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveOutGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveOutGetDevCaps(i, @DevOutCaps, SizeOf(DevOutCaps));
    s := PChar(@DevOutCaps.szPname);
    waveRingDevice.Items.Add(s);
  end;

  waveOutDevice.ItemIndex := 0;
  waveInDevice.ItemIndex := 0;
  waveRingDevice.ItemIndex := 0;

end;

procedure TframeSipAudioSettings.Label1Click(Sender: TObject);
begin
  GetSipAudioSettings;
end;

procedure TframeSipAudioSettings.LoadSipAudioSettings;
begin
  waveInDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveInDevice', '');
  waveOutDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveOutDevice', '');
  waveRingDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveRingDevice', '');
end;

procedure TframeSipAudioSettings.SaveSipAudioSettings;
begin
  AppUserConfigStorage.TextValues.SetValue('WaveInDevice', waveInDevice.Text);
  AppUserConfigStorage.TextValues.SetValue('WaveOutDevice', waveOutDevice.Text);
  AppUserConfigStorage.TextValues.SetValue('WaveRingDevice', waveRingDevice.Text);
end;

end.
