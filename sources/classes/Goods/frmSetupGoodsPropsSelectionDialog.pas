unit frmSetupGoodsPropsSelectionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, SWNUtils, Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls,
  cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxDBLookupComboBox, DB, DBAccess, IBC, cxButtonEdit, Vcl.Menus, cxButtons, MemDS, cxLookupEdit, cxDBLookupEdit, Vcl.NumberBox,
  dxUIAClasses, dxCoreGraphics;

type

  TfrmSetupGoodsPropsSelectionDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cbWebGoodsType: TCheckBox;
    lcbWebGoodsType: TcxLookupComboBox;
    lcbVendorID: TcxLookupComboBox;
    cbVendorID: TCheckBox;
    cbBaseParam: TCheckBox;
    edBaseParam: TEdit;
    lbInfoText: TLabel;
    lbGoodsCount: TLabel;
    IBCDataSourceVendors: TIBCDataSource;
    IBCQueryVendors: TIBCQuery;
    IBCQueryWebGoodsType: TIBCQuery;
    IBCDataSourceWebGoodsType: TIBCDataSource;
    cbGoodsACNT: TCheckBox;
    beGoodsACNT: TcxButtonEdit;
    cbGoodsType: TCheckBox;
    lcbGoodsType: TcxLookupComboBox;
    IBCQuerySysS: TIBCQuery;
    IBCDSSysS: TIBCDataSource;
    edWaranty: TEdit;
    lcbTipEvidenta: TcxLookupComboBox;
    cbTipEvidenta: TCheckBox;
    cbUM: TCheckBox;
    cbWaranty: TCheckBox;
    lcbUM: TcxLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cbPrefix: TCheckBox;
    edPrefixName: TEdit;
    IBCQueryTipEvidenta: TIBCQuery;
    IBCDataSourceTipEvidenta: TIBCDataSource;
    IBCQueryUM: TIBCQuery;
    IBCDataSourceUM: TIBCDataSource;
    cbFilterParams: TCheckBox;
    beFilterSelect: TcxButtonEdit;
    beFilterValueSelect: TcxButtonEdit;
    procedure cbWebGoodsTypeClick(Sender: TObject);
    procedure beGoodsACNTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure cxLookupComboBox2PropertiesInitPopup(Sender: TObject);
    procedure beFilterSelectPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    fSelectionResult: TGoodsPropertySelectionData;
    fGoodsACNT: Integer;

    function CheckValues: Boolean;

    procedure SelectGoodsAcnt;
    procedure SelectFilterParam;
    procedure SetFilterParam(const FilterID, FilterParamID: Integer; const FilterName, FilterParamValue: string);
    procedure RestoreLastFilterParam;
    procedure StoreLastFilterParam;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    procedure SetGoodsCount(const Count: Integer);
    property SelectionData: TGoodsPropertySelectionData read fSelectionResult;

  end;

implementation

uses DataModuleDB, SWNConst, frmGoodsACNTBrowser, frmWebFiltersDialog, SWNValueStorageUnit;

{$R *.dfm}

const
  // ultimul filtru / ultima valoare aleasa - se pastreaza in setarile utilizatorului
  cStorageSection = 'frmSetupGoodsPropsSelectionDlg';
  cStorageKey_FilterID = 'LAST_FILTERID';
  cStorageKey_FilterParamID = 'LAST_FILTERPARAMID';

procedure TfrmSetupGoodsPropsSelectionDlg.beGoodsACNTPropertiesButtonClick
  (Sender: TObject; AButtonIndex: Integer);
begin
  SelectGoodsAcnt;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.beFilterSelectPropertiesButtonClick
  (Sender: TObject; AButtonIndex: Integer);
begin
  SelectFilterParam;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.cbWebGoodsTypeClick(Sender: TObject);
begin
  lcbWebGoodsType.Enabled := cbWebGoodsType.Checked;
  lcbGoodsType.Enabled := cbGoodsType.Checked;
  lcbVendorID.Enabled := cbVendorID.Checked;
  edBaseParam.Enabled := cbBaseParam.Checked;
  beGoodsACNT.Enabled := cbGoodsACNT.Checked;
  edWaranty.Enabled := cbWaranty.Checked;
  lcbTipEvidenta.Enabled := cbTipEvidenta.Checked;
  edPrefixName.Enabled := cbPrefix.Checked;
  lcbUM.Enabled := cbUM.Checked;
  beFilterSelect.Enabled := cbFilterParams.Checked;
  beFilterValueSelect.Enabled := cbFilterParams.Checked;
end;

function TfrmSetupGoodsPropsSelectionDlg.CheckValues: Boolean;
var
  ErrorStr: String;
begin
  Result := False;

  if cbWebGoodsType.Checked and (lcbWebGoodsType.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Tip produs web!');
  if cbVendorID.Checked and (lcbVendorID.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Producator!');
  if cbBaseParam.Checked and (Trim(edBaseParam.Text) = '') then
    AddErrorToStr(ErrorStr, 'Parametru de baza!');

  if cbWaranty.Checked and (Trim(edWaranty.Text) = '') then
    AddErrorToStr(ErrorStr, 'Garantia!');

  if cbGoodsACNT.Checked and (fGoodsACNT = -1) then
    AddErrorToStr(ErrorStr, 'Denumire factura!');
  if cbGoodsType.Checked and (lcbGoodsType.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Tip produs!');
  if (cbPrefix.Checked) and (edPrefixName.Text = '') then
      AddErrorToStr(ErrorStr, 'Prefixul in denumirea produsului!');

  if cbFilterParams.Checked and (beFilterSelect.Tag <= 0) then
    AddErrorToStr(ErrorStr, 'Filtru!');
  if cbFilterParams.Checked and (beFilterValueSelect.Tag <= 0) then
    AddErrorToStr(ErrorStr, 'Valoarea filtrului!');

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmSetupGoodsPropsSelectionDlg.cxLookupComboBox2PropertiesInitPopup(Sender: TObject);
begin
  IBCQuerySysS.Close;
  IBCQuerySysS.SQL.Text := 'SELECT * FROM TS_UM'; // единица измерения
  IBCQuerySysS.Open;

end;

procedure TfrmSetupGoodsPropsSelectionDlg.FormCreate(Sender: TObject);
begin
  fGoodsACNT := -1;
  beFilterSelect.Tag := -1;
  beFilterValueSelect.Tag := -1;
end;

function TfrmSetupGoodsPropsSelectionDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    // save values
    fSelectionResult.Change_WebGoodsTypeID := cbWebGoodsType.Checked;
    fSelectionResult.Change_VendorID := cbVendorID.Checked;
    fSelectionResult.Change_BaseParam := cbBaseParam.Checked;
    fSelectionResult.Change_Waranty := cbWaranty.Checked;
    fSelectionResult.Change_GoodsACNT := cbGoodsACNT.Checked;
    fSelectionResult.Change_GoodsTypeID := cbGoodsType.Checked;
    fSelectionResult.Change_PrefixName := cbPrefix.Checked;
    fSelectionResult.Change_TipEvidenta := cbTipEvidenta.Checked;
    fSelectionResult.Change_UM := cbUM.Checked;
    fSelectionResult.Change_FilterID := cbFilterParams.Checked;

    fSelectionResult.Value_WebGoodsTypeID := lcbWebGoodsType.EditValue;
    fSelectionResult.Value_VendorID := lcbVendorID.EditValue;
    fSelectionResult.Value_BaseParam := Trim(edBaseParam.Text);
    fSelectionResult.Value_Waranty := Trim(edWaranty.Text);
    fSelectionResult.Value_GoodsACNT := fGoodsACNT;
    fSelectionResult.Value_GoodsTypeID := lcbGoodsType.EditValue;
    fSelectionResult.Value_PrefixName := trim(edPrefixName.Text);
    fSelectionResult.Value_TipEvidenta := lcbTipEvidenta.EditValue;
    fSelectionResult.Value_UM := lcbUM.EditValue;
    fSelectionResult.Value_FilterID := beFilterSelect.Tag;
    fSelectionResult.Value_FilterParamID := beFilterValueSelect.Tag;

    // ok?
    Result := fSelectionResult.Change_WebGoodsTypeID or
              fSelectionResult.Change_VendorID or
              fSelectionResult.Change_BaseParam or
              fSelectionResult.Change_GoodsACNT or
              fSelectionResult.Change_GoodsTypeID or
              fSelectionResult.Change_Waranty or
              fSelectionResult.Change_UM or
              fSelectionResult.Change_PrefixName or
              fSelectionResult.Change_TipEvidenta or
              fSelectionResult.Change_FilterID;
  end;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.Prepare;
begin
  inherited;

  IBCQueryWebGoodsType.Active := True;
  IBCQueryVendors.Active := True;
  edBaseParam.Text := '';
  edWaranty.Text := '24';
  edPrefixName.Text := '';

  fSelectionResult.Change_WebGoodsTypeID := False;
  fSelectionResult.Change_GoodsTypeID := False;
  fSelectionResult.Change_VendorID := False;
  fSelectionResult.Change_BaseParam := False;

  IBCQueryUM.Open;
  IBCQueryTipEvidenta.Open;
  IBCQuerySysS.Open;

  RestoreLastFilterParam;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.SelectGoodsAcnt;
var
  dialog: TfrmGoodsACNTDlg;
begin
  dialog := TfrmGoodsACNTDlg.Create(Self);
  try
    if dialog.SelectGoodsAcnt(fGoodsACNT) then
    begin
      fGoodsACNT := dialog.GoodsAcntID;
      beGoodsACNT.Text := dialog.GoodsAcntTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.SelectFilterParam;
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: Integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmDB.IBCConnection);
  try
    defaultFilterID := beFilterSelect.Tag;
    defaultFilterParamID := beFilterValueSelect.Tag;

    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      SetFilterParam(dialog.FilterID, dialog.FilterParamID, dialog.FilterNameRom, dialog.FilterParamValueRom);
      StoreLastFilterParam;
    end;
  finally
    dialog.Free;
  end;
end;

// ID-urile se tin in Tag, textul afisat e denumirea (RO) a filtrului / valorii
procedure TfrmSetupGoodsPropsSelectionDlg.SetFilterParam(const FilterID, FilterParamID: Integer;
  const FilterName, FilterParamValue: string);
begin
  beFilterSelect.Tag := FilterID;
  beFilterSelect.Text := FilterName;
  beFilterValueSelect.Tag := FilterParamID;
  beFilterValueSelect.Text := FilterParamValue;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.RestoreLastFilterParam;
var
  LastFilterID, LastFilterParamID: Integer;
  Query: TIBCQuery;
begin
  AppUserConfigStorage.OpenSection(cStorageSection);
  try
    LastFilterID := AppUserConfigStorage.IntValues.GetValue(cStorageKey_FilterID, -1);
    LastFilterParamID := AppUserConfigStorage.IntValues.GetValue(cStorageKey_FilterParamID, -1);
  finally
    AppUserConfigStorage.CloseSection;
  end;

  if (LastFilterID <= 0) and (LastFilterParamID <= 0) then
    Exit;

  // denumirile se citesc din baza (pot fi redenumite intre timp)
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;

    // 1. valoarea salvata; filtrul se ia din ea, ca perechea sa ramana consistenta
    if LastFilterParamID > 0 then
    begin
      Query.SQL.Text :=
        'SELECT P.FILTERID, P.FILTERPARAMID, F.FILTERNAME, P.PARAM_VALUE ' +
        'FROM TS_FILTER_PARAMS P ' +
        'JOIN TS_FILTERS F ON F.FILTERID = P.FILTERID ' +
        'WHERE P.FILTERPARAMID = :FILTERPARAMID';
      Query.ParamByName('FILTERPARAMID').AsInteger := LastFilterParamID;
      Query.Open;
      if not Query.IsEmpty then
      begin
        SetFilterParam(Query.FieldByName('FILTERID').AsInteger, Query.FieldByName('FILTERPARAMID').AsInteger,
          Query.FieldByName('FILTERNAME').AsString, Query.FieldByName('PARAM_VALUE').AsString);
        Exit;
      end;
      Query.Close;
    end;

    // 2. valoarea nu mai exista - pastram macar filtrul, ca selectorul sa se deschida pe el
    if LastFilterID > 0 then
    begin
      Query.SQL.Text := 'SELECT FILTERNAME FROM TS_FILTERS WHERE FILTERID = :FILTERID';
      Query.ParamByName('FILTERID').AsInteger := LastFilterID;
      Query.Open;
      if not Query.IsEmpty then
        SetFilterParam(LastFilterID, -1, Query.FieldByName('FILTERNAME').AsString, '');
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmSetupGoodsPropsSelectionDlg.StoreLastFilterParam;
begin
  AppUserConfigStorage.OpenSection(cStorageSection);
  try
    AppUserConfigStorage.IntValues.SetValue(cStorageKey_FilterID, beFilterSelect.Tag);
    AppUserConfigStorage.IntValues.SetValue(cStorageKey_FilterParamID, beFilterValueSelect.Tag);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;
procedure TfrmSetupGoodsPropsSelectionDlg.SetGoodsCount(const Count: Integer);
begin
  lbGoodsCount.Caption := IntToStr(Count);
end;

end.
