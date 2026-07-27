unit frmDocTypesViewCodeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, fs_ipascal, fs_synmemo, SWNBaseUnit;

type
  TfrmDocTypesViewCodeDialog = class(TSWNCustomForm)
    fsSyntaxMemo1: TfsSyntaxMemo;
    fsPascal1: TfsPascal;
    bbSaveToFile: TcxButton;
    bbClose: TcxButton;
    procedure bbSaveToFileClick(Sender: TObject);
  private
    fGeneratedLines: TStrings;
    procedure SetGeneratedLines(const Value: TStrings);
    { Private declarations }
  protected
    procedure prepare; override;
  public
    { Public declarations }
    property GeneratedLines: TStrings read fGeneratedLines write SetGeneratedLines;
  end;

var
  frmDocTypesViewCodeDialog: TfrmDocTypesViewCodeDialog;

implementation

{$R *.dfm}

procedure TfrmDocTypesViewCodeDialog.bbSaveToFileClick(Sender: TObject);
begin
    with TSaveDialog.Create(self) do
     begin
          FileName:='TS_DocTypes_Const.txt';
          if Execute then fsSyntaxMemo1.Lines.SaveToFile(FileName);
     end;
end;

procedure TfrmDocTypesViewCodeDialog.prepare;
begin
  inherited;
  fsSyntaxMemo1.Lines := GeneratedLines;
end;

procedure TfrmDocTypesViewCodeDialog.SetGeneratedLines(const Value: Tstrings);
begin
  fGeneratedLines := Value;
end;

end.
