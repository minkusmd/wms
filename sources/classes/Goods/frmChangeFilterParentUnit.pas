unit frmChangeFilterParentUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, SWNBaseUnit,
  System.Generics.Collections, Data.DB, MemDS, DBAccess, IBC, DataModuleDB;

type
  TfrmChangeFilterParentDialog = class(TSWNCustomForm)
    teFilterID: TcxTextEdit;
    Label1: TLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    { Private declarations }
  protected
    function CheckParams: boolean;
    procedure DoChangeFilterID;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    FFilterIDValue: Integer;
    FilterParamList: TObjectList<TFilterParamsList>;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmChangeFilterParentDialog: TfrmChangeFilterParentDialog;

implementation

{$R *.dfm}

function TfrmChangeFilterParentDialog.CheckParams: boolean;
var
  ErrorStr: string;
begin
  Result := True;
  ErrorStr := '';

  if StrToIntDef(teFilterID.Text, -1) = -1 then
  begin
    ErrorStr := 'Eroare! Introduceri un cod corect!';
    result := False;
  end;
end;

constructor TfrmChangeFilterParentDialog.Create(AOwner: TComponent);
begin
  inherited;
  FilterParamList := TObjectList<TFilterParamsList>.Create();
end;

destructor TfrmChangeFilterParentDialog.Destroy;
begin
  FilterParamList.Free;
  inherited;
end;

procedure TfrmChangeFilterParentDialog.DoChangeFilterID;
var
  I: Integer;
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  Query.Transaction := dmdb.IBCTrDefaultUpdate;
  Query.SQL.Text := 'EXECUTE PROCEDURE SP_CHANGE_FILTERID(:NEWFILTERID, :FILTERPARAMID)';
  Query.Prepare;
  try
    for I := 0 to FilterParamList.Count-1 do
    begin
       Query.ParamByName('newfilterid').AsString := teFilterID.Text;
       Query.ParamByName('filterparamid').AsInteger := FilterParamList[i].FilterParamID;
       Query.Execute;
    end;

    Query.Transaction.Commit;
  finally
    Query.Free;
  end;
end;

{ TfrmChangeFilterParentDialog }

function TfrmChangeFilterParentDialog.IsFormDataPosted: Boolean;
begin
  Result := True;

  if not CheckParams then
  begin
      Result := False;
     exit;
  end;

  DoChangeFilterID;
end;

procedure TfrmChangeFilterParentDialog.Prepare;
begin
  teFilterID.Text := FFilterIDValue.ToString;
end;

end.
