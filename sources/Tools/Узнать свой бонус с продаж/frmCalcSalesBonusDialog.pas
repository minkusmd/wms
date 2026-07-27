unit frmCalcSalesBonusDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.ExtCtrls,
  DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmCalcSalesBonusDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    deStart: TcxDateEdit;
    deEnd: TcxDateEdit;
    btnCalc: TButton;
    Label4: TLabel;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnCancel: TButton;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_BONUS: TcxGridDBColumn;
    cxGridTable_GOODS_TITLE: TcxGridDBColumn;
    IBCQueryBonus: TIBCQuery;
    IBCDataSourceBonus: TIBCDataSource;
    cxGridTable_BONUS_TITLE: TcxGridDBColumn;
    Label5: TLabel;
    lcbUser: TcxLookupComboBox;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    procedure btnCalcClick(Sender: TObject);
  private
    { Private declarations }
    function CheckInputParams: Boolean;
    procedure LoadData;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, SWNConst, SWNUtils, DataModuleDB, SWNSecurity,
  SWNSecurityFlags;

procedure TfrmCalcSalesBonusDlg.btnCalcClick(Sender: TObject);
begin
  if CheckInputParams then
    LoadData;
end;

function TfrmCalcSalesBonusDlg.CheckInputParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if VarIsNull(deStart.EditValue) or VarIsNull(deEnd.EditValue) or (deEnd.EditValue < deStart.EditValue) then
    AddErrorToStr(ErrorStr, 'Период!');

  if VarIsNull(lcbUser.EditValue) or (lcbUser.EditValue <= 0) then
    AddErrorToStr(ErrorStr, 'Пользователь!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCalcSalesBonusDlg.LoadData;
begin
  IBCQueryBonus.Close;
  IBCQueryBonus.ParamByName('USERID').AsInteger := lcbUser.EditValue;
  IBCQueryBonus.ParamByName('DATE_START').AsDate := deStart.EditValue;
  IBCQueryBonus.ParamByName('DATE_END').AsDate := deEnd.EditValue;
  IBCQueryBonus.Active := True;
end;

procedure TfrmCalcSalesBonusDlg.Prepare;
begin
  IBCQueryUsers.Active := True;
  lcbUser.EditValue := dmDB.CurrentUserID;
end;

procedure TfrmCalcSalesBonusDlg.SetupSecurityItems;
begin
  lcbUser.Enabled := (SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) or SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari));
end;

end.

