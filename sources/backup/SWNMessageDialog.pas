unit SWNMessageDialog;

interface

type

  TSWNMessageDialog = class
  private
    { private declarations }
    fVerificationFlag: Boolean;
    fIsVista: Boolean;

    procedure WhenTaskDialogVerifyClick(Sender:TObject);
  public
    { public declarations }
    constructor Create;

    procedure ShowErrorDlg(const Title:WideString; const Text:WideString=''; const ExpandedText:WideString=''; const FooterText:WideString='');
    function ShowAskDialog(const Title,Text:WideString; const InfoText:WideString=''):integer;
    function ShowAskDialogWithVerification(const Title,Text,VerificationText,InfoText:WideString):integer;
    procedure ShowWarningDialog(const Title,Text:WideString);
    procedure ShowInfoDialog(const Title,Text:WideString);
    procedure ShowInfoDialogVerification(const Title,Text,VerificationText:WideString);

    property VerificationFlag:Boolean read fVerificationFlag;
    property IsVista:Boolean read fIsVista;
  end;


implementation
Uses SysUtils, Controls, Dialogs, Themes;

{ TSWNMessageDialog }

constructor TSWNMessageDialog.Create;
begin
     fVerificationFlag:=False;
     // detect Vista
     fIsVista:=(Win32MajorVersion >= 6) and (Themes.ThemeServices.ThemesAvailable and Themes.ThemeServices.ThemesEnabled);
end;

function TSWNMessageDialog.ShowAskDialog(const Title, Text, InfoText: WideString): integer;
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
begin
     Result:=mrNo;
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; // Confirmare
             TaskDialog.MainIcon:=tdiShield;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.CommonButtons:=[tcbYes,tcbNo];
             TaskDialog.DefaultButton:=tcbNo;
             if InfoText<>'' then
             begin
                  TaskDialog.FooterText:=InfoText;
                  TaskDialog.FooterIcon:=tdiInformation;
             end;
             // show
             if TaskDialog.Execute then Result:=TaskDialog.ModalResult;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP, Others
          Result:=MessageDlg(Title+#13#10+#13#10+Text,mtConfirmation,[mbYes,mbNo],0);
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

function TSWNMessageDialog.ShowAskDialogWithVerification(const Title, Text, VerificationText, InfoText: WideString): integer;
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
    //btn:TTaskDialogBaseButtonItem;
begin
     Result:=mrNo;
     fVerificationFlag:=False;
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; // Confirmare
             TaskDialog.MainIcon:=tdiShield;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.CommonButtons:=[tcbYes,tcbNo];
             TaskDialog.DefaultButton:=tcbNo;
             if VerificationText<>'' then
             begin
                  TaskDialog.VerificationText:=VerificationText;
                  TaskDialog.OnVerificationClicked:=WhenTaskDialogVerifyClick;
             end;
             if InfoText<>'' then
             begin
                  TaskDialog.FooterText:=InfoText;
                  TaskDialog.FooterIcon:=tdiInformation;
             end;
             fVerificationFlag:=False;
             // show
             if TaskDialog.Execute then Result:=TaskDialog.ModalResult;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP, Others
          fVerificationFlag:=False;
          Result:=MessageDlg(Title+#13#10+#13#10+Text,mtConfirmation,[mbYes,mbNo],0);
          { TODO : Verification flag in XP }
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TSWNMessageDialog.ShowErrorDlg(const Title, Text, ExpandedText, FooterText: WideString);
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
    S:String;
begin
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; 'Eroare'
             TaskDialog.MainIcon:=tdiError;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.ExpandedText:=ExpandedText;
             TaskDialog.FooterText:=FooterText;
             TaskDialog.FooterIcon:=tdiInformation;
             TaskDialog.CommonButtons:=[tcbOk];
             // show
             TaskDialog.Execute;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP & others
          S:=Title+#13#10+#13#10+Text;
          if ExpandedText<>'' then S:=S+#13#10+#13#10+ExpandedText;
          MessageDlg(S,mtError,[mbOk],0);
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TSWNMessageDialog.ShowInfoDialog(const Title, Text: WideString);
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
begin
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; 'Eroare'
             TaskDialog.MainIcon:=tdiInformation;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.CommonButtons:=[tcbOk];
             // show
             TaskDialog.Execute;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP & others
          MessageDlg(Title+#13#10+#13#10+Text,mtInformation,[mbOk],0);
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TSWNMessageDialog.ShowInfoDialogVerification(const Title, Text, VerificationText: WideString);
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
begin
     fVerificationFlag:=False;
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; 'Eroare'
             TaskDialog.MainIcon:=tdiInformation;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.CommonButtons:=[tcbOk];
             if VerificationText<>'' then
             begin
                  TaskDialog.VerificationText:=VerificationText;
                  TaskDialog.OnVerificationClicked:=WhenTaskDialogVerifyClick;
             end;
             // show
             TaskDialog.Execute;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP & others
          fVerificationFlag:=False;
          MessageDlg(Title+#13#10+#13#10+Text,mtInformation,[mbOk],0);
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TSWNMessageDialog.ShowWarningDialog(const Title, Text: WideString);
{$WARN SYMBOL_PLATFORM OFF}
var TaskDialog: TTaskDialog;
begin
     if fIsVista then
     begin
          // VISTA styled
          TaskDialog:=TTaskDialog.Create(nil);
          try
             // setup
             TaskDialog.Caption:=' '; 'Eroare'
             TaskDialog.MainIcon:=tdiWarning;
             TaskDialog.Title:=Title;
             TaskDialog.Text:=Text;
             TaskDialog.CommonButtons:=[tcbOk];
             // show
             TaskDialog.Execute;
          finally
             TaskDialog.Free;
          end;
     end
     else
     begin
          // XP & others
          MessageDlg(Title+#13#10+#13#10+Text,mtWarning,[mbOk],0);
     end;
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TSWNMessageDialog.WhenTaskDialogVerifyClick(Sender: TObject);
begin
     fVerificationFlag:=Not fVerificationFlag; 
end;

end.
