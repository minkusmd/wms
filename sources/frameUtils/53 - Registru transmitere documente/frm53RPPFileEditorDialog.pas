unit frm53RPPFileEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, IBC,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Vcl.ExtCtrls, DialogTitle;

type
  Tfrm53RPPFileEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beFile: TcxButtonEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure beFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    fFileName: string;
    fFileChanged:Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure DisplayFileInfo;
    function CheckValues:Boolean;
    procedure UpdateFileDataToDB;
    procedure LoadFile;
    function GetFileSize(const FileName:String):int64;

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

uses DataModuleAdditions, SWNUtils, SWNConst, DB;

{ TForm2 }

procedure Tfrm53RPPFileEditorDlg.beFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     LoadFile;
end;

function Tfrm53RPPFileEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=false;
     ErrorStr:='';

     if fFileChanged then
     begin
          if fMasterDataSet.FieldByName('FILENAME').IsNull or (fFileName='') then AddErrorToStr(ErrorStr,'Selectati fisierul!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure Tfrm53RPPFileEditorDlg.DisplayFileInfo;
begin
     if fMasterDataSet.FieldByName('FILENAME').IsNull then beFile.Text:=''
     else
     begin
          beFile.Text:=Format('%s [%d bytes]',[fMasterDataSet.FieldByName('FILENAME').AsString,fMasterDataSet.FieldByName('FILESIZE').AsInteger]);
     end;
end;

function Tfrm53RPPFileEditorDlg.GetFileSize(const FileName: String): int64;
var sr: TSearchRec;
begin
     Result:=0;
     if FindFirst(FileName, faAnyFile, sr) = 0 then
     begin
          Result:=sr.Size;
     end;
     FindClose(sr);
end;

function Tfrm53RPPFileEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          if fFileChanged then UpdateFileDataToDB;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure Tfrm53RPPFileEditorDlg.LoadFile;
var dialog:TFileOpenDialog;
begin
     dialog:=TFileOpenDialog.Create(Self);
     try
        if dialog.Execute then
        begin
             fFileName:=dialog.FileName;
             fMasterDataSet.FieldByName('FILENAME').AsString:=ExtractFileName(dialog.FileName);
             fMasterDataSet.FieldByName('FILESIZE').AsInteger:=GetFileSize(dialog.FileName);
             DisplayFileInfo;
             fFileChanged:=True;
        end;
     finally
       dialog.Free;
     end;
end;

procedure Tfrm53RPPFileEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Creare fisier nou';
             fFileChanged:=True;
             fMasterDataSet.Insert;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare fisier';
             fMasterDataSet.Edit;
             fFileChanged:=False;
        end;
        DisplayFileInfo;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure Tfrm53RPPFileEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure Tfrm53RPPFileEditorDlg.UpdateFileDataToDB;
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

procedure Tfrm53RPPFileEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
