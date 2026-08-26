unit frmSelectGoodsTypeUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  SWNBaseUnit,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  Data.DB,
  cxDBData,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  DBAccess,
  IBC,
  MemDS,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid;

type
  TcxGridTableControllerAccess = class(TcxGridTableController);

  TcxGridFindPanelAccess = class(TcxGridFindPanel);

  TfrmSelectGoodsTypeDlg = class(TSWNBaseFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1COD: TcxGridDBColumn;
    cxGrid1DBTableView1Denumire: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE_RUS: TcxGridDBColumn;
    IBCQueryGoodsTypes: TIBCQuery;
    IBCDataSourceGoodsTypes: TIBCDataSource;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function IsFormDataPosted: Boolean; override;
    procedure Prepare; override;
  public
    GoodsTypeID: Integer;
    GoodsTypeName: string;
    constructor Create(AOwner: TComponent; IBCConnection: TIBCConnection; AGoodsID: integer); reintroduce;
    { Public declarations }
  end;

var
  frmSelectGoodsTypeDlg: TfrmSelectGoodsTypeDlg;

implementation

uses
  frameSchedulerUnit,
  frmGoodsTypeDialog;

{$R *.dfm}

{ TfrmSelectGoodsTypeDlg }

constructor TfrmSelectGoodsTypeDlg.Create(AOwner: TComponent; IBCConnection: TIBCConnection; AGoodsID: integer);
begin
  inherited Create(AOwner, IBCConnection);

  IBCQueryGoodsTypes.Close;
  IBCQueryGoodsTypes.ParamByName('goodsid').AsInteger := AGoodsID;
  IBCQueryGoodsTypes.Open;
end;

procedure TfrmSelectGoodsTypeDlg.cxButton3Click(Sender: TObject);
var
  editor: TfrmGoodsTypeDlg;
begin
  editor := TfrmGoodsTypeDlg.Create(self);
  try
    if not IBCQueryGoodsTypes.FieldByName('GOODSTYPEID').IsNull then
      editor.DefaultGoodsTypeID := IBCQueryGoodsTypes.FieldByName('GOODSTYPEID').AsInteger;

    if editor.ShowModal = mrOk then
      IBCQueryGoodsTypes.Refresh;
  finally
    editor.Free;
  end;
end;

procedure TfrmSelectGoodsTypeDlg.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmSelectGoodsTypeDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_RETURN then
    ModalResult := mrOK;

end;

procedure TfrmSelectGoodsTypeDlg.FormActivate(Sender: TObject);
begin
  TcxGridFindPanelAccess(TcxGridTableControllerAccess(cxGrid1DBTableView1.Controller).FindPanel).Edit.SetFocus;
end;

function TfrmSelectGoodsTypeDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryGoodsTypes.RecordCount > 0 then
  begin
    Result := True;
    GoodsTypeID := IBCQueryGoodsTypes.FieldByName('GOODSTYPEID').AsInteger;
    GoodsTypeName := IBCQueryGoodsTypes.FieldByName('Title').AsString;
  end
  else
    Result := False;
end;

procedure TfrmSelectGoodsTypeDlg.Prepare;
begin
  inherited;

end;

end.

