unit uwgetThread;

interface

uses
  System.Classes;

type
  TwgetThread = class(TThread)
  private
    { Private declarations }
    fResult: Integer;
  protected
    procedure Execute; override;
    procedure Sync;
  public
    constructor Create(CreateSuspended: boolean);
  end;

implementation

{ TwgetThread }

constructor TwgetThread.Create(CreateSuspended: boolean);
begin
    inherited Create(CreateSuspended);
end;

procedure TwgetThread.Execute;
begin
  { Place thread code here }

end;

procedure TwgetThread.Sync;
begin
   if fResult=1 then
    //Form1.meGoodURL.Lines.Add(fUrl);
   if fResult = 0 then
    //Form1.meBadURL.Lines.Add(fURL);

//  Form1.ProgressBar1.Position := Form1.ProgressBar1.Position + 1;

end;

end.
