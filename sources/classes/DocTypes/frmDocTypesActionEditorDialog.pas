unit frmDocTypesActionEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  cxTextEdit, StdCtrls,
  ExtCtrls, DialogTitle, cxCheckBox, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus;

type
  TfrmDocTypesActionEditorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxTextEdit;
    cbAccessVisible: TcxCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    function GetTitle: String;
    procedure SetTitle(const Value: String);
    function CheckParams:Boolean;
    function GetFLG_ACCESS_VISIBLE: Boolean;
    procedure SetFLG_ACCESS_VISIBLE(const Value: Boolean);
  protected
    { protected declarations }
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property TITLE:String read GetTitle write SetTitle;
    property FLG_ACCESS_VISIBLE:Boolean read GetFLG_ACCESS_VISIBLE write SetFLG_ACCESS_VISIBLE;
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmDocTypesActionEditorDlg }

function TfrmDocTypesActionEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if Trim(edTITLE.Text)='' then AddErrorToStr(ErrorStr,'Название!');

     if ErrorStr='' then Result:=True
     else
     ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmDocTypesActionEditorDlg.GetFLG_ACCESS_VISIBLE: Boolean;
begin
     Result:=cbAccessVisible.Checked;
end;

function TfrmDocTypesActionEditorDlg.GetTitle: String;
begin
     Result:=Trim(edTITLE.Text);
end;

function TfrmDocTypesActionEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams
      then Result:=True
      else Result:=False;
end;

procedure TfrmDocTypesActionEditorDlg.SetFLG_ACCESS_VISIBLE(const Value: Boolean);
begin
     cbAccessVisible.Checked:=Value;
end;

procedure TfrmDocTypesActionEditorDlg.SetTitle(const Value: String);
begin
     edTITLE.Text:=Value;
end;

end.
