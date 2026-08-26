unit frmSelectFilterDialog;

{ Picker de filtru din dictionarul global TS_FILTERS.
  Se foloseste la adaugarea unui filtru in sablonul unui tip de produs
  (vezi frmGoodsTypeFiltersDialog).

  De ce cautare obligatorie si nu lista intreaga: in baza sunt ~3.600 de filtre,
  iar multe au acelasi nume, create separat pentru fiecare grupa de marfa
  ("Tip" apare de 113 ori, "Culoare" de 37). Ca operatorul sa aleaga filtrul
  POTRIVIT, grila arata coloana "Produse tip" - cate produse ale tipului curent
  folosesc deja acel filtru. Practic, cel cu numarul mare e cel corect.

  Coloana aceea se calculeaza cu un subselect peste TS_GOODS_FILTERS (aproape
  2 mln de randuri), de aceea rezultatele apar doar dupa o cautare - niciodata
  pe toata tabela. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
  cxGrid, cxButtons, cxTextEdit, cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
  TfrmSelectFilterDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTransactionSelect: TIBCTransaction;
    IBCQueryFilters: TIBCQuery;
    IBCDataSourceFilters: TIBCDataSource;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    pnTop: TPanel;
    lbSearch: TLabel;
    edSearch: TcxTextEdit;
    btnSearch: TcxButton;
    cxGridFlt: TcxGrid;
    cxGridFltTable: TcxGridDBTableView;
    cxGridFltLevel: TcxGridLevel;
    cxGridFlt_FILTERID: TcxGridDBColumn;
    cxGridFlt_FILTERNAME: TcxGridDBColumn;
    cxGridFlt_FILTERNAME_RUS: TcxGridDBColumn;
    cxGridFlt_PRODUSE_TIP: TcxGridDBColumn;
    procedure btnSearchClick(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridFltTableDblClick(Sender: TObject);
  private
    FGoodsTypeID: Integer;
    FSelectedFilterID: Integer;
    FSelectedFilterName: string;
    procedure DoSearch;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    property SelectedFilterID: Integer read FSelectedFilterID;
    property SelectedFilterName: string read FSelectedFilterName;
  end;

implementation

uses
  SWNUtils, DataModuleDB, System.UITypes;

{$R *.dfm}

{ TfrmSelectFilterDlg }

procedure TfrmSelectFilterDlg.Prepare;
begin
  FSelectedFilterID := 0;
  FSelectedFilterName := '';
  if not IBCTransactionSelect.Active then
    IBCTransactionSelect.StartTransaction;
  DialogTitle1.Text := 'Cautati filtrul dupa denumire';
end;

procedure TfrmSelectFilterDlg.DoSearch;
var
  s: string;
begin
  s := Trim(edSearch.Text);
  if Length(s) < 2 then
  begin
    ShowMessage('Introduceti cel putin 2 caractere pentru cautare.');
    Exit;
  end;

  IBCQueryFilters.Close;
  IBCQueryFilters.ParamByName('gtid').AsInteger := FGoodsTypeID;
  IBCQueryFilters.ParamByName('flt').AsString := '%' + AnsiUpperCase(s) + '%';
  IBCQueryFilters.Open;

  if IBCQueryFilters.IsEmpty then
    ShowMessage('Niciun filtru nu contine textul cautat.');
end;

procedure TfrmSelectFilterDlg.btnSearchClick(Sender: TObject);
begin
  DoSearch;
end;

procedure TfrmSelectFilterDlg.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    DoSearch;
  end;
end;

procedure TfrmSelectFilterDlg.cxGridFltTableDblClick(Sender: TObject);
begin
  if IBCQueryFilters.Active and (not IBCQueryFilters.IsEmpty) then
    ModalResult := mrOk;
end;

function TfrmSelectFilterDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if (not IBCQueryFilters.Active) or IBCQueryFilters.IsEmpty then
  begin
    ShowMessage('Selectati un filtru din lista.');
    Exit;
  end;
  FSelectedFilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
  FSelectedFilterName := IBCQueryFilters.FieldByName('FILTERNAME').AsString;
  Result := True;
end;

procedure TfrmSelectFilterDlg.WhenCancelForm;
begin
  FSelectedFilterID := 0;
  FSelectedFilterName := '';
end;

end.
