unit frmServiceEnginerCloseIncidentDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxListBox, cxDBEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, MemDS, DBAccess, IBC,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmServiceEnginerCloseIncidentDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    IBCDS_FinalSyss: TIBCDataSource;
    ibcFinalSyss: TIBCQuery;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_SYSSID: TcxGridDBColumn;
    cbCreateReturn: TCheckBox;
  private
    { Private declarations }
    function CheckParams:Boolean;
    function GetStatusID: Integer;
    function GetCreateReturn: Boolean;
    function ConfirmAction:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    property StatusID:Integer read GetStatusID;
    property CreateReturn:Boolean read GetCreateReturn;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{ TfrmServiceEnginerCloseIncidentDlg }

function TfrmServiceEnginerCloseIncidentDlg.CheckParams: Boolean;
begin
     Result:=True;
     if Not Assigned(cxGridTable.Controller.FocusedRecord) then
     begin
          Result:=False;
          ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,'Selectati tipul incidentului finalizat!');
     end;
end;

function TfrmServiceEnginerCloseIncidentDlg.ConfirmAction: Boolean;
var status,adds:String;
begin
     status:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRecord.Index,cxGridTable_TITLE.Index];
     if cbCreateReturn.Checked
       then adds:='De asemenea va fi creat documentul retur marfa client.'
       else adds:='!!! Documentul retur marfa client nu va fi creat.';
     Result:=ShowAskDialog('Finalizare incident',Format('Doriti sa finalizati incidentul cu statusul "%s"?'#13#10'%s',[status,adds]))=mrYes;
end;

function TfrmServiceEnginerCloseIncidentDlg.GetCreateReturn: Boolean;
begin
     Result:=cbCreateReturn.Checked;
end;

function TfrmServiceEnginerCloseIncidentDlg.GetStatusID: Integer;
begin
     Result:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRecord.Index,cxGridTable_SYSSID.Index];
end;

function TfrmServiceEnginerCloseIncidentDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckParams and ConfirmAction;
end;

procedure TfrmServiceEnginerCloseIncidentDlg.Prepare;
begin
     ibcFinalSyss.Active:=True;
end;

end.
