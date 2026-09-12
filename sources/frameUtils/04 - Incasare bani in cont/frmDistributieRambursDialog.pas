unit frmDistributieRambursDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxBar, DialogTitle, SWNUtils, dxUIAClasses;

type
  TfrmDistributieRambursDlg = class(TSWNMasteredFormClass)
    IBCQueryDistributieRamburs: TIBCQuery;
    IBCDataSourceDistributieRamburs: TIBCDataSource;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    Panel1: TPanel;
    cxGridRamburs: TcxGrid;
    cxGridRambursDBTableView: TcxGridDBTableView;
    cxGridRambursDBTableViewCUSTOMERID: TcxGridDBColumn;
    cxGridRambursDBTableViewCUSTOMER_NAME: TcxGridDBColumn;
    cxGridRambursDBTableViewAWB: TcxGridDBColumn;
    cxGridRambursDBTableViewRAMBURS: TcxGridDBColumn;
    cxGridRambursDBTableViewPRET_LIVRARE: TcxGridDBColumn;
    cxGridRambursDBTableViewCOMISION: TcxGridDBColumn;
    cxGridRambursLevel1: TcxGridLevel;
    cxButton1: TcxButton;
    IBCTrLocal: TIBCTransaction;
    cxGridRambursDBTableViewCONTRACTID: TcxGridDBColumn;
    DialogTitle1: TDialogTitle;
    bbImport: TdxBarButton;
    procedure cxGridRambursDBTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbImportClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
  protected
    procedure ShowEditorDlg(AIsNewRecord: Boolean);
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public    { Public declarations }
  end;

var
  frmDistributieRambursDlg: TfrmDistributieRambursDlg;

implementation

uses
  DataModuleAdditions, frmDistributieRambursEditorDialog, frmCustomerContractsDialog, Vcl.Clipbrd, DataModuleDB;

{$R *.dfm}

procedure TfrmDistributieRambursDlg.bbDeleteClick(Sender: TObject);
begin
    if (MessageDlg('Stergeti inregistrarea', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
        IBCQueryDistributieRamburs.Delete;
end;

procedure TfrmDistributieRambursDlg.bbEditClick(Sender: TObject);
begin
    ShowEditorDlg(False);
end;

procedure TfrmDistributieRambursDlg.bbImportClick(Sender: TObject);
var
  AWB: string;
  I: Integer;
  q: TIBCQuery;
  slist: TStringList;
  clipboard_array: TArray<string>;
  PretLivrare: string;
  SumaRamburs: string;
begin
  slist := TStringlist.Create;

  q := TIBCQuery.Create(self);
  q.SQL.Text := 'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME FROM GET_AWB_FULLINFO(:AWB)';
  q.Prepare;
  slist.Text := Clipboard.AsText;

  try
    for I := 0 to slist.count - 1 do begin
      clipboard_array := slist[I].Split([#9]);
      AWB := clipboard_array[0];
      PretLivrare := clipboard_array[1];
      SumaRamburs := clipboard_array[2];

      q.CLose;
      q.ParamByName('awb').AsString := AWB;
      q.Open;

      IBCQueryDistributieRamburs.Append;
      IBCQueryDistributieRamburs.FieldByName('CUSTOMERID').AsInteger := q.FieldByName('CUSTOMERID').AsInteger;
      IBCQueryDistributieRamburs.FieldByName('PRET_LIVRARE').Asstring := PretLivrare;
      IBCQueryDistributieRamburs.FieldByName('RAMBURS').Asstring := SumaRamburs;
      IBCQueryDistributieRamburs.FieldByName('AWB').Asstring := AWB;
      IBCQueryDistributieRamburs.FieldByName('COMISION').AsFloat := 0;
      IBCQueryDistributieRamburs.FieldByName('CONTRACTID').AsFloat := -1;

      LoadDefaultContract(q.FieldByName('CUSTOMERID').AsInteger, dmdb.ibcquerydocs.FieldByName('DATA').AsDateTime);
      IBCQueryDistributieRamburs.Post;
    end
  finally
    q.Free;
    slist.Free;
  end;
end;

procedure TfrmDistributieRambursDlg.bbNewClick(Sender: TObject);
begin
  ShowEditorDlg(True);
end;

procedure TfrmDistributieRambursDlg.cxGridRambursDBTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGridRambursDBTableView, Key, Shift);
end;

function TfrmDistributieRambursDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
end;

procedure TfrmDistributieRambursDlg.Prepare;
begin
  inherited;
  DialogTitle1.Title := Format('%s Suma ramburs: %n lei', [fMasterDataSet.FieldByName('CT_NAME').AsString,
    fMasterDataSet.FieldByName('suma').AsFloat]);

  IBCTrLocal.DefaultConnection := fMasterDataSet.Transaction.DefaultConnection;
  IBCQueryDistributieRamburs.Transaction := fMasterDataSet.Transaction;
  IBCQueryDistributieRamburs.MasterSource := fMasterDataSource;
  IBCQueryDistributieRamburs.MasterFields := 'DOCID';
  IBCQueryDistributieRamburs.DetailFields := 'DOCID';
  IBCQueryDistributieRamburs.Open;
end;

procedure TfrmDistributieRambursDlg.ShowEditorDlg(AIsNewRecord: Boolean);
var
  dialog: TfrmDistributieRambursEditorDlg;
begin
  dialog := TfrmDistributieRambursEditorDlg.Create(Self, IBCQueryDistributieRamburs, IBCDataSourceDistributieRamburs);
  try
    dialog.DocumentDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    dialog.IsNewRecord := AIsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmDistributieRambursDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
    contractInfo: TCustomerDefultContractInfo;
    dialog : TfrmContractsDlg;
begin
    dialog := TfrmContractsDlg.Create(self);
    try
        contractInfo := LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.fieldbyname('dt').Asinteger, CustomerID, DocDate);
        if Assigned(contractInfo) then
        begin
//            dmdb.ibcquerydocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//            dmdb.ibcquerydocs.FieldByName('FLG_ACNT').AsInteger := 1;
            contractInfo.Free;
        end
        else
        begin
//            dmdb.ibcquerydocs.FieldByName('CONTRACTID').Value := -1;
        end;
    finally
        dialog.Free;
    end;
end;

end.

