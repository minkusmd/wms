unit frmCustomerCallInfoUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
   Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus, DBAccess, IBC, MemDS,
  Vcl.StdCtrls, cxButtons, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, Vcl.ExtCtrls, dxScrollbarAnnotations, dxUIAClasses,
  cxCheckBox;

// TSWNBaseFormClass
type
   TfrmCustomerCallInfoDlg = class(TSWNBaseFormClass)
    btnClose: TcxButton;
      IBCQueryLocalDocs: TIBCQuery;
      IBCQueryLocalJurnal: TIBCQuery;
      IBCDataSourceLocalDocs: TIBCDataSource;
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    cxGrid2DBTableView1Column4: TcxGridDBColumn;
    cxGrid2DBTableView1Column5: TcxGridDBColumn;
    cxGrid2Level1: TcxGridLevel;
    Label1: TLabel;
    lbPhoneNumber: TLabel;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_CLOSED: TcxGridDBColumn;
      procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
          TShiftState);
    procedure cxGrid2DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
   private
      FPhoneNumber: string;
      procedure SetPhoneNumber(const Value: string);
    { Private declarations }
   protected
      procedure Prepare; override;
   public
      property PhoneNumber: string read FPhoneNumber write SetPhoneNumber;
    { Public declarations }


   end;

implementation

{$R *.dfm}

uses DataModuleDB;

procedure TfrmCustomerCallInfoDlg.cxGrid1DBTableView1KeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
if (Key = 67) and (Shift = [ssCtrl]) then
   begin
      // copy cell content in clipboard
      dmdb.CopyGridCellTextToClipboard(cxGrid1DBTableView1);
      Key := 0;
      Shift := [];
   end
end;

procedure TfrmCustomerCallInfoDlg.cxGrid2DBTableView1KeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
   begin
      dmdb.CopyGridCellTextToClipboard(cxGrid2DBTableView1);
      Key := 0;
      Shift := [];
   end
end;

procedure TfrmCustomerCallInfoDlg.Prepare;
begin
   IBCQueryLocalDocs.ParamByName('PHONENUMBER').AsString := fPhoneNumber;
   IBCQueryLocalDocs.Open;
   IBCQueryLocalDocs.Last;
   IBCQueryLocalJurnal.Open;
   lbPhoneNumber.Caption := fPhoneNumber;
end;

procedure TfrmCustomerCallInfoDlg.SetPhoneNumber(const Value: string);
begin
   FPhoneNumber := Value;
end;

end.

