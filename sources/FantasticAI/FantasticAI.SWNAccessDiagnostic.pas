unit FantasticAI.SWNAccessDiagnostic;

interface

// Diagnostic only. Does not register an HTTP server or grant API access.
procedure WriteFantasticAccessDiagnostic(const AllowedFirms: array of Integer);

implementation

uses System.SysUtils, System.Classes, System.JSON, System.IOUtils,
  System.DateUtils, Winapi.Windows, Vcl.Dialogs, DataModuleDB, SWNSecurity;

procedure WriteFantasticAccessDiagnostic(const AllowedFirms: array of Integer);
const Prefix='--fantastic-ai-access-report=';
var Path:string; I,Actor,CurrentDT,Matches:Integer; CompanyAllowed,StockFlag,
  ProductModule,PartialAccess,Passed:Boolean; Report:TJSONObject;
  Handle:THandle; Stream:THandleStream; Bytes:TBytes;
begin
  Path:=''; Matches:=0;
  for I:=1 to ParamCount do
    if Copy(ParamStr(I),1,Length(Prefix))=Prefix then
    begin Inc(Matches); Path:=Copy(ParamStr(I),Length(Prefix)+1,MaxInt); end;
  if Matches=0 then Exit;
  Report:=nil; Handle:=INVALID_HANDLE_VALUE;
  try
    try
      if Matches<>1 then raise Exception.Create('ONE_REPORT_PATH_REQUIRED');
      if GetCurrentThreadId<>MainThreadID then raise Exception.Create('MAIN_THREAD_REQUIRED');
      if not TPath.IsPathRooted(Path) or (Copy(Path,1,2)='\\') or
        (Pos(#13,Path)>0) or (Pos(#10,Path)>0) then raise Exception.Create('LOCAL_ABSOLUTE_REPORT_PATH_REQUIRED');
      if not Assigned(dmDB) or not Assigned(SWNSecurityManager) or
        not Assigned(SWNSecurityManager.LoggedUser) then raise Exception.Create('AUTHENTICATED_ERP_SESSION_REQUIRED');
      Actor:=dmDB.CurrentUserID; CurrentDT:=dmDB.CurrentFirma;
      CompanyAllowed:=False;
      for I in AllowedFirms do if I=316910 then CompanyAllowed:=True;
      StockFlag:=SWNSecurityManager.UserHasSecurityFlag(1612);
      ProductModule:=SWNSecurityManager.UserHasSecurityFlag(1287);
      PartialAccess:=SWNSecurityManager.IsPartialAccessMode;
      Passed:=(Actor=204) and CompanyAllowed and StockFlag and not PartialAccess;
      Report:=TJSONObject.Create;
      if Passed then Report.AddPair('status','passed') else Report.AddPair('status','denied_for_pilot');
      Report.AddPair('generated_at',DateToISO8601(TTimeZone.Local.ToUniversalTime(Now),True));
      Report.AddPair('actual_erp_user_id',TJSONNumber.Create(Actor));
      Report.AddPair('expected_erp_user_id',TJSONNumber.Create(204));
      Report.AddPair('current_erp_firma',TJSONNumber.Create(CurrentDT));
      Report.AddPair('target_stock_dt',TJSONNumber.Create(316910));
      Report.AddPair('target_company_in_erp_firm_list',TJSONBool.Create(CompanyAllowed));
      Report.AddPair('security_flag_1612',TJSONBool.Create(StockFlag));
      Report.AddPair('security_flag_1287',TJSONBool.Create(ProductModule));
      Report.AddPair('partial_access_mode',TJSONBool.Create(PartialAccess));
      Report.AddPair('identity_source','dmDB.CurrentUserID / SWNSecurityManager.LoggedUser');
      Report.AddPair('company_source','MainForm.BuildFirmList / GET_FIRMS_BY_USER');
      Report.AddPair('acl_evidence_kind','existing_erp_session_cached_acl');
      Report.AddPair('real_time_revocation_verified',TJSONBool.Create(False));
      Report.AddPair('specific_goods_acl_verified',TJSONBool.Create(False));
      Report.AddPair('production_api_activated',TJSONBool.Create(False));
      Report.AddPair('cloud_connected',TJSONBool.Create(False));
      Handle:=CreateFile(PChar(Path),GENERIC_WRITE,0,nil,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,0);
      if Handle=INVALID_HANDLE_VALUE then raise Exception.Create('NEW_WRITABLE_REPORT_REQUIRED');
      Bytes:=TEncoding.UTF8.GetBytes(Report.Format(2));
      Stream:=THandleStream.Create(Handle);
      try Stream.WriteBuffer(Bytes[0],Length(Bytes)); finally Stream.Free; end;
      if Passed then ShowMessage('Fantastic AI: ERP session diagnostic passed. Report: '+Path)
      else ShowMessage('Fantastic AI: pilot access not confirmed. See report: '+Path);
    except
      // Never propagate a diagnostic error into ERP startup or expose raw errors.
      ShowMessage('Fantastic AI: diagnostic could not be completed. Use a new local report path and an authenticated ERP session.');
    end;
  finally Report.Free; if Handle<>INVALID_HANDLE_VALUE then CloseHandle(Handle); end;
end;

end.
