unit caTimer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
Dialogs,
  ExtCtrls, MMSystem;

type
  TcaTimer = class;


//---------------------------------------------------------------------------
  // TcaTimerThread

//---------------------------------------------------------------------------
  TcaTimerThread = class(TThread)
  private
    FTimer: TcaTimer;
  protected
    procedure DoExecute;
  public
    constructor CreateTimerThread(Timer: TcaTimer);
    procedure Execute; override;
  end;


//---------------------------------------------------------------------------
  // TcaTimer

//---------------------------------------------------------------------------
  TcaTimer = class(TComponent)
  private
    FInterval: Integer;
    FPriority: TThreadPriority;
    FOnTimer: TNotifyEvent;
    FContinue: Boolean;
    FRunning: Boolean;
    FEnabled: Boolean;
    procedure SetEnabled(Value: Boolean );
  protected
    procedure StartTimer;
    procedure StopTimer;
    property Continue: Boolean read FContinue write FContinue;
  public
    constructor Create(Owner: TComponent); override;
    procedure On;
    procedure Off;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Interval: Integer read FInterval write FInterval;
    property ThreadPriority: TThreadPriority read FPriority write
FPriority default tpNormal;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('System', [TcaTimer]);
end;

//-----------------------------------------------------------------------------
// TcaTimerThread
//-----------------------------------------------------------------------------
constructor TcaTimerThread.CreateTimerThread(Timer: TcaTimer);
begin
  inherited Create(True);
  FTimer := Timer;
  FreeOnTerminate := True;
end;

procedure TcaTimerThread.Execute;
var
  SleepTime, Last: Integer;
begin
  while FTimer.Continue do
    begin
      Last := timeGetTime;
      Synchronize(DoExecute);
      SleepTime := FTimer.FInterval - (timeGetTime - Last);
      if SleepTime < 10 then SleepTime := 10;
      Sleep(SleepTime);
    end;
end;

procedure TcaTimerThread.DoExecute;
begin
  if Assigned(FTimer.OnTimer) then FTimer.OnTimer(FTimer);
end;

//-----------------------------------------------------------------------------
// TcaTimer
//-----------------------------------------------------------------------------
constructor TcaTimer.Create(Owner: TComponent);
begin
  inherited;
  FPriority := tpNormal;
end;

procedure TcaTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
    begin
      FEnabled := Value;
      if FEnabled then
        StartTimer
      else
        StopTimer;
    end;
end;

procedure TcaTimer.StartTimer;
begin
  if FRunning then Exit;
  FContinue := True;
  if not (csDesigning in ComponentState) then
    begin
      with TcaTimerThread.CreateTimerThread(Self) do
        begin
          Priority := FPriority;
          Resume;
        end;
    end;
  FRunning := True;
end;

procedure TcaTimer.StopTimer;
begin
  FContinue := False;
  FRunning := False;
end;

procedure TcaTimer.On;
begin
  StartTimer;
end;

procedure TcaTimer.Off;
begin
  StopTimer;
end;

end.

