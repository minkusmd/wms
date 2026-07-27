unit frmScetFacturaNomerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls,
  cxDBLookupComboBox, Data.DB,
  IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  DBAccess, MemDS, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit;

type
  TfrmScetFacturaNomerDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edInvoiceNO: TEdit;
    Label2: TLabel;
    lcbFacturaNo: TcxDBLookupComboBox;
    IBCQueryDSE: TIBCQuery;
    IBCDataSourceDSE: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    function getInvoiceNO: String;
    function CheckValues:Boolean;
  protected
    { protected declarations }
    function IsFormDataPosted:Boolean;override;
    procedure Prepare; override;
  public
    { Public declarations }
    property InvoiceNO:String read getInvoiceNO;
  end;


implementation
Uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmScetFacturaNomerDlg }

function TfrmScetFacturaNomerDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';
     if (Trim(edInvoiceNO.Text)='') or (Length(edInvoiceNO.Text)<=3) then AddErrorToStr(ErrorStr,'Номер счет фактуры!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmScetFacturaNomerDlg.getInvoiceNO: String;
begin
     Result:=Trim(edInvoiceNO.Text);
end;

function TfrmScetFacturaNomerDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
        Result := True;
     end;


end;

procedure TfrmScetFacturaNomerDlg.Prepare;
begin
  inherited;
  lcbFacturaNo.DataBinding.DataSource := fMasterDataSource;
  IBCQueryDSE.Open;
  IBCQueryDSE.Edit;
end;

end.
