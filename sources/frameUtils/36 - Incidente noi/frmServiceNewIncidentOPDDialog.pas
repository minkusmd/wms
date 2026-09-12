unit frmServiceNewIncidentOPDDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmServiceNewIncidentOPDDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxGrid: TcxGrid;
    cxGridDBTable: TcxGridDBTableView;
    cxGridDBTable_SYSSID: TcxGridDBColumn;
    cxGridDBTable_TITLE: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    IBCQueryDefect: TIBCQuery;
    IBCDataSourceDefect: TIBCDataSource;
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

uses SWNValueStorageUnit;

{ TfrmServiceNewIncidentOPDDlg }

procedure TfrmServiceNewIncidentOPDDlg.cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     ModalResult:=mrOk;
     AHandled:=True;
end;

function TfrmServiceNewIncidentOPDDlg.GetText: String;
begin
     Result:='???';
     if Assigned(cxGridDBTable.Controller.FocusedRow)
       then Result:=cxGridDBTable.Controller.FocusedRow.Values[cxGridDBTable_TITLE.Index];
end;

function TfrmServiceNewIncidentOPDDlg.IsFormDataPosted: Boolean;
begin
     Result:=Assigned(cxGridDBTable.Controller.FocusedRow);
end;

procedure TfrmServiceNewIncidentOPDDlg.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self)
       then Position:=poDesigned;
end;

procedure TfrmServiceNewIncidentOPDDlg.Prepare;
begin
     IBCQueryDefect.Active:=True;
     cxGridDBTable_TITLE.Selected:=True;
end;

procedure TfrmServiceNewIncidentOPDDlg.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
       then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

end.
