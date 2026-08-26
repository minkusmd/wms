unit frmModifyFilterParamsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Vcl.StdCtrls, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxContainer,
  cxCheckBox;

type
  TfrmModifyFilterParamsDlg = class(TForm)
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1TableView1: TcxGridTableView;
    cxGrid1TableView1_PARENTID: TcxGridColumn;
    cxGrid1TableView1_FILTERID: TcxGridColumn;
    cxGrid1TableView1_FILTERPARAMID: TcxGridColumn;
    Button1: TButton;
    Button2: TButton;
    cbDeleteFirst: TcxCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmModifyFilterParamsDlg: TfrmModifyFilterParamsDlg;

implementation

uses
    DataModuleDB;

{$R *.dfm}

procedure TfrmModifyFilterParamsDlg.Button1Click(Sender: TObject);
var
  i: Integer;
  DeleteFirst: integer;
begin
  for i := 0 to cxGrid1TableView1.DataController.RecordCount-1 do
  begin
      if (cbDeleteFirst.Checked) then DeleteFirst := 1 else DeleteFirst := 0;
      DMDB.ExecuteQuery('EXECUTE PROCEDURE MODIFY_GOODS_FILTERS (:deleteFirst, :PARENTID, :FILTERID, :FILTERPARAMID)',
      [
        DeleteFirst,
        cxGrid1TableView1.DataController.Values[i, cxGrid1TableView1_PARENTID.Index],
        cxGrid1TableView1.DataController.Values[i, cxGrid1TableView1_FILTERID.Index],
        cxGrid1TableView1.DataController.Values[i, cxGrid1TableView1_FILTERPARAMID.Index]
      ]);
  end;
end;

end.
