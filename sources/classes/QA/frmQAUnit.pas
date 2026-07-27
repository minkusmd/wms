unit frmQAUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
// TSWNBaseFormClass
  TfrmQADlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    lbQuestion: TLabel;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    Button1: TButton;
    Button2: TButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
  private
    FQuestionText: string;
    procedure SetQuestionText(const Value: string);
    { Private declarations }
  protected
   procedure Prepare; override;
  public
    property QuestionText: string read FQuestionText write SetQuestionText;
    { Public declarations }
  end;

var
  frmQADlg: TfrmQADlg;

implementation

uses
   DataModuleAdditions;

{$R *.dfm}

procedure TfrmQADlg.Prepare;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fIBCConnection;
    Query.SQL.Clear;
    Query.SQL.Add('select * from ts_questions where id = :ID');
    Query.ParamByName('ID').AsInteger := 1;
    Query.Open;
    lbQuestion.Caption := Query.FieldByName('TITLE').AsString;
  finally
     Query.Free;
  end;
end;

procedure TfrmQADlg.SetQuestionText(const Value: string);
begin
   FQuestionText := Value;
end;

end.
