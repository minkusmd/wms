unit frmSelectBannerDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS, cxImage, SWNBaseUnit, Vcl.StdCtrls;

type
  TfrmSelectBannerDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridActiuniTable: TcxGridDBTableView;
    cxGridActiuniLevel: TcxGridLevel;
    cxGridActiuni: TcxGrid;
    cxGridImagesTable: TcxGridDBTableView;
    cxGridImagesLevel: TcxGridLevel;
    cxGridImages: TcxGrid;
    IBCQueryActiuni: TIBCQuery;
    IBCDataSourceActiuni: TIBCDataSource;
    cxGridActiuniTableColumn1: TcxGridDBColumn;
    IBCQueryBlocks: TIBCQuery;
    IBCDataSourceBlocks: TIBCDataSource;
    cxGridImagesTableColumn1: TcxGridDBColumn;
    btnOk: TButton;
    btnCancel: TButton;
    colPAIMAGEBRICKID: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    function GetPAImageIDList: TIntegerArray;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions;

{ TfrmSelectBannerDlg }

function TfrmSelectBannerDlg.GetPAImageIDList: TIntegerArray;
var
  i, recordIndex: integer;
begin
  SetLength(Result, cxGridImagesTable.Controller.SelectedRecordCount);
  for i := 0 to cxGridImagesTable.Controller.SelectedRecordCount - 1 do
  begin
    recordIndex := cxGridImagesTable.Controller.SelectedRecords[i].recordIndex;
    Result[i] := integer(cxGridImagesTable.DataController.Values[recordIndex, colPAIMAGEBRICKID.Index]);
  end;
end;

function TfrmSelectBannerDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if cxGridImagesTable.DataController.RecNo > 0 then
  begin
    Result := True;
  end;
end;

procedure TfrmSelectBannerDlg.Prepare;
begin
  IBCQueryActiuni.Active := True;
  IBCQueryBlocks.Active := True;
end;

end.
