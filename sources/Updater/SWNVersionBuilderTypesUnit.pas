unit SWNVersionBuilderTypesUnit;

interface
Uses Windows;

type

  TVersionFileHeader = record
    Title:array[1..25] of AnsiChar;
    CRC:DWORD;
    FileCount:integer;
  end;


  TCompressedFileInfo2 = class
  private
    fFileName: String;
    fCompressedSize: int64;
    fFileSize: int64;
    fDataOffset:int64;
  public
    { public declarations }
    constructor Create(const AFileName:String; const AFileSize, ACompressedSize, ADataOffset:int64);

    property FileName:String read fFileName;
    property FileSize:int64 read fFileSize;
    property CompressedSize:int64 read fCompressedSize;
    property DataOffset:int64 read fDataOffset;
  end;



implementation

{ TCompressedFileInfo2 }

constructor TCompressedFileInfo2.Create(const AFileName: String; const AFileSize, ACompressedSize, ADataOffset: int64);
begin
     fFileName:=AFileName;
     fFileSize:=AFileSize;
     fCompressedSize:=ACompressedSize;
     fDataOffset:=ADataOffset;
end;

end.
