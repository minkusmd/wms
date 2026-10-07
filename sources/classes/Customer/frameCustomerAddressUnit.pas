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
    bbCloneAddr: TdxBarButton;
    procedure bbDeleteClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure cxGridCustomerAddrKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure bbCloneAddrClick(Sender: TObject);
    procedure IBCQueryCustomerAddrBeforePost(DataSet: TDataSet);
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
    procedure CloneAddrWithSwappedType;
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

const
  // tipurile de adresa (GET_ADDR_TYPES)
  cAddrTypePhysical = 7662;   // Adresa fizica
  cAddrTypeLegal = 7663;      // Adresa juridica

{ TframeCustomerAddr }

procedure TframeCustomerAddr.bbCloneAddrClick(Sender: TObject);
begin
  CloneAddrWithSwappedType;
end;

{ Cloneaza adresa curenta cu tipul schimbat: fizica -> juridica, juridica -> fizica.
  Inregistrarea noua intra, ca si cele adaugate din dialog, in cache-ul query-ului
  (CachedUpdates) si se salveaza impreuna cu clientul. }
procedure TframeCustomerAddr.CloneAddrWithSwappedType;
const
  // ADDRID il da generatorul, tipul se inverseaza
  cCopyFields: array[0..9] of string = ('CUSTOMERID', 'COUNTRYID', 'COUNTRY_NAME', 'CITYID',
    'CITY_NAME', 'DISTRICTID', 'DISTRICT_NAME', 'STREET', 'FULL_ADDRESS', 'COMMENTS');
var
  Values: array[0..9] of Variant;
  NewTypeID, I: Integer;
  NewTypeName: string;
  Bookmark: TBookmark;
  HasNewType: Boolean;
begin
  if not IBCQueryCustomerAddr.Active or IBCQueryCustomerAddr.IsEmpty then
    Exit;
  if IBCQueryCustomerAddr.State in dsEditModes then
    IBCQueryCustomerAddr.Post;

  case IBCQueryCustomerAddr.FieldByName('ADDRTYPEID').AsInteger of
    cAddrTypePhysical:
      begin
        NewTypeID := cAddrTypeLegal;
        NewTypeName := 'Adresa juridica';
      end;
    cAddrTypeLegal:
      begin
        NewTypeID := cAddrTypePhysical;
        NewTypeName := 'Adresa fizica';
      end;
  else
    ShowErrorDialog('Adrese clienti', 'Se pot clona doar adresele fizice si juridice.');
    Exit;
  end;

  for I := Low(cCopyFields) to High(cCopyFields) do
    Values[I] := IBCQueryCustomerAddr.FieldByName(cCopyFields[I]).Value;

  // clientul are deja o adresa de tipul nou?
  IBCQueryCustomerAddr.DisableControls;
  Bookmark := IBCQueryCustomerAddr.GetBookmark;
  try
    HasNewType := IBCQueryCustomerAddr.Locate('ADDRTYPEID', NewTypeID, []);
    IBCQueryCustomerAddr.GotoBookmark(Bookmark);
  finally
    IBCQueryCustomerAddr.FreeBookmark(Bookmark);
    IBCQueryCustomerAddr.EnableControls;
  end;
  if HasNewType and (ShowAskDialog('Adrese clienti',
    Format('Clientul are deja o inregistrare "%s". Adaugam inca una?', [NewTypeName])) <> mrYes) then
    Exit;

  IBCQueryCustomerAddr.Append;
  try
    for I := Low(cCopyFields) to High(cCopyFields) do
      IBCQueryCustomerAddr.FieldByName(cCopyFields[I]).Value := Values[I];
    IBCQueryCustomerAddr.FieldByName('ADDRTYPEID').AsInteger := NewTypeID;
    IBCQueryCustomerAddr.FieldByName('ADDRTYPE_NAME').AsString := NewTypeName;
    IBCQueryCustomerAddr.Post;
  except
    IBCQueryCustomerAddr.Cancel;
    raise;
  end;
end;

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

{ Orice adresa salvata fara client primeste clientul deschis - altfel ApplyUpdates cade in
  VW_TS_CUST_ADDR_BI cu "validation error ... TS_CUST_ADDR.CUSTOMERID ... null". }
procedure TframeCustomerAddr.IBCQueryCustomerAddrBeforePost(DataSet: TDataSet);
begin
  if (FCustomerID > 0) and (DataSet.FieldByName('CUSTOMERID').AsInteger <= 0) then
    DataSet.FieldByName('CUSTOMERID').AsInteger := FCustomerID;
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
    bbCloneAddr.Enabled := (FCustomerID > 0);
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

