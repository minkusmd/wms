unit frmSelectInventoryCostingMethodUnit;

interface

uses
  Data.DB,
  DBAccess,
  IBC,
  MemDS,
  SWNBaseUnit,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.StdCtrls,
  cxButtons,
  cxContainer,
  cxControls,
  cxDBLookupComboBox,
  cxDropDownEdit,
  cxEdit,
  cxGraphics,
  cxLookAndFeelPainters,
  cxLookAndFeels,
  cxLookupEdit,
  cxMaskEdit,
  cxTextEdit;

type
  TfrmSelectInventoryCostingMethodDlg = class(TSWNBaseFormClass)
    btnCancel: TcxButton;
    btnOK: TcxButton;
    IBCDataSourceGST: TIBCDataSource;
    IBCQueryGST: TIBCQuery;
    LabelInventoryCostingMethod: TLabel;
    lcbSerialNumber: TcxLookupComboBox;
  private
    FInitialInventoryCostingMethodID: Integer;
    FInventoryCostingMethodID: Integer;
  protected
    function IsFormDataPosted: Boolean; override;
    procedure Prepare; override;
  public
    constructor Create(AOwner: TComponent; AIBCConnection: TIBCConnection;
      AInitialInventoryCostingMethodID: Integer); reintroduce;
    property InventoryCostingMethodID: Integer read FInventoryCostingMethodID;
  end;

implementation

{$R *.dfm}

constructor TfrmSelectInventoryCostingMethodDlg.Create(AOwner: TComponent;
  AIBCConnection: TIBCConnection; AInitialInventoryCostingMethodID: Integer);
begin
  inherited Create(AOwner, AIBCConnection);
  FInitialInventoryCostingMethodID := AInitialInventoryCostingMethodID;
  FInventoryCostingMethodID := -1;
end;

function TfrmSelectInventoryCostingMethodDlg.IsFormDataPosted: Boolean;
begin
  FInventoryCostingMethodID := StrToIntDef(VarToStr(lcbSerialNumber.EditValue), -1);
  Result := FInventoryCostingMethodID > 0;

  if not Result then
    MessageDlg('Selectati tipul evidentei.', mtWarning, [mbOK], 0);
end;

procedure TfrmSelectInventoryCostingMethodDlg.Prepare;
begin
  inherited;

  IBCQueryGST.Connection := IBCConnection;
  IBCQueryGST.Open;

  if IBCQueryGST.IsEmpty then
  begin
    MessageDlg('Lista tipurilor de evidenta este goala.', mtWarning, [mbOK], 0);
    ModalResult := mrCancel;
    Exit;
  end;

  if (FInitialInventoryCostingMethodID > 0) and
    IBCQueryGST.Locate('GOODSSERIALTYPEID', FInitialInventoryCostingMethodID, []) then
    lcbSerialNumber.EditValue := FInitialInventoryCostingMethodID
  else
  begin
    IBCQueryGST.First;
    lcbSerialNumber.EditValue := IBCQueryGST.FieldByName('GOODSSERIALTYPEID').AsInteger;
  end;
end;

end.
