unit uSelectPromotionDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, DialogTitle, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.Menus, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  cxCheckBox, dxUIAClasses;

type
  TfrmSelectPromotionDlg = class(TSWNFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryWebPromo: TIBCQuery;
    IBCDataSourceWebPromo: TIBCDataSource;
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1PROMOACTIONID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1START_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1END_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ENABLED: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
  private    { Private declarations }
  protected    { Protected declaratioins }
    procedure AddGoodsToPromotion(const APromoActionID: Integer);
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public    { Public declarations }
    PromoActionID: Integer;

  end;

implementation

uses
  SWNUtils;

{$R *.dfm}

procedure TfrmSelectPromotionDlg.AddGoodsToPromotion(const APromoActionID: Integer);
begin
  PromoActionID := APromoActionID;
end;

{ TfrmSelectPromotionDlg }

procedure TfrmSelectPromotionDlg.BindingDataSource;
begin
  inherited;
end;

function TfrmSelectPromotionDlg.IsFormDataPosted: Boolean;
begin
  AddGoodsToPromotion(IBCQueryWebPromo.FieldByName('PROMOACTIONID').AsInteger);
  Result := True;
end;

procedure TfrmSelectPromotionDlg.Prepare;
begin

  IBCQueryWebPromo.Connection := fIBCConnection;
  if Assigned(FReadTransaction) then
    IBCQueryWebPromo.Transaction := FReadTransaction
  else
    raise Exception.Create('Nu este setata transactia de citire!');

  IBCQueryWebPromo.Open;
end;

procedure TfrmSelectPromotionDlg.WhenCancelForm;
begin
  inherited;

end;

end.

