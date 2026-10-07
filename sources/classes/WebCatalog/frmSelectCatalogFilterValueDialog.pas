unit frmSelectCatalogFilterValueDialog;

(* Picker pentru o mapa virtuala din webcatalog: alege un filtru (TS_FILTERS,
   ex. Gen) si o valoare a lui (TS_FILTER_PARAMS, ex. Masculin).
   Intoarce FilterID + ParamIDs (CSV de FILTERPARAMID; iteratia 1 = o valoare).

   Sus-stanga: categoria de produse (TS_GOODS_TYPE, RO + RU) - lookup cu grila
   in lista derulanta (cautare + filtrare).

   Grile master-detail:
     - stanga: filtrele din sablonul categoriei alese (TS_GOODS_TYPE_FILTERS,
       in ordinea sablonului); fara categorie = toate filtrele TS_FILTERS
       (non-folder) - asa raman accesibile filtrele care nu sunt in niciun
       sablon, ex. Producatori
     - dreapta: TS_FILTER_PARAMS al filtrului selectat *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
    cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData,
  dxCoreGraphics, cxTextEdit, cxMaskEdit, cxButtonEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDBExtLookupComboBox;

type
    TfrmSelectCatalogFilterValueDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryFilters: TIBCQuery;
        IBCDataSourceFilters: TIBCDataSource;
        IBCQueryParams: TIBCQuery;
        IBCDataSourceParams: TIBCDataSource;
        cxGridFilters: TcxGrid;
        cxGridFiltersTable: TcxGridDBTableView;
        cxGridFiltersLevel: TcxGridLevel;
        cxGridFilters_FILTERNAME: TcxGridDBColumn;
        cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn;
        cxGridParams: TcxGrid;
        cxGridParamsTable: TcxGridDBTableView;
        cxGridParamsLevel: TcxGridLevel;
        cxGridParams_PARAM_VALUE: TcxGridDBColumn;
        cxGridParams_PARAM_VALUE_RUS: TcxGridDBColumn;
        btnOk: TcxButton;
        btnCancel: TcxButton;
    cxGridFilters_FILTERID: TcxGridDBColumn;
    cxGridParams_FILTERPARAMID: TcxGridDBColumn;
    cxButtonEdit1: TcxButtonEdit;
        lbGoodsType: TLabel;
        cxLookupGoodsType: TcxExtLookupComboBox;
        IBCQueryGoodsType: TIBCQuery;
        IBCDataSourceGoodsType: TIBCDataSource;
        cxGridViewRepository: TcxGridViewRepository;
        cxGridGoodsTypeView: TcxGridDBTableView;
        cxGridGoodsType_GOODSTYPEID: TcxGridDBColumn;
        cxGridGoodsType_TITLE: TcxGridDBColumn;
        cxGridGoodsType_TITLE_RUS: TcxGridDBColumn;
        cxGridGoodsType_FILTERS_CNT: TcxGridDBColumn;
        procedure cxGridParamsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
        procedure cxLookupGoodsTypePropertiesEditValueChanged(Sender: TObject);
    private
        FFilterID: Integer;
        FParamIDs: string;
        FGoodsTypeID: Integer;
        procedure ReloadFilters;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        function SelectSyssID(Value: Integer): Integer;
        property FilterID: Integer read FFilterID write FFilterID;
        property ParamIDs: string read FParamIDs write FParamIDs;
        { categoria preselectata (0 = fara); la OK intoarce categoria ramasa aleasa }
        property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    end;

implementation

uses
  DataModuleDB, frmSyssDataEditor, frmSyssEditorWindow;

{$R *.dfm}

{ TfrmSelectCatalogFilterValueDlg }

procedure TfrmSelectCatalogFilterValueDlg.Prepare;
begin
    dtDialogTitle.Text := 'Alege categoria de produse, apoi atributul (filtru) si valoarea. ' +
        'Fara categorie (Del) se afiseaza toate filtrele.';
    IBCQueryGoodsType.Connection := dmDB.IBCConnection;
    IBCQueryGoodsType.Transaction := dmDB.IBCTrDefaultSelect;
    IBCQueryFilters.Connection := dmDB.IBCConnection;
    IBCQueryFilters.Transaction := dmDB.IBCTrDefaultSelect;
    IBCQueryParams.Connection := dmDB.IBCConnection;
    IBCQueryParams.Transaction := dmDB.IBCTrDefaultSelect;

    IBCQueryGoodsType.Open;
    { mapa virtuala nu tine minte categoria: vine de la apelant (ultima aleasa)
      sau ramane goala = toate filtrele }
    if (FGoodsTypeID > 0) and IBCQueryGoodsType.Locate('GOODSTYPEID', FGoodsTypeID, []) then
        cxLookupGoodsType.EditValue := FGoodsTypeID;
    ReloadFilters;
    if (FFilterID > 0) and not IBCQueryFilters.Locate('FILTERID', FFilterID, []) and
        not VarIsNull(cxLookupGoodsType.EditValue) then
    begin
        { filtrul curent nu e in sablonul categoriei: aratam toate filtrele }
        cxLookupGoodsType.Clear;
        ReloadFilters;
        IBCQueryFilters.Locate('FILTERID', FFilterID, []);
    end;
    IBCQueryParams.Open; { detail: filtrat automat pe FILTERID prin master-detail }

    if (FFilterID > 0) and (Trim(FParamIDs) <> '') then
        IBCQueryParams.Locate('FILTERPARAMID', StrToIntDef(Trim(FParamIDs), -1), []);
end;

procedure TfrmSelectCatalogFilterValueDlg.ReloadFilters;
var
    KeepFilterID: Integer;
begin
    KeepFilterID := 0;
    if IBCQueryFilters.Active and not IBCQueryFilters.IsEmpty then
        KeepFilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;

    IBCQueryFilters.Close;
    if VarIsNull(cxLookupGoodsType.EditValue) or VarIsEmpty(cxLookupGoodsType.EditValue) then
        IBCQueryFilters.ParamByName('GOODSTYPEID').Clear
    else
        IBCQueryFilters.ParamByName('GOODSTYPEID').AsInteger := cxLookupGoodsType.EditValue;
    IBCQueryFilters.Open;

    { filtrul selectat ramane selectat daca exista si in noua lista }
    if (KeepFilterID > 0) then
        IBCQueryFilters.Locate('FILTERID', KeepFilterID, []);
end;

procedure TfrmSelectCatalogFilterValueDlg.cxLookupGoodsTypePropertiesEditValueChanged(Sender: TObject);
begin
    if IBCQueryGoodsType.Active then
        ReloadFilters;
end;

function TfrmSelectCatalogFilterValueDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if IBCQueryFilters.IsEmpty then
    begin
        if VarIsNull(cxLookupGoodsType.EditValue) or VarIsEmpty(cxLookupGoodsType.EditValue) then
            ShowMessage('Nu exista filtre definite.')
        else
            ShowMessage('Categoria aleasa nu are filtre in sablon.');
        Exit;
    end;
    if IBCQueryParams.IsEmpty then
    begin
        ShowMessage('Alegeti o valoare pentru filtrul selectat.');
        Exit;
    end;
    FFilterID := IBCQueryParams.FieldByName('FILTERID').AsInteger;
    FParamIDs := IBCQueryParams.FieldByName('FILTERPARAMID').AsString;
    if VarIsNull(cxLookupGoodsType.EditValue) or VarIsEmpty(cxLookupGoodsType.EditValue) then
        FGoodsTypeID := 0
    else
        FGoodsTypeID := cxLookupGoodsType.EditValue;
    Result := True;
end;

procedure TfrmSelectCatalogFilterValueDlg.cxButtonEdit1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
    if (FilterID = 10) then
    begin
      // producatori
//      FilterParamID := SelectSyssID(2);
    end;

end;

procedure TfrmSelectCatalogFilterValueDlg.cxGridParamsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    AHandled := True;
    ModalResult := mrOk;
end;

function TfrmSelectCatalogFilterValueDlg.SelectSyssID(Value: Integer): Integer;
begin
  Result := -1;
//  var d:=TfrmSelectSyssEditorWin.Create(Self);
//  d.SelectMode := True;
//  d.
end;

end.
