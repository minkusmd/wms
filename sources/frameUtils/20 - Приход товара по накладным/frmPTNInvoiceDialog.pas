unit frmPTNInvoiceDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit,
  cxTextEdit, Vcl.ExtCtrls, DialogTitle, dxUIAClasses;

type
  TfrmPTNInvoiceDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edFACTURANO: TcxDBTextEdit;
    deDATA_ELIBERARII: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    cbRedirijari: TcxDBComboBox;
  private
    { Private declarations }
    FCreateNew: Boolean;
    procedure SetCreateNew(const Value: Boolean);
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNew:Boolean read FCreateNew write SetCreateNew;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB;

{ TfrmПриходТовараПоНакладнымФактураDlg }

function TfrmPTNInvoiceDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('FACTURANO').IsNull or (Trim(fMasterDataSet.FieldByName('FACTURANO').AsString)='')
       then AddErrorToStr(ErrorStr,'Nnumarul Facturii!');
     if fMasterDataSet.FieldByName('DATA_ELIBERARII').IsNull then AddErrorToStr(ErrorStr,'Data eliberarii facturii!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmPTNInvoiceDlg.BindingDataSource;
begin
     edFACTURANO.DataBinding.DataSource:=fMasterDataSource;
     deDATA_ELIBERARII.DataBinding.DataSource:=fMasterDataSource;
     cbRedirijari.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmPTNInvoiceDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmPTNInvoiceDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNew then
        begin
             dtDialogTitle.Text:='Inregistrarea unei facturi noi';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DATA_ELIBERARII').AsDateTime := dmdb.IBCQueryDocs.FieldbyName('DATA').AsDateTime;
        end
        else
        begin
             dtDialogTitle.Text:='Modificarea informatiei in factura';
             fMasterDataSet.Edit;
        end;
   except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
   end;
end;

procedure TfrmPTNInvoiceDlg.SetCreateNew(const Value: Boolean);
begin
     fCreateNew := Value;
end;

procedure TfrmPTNInvoiceDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
