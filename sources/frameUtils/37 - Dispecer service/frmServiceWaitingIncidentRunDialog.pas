unit frmServiceWaitingIncidentRunDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, ComCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxImage, StdCtrls,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, DBAccess, IBC, MemDS, cxLabel, dxCore, cxDateUtils, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmServiceWaitingIncidentRunDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmText: TMemo;
    deFinishDate: TcxDateEdit;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridDBTableView;
    cxGridTable_IMAGE: TcxGridDBColumn;
    cxGridTable_FULL_NAME: TcxGridDBColumn;
    Label4: TLabel;
    edPriority: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cxGridTable_USERID: TcxGridDBColumn;
    cxGridTable_FUNCTIA_DETINUTA: TcxGridDBColumn;
    procedure cxGridTable_FULL_NAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    { Private declarations }
    fAssignedUser: Integer;
    fFinishDate: TDateTime;

    procedure PrepareInfo;
    function CheckValues:Boolean;
    function AskAgain:Boolean;
    function CheckTargetUserPassword:Boolean;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    property FinishDate:TDateTime read fFinishDate;
    property AssignedUser:Integer read fAssignedUser;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, DateUtils, frmPasswordDlg, SWNSecurity;

{$R *.dfm}

{ TfrmServiceWaitingIncidentRunDlg }

function TfrmServiceWaitingIncidentRunDlg.AskAgain: Boolean;
begin
     Result:=ShowAskDialog('Lansare incident in lucru',
                           Format('Alocati incidentul inginerului "%s" si il lansati in lucru?',[cxGridTable.Controller.FocusedRow.Values[cxGridTable_FULL_NAME.Index]]),
                           'Pentru continuare va fi necesara parola inginerului!')=mrYes;
end;

function TfrmServiceWaitingIncidentRunDlg.CheckTargetUserPassword: Boolean;
var dialog:TfrmPasswordDialog;
    UserID:integer;
begin
     Result:=False;

     UserID:=cxGridTable.Controller.FocusedRow.Values[cxGridTable_USERID.Index];

     dialog:=TfrmPasswordDialog.Create(Self,pdmAskPassword);
     try
        if dialog.ShowModal=mrOk then
        begin
             Result:=SWNSecurityManager.TestUserPassword(UserID,dialog.Password);
             if Not Result then ShowErrorDialog('Eroare','Parola incorecta!');
        end;
     finally
        dialog.Free;
     end;
end;

function TfrmServiceWaitingIncidentRunDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=false;
     ErrorStr:='';

     if Not Assigned(cxGridTable.Controller.FocusedRow) then AddErrorToStr(ErrorStr,'Inginer alocat!');
     if VarIsNull(deFinishDate.EditValue) or (DateOf(deFinishDate.EditValue)<DateOf(NOW)) then AddErrorToStr(ErrorStr,'Data de finalizare!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmServiceWaitingIncidentRunDlg.cxGridTable_FULL_NAMEGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridTable_FULL_NAME.Index]) then
     begin
          if Not VarIsNull(ARecord.Values[cxGridTable_FUNCTIA_DETINUTA.Index])
             then AText:=ARecord.Values[cxGridTable_FULL_NAME.Index]+#13#10+'  '+ARecord.Values[cxGridTable_FUNCTIA_DETINUTA.Index];
     end;
end;

procedure TfrmServiceWaitingIncidentRunDlg.BindingDataSource;
begin
     inherited;
     fAssignedUser:=-1;
     fFinishDate:=0;
end;

function TfrmServiceWaitingIncidentRunDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckValues and AskAgain and CheckTargetUserPassword then
     begin
          fFinishDate:=deFinishDate.EditValue;
          fAssignedUser:=cxGridTable.Controller.FocusedRow.Values[cxGridTable_USERID.Index];
          Result:=True;
     end;
end;

procedure TfrmServiceWaitingIncidentRunDlg.Prepare;
begin
     PrepareInfo;
     IBCQueryUsers.Active:=True;
end;

procedure TfrmServiceWaitingIncidentRunDlg.PrepareInfo;
begin
     mmText.Lines.BeginUpdate;
     try
        mmText.Lines.Clear;
        mmText.Lines.Add(Format('<< %s >>',[fMasterDataSet.FieldByName('TYPE_TITLE').AsString]));
        mmText.Lines.Add('');
        mmText.Lines.Add(Format('%s %s, SN=%s',[fMasterDataSet.FieldByName('VENDOR_TITLE').AsString,fMasterDataSet.FieldByName('GOODS_MODEL').AsString,fMasterDataSet.FieldByName('GOODS_SN').AsString]));
        mmText.Lines.Add('');
        mmText.Lines.Add(Format('Defecte: %s',[fMasterDataSet.FieldByName('DEFECTE_DSC').AsString]));
        mmText.Lines.Add('');
        mmText.Lines.Add(Format('Aspect exterior: %s',[fMasterDataSet.FieldByName('ASPECT_VISUAL_DSC').AsString]));
        if (Not fMasterDataSet.FieldByName('COMMENTS').IsNull) and (Trim(fMasterDataSet.FieldByName('COMMENTS').AsString)<>'') then
        begin
             mmText.Lines.Add('');
             mmText.Lines.Add(Format('Comentarii: %s',[fMasterDataSet.FieldByName('COMMENTS').AsString]));
        end;
     finally
        mmText.Lines.EndUpdate;
     end;
     // finish date
     deFinishDate.EditValue:=fMasterDataSet.FieldByName('DATA_EST_FINISH').AsDateTime;
     // priority
     if (fMasterDataSet.FieldByName('FLG_TOP_PRIORITY').AsInteger=1) then
     begin
          edPriority.Text:='De facut acum!';
          edPriority.Font.Color:=clRed;
     end
     else edPriority.Text:=fMasterDataSet.FieldByName('PRIORITY_LEVEL_TITLE').AsString;


end;

end.
