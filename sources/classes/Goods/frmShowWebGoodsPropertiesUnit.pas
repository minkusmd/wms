unit frmShowWebGoodsPropertiesUnit;

interface

uses
  Winapi.Windows, swnBaseUnit, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Data.DB, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons, cxTextEdit, cxDBEdit, cxLabel, Vcl.ExtCtrls, DialogTitle;

type
  TfrmShowWebGoodsProperties = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    IBCQueryWebGoods: TIBCQuery;
    IBCDataSourceWebGoods: TIBCDataSource;
    IBCTrLocalUpdate: TIBCTransaction;
    cxLabel8: TcxLabel;
    teNameRU: TcxDBTextEdit;
    teNameRO: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    cxButton1: TcxButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IBCQueryWebGoodsAfterInsert(DataSet: TDataSet);
    procedure cxButton1Click(Sender: TObject);
  private
    fGoodsID: integer;
    fGoodsName: string;
    procedure SetGoodsID(const Value: integer);
    procedure SetGoodsName(const Value: string);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property GoodsID: integer read fGoodsID write SetGoodsID;
    property GoodsName: string read fGoodsName write SetGoodsName;
  end;

var
  frmShowWebGoodsProperties: TfrmShowWebGoodsProperties;

implementation

uses
  DataModuleDB, SWNDBErrors;

{$R *.dfm}

{ TfrmShowWebGoodsProperties }

procedure TfrmShowWebGoodsProperties.cxButton1Click(Sender: TObject);
begin
    IBCQueryWebGoods.FieldByName('NAME_RO').AsString := GoodsName;
    IBCQueryWebGoods.FieldByName('NAME_RU').AsString := GoodsName;
end;

procedure TfrmShowWebGoodsProperties.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
  begin
    IBCQueryWebGoods.FieldByName('META_TITLE_RO').AsString := IBCQueryWebGoods.FieldByName('NAME_RO').AsString + ' in Moldova, comanda cu livrare rapida';
    IBCQueryWebGoods.FieldByName('META_TITLE_RU').AsString := IBCQueryWebGoods.FieldByName('NAME_RU').AsString + ' in Moldova, cumparati cu livrare rapida';

    IBCQueryWebGoods.FieldByName('META_DESC_RO').AsString := 'Cumpara ' + IBCQueryWebGoods.FieldByName('NAME_RO').AsString +
                    ' in Moldova la cel mai mic pret. ' +IBCQueryWebGoods.FieldByName('NAME_RO').AsString +
                    ' in Chisinau si Moldova pe credit, livrare rapida. Garantie';
    IBCQueryWebGoods.FieldByName('META_DESC_RU').AsString := 'Cumparati ' + IBCQueryWebGoods.FieldByName('NAME_RU').AsString +
                    ' in Moldova la pret mic! ' +IBCQueryWebGoods.FieldByName('NAME_RU').AsString +
                    ' in Chisinau - vanzare in credit, livrare rapida. Garantie';

    IBCQueryWebGoods.FieldByName('META_KEY_RO').AsString := IBCQueryWebGoods.FieldByName('NAME_RO').AsString.Replace(' ', ', ');
    IBCQueryWebGoods.FieldByName('META_KEY_RU').AsString := IBCQueryWebGoods.FieldByName('NAME_RU').AsString.Replace(' ', ', ');
  end;
end;

procedure TfrmShowWebGoodsProperties.IBCQueryWebGoodsAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('GOODSID').AsInteger := fGoodsID;
end;

function TfrmShowWebGoodsProperties.IsFormDataPosted: Boolean;
begin
  try
    if IBCQueryWebGoods.State in [dsEdit, dsInsert] then
      IBCQueryWebGoods.Post;
    Result := True;
  except
    on e: Exception do
    begin
      Result := False;
      if not ProcessSWNError(e) then
        raise;
    end;
  end;
end;

procedure TfrmShowWebGoodsProperties.Prepare;
begin
  IBCQueryWebGoods.Close;
  IBCQueryWebGoods.ParamByName('GOODSID').AsInteger := fGoodsID;
  IBCQueryWebGoods.Open;

  IBCQueryWebGoods.Edit;
end;

procedure TfrmShowWebGoodsProperties.SetGoodsID(const Value: integer);
begin
  fGoodsID := Value;
end;

procedure TfrmShowWebGoodsProperties.SetGoodsName(const Value: string);
begin
  fGoodsName := Value;
end;

procedure TfrmShowWebGoodsProperties.WhenCancelForm;
begin
  inherited;
  if IBCQueryWebGoods.State in [dsEdit, dsInsert] then
    IBCQueryWebGoods.Cancel;
end;

end.

