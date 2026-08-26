unit frame131OlisGrupUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, SWNDataFiltering;

type
  Tframe131OligGrup = class(TSWNBaseFrame)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
  private
    { Private declarations }
  protected
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DeleteRecord; override;
        procedure PrepareData;
        procedure RefreshData; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ Tframe131OligGrup }

procedure Tframe131OligGrup.DeleteRecord;
begin
  inherited;

end;

procedure Tframe131OligGrup.DoFrameHide;
begin
  inherited;

end;

procedure Tframe131OligGrup.DoFrameShow(
  const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

end;

function Tframe131OligGrup.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe131OligGrup.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe131OligGrup.GetFrameButtons: TFrameButtons;
begin

end;

function Tframe131OligGrup.InitFrameID: Integer;
begin
  Result := 131;
end;

procedure Tframe131OligGrup.PrepareData;
begin

end;

procedure Tframe131OligGrup.RefreshData;
begin
  inherited;

end;

end.
