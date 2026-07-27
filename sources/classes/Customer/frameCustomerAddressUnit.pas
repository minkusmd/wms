unit frameCustomerAddressUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, MemDS, DBAccess, IBC, Vcl.ExtCtrls, dxStatusBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, SWNBaseFrameUnit,
  dxUIAClasses;

type
  TframeCustomerAddr = class(TFrame)
    IBCDataSourceCustomerAddr: TIBCDataSource;
    IBCQueryCustomerAddr: TIBCQuery;
    cxGrid3: TcxGrid;
    cxGridCustomerAddr: TcxGridDBTableView;
    cxGridCustomerAddr_TIP_EVENIMENT: TcxGridDBColumn;
    cxGridCustomerAddr_DATA: TcxGridDBColumn;
    cxGridCustomerAddrNOTA: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridCustomerAddrRaion: TcxGridDBColumn;
    cxGridCustomerAddr_Oras: TcxGridDBColumn;
    procedure bbDeleteClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure cxGridCustomerAddrKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    FConnection: TIBCConnection;
    FCustomerID: integer;
    FSelectTransaction: TIBCTransaction;
    FLocalUpdateTransaction: TIBCTransaction;
    procedure SetConnection(const Value: TIBCConnection);
    procedure SetCustomerID(const Value: integer);
    procedure SetSelectTransaction(const Value: TIBCTransaction);
    procedure SetLocalUpdateTransaction(const Value: TIBCTransaction);
    procedure ShowAddrEditDialog(IsNewRecord: Boolean);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Connection: TIBCConnection read FConnection write SetConnection;
    property CustomerID: integer read FCustomerID write SetCustomerID;
    property SelectTransaction: TIBCTransaction read FSelectTransaction write SetSelectTransaction;
    property LocalUpdateTransaction: TIBCTransaction read FLocalUpdateTransaction write SetLocalUpdateTransaction;
  end;

implementation

uses
  DataModuleAdditions, uCustomerEventsEditorDialog, SWNUtils, frmCustomerAddrEditUnit;

{$R *.dfm}

{ TframeCustomerAddr }

procedure TframeCustomerAddr.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Adrese clienti', 'Stergeti inregistrarea ?')=mrYes then
    IBCQueryCustomerAddr.Delete;
end;

procedure TframeCustomerAddr.bbEditClick(Sender: TObject);
begin
  ShowAddrEditDialog(False);
end;

procedure TframeCustomerAddr.bbNewClick(Sender: TObject);
begin
  ShowAddrEditDialog(True);
end;

constructor TframeCustomerAddr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TframeCustomerAddr.cxGridCustomerAddrKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
//  ProcessCommonKeys(cxGridCustomerAddr, Key, Shift);
end;

procedure TframeCustomerAddr.FrameEnter(Sender: TObject);
begin
    bbNew.Enabled := (FCustomerID > 0);
    bbEdit.Enabled := (FCustomerID > 0);
    bbDelete.Enabled := (FCustomerID > 0);
end;

procedure TframeCustomerAddr.SetConnection(const Value: TIBCConnection);
begin
  FConnection := Value;
end;

procedure TframeCustomerAddr.SetCustomerID(const Value: integer);
begin
  FCustomerID := Value;
end;

procedure TframeCustomerAddr.SetSelectTransaction(const Value: TIBCTransaction);
begin
  FSelectTransaction := Value;
end;

procedure TframeCustomerAddr.SetLocalUpdateTransaction(const Value: TIBCTransaction);
begin
  FLocalUpdateTransaction := Value;
  IBCQueryCustomerAddr.UpdateTransaction := Value;
end;

procedure TframeCustomerAddr.ShowAddrEditDialog(IsNewRecord: Boolean);
var
  dialog: TfrmCustomerAddrEditDlg;
begin
  dialog := TfrmCustomerAddrEditDlg.Create(self, IBCQueryCustomerAddr, IBCDataSourceCustomerAddr);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.CustomerID := CustomerID; // KeyField, MasterField
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

