unit frmGoodsFilterParamMergeDialog;

interface

uses
  DBAccess, IBC, MemDS, SWNBaseUnit, cxButtonEdit, cxButtons, cxCheckBox, cxClasses, cxContainer, cxControls,
  cxCustomData, cxData, cxDataStorage, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView,
  cxGridLevel, cxGridTableView, cxLabel, cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxNavigator, cxStyles,
  cxTextEdit, dxDateRanges, dxScrollbarAnnotations, System.Generics.Collections, DataModuleDB,

  Data.DB,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows, dxUIAClasses;

type
  TfrmGoodsFilterParamMergeDlg = class(TSWNCustomForm)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxLabel4: TcxLabel;
    tvGoodsList: TcxGridTableView;
    cxGrid1TableView_FILTERPARAMID: TcxGridColumn;
    cxGrid1TableView_GOODS_NAME: TcxGridColumn;
    cxGrid1TableView_CHECKED: TcxGridColumn;
    procedure cxButton1Click(Sender: TObject);
    procedure tvGoodsListDblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function CheckValues(var ErrorMessage: string): Boolean;
    procedure FillItems;
    procedure Prepare; override;
  public
    FilterParamList: TObjectList<TFilterParamsList>;
    GoodsList: string;
    { Public declarations }
  end;

implementation

uses
  SWNDBErrors, SWNUtils, frmWebFiltersDialog, System.UITypes;

{$R *.dfm}

function TfrmGoodsFilterParamMergeDlg.CheckValues(var ErrorMessage: string): Boolean;
begin
  Result := true;
  ErrorMessage := '';
  if ((tvGoodsList.Controller.SelectedRowCount - 1) > 0) then
  begin
    ErrorMessage := 'Eroare! Sunt selectate mai multe de 1 produs!' + #13#10;
  end;

  if ErrorMessage <> '' then
    Result := False;
end;

procedure TfrmGoodsFilterParamMergeDlg.cxButton1Click(Sender: TObject);
var
  sp: TIBCQuery;
  ErrorMessage: string;
  i: Integer;
  SelectedFilterParamID: string;
begin
  if not CheckValues(ErrorMessage) then
  begin
    MessageDlg(ErrorMessage, mtError, [mbOK], 0);
    Exit;
  end;

  SelectedFilterParamID := tvGoodsList.DataController.GetValue(tvGoodsList.Controller.SelectedRecords[0].RecordIndex,
    cxGrid1TableView_FILTERPARAMID.Index);

  sp := TIBCQuery.Create(self);

  sp.Transaction := dmdb.IBCTrDefaultUpdate;
  if not sp.Transaction.Active then
    sp.Transaction.StartTransaction;

  sp.SQL.Text := 'EXECUTE PROCEDURE MERGE_GOODS_FILTER_PARAMS2(:FILTER_PARAMID_LIST, :FILTER_PARAMID)';
  sp.Prepare;

  try

    for i := 0 to tvGoodsList.DataController.RecordCount - 1 do
    begin
      if tvGoodsList.DataController.Values[i, cxGrid1TableView_FILTERPARAMID.Index] <> SelectedFilterParamID then
      begin
        sp.ParamByName('FILTER_PARAMID_LIST').AsString := tvGoodsList.DataController.Values[i,
          cxGrid1TableView_FILTERPARAMID.Index];
        sp.ParamByName('FILTER_PARAMID').AsString := SelectedFilterParamID;
        sp.Execute;
      end;
    end;
    sp.Transaction.Commit;
  finally
    sp.Free;
  end;
end;

procedure TfrmGoodsFilterParamMergeDlg.FillItems;
var
  ARecordIndex: Integer;
  i: Integer;
begin
  for i:=0 to FilterParamList.Count-1 do
  begin
      ARecordIndex := tvGoodsList.DataController.AppendRecord;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_CHECKED.Index] := False;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_FILTERPARAMID.Index] := FilterParamList[i].FilterParamID;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_GOODS_NAME.Index] := FilterParamList[i].FilterParamName;
  end;
end;

procedure TfrmGoodsFilterParamMergeDlg.Prepare;
begin
  FillItems;
end;

procedure TfrmGoodsFilterParamMergeDlg.tvGoodsListDblClick(Sender: TObject);
begin
  cxButton1Click(Sender);
  ModalResult := mrOK;
end;

end.

