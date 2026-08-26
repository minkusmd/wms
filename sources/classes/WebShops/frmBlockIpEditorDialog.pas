unit frmBlockIpEditorDialog;

(* ============================================================================
   Editor pentru o intrare din lista de IP-uri blocate (TWEB_BLOCKED_IP).

   Nu este legat la dataset: aduna valorile in proprietati, iar scrierea in baza
   o face managerul (frmBlockedIpDialog), pentru ca EXPIRES_AT este calculat din
   optiunea de durata aleasa aici, nu introdus direct.

   Durata: permanent (EXPIRES_AT = NULL), N minute, sau pana la o data anume.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxSpinEdit, cxCheckBox,
    cxRadioGroup, cxButtons, cxLabel, dxScrollbarAnnotations;

type
    TfrmBlockIpEditorDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        lbIp: TLabel;
        lbReason: TLabel;
        lbNote: TLabel;
        edIp: TcxTextEdit;
        edReason: TcxTextEdit;
        edNote: TcxTextEdit;
        rgDuration: TcxRadioGroup;
        seMinutes: TcxSpinEdit;
        deUntil: TcxDateEdit;
        lbMinutes: TLabel;
        lbUntil: TLabel;
        chkWhitelist: TcxCheckBox;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure rgDurationPropertiesChange(Sender: TObject);
        procedure chkWhitelistPropertiesChange(Sender: TObject);
    private
        FCreateNewItem: Boolean;
        FIpAddress: string;
        FReason: string;
        FNote: string;
        FIsWhitelist: Boolean;
        FExpiresAt: TDateTime; { 0 = permanent }
        procedure UpdateControlsState;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
        property IpAddress: string read FIpAddress write FIpAddress;
        property Reason: string read FReason write FReason;
        property Note: string read FNote write FNote;
        property IsWhitelist: Boolean read FIsWhitelist write FIsWhitelist;
        property ExpiresAt: TDateTime read FExpiresAt write FExpiresAt;
    end;

{ Validare IPv4 / IPv6 (forma simpla, suficienta pentru introducere manuala). }
function IsValidIpAddress(const S: string): Boolean;

implementation

{$R *.dfm}

const
    cDur_Permanent = 0;
    cDur_Minutes   = 1;
    cDur_UntilDate = 2;

function IsValidIpV4(const S: string): Boolean;
var
    parts: TArray<string>;
    i, v, code: Integer;
begin
    Result := False;
    parts := S.Split(['.']);
    if Length(parts) <> 4 then
        Exit;
    for i := 0 to 3 do
    begin
        if (parts[i] = '') or (Length(parts[i]) > 3) then
            Exit;
        Val(parts[i], v, code);
        if (code <> 0) or (v < 0) or (v > 255) then
            Exit;
    end;
    Result := True;
end;

function IsValidIpV6(const S: string): Boolean;
var
    parts: TArray<string>;
    i, j, groups, emptyCnt: Integer;
    p: string;
begin
    Result := False;
    if Pos(':', S) = 0 then
        Exit;
    parts := S.Split([':']);
    if (Length(parts) < 3) or (Length(parts) > 8) then
        Exit;
    groups := 0;
    emptyCnt := 0;
    for i := 0 to High(parts) do
    begin
        p := parts[i];
        if p = '' then
        begin
            Inc(emptyCnt);
            Continue;
        end;
        if Length(p) > 4 then
            Exit;
        for j := 1 to Length(p) do
            if not CharInSet(p[j], ['0'..'9', 'a'..'f', 'A'..'F']) then
                Exit;
        Inc(groups);
    end;
    { cel putin un grup valid; grupurile goale vin din notatia "::" }
    Result := (groups > 0) and (emptyCnt <= 3);
end;

function IsValidIpAddress(const S: string): Boolean;
var
    t: string;
begin
    t := Trim(S);
    if t = '' then
        Exit(False);
    if Pos(':', t) > 0 then
        Result := IsValidIpV6(t)
    else
        Result := IsValidIpV4(t);
end;

{ TfrmBlockIpEditorDlg }

procedure TfrmBlockIpEditorDlg.Prepare;
begin
    if FCreateNewItem then
    begin
        dtDialogTitle.Text := 'Adaugare IP in lista de blocare';
        if FReason = '' then
            FReason := 'Blocat manual din WMS';
    end
    else
        dtDialogTitle.Text := 'Modificare blocare IP';

    edIp.Text := FIpAddress;
    edReason.Text := FReason;
    edNote.Text := FNote;
    chkWhitelist.Checked := FIsWhitelist;

    if FExpiresAt = 0 then
        rgDuration.ItemIndex := cDur_Permanent
    else
    begin
        rgDuration.ItemIndex := cDur_UntilDate;
        deUntil.Date := FExpiresAt;
    end;

    if seMinutes.Value = 0 then
        seMinutes.Value := 15;
    if deUntil.Date = 0 then
        deUntil.Date := Now + 1;

    edIp.Enabled := FCreateNewItem;
    UpdateControlsState;
end;

procedure TfrmBlockIpEditorDlg.UpdateControlsState;
var
    wl: Boolean;
begin
    wl := chkWhitelist.Checked;
    { pentru whitelist durata nu are sens - intrarea e permanenta }
    rgDuration.Enabled := not wl;
    seMinutes.Enabled := (not wl) and (rgDuration.ItemIndex = cDur_Minutes);
    deUntil.Enabled := (not wl) and (rgDuration.ItemIndex = cDur_UntilDate);
    lbMinutes.Enabled := seMinutes.Enabled;
    lbUntil.Enabled := deUntil.Enabled;
end;

procedure TfrmBlockIpEditorDlg.rgDurationPropertiesChange(Sender: TObject);
begin
    UpdateControlsState;
end;

procedure TfrmBlockIpEditorDlg.chkWhitelistPropertiesChange(Sender: TObject);
begin
    UpdateControlsState;
end;

function TfrmBlockIpEditorDlg.IsFormDataPosted: Boolean;
begin
    Result := False;

    FIpAddress := Trim(edIp.Text);
    if not IsValidIpAddress(FIpAddress) then
    begin
        ShowMessage('Adresa IP nu este valida. Exemple: 192.168.1.10 sau 2a02:2f0a::1');
        edIp.SetFocus;
        Exit;
    end;

    FReason := Trim(edReason.Text);
    FNote := Trim(edNote.Text);
    FIsWhitelist := chkWhitelist.Checked;

    if FIsWhitelist then
        FExpiresAt := 0 { whitelist = permanent }
    else
        case rgDuration.ItemIndex of
            cDur_Minutes:
                begin
                    if seMinutes.Value <= 0 then
                    begin
                        ShowMessage('Durata in minute trebuie sa fie mai mare ca zero.');
                        Exit;
                    end;
                    FExpiresAt := Now + (seMinutes.Value / (24 * 60));
                end;
            cDur_UntilDate:
                begin
                    if deUntil.Date <= Now then
                    begin
                        ShowMessage('Data de expirare trebuie sa fie in viitor.');
                        Exit;
                    end;
                    FExpiresAt := deUntil.Date;
                end;
        else
            FExpiresAt := 0; { permanent }
        end;

    Result := True;
end;

end.
