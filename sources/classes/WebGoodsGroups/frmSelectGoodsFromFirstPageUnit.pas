unit frmSelectGoodsFromFirstPageUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxContainer, cxEdit, cxCustomListBox, cxListBox, cxDBEdit, Data.DB, DBAccess, IBC, MemDS,
  DialogTitle, SWNBaseUnit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid;

type
  TfrmSelectGoodsFromFirstPageDlg = class(TSWNBaseFormClass)
    Label1: TLabel;
    DialogTitle1: TDialogTitle;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    btnOK: TcxButton;
    cxButton2: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_GGID: TcxGridDBColumn;
    cxGrid1DBTableView1_Qty: TcxGridDBColumn;
  private
    FGoodsGroupID: Integer;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property GoodsGroupID: Integer read FGoodsGroupID write FGoodsGroupID;
    { Public declarations }
  end;

var
  frmSelectGoodsFromFirstPageDlg: TfrmSelectGoodsFromFirstPageDlg;

implementation

uses
    DataModuleAdditions;

{$R *.dfm}

{ TForm1 }

function TfrmSelectGoodsFromFirstPageDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    try
    GoodsGroupID := IBCQuery1.FieldByName('GGID').AsInteger;
    Result := True;
    except
    begin
        GoodsGroupID := -1;
        raise;
    end;
    end;
end;

procedure TfrmSelectGoodsFromFirstPageDlg.Prepare;
begin
  inherited;
  IBCQuery1.Open;
end;

end.
