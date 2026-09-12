unit frm52ZamenaTovaraEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtonEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxCheckBox, cxDBEdit, Vcl.ActnList, cxCalc, cxRadioGroup, cxLabel, Menus,
  cxButtons, cxPCdxBarPopupMenu, Data.DB, DBAccess, IBC, MemDS, cxMemo, cxPC,
  System.Actions, DataModuleDB, dxBarBuiltInMenu;

type
  Tfrm52ZamenaTovaraCountryVendorInfo = class
    CountryID: integer;
    CountryName: string;
    VendorID: integer;
    VendorName: string;
  end;

  Tfrm52ZamenaTovaraEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    ActionList1: TActionList;
    ActionF6: TAction;
    ActionF4: TAction;
    IBC_IDENT: TIBCQuery;
    IBCDS_IDENT: TIBCDataSource;
    pnClient: TPanel;
    cxPageControl2: TcxPageControl;
    pnSource: TcxTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    lbIDEN_DT: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    beGOODS_DT: TcxButtonEdit;
    beIDEN_DT: TcxButtonEdit;
    lcbDT_DEP: TcxDBLookupComboBox;
    ceDT_PRICE: TcxDBCalcEdit;
    edCOUNTRY_DT: TcxTextEdit;
    edVENDOR_DT: TcxTextEdit;
    cbDT_FLG_BALANCE: TcxCheckBox;
    mmDT_DESCRIPTION: TcxDBMemo;
    cxPageControl3: TcxPageControl;
    pnTarget: TcxTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    lbIDEN_CT: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    mmCT_DESCRIPTION: TcxDBMemo;
    beGOODS_CT: TcxButtonEdit;
    lcbCT_DEP: TcxDBLookupComboBox;
    edCT_IDENT: TcxDBTextEdit;
    ceCT_PRICE: TcxDBCalcEdit;
    beCountryID_CT: TcxButtonEdit;
    beVendorID_CT: TcxButtonEdit;
    cbCT_FLG_BALANCE: TcxCheckBox;
    cxButton1: TcxButton;
    Label11: TLabel;
    Label12: TLabel;
    edNR_ACT_PRIMIRE: TcxDBTextEdit;
    edNR_ACT_ZACEOT: TcxDBTextEdit;
    procedure beGOODS_DTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure beIDEN_DTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure beGOODS_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure ActionF6Execute(Sender: TObject);
    procedure ActionF4Execute(Sender: TObject);
    procedure rbDT_FLG_BALANCE1Click(Sender: TObject);
    procedure rbCT_FLG_BALANCE1Click(Sender: TObject);
    procedure beCountryID_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure beVendorID_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    FDocID: integer;
    FDT_DEP: integer;
    FReadOnly: Boolean;
    fGoodsDTisSerial, fGoodsCTisSerial: Boolean;
    fDocData: TDateTime;
    FDocCurrencyID: integer;
    FDocFlgACNT: Boolean;
    fInternalChange: Boolean;
    FCT_IDENT_Format: string;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetDocID(const Value: integer);
    procedure SetDT_DEP(const Value: integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SelectGoodsDT;
    procedure SelectGoodsDTSerialNumber;
    procedure SelectGoodsDTPartNumber;
    function GenCountryVendorInfo(const CountryID, VendorID: integer): Tfrm52ZamenaTovaraCountryVendorInfo;
    procedure SelectGoodsCT;
    function CheckValues: Boolean;
    procedure SetDocData(const Value: TDateTime);
    procedure SetDocCurrencyID(const Value: integer);
    procedure SetDocFlgACNT(const Value: Boolean);
    procedure DT_FLAGS_Changed;
    procedure CT_FLAGS_Changed;
    procedure ClearDTPart;
    procedure ClearCTPart;
    procedure SelectCountry;
    procedure SelectVendor;
    procedure SetCT_IDENT_Format(const Value: string);
    procedure DisableAllControls(const Parent: TWinControl; const ExceptControls: array of TControl);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read fCreateNewRecord write SetCreateNewRecord;
    property readonly: Boolean read FReadOnly write SetReadOnly;
    property DocID: integer read FDocID write SetDocID;
    property DocCurrencyID: integer read FDocCurrencyID write SetDocCurrencyID;
    property DocFlgACNT: Boolean read FDocFlgACNT write SetDocFlgACNT;
    property DT_DEP: integer read FDT_DEP write SetDT_DEP;
    property DocData: TDateTime read fDocData write SetDocData;
    property CT_IDENT_Format: string read FCT_IDENT_Format write SetCT_IDENT_Format;
    procedure DisableLeftPane;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, SWNConst, frmGoods, SWNUtils, SWNTypes,
  frm52ZamenaTovaraSelectSNDialog, frm52ZamenaTovaraSelectPartNoDialog,
  frmSyssEditorWindow;

{ Tfrm52ZamenaTovaraEditorDlg }

procedure Tfrm52ZamenaTovaraEditorDlg.ActionF4Execute(Sender: TObject);
begin
  SelectGoodsDT;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.ActionF6Execute(Sender: TObject);
begin
  beIDEN_DTPropertiesButtonClick(nil, 0);
end;

procedure Tfrm52ZamenaTovaraEditorDlg.beCountryID_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectCountry;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.beGOODS_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  if (AButtonIndex = 0) then
    SelectGoodsCT
  else
  begin
    if not fMasterDataSet.FieldByName('DT_GOODSID').IsNull then
    begin
      fMasterDataSet.FieldByName('CT_GOODSID').AsInteger := fMasterDataSet.FieldByName('DT_GOODSID').AsInteger;
      fMasterDataSet.FieldByName('CT_GOODS_TITLE').AsString := fMasterDataSet.FieldByName('DT_GOODS_TITLE').AsString;
      beGOODS_CT.Text := beGOODS_DT.Text;
    end;
    // SN or PartNO
    if not fMasterDataSet.FieldByName('DT_IDENT').IsNull then
      fMasterDataSet.FieldByName('CT_IDENT').AsString := fMasterDataSet.FieldByName('DT_IDENT').AsString;

    // SN or PartNO type
    fMasterDataSet.FieldByName('CT_GOODS_SERIAL_TYPE').AsInteger := fMasterDataSet.FieldByName('DT_GOODS_SERIAL_TYPE').AsInteger;
    if (fMasterDataSet.FieldByName('CT_GOODS_SERIAL_TYPE').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
    begin
      lbIDEN_CT.Caption := 'Numar de serie';
      fGoodsCTisSerial := True;
    end
    else
    begin
      lbIDEN_CT.Caption := 'Numar de partida';
      fGoodsCTisSerial := False;
    end;

    // pretul
    if not fMasterDataSet.FieldByName('DT_PRICE').IsNull then
      fMasterDataSet.FieldByName('CT_PRICE').AsCurrency := fMasterDataSet.FieldByName('DT_PRICE').AsCurrency;
    // CountryID
    fMasterDataSet.FieldByName('CT_COUNTRYID').AsInteger := fMasterDataSet.FieldByName('DT_COUNTRYID').AsInteger;
    beCountryID_CT.Text := fMasterDataSet.FieldByName('DT_COUNTRY_NAME').AsString;
    // VendorID
    fMasterDataSet.FieldByName('CT_VENDORID').AsInteger := fMasterDataSet.FieldByName('DT_VENDORID').AsInteger;
    beVendorID_CT.Text := fMasterDataSet.FieldByName('DT_VENDOR_NAME').AsString;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.beGOODS_DTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectGoodsDT;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.beIDEN_DTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  if fGoodsDTisSerial then
    SelectGoodsDTSerialNumber
  else
    SelectGoodsDTPartNumber;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.beVendorID_CTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectVendor;
end;

function Tfrm52ZamenaTovaraEditorDlg.CheckValues: Boolean;
var
  ErrorStr: string;
  hasGoods: Boolean;
begin
  ErrorStr := '';
  Result := False;
  hasGoods := False;

  if fMasterDataSet.FieldByName('DOCID').IsNull then
    AddErrorToStr(ErrorStr, 'Cod document!');

  if cbDT_FLG_BALANCE.Checked then
  begin
    hasGoods := True;
    if fMasterDataSet.FieldByName('DT_DEP').IsNull then
      AddErrorToStr(ErrorStr, 'Depozit produs pentru casare!');
    if fMasterDataSet.FieldByName('DT_GOODSID').IsNull then
      AddErrorToStr(ErrorStr, 'Produs pentru casare!');
    if fMasterDataSet.FieldByName('DT_IDENT').IsNull then
      AddErrorToStr(ErrorStr, lbIDEN_DT.Caption + ' (pentru casare)!');
    if fMasterDataSet.FieldByName('DT_PRICE').IsNull or (fMasterDataSet.FieldByName('DT_PRICE').AsCurrency < 0) then
      AddErrorToStr(ErrorStr, 'Pretul produsului pentru casare!');
  end;

  if cbCT_FLG_BALANCE.Checked then
  begin
    hasGoods := True;
    if fMasterDataSet.FieldByName('CT_DEP').IsNull then
      AddErrorToStr(ErrorStr, 'Depozit produs la primire!');
    if fMasterDataSet.FieldByName('CT_GOODSID').IsNull then
      AddErrorToStr(ErrorStr, 'Produs la primire!');
    if fMasterDataSet.FieldByName('CT_IDENT').IsNull then
      AddErrorToStr(ErrorStr, lbIDEN_CT.Caption + ' (la primire)!');
    if fMasterDataSet.FieldByName('CT_PRICE').IsNull or (fMasterDataSet.FieldByName('DT_PRICE').AsCurrency < 0) then
      AddErrorToStr(ErrorStr, 'Pretul produsului la primire!');
    if fMasterDataSet.FieldByName('CT_COUNTRYID').IsNull then
      AddErrorToStr(ErrorStr, 'Tara de producere la primire!');
    if fMasterDataSet.FieldByName('CT_VENDORID').IsNull then
      AddErrorToStr(ErrorStr, 'Producator la primire!');
  end;

  if (not cbDT_FLG_BALANCE.Checked and not cbCT_FLG_BALANCE.Checked) then
  begin
    hasGoods := True;
    if fMasterDataSet.FieldByName('DT_DEP').IsNull then
      AddErrorToStr(ErrorStr, 'Depozit pentru casare!');
    if fMasterDataSet.FieldByName('DT_GOODSID').IsNull then
      AddErrorToStr(ErrorStr, 'Produs pentru casare!');
    if fMasterDataSet.FieldByName('DT_IDENT').IsNull then
      AddErrorToStr(ErrorStr, lbIDEN_DT.Caption + ' (pentru casare)!');
    if fMasterDataSet.FieldByName('DT_PRICE').IsNull or (fMasterDataSet.FieldByName('DT_PRICE').AsCurrency < 0) then
      AddErrorToStr(ErrorStr, 'Pretul produsului pentru casare!');
    if fMasterDataSet.FieldByName('CT_DEP').IsNull then
      AddErrorToStr(ErrorStr, 'Depozit produs la primire!');
    if fMasterDataSet.FieldByName('CT_GOODSID').IsNull then
      AddErrorToStr(ErrorStr, 'Produs la primire!');
    if fMasterDataSet.FieldByName('CT_IDENT').IsNull then
      AddErrorToStr(ErrorStr, lbIDEN_CT.Caption + ' (la primire)!');
    if fMasterDataSet.FieldByName('CT_PRICE').IsNull or (fMasterDataSet.FieldByName('DT_PRICE').AsCurrency < 0) then
      AddErrorToStr(ErrorStr, 'Pretul produsului la primire!');
    if fMasterDataSet.FieldByName('CT_COUNTRYID').IsNull then
      AddErrorToStr(ErrorStr, 'Tara producerii la primire!');
    if fMasterDataSet.FieldByName('CT_VENDORID').IsNull then
      AddErrorToStr(ErrorStr, 'Producator la primire!');
  end;

  if not hasGoods then
    AddErrorToStr(ErrorStr, 'Alege "Trece suma in creanta" pentru produs!');

//  if not (fMasterDataSet.FieldByName('NR_ACT_PRIMIRE').IsNull) or (Trim(fMasterDataSet.FieldByName('NR_ACT_PRIMIRE').AsString) <> '') then
//  begin
//    fMasterDataSet.FieldByName('FLG_CLOSED').AsInteger := 1;
//  end;


  if fMasterDataSet.FieldByName('FLG_CLOSED').AsInteger = 1 then
  begin
    if fMasterDataSet.FieldByName('NR_ACT_PRIMIRE').IsNull or (Trim(fMasterDataSet.FieldByName('NR_ACT_PRIMIRE').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Actul de primire predare a produsului!');

    if cbDT_FLG_BALANCE.Checked then
    begin
      if fMasterDataSet.FieldByName('NR_ACT_ZACEOT').IsNull or (Trim(fMasterDataSet.FieldByName('NR_ACT_ZACEOT').AsString) = '') then
        AddErrorToStr(ErrorStr, 'Numarul actului de modificare a datoriei!');
    end;
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure Tfrm52ZamenaTovaraEditorDlg.ClearCTPart;
begin
  fMasterDataSet.FieldByName('CT_DEP').Value := Null;
  fMasterDataSet.FieldByName('CT_GOODSID').Value := Null;
  fMasterDataSet.FieldByName('CT_IDENT').Value := Null;
  fMasterDataSet.FieldByName('CT_PRICE').Value := Null;
  fMasterDataSet.FieldByName('CT_FLG_BALANCE').AsInteger := 0;
  fMasterDataSet.FieldByName('CT_FLG_PERESORT').AsInteger := 0;

  beGOODS_CT.Text := '';
  cbCT_FLG_BALANCE.Checked := False;
  // rbCT_FLG_PERESORT.Checked:=False;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.ClearDTPart;
begin
  fMasterDataSet.FieldByName('DT_DEP').Value := Null;
  fMasterDataSet.FieldByName('DT_GOODSID').Value := Null;
  fMasterDataSet.FieldByName('DT_IDENT').Value := Null;
  fMasterDataSet.FieldByName('DT_PRICE').Value := Null;
  fMasterDataSet.FieldByName('DT_FLG_BALANCE').AsInteger := 0;
  fMasterDataSet.FieldByName('DT_FLG_PERESORT').AsInteger := 0;

  beGOODS_DT.Text := '';
  cbDT_FLG_BALANCE.Checked := False;
  // rbDT_FLG_PERESORT.Checked:=False;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.CT_FLAGS_Changed;
begin
  if fInternalChange then
    exit;

  if cbCT_FLG_BALANCE.Checked then
  begin
    pnSource.Enabled := False;
    ClearDTPart;
  end
  else
  begin
    pnSource.Enabled := True;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.cxButton1Click(Sender: TObject);
var
  Query: TIBCQuery;
  S: integer;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'SELECT COUNT(*) FROM TDB_JURNAL_SP WHERE (CT_GOODSID=:GOODSID)';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('CT_GOODSID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      S := Query.Fields[0].AsInteger + 1;
      fMasterDataSet.FieldByName('CT_IDENT').AsString := format(FCT_IDENT_Format, [fMasterDataSet.FieldByName('CT_GOODSID').AsString, DateToStr(date), S]);
      // 'INV-%s/%s-%d'
      // FMasterDataSet.FieldByName('CT_IDENT').AsString := 'INV-'+fMasterDataSet.FieldByName('CT_GOODSID').AsString+'/'+DateToStr(date)+'-'+IntToStr(S);
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.DisableAllControls(const Parent: TWinControl; const ExceptControls: array of TControl);

  function IsExceptControl(const TestControl: TControl): Boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to Length(ExceptControls) do
      if (ExceptControls[i] = TestControl) then
      begin
        Result := True;
        break;
      end;
  end;

var
  i: integer;
begin
  for i := 0 to Parent.ControlCount - 1 do
    if not IsExceptControl(Parent.Controls[i]) then
      Parent.Controls[i].Enabled := False;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.DisableLeftPane;
begin
  pnSource.Enabled := False;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.DT_FLAGS_Changed;
begin
  if fInternalChange then
    exit;

  // if not rbDT_FLG_PERESORT.Checked then
  if cbDT_FLG_BALANCE.Checked then
  begin
    pnTarget.Enabled := False;
    ClearCTPart;
  end
  else
  begin
    pnTarget.Enabled := True;
  end;
end;

function Tfrm52ZamenaTovaraEditorDlg.GenCountryVendorInfo(const CountryID, VendorID: integer): Tfrm52ZamenaTovaraCountryVendorInfo;
var
  Query: TIBCQuery;
begin
  Result := nil;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT S1.SYSSID, S1.TITLE, S2.SYSSID, S2.TITLE');
    Query.SQL.Add('FROM RDB$DATABASE');
    Query.SQL.Add('INNER JOIN TS_SYSS S1 ON (S1.SYSSID=:CID)');
    Query.SQL.Add('INNER JOIN TS_SYSS S2 ON (S2.SYSSID=:VID)');
    Query.ParamByName('CID').AsInteger := CountryID;
    Query.ParamByName('VID').AsInteger := VendorID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      Result := Tfrm52ZamenaTovaraCountryVendorInfo.Create;
      Result.CountryID := Query.Fields[0].AsInteger;
      Result.CountryName := Query.Fields[1].AsString;
      Result.VendorID := Query.Fields[2].AsInteger;
      Result.VendorName := Query.Fields[3].AsString;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.BindingDataSource;
begin
  FDocID := -1;
  FDT_DEP := -1;
  FReadOnly := False;
  FCT_IDENT_Format := 'INV-%s/%s-%d'; // CT_GOODSID, Date, Count
  lcbDT_DEP.DataBinding.DataSource := fMasterDataSource;
  lcbCT_DEP.DataBinding.DataSource := fMasterDataSource;
  edCT_IDENT.DataBinding.DataSource := fMasterDataSource;
  ceDT_PRICE.DataBinding.DataSource := fMasterDataSource;
  ceCT_PRICE.DataBinding.DataSource := fMasterDataSource;
  // cbFLG_CLOSED.DataBinding.DataSource := fMasterDataSource;
  lcbDT_DEP.DataBinding.DataSource := fMasterDataSource;
  lcbCT_DEP.DataBinding.DataSource := fMasterDataSource;
  lcbCT_DEP.Properties.ListSource := dmDB.IBCDataSourceStocks;
  lcbDT_DEP.Properties.ListSource := dmDB.IBCDataSourceStocks;
  edNR_ACT_PRIMIRE.DataBinding.DataSource := fMasterDataSource;
  edNR_ACT_ZACEOT.DataBinding.DataSource := fMasterDataSource;
end;

function Tfrm52ZamenaTovaraEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    // save flags
    fMasterDataSet.FieldByName('DT_FLG_BALANCE').AsInteger := Ord(cbDT_FLG_BALANCE.Checked);
    fMasterDataSet.FieldByName('DT_FLG_PERESORT').AsInteger := Ord(not cbDT_FLG_BALANCE.Checked);
    fMasterDataSet.FieldByName('CT_FLG_BALANCE').AsInteger := Ord(cbCT_FLG_BALANCE.Checked);
    fMasterDataSet.FieldByName('CT_FLG_PERESORT').AsInteger := Ord(not cbCT_FLG_BALANCE.Checked);

    fMasterDataSet.Post;

    if (IBC_IDENT.State in [dsEdit, dsInsert]) then
      IBC_IDENT.Post;

    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.Prepare;
begin
  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('DOCID').AsInteger := FDocID;
      fMasterDataSet.FieldByName('DT_DEP').AsInteger := FDT_DEP;
      fMasterDataSet.FieldByName('DT_FLG_BALANCE').AsInteger := 0;
      fMasterDataSet.FieldByName('DT_FLG_PERESORT').AsInteger := 0;
      fMasterDataSet.FieldByName('CT_FLG_BALANCE').AsInteger := 0;
      fMasterDataSet.FieldByName('CT_FLG_PERESORT').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_CLOSED').AsInteger := 0;
    end
    else
    begin
      if FReadOnly then
      begin
        dtDialogTitle.Text := 'Modifica inregistrarea';
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnCancel.Caption := cMSG_ButtonClose;
        btnOk.Visible := False;

        ActionF4.Enabled := False;
        ActionF6.Enabled := False;

        // disable control from tab "MARFA DE INLOCUIT"
        DisableAllControls(pnSource, [beIDEN_DT, lbIDEN_DT, Label11, edNR_ACT_PRIMIRE, edNR_ACT_ZACEOT, Label12]);
        beIDEN_DT.Properties.Buttons.Clear;
        beIDEN_DT.Properties.readonly := True;
        edNR_ACT_PRIMIRE.Properties.readonly := True;
        edNR_ACT_ZACEOT.Properties.readonly := True;
        // cbFLG_CLOSED.Visible:=False;

        // disable control from tab "MARFA DE INLOCUIRE"
        DisableAllControls(pnTarget, [edCT_IDENT, lbIDEN_CT]);
        edCT_IDENT.Properties.readonly := True;

      end
      else
      begin
        dtDialogTitle.Text := 'Modifica inregistrarea';
        fMasterDataSet.Edit;
      end;
      beGOODS_DT.Text := fMasterDataSet.FieldByName('DT_GOODS_TITLE').AsString;
      beGOODS_CT.Text := fMasterDataSet.FieldByName('CT_GOODS_TITLE').AsString;
      beIDEN_DT.Text := fMasterDataSet.FieldByName('DT_IDENT').AsString;

      if (fMasterDataSet.FieldByName('DT_GOODS_SERIAL_TYPE').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
      begin
        lbIDEN_DT.Caption := 'Numar de serie';
        fGoodsDTisSerial := True;
      end
      else
      begin
        lbIDEN_DT.Caption := 'Partida';
        fGoodsDTisSerial := False;
      end;

      if (fMasterDataSet.FieldByName('CT_GOODS_SERIAL_TYPE').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
      begin
        lbIDEN_CT.Caption := 'Numar de serie';
        fGoodsCTisSerial := True;
      end
      else
      begin
        lbIDEN_CT.Caption := 'Partida';
        fGoodsCTisSerial := False;
      end;

      edCOUNTRY_DT.Text := fMasterDataSet.FieldByName('DT_COUNTRY_NAME').AsString;
      edVENDOR_DT.Text := fMasterDataSet.FieldByName('DT_VENDOR_NAME').AsString;
      beCountryID_CT.Text := fMasterDataSet.FieldByName('CT_COUNTRY_NAME').AsString;
      beVendorID_CT.Text := fMasterDataSet.FieldByName('CT_VENDOR_NAME').AsString;

    end;
    dmDB.IBCQueryStocks.Active := True;

    IBC_IDENT.MasterSource := fMasterDataSource;
    IBC_IDENT.Open;
    IBC_IDENT.Edit;

    fInternalChange := True;
    cbDT_FLG_BALANCE.Checked := fMasterDataSet.FieldByName('DT_FLG_BALANCE').AsInteger = 1;
    // rbDT_FLG_BALANCE.Checked:=fMasterDataSet.FieldByName('DT_FLG_BALANCE').AsInteger=1;
    // rbDT_FLG_PERESORT.Checked:=fMasterDataSet.FieldByName('DT_FLG_PERESORT').AsInteger=1;
    cbCT_FLG_BALANCE.Checked := fMasterDataSet.FieldByName('CT_FLG_BALANCE').AsInteger = 1;

    // rbCT_FLG_BALANCE.Checked:=fMasterDataSet.FieldByName('CT_FLG_BALANCE').AsInteger=1;
    // rbCT_FLG_PERESORT.Checked:=fMasterDataSet.FieldByName('CT_FLG_PERESORT').AsInteger=1;

    if not FReadOnly then
    begin
      if cbDT_FLG_BALANCE.Checked then
        pnTarget.Enabled := False;
      if cbCT_FLG_BALANCE.Checked then
        pnSource.Enabled := False;
    end;

    // if (pnTarget.Enabled) and (pnSource.Enabled) then
    // MessageDlg('Sunati urgent la Administrator, ii laja!', mtError, [mbOK],0);
    fInternalChange := False;

  except
    if not FReadOnly then
    begin
      if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
    end;
    raise;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.rbCT_FLG_BALANCE1Click(Sender: TObject);
begin
  CT_FLAGS_Changed;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.rbDT_FLG_BALANCE1Click(Sender: TObject);
begin
  DT_FLAGS_Changed;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectCountry;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(Self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(27);
    dialog.SYSSID := fMasterDataSet.FieldByName('CT_COUNTRYID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('CT_COUNTRYID').AsInteger := dialog.SYSSID;
      beCountryID_CT.Text := dialog.SyssTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectGoodsCT;
var
  dialog: TfrmGoodsBrowser;
  goodsID: integer;
  tmpSuma: Currency;
  tmpRate: Double;
begin
  goodsID := 0;
  if not fMasterDataSet.FieldByName('CT_GOODSID').IsNull then
    goodsID := fMasterDataSet.FieldByName('CT_GOODSID').AsInteger;

  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(goodsID, False, 0, 'Alageti produsul pentru a fi inlocuit') then
    begin
      fMasterDataSet.FieldByName('CT_GOODSID').AsInteger := dialog.goodsID;
      beGOODS_CT.Text := dialog.GoodsTitle;
      fGoodsCTisSerial := dialog.IsSerialTypeSerialNumber(dialog.GoodsSerialType);
      if fGoodsCTisSerial then
        lbIDEN_CT.Caption := 'Numar de serie'
      else
        lbIDEN_CT.Caption := 'Numar de partida';

      if dmDB.TransformCurrency1(dialog.GoodsPrice[0], dialog.GoodsPriceCurrencyID, FDocCurrencyID, FDocFlgACNT, tmpSuma, tmpRate, True, True) then
        fMasterDataSet.FieldByName('CT_PRICE').AsCurrency := tmpSuma
      else
        fMasterDataSet.FieldByName('CT_PRICE').Value := Null;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectGoodsDT;
var
  dialog: TfrmGoodsBrowser;
  goodsID: integer;
  tmpSuma: Currency;
  tmpRate: Double;
begin
  goodsID := 0;
  if not fMasterDataSet.FieldByName('DT_GOODSID').IsNull then
    goodsID := fMasterDataSet.FieldByName('DT_GOODSID').AsInteger;

  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(goodsID, False, 0, 'Alageti produsul pentru a fi inlocuit') then
    begin
      fMasterDataSet.FieldByName('DT_GOODSID').AsInteger := dialog.goodsID;
      beGOODS_DT.Text := dialog.GoodsTitle;
      fGoodsDTisSerial := dialog.IsSerialTypeSerialNumber(dialog.GoodsSerialType);
      if fGoodsDTisSerial then
        lbIDEN_DT.Caption := 'Numar de serie'
      else
        lbIDEN_DT.Caption := 'Numar de partida';
      fMasterDataSet.FieldByName('DT_IDENT').Value := Null;
      beIDEN_DT.Text := '';
      // pretul 0
      if dmDB.TransformCurrency1(dialog.GoodsPrice[0], dialog.GoodsPriceCurrencyID, FDocCurrencyID, FDocFlgACNT, tmpSuma, tmpRate, True, True) then
        fMasterDataSet.FieldByName('DT_PRICE').AsCurrency := tmpSuma
      else
        fMasterDataSet.FieldByName('DT_PRICE').Value := Null;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectGoodsDTPartNumber;
var
  dialog: Tfrm52ZamenaTovaraSelectPartNoDlg;
  cvInfo: Tfrm52ZamenaTovaraCountryVendorInfo;
begin
  dialog := Tfrm52ZamenaTovaraSelectPartNoDlg.Create(Self);
  try
    dialog.goodsID := fMasterDataSet.FieldByName('DT_GOODSID').AsInteger;
    dialog.DEP := fMasterDataSet.FieldByName('DT_DEP').AsInteger;
    ;
    dialog.DocData := fDocData;
    dialog.GoodsTitle := beGOODS_CT.Text;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('DT_IDENT').AsString := dialog.PartNO;
      beIDEN_DT.Text := dialog.PartNO;

      cvInfo := GenCountryVendorInfo(dialog.CountryID, dialog.VendorID);
      if Assigned(cvInfo) then
      try
        fMasterDataSet.FieldByName('DT_COUNTRYID').AsInteger := cvInfo.CountryID;
        fMasterDataSet.FieldByName('DT_VENDORID').AsInteger := cvInfo.VendorID;
        edCOUNTRY_DT.Text := cvInfo.CountryName;
        edVENDOR_DT.Text := cvInfo.VendorName;
      finally
        cvInfo.Free;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectGoodsDTSerialNumber;
var
  dialog: Tfrm52ZamenaTovaraSelectSNDlg;
  cvInfo: Tfrm52ZamenaTovaraCountryVendorInfo;
begin
  if fMasterDataSet.FieldByName('DT_GOODSID').IsNull then
    ShowErrorDialog('Eroare', 'Selectati marfa mai intai!')
  else
  begin
    dialog := Tfrm52ZamenaTovaraSelectSNDlg.Create(Self);
    try
      dialog.goodsID := fMasterDataSet.FieldByName('DT_GOODSID').AsInteger;
      dialog.DEP := fMasterDataSet.FieldByName('DT_DEP').AsInteger;
      dialog.Data := fDocData;
      dialog.GoodsTitle := beGOODS_DT.Text;
      if dialog.ShowModal = mrOk then
      begin
        fMasterDataSet.FieldByName('DT_IDENT').AsString := dialog.SN;
        beIDEN_DT.Text := dialog.SN;
        cvInfo := GenCountryVendorInfo(dialog.CountryID, dialog.VendorID);
        if Assigned(cvInfo) then
        try
          fMasterDataSet.FieldByName('DT_COUNTRYID').AsInteger := cvInfo.CountryID;
          fMasterDataSet.FieldByName('DT_VENDORID').AsInteger := cvInfo.VendorID;
          edCOUNTRY_DT.Text := cvInfo.CountryName;
          edVENDOR_DT.Text := cvInfo.VendorName;
        finally
          cvInfo.Free;
        end;
      end;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SelectVendor;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(Self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(1);
    dialog.SYSSID := fMasterDataSet.FieldByName('CT_VENDORID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('CT_VENDORID').AsInteger := dialog.SYSSID;
      beVendorID_CT.Text := dialog.SyssTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetCT_IDENT_Format(const Value: string);
begin
  FCT_IDENT_Format := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetDocCurrencyID(const Value: integer);
begin
  FDocCurrencyID := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetDocData(const Value: TDateTime);
begin
  fDocData := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetDocFlgACNT(const Value: Boolean);
begin
  FDocFlgACNT := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetDocID(const Value: integer);
begin
  FDocID := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetDT_DEP(const Value: integer);
begin
  FDT_DEP := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure Tfrm52ZamenaTovaraEditorDlg.WhenCancelForm;
begin
  if not FReadOnly then
  begin
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

end.

