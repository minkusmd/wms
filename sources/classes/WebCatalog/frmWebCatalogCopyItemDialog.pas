unit frmWebCatalogCopyItemDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit;

type
  TfrmWebCatalogCopyItemDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cbCopyGoods: TCheckBox;
    edSourceItem: TEdit;
    edTargetParent: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cbCopyFilters: TCheckBox;
    cbCopyBanners: TCheckBox;
    cbCopyAlsoBuy: TCheckBox;
  private
    { Private declarations }
    FSourceCatalogID: Integer;
    FTargetParentCatalogID: Integer;
    procedure SetSourceCatalogID(const Value: Integer);
    procedure SetTargetParentCatalogID(const Value: Integer);

    procedure ReadInfo;
    function GetCopyAlsoBuy: Boolean;
    function GetCopyBaners: Boolean;
    function GetCopyFilters: Boolean;
    function GetCopyGoods: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property SourceCatalogID: Integer read FSourceCatalogID write SetSourceCatalogID;
    property TargetParentCatalogID: Integer read FTargetParentCatalogID write SetTargetParentCatalogID;
    property CopyGoods: Boolean read GetCopyGoods;
    property CopyFilters: Boolean read GetCopyFilters;
    property CopyBaners: Boolean read GetCopyBaners;
    property CopyAlsoBuy: Boolean read GetCopyAlsoBuy;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, IBC;

{ TfrmWebCatalogCopyItemDlg }

function TfrmWebCatalogCopyItemDlg.GetCopyAlsoBuy: Boolean;
begin
  Result := cbCopyAlsoBuy.Checked;
end;

function TfrmWebCatalogCopyItemDlg.GetCopyBaners: Boolean;
begin
  Result := cbCopyBanners.Checked;
end;

function TfrmWebCatalogCopyItemDlg.GetCopyFilters: Boolean;
begin
  Result := cbCopyFilters.Checked;
end;

function TfrmWebCatalogCopyItemDlg.GetCopyGoods: Boolean;
begin
  Result := cbCopyGoods.Checked;
end;

procedure TfrmWebCatalogCopyItemDlg.Prepare;
begin
  cbCopyGoods.Checked := True;
  cbCopyFilters.Checked := True;
  cbCopyBanners.Checked := True;
  cbCopyAlsoBuy.Checked := True;
  ReadInfo;
end;

procedure TfrmWebCatalogCopyItemDlg.ReadInfo;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('(SELECT TITLE_RUS FROM TWEB_CATALOG WHERE CATALOGID=:sid),');
    Query.SQL.Add('(SELECT TITLE_RUS FROM TWEB_CATALOG WHERE CATALOGID=:tid),');
    Query.SQL.Add('(SELECT COUNT(1) FROM TWEB_CATALOG_ITEMS WHERE CATALOGID=:sid),');
    Query.SQL.Add('(SELECT COUNT(1) FROM TWEB_CATALOG_BANNERS WHERE CATALOGID=:sid),');
    Query.SQL.Add('(SELECT COUNT(1) FROM TWEB_CATALOG_FILTERS WHERE CATALOGID=:sid),');
    Query.SQL.Add('(SELECT COUNT(1) FROM TWEB_CATALOG_ALSOBUY WHERE CATALOGID=:sid)');
    Query.SQL.Add('FROM RDB$DATABASE');
    Query.ParamByName('sid').Value := FSourceCatalogID;
    Query.ParamByName('tid').Value := FTargetParentCatalogID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      edSourceItem.Text := Query.Fields[0].AsString;
      edTargetParent.Text := Query.Fields[1].AsString;
      // sunt produse pentru a copia?
      if Query.Fields[2].AsInteger = 0 then
      begin
        cbCopyGoods.Enabled := False;
        cbCopyGoods.Checked := False;
      end;
      // sunt banere pentru a copia?
      if Query.Fields[3].AsInteger = 0 then
      begin
        cbCopyBanners.Enabled := False;
        cbCopyBanners.Checked := False;
      end;
      // sunt filtre pentru a copia?
      if Query.Fields[4].AsInteger = 0 then
      begin
        cbCopyFilters.Enabled := False;
        cbCopyFilters.Checked := False;
      end;
      // sunt produse Also Buy pentru a copia?
      if Query.Fields[5].AsInteger = 0 then
      begin
        cbCopyAlsoBuy.Enabled := False;
        cbCopyAlsoBuy.Checked := False;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebCatalogCopyItemDlg.SetSourceCatalogID(const Value: Integer);
begin
  FSourceCatalogID := Value;
end;

procedure TfrmWebCatalogCopyItemDlg.SetTargetParentCatalogID(const Value: Integer);
begin
  FTargetParentCatalogID := Value;
end;

end.
