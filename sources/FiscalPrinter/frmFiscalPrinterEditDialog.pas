unit frmFiscalPrinterEditDialog;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
   cxLookAndFeelPainters, cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, Vcl.StdCtrls,
   cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDBEdit, cxTextEdit, cxMemo,
   cxCheckBox, Vcl.ExtCtrls, DialogTitle;

type
   TfrmFiscalPrinterEditDlg = class(TSWNMasteredFormClass)
      dtDialogTitle: TDialogTitle;
      pnClient: TPanel;
      btnOk: TButton;
      btnCancel: TButton;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      cbFLG_ENABLED: TcxDBCheckBox;
      mmDESCRIPTION: TcxDBMemo;
      edSERIAL_NUMBER: TcxDBTextEdit;
      lcbFIRMA_ID: TcxDBLookupComboBox;
      lcbWS_ID: TcxDBLookupComboBox;
      Label5: TLabel;
      edSERVER_ADDRESS: TcxDBTextEdit;
      Label6: TLabel;
      edCOM_PORT: TcxDBTextEdit;
      Label7: TLabel;
      edBAUD_RATE: TcxDBTextEdit;
      Label8: TLabel;
      IBCQueryWS: TIBCQuery;
      IBCDataSourceWS: TIBCDataSource;
      procedure FormDestroy(Sender: TObject);
      procedure lcbWS_IDPropertiesInitPopup(Sender: TObject);
   private
    { Private declarations }
      fCreateNewRecord: Boolean;
      procedure SetCreateNewRecord(const Value: Boolean);
      function CheckValues: Boolean;
   protected
    { protected declarations }
      procedure BindingDataSource; override;
      procedure Prepare; override;
      function IsFormDataPosted: Boolean; override;
      procedure WhenCancelForm; override;
   public
    { Public declarations }
      property CreateNewRecord: Boolean read fCreateNewRecord write SetCreateNewRecord;
   end;

implementation

{$R *.dfm}

uses
   DataModuleAdditions, DataModuleDB, SWNUpdateClientDBClass, SWNUtils, SWNConst;

{ TfrmFiscalPrinterEditDlg }

function TfrmFiscalPrinterEditDlg.CheckValues: Boolean;
var
   Error: string;
begin
   Result := False;
   Error := '';

   if fMasterDataSet.FieldByName('SERIAL_NUMBER').IsNull or (Trim(fMasterDataSet.FieldByName('SERIAL_NUMBER').AsString)
      = '') then
      AddErrorToStr(Error, 'Numar de serie!');
   if fMasterDataSet.FieldByName('FIRMA_ID').IsNull or (fMasterDataSet.FieldByName('FIRMA_ID').AsInteger <= 0) then
      AddErrorToStr(Error, 'Subdiviziune!');
//     if fMasterDataSet.FieldByName('WS_ID').IsNull or (fMasterDataSet.FieldByName('WS_ID').AsInteger<=0)
//       then AddErrorToStr(Error,'Workstation!');

   // MCC din retea: portul apartine altui calculator, deci trebuie indicat explicit
   if Trim(fMasterDataSet.FieldByName('SERVER_ADDRESS').AsString) <> '' then
   begin
      if Trim(fMasterDataSet.FieldByName('COM_PORT').AsString) = '' then
         AddErrorToStr(Error, 'Port COM (obligatoriu pentru MCC din retea)!');
      if fMasterDataSet.FieldByName('BAUD_RATE').AsInteger <= 0 then
         AddErrorToStr(Error, 'Viteza portului (obligatorie pentru MCC din retea)!');
   end;

   if Error = '' then
      Result := True
   else
      ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Error);
end;

procedure TfrmFiscalPrinterEditDlg.FormDestroy(Sender: TObject);
begin
   dmDB.IBCQueryFirms.Active := False;
end;

procedure TfrmFiscalPrinterEditDlg.BindingDataSource;
begin
   cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
   edSERIAL_NUMBER.DataBinding.DataSource := fMasterDataSource;
   mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
   lcbFIRMA_ID.DataBinding.DataSource := fMasterDataSource;
   lcbWS_ID.DataBinding.DataSource := fMasterDataSource;
   edSERVER_ADDRESS.DataBinding.DataSource := fMasterDataSource;
   edCOM_PORT.DataBinding.DataSource := fMasterDataSource;
   edBAUD_RATE.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmFiscalPrinterEditDlg.IsFormDataPosted: Boolean;
begin
   Result := False;
   if CheckValues then
   begin
      if fMasterDataSet.State in dsEditModes then
         fMasterDataSet.Post;
      fMasterDataSet.UpdateTransaction.Commit;
      Result := True;
   end;
end;

procedure TfrmFiscalPrinterEditDlg.lcbWS_IDPropertiesInitPopup(Sender: TObject);
begin
   IBCQueryWS.Close;
   IBCQueryWS.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('FIRMA_ID').AsInteger;
   IBCQueryWS.Active := True;
end;

procedure TfrmFiscalPrinterEditDlg.Prepare;
begin
   fMasterDataSet.UpdateTransaction.StartTransaction;
   try
      if fCreateNewRecord then
      begin
         dtDialogTitle.Text := 'Inregistrarea MCC';
         fMasterDataSet.Insert;
         fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 0;
      end
      else
      begin
         dtDialogTitle.Text := 'Modificarea inregistrarii';
         fMasterDataSet.Edit;
      end;
      dmDB.IBCQueryFirms.Active := True;
      lcbWS_IDPropertiesInitPopup(Self);
   except
      if fMasterDataSet.State in dsEditModes then
         fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
   end;

end;

procedure TfrmFiscalPrinterEditDlg.SetCreateNewRecord(const Value: Boolean);
begin
   fCreateNewRecord := Value;
end;

procedure TfrmFiscalPrinterEditDlg.WhenCancelForm;
begin
   if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
   fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

