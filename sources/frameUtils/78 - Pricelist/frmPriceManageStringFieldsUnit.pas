unit frmPriceManageStringFieldsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxMaskEdit, cxDropDownEdit, cxCheckBox, cxTextEdit, SWNBaseUnit;

type
  TfrmPriceManageStringFieldsDlg = class(TSWNCustomForm)
    teExcludeString: TcxTextEdit;
    cbExcludeString: TcxCheckBox;
    cmbFieldName: TcxComboBox;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Label1: TLabel;
    procedure cxCheckBox1PropertiesChange(Sender: TObject);
  private
    { Private declarations }
  protected
    function IsFormDataPosted: boolean; override;

  public
    FieldIndex: Integer;
    StringToReplace: string;
    { Public declarations }
  end;

var
  frmPriceManageStringFieldsDlg: TfrmPriceManageStringFieldsDlg;

implementation

{$R *.dfm}

procedure TfrmPriceManageStringFieldsDlg.cxCheckBox1PropertiesChange(
  Sender: TObject);
begin
  teExcludeString.Enabled := cbExcludeString.Checked;
end;

function TfrmPriceManageStringFieldsDlg.IsFormDataPosted: boolean;
begin
  Result := False;
  FieldIndex := cmbFieldName.ItemIndex;
  if cbExcludeString.Checked then begin
    StringToReplace := teExcludeString.Text;
    if Trim(StringToReplace) = '' then
      raise Exception.Create('Indicati textul pentru exludere!');
    Result := True;
  end
  else
  begin
    StringToReplace := '';
    Result := False;
  end;
end;

end.
