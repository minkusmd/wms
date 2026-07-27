unit frmWebPromoBrickLinkEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, Vcl.StdCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmWebPromoBrickLinkEditorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beURL: TcxButtonEdit;
    btnOk: TButton;
    btnCancel: TButton;
    lbGoodsInfo: TLabel;
    procedure beURLPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    function GetURL: String;
    procedure SetURL(const Value: String);
    function CheckValues:Boolean;
    procedure CreateLinkFromGoodsID(const GoodsIDStr:String);


  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    property URL:String read GetURL write SetURL;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNConst, SWNUtils, frmGoods, SWNValueStorageUnit;

{ TfrmWebPromoBrickLinkEditorDlg }

procedure TfrmWebPromoBrickLinkEditorDlg.beURLPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     CreateLinkFromGoodsID(beURL.Text);
end;

function TfrmWebPromoBrickLinkEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if Trim(beURL.Text)='' then AddErrorToStr(ErrorStr,'—сылка!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmWebPromoBrickLinkEditorDlg.CreateLinkFromGoodsID(const GoodsIDStr: String);
var ID:integer;
    goodsInfo:TGoodsWebInfoClass;
begin
     ID:=StrToIntDef(GoodsIDStr,-1);
     if (ID<=0) then
     begin
          ShowErrorDialog('Eroare','Introducerti corect codul produsului!');
          Exit;
     end;

     goodsInfo:=GetGoodsWebInfo(ID);
     if Assigned(goodsInfo) then
     begin
          try
             beURL.Text:=Format('http://www.fantastic.md/product.aspx?id=%d&sid=%d',[goodsInfo.GoodsID, goodsInfo.SecID]);
             lbGoodsInfo.Caption:=Format('%s %s %s %s',[goodsInfo.GoodsTypeNameRO,goodsInfo.VendorName,goodsInfo.CodeRO,goodsInfo.Details]);
          finally
             goodsInfo.Free;
          end;
     end
     else ShowErrorDialog('Eroare','Nu este informatie despre produs!');
end;

function TfrmWebPromoBrickLinkEditorDlg.GetURL: String;
begin
     Result:=Trim(beURL.Text);
end;

function TfrmWebPromoBrickLinkEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues;
end;

procedure TfrmWebPromoBrickLinkEditorDlg.LoadStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form position
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBrickLinkEditorDlg.Prepare;
begin
     lbGoodsInfo.Caption:='';
end;

procedure TfrmWebPromoBrickLinkEditorDlg.SaveStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form pos
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
          then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBrickLinkEditorDlg.SetURL(const Value: String);
begin
     beURL.Text:=Value;
end;

end.
