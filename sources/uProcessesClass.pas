unit uProcessesClass;

interface
uses Classes;
function FillProcessesList(var slProcesses: TStringList): Boolean;

implementation

uses Windows, SysUtils, PsAPI;

procedure EnableDebugPrivileges; // Obtine privilegiile de debug
var
  hToken: THandle;
  tp: TTokenPrivileges;
  DebugNameValue: Int64;
  ret: Cardinal;
begin
  OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken); // Obtinem markerul de acces al procesului curent
  // Obtinem valoarea privilegiilor de debug

  LookupPrivilegeValue(nil,'SeDebugPrivilege',DebugNameValue);
  tp.PrivilegeCount := 1; // Activam privilegiile de debug
  tp.Privileges[0].Luid := DebugNameValue;
  tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

  // Aplicam privilegiile actualizate
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end;


procedure DisableDebugPrivileges; // Dezactiveaza privilegiile de debug
var
  hToken: THandle;
  tp: TTokenPrivileges;
  DebugNameValue: Int64;
  ret: Cardinal;
begin
  OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken);
  LookupPrivilegeValue(nil,'SeDebugPrivilege',DebugNameValue);
  tp.PrivilegeCount := 1;
  tp.Privileges[0].Luid := DebugNameValue;
  tp.Privileges[0].Attributes := 0; // Dezactivam privilegiile de debug
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end;
// Folosim versiunea ANSI a functiei GetProcessImageFileName
function GetProcessImageFileName(hProcess: THandle; lpFilename: PAnsiChar;
                                 nSize: DWORD): DWORD; stdcall;
                                 external 'psapi.dll'
                                 name 'GetProcessImageFileNameA';

// Obtinem lista proceselor si completam TStringList cu ea
function FillProcessesList(var slProcesses: TStringList): Boolean;
const
  INCREMENTAL_SIZE = 64; // pasul de modificare a dimensiunii array-ului aProcessIds
var
  aProcessIds: array of DWORD; // Array dinamic pentru PID-uri
  iSize: Cardinal; // numarul de elemente ale array-ului aProcessIds
  dwBytesReturned: DWORD; // numarul de octeti returnati de EnumProcesses
  iProcessesCount: Integer; // numarul de PID-uri in array-ul aProcessIds
  i: Integer;  // contorul buclei
  hProcess: THandle; // descriptorul procesului deschis
  sBaseName: array [0..MAX_PATH] of Char; // Buffere pentru siruri
  sFileName: array [0..MAX_PATH] of Char;
  sImageFileName: array [0..MAX_PATH] of Char;
  sOut: String; // sirul de adaugat in TStringList
  fFound: boolean;
begin
  Result := False;
  if slProcesses = nil then Exit; // Verificam corectitudinea parametrului
  EnableDebugPrivileges; // Activam privilegiile de debug
  iSize := 0; // initializam dimensiunea array-ului
  repeat
    inc(iSize, INCREMENTAL_SIZE); // marim dimensiunea array-ului
    SetLength(aProcessIds,iSize); // setam noua dimensiune a array-ului
    if not EnumProcesses(@aProcessIds[0], //completam array-ul cu PID-uri
                         iSize * SizeOf(DWORD), //dimensiunea array-ului in octeti
                         dwBytesReturned) then Exit; //octetii returnati
  until dwBytesReturned < (iSize * SizeOf(DWORD)); // daca buffer-ul e mic, incercam din nou
  // Numaram procesele din array
  iProcessesCount := dwBytesReturned div SizeOf(DWORD);
  // Obtinem in bucla info pentru fiecare element din array
  fFound := false;
  for i := 0 to iProcessesCount-1 do
  begin
       sOut := '';
    // Deschidem procesul dupa PID cu flag-uri pentru obtinerea informatiei
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
                            False, aProcessIds[i]);
    if hProcess <> 0 then
    begin
      if GetModuleBaseName(hProcess,0,@sBaseName,SizeOf(sBaseName)) > 0 then
        sOut := sBaseName;

      if UpperCase(SBaseName)= 'SWNSS.EXE' then
        fFound := true
      else
        if UpperCase(SBaseName)= 'DW.EXE' then
           fFound := true
        else
           if UpperCase(SBaseName)= 'COLLABMAN.EXE' then
           fFound := true;

      CloseHandle(hProcess);  // Inchidem obligatoriu procesul
    end;
    if length(sout)>0 then
    slProcesses.Add(UpperCase(sOut)); // Adaugam randul in TStringList
  end;
  SetLength(aProcessIds,0); // Eliberam memoria
  DisableDebugPrivileges; // Dezactivam privilegiile de debug

  Result := FFound; // Functia s-a executat cu succes
end;



end.
