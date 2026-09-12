unit frmWebDescriptionElementEditorDialog;

interface

uses
  Classes, Controls, DialogTitle, Dialogs, ExtCtrls, Forms, Graphics, Messages, SWNBaseUnit, StdCtrls,
  SysUtils, Variants, Windows, cxButtonEdit, cxButtons, cxCheckBox, cxContainer, cxControls, cxDBEdit, cxEdit,
  cxGraphics, cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxMemo, cxTextEdit, Vcl.Menus, cxGroupBox;

type
  TWebFilterInfo = class
    FilterID: integer;
    Filter_Title_Rom: string;
    Filter_Title_Rus: string;
    SimpleFilterValue_RO: string;
    SimpleFilterValue_RU: string;
  end;

  TfrmWebDescriptionElementEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxGroupBox1: TcxGroupBox;
    cbFLG_GROUP: TcxDBCheckBox;
    cbFLG_VISIBLE: TcxDBCheckBox;
    cbFLG_COMPATIBILITY: TcxDBCheckBox;
    cbFLG_COMPARE: TcxDBCheckBox;
    cxGroupBox3: TcxGroupBox;
    edFILTER_NAME_ROM: TcxTextEdit;
    btnChangeFilter: TcxButton;
    edFILTER_NAME_RUS: TcxTextEdit;
    mmPARAM_VALUE_RUS: TcxMemo;
    mmPARAM_VALUE_ROM: TcxMemo;
    Label7: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    procedure btnChangeFilterClick(Sender: TObject);
    procedure beFilterPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beFiltersPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure beFilterRoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewDescription: Boolean;
    FInGoodsDescription: Boolean;
    FIsCloning: Boolean;
    FClone_FLG_COMPARE: integer;
    FClone_FilterParamID: integer;
    FClone_OrderNO: integer;
    FClone_FLG_VISIBLE: integer;
    FClone_FLG_COMPATIBILITY: integer;
    FClone_FilterID: integer;
    FLastOpenedFilterID: integer;
    FLastOpenedFilterParamID: integer;
    procedure SetCreateNewDescription(const Value: Boolean);
    function CheckInputParams: Boolean;
    procedure ShowSelectFilterDialog;
    procedure SetInGoodsDescription(const Value: Boolean);
    procedure SetIsCloning(const Value: Boolean);
    procedure SetClone_FilterID(const Value: integer);
    procedure SetClone_FilterParamID(const Value: integer);
    procedure SetClone_FLG_COMPARE(const Value: integer);
    procedure SetClone_FLG_COMPATIBILITY(const Value: integer);
    procedure SetClone_FLG_VISIBLE(const Value: integer);
    procedure SetClone_OrderNO(const Value: integer);
    function GetFilterInfo(const FilterID: integer): TWebFilterInfo;
    procedure SetLastOpenedFilterID(const Value: integer);
    procedure SetLastOpenedFilterParamID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SelectOnlyFilterDialog;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewDescription: Boolean read fCreateNewDescription write SetCreateNewDescription;
    property InGoodsDescription: Boolean read FInGoodsDescription write SetInGoodsDescription;
    property IsCloning: Boolean read FIsCloning write SetIsCloning;
    property Clone_FilterID: integer read FClone_FilterID write SetClone_FilterID;
    property Clone_FilterParamID: integer read FClone_FilterParamID write SetClone_FilterParamID;
    property Clone_FLG_VISIBLE: integer read FClone_FLG_VISIBLE write SetClone_FLG_VISIBLE;
    property Clone_FLG_COMPATIBILITY: integer read FClone_FLG_COMPATIBILITY write SetClone_FLG_COMPATIBILITY;
    property Clone_FLG_COMPARE: integer read FClone_FLG_COMPARE write SetClone_FLG_COMPARE;
    property Clone_OrderNO: integer read FClone_OrderNO write SetClone_OrderNO;
    property LastOpenedFilterID: integer read FLastOpenedFilterID write SetLastOpenedFilterID;
    property LastOpenedFilterParamID: integer read FLastOpenedFilterParamID write SetLastOpenedFilterParamID;
  end;

implementation

uses
  SWNConst, SWNUtils, frmWebFiltersDialog, IBC, frmWebFiltersUnit, DataModuleDB;

{$R *.dfm}
{ TfrmWebDescriptionElementEditorDlg }

procedure TfrmWebDescriptionElementEditorDlg.btnChangeFilterClick(Sender: TObject);
begin
  ShowSelectFilterDialog;
end;

function TfrmWebDescriptionElementEditorDlg.CheckInputParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('FILTERID').IsNull then
    AddErrorToStr(ErrorStr, 'Filtru!');
  if fMasterDataSet.FieldByName('FILTERPARAMID').IsNull then
    AddErrorToStr(ErrorStr, 'Valoarea implicita!');

  if ErrorStr = '' then
    Result := true
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmWebDescriptionElementEditorDlg.GetFilterInfo(const FilterID: integer): TWebFilterInfo;
var
  Query: TIBCQuery;
begin
  Result := nil;
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text :=
      'SELECT FILTERID,FILTERNAME,FILTERNAME_RUS, Filter_value_ro, filter_value_ru FROM TS_FILTERS WHERE FILTERID=:ID';
    Query.ParamByName('ID').AsInteger := FilterID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      Result := TWebFilterInfo.Create;
      Result.FilterID := Query.Fields[0].AsInteger;
      Result.Filter_Title_Rom := Query.Fields[1].AsString;
      Result.Filter_Title_Rus := Query.Fields[2].AsString;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.beFilterPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectOnlyFilterDialog;
end;

procedure TfrmWebDescriptionElementEditorDlg.beFilterRoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
    defaultFilterID := -1;
    defaultFilterParamID := -1;
    if not fMasterDataSet.FieldByName('FILTERID').IsNull then
      defaultFilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
    if not fMasterDataSet.FieldByName('FILTERPARAMID').IsNull then
      defaultFilterParamID := fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger;
    if (defaultFilterID = -1) and (FLastOpenedFilterID > 0) then
    begin
      defaultFilterID := FLastOpenedFilterID;
      // defaultFilterParamID:=FLastOpenedFilterParamID;
    end;
    // daca e filtru simplu atunci cerem sa fie introdusa valoare

    // numai daca filterul este complex
    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      fMasterDataSet.FieldByName('FILTERID').AsInteger := dialog.FilterID;
      fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger := dialog.FilterParamID;
      btnChangeFilter.Default := False;
      btnOk.Default := true;
    end
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.beFiltersPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmFiltersDialog;
begin
  dialog := TfrmFiltersDialog.Create(self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.BindingDataSource;
begin
  FIsCloning := False;
  fCreateNewDescription := False;
  FLastOpenedFilterID := -1;
  FLastOpenedFilterParamID := -1;

  cbFLG_GROUP.DataBinding.DataSource := fMasterDataSource;
  cbFLG_VISIBLE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_COMPATIBILITY.DataBinding.DataSource := fMasterDataSource;
  cbFLG_COMPARE.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmWebDescriptionElementEditorDlg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    btnChangeFilterClick(Sender);
  end;
end;

function TfrmWebDescriptionElementEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    if fMasterDataSet.FieldByName('FLG_GROUP').AsInteger = 1 then
    begin
      // clear flags
      fMasterDataSet.FieldByName('FLG_COMPATIBILITY').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_COMPARE').AsInteger := 0;
    end;

    fMasterDataSet.Post;
    Result := true;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.Prepare;
var
  filterInfo: TWebFilterInfo;
begin
  if fCreateNewDescription then
  begin
    dtDialogTitle.Text := 'Creare caracteristica noua';

    fMasterDataSet.Insert;
    if (FIsCloning) then
    begin
      fMasterDataSet.FieldByName('FILTERID').AsInteger := FClone_FilterID;
      fMasterDataSet.FieldByName('FLG_GROUP').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_VISIBLE').AsInteger := FClone_FLG_VISIBLE;
      fMasterDataSet.FieldByName('FLG_COMPATIBILITY').AsInteger := FClone_FLG_COMPATIBILITY;
      fMasterDataSet.FieldByName('FLG_COMPARE').AsInteger := FClone_FLG_COMPATIBILITY;
      fMasterDataSet.FieldByName('ORDERNO').AsInteger := FClone_OrderNO;
      // show values
      filterInfo := GetFilterInfo(FClone_FilterID);
      if (filterInfo <> nil) then
      begin
        edFILTER_NAME_ROM.Text := filterInfo.Filter_Title_Rom;
        edFILTER_NAME_RUS.Text := filterInfo.Filter_Title_Rus;
      end;
    end
    else
    begin
      fMasterDataSet.FieldByName('FLG_GROUP').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_VISIBLE').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_COMPATIBILITY').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_COMPARE').AsInteger := 0;
//      fMasterDataSet.FieldByName('FLG_SIMPLE_PROPERTY').AsInteger := 0;
    end;
  end
  else
  begin
    dtDialogTitle.Text := 'Modificare caracteristica';
    fMasterDataSet.Edit;
    edFILTER_NAME_ROM.Text := fMasterDataSet.FieldByName('FILTERNAME_ROM').AsString;
    edFILTER_NAME_RUS.Text := fMasterDataSet.FieldByName('FILTERNAME_RUS').AsString;
    mmPARAM_VALUE_ROM.Text := fMasterDataSet.FieldByName('PARAM_VALUE_ROM').AsString;
    mmPARAM_VALUE_RUS.Text := fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.SelectOnlyFilterDialog;
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: integer;
begin
  // de mutat in alta parte goods_description_Dialog!!!
  dialog := TfrmWebFiltersDlg.Create(Self, dmDB.IBCConnection);
  try
    defaultFilterID := -1;
    defaultFilterParamID := -1;
    if not fMasterDataSet.FieldByName('FILTERID').IsNull then
      defaultFilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
//    if Not fMasterDataSet.FieldByName('FILTERPARAMID').IsNull then
//      defaultFilterParamID := fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger;
    if (defaultFilterID = -1) and (FLastOpenedFilterID > 0) then
    begin
      defaultFilterID := FLastOpenedFilterID;
      // defaultFilterParamID:=FLastOpenedFilterParamID;
    end;

    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      fMasterDataSet.FieldByName('FILTERID').AsInteger := dialog.FilterID;
      fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger := dialog.FilterParamID;
      edFILTER_NAME_ROM.Text := dialog.FilterNameRom;
      edFILTER_NAME_RUS.Text := dialog.FilterNameRus;
      mmPARAM_VALUE_ROM.Text := dialog.FilterParamValueRom;
      mmPARAM_VALUE_RUS.Text := dialog.FilterParamValueRus;

      btnChangeFilter.Default := False;
      btnOk.Default := true;
    end
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_FilterID(const Value: integer);
begin
  FClone_FilterID := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_FilterParamID(const Value: integer);
begin
  FClone_FilterParamID := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_FLG_COMPARE(const Value: integer);
begin
  FClone_FLG_COMPARE := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_FLG_COMPATIBILITY(const Value: integer);
begin
  FClone_FLG_COMPATIBILITY := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_FLG_VISIBLE(const Value: integer);
begin
  FClone_FLG_VISIBLE := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetClone_OrderNO(const Value: integer);
begin
  FClone_OrderNO := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetCreateNewDescription(const Value: Boolean);
begin
  fCreateNewDescription := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetInGoodsDescription(const Value: Boolean);
begin
  FInGoodsDescription := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetIsCloning(const Value: Boolean);
begin
  FIsCloning := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetLastOpenedFilterID(const Value: integer);
begin
  FLastOpenedFilterID := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.SetLastOpenedFilterParamID(const Value: integer);
begin
  FLastOpenedFilterParamID := Value;
end;

procedure TfrmWebDescriptionElementEditorDlg.ShowSelectFilterDialog;
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
    defaultFilterID := -1;
    defaultFilterParamID := -1;
    if not fMasterDataSet.FieldByName('FILTERID').IsNull then
      defaultFilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
    if not fMasterDataSet.FieldByName('FILTERPARAMID').IsNull then
      defaultFilterParamID := fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger;
    if (defaultFilterID = -1) and (FLastOpenedFilterID > 0) then
    begin
      defaultFilterID := FLastOpenedFilterID;
      // defaultFilterParamID:=FLastOpenedFilterParamID;
    end;
    // daca e filtru simplu atunci cerem sa fie introdusa valoare

    // numai daca filterul este complex
    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      fMasterDataSet.FieldByName('FILTERID').AsInteger := dialog.FilterID;
      fMasterDataSet.FieldByName('FILTERPARAMID').AsInteger := dialog.FilterParamID;
      edFILTER_NAME_ROM.Text := dialog.FilterNameRom;
      edFILTER_NAME_RUS.Text := dialog.FilterNameRus;
      mmPARAM_VALUE_ROM.Text := dialog.FilterParamValueRom;
      mmPARAM_VALUE_RUS.Text := dialog.FilterParamValueRus;

      btnChangeFilter.Default := False;
      btnOk.Default := true;
    end
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionElementEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.

