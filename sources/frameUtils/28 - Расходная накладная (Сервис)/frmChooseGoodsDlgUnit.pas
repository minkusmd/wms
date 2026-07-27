unit frmChooseGoodsDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxButtons, DialogTitle, cxCheckBox, dxBar, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmChooseGoodsDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCQueryGoodsList: TIBCQuery;
    IBCDataSourceGoodsList: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1DOCID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSNAME: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbSelectSerialNumber: TdxBarButton;
    IBCQuerySupplierInfo: TIBCQuery;
    IBCDataSourceSupplierInfo: TIBCDataSource;
    procedure bbSelectSerialNumberClick(Sender: TObject);
  private
    FCustomerID: Integer;
    FGoodsQTY: Double;
    FGoodsIdentificator: string;
    FUntilDate: TDate;
    procedure SetCustomerID(const Value: Integer);
    procedure SetGoodsQTY(const Value: Double);
    procedure SetGoodsIdentificator(const Value: string);
    procedure SetUntilDate(const Value: TDate);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property GoodsQTY: Double read FGoodsQTY write SetGoodsQTY;
    property GoodsIdentificator: string read FGoodsIdentificator write SetGoodsIdentificator;
    property UntilDate: TDate read FUntilDate write SetUntilDate;
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions, frmSelectSerialPartNoUnit, DataModuleDB;

{$R *.dfm}

procedure TfrmChooseGoodsDlg.bbSelectSerialNumberClick(Sender: TObject);
var
  dialog: TfrmSelectSerialPartNoDlg;
begin
  if IBCQueryGoodsList.FieldByName('FLG_SN').AsInteger = 1 then
  begin
    dialog := TfrmSelectSerialPartNoDlg.Create(Self, dmdb.IBCConnection);
    try
      dialog.DocID := IBCQueryGoodsList.FieldByName('DOCID').AsInteger;
      dialog.GoodsID := IBCQueryGoodsList.FieldByName('GOODSID').AsInteger;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

function TfrmChooseGoodsDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
end;

procedure TfrmChooseGoodsDlg.Prepare;
begin
  with IBCQueryGoodsList do
  begin
    Close;
    ParamByName('CUSTOMERID').AsInteger := FCustomerID;
    ParamByName('UNTIL_DATE').AsDate := FUntilDate;
    Open;
  end;
end;

procedure TfrmChooseGoodsDlg.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TfrmChooseGoodsDlg.SetGoodsQTY(const Value: Double);
begin
  FGoodsQTY := Value;
end;

procedure TfrmChooseGoodsDlg.SetGoodsIdentificator(const Value: string);
begin
  FGoodsIdentificator := Value;
end;

procedure TfrmChooseGoodsDlg.SetUntilDate(const Value: TDate);
begin
  FUntilDate := Value;
end;

procedure TfrmChooseGoodsDlg.WhenCancelForm;
begin

end;

end.

