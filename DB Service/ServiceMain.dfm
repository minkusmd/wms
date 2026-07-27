object ServiceSWN: TServiceSWN
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  AllowPause = False
  DisplayName = 'SWN DB Service'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 319
  Width = 541
end
