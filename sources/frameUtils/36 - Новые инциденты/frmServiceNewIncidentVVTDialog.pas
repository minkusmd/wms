unit frmServiceNewIncidentVVTDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit;

type
  TfrmServiceNewIncidentVVTDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryAspect: TIBCQuery;
    IBCDataSourceAspect: TIBCDataSource;
    cxGridDBTable_SYSSID: TcxGridDBColumn;
    cxGridDBTable_TITLE: TcxGridDBColumn;
    procedure cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    function GetText:String;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNValueStorageUnit;

{ TfrmServiceNewIncidentVVTDlg }

procedure TfrmServiceNewIncidentVVTDlg.cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     ModalResult:=mrOk;
     AHandled:=True;
end;

function TfrmServiceNewIncidentVVTDlg.GetText: String;
begin
     Result:='???';
     if Assigned(cxGridDBTable.Controller.FocusedRow)
       then Result:=cxGridDBTable.Controller.FocusedRow.Values[cxGridDBTable_TITLE.Index];
end;

function TfrmServiceNewIncidentVVTDlg.IsFormDataPosted: Boolean;
begin
     Result:=Assigned(cxGridDBTable.Controller.FocusedRow);
end;

procedure TfrmServiceNewIncidentVVTDlg.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self)
       then Position:=poDesigned;
end;

procedure TfrmServiceNewIncidentVVTDlg.Prepare;
begin
     IBCQueryAspect.Active:=True;
     cxGridDBTable_TITLE.Selected:=True;
end;

procedure TfrmServiceNewIncidentVVTDlg.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
       then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

end.
