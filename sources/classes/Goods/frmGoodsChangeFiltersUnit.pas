unit frmGoodsChangeFiltersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, dxBar, cxClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxImageComboBox, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, DBAccess, IBC, MemDS, dxmdaset, cxContainer, Vcl.Menus, cxButtons, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.NumberBox,
  dxCoreGraphics;

type
  TfrmGoodsChangeFilters = class(TSWNBaseFormClass)
    Panel1: TPanel;
    btnOK: TButton;
    Button2: TButton;
    dxMemData1: TdxMemData;
    DataSourceFilters: TDataSource;
    dxMemData1FILTERID: TIntegerField;
    dxMemData1FILTER_NAME: TStringField;
    dxMemData1PARAMID: TIntegerField;
    dxMemData1PARAM_VALUE: TStringField;
    Panel2: TPanel;
    Label3: TLabel;
    edFilterID: TNumberBox;
    beFilters: TcxButtonEdit;
    Label4: TLabel;
    edFilterParamID: TNumberBox;
    beParamValue: TcxButtonEdit;
    cxButton1: TcxButton;
    btnCancel: TcxButton;
    edOrd: TNumberBox;
    Label7: TLabel;
    btnDeleteFilter: TcxButton;
    procedure beFiltersClick(Sender: TObject);
    procedure edFilterIDExit(Sender: TObject);
    procedure edFilterParamIDExit(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure btnDeleteFilterClick(Sender: TObject);
  private
    defaultFilterID: Integer;
    LastFilterID: integer;
    LastFilterParamID: integer;
    FAppendMode: Boolean;
    procedure SetAppendMode(const Value: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property AppendMode: Boolean read FAppendMode write SetAppendMode;
    { Public declarations }
  end;

var
  frmGoodsChangeFilters: TfrmGoodsChangeFilters;

implementation

uses
  frmWebFiltersDialog, DataModuleDB;

{$R *.dfm}

procedure TfrmGoodsChangeFilters.beFiltersClick(Sender: TObject);
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
    defaultFilterID := -1;
    defaultFilterParamID := -1;

    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      edFilterID.Value:= dialog.FilterID;
      beFilters.Tag := dialog.FilterID;
      beFilters.Text := dialog.FilterNameRom;
      edFilterParamID.Value := dialog.FilterParamID;
      beParamValue.Tag := dialog.FilterParamID;
      beParamValue.Text:=dialog.FilterParamValueRom;
    end
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsChangeFilters.btnDeleteFilterClick(Sender: TObject);
begin
  inherited;
  AppendMode:= False;
end;

procedure TfrmGoodsChangeFilters.cxButton1Click(Sender: TObject);
begin
  inherited;
  AppendMode:= true;
end;

procedure TfrmGoodsChangeFilters.edFilterIDExit(Sender: TObject);
var
  q: TIBCQuery;
begin
  q:=TIBCQuery.Create(nil);
  try
    q.SQL.Text:='SELECT FILTERNAME FROM TS_FILTERS WHERE FILTERID = :FILTERID';
    q.ParamByName('FILTERID').AsInteger:=edFilterID.ValueInt;
    q.Open;
    edFilterID.tag:=edFilterID.ValueInt;
    edFilterID.text:=q.FieldByName('FILTERNAME').AsString;
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsChangeFilters.edFilterParamIDExit(Sender: TObject);
var
  q: TIBCQuery;
begin
  q:=TIBCQuery.Create(nil);
  try
    q.SQL.Text:='SELECT PARAM_VALUE FROM TS_FILTER_PARAMS WHERE filterparamid=:filterparamid';
//    q.ParamByName('FILTERID').AsInteger:=edFilterID.ValueInt;
    q.ParamByName('FILTERPARAMID').AsInteger:=edFilterParamID.ValueInt;
    q.Open;
    edFilterParamID.tag:=edFilterID.ValueInt;
    edFilterParamID.text:=q.FieldByName('PARAM_VALUE').AsString;
  finally
    q.Free;
  end;

end;

function TfrmGoodsChangeFilters.IsFormDataPosted: Boolean;
begin
  edFilterID.Value := LastFilterID;
  edFilterParamID.Value := LastFilterParamID;
  result:=true;
end;

procedure TfrmGoodsChangeFilters.Prepare;
begin
  inherited;
  edOrd.Enabled:=false;
end;

procedure TfrmGoodsChangeFilters.SetAppendMode(const Value: Boolean);
begin
  FAppendMode := Value;
end;

end.
