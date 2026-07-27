unit frameSmsHistoryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxCheckBox, cxContainer, MemDS, DBAccess,
  IBC, cxTextEdit, cxMemo, cxDBEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.ExtCtrls, dxDateRanges, dxScrollbarAnnotations;

type
  TframeSMSHistory = class(TFrame)
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1FLG_SENT: TcxGridDBColumn;
    cxGrid1DBTableView1DATA_CREATED: TcxGridDBColumn;
    cxGrid1DBTableView1PHONE: TcxGridDBColumn;
    cxGrid1DBTableView1DATA_DELIVERED: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxDBMemo1: TcxDBMemo;
    IBCDataSourceSMS_History: TIBCDataSource;
    IBCQuerySMS_History: TIBCQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
