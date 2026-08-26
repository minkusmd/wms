unit uGoodsAttributes;

interface

uses
  IBC, SWNBaseUnit, cxButtons, cxCheckBox, cxCheckListBox, cxContainer, cxControls, cxCustomListBox, cxDBCheckListBox,
  cxEdit, cxGraphics, cxLookAndFeelPainters, cxLookAndFeels,

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
  Winapi.Windows,
  System.JSON,
  Data.DB;

type
  TfrmGoodsAttributesDlg = class(TSWNMasteredFormClass)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    clbAttributes: TcxDBCheckListBox;
  private
    { Private declarations }
  protected
    function CheckData: Boolean;
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure ReadCheckListBoxItems;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

var
  frmGoodsAttributesDlg: TfrmGoodsAttributesDlg;

implementation

uses
  SWNUtils;

{$R *.dfm}

function TfrmGoodsAttributesDlg.CheckData: Boolean;
begin
  Result := True;
end;


{ TfrmGoodsAttributesDlg }

function TfrmGoodsAttributesDlg.isFormDataPosted: boolean;
var
  i: Integer;
  res: Integer;
  q: TIBCQuery;
begin
  Result := false;
  try
     res := 0;

     for i := 0 to clbAttributes.Items.Count-1 do
     begin
       if clbAttributes.Items[i].Checked then
         res := SetBitValue(res, i, 1)
       else
         res := SetBitValue(res, i, 0);
     end;

    if not fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.StartTransaction;

    q := TIBCQuery.Create(self);
    try
      q.SQL.Text := 'update ts_goods set attributes = :attributes where goodsid = :goodsid';
      q.ParamByName('attributes').AsInteger := res;
      q.ParamByName('goodsid').AsInteger := fMasterDataSet.FieldByName('goodsid').AsInteger;
      q.Transaction := fMasterDataSet.UpdateTransaction;
      q.Execute;
      fMasterDataSet.RefreshRecord;
    finally
      q.Free;
    end;

    if fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  except
  begin
      fMasterDataSet.UpdateTransaction.Rollback;
      Result := false;
      raise;
  end;
  end;
end;

procedure TfrmGoodsAttributesDlg.Prepare;
begin
  inherited;
  clbAttributes.DataBinding.DataSource := fMasterDataSource;
  ReadCheckListBoxItems;
end;

procedure TfrmGoodsAttributesDlg.ReadCheckListBoxItems;
var
//  i: Integer;
  item:TcxCheckListBoxItem;
  json: TJSONObject;
  q: TIBCQuery;
begin
     q := TIBCQuery.Create(self);
     clbAttributes.Items.BeginUpdate;
     try
        q.SQL.Text := 'select * from ts_syss where parentid = 58';
        q.Open;
//        i := 0;
        while Not q.Eof do
        begin
             json := TJsonObject.Create;
             try
               JSON.Parse(TEncoding.UTF8.GetBytes(q.FieldByName('title').AsString),0);
               item := clbAttributes.Items.Add;
               item.Text := json.FindValue('web_name_ro').Value;
               item.Tag := json.FindValue('bitindex').Value.ToInteger();
             finally
               json.Free;
             end;
//             Inc(i);
             q.Next;
        end;
        q.Close;
     finally
        clbAttributes.Items.EndUpdate;
        q.Free;
     end;
end;

procedure TfrmGoodsAttributesDlg.WhenCancelForm;
begin
  inherited;
  if   fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
  if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
