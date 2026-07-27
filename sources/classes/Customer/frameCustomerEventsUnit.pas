unit frameCustomerEventsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, MemDS, DBAccess, IBC, Vcl.ExtCtrls, dxStatusBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TframeCustomerEvents = class(TFrame)
    IBCDataSourceCustomerEvents: TIBCDataSource;
    IBCQueryCustomerEvents: TIBCQuery;
    cxGrid3: TcxGrid;
    cxGridImportantEvents: TcxGridDBTableView;
    cxGridImportantEvents_TIP_EVENIMENT: TcxGridDBColumn;
    cxGridImportantEvents_DATA: TcxGridDBColumn;
    cxGridImportantEvents_DATA_NEXT: TcxGridDBColumn;
    cxGridImportantEventsNOTA: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNewCustomerEvent: TdxBarButton;
    bbEditCustomerEvent: TdxBarButton;
    bbDeleteCustomerEvent: TdxBarButton;
    procedure bbDeleteCustomerEventClick(Sender: TObject);
    procedure bbEditCustomerEventClick(Sender: TObject);
    procedure bbNewCustomerEventClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    FConnection: TIBCConnection;
    FCustomerID: integer;
    FSelectTransaction: TIBCTransaction;
    FLocalUpdateTransaction: TIBCTransaction;
    procedure SetConnection(const Value: TIBCConnection);
    procedure SetCustomerID(const Value: integer);
    procedure SetSelectTransaction(const Value: TIBCTransaction);
    procedure SetLocalUpdateTransaction(const Value: TIBCTransaction);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
//    procedure OpenDataSet;
    procedure ShowCustomerEventsEditorDialog(IsNewRecord: Boolean);
    property Connection: TIBCConnection read FConnection write SetConnection;
    property CustomerID: integer read FCustomerID write SetCustomerID;
    property SelectTransaction: TIBCTransaction read FSelectTransaction write SetSelectTransaction;
    property LocalUpdateTransaction: TIBCTransaction read FLocalUpdateTransaction write SetLocalUpdateTransaction;
  end;

implementation

uses
  DataModuleAdditions, uCustomerEventsEditorDialog, SWNUtils;

{$R *.dfm}

{ TFrame2 }

procedure TframeCustomerEvents.bbDeleteCustomerEventClick(Sender: TObject);
begin
  if ShowAskDialog('Evenimente clienti', 'Stergeti inregistrarea ?')=mrYes then
    IBCQueryCustomerEvents.Delete;
end;

procedure TframeCustomerEvents.bbEditCustomerEventClick(Sender: TObject);
begin
  ShowCustomerEventsEditorDialog(False);
end;

procedure TframeCustomerEvents.bbNewCustomerEventClick(Sender: TObject);
begin
  ShowCustomerEventsEditorDialog(True);
end;

constructor TframeCustomerEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TframeCustomerEvents.FrameEnter(Sender: TObject);
begin
  if not (FCustomerID > 0) then
  begin
    bbEditCustomerEvent.Enabled := False;
    bbDeleteCustomerEvent.Enabled := False;
  end
end;

//procedure TframeCustomerEvents.OpenDataSet;
//begin
//  with IBCQueryCustomerEvents do
//  begin
//    Close;
//    Connection := FConnection;
//    Transaction := SelectTransaction;
//    AutoCommit := False;
//    UpdateTransaction := LocalUpdateTransaction;
//    ParamByName('CUSTOMERID').AsInteger := FCustomerID;
//    Open;
//  end;
//end;

procedure TframeCustomerEvents.SetConnection(const Value: TIBCConnection);
begin
  FConnection := Value;
end;

procedure TframeCustomerEvents.SetCustomerID(const Value: integer);
begin
  FCustomerID := Value;
end;

procedure TframeCustomerEvents.SetSelectTransaction(const Value: TIBCTransaction);
begin
  FSelectTransaction := Value;
end;

procedure TframeCustomerEvents.SetLocalUpdateTransaction(const Value: TIBCTransaction);
begin
  FLocalUpdateTransaction := Value;
end;

procedure TframeCustomerEvents.ShowCustomerEventsEditorDialog(IsNewRecord: Boolean);
var
  dialog: TfrmCustomerEventsEditorDialog;
begin
  dialog := TfrmCustomerEventsEditorDialog.Create(Self, IBCQueryCustomerEvents, IBCDataSourceCustomerEvents);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.CustomerID := FCustomerID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

