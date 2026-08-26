unit frmMergeGoodsDialogEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxImage, cxDBEdit, cxTextEdit, StdCtrls, cxMaskEdit, cxButtonEdit, cxMemo, Buttons, dxGDIPlusClasses,
  DB, DBAccess, IBC, Vcl.Menus, cxButtons, MemDS, dxUIAClasses, dxCoreGraphics,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxLabel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView, cxGrid,
  SWNBaseUnit, DataModuleDB, System.Generics.Collections;

type
  TfrmMergeGoodsDlgEx = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    IBCQuerySource1: TIBCQuery;
    IBCDataSourceSource: TIBCDataSource;
    IBCQueryTarget1: TIBCQuery;
    IBCDataSourceTarget: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxGrid1: TcxGrid;
    tvGoodsList: TcxGridTableView;
    cxGrid1TableView_CHECKED: TcxGridColumn;
    cxGrid1TableView_GOODSID: TcxGridColumn;
    cxGrid1TableView_GOODS_NAME: TcxGridColumn;
    cxGrid1Level1: TcxGridLevel;
    cxLabel4: TcxLabel;
    procedure sbSelectTargetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvGoodsListDblClick(Sender: TObject);
  private
    fTargetGoodsID:integer;
    procedure OpenSourceGoodsInfo(const GoodsID:integer);
    procedure OpenTargetGoodsInfo(const GoodsID:integer);

    procedure DoMerge;
    function CheckValues(var ErrorMessage: string): Boolean;
    procedure FillItems;
  protected
    procedure Prepare; override;

  public
    GoodsList: TObjectList<TMergeGoodsList>;
  end;


implementation

uses frmGoods, SWNUtils, SWNDBErrors;

{$R *.dfm}

function TfrmMergeGoodsDlgEx.CheckValues(var ErrorMessage: string): Boolean;
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

procedure TfrmMergeGoodsDlgEx.DoMerge;
var
  sp: TIBCQuery;
  ErrorMessage: string;
  i: Integer;
  SelectedGoodsID: string;
begin
  if not CheckValues(ErrorMessage) then
  begin
    MessageDlg(ErrorMessage, mtError, [mbOK], 0);
    Exit;
  end;

  SelectedGoodsID := tvGoodsList.DataController.GetValue(tvGoodsList.Controller.SelectedRecords[0].RecordIndex,
    cxGrid1TableView_GOODSID.Index);

  sp := TIBCQuery.Create(self);

  sp.Transaction := dmdb.IBCTrDefaultUpdate;
  if not sp.Transaction.Active then
    sp.Transaction.StartTransaction;

  sp.SQL.Text := 'EXECUTE PROCEDURE MERGE_GOODS_EX(:GOODS_LIST, :REMAINING_GOODSID)';
  sp.Prepare;

  try

    for i := 0 to tvGoodsList.DataController.RecordCount - 1 do
    begin
      if tvGoodsList.DataController.Values[i, cxGrid1TableView_GOODSID.Index] <> SelectedGoodsID then
      begin
        sp.ParamByName('GOODS_LIST').AsString := tvGoodsList.DataController.Values[i,
          cxGrid1TableView_GOODSID.Index];
        sp.ParamByName('REMAINING_GOODSID').AsString := SelectedGoodsID;
        sp.Execute;
      end;
    end;
    sp.Transaction.Commit;
  finally
    sp.Free;
  end;
end;

procedure TfrmMergeGoodsDlgEx.FillItems;
var
  ARecordIndex: Integer;
  i: Integer;
begin
  for i:=0 to GoodsList.Count-1 do
  begin
      ARecordIndex := tvGoodsList.DataController.AppendRecord;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_CHECKED.Index] := False;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_GOODSID.Index] := GoodsList[i].GoodsID;
      tvGoodsList.DataController.Values[ARecordIndex, cxGrid1TableView_GOODS_NAME.Index] := GoodsList[i].GoodsName;
  end;
end;

procedure TfrmMergeGoodsDlgEx.Prepare;
begin
  FillItems;
end;




procedure TfrmMergeGoodsDlgEx.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
//  if AButtonIndex = 1 then
//     SelectTargetGoods;
//  if AButtonIndex = 0 then
//    LookupGoodsValue(StrToInt(beTargetGoodsID.Text));
end;

procedure TfrmMergeGoodsDlgEx.FormCreate(Sender: TObject);
begin
  inherited;
end;

// TODO: LookupGoodsValue
//procedure TfrmMergeGoodsDlgEx.LookupGoodsValue(GoodsID: Integer);
//begin
//  OpenTargetGoodsInfo(GoodsID);
//end;

procedure TfrmMergeGoodsDlgEx.OpenSourceGoodsInfo(const GoodsID:integer);
begin
//     IBCQuerySource.Close;
//     IBCQuerySource.ParamByName('id').AsInteger:=GoodsID;
//     IBCQuerySource.Open;
//     beSourceGoodsID.Text := IBCQuerySource.FieldByName('TITLE').AsString;
//     beSourceGoodsID.Tag := GoodsID;
//     fSourceGoodsID:=GoodsID;
end;

procedure TfrmMergeGoodsDlgEx.OpenTargetGoodsInfo(const GoodsID:integer);
begin
//     IBCQueryTarget.Close;
//     IBCQueryTarget.ParamByName('id').AsInteger:=GoodsID;
//     IBCQueryTarget.Open;
//     fTargetGoodsID:=GoodsID;
end;

procedure TfrmMergeGoodsDlgEx.sbSelectTargetClick(Sender: TObject);
begin
//     SelectTargetGoods;
end;

procedure TfrmMergeGoodsDlgEx.tvGoodsListDblClick(Sender: TObject);
begin
  DoMerge;
  ModalResult := mrOK;
end;

end.
