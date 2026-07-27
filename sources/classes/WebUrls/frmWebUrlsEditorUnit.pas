unit frmWebUrlsEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.StdCtrls, cxCheckBox, cxDBEdit, cxTextEdit, Vcl.ExtCtrls, DialogTitle;

type
  TfrmWebUrlsEditorDialog = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBTextEdit4: TcxDBTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWebUrlsEditorDialog: TfrmWebUrlsEditorDialog;

implementation

uses
  DataModuleAdditions;

{$R *.dfm}

end.
