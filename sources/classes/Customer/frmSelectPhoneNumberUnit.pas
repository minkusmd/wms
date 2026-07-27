unit frmSelectPhoneNumberUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxDropDownEdit, cxMaskEdit, Vcl.Menus, DBAccess, IBC, MemDS,
  Vcl.StdCtrls, cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges,
  dxScrollbarAnnotations;

type
  TfrmSelectPhoneNumber = class(TSWNCustomForm)
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    btnOK: TcxButton;
    cxButton2: TcxButton;
    IBCQueryPhone: TIBCQuery;
    IBCDSPhone: TIBCDataSource;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fSelectedPhoneNumber: string;
    fCustomerID: integer;
    procedure SetSelectedPhoneNumber(const Value: string);
    procedure SetCustomerID(const Value: integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    property CustomerID: integer read fCustomerID write SetCustomerID;
    property SelectedPhoneNumber: string read fSelectedPhoneNumber write SetSelectedPhoneNumber;
  end;

var
  frmSelectPhoneNumber: TfrmSelectPhoneNumber;

implementation

uses SWNUtils;

{$R *.dfm}

procedure TfrmSelectPhoneNumber.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
    // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGrid1DBTableView1);
    Key := 0;
  end;
end;

{ TfrmSelectPhoneNumber }

function TfrmSelectPhoneNumber.IsFormDataPosted: Boolean;
begin
   result := True;
   SelectedPhoneNumber := '';
   if IBCQueryPhone.FieldByName('PHONENUMBER').AsString <> '' then
   begin
      SelectedPhoneNumber := IBCQueryPhone.FieldByName('PHONENUMBER').AsString;
//      if POS('0', SelectedPhoneNumber) = 1 then
//      begin
//        SelectedPhoneNumber := copy(SelectedPhoneNumber, 2, length(SelectedPhoneNumber));
//      end;
//      if POS('373', SelectedPhoneNumber) <= 2 then
//      begin
//        SelectedPhoneNumber := copy(SelectedPhoneNumber, POS('373', SelectedPhoneNumber)+1, length(SelectedPhoneNumber));
//      end;

   end;
end;

procedure TfrmSelectPhoneNumber.Prepare;
begin
  inherited;
  IBCQueryPhone.Close;
  IBCQueryPhone.ParamByName('CUSTOMERID').AsInteger := CustomerID;
  IBCQueryPhone.Open;
  cxGrid1DBTableView1Column2.Focused := True;

end;

procedure TfrmSelectPhoneNumber.SetCustomerID(const Value: integer);
begin
  fCustomerID := Value;
end;

procedure TfrmSelectPhoneNumber.SetSelectedPhoneNumber(const Value: string);
begin
  fSelectedPhoneNumber := Value;
end;

end.
