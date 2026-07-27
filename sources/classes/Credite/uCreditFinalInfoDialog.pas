unit uCreditFinalInfoDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalc, cxDBEdit, DBAccess, IBC, MemDS,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmCreditFinalInfoDialog = class(TSWNBaseFormClass)
    Label1: TLabel;
    Label2: TLabel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1OF: TcxGridDBColumn;
    cxGrid1DBTableView1RL: TcxGridDBColumn;
    cxGrid1DBTableView1AVANS: TcxGridDBColumn;
    cxGrid1DBTableView1TOTAL: TcxGridDBColumn;
    cxButton1: TcxButton;
    IBCQueryResult: TIBCQuery;
    IBCDataSourceReult: TIBCDataSource;
    ceSUMA: TcxCalcEdit;
    ceAvans: TcxCalcEdit;
    ceLuni: TcxCalcEdit;
    Label3: TLabel;
    procedure ceLuniPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ceLuniPropertiesEditValueChanged(Sender: TObject);
    procedure ceAvansPropertiesEditValueChanged(Sender: TObject);
  private
    procedure RefreshData;
    { Private declarations }
  protected
    function GetPrepayAmount(ListOfGoodsID: string): Double;
    procedure Prepare; override;
  public
    ListOfGoodsID: string;
    SumaCredit: Double;
    Avans: Double;
    { Public declarations }
  end;

var
  frmCreditFinalInfoDialog: TfrmCreditFinalInfoDialog;

implementation

{$R *.dfm}

procedure TfrmCreditFinalInfoDialog.ceAvansPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfrmCreditFinalInfoDialog.ceLuniPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfrmCreditFinalInfoDialog.ceLuniPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  if (DisplayValue<3) or (DisplayValue>36) then
  begin
    Error := True;
    ErrorText := 'Valori admisibile [3..36] !';
  end
  else
    Error := False;
end;

function TfrmCreditFinalInfoDialog.GetPrepayAmount(ListOfGoodsID: string):
    Double;
var
  Query: TIBCQuery;
begin
  Result := 0;
  Query := TIBCQuery.Create(Self);
  Try
  Query.SQL.Text := 'select coalesce(sum(mk.prepay_amount),0) prepay_amount from mk_credit_goods mk '+
                    'inner join sp_split('+QuotedStr(ListOfGoodsID)+') s on s.id=mk.goodsid and ' +
                    'mk.data1<=current_date and mk.data2 >= current_date';
  Query.Open;
  Result := Query.FieldByName('PREPAY_AMOUNT').AsFloat;
  Finally
    Query.Free;
  End;
end;

{ TfrmCreditFinalInfoDialog }

procedure TfrmCreditFinalInfoDialog.Prepare;
begin
  inherited;
  ceAvans.Value := GetPrepayAmount(ListOfGoodsID);
  ceSuma.Value := SumaCredit;
  ceLuni.Value := 12;
  
  RefreshData;
  cxGrid1DBTableView1.Controller.FocusedRecordIndex := 0;
end;

procedure TfrmCreditFinalInfoDialog.RefreshData;
begin
  IBCQueryResult.Close;

  IBCQueryResult.ParamByName('LUNI').AsString := ceLuni.Value.ToString;
  IBCQueryResult.ParamByName('AVANS').AsFloat := ceAvans.Value;
  IBCQueryResult.ParamByName('SUMA').AsFloat := ceSUMA.Value;
  IBCQueryResult.ParamByName('LISTOFGOODSID').AsString := ListOfGoodsID;

  IBCQueryResult.Open;
end;

end.
