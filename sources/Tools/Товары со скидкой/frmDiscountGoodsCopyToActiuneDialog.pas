unit frmDiscountGoodsCopyToActiuneDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBAccess, IBC, MemDS, cxNavigator,
  dxUIAClasses, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmDiscountGoodsCopyToActiuneDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridActiuni: TcxGrid;
    cxGridATable: TcxGridDBTableView;
    cxGridA_ACTIUNEID: TcxGridDBColumn;
    cxGridA_TITLE_RUS: TcxGridDBColumn;
    cxGridA_START_DATE: TcxGridDBColumn;
    cxGridA_END_DATE: TcxGridDBColumn;
    cxGridA_FLG_ENDED: TcxGridDBColumn;
    cxGridALevel: TcxGridLevel;
    btnCopy: TButton;
    btnCancel: TButton;
    IBCQueryActiuni: TIBCQuery;
    IBCDataSourceActiuni: TIBCDataSource;
    cbCopySelectedOnly: TCheckBox;
    procedure cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridATableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
    procedure SelectionChanged;
    function GetActiuneID: integer;
    function GetCopySelectedOnly: Boolean;
    procedure SetCopySelectedOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property ActiuneID:integer read GetActiuneID;
    property CopySelectedOnly:Boolean read GetCopySelectedOnly write SetCopySelectedOnly;
  end;


implementation

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

procedure TfrmDiscountGoodsCopyToActiuneDlg.cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmDiscountGoodsCopyToActiuneDlg.cxGridATableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if Not VarIsNull(ARecord.Values[cxGridA_FLG_ENDED.Index]) then
     begin
          if ARecord.Values[cxGridA_FLG_ENDED.Index]=1 then AStyle:=dmAdditions.cxStyle_TextGray;
     end;
end;

function TfrmDiscountGoodsCopyToActiuneDlg.GetActiuneID: integer;
var N:integer;
begin
     Result:=-1;
     if IBCQueryActiuni.RecordCount>0 then
     begin
     Result := IBCQueryActiuni.FieldByName('PROMOACTIONID').AsInteger;
     end;
    { if Assigned(cxGridATable.Controller.FocusedRow) then
     begin
          N:=cxGridATable.Controller.FocusedRow.RecordIndex;
          Result:=cxGridATable.DataController.Values[N,cxGridA_ACTIUNEID.Index];
     end  }
end;

function TfrmDiscountGoodsCopyToActiuneDlg.GetCopySelectedOnly: Boolean;
begin
     Result:=cbCopySelectedOnly.Checked;
end;

procedure TfrmDiscountGoodsCopyToActiuneDlg.Prepare;
begin
     IBCQueryActiuni.Active:=True;

     SelectionChanged;
end;

procedure TfrmDiscountGoodsCopyToActiuneDlg.SelectionChanged;
begin
     btnCopy.Enabled:=cxGridATable.DataController.RecNo>0;
end;

procedure TfrmDiscountGoodsCopyToActiuneDlg.SetCopySelectedOnly(const Value: Boolean);
begin
     cbCopySelectedOnly.Checked:=Value;
end;

end.
