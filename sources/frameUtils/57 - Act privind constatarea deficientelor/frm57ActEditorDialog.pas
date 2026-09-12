unit frm57ActEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, IBC,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Vcl.ExtCtrls, DialogTitle, cxMemo, cxDBEdit, cxLabel;

type
  Tfrm57ActEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxLabel5: TcxLabel;
    teActNo: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    teIncidentID: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxLabel4: TcxLabel;
    cxDBMemo2: TcxDBMemo;
    cxLabel3: TcxLabel;
    cxDBMemo3: TcxDBMemo;
    cxLabel2: TcxLabel;
    cxDBMemo4: TcxDBMemo;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    fFileName: string;
    fFileChanged:Boolean;

    procedure SaveData;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure UpdateFileDataToDB;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DB, DataModuleDB;

{ TForm2 }



function Tfrm57ActEditorDlg.IsFormDataPosted: Boolean;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Post;

  fMasterDataSet.UpdateTransaction.Commit;

  Result := True;
end;

procedure Tfrm57ActEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
             dtDialogTitle.Text:='Modificare act';
             fMasterDataSet.Edit;
             fFileChanged:=False;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;


procedure Tfrm57ActEditorDlg.SaveData;
begin
if fMasterDataSet.State in [dsEdit, dsInsert] then
  begin
    fMasterDataSet.Post;
    try
      if fMasterDataSet.UpdateTransaction.Active then
         fMasterDataSet.UpdateTransaction.Commit;
     except on E:Exception do
           begin
                fMasterDataSet.UpdateTransaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;

    end;
  end;
end;

procedure Tfrm57ActEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure Tfrm57ActEditorDlg.UpdateFileDataToDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='UPDATE TDB_DOCS_ATTACHMENTS SET FILEDATA=:DATA WHERE ATTID=:ID';
        Query.ParamByName('ID').AsInteger:=fMasterDataSet.FieldByName('ATTID').AsInteger;
        Query.ParamByName('DATA').LoadFromFile(fFileName,ftBlob);
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure Tfrm57ActEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
