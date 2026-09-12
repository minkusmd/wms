unit frmServiceRefRepairAimsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalc, Buttons,
  Menus;

type
  TfrmServiceRefRepairAimsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    cbFLG_ENABLED: TcxDBCheckBox;
    Label3: TLabel;
    ceESTIMATED_HOURS: TcxDBCalcEdit;
    Label4: TLabel;
    cbFLG_DEFAULT_GARANT: TcxDBCheckBox;
    cbFLG_DEFAULT_REPAIR: TcxDBCheckBox;
    bbDaysPreset: TSpeedButton;
    pmDays: TPopupMenu;
    N11: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N51: TMenuItem;
    N141: TMenuItem;
    N261: TMenuItem;
    procedure bbDaysPresetClick(Sender: TObject);
    procedure N261Click(Sender: TObject);
  private
    fCreateNewScop: Boolean;
    fParentID: integer;
    { Private declarations }
    function CheckInputParams: Boolean;
    procedure SetCreateNewAnalytics(const Value: Boolean);
    procedure SetParentID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewScop: Boolean read fCreateNewScop write SetCreateNewAnalytics;
    property ParentID: integer read fParentID write SetParentID;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmAnalyticsEditorDlg }

procedure TfrmServiceRefRepairAimsEditorDlg.bbDaysPresetClick(Sender: TObject);
var
  P: TPoint;
begin
  P := Point(bbDaysPreset.Left, bbDaysPreset.Top + bbDaysPreset.Height);
  P := pnClient.ClientToScreen(P);
  pmDays.Popup(P.X, P.Y);
end;

function TfrmServiceRefRepairAimsEditorDlg.CheckInputParams: Boolean;
var
  Errors: String;
begin
  Result := False;

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(Errors, 'Denumirea obiectivului!');
  if fMasterDataSet.FieldByName('FLG_ENABLED').IsNull then
    AddErrorToStr(Errors, 'Disponibil!');
  if fMasterDataSet.FieldByName('ESTIMATED_HOURS').IsNull or (fMasterDataSet.FieldByName('ESTIMATED_HOURS').AsInteger <= 0) then
    AddErrorToStr(Errors, 'Timp pentru executare!');

  if Errors = '' then
    Result := true
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmServiceRefRepairAimsEditorDlg.BindingDataSource;
begin
  inherited;

  fParentID := 0;
  fCreateNewScop := False;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  ceESTIMATED_HOURS.DataBinding.DataSource := fMasterDataSource;
  cbFLG_DEFAULT_GARANT.DataBinding.DataSource := fMasterDataSource;
  cbFLG_DEFAULT_REPAIR.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmServiceRefRepairAimsEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := true;
  end
  else
    Result := False;
end;

procedure TfrmServiceRefRepairAimsEditorDlg.N261Click(Sender: TObject);
var
  N: integer;
begin
  N := TMenuItem(Sender).Tag;
  fMasterDataSet.FieldByName('ESTIMATED_HOURS').AsInteger := N;
end;

procedure TfrmServiceRefRepairAimsEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  if fCreateNewScop then
  begin
    dtDialogTitle.Text := 'Creare obiectiv nou';
    fMasterDataSet.Insert;
    fMasterDataSet.FieldByName('PARENTID').AsInteger := fParentID;
    fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
    fMasterDataSet.FieldByName('ESTIMATED_HOURS').AsInteger := 24;
    fMasterDataSet.FieldByName('FLG_DEFAULT_GARANT').AsInteger := 0;
    fMasterDataSet.FieldByName('FLG_DEFAULT_REPAIR').AsInteger := 0;
  end
  else
  begin
    dtDialogTitle.Text := 'Modificare obiectiv';
    fMasterDataSet.Edit;
  end;
end;

procedure TfrmServiceRefRepairAimsEditorDlg.SetCreateNewAnalytics(const Value: Boolean);
begin
  fCreateNewScop := Value;
end;

procedure TfrmServiceRefRepairAimsEditorDlg.SetParentID(const Value: integer);
begin
  fParentID := Value;
end;

procedure TfrmServiceRefRepairAimsEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
