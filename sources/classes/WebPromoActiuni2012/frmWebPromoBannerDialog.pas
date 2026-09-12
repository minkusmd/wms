unit frmWebPromoBannerDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, Vcl.ExtCtrls, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxImage, Vcl.StdCtrls,
  cxCheckBox, Data.DB, DBAccess, IBC, MemDS, cxMaskEdit, cxDropDownEdit, cxCalc, dxBarBuiltInMenu, cxPC,
  SynEditHighlighter, SynHighlighterHtml, SynEdit, SynDBEdit, cxMemo,
  System.Actions, Vcl.ActnList;

type
  TfrmWebPromoBannerDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryBanner: TIBCQuery;
    IBCDataSourceBanner: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    Label1: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cxDBImage2: TcxDBImage;
    cxDBImage1: TcxDBImage;
    cbFLG_GOTO_BRICKS: TcxDBCheckBox;
    edNAV_URL: TcxDBTextEdit;
    edNAV_URL_RU: TcxDBTextEdit;
    lbl_RuSize: TLabel;
    cxTabSheet3: TcxTabSheet;
    cxDBImage6: TcxDBImage;
    Label13: TLabel;
    cxDBImage7: TcxDBImage;
    Label14: TLabel;
    lbl_RoSize: TLabel;
    cxTabSheet4: TcxTabSheet;
    SynHTMLSyn1: TSynHTMLSyn;
    cxDBImage8: TcxDBImage;
    cxDBImage9: TcxDBImage;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    Label18: TLabel;
    Label19: TLabel;
    Button1: TButton;
    ActionList1: TActionList;
    actGenerateURL: TAction;
    Label5: TLabel;
    Label6: TLabel;
    cxDBImage3: TcxDBImage;
    procedure actGenerateURLExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxDBImage1PropertiesChange(Sender: TObject);
    procedure cxTabSheet4Show(Sender: TObject);
    procedure IBCQueryBannerAfterPost(DataSet: TDataSet);
    procedure Label5Click(Sender: TObject);
  private
    FPromoActionID: integer;
    { Private declarations }
    procedure SetUpdateTransaction(const Value: TIBCTransaction);
    function CheckValues:Boolean;
    procedure SetPromoActionID(const Value: integer);
    procedure UpdateImageSize;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property PromoActionID:integer read FPromoActionID write SetPromoActionID;
    property UpdateTransaction:TIBCTransaction write SetUpdateTransaction;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, System.Math;

procedure TfrmWebPromoBannerDlg.actGenerateURLExecute(Sender: TObject);
begin
    IBCQueryBanner.FieldByName('NAV_URL').AsString := '/promo/'+PromoActionID.ToString;
    IBCQueryBanner.FieldByName('NAV_URL_RU').AsString := '/ru/promo/'+PromoActionID.ToString;
end;

procedure TfrmWebPromoBannerDlg.Button1Click(Sender: TObject);
begin

end;

{ TfrmWebPromoBannerDlg }

function TfrmWebPromoBannerDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if IBCQueryBanner.FieldByName('FLG_GOTO_BRICKS').AsInteger=0 then
     begin
          if IBCQueryBanner.FieldByName('FLG_GOTO_BRICKS').IsNull or (IBCQueryBanner.FieldByName('NAV_URL').AsString='')
            then AddErrorToStr(ErrorStr,'Alta adresa de redirectionare!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmWebPromoBannerDlg.cxDBImage1PropertiesChange(Sender: TObject);
begin
  UpdateImageSize;
end;

procedure TfrmWebPromoBannerDlg.cxTabSheet4Show(Sender: TObject);
begin
  SynEdit1.Lines.Text := IBCQueryBanner.FieldByName('description_ro').AsString;
  SynEdit2.Lines.Text := IBCQueryBanner.FieldByName('description_ru').AsString;
end;

procedure TfrmWebPromoBannerDlg.IBCQueryBannerAfterPost(DataSet: TDataSet);
begin
  UpdateImageSize;
end;

function TfrmWebPromoBannerDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          IBCQueryBanner.Edit;
          IBCQueryBanner.FieldByName('description_ro').AsString := SynEdit1.Lines.Text;
          IBCQueryBanner.FieldByName('description_ru').AsString := SynEdit2.Lines.Text;

          IBCQueryBanner.Post;
          IBCQueryBanner.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmWebPromoBannerDlg.Label5Click(Sender: TObject);
begin
  SynEdit1.LInes.Add('<div class="container">');
  SynEdit1.LInes.Add('<div class="row">');
  SynEdit1.LInes.Add('<p><h2>Video cartele Nvidia GeForce RTX 3080 / 3090!</h2></p>');
  SynEdit1.LInes.Add('<p>');
  SynEdit1.LInes.Add('<ul><b>La procurarea plăcii video Nvidia GeForce RTX 3080 / RTX 3090 în perioada promoției, primiți o cheie de activare pentru 4 jocuri:</b>');
  SynEdit1.LInes.Add('<li>Ghostwire: Tokyo</li>');
  SynEdit1.LInes.Add('<li>DOOM Eternal</li>');
  SynEdit1.LInes.Add('</ul>');
  SynEdit1.LInes.Add('<i><b>Prețul jocurilor = 129 USD</b>(Preț Steam)</i>');
  SynEdit1.LInes.Add('</p>');
  SynEdit1.LInes.Add('<p>');
  SynEdit1.LInes.Add('<ul><b>Termeni promoției:</b>');
  SynEdit1.LInes.Add('<li>Oferta este valabilă numai pentru bunurile care participă la promoție.</li>');
  SynEdit1.LInes.Add('<li>Perioada promoției 21.07.2022 - 25.08.2022</li>');
  SynEdit1.LInes.Add('<li>Numai persoane fizice</li>');
  SynEdit1.LInes.Add('<li>Promoția 0% | 12 luni este valabilă</li>');
  SynEdit1.LInes.Add('<li>Perioada de creditare 12 luni</li>');
  SynEdit1.LInes.Add('</ul>');
  SynEdit1.LInes.Add('</p>');
  SynEdit1.LInes.Add('');
  SynEdit1.LInes.Add('<div>');
  SynEdit1.LInes.Add('</div>');


  SynEdit2.Lines.Add('<div class="container">');
  SynEdit2.Lines.Add('<div class="row">');
  SynEdit2.Lines.Add('<p><h2>Placi video Nvidia GeForce 3080 /3090!</h2></p>');
  SynEdit2.Lines.Add('<p>');
  SynEdit2.Lines.Add('<ul><b>La cumpararea placilor video Nvidia GeForce RTX 3080 / RTX 3090 in perioada actiunii, primesti cheie de activare pentru 4 jocuri:</b>');
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('<li>Ghostwire: Tokyo</li>');
  SynEdit2.Lines.Add('<li>DOOM Eternal</li>');
  SynEdit2.Lines.Add('</ul>');
  SynEdit2.Lines.Add('<i><b>Costul jocurilor = $129 USD </b>(Steam prices)</i>');
  SynEdit2.Lines.Add('</p>');
  SynEdit2.Lines.Add('<p>');
  SynEdit2.Lines.Add('<ul><b>Conditiile actiunii:</b>');
  SynEdit2.Lines.Add('<li>Oferta este valabila doar pentru produsele participante la actiune.</li>');
  SynEdit2.Lines.Add('<li>Perioada actiunii 21.07.2022 - 25.08.2022</li>');
  SynEdit2.Lines.Add('<li>La actiune participa doar persoanele fizice</li>');
  SynEdit2.Lines.Add('<li>Actiunea 0% | 12 luni este valabila</li>');
  SynEdit2.Lines.Add('<li>Termenul creditului 12 luni</li>');
  SynEdit2.Lines.Add('</ul>');
  SynEdit2.Lines.Add('</p>');
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('<div>');
  SynEdit2.Lines.Add('</div>');
end;

procedure TfrmWebPromoBannerDlg.Prepare;
begin
     IBCQueryBanner.ParamByName('ID').AsInteger:=FPromoActionID;

     if not IBCQueryBanner.UpdateTransaction.Active then
       IBCQueryBanner.UpdateTransaction.StartTransaction;

     try
        IBCQueryBanner.Active:=True;
        if IBCQueryBanner.Eof then
        begin
             dtDialogTitle.Text:='Crearea unui baner web';
             IBCQueryBanner.Insert;
             IBCQueryBanner.FieldByName('PROMOACTIONID').asInteger:=FPromoActionID;
             IBCQueryBanner.FieldByName('FLG_GOTO_BRICKS').asInteger:=0;
             IBCQueryBanner.FieldByName('NAV_URL').AsString:='/';
        end
        else
        begin
             dtDialogTitle.Text:='Modifica baner web';
             IBCQueryBanner.Edit;
             SynEdit1.Lines.Text := IBCQueryBanner.FieldByName('description_ro').AsString;
             SynEdit2.Lines.Text := IBCQueryBanner.FieldByName('description_ru').AsString;

        end;
        UpdateImageSize;
        cxPageControl1.ActivePageIndex := 0;
     except
        IBCQueryBanner.Cancel;
        IBCQueryBanner.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmWebPromoBannerDlg.SetPromoActionID(const Value: integer);
begin
  FPromoActionID := Value;
end;

procedure TfrmWebPromoBannerDlg.SetUpdateTransaction(const Value: TIBCTransaction);
begin
     IBCQueryBanner.UpdateTransaction:=Value;
end;

procedure TfrmWebPromoBannerDlg.UpdateImageSize;
var
  RoSize: Integer;
  RuSize: Integer;
begin
  RoSize := dmDB.GetBlobSize(TBlobField(IBCQueryBanner.FieldByName('IMAGE_ROM')));
  RuSize := dmdb.GetBlobSize(TBlobField(IBCQueryBanner.FieldByName('IMAGE_RUS')));
  lbl_RoSize.Caption := Format('%d KB', [RoSize div 1024]);
  lbl_RuSize.Caption := Format('%d KB', [RuSize div 1024]);
  lbl_RoSize.Font.Color := IfThen((RoSize div 1024)>200, clRed, clWebDarkCyan);
  lbl_RuSize.Font.Color := iif((RuSize div 1024)>200, clRed, clWebDarkCyan);
end;

procedure TfrmWebPromoBannerDlg.WhenCancelForm;
begin
     IBCQueryBanner.Cancel;
     IBCQueryBanner.UpdateTransaction.Rollback;
end;

end.
