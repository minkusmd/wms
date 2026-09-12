unit frmœËıÓ‰“Ó‚‡‡œÓÕ‡ÍÎ‡‰Ì˚ÏChangeGoodsAcntDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.StdCtrls, cxMaskEdit, cxButtonEdit, cxDBEdit, cxTextEdit, Data.DB, DBAccess, IBC, MemDS;

type
  TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    beACNT: TcxButtonEdit;
    procedure beACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    procedure ShowSelectAcntGoods;
    procedure ClearAcnt;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

    procedure SaveStates;override;
    procedure LoadStates;override;
  public
    { Public declarations }
    Property GoodsID:Integer read FGoodsID write SetGoodsID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, frmGoodsACNTBrowser, SWNValueStorageUnit;

{ TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg }

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.beACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: ShowSelectAcntGoods;
     1: ClearAcnt;
     end;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.ClearAcnt;
begin
     IBCQueryGoods.FieldByName('GOODS_ACNT_ID').AsInteger:=-1;
     beACNT.Text:='Marfa fara nume';
end;

function TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.IsFormDataPosted: Boolean;
begin
     IBCQueryGoods.Post;
     IBCQueryGoods.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.LoadStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form position
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self)
          then Self.Position := poDesigned;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.Prepare;
begin
     inherited;
     IBCQueryGoods.ParamByName('ID').AsInteger:=FGoodsID;
     IBCQueryGoods.Active:=True;
     IBCQueryGoods.UpdateTransaction.StartTransaction;
     try
        IBCQueryGoods.Edit;
        beACNT.Text:=IBCQueryGoods.FieldByName('NAMEACNT').AsString;
     except
        if IBCQueryGoods.state in dsEditModes then IBCQueryGoods.Cancel;
        IBCQueryGoods.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.SaveStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form pos
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.ShowSelectAcntGoods;
var goodsACNT:TfrmGoodsACNTDlg;
begin
     goodsACNT:=TfrmGoodsACNTDlg.Create(Self);
     try
        if goodsACNT.SelectGoodsACNT(IBCQueryGoods.FieldByName('GOODS_ACNT_ID').AsInteger) then
        begin
             IBCQueryGoods.FieldByName('GOODS_ACNT_ID').AsInteger:=goodsACNT.GoodsAcntID;
             beACNT.Text:=goodsACNT.GoodsAcntTitle;
        end
     finally
        goodsACNT.Free;
     end;
end;

procedure TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.WhenCancelForm;
begin
     IBCQueryGoods.Cancel;
     IBCQueryGoods.UpdateTransaction.Rollback;
end;

end.
