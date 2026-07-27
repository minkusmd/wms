unit frmServiceWaitingIncidentPropsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, MemDS,
  DBAccess, IBC, StdCtrls, cxMemo, cxDBEdit, cxCheckBox;

type
  TfrmServiceWaitingIncidentPropsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label3: TLabel;
    IBCDataSourceGroups: TIBCDataSource;
    IBCQueryGroups: TIBCQuery;
    Label1: TLabel;
    lcbEXEC_PERSONAL_GROUP_ID: TcxDBLookupComboBox;
    lcbPRIORITY_LEVEL_ID: TcxDBLookupComboBox;
    cbFLG_TOP_PRIORITY: TcxDBCheckBox;
    Label2: TLabel;
    mmCOMMENTS: TcxDBMemo;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryPriority: TIBCQuery;
    IBCDataSourcePriority: TIBCDataSource;
  private
    { Private declarations }
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceWaitingIncidentPropsDlg }

function TfrmServiceWaitingIncidentPropsDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     if fMasterDataSet.FieldByName('EXEC_PERSONAL_GROUP_ID').IsNull or (fMasterDataSet.FieldByName('EXEC_PERSONAL_GROUP_ID').AsInteger=-1)
       then AddErrorToStr(ErrorStr,'Группа инжинеров!');
     if fMasterDataSet.FieldByName('PRIORITY_LEVEL_ID').IsNull or (fMasterDataSet.FieldByName('PRIORITY_LEVEL_ID').AsInteger=-1)
       then AddErrorToStr(ErrorStr,'Приоритет выполнения!');

     if (fMasterDataSet.FieldByName('FLG_TOP_PRIORITY').AsInteger=1) and
        (fMasterDataSet.FieldByName('COMMENTS').IsNull or (Trim(fMasterDataSet.FieldByName('COMMENTS').AsString)=''))
      then AddErrorToStr(ErrorStr,'Комментарии!');

      if ErrorStr='' then Result:=True
      else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmServiceWaitingIncidentPropsDlg.BindingDataSource;
begin
     inherited;
     lcbEXEC_PERSONAL_GROUP_ID.DataBinding.DataSource:=fMasterDataSource;
     lcbPRIORITY_LEVEL_ID.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_TOP_PRIORITY.DataBinding.DataSource:=fMasterDataSource;
     mmCOMMENTS.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmServiceWaitingIncidentPropsDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckValues then
     begin
          fMasterDataSet.post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmServiceWaitingIncidentPropsDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        dtDialogTitle.Text:=Format('%s %s. SN=%s',[fMasterDataSet.FieldByName('VENDOR_TITLE').AsString,fMasterDataSet.FieldByName('GOODS_MODEL').AsString,fMasterDataSet.FieldByName('GOODS_SN').AsString]);

        // edit
        fMasterDataSet.Edit;
        // open data
        IBCQueryGroups.Active:=True;
        IBCQueryPriority.Active:=True;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmServiceWaitingIncidentPropsDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
