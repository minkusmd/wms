unit ufrmListOfUserGroupsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, SWNBaseUnit, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, Vcl.Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxButtons, DialogTitle, cxGridLevel, cxClasses, cxGridCustomView, cxGrid;

type
  TfrmListOfUserGroupsDialog = class(TSWNBaseFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1GROUPID: TcxGridDBColumn;
    cxGrid1DBTableView1GROUP_NAME: TcxGridDBColumn;
  private
    FSecurityFlagValue: Integer;
    procedure SetSecurityFlagValue(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property SecurityFlagValue: Integer read FSecurityFlagValue write
        SetSecurityFlagValue;
    { Public declarations }
  end;

var
  frmListOfUserGroupsDialog: TfrmListOfUserGroupsDialog;

implementation

{$R *.dfm}

{ TTfrmListOfUserGroupsDialog }

procedure TfrmListOfUserGroupsDialog.Prepare;
begin

    IBCQuery1.ParamByName('value').AsInteger := fSecurityFlagValue;
    IBCQuery1.Open;
end;

procedure TfrmListOfUserGroupsDialog.SetSecurityFlagValue(const Value:
    Integer);
begin
    FSecurityFlagValue := Value;
end;

end.
