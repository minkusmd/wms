unit frmWebPacheteGoodsEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit, cxCalc, cxDBEdit, cxLabel, cxTextEdit,
  cxMaskEdit, cxButtonEdit, SWNBaseUnit, Vcl.ExtCtrls, RzPanel, RzDlgBtn;

type
  TfrmWebPacheteGoodsEditorDlg = class(TSWNMasteredFormClass)
    beGoods: TcxButtonEdit;
    cxLabel1: TcxLabel;
    cePrice: TcxDBCalcEdit;
    cxLabel2: TcxLabel;
    RzDialogButtons1: TRzDialogButtons;
    cxLabel3: TcxLabel;
    ceReducere: TcxDBCalcEdit;
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FIsNewRecord: boolean;
    fLastGoodsID: integer;
    procedure SetIsNewRecord(const Value: boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    property IsNewRecord: boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmWebPacheteGoodsEditorDlg: TfrmWebPacheteGoodsEditorDlg;

implementation

uses
  frmGoods, SWNDBErrors, Data.DB;

{$R *.dfm}

{ TfrmWebPacheteGoodsEditorDlg }

procedure TfrmWebPacheteGoodsEditorDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex:
  Integer);
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
//        dialog.OnCheckIfGoodsExists:=WhenCheckIfGoodsExists;
    if dialog.SelectGoods(fLastGoodsID, False, 0, 'Selectare produs pentru pachet') then
    begin
      MasterDataSet.FieldByName('GOODS_ID').AsInteger := dialog.GoodsID;
      MasterDataSet.FieldByName('PACHET_ID').AsInteger := fMasterDataSet.FieldByName('PACHET_ID').AsInteger;
      MasterDataSet.FieldByName('PRICE').AsFloat := dialog.GoodsPrice[1];
      fLastGoodsID := dialog.GoodsID;
      beGoods.Tag := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle
    end;
  finally
    dialog.Free;
  end;
end;

function TfrmWebPacheteGoodsEditorDlg.IsFormDataPosted: boolean;
begin
  Result := false;
  try
    MasterDataSet.Post;
    Result := True;
  except
    on E: Exception do
    begin
      if MasterDataSet.State in dsEditModes then
        MasterDataSet.Cancel;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebPacheteGoodsEditorDlg.Prepare;
begin
  inherited;
  cePrice.DataBinding.DataSource := MasterDataSource;
  ceReducere.DataBinding.DataSource := MasterDataSource;

  beGoods.Text := MasterDataSet.FieldByName('GOODS_NAME').AsString;
  beGoods.Tag := MasterDataSet.FieldByName('GOODS_ID').AsInteger;

  if IsNewRecord then
  begin
    MasterDataSet.Insert;
  end
  else
    MasterDataSet.Edit;
end;

procedure TfrmWebPacheteGoodsEditorDlg.SetIsNewRecord(const Value: boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmWebPacheteGoodsEditorDlg.WhenCancelForm;
begin
  if MasterDataSet.State in dsEditModes then
        MasterDataSet.Cancel;
end;

end.

