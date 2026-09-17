unit frmImportPricelistErrorUnit;

{
  Lista structurata a erorilor la importul unui pricelist (validare + inserare
  in baza). Dublu-click pe o eroare inchide lista si pozitioneaza cursorul pe
  celula respectiva din tabel (SelectedRow / SelectedColumn).
}

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Menus,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxButtons;

type
  TfrmImportPricelistErrorDlg = class(TForm)
    pnTop: TPanel;
    lbSummary: TLabel;
    lbHint: TLabel;
    cxGridErrors: TcxGrid;
    tvErrors: TcxGridTableView;
    tvErrorsStage: TcxGridColumn;
    tvErrorsRow: TcxGridColumn;
    tvErrorsCode: TcxGridColumn;
    tvErrorsColumn: TcxGridColumn;
    tvErrorsMessage: TcxGridColumn;
    tvErrorsCellColumn: TcxGridColumn;
    lvErrors: TcxGridLevel;
    pnBottom: TPanel;
    btnCopy: TcxButton;
    btnSave: TcxButton;
    btnClose: TcxButton;
    procedure btnCopyClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure tvErrorsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSelectedRow: Integer;
    FSelectedColumn: Integer;
    function ErrorsAsText: string;
    procedure UpdateSummary;
  public
    constructor Create(AOwner: TComponent); override;
    { ARow / ACellColumn = pozitia in tabel (0-based); -1 daca eroarea nu tine de o celula }
    procedure AddError(const AStage: string; const ARow: Integer; const ACode, AColumnTitle: string;
      const ACellColumn: Integer; const AMessage: string);
    function ErrorCount: Integer;
    property SelectedRow: Integer read FSelectedRow;
    property SelectedColumn: Integer read FSelectedColumn;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Clipbrd;

constructor TfrmImportPricelistErrorDlg.Create(AOwner: TComponent);
begin
  inherited;
  FSelectedRow := -1;
  FSelectedColumn := -1;
end;

procedure TfrmImportPricelistErrorDlg.AddError(const AStage: string; const ARow: Integer; const ACode, AColumnTitle:
  string; const ACellColumn: Integer; const AMessage: string);
var
  R: Integer;
  Msg: string;
begin
  { mesajele Firebird vin pe mai multe randuri - in grila le vrem pe unul singur }
  Msg := Trim(StringReplace(StringReplace(AMessage, #13#10, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]));

  tvErrors.DataController.BeginUpdate;
  try
    R := tvErrors.DataController.AppendRecord;
    tvErrors.DataController.Values[R, tvErrorsStage.Index] := AStage;
    if ARow >= 0 then
      tvErrors.DataController.Values[R, tvErrorsRow.Index] := ARow + 1 // numerotarea din antetul tabelului
    else
      tvErrors.DataController.Values[R, tvErrorsRow.Index] := Null;
    tvErrors.DataController.Values[R, tvErrorsCode.Index] := ACode;
    tvErrors.DataController.Values[R, tvErrorsColumn.Index] := AColumnTitle;
    tvErrors.DataController.Values[R, tvErrorsMessage.Index] := Msg;
    tvErrors.DataController.Values[R, tvErrorsCellColumn.Index] := ACellColumn;
  finally
    tvErrors.DataController.EndUpdate;
  end;
end;

function TfrmImportPricelistErrorDlg.ErrorCount: Integer;
begin
  Result := tvErrors.DataController.RecordCount;
end;

{ Textul respecta filtrul si sortarea curenta din grila; separator TAB ca sa se
  poata lipi direct in Excel. }
function TfrmImportPricelistErrorDlg.ErrorsAsText: string;
var
  SL: TStringList;
  I: Integer;
  Rec: TcxCustomGridRecord;
begin
  SL := TStringList.Create;
  try
    SL.Add('Etapa'#9'Rind'#9'Cod produs'#9'Coloana'#9'Eroare');
    for I := 0 to tvErrors.ViewData.RecordCount - 1 do
    begin
      Rec := tvErrors.ViewData.Records[I];
      if not Rec.IsData then
        Continue;
      SL.Add(VarToStr(Rec.Values[tvErrorsStage.Index]) + #9 + VarToStr(Rec.Values[tvErrorsRow.Index]) + #9 +
        VarToStr(Rec.Values[tvErrorsCode.Index]) + #9 + VarToStr(Rec.Values[tvErrorsColumn.Index]) + #9 +
        VarToStr(Rec.Values[tvErrorsMessage.Index]));
    end;
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TfrmImportPricelistErrorDlg.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := ErrorsAsText;
end;

procedure TfrmImportPricelistErrorDlg.btnSaveClick(Sender: TObject);
var
  dialog: TSaveDialog;
  SL: TStringList;
begin
  dialog := TSaveDialog.Create(Self);
  try
    dialog.DefaultExt := 'txt';
    dialog.Filter := 'Text cu TAB (*.txt)|*.txt|Toate fisierele (*.*)|*.*';
    dialog.FileName := 'erori_import_pricelist_' + FormatDateTime('yyyymmdd_hhnn', Now) + '.txt';
    dialog.Options := dialog.Options + [ofOverwritePrompt];
    if not dialog.Execute then
      Exit;
    SL := TStringList.Create;
    try
      SL.Text := ErrorsAsText;
      SL.SaveToFile(dialog.FileName, TEncoding.UTF8);
    finally
      SL.Free;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportPricelistErrorDlg.FormShow(Sender: TObject);
begin
  UpdateSummary;
  if ErrorCount > 0 then
  begin
    tvErrors.Controller.FocusedRowIndex := 0;
    cxGridErrors.SetFocus;
  end;
end;

procedure TfrmImportPricelistErrorDlg.tvErrorsDblClick(Sender: TObject);
var
  Rec: TcxCustomGridRecord;
begin
  Rec := tvErrors.Controller.FocusedRecord;
  if not Assigned(Rec) or not Rec.IsData or VarIsNull(Rec.Values[tvErrorsRow.Index]) then
    Exit;

  FSelectedRow := Integer(Rec.Values[tvErrorsRow.Index]) - 1;
  if VarIsNull(Rec.Values[tvErrorsCellColumn.Index]) then
    FSelectedColumn := 0
  else
    FSelectedColumn := Rec.Values[tvErrorsCellColumn.Index];
  if FSelectedColumn < 0 then
    FSelectedColumn := 0;
  ModalResult := mrOk;
end;

procedure TfrmImportPricelistErrorDlg.UpdateSummary;
var
  I: Integer;
  Codes: TStringList;
  Code: string;
begin
  Codes := TStringList.Create;
  try
    Codes.Sorted := True;
    Codes.Duplicates := dupIgnore;
    for I := 0 to tvErrors.DataController.RecordCount - 1 do
    begin
      Code := VarToStr(tvErrors.DataController.Values[I, tvErrorsCode.Index]);
      if Code <> '' then
        Codes.Add(Code);
    end;
    lbSummary.Caption := Format('%d erori, %d produse afectate', [ErrorCount, Codes.Count]);
  finally
    Codes.Free;
  end;
end;

end.
