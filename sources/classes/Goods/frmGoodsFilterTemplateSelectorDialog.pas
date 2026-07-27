unit frmGoodsFilterTemplateSelectorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle,
  DB, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGrid, IBC, StdCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, Vcl.Menus, DBAccess, MemDS,
  cxClasses, cxGridCustomView;

type
  TfrmGoodsFilterTemplateSelectorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_TEMPLATEID: TcxGridDBColumn;
    cxGridTable_TITLE_ROM: TcxGridDBColumn;
    cxGridTable_TITLE_RUS: TcxGridDBColumn;
    IBCQueryTemplates: TIBCQuery;
    IBCDataSourceTemplates: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxGridTableDblClick(Sender: TObject);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    fTemplateTitleRus: string;
    fTemplateID: integer;
    fTemplateTitleRom: string;

    procedure SelectionChanged;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property TemplateID:integer read fTemplateID;
    property TemplateTitleRom:string read fTemplateTitleRom;
    property TemplateTitleRus:string read fTemplateTitleRus;
  end;


implementation



{$R *.dfm}

procedure TfrmGoodsFilterTemplateSelectorDlg.cxGridTableDblClick(Sender:
    TObject);
begin
    ModalResult := mrOk;
end;

{ TfrmGoodsFilterTemplateSelectorDlg }

procedure TfrmGoodsFilterTemplateSelectorDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmGoodsFilterTemplateSelectorDlg.Prepare;
begin
     IBCQueryTemplates.Active:=True;
end;

procedure TfrmGoodsFilterTemplateSelectorDlg.SelectionChanged;
begin
     if Assigned(cxGridTable.Controller.FocusedRecord) then
     begin
          btnOk.Enabled:=true;
          fTemplateID:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_TEMPLATEID.Index];
          fTemplateTitleRom:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_TITLE_ROM.Index];
          fTemplateTitleRus:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_TITLE_RUS.Index];
     end
     else
     begin
          btnOk.Enabled:=false;
          fTemplateID:=-1;
          fTemplateTitleRom:='';
          fTemplateTitleRus:='';
     end;
end;

end.
