unit frmDocumentCommentsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, StdCtrls, cxTextEdit,
  ExtCtrls, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmDocumentCommentsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edComments: TcxTextEdit;
    Label2: TLabel;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_DATA: TcxGridColumn;
    cxGridTable_USER: TcxGridColumn;
    cxGridTable_COMMENTS: TcxGridColumn;
    btnAdd: TcxButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
    fChanged: Boolean;
    procedure ParseComments(const Text: string);
    procedure DoAddNewComments;
    function GetCommentsText: string;
  protected
    { protected declarations }
    //procedure BindingDataSource;override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    //procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, DB;

{$R *.dfm}

{ TfrmDocumentCommentsEditorDlg }

procedure TfrmDocumentCommentsEditorDlg.btnAddClick(Sender: TObject);
begin
  if Trim(edComments.Text) = '' then
    ModalResult := mrOk
  else
    DoAddNewComments;
end;

procedure TfrmDocumentCommentsEditorDlg.DoAddNewComments;
var
  S: string;
  recIndex: integer;
begin
  S := Trim(edComments.Text);
  if S = '' then
    exit;

  cxGridTable.DataController.BeginUpdate;
  try
    recIndex := cxGridTable.DataController.AppendRecord;
    cxGridTable.DataController.Values[recIndex, cxGridTable_DATA.Index] := FormatDateTime('dd.mm.yyyy hh:nn', NOW);
    cxGridTable.DataController.Values[recIndex, cxGridTable_USER.Index] := dmDB.CurrentUserFullName;
    cxGridTable.DataController.Values[recIndex, cxGridTable_COMMENTS.Index] := S;

    edComments.Text := '';
    fChanged := True;
  finally
    cxGridTable.DataController.EndUpdate;
  end;
end;

function TfrmDocumentCommentsEditorDlg.GetCommentsText: string;
var
  List: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  try
    with cxGridTable.DataController do
      for i := 0 to RecordCount - 1 do
        List.Add(Format('%s (%s) - %s', [Values[i, cxGridTable_USER.Index], Values[i, cxGridTable_DATA.Index], Values[i, cxGridTable_COMMENTS.Index]]));

    Result := List.Text;
  finally
    List.Free;
  end;
end;

function TfrmDocumentCommentsEditorDlg.IsFormDataPosted: Boolean;
begin
  if fChanged then
  begin
    if not (fMasterDataSet.State in dsEditModes) then
      fMasterDataSet.Edit;
    fMasterDataSet.FieldByName('COMMENTS').AsString := GetCommentsText;
  end;
  Result := True;
end;

procedure TfrmDocumentCommentsEditorDlg.ParseComments(const Text: string);
var
  List: TStringList;
  i, k, recIndex: integer;
  S: string;
  dateStr, userStr, comStr: string;
begin
  List := TStringList.Create;
  cxGridTable.DataController.BeginUpdate;
  try
        // convert to lines
    List.Text := Text;

    for i := 0 to List.Count - 1 do
    begin
      S := Trim(List[i]);
      if S = '' then
        Continue;

      dateStr := '(??.??.?? ??:??)';
      userStr := 'unknown';

      k := pos(' (', S);
      if (k > 0) then
      begin
                  // user
        userStr := Trim(Copy(S, 1, k - 1));
        Delete(S, 1, k + 1);
        k := pos(') - ', S);
        if (k > 0) then
        begin
                       // date time
          dateStr := Trim(Copy(S, 1, k - 1));
          Delete(S, 1, k + 3);
        end
      end;
      comStr := Trim(S);

      recIndex := cxGridTable.DataController.AppendRecord;
      cxGridTable.DataController.Values[recIndex, cxGridTable_DATA.Index] := dateStr;
      cxGridTable.DataController.Values[recIndex, cxGridTable_USER.Index] := userStr;
      cxGridTable.DataController.Values[recIndex, cxGridTable_COMMENTS.Index] := comStr;
    end;
  finally
    List.Free;
    cxGridTable.DataController.EndUpdate;
  end;
end;

procedure TfrmDocumentCommentsEditorDlg.Prepare;
begin
  fChanged := False;

     // working with TDB_DOCS_PROPS table only!!!
  ParseComments(fMasterDataSet.FieldByName('COMMENTS').AsString);

end;

end.

