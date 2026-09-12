unit frmBPPLSelectCustomUSDRateDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, cxCurrencyEdit,
  StdCtrls, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmBPPLSelectCustomUSDRateDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryZP: TIBCQuery;
    IBCDataSourceZP: TIBCDataSource;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_RATEUSD: TcxGridDBColumn;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    btnOk: TButton;
    btnCancel: TButton;
    cxGrid_DOCTYPENAME: TcxGridDBColumn;
    cxGrid_DATE_ONLY: TcxGridDBColumn;
  private
    { Private declarations }
    fCustomUSDRate:double;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    property CustomUSDRate:double read fCustomUSDRate;
  end;


implementation

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmZarplataSelectCustomUsdRateDialog }

function TfrmBPPLSelectCustomUSDRateDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;

     if Assigned(cxGridTable.Controller.FocusedRecord) and (cxGridTable.Controller.FocusedRow.IsData) then
     begin
          fCustomUSDRate:=cxGridTable.Controller.FocusedRecord.Values[cxGrid_RATEUSD.Index];
          Result:=True;
     end;
end;

procedure TfrmBPPLSelectCustomUSDRateDlg.Prepare;
begin
     IBCQueryZP.ParamByName('currFirma').AsInteger:=dmDB.CurrentFirma;
     IBCQueryZP.Active:=True;
     cxGridTable.DataController.Groups.ChangeExpanding(0,True,False);
     // focus record in group
     if cxGridTable.DataController.RecordCount>0 then cxGridTable.Controller.FocusRecord(1,true);
end;

end.
