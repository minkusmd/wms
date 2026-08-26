unit frmIncidentDescriptionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls,
  StdCtrls, cxMemo, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxCheckListBox, ComCtrls, cxDBCheckListBox,
  cxLabel, cxDBLabel, cxMaskEdit, cxDropDownEdit, cxCalendar, DB, DBAccess, IBC, MemDS, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmIncidentDescriptionDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    pcPageControl: TPageControl;
    tbsGeneral: TTabSheet;
    tbsDescriptions: TTabSheet;
    Label1: TLabel;
    mmGOODS_NAME: TcxDBMemo;
    edSN: TcxDBTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    edGOODS_MODEL: TcxDBTextEdit;
    Label6: TLabel;
    cmbPriority: TComboBox;
    Label4: TLabel;
    mmDEFECT_DSC: TcxDBMemo;
    Label5: TLabel;
    mmEXTERNAL_DSC: TcxDBMemo;
    Label7: TLabel;
    clbFLAGS_COMPLECT: TcxDBCheckListBox;
    Label8: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    Label9: TLabel;
    deDATA_ESTIMATED_FINISH: TcxDBDateEdit;
    tbsComments: TTabSheet;
    Label10: TLabel;
    mmIID_COMMENTS: TcxDBMemo;
    IBCQueryICOMMENTS: TIBCQuery;
    IBCDataSourceICOMMENTS: TIBCDataSource;
  private
    { Private declarations }
    procedure PreparePriorityItems;
    function CheckParams: Boolean;
  protected
    { protected declarations }
    procedure InitValues; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB;

{$R *.dfm}

{ TfrmIncidentDescriptionDlg }

function TfrmIncidentDescriptionDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  fMasterDataSet.FieldByName('PRIORITY').AsInteger := cmbPriority.ItemIndex;

  if fMasterDataSet.FieldByName('GOODS_MODEL').IsNull or (fMasterDataSet.FieldByName('GOODS_MODEL').AsString = '') then
    AddErrorToStr(ErrorStr, 'Модель!');
  if fMasterDataSet.FieldByName('DEFECT_DSC').IsNull or (fMasterDataSet.FieldByName('DEFECT_DSC').AsString = '') then
    AddErrorToStr(ErrorStr, 'Описание дефекта!');
  if fMasterDataSet.FieldByName('FLAGS_COMPLECT').IsNull or (fMasterDataSet.FieldByName('FLAGS_COMPLECT').AsInteger = 0) then
    AddErrorToStr(ErrorStr, 'Комплектация!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmIncidentDescriptionDlg.InitValues;
begin
  inherited;

  PreparePriorityItems;
  pcPageControl.ActivePage := tbsGeneral;

  edGOODS_MODEL.DataBinding.DataSource := fMasterDataSource;
  edTYPE_TITLE.DataBinding.DataSource := fMasterDataSource;
  mmGOODS_NAME.DataBinding.DataSource := fMasterDataSource;
  edSN.DataBinding.DataSource := fMasterDataSource;

  mmDEFECT_DSC.DataBinding.DataSource := fMasterDataSource;
  mmEXTERNAL_DSC.DataBinding.DataSource := fMasterDataSource;
  clbFLAGS_COMPLECT.DataBinding.DataSource := fMasterDataSource;
  deDATA_ESTIMATED_FINISH.DataBinding.DataSource := fMasterDataSource;

  IBCQueryICOMMENTS.MasterSource := fMasterDataSource;
  IBCQueryICOMMENTS.UpdateTransaction := fMasterDataSet.UpdateTransaction;

  pcPageControl.ActivePage := tbsGeneral;
end;

function TfrmIncidentDescriptionDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    if IBCQueryICOMMENTS.State in dsEditModes then
      IBCQueryICOMMENTS.Post;

    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmIncidentDescriptionDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    fMasterDataSet.Edit;
    cmbPriority.ItemIndex := fMasterDataSet.FieldByName('PRIORITY').AsInteger;

    IBCQueryICOMMENTS.Active := True;

  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmIncidentDescriptionDlg.PreparePriorityItems;
var
  i: integer;
begin
  cmbPriority.Items.BeginUpdate;
  try
    for i := Low(cINCIDENT_Priority) to High(cINCIDENT_Priority) do
      cmbPriority.Items.Add(cINCIDENT_Priority[i]);
  finally
    cmbPriority.Items.EndUpdate;
  end;
end;

procedure TfrmIncidentDescriptionDlg.WhenCancelForm;
begin
  if IBCQueryICOMMENTS.State in dsEditModes then
    IBCQueryICOMMENTS.Cancel;
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

