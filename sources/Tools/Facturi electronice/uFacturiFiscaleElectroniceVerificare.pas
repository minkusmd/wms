unit uFacturiFiscaleElectroniceVerificare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, Vcl.Menus, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, dxBar, cxClasses, cxGridCustomView, cxGridDBTableView, Vcl.StdCtrls, cxButtons, cxGridLevel, cxGrid,
  Vcl.Clipbrd, cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList, MemDS, DBAccess, IBC,
  cxGridExportLink;

type
  TfrmFacturiFiscaleElectroniceVerificareDlg = class(TForm)
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    cxGrid1TableView1: TcxGridTableView;
    tvSeria: TcxGridColumn;
    tvNumar: TcxGridColumn;
    tvSuma: TcxGridColumn;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    tvStatus: TcxGridColumn;
    cxImageList1: TcxImageList;
    tvDOCID: TcxGridColumn;
    dxBarButton4: TdxBarButton;
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFacturiFiscaleElectroniceVerificareDlg: TfrmFacturiFiscaleElectroniceVerificareDlg;

implementation


{$R *.dfm}

procedure TfrmFacturiFiscaleElectroniceVerificareDlg.dxBarButton1Click(Sender: TObject);
var
  i: Integer;
  list: TStringlist;
  N: Integer;
  Numar: string;
  Seria: string;
  str: string;
  Suma: string;
begin
  list := TStringList.Create;
  try
    list.Text := Clipboard.AsText;
    for i := 0 to list.count-1 do
    begin
      str:= list[i];
      Seria := Copy(str, 1, Pos(#9, str)-1);
      str := Copy(Str, Pos(#9, str)+1, Length(str));
      Numar := Copy(str, 1, Pos(#9, str) -1);
      str := Copy(Str, Pos(#9, str)+1, Length(str));
      Suma := Copy(str, 1, Length(str));
      N := cxGrid1TableView1.DataController.AppendRecord;
      cxGrid1TableView1.DataController.Values[N, tvSeria.Index] := Seria;
      cxGrid1TableView1.DataController.Values[N, tvNumar.Index] := Numar;
      cxGrid1TableView1.DataController.Values[N, tvSuma.Index] := Suma;
    end;
  finally
    list.Free;
  end;

end;

procedure TfrmFacturiFiscaleElectroniceVerificareDlg.dxBarButton2Click(Sender: TObject);
var
  N: Integer;
begin
  for N := cxGrid1TableView1.DataController.RecordCount - 1 downto 0 do
     cxGrid1TableView1.DataController.DeleteRecord(N);
end;

procedure TfrmFacturiFiscaleElectroniceVerificareDlg.dxBarButton3Click(Sender: TObject);
var
  I: Integer;
  q: TIBCQuery;
  Seria: string;
  Numar: string;
begin
  q := TIBCQuery.Create(self);
  try
    q.SQL.Text := 'select DOCID from tdb_invoices where ((upper(facturano) = :facturano1) or (upper(facturano) = :facturano2) or facturano containing :facturano3)';
    q.Prepare;
    for I := 0 to cxGrid1TableView1.DataController.RecordCount -1 do
    begin
        Seria := cxGrid1TableView1.DataController.Values[i, tvSeria.Index];
        Numar := cxGrid1TableView1.DataController.Values[i, tvNumar.Index];
        q.ParamByName('FacturaNO1').AsString := Seria+' '+Numar;
        q.ParamByName('FacturaNO2').AsString := Seria+Numar;
        q.ParamByName('FacturaNO3').AsString := Numar;
        q.Open;
        if q.RecordCount = 0 then
        begin
           cxGrid1TableView1.DataController.Values[i, tvStatus.Index] := 1;
        end
        else
        begin
           cxGrid1TableView1.DataController.Values[i, tvStatus.Index] := 0;
           cxGrid1TableView1.DataController.Values[i, tvDOCID.Index] := q.FieldByName('DOCID').AsString;
        end;
        q.Close;
    end;
  finally
    q.Free;
  end;

end;

procedure TfrmFacturiFiscaleElectroniceVerificareDlg.dxBarButton4Click(Sender: TObject);
var
  d: TSaveDialog;
begin
  d := TSaveDialog.Create(Self);
  try
    if d.execute then
      ExportGridToXLSX(d.FileName, cxGrid1);
  finally
    d.Free;
  end;
end;

end.
