unit SWNSecurityUtils;

interface

procedure SetAccessBit(var AccessMask: Int64; const BitIndex:integer; const Value:Boolean = True);
function CreateHashPassword(const TextPassword: String):String;
function GetSampleMD5(const text:String):String;

implementation

uses wms_md5hash;


procedure SetAccessBit(var AccessMask: Int64; const BitIndex:integer; const Value:Boolean = True);
var bitval:int64;
begin
     bitval:=1;
     bitval:=bitval shl BitIndex;
     if Value then AccessMask:=AccessMask or bitval
     else
     if (AccessMask and bitval)=bitval then AccessMask:=AccessMask - bitval;
end;

function CreateHashPassword(const TextPassword: String):String;
begin
     Result:=GetSampleMD5(TextPassword);
end;

function GetSampleMD5(const text:String):String;
var S:RawByteString;
    digest:TMD5Digest;
begin
     S:=UTF8Encode(text);
     digest:=MD5Buffer(S[1],Length(S));
     Result:=MD5DigestToStr(digest);
end;

end.
