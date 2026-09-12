unit frmATehnoStockResultDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmATehnoStockResultDlg = class(TForm)
    pnButtons: TPanel;
    btnClose: TcxButton;
    lbCodeCaption: TLabel;
    lbCode: TLabel;
    lbTitleCaption: TLabel;
    lbTitle: TLabel;
    lbStatusCaption: TLabel;
    lbStatus: TLabel;
    lbLocationsCaption: TLabel;
    lbLocations: TListBox;
    lbLink: TLabel;
    procedure lbLinkClick(Sender: TObject);
  private
    FProductURL: string;
  public
    procedure ShowStockInfo(const ACode, ATitle, AStatusText, AStatusClass, AURL: string;
      ALocations: TStrings);
  end;

implementation

uses ShellApi;

{$R *.dfm}

procedure TfrmATehnoStockResultDlg.ShowStockInfo(const ACode, ATitle, AStatusText, AStatusClass, AURL: string;
  ALocations: TStrings);
begin
  lbCode.Caption := ACode;

  if ATitle <> '' then
    lbTitle.Caption := ATitle
  else
    lbTitle.Caption := '-';

  if AStatusText <> '' then
    lbStatus.Caption := AStatusText
  else
    lbStatus.Caption := '-';

  if AStatusClass = 'product-available' then
    lbStatus.Font.Color := clGreen
  else if AStatusClass = 'product-only-order' then
    lbStatus.Font.Color := $000080FF
  else if AStatusClass = 'product-not-available' then
    lbStatus.Font.Color := clRed
  else
    lbStatus.Font.Color := clWindowText;

  lbLocations.Items.Clear;
  if Assigned(ALocations) and (ALocations.Count > 0) then
  begin
    lbLocations.Items.Assign(ALocations);
    lbLocationsCaption.Caption := 'Disponibil pentru ridicare din:';
  end
  else
  begin
    lbLocations.Items.Add('Nu este disponibil pentru ridicare din niciun magazin.');
    lbLocationsCaption.Caption := 'Ridicare din magazin:';
  end;

  FProductURL := Trim(AURL);
  lbLink.Visible := FProductURL <> '';
end;

procedure TfrmATehnoStockResultDlg.lbLinkClick(Sender: TObject);
begin
  if FProductURL <> '' then
    ShellExecute(0, 'open', PChar(FProductURL), nil, nil, SW_SHOWNORMAL);
end;

end.
