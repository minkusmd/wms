unit frmWebGoodsSetHintUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls,
  cxContainer, cxEdit, DialogTitle, cxTextEdit, Vcl.StdCtrls, cxButtons, SWNBaseUnit,
  dxUIAClasses;

type
  TfrmWebGoodsSetHintDlg = class(TSWNBaseFormClass)
    Label1: TLabel;
    Label2: TLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    teHintRo: TcxTextEdit;
    teHintRu: TcxTextEdit;
    DialogTitle1: TDialogTitle;
    teHintRoUrl: TcxTextEdit;
    Label3: TLabel;
    teHintRuUrl: TcxTextEdit;
    Label4: TLabel;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
    HintRo: string;
    HintRu: string;
    HintRoUrl: string;
    HintRuUrl: string
  end;

//var
//  frmWebGoodsSetHintDlg: TfrmWebGoodsSetHintDlg;

implementation

uses
    DataModuleAdditions;

{$R *.dfm}

{ TfrmWebGoodsSetHintDlg }

function TfrmWebGoodsSetHintDlg.IsFormDataPosted: boolean;
begin
    HintRo := teHintRo.Text;
    HintRu := teHintRu.Text;
    HintRoUrl := teHintRoUrl.Text;
    HintRuUrl := teHintRuUrl.Text;
    Result := True;
end;

procedure TfrmWebGoodsSetHintDlg.Prepare;
begin
  inherited;
  teHintRo.Text :=  HintRo;
  teHintRu.Text := HintRu;
  teHintRoUrl.Text := HintRoUrl;
  teHintRuUrl.Text := HintRuUrl;
end;

end.
