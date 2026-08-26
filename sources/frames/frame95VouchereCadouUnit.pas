unit frame95VouchereCadouUnit;

// –≈ À¿Ã¿ - ÔÓÏÓ ÍÓ‰˚

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit, SWNDocumentFilters, SWNDataFiltering, Data.DB, DBAccess, IBC, MemDS, cxGraphics,
  cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxLabel, cxCheckBox,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, cxDropDownEdit,
  dxScrollbarAnnotations, dxBar, cxSplitter;

type
  Tframe95VouchereCadou = class(TSWNBaseFrame)
    IBCDataSourceVouchereCadou: TIBCDataSource;
    cxGridPromoTickets: TcxGrid;
    cxGridPromoTicketsTable: TcxGridDBTableView;
    cxGridPromoTicketsLevel: TcxGridLevel;
    Panel1: TPanel;
    Label1: TLabel;
    cxGridPromoTicketsTableTICKETID: TcxGridDBColumn;
    cxGridPromoTicketsTableTICKET_CODE: TcxGridDBColumn;
    cxGridPromoTicketsTableDATA1: TcxGridDBColumn;
    cxGridPromoTicketsTableDATA2: TcxGridDBColumn;
    cxGridPromoTicketsTableDISCOUNT_VALUE: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    IBCQueryVouchereCadou: TIBCQuery;
    bbGenerateGiftVouchers: TdxBarButton;
    cxGridPromoTicketsTable_FLG_USED: TcxGridDBColumn;
    cxGridPromoTicketsTable_FLG_ACTIVE: TcxGridDBColumn;
    procedure cxGridPromoTicketsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    fSECURITY_New, fSECURITY_Edit, fSECURITY_Delete: Boolean;
    procedure SelectionChanged;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure CloneRecord; override;

    procedure SetupSecurityItems; override;

  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

{$R *.dfm}

uses DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors, frmMarketingActiuneEditorDialog, frmPromoCodesEditorUnit,
  uVouchereCadouEditorDialog;

{ Tframe47ActiuniMarketing }

procedure Tframe95VouchereCadou.CloneRecord;
begin
  inherited;

end;

procedure Tframe95VouchereCadou.CreateNewRecord;
var
  dialog: TfrmVouchereCadouEditorDialog;
begin
  dialog := TfrmVouchereCadouEditorDialog.Create(Self, IBCQueryVouchereCadou, IBCDataSourceVouchereCadou);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe95VouchereCadou.cxGridPromoTicketsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe95VouchereCadou.DeleteRecord;
begin
  if IBCQueryVouchereCadou.FieldByName('FLG_USED').AsInteger = 0 then
  begin
    if ShowAskDialog('Sterge Voucher cadou', Format('Stergeti voucherul cu codul "%s"?',
      [IBCQueryVouchereCadou.FieldByName('CODE').AsString])) <> mrYes then
      Exit;

    IBCQueryVouchereCadou.UpdateTransaction.StartTransaction;
    try
      IBCQueryVouchereCadou.Delete;
      IBCQueryVouchereCadou.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryVouchereCadou.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe95VouchereCadou.DoFrameHide;
begin
  IBCQueryVouchereCadou.Close;
  inherited;
end;

procedure Tframe95VouchereCadou.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  IBCQueryVouchereCadou.Open;
end;

function Tframe95VouchereCadou.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe95VouchereCadou.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtADD, fbtMODIFY, fbtDELETE];
end;

function Tframe95VouchereCadou.InitFrameID: integer;
begin
  Result := 95;
end;

procedure Tframe95VouchereCadou.ModifyRecord;
var
  dialog: TfrmVouchereCadouEditorDialog;
begin
  dialog := TfrmVouchereCadouEditorDialog.Create(Self, IBCQueryVouchereCadou, IBCDataSourceVouchereCadou);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe95VouchereCadou.RefreshData;
begin
  IBCQueryVouchereCadou.Refresh;
end;

procedure Tframe95VouchereCadou.SelectionChanged;
begin

end;

procedure Tframe95VouchereCadou.SetupDefaultFocus;
begin
  cxGridPromoTickets.SetFocus;
  cxGridPromoTicketsTableTICKET_CODE.Focused := True;
end;

procedure Tframe95VouchereCadou.SetupSecurityItems;
begin
  fSECURITY_New := True;
  fSECURITY_Edit := True;
  fSECURITY_Delete := True;
end;

end.
