unit frmManualAttributeValueDialog;

(* Introducere MANUALA a unei valori de atribut, direct pe produs
   (TS_GOODS_ATTRIBUTE), fara legatura cu dictionarul TS_ATTRIBUTE_VALUE.
   Returneaza textul introdus (ValueRo/ValueRu); daca RU e gol se preia RO. *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxButtons;

type
    TfrmManualAttributeValueDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        edVALUE_RO: TcxTextEdit;
        edVALUE_RU: TcxTextEdit;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure edVALUE_ROExit(Sender: TObject);
    private
        FAttrName: string;
        FValueRo: string;
        FValueRu: string;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        property AttrName: string read FAttrName write FAttrName;
        property ValueRo: string read FValueRo write FValueRo;
        property ValueRu: string read FValueRu write FValueRu;
    end;

implementation

{$R *.dfm}

{ TfrmManualAttributeValueDlg }

procedure TfrmManualAttributeValueDlg.Prepare;
begin
    dtDialogTitle.Text := 'Valoare pentru atributul: ' + FAttrName;
    edVALUE_RO.Text := FValueRo;
    edVALUE_RU.Text := FValueRu;
end;

procedure TfrmManualAttributeValueDlg.edVALUE_ROExit(Sender: TObject);
begin
    { daca valoarea RU e goala, se preia automat textul din RO }
    if (Trim(edVALUE_RU.Text) = '') and (Trim(edVALUE_RO.Text) <> '') then
        edVALUE_RU.Text := edVALUE_RO.Text;
end;

function TfrmManualAttributeValueDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if Trim(edVALUE_RO.Text) = '' then
    begin
        ShowMessage('Introduceti valoarea RO.');
        Exit;
    end;
    FValueRo := Trim(edVALUE_RO.Text);
    FValueRu := Trim(edVALUE_RU.Text);
    if FValueRu = '' then
        FValueRu := FValueRo;
    Result := True;
end;

end.
