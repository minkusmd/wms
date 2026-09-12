unit frmServiceRequestWarrantyDescriptionDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckListBox,
  cxDBCheckListBox, cxDBEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls,
  Data.DB, DBAccess, IBC, MemDS, cxMemo, cxCustomListBox;

type
  TfrmServiceRequestWarrantyDescriptionDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnCleint: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lcbCERTIFICAT_TIP: TcxDBLookupComboBox;
    deCERTIFICAT_DATA: TcxDBDateEdit;
    edCERTIFICAT_NUMAR: TcxDBTextEdit;
    clbFLAGS_SCOP: TcxDBCheckListBox;
    clbFLAGS_COMPLECTINFO: TcxDBCheckListBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mmDEFECTE_PRESUPUSE: TcxDBMemo;
    mmDEFECTE_ESTETITE: TcxDBMemo;
    mmEXAMINAREA_PREVENTIVA: TcxDBMemo;
    IBCQueryInfo: TIBCQuery;
    IBCDataSourceInfo: TIBCDataSource;
    IBCQueryCTYPES: TIBCQuery;
    IBCDataSourceCTYPES: TIBCDataSource;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils;

{ TfrmServiceRequestWarrantyDescriptionDlg }

function TfrmServiceRequestWarrantyDescriptionDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;
     Error:='';

     if IBCQueryInfo.FieldByName('CERTIFICAT_TIP').IsNull or (IBCQueryInfo.FieldByName('CERTIFICAT_TIP').AsInteger<=0) then AddErrorToStr(Error,'Tipul documentului!');
     if IBCQueryInfo.FieldByName('CERTIFICAT_NUMAR').IsNull or (Trim(IBCQueryInfo.FieldByName('CERTIFICAT_NUMAR').AsString)='') then AddErrorToStr(Error,'Numarul documentului!');
     if IBCQueryInfo.FieldByName('CERTIFICAT_DATA').IsNull or (IBCQueryInfo.FieldByName('CERTIFICAT_DATA').AsDateTime>NOW) then AddErrorToStr(Error,'Data documentului!');

     if IBCQueryInfo.FieldByName('FLAGS_SCOP').IsNull or (IBCQueryInfo.FieldByName('FLAGS_SCOP').AsInteger<=0) then AddErrorToStr(Error,'Scopul receptiei marfii!');

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmServiceRequestWarrantyDescriptionDlg.BindingDataSource;
begin
     IBCQueryInfo.MasterSource:=fMasterDataSource;
     IBCQueryInfo.Transaction:=fMasterDataSet.Transaction;
     IBCQueryInfo.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

function TfrmServiceRequestWarrantyDescriptionDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          IBCQueryInfo.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmServiceRequestWarrantyDescriptionDlg.Prepare;
begin
     IBCQueryInfo.Active:=True;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if IBCQueryInfo.Eof then
        begin
             dtDialogTitle.Text:='Creare inregistrare noua';
             IBCQueryInfo.Insert;
             IBCQueryInfo.FieldByName('CERTIFICAT_TIP').AsInteger:=1;
             IBCQueryInfo.FieldByName('FLAGS_SCOP').AsInteger:=0;
             IBCQueryInfo.FieldByName('FLAGS_COMPLECTINFO').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             IBCQueryInfo.Edit;
        end;
        IBCQueryCTYPES.Active:=True;
     except
        IBCQueryInfo.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmServiceRequestWarrantyDescriptionDlg.WhenCancelForm;
begin
     IBCQueryInfo.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
