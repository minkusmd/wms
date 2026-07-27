unit frmDocumentDeleteDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, IBC,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMemo, StdCtrls, DialogTitle, dxUIAClasses;

type
  TfrmDocumentDeleteDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    Label1: TLabel;
    mmReason: TcxMemo;
    btnYes: TButton;
    btnNo: TButton;
  private
    { Private declarations }
    fDocID: integer;
    fDoNotAsk: Boolean;
    fTransaction: TIBCTransaction;
    procedure SetDocID(const Value: integer);

    function CheckValues:Boolean;
    procedure SaveToLog;
    procedure SetDoNotAsk(const Value: Boolean);
    procedure SetTransaction(const Value: TIBCTransaction);

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DocID:integer read FDocID write SetDocID;
    property DoNotAsk:Boolean read FDoNotAsk write SetDoNotAsk;
    property Transaction:TIBCTransaction read FTransaction write SetTransaction;
  end;


  function DeleteCurrentSWNDocument(const Sender:TComponent):Boolean;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB, SWNDBErrors;

{$R *.dfm}


function DeleteCurrentSWNDocument(const Sender:TComponent):Boolean;
var dialog:TfrmDocumentDeleteDlg;
begin
     Result:=False;
     dialog:=TfrmDocumentDeleteDlg.Create(Sender);
     try
        dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
        dialog.DocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.Transaction:=dmDB.IBCQueryDocs.UpdateTransaction;

        if dialog.ShowModal=mrOk then
        try
           dmDB.IBCQueryDocs.Delete;
           dmDB.IBCQueryDocs.UpdateTransaction.Commit;
           Result:=True;
        except on E:Exception do
            begin
                  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
            end;
        end
        else dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
     finally
        dialog.Free;
     end;
end;

{ TfrmDocumentDeleteDlg }

function TfrmDocumentDeleteDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if Trim(mmReason.Text)='' then AddErrorToStr(ErrorStr,'Indicati cauza stergerii documentului!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmDocumentDeleteDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          SaveToLog;
          Result:=True;
     end;
end;

procedure TfrmDocumentDeleteDlg.Prepare;
begin
     dtDialogTitle.Text:=Format('Doriti sa stergeti documentul ¹%d?',[FDocID]);
end;

procedure TfrmDocumentDeleteDlg.SaveToLog;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fTransaction;
        Query.SQL.Add('INSERT INTO TLOG_DOCS (DOCID, USERID, DESCRIPTION)');
        Query.SQL.Add('VALUES (:DOCID, :USERID, :text)');
        Query.ParamByName('DOCID').AsInteger:=fDocID;
        Query.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
        Query.ParamByName('text').AsString:=Format('Cauza stergerii documentului: %s',[Trim(mmReason.Text)]);
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmDocumentDeleteDlg.SetDocID(const Value: integer);
begin
     fDocID := Value;
end;

procedure TfrmDocumentDeleteDlg.SetDoNotAsk(const Value: Boolean);
begin
     fDoNotAsk := Value;
end;

procedure TfrmDocumentDeleteDlg.SetTransaction(const Value: TIBCTransaction);
begin
     fTransaction := Value;
end;

end.
