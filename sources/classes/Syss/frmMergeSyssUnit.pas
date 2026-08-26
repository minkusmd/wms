unit frmMergeSyssUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, Vcl.StdCtrls, Vcl.ExtCtrls, RzPanel, RzDlgBtn, SWNBaseUnit,
  Vcl.NumberBox;

type
  TfrmMergeSyssDlg = class(TSWNBaseFormClass)
    RzDialogButtons1: TRzDialogButtons;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    nbOldElement: TNumberBox;
    nbNewElement: TNumberBox;
    edOldElementTitle: TEdit;
    edNewElementTitle: TEdit;
  private
    FOldID: Integer;
    function CheckParams: Boolean;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    property OldID: Integer read FOldID write FOldID;
    { Public declarations }
  end;

var
  frmMergeSyssDlg: TfrmMergeSyssDlg;

implementation

{$R *.dfm}

uses DataModuleDB;

{ TfrmMergeSyssDlg }

function TfrmMergeSyssDlg.IsFormDataPosted: boolean;
begin
  if CheckParams then
  begin

    dmdb.ExecuteQuery('EXECUTE PROCEDURE MERGE_SYSS(:OLDID, :NEWID)', [nbOldElement.Value,
      nbNewElement.Value]);

    result := True
  end;
end;

procedure TfrmMergeSyssDlg.Prepare;
begin
  inherited;
  nbOldElement.Value := 0;
  edOldElementTitle.Text := '';

  nbNewElement.Value := 0;
  edNewElementTitle.Text := '';
end;

procedure TfrmMergeSyssDlg.WhenCancelForm;
begin
  inherited;

end;

function TfrmMergeSyssDlg.CheckParams: Boolean;
var
  ErrorList: TStringList;
begin
  Result := false;
  ErrorList := TStringList.Create;
  try
    if nbOldElement.Value = 0 then
      ErrorList.Add('Nu ati ales codul elementului care va fi sters!');
    if nbNewElement.Value = 0 then
      ErrorList.Add('Nu ati ales codul elementului care va fi ramine in sistem!');

    result := (ErrorList.Count = 0);
  finally
    ErrorList.Free;
  end;
end;

end.
