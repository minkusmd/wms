unit frmWebStaticPageEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit, Vcl.StdCtrls, Vcl.ExtCtrls, cxMemo,
  cxCheckBox, Vcl.Buttons, dxBarBuiltInMenu, cxLabel, cxPC, SynEdit, SynEditHighlighter, SynHighlighterHtml,
  SynHighlighterPHP;

type
  TfrmWebStaticPageEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label5: TLabel;
    edPAGEID: TcxDBTextEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    Label7: TLabel;
    Label6: TLabel;
    cxPageControl1: TcxPageControl;
    cxTabSheet2: TcxTabSheet;
    cxLabel1: TcxLabel;
    teTitleRO: TcxDBTextEdit;
    teTitleRU: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    teDescRO: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    teDescRU: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    teKeysRO: TcxDBTextEdit;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    teKeysRU: TcxDBTextEdit;
    cxTabSheet3: TcxTabSheet;
    cxPageControl2: TcxPageControl;
    cxTabSheet4: TcxTabSheet;
    cxTabSheet5: TcxTabSheet;
    Label1: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    Label3: TLabel;
    Label2: TLabel;
    edTITLE_ROM: TcxDBTextEdit;
    Label4: TLabel;
    SynHTMLSyn1: TSynHTMLSyn;
    mmBODY_RUS: TSynEdit;
    mmBODY_ROM: TSynEdit;
    procedure sbInsertIMGClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    function IsPageIDValid(const PageID:String):Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DB, SWNUtils, SWNConst;

{ TForm2 }

function TfrmWebStaticPageEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('PAGEID').IsNull or (fMasterDataSet.FieldByName('PAGEID').AsString='') or (Not IsPageIDValid(fMasterDataSet.FieldByName('PAGEID').AsString))
       then AddErrorToStr(ErrorStr,'Идентификатор страницы!');

     if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('TITLE_RUS').AsString='')
       then AddErrorToStr(ErrorStr,'Название страницы!');
     if fMasterDataSet.FieldByName('TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('TITLE_ROM').AsString='')
       then AddErrorToStr(ErrorStr,'Denumirea paginei!');
     if fMasterDataSet.FieldByName('BODY_RUS').IsNull or (fMasterDataSet.FieldByName('BODY_RUS').AsString='')
       then AddErrorToStr(ErrorStr,'Содержание страницы!');
     if fMasterDataSet.FieldByName('BODY_ROM').IsNull or (fMasterDataSet.FieldByName('BODY_ROM').AsString='')
       then AddErrorToStr(ErrorStr,'Conținutul paginei!');

     if (ErrorStr='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmWebStaticPageEditorDlg.BindingDataSource;
begin
     edPAGEID.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_ENABLED.DataBinding.DataSource:=fMasterDataSource;
     edTITLE_RUS.DataBinding.DataSource:=fMasterDataSource;
     edTITLE_ROM.DataBinding.DataSource:=fMasterDataSource;
     teTitleRO.DataBinding.DataSource:=fMasterDataSource;
     teTitleRU.DataBinding.DataSource:=fMasterDataSource;
     teDescRO.DataBinding.DataSource:=fMasterDataSource;
     teDescRU.DataBinding.DataSource:=fMasterDataSource;
     teKeysRO.DataBinding.DataSource:=fMasterDataSource;
     teKeysRU.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmWebStaticPageEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;

     fMasterDataSet.Edit;

     fMasterDataSet.FieldByName('BODY_RUS').AsString := mmBODY_RUS.Text;
     fMasterDataSet.FieldByName('BODY_ROM').AsString := mmBODY_ROM.Text;

     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

function TfrmWebStaticPageEditorDlg.IsPageIDValid(const PageID: String): Boolean;
var i:integer;
begin
     Result:=True;
     for i := 1 to length(PageID) do
     if Not CharInSet(PageID[i],['0'..'9','a'..'z']) then
     begin
          Result:=False;
          Break;
     end;
end;

procedure TfrmWebStaticPageEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Crearea unei pagini noi';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger:=0;
             mmBODY_ROM.Lines.Clear;
             mmBODY_RUS.Lines.Clear;
        end
        else
        begin
             dtDialogTitle.Text:='Modificarea paginei';
             fMasterDataSet.Edit;

             mmBODY_RUS.Lines.Text := fMasterDataSet.FieldByName('BODY_RUS').AsString;
             mmBODY_ROM.Lines.Text := fMasterDataSet.FieldByName('BODY_ROM').AsString;

        end;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmWebStaticPageEditorDlg.sbInsertIMGClick(Sender: TObject);
//var control:TcxDBMemo;
begin
//     control:=mmBODY_RUS;
//     if mmBODY_ROM.Focused then control:=mmBODY_ROM;
//
//     case TSpeedButton(Sender).Tag of
//     1: begin
//             // insert <P>
//             control.SelText:=Format('<p>%s</p>'#13#10,[control.SelText]);
//        end;
//     2: begin
//             // insert <DIV>
//             control.SelText:=Format('<div>%s</div>'#13#10,[control.SelText]);
//        end;
//     3: begin
//             // insert <IMG>
//             control.SelText:='<img src="images/..." alt="" />'#13#10;
//        end;
//     end;
end;

procedure TfrmWebStaticPageEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmWebStaticPageEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
