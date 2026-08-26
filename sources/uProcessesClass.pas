unit uProcessesClass;

interface
uses Classes;
function FillProcessesList(var slProcesses: TStringList): Boolean;

implementation

uses Windows, SysUtils, PsAPI;

procedure EnableDebugPrivileges; // Получить привилегии отладчика
var
  hToken: THandle;
  tp: TTokenPrivileges;
  DebugNameValue: Int64;
  ret: Cardinal;
begin
  OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken); // Получаем маркер доступа текущего процесса
  // Получаем значение отладочных привилегий

  LookupPrivilegeValue(nil,'SeDebugPrivilege',DebugNameValue);
  tp.PrivilegeCount := 1; // Включаем отладочные привилегии
  tp.Privileges[0].Luid := DebugNameValue;
  tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

  // Применяем обновленные привилегии
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end;


procedure DisableDebugPrivileges; // Отключить привилегии отладчика
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
  tp.Privileges[0].Attributes := 0; // Отключаем отладочные привилегии
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end;
// Используем ANSI версию функции GetProcessImageFileName
function GetProcessImageFileName(hProcess: THandle; lpFilename: PAnsiChar;
                                 nSize: DWORD): DWORD; stdcall;
                                 external 'psapi.dll'
                                 name 'GetProcessImageFileNameA';

// Получаем список процессов и заполняем им TStringList
function FillProcessesList(var slProcesses: TStringList): Boolean;
const
  INCREMENTAL_SIZE = 64; // шаг изменения размера массива aProcessIds
var
  aProcessIds: array of DWORD; // Динамический массив для PID'ов
  iSize: Cardinal; // количесво элементов массива aProcessIds
  dwBytesReturned: DWORD; // количество байт, возвращенных EnumProcesses
  iProcessesCount: Integer; // количество PID'ов в массиве aProcessIds
  i: Integer;  // счетчик цикла
  hProcess: THandle; // дескриптор открытого процесса
  sBaseName: array [0..MAX_PATH] of Char; // Буферы для строк
  sFileName: array [0..MAX_PATH] of Char;
  sImageFileName: array [0..MAX_PATH] of Char;
  sOut: String; // строка для добавления в TStringList
  fFound: boolean;
begin
  Result := False;
  if slProcesses = nil then Exit; // Проверяем кооректность параметра
  EnableDebugPrivileges; // Включаем отладочные привилегии
  iSize := 0; // инициируем размер массива
  repeat
    inc(iSize, INCREMENTAL_SIZE); // увеличиваем размер массива
    SetLength(aProcessIds,iSize); // устанавливаем новый размер массива
    if not EnumProcesses(@aProcessIds[0], //заполняем массив PID'ами
                         iSize * SizeOf(DWORD), //размер массива в байтах
                         dwBytesReturned) then Exit; //возращенные байты
  until dwBytesReturned < (iSize * SizeOf(DWORD)); // если буфера мало, то снова
  // Считаем количество процессов в массиве
  iProcessesCount := dwBytesReturned div SizeOf(DWORD);
  // Получаем в цикле инфу для каждого элемента массива
  fFound := false;
  for i := 0 to iProcessesCount-1 do
  begin
       sOut := '';
    // Открываем процесс по PID'у с флагами для получения информации
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

      CloseHandle(hProcess);  // Обязательно закрываем процесс
    end;
    if length(sout)>0 then
    slProcesses.Add(UpperCase(sOut)); // Добавляем строчку в TStringList
  end;
  SetLength(aProcessIds,0); // Освобождаем память
  DisableDebugPrivileges; // Отключаем отладочные привилегии

  Result := FFound; // Функция выполнилась успешно
end;



end.
