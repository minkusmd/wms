unit frmCreateCustomNareadSborkaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxTextEdit, DB, DBAccess, IBC, MemDS, Vcl.Menus, cxButtons;

type
  TfrmCreateCustomNareadSborkaDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    rbCurrentFirma: TRadioButton;
    rbCustomFirma: TRadioButton;
    edCurrentFirma: TcxTextEdit;
    lcbFirms: TcxLookupComboBox;
    IBCQueryFirms: TIBCQuery;
    IBCDataSourceFirms: TIBCDataSource;
    btnOk: TcxButton;
    Button2: TcxButton;
    procedure rbCurrentFirmaClick(Sender: TObject);
  private
    fIsCustomFirma: Boolean;
    fCustomFirma: integer;
    { Private declarations }
    function CheckInputParams:Boolean;
    procedure SaveValues;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property IsCustomFirma:Boolean read fIsCustomFirma;
    property CustomFirma:integer read fCustomFirma;
  end;



implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TForm2 }

function TfrmCreateCustomNareadSborkaDlg.CheckInputParams: Boolean;
var Errors:TStringList;
begin
     Result:=False;
     Errors:=TStringList.Create;
     try

        if (not rbCurrentFirma.Checked) and (Not rbCustomFirma.Checked) then Errors.Add('Nu este selectat asamblatorul!');
        if rbCustomFirma.Checked and (VarIsNull(lcbFirms.EditValue) or (lcbFirms.EditValue<=0)) then Errors.Add('Alta firma!');

        if Errors.Count=0 then Result:=True
        else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors.Text);

     finally
        Errors.Free;
     end;
end;

function TfrmCreateCustomNareadSborkaDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          SaveValues;
          Result:=True;
     end;
end;

procedure TfrmCreateCustomNareadSborkaDlg.Prepare;
begin
     edCurrentFirma.Text:=dmDB.CurrentFirmaName;
     edCurrentFirma.Enabled:=false;
     lcbFirms.Enabled:=false;
     fIsCustomFirma:=false;

     IBCQueryFirms.ParamByName('firma').AsInteger:=dmDb.CurrentFirma;
     IBCQueryFirms.Active:=True;
end;

procedure TfrmCreateCustomNareadSborkaDlg.rbCurrentFirmaClick(Sender: TObject);
begin
     edCurrentFirma.Enabled:=rbCurrentFirma.Checked;
     lcbFirms.Enabled:=rbCustomFirma.Checked;
end;

procedure TfrmCreateCustomNareadSborkaDlg.SaveValues;
begin
     fIsCustomFirma:=rbCustomFirma.Checked;
     if rbCustomFirma.Checked
       then fCustomFirma:=lcbFirms.EditValue
       else fCustomFirma:=dmDB.CurrentFirma;
end;

end.
