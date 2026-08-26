unit frmSelectCatalogFilterValueDialog;

(* Picker pentru o mapa virtuala din webcatalog: alege un filtru (TS_FILTERS,
   ex. Gen) si o valoare a lui (TS_FILTER_PARAMS, ex. Masculin).
   Intoarce FilterID + ParamIDs (CSV de FILTERPARAMID; iteratia 1 = o valoare).

   Grile master-detail:
     - stanga: TS_FILTERS (non-folder)
     - dreapta: TS_FILTER_PARAMS al filtrului selectat *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
    cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData,
  dxCoreGraphics, cxTextEdit, cxMaskEdit, cxButtonEdit;

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
        procedure cxGridParamsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    private
        FFilterID: Integer;
        FParamIDs: string;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        function SelectSyssID(Value: Integer): Integer;
        property FilterID: Integer read FFilterID write FFilterID;
        property ParamIDs: string read FParamIDs write FParamIDs;
    end;

implementation

uses
  DataModuleDB, frmSyssDataEditor, frmSyssEditorWindow;

{$R *.dfm}

{ TfrmSelectCatalogFilterValueDlg }

procedure TfrmSelectCatalogFilterValueDlg.Prepare;
begin
    dtDialogTitle.Text := 'Alege atributul (filtru) si valoarea';
    IBCQueryFilters.Connection := dmDB.IBCConnection;
    IBCQueryFilters.Transaction := dmDB.IBCTrDefaultSelect;
    IBCQueryParams.Connection := dmDB.IBCConnection;
    IBCQueryParams.Transaction := dmDB.IBCTrDefaultSelect;

    IBCQueryFilters.Open;
    if (FFilterID > 0) then
        IBCQueryFilters.Locate('FILTERID', FFilterID, []);
    IBCQueryParams.Open; { detail: filtrat automat pe FILTERID prin master-detail }

    if (FFilterID > 0) and (Trim(FParamIDs) <> '') then
        IBCQueryParams.Locate('FILTERPARAMID', StrToIntDef(Trim(FParamIDs), -1), []);
end;

function TfrmSelectCatalogFilterValueDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if IBCQueryFilters.IsEmpty then
    begin
        ShowMessage('Nu exista filtre definite.');
        Exit;
    end;
    if IBCQueryParams.IsEmpty then
    begin
        ShowMessage('Alegeti o valoare pentru filtrul selectat.');
        Exit;
    end;
    FFilterID := IBCQueryParams.FieldByName('FILTERID').AsInteger;
    FParamIDs := IBCQueryParams.FieldByName('FILTERPARAMID').AsString;
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
