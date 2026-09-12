unit frmServiceAcceptGoodsFromPererabotkaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxEdit, StdCtrls, cxInplaceContainer, cxVGrid, cxDBVGrid, cxLabel, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, DBAccess, IBC, MemDS, dxScrollbarAnnotations;

type
  TfrmServiceAcceptGoodsFromPererabotkaDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxDBVerticalGrid: TcxDBVerticalGrid;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    cxDBVerticalGridDBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow6: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow8: TcxDBEditorRow;
    cxDBVerticalGridDBEditorRow9: TcxDBEditorRow;
    Label3: TLabel;
    lcbEXEC_PERSONAL_GROUP_ID: TcxLookupComboBox;
    IBCQueryGroups: TIBCQuery;
    IBCDataSourceGroups: TIBCDataSource;
  private
    { Private declarations }
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    function GetInginersGroup:Integer;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceAcceptGoodsFromPererabotkaDlg }

function TfrmServiceAcceptGoodsFromPererabotkaDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if VarIsNull(lcbEXEC_PERSONAL_GROUP_ID.EditValue) or (lcbEXEC_PERSONAL_GROUP_ID.EditValue=-1)
       then AddErrorToStr(ErrorStr,'Grup ingineri!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmServiceAcceptGoodsFromPererabotkaDlg.GetInginersGroup: Integer;
begin
     Result:=-1;
     if Not VarIsNull(lcbEXEC_PERSONAL_GROUP_ID.EditValue) then Result:=lcbEXEC_PERSONAL_GROUP_ID.EditValue;
end;

procedure TfrmServiceAcceptGoodsFromPererabotkaDlg.BindingDataSource;
begin
     inherited;

     cxDBVerticalGrid.DataController.DataSource:=fMasterDataSource;
end;

function TfrmServiceAcceptGoodsFromPererabotkaDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues;
end;

procedure TfrmServiceAcceptGoodsFromPererabotkaDlg.LoadStates;
begin
  inherited;

end;

procedure TfrmServiceAcceptGoodsFromPererabotkaDlg.Prepare;
begin
     lcbEXEC_PERSONAL_GROUP_ID.EditValue:=fMasterDataSet.FieldByName('EXEC_PERSONAL_GROUP_ID').AsInteger;
     IBCQueryGroups.Active:=True;
end;

procedure TfrmServiceAcceptGoodsFromPererabotkaDlg.SaveStates;
begin
  inherited;

end;

end.
