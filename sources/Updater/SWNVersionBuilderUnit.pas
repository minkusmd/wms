unit SWNVersionBuilderUnit;

interface
Uses Classes;

type

  TSWNVersionBuilderProgressType = (ptStart, ptProgress, ptEnd);

  TSWNVersionBuilderProgressEvent = procedure (const ProgressType:TSWNVersionBuilderProgressType; const Value:integer) of Object;

  TCompressedFileInfo = class
  private
    fFileName: String;
    fCompressedSize: int64;
    fFileSize: int64;
    fData: TMemoryStream;
    fDataOffset:int64;
  public
    { public declarations }
    constructor Create(const AFileName:String; const AFileSize:int64);
    destructor Destroy;override;

    property FileName:String read fFileName;
    property FileSize:int64 read fFileSize;
    property CompressedSize:int64 read fCompressedSize;
    property Data:TMemoryStream read fData;
  end;


  TSWNVersionBuilder = class
  private
    FFileList: TStrings;
    FOnProgress: TSWNVersionBuilderProgressEvent;
    procedure SetFileList(const Value: TStrings);
    procedure SetOnProgress(const Value: TSWNVersionBuilderProgressEvent);
    { private declarations }
  protected
    { protected declarations }
    fCompressedFiles:TList;
    procedure ClearCompressedFiles;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property FileList:TStrings read FFileList write SetFileList;

    property OnProgress:TSWNVersionBuilderProgressEvent read FOnProgress write SetOnProgress;

    function BuildOutputStream(const OutStream:TMemoryStream):Boolean;

  end;



implementation
Uses Windows, SysUtils, SWNUtils, SWNVersionBuilderTypesUnit, SZCRC32;

{ TSWNVersionBuilder }

function TSWNVersionBuilder.BuildOutputStream(const OutStream: TMemoryStream): Boolean;
var i:integer;
    MS:TMemoryStream;
    compressedFileInfo:TCompressedFileInfo;
    header:TVersionFileHeader;
    title:AnsiString;
    N:integer;
    S:String;
begin
     Result:=false;
     OutStream.Clear;
     MS:=TMemoryStream.Create;
     try
        if Assigned(FOnProgress) then FOnProgress(ptStart,fFileList.Count);


        // 1. compress all given files
        for i := 0 to fFileList.Count - 1 do
        begin
             MS.LoadFromFile(fFileList[i]);

             compressedFileInfo:=TCompressedFileInfo.Create(fFileList[i],MS.Size);
             fCompressedFiles.Add(compressedFileInfo);

             CompressStream(MS,compressedFileInfo.fData);
             compressedFileInfo.fCompressedSize:=compressedFileInfo.fData.Size;

             if Assigned(FOnProgress) then FOnProgress(ptProgress,i+1);
        end;

        // 2. create common stream of data
        MS.Clear;
        for i := 0 to fCompressedFiles.Count - 1 do
        begin
             compressedFileInfo:=TCompressedFileInfo(fCompressedFiles[i]);
             compressedFileInfo.fDataOffset:=MS.Position;
             compressedFileInfo.fData.Position:=0;
             MS.CopyFrom(compressedFileInfo.fData,compressedFileInfo.fCompressedSize);
        end;

        // 3. create header in Output Stream
        title:='SWN 6. Version Data File.';
        CopyMemory(@header.Title[1],@title[1],SizeOf(header.Title));
        MS.Position:=0;
        header.CRC := SZCRC32FullStream(MS);
        header.FileCount:=fCompressedFiles.Count;
        OutStream.Write(header,SizeOf(TVersionFileHeader));

        // 4. create list of files in Output Stream
        for i := 0 to fCompressedFiles.Count - 1 do
        begin
             compressedFileInfo:=TCompressedFileInfo(fCompressedFiles[i]);
             // a. file name
             S:=ExtractFileName(compressedFileInfo.fFileName);
             N:=Length(S);
             OutStream.Write(N,SizeOf(Integer));
             OutStream.Write(S[1],SizeOf(Char)*N);
             // b. file size
             OutStream.Write(compressedFileInfo.fFileSize,SizeOf(Int64));
             // c. compressed file size
             OutStream.Write(compressedFileInfo.fCompressedSize,SizeOf(Int64));
             // d. data offset
             OutStream.Write(compressedFileInfo.fDataOffset,SizeOf(Int64));
        end;

        // 5. save all data in Output Stream
        MS.Position:=0;
        OutStream.CopyFrom(MS,MS.Size);

        if Assigned(FOnProgress) then FOnProgress(ptEnd,0);

        // done
        Result:=True;

     finally
        MS.Free;
        ClearCompressedFiles;
     end;
end;

procedure TSWNVersionBuilder.ClearCompressedFiles;
var i:integer;
begin
     for i := 0 to fCompressedFiles.Count - 1 do TCompressedFileInfo(fCompressedFiles[i]).Free;
     fCompressedFiles.Clear;
end;

constructor TSWNVersionBuilder.Create;
begin
     fFileList:=TStringList.Create;
     fCompressedFiles:=TList.Create;
     FOnProgress := nil;
end;

destructor TSWNVersionBuilder.Destroy;
begin
     try
        fFileList.Free;
        ClearCompressedFiles;
        fCompressedFiles.Free;
     finally
        inherited;
     end;
end;

procedure TSWNVersionBuilder.SetFileList(const Value: TStrings);
begin
     fFileList.Assign(Value);
end;

procedure TSWNVersionBuilder.SetOnProgress(const Value: TSWNVersionBuilderProgressEvent);
begin
     FOnProgress := Value;
end;

{ TCompressedFileInfo }

constructor TCompressedFileInfo.Create(const AFileName:String; const AFileSize:int64);
begin
     fFileName:=ExtractFileName(AFileName);
     fFileSize:=AFileSize;
     fCompressedSize:=0;
     fDataOffset:=0;

     fData:=TMemoryStream.Create;
end;

destructor TCompressedFileInfo.Destroy;
begin
     fData.Free;
     inherited;
end;


end.
