unit frmLinkFirmsTo1CEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls,
  cxDropDownEdit, cxDBEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, DialogTitle, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Data.DB, DBAccess, IBC, MemDS;

type
  TfrmLinkFirmsTo1CEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edFIRMA_COD: TcxDBTextEdit;
    edFIRMA_NAME: TcxDBTextEdit;
    edSKLAD_COD: TcxDBTextEdit;
    edSKLAD_TITLE: TcxDBTextEdit;
    cmbSKLAD_TYPE: TcxDBComboBox;
    edPERS_FIZ_CODE: TcxDBTextEdit;
    edPERS_FIZ_TITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    lcbCUSTOMERID: TcxDBLookupComboBox;
    lcbDT: TcxDBLookupComboBox;
    IBCQueryFirms: TIBCQuery;
    IBCDataSourceFirms: TIBCDataSource;
    IBCQueryMainFirms: TIBCQuery;
    IBCDataSourceMainFirms: TIBCDataSource;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    fFolderParentID: Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetFolderParentID(const Value: Integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property FolderParentID:Integer read FFolderParentID write SetFolderParentID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNConst, SWNUtils;

{ TForm2 }

function TfrmLinkFirmsTo1CEditorDlg.CheckValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if (fMasterDataSet.FieldByName('CUSTOMERID').IsNull) or (fMasterDataSet.FieldByName('CUSTOMERID').AsInteger<=0) then AddErrorToStr(Errors,'Firma!');
     if (fMasterDataSet.FieldByName('FIRMA_COD').IsNull) or (Trim(fMasterDataSet.FieldByName('FIRMA_COD').AsString)='') then AddErrorToStr(Errors,'Codul firmei in 1C!');
     if (fMasterDataSet.FieldByName('FIRMA_NAME').IsNull) or (Trim(fMasterDataSet.FieldByName('FIRMA_NAME').AsString)='') then AddErrorToStr(Errors,'Denumirea firmei in 1C!');
     if (fMasterDataSet.FieldByName('SKLAD_COD').IsNull) or (Trim(fMasterDataSet.FieldByName('SKLAD_COD').AsString)='') then AddErrorToStr(Errors,'Codul depozitului in 1C!');
     if (fMasterDataSet.FieldByName('SKLAD_TITLE').IsNull) or (Trim(fMasterDataSet.FieldByName('SKLAD_TITLE').AsString)='') then AddErrorToStr(Errors,'Denumirea depozitului in 1C!');
     if (fMasterDataSet.FieldByName('SKLAD_TYPE').IsNull) or (Trim(fMasterDataSet.FieldByName('SKLAD_TYPE').AsString)='') then AddErrorToStr(Errors,'Tipul depozitului!');
     if (fMasterDataSet.FieldByName('PERS_FIZ_CODE').IsNull) or (Trim(fMasterDataSet.FieldByName('PERS_FIZ_CODE').AsString)='') then AddErrorToStr(Errors,'Codul persoanei fizice in 1C!');
     if (fMasterDataSet.FieldByName('PERS_FIZ_TITLE').IsNull) or (Trim(fMasterDataSet.FieldByName('PERS_FIZ_TITLE').AsString)='') then AddErrorToStr(Errors,'Denumirea persoanei fizice in 1C!');
     if (fMasterDataSet.FieldByName('DT').IsNull) or (fMasterDataSet.FieldByName('DT').AsInteger<=0) then AddErrorToStr(Errors,'Firma-mama!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmLinkFirmsTo1CEditorDlg.BindingDataSource;
begin
     lcbCUSTOMERID.DataBinding.DataSource:=fMasterDataSource;
     edFIRMA_COD.DataBinding.DataSource:=fMasterDataSource;
     edFIRMA_NAME.DataBinding.DataSource:=fMasterDataSource;
     edSKLAD_COD.DataBinding.DataSource:=fMasterDataSource;
     edSKLAD_TITLE.DataBinding.DataSource:=fMasterDataSource;
     cmbSKLAD_TYPE.DataBinding.DataSource:=fMasterDataSource;
     edPERS_FIZ_CODE.DataBinding.DataSource:=fMasterDataSource;
     edPERS_FIZ_TITLE.DataBinding.DataSource:=fMasterDataSource;
     lcbDT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmLinkFirmsTo1CEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmLinkFirmsTo1CEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             IBCQueryFirms.FilterSQL:='NOT EXISTS(SELECT CUSTOMERID FROM TS_CUST_1C WHERE TS_CUST_1C.CUSTOMERID=TS_CUSTOMER.CUSTOMERID)';
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             fMasterDataSet.Edit;
        end;

        IBCQueryFirms.ParamByName('PARENTID').AsInteger:=fFolderParentID;
        IBCQueryMainFirms.ParamByName('PARENTID').AsInteger:=fFolderParentID;
        IBCQueryFirms.Active:=True;
        IBCQueryMainFirms.Active:=True;

     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmLinkFirmsTo1CEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmLinkFirmsTo1CEditorDlg.SetFolderParentID(const Value: Integer);
begin
     FFolderParentID := Value;
end;

procedure TfrmLinkFirmsTo1CEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
