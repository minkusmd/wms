unit frmGoodsTypeFolderSuggestDialog;

// Propunerea folderului pentru un tip de produs: folderele in care stau deja produsele
// tipului (TS_GOODS.WEBGOODSTYPE_ID), cu numarul de produse, descrescator.
// ShowModal: mrOk - folderul ales (FolderID / FolderTitle); mrRetry - "Alt folder..." (alegere din arbore).

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  Vcl.Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DialogTitle, dxScrollbarAnnotations;

type
  TfrmGoodsTypeFolderSuggestDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    cxGrid1: TcxGrid;
    tvFolders: TcxGridDBTableView;
    tvFoldersGOODSID: TcxGridDBColumn;
    tvFoldersTITLE: TcxGridDBColumn;
    tvFoldersGOODS_COUNT: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    btnSelect: TcxButton;
    btnOtherFolder: TcxButton;
    btnCancel: TcxButton;
    IBCQueryFolders: TIBCQuery;
    IBCDataSourceFolders: TIBCDataSource;
    procedure tvFoldersCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure tvFoldersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCurrentFolderID: Integer;
    FFolderID: Integer;
    FFolderTitle: string;
    FGoodsTypeID: Integer;
    FGoodsTypeTitle: string;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property CurrentFolderID: Integer read FCurrentFolderID write FCurrentFolderID;
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    property GoodsTypeTitle: string read FGoodsTypeTitle write FGoodsTypeTitle;
    property FolderID: Integer read FFolderID;
    property FolderTitle: string read FFolderTitle;
  end;

implementation

uses
  DataModuleAdditions;

{$R *.dfm}

{ TfrmGoodsTypeFolderSuggestDlg }

function TfrmGoodsTypeFolderSuggestDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if ModalResult <> mrOk then
    Exit; // mrRetry: folderul se alege din arbore, in editorul tipului

  Result := not IBCQueryFolders.IsEmpty;
  if Result then
  begin
    FFolderID := IBCQueryFolders.FieldByName('GOODSID').AsInteger;
    FFolderTitle := IBCQueryFolders.FieldByName('TITLE').AsString;
  end;
end;

procedure TfrmGoodsTypeFolderSuggestDlg.Prepare;
begin
  inherited;
  FFolderID := 0;
  FFolderTitle := '';

  IBCQueryFolders.Close;
  IBCQueryFolders.Connection := IBCConnection;
  IBCQueryFolders.ParamByName('GOODSTYPEID').AsInteger := FGoodsTypeID;
  IBCQueryFolders.Open;

  if IBCQueryFolders.IsEmpty then
    DialogTitle1.Text := Format('Nu exista produse de tipul "%s" - alegeti folderul din arbore ("Alt folder...").',
      [FGoodsTypeTitle])
  else
  begin
    DialogTitle1.Text := Format('Folderele in care se afla produsele de tipul "%s" (dupa numarul de produse).',
      [FGoodsTypeTitle]);
    if FCurrentFolderID > 0 then
      IBCQueryFolders.Locate('GOODSID', FCurrentFolderID, []);
  end;
  btnSelect.Enabled := not IBCQueryFolders.IsEmpty;
end;

procedure TfrmGoodsTypeFolderSuggestDlg.tvFoldersCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AHandled := True;
  ModalResult := mrOk;
end;

procedure TfrmGoodsTypeFolderSuggestDlg.tvFoldersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) and btnSelect.Enabled then
  begin
    Key := 0;
    ModalResult := mrOk;
  end;
end;

end.
