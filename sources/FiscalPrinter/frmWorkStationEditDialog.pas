unit frmWorkStationEditDialog;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
   cxLookAndFeelPainters, cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, Vcl.StdCtrls,
   cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDBEdit, cxTextEdit, cxMemo,
   cxCheckBox, Vcl.ExtCtrls, DialogTitle;

type
   TfrmWorkStationEditDlg = class(TSWNMasteredFormClass)
      dtDialogTitle: TDialogTitle;
      pnClient: TPanel;
      btnOk: TButton;
      btnCancel: TButton;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      cbFLG_ENABLED: TcxDBCheckBox;
      edCOMPUTER_NAME: TcxDBTextEdit;
      mmDESCRIPTION: TcxDBMemo;
      lcbFIRMA_ID: TcxDBLookupComboBox;
      btnUseThisComputer: TButton;
      procedure FormDestroy(Sender: TObject);
      procedure btnUseThisComputerClick(Sender: TObject);
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
   DataModuleAdditions, DataModuleDB, FiscalPrinterUtilsUnit, SWNUtils, SWNConst;

{ TfrmWorkStationEditDlg }

procedure TfrmWorkStationEditDlg.BindingDataSource;
begin
   cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
   edCOMPUTER_NAME.DataBinding.DataSource := fMasterDataSource;
   mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
   lcbFIRMA_ID.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmWorkStationEditDlg.btnUseThisComputerClick(Sender: TObject);
begin
   if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.FieldByName('COMPUTER_NAME').AsString := GetCurrentComputerName;
end;

function TfrmWorkStationEditDlg.CheckValues: Boolean;
var
   Error: string;
   Query: TIBCQuery;
begin
   Result := False;
   Error := '';

   if fMasterDataSet.FieldByName('COMPUTER_NAME').IsNull or
      (Trim(fMasterDataSet.FieldByName('COMPUTER_NAME').AsString) = '') then
      AddErrorToStr(Error, 'Nume calculator!');
   if fMasterDataSet.FieldByName('FIRMA_ID').IsNull or (fMasterDataSet.FieldByName('FIRMA_ID').AsInteger <= 0) then
      AddErrorToStr(Error, 'Subdiviziune!');

   // acelasi calculator nu poate fi inregistrat de doua ori in aceeasi subdiviziune,
   // altfel dialogul "Acces la MCC" ar arata dubluri
   if Error = '' then
   begin
      Query := TIBCQuery.Create(nil);
      try
         Query.Connection := dmDB.IBCConnection;
         Query.SQL.Text :=
            'SELECT FIRST 1 WS_ID FROM WS_WORK_STATIONS ' +
            'WHERE (FIRMA_ID = :FIRMA_ID) AND (UPPER(COMPUTER_NAME) = :COMPUTER_NAME) AND (WS_ID <> :WS_ID)';
         Query.ParamByName('FIRMA_ID').AsInteger := fMasterDataSet.FieldByName('FIRMA_ID').AsInteger;
         Query.ParamByName('COMPUTER_NAME').AsString :=
            UpperCase(Trim(fMasterDataSet.FieldByName('COMPUTER_NAME').AsString));
         if fMasterDataSet.FieldByName('WS_ID').IsNull then
            Query.ParamByName('WS_ID').AsInteger := -1
         else
            Query.ParamByName('WS_ID').AsInteger := fMasterDataSet.FieldByName('WS_ID').AsInteger;
         Query.Open;
         if not Query.Eof then
            AddErrorToStr(Error, 'Acest calculator este deja inregistrat in subdiviziunea data!');
         Query.Close;
      finally
         Query.Free;
      end;
   end;

   if Error = '' then
      Result := True
   else
      ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Error);
end;

procedure TfrmWorkStationEditDlg.FormDestroy(Sender: TObject);
begin
   dmDB.IBCQueryFirms.Active := False;
end;

function TfrmWorkStationEditDlg.IsFormDataPosted: Boolean;
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

procedure TfrmWorkStationEditDlg.Prepare;
begin
   fMasterDataSet.UpdateTransaction.StartTransaction;
   try
      if fCreateNewRecord then
      begin
         dtDialogTitle.Text := 'Inregistrarea statiei de lucru';
         fMasterDataSet.Insert;
         fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
         fMasterDataSet.FieldByName('COMPUTER_NAME').AsString := GetCurrentComputerName;
         if dmDB.CurrentFirma > 0 then
            fMasterDataSet.FieldByName('FIRMA_ID').AsInteger := dmDB.CurrentFirma;
      end
      else
      begin
         dtDialogTitle.Text := 'Modificarea inregistrarii';
         fMasterDataSet.Edit;
      end;
      dmDB.IBCQueryFirms.Active := True;
   except
      if fMasterDataSet.State in dsEditModes then
         fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
   end;
end;

procedure TfrmWorkStationEditDlg.SetCreateNewRecord(const Value: Boolean);
begin
   fCreateNewRecord := Value;
end;

procedure TfrmWorkStationEditDlg.WhenCancelForm;
begin
   if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
   fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
