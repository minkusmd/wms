unit WebNewsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxTextEdit, StdCtrls, cxPC, OleCtrls, SHDocVw,
  cxMemo, cxClasses, dxBar, ImgList;

type
  TfrmWebNewsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    dePOSTEDTIME: TcxDBDateEdit;
    pcPageControl: TcxPageControl;
    tbsText: TcxTabSheet;
    tbsPreview: TcxTabSheet;
    mmTEXT: TcxDBMemo;
    wbWebBrowser: TWebBrowser;
    btnOk: TButton;
    btnCancel: TButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbBold: TdxBarButton;
    bbItalic: TdxBarButton;
    bbImage: TdxBarButton;
    bbUnderline: TdxBarButton;
    cxImageList1: TcxImageList;
    dxBarSubItem1: TdxBarSubItem;
    bbPreset1: TdxBarButton;
    bbPreset2: TdxBarButton;
    procedure pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure bbBoldClick(Sender: TObject);
    procedure bbItalicClick(Sender: TObject);
    procedure bbUnderlineClick(Sender: TObject);
    procedure bbPreset1Click(Sender: TObject);
    procedure bbPreset2Click(Sender: TObject);
  private
    { Private declarations }
    FCreateNewNews: Boolean;
    procedure SetCreateNewnews(const Value: Boolean);
  protected
    { protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

    function CheckValues:Boolean;
    procedure WBLoadHTML(const HTMLCode: string);
  public
    { Public declarations }
    property CreateNewNews:Boolean read FCreateNewnews write SetCreateNewnews;
  end;



implementation

uses DB, DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, MSHTML, ACTIVEX;

{$R *.dfm}

{ TfrmWebNewsEditorDlg }

procedure TfrmWebNewsEditorDlg.bbBoldClick(Sender: TObject);
var S:String;
begin
     S:=mmTEXT.SelText;
     if S<>'' then
     begin
          S:='<b>'+S+'</b>';
          mmTEXT.SelText:=S;
     end;
end;

procedure TfrmWebNewsEditorDlg.bbItalicClick(Sender: TObject);
var S:String;
begin
     S:=mmTEXT.SelText;
     if S<>'' then
     begin
          S:='<i>'+S+'</i>';
          mmTEXT.SelText:=S;
     end;
end;

procedure TfrmWebNewsEditorDlg.bbPreset1Click(Sender: TObject);
var S:String;
begin
     S:='<img src="" class="news_ImageLeft"><div>'+mmTEXT.Text+'</div>';
     if Not (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Edit;
     fMasterDataSet.FieldByName('TEXT').AsString:=S;
end;

procedure TfrmWebNewsEditorDlg.bbPreset2Click(Sender: TObject);
var S:String;
begin
     S:='<img src="" class="news_ImageRight"><div>'+mmTEXT.Text+'</div>';
     if Not (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Edit;
     fMasterDataSet.FieldByName('TEXT').AsString:=S;
end;

procedure TfrmWebNewsEditorDlg.bbUnderlineClick(Sender: TObject);
var S:String;
begin
     S:=mmTEXT.SelText;
     if S<>'' then
     begin
          S:='<u>'+S+'</u>';
          mmTEXT.SelText:=S;
     end;
end;

function TfrmWebNewsEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString)='')
      then AddErrorToStr(ErrorStr,'Stirea!');
     if fMasterDataSet.FieldByName('POSTEDTIME').IsNull then AddErrorToStr(ErrorStr,'Data si ora!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmWebNewsEditorDlg.InitValues;
begin
     FCreateNewnews := false;

     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     dePOSTEDTIME.DataBinding.DataSource:=fMasterDataSource;
     mmTEXT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmWebNewsEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckValues then
     begin
          if fMasterDataSet.State in dsEditModes then fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmWebNewsEditorDlg.pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet;
  var AllowChange: Boolean);
begin
     if (NewPage=tbsPreview) then
     begin
          if fMasterDataSet.State in dsEditModes then fMasterDataSet.Post;
          WBLoadHTML(fMasterDataSet.FieldByName('TEXT').AsString);
     end;
end;

procedure TfrmWebNewsEditorDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsText;

     wbWebBrowser.Navigate('about:blank') ;
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewnews then
        begin
             dtDialogTitle.Text:='Stire noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('POSTEDTIME').AsDateTime:=NOW;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare stire';
             fMasterDataSet.Edit;
        end;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmWebNewsEditorDlg.SetCreateNewnews(const Value: Boolean);
begin
     FCreateNewnews := Value;
end;

procedure TfrmWebNewsEditorDlg.WBLoadHTML(const HTMLCode: string);
var v: Variant;
    HTMLDocument: IHTMLDocument2;
    S:String;
begin
     S:='<head><style type="text/css">'+
        'body{font-family:Arial;font-size:12px;}'+
        '.news_ImageLeft{float:left;boder:0px none;margin-right:12px;}'+
        '.news_ImageRight{float:right;boder:0px none;margin-left:12px;}'+
        '</style></head><body>'+HTMLCode+'</body>';

     HTMLDocument := wbWebBrowser.Document as IHTMLDocument2;
     v := VarArrayCreate([0, 0], varVariant);
     v[0] := S; // Here's your HTML string
     HTMLDocument.Write(PSafeArray(TVarData(v).VArray));
     HTMLDocument.Close;
end;

procedure TfrmWebNewsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
