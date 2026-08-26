unit frameDocsDeliveryUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
   cxStyles, cxEdit, cxButtonEdit, cxCalc, cxCheckBox, cxCalendar, cxMemo,
   cxDataControllerConditionalFormattingRulesManagerDialog, cxVGrid, cxDBVGrid, cxInplaceContainer, Data.DB,
   DBAccess, IBC, MemDS, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxScrollbarAnnotations, cxFilter, cxTextEdit;

type
   TframeDocsDelivery = class(TFrame)
      cxDBVerticalGrid1: TcxDBVerticalGrid;
      cxDBVerticalGrid1DOCID: TcxDBEditorRow;
      cxDBVerticalGrid1COURIERID: TcxDBEditorRow;
      cxDBVerticalGrid1CategoryRow2: TcxCategoryRow;
      cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow;
      cxDBVerticalGrid1AWB: TcxDBEditorRow;
      cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow;
      cxDBVerticalGrid1CategoryRow1: TcxCategoryRow;
      cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow;
      cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow;
      cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow;
      IBCQueryDelivery: TIBCQuery;
      IBCDSDelivery: TIBCDataSource;
      pnButtons: TPanel;
      btnAddDelivery: TcxButton;
      btnDeleteDelivery: TcxButton;
      lbEmptyHint: TLabel;
      procedure btnAddDeliveryClick(Sender: TObject);
      procedure btnDeleteDeliveryClick(Sender: TObject);
      procedure cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
      procedure IBCDSDeliveryStateChange(Sender: TObject);
      procedure IBCDSDeliveryDataChange(Sender: TObject; Field: TField);
   private
    { Private declarations }
      fDocID: Integer;
      fReadOnly: Boolean;
      procedure SetReadOnly(const Value: Boolean);
   protected
      function HasRecord: Boolean;
   public
      procedure PostData(DocID: Integer);
      procedure PrepareData(DocID: Integer);
      procedure CancelData;
      procedure CloseData;
      procedure UpdateControlsState;
      function HasData: Boolean;
      property ReadOnly: Boolean read fReadOnly write SetReadOnly;
    { Public declarations }
   end;

implementation

uses
   System.UITypes, DataModuleDB, SWNUtils, frmCustomersDlg;

{$R *.dfm}

function TframeDocsDelivery.HasRecord: Boolean;
begin
   Result := IBCQueryDelivery.Active and ((IBCQueryDelivery.RecordCount > 0) or (IBCQueryDelivery.State = dsInsert));
end;

function TframeDocsDelivery.HasData: Boolean;
begin
   Result := HasRecord;
end;

procedure TframeDocsDelivery.UpdateControlsState;
var
   Present: Boolean;
begin
   if ([csLoading, csDestroying] * ComponentState <> []) or (btnAddDelivery = nil) then
      Exit;

   Present := HasRecord;

   btnAddDelivery.Enabled := (not fReadOnly) and IBCQueryDelivery.Active and (not Present);
   btnDeleteDelivery.Enabled := (not fReadOnly) and Present and (IBCQueryDelivery.State <> dsInsert);

   cxDBVerticalGrid1.Visible := Present;
   lbEmptyHint.Visible := not Present;
end;

procedure TframeDocsDelivery.SetReadOnly(const Value: Boolean);
begin
   fReadOnly := Value;
   cxDBVerticalGrid1.OptionsData.Editing := not Value;
   UpdateControlsState;
end;

procedure TframeDocsDelivery.btnAddDeliveryClick(Sender: TObject);
begin
   if fReadOnly or (not IBCQueryDelivery.Active) or HasRecord then
      Exit;

   IBCQueryDelivery.Append;
   IBCQueryDelivery.FieldByName('DOCID').AsInteger := fDocID;
   IBCQueryDelivery.FieldByName('COURIERID').AsInteger := dmDB.CurrentFirma;
   IBCQueryDelivery.FieldByName('COURIER_NAME').AsString := dmDB.CurrentFirmaName;
   IBCQueryDelivery.FieldByName('DELIVERY_DATE').AsDateTime := Date;
   IBCQueryDelivery.FieldByName('FLG_CASHONDELIVERY').AsInteger := 0;
   IBCQueryDelivery.FieldByName('FLG_INVOICE_ONDELIVERY').AsInteger := 0;

   UpdateControlsState;

   if cxDBVerticalGrid1.CanFocus then
      cxDBVerticalGrid1.SetFocus;
end;

procedure TframeDocsDelivery.btnDeleteDeliveryClick(Sender: TObject);
begin
   if fReadOnly or (not HasRecord) then
      Exit;

   if ShowAskDialog('Sterge datele de livrare',
      'Doriti sa eliminati datele de livrare ale acestui document?') <> mrYes then
      Exit;

   if IBCQueryDelivery.State in dsEditModes then
      IBCQueryDelivery.Cancel;
   IBCQueryDelivery.Delete;

   UpdateControlsState;
end;

procedure TframeDocsDelivery.cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject;
   AButtonIndex: Integer);
var
   dialog: TfrmCustomersDlg;
begin
   if fReadOnly or (not HasRecord) then
      Exit;

   dialog := TfrmCustomersDlg.Create(Self);
   try
      if dialog.SelectCustomer(IBCQueryDelivery.FieldByName('COURIERID').AsInteger, False, 0, 'Alege transportator') then
      begin
         if not (IBCQueryDelivery.State in dsEditModes) then
            IBCQueryDelivery.Edit;
         IBCQueryDelivery.FieldByName('COURIERID').AsInteger := dialog.CustomerID;
         IBCQueryDelivery.FieldByName('COURIER_NAME').AsString := dialog.CustomerTitle;
      end;
   finally
      dialog.Free;
   end;
end;

procedure TframeDocsDelivery.IBCDSDeliveryDataChange(Sender: TObject; Field: TField);
begin
   UpdateControlsState;
end;

procedure TframeDocsDelivery.IBCDSDeliveryStateChange(Sender: TObject);
begin
   UpdateControlsState;
end;

procedure TframeDocsDelivery.PostData(DocID: Integer);
begin
   if not IBCQueryDelivery.Active then
      Exit;

   try
      if IBCQueryDelivery.State in dsEditModes then
      begin
         if IBCQueryDelivery.State = dsInsert then
            IBCQueryDelivery.FieldByName('DOCID').AsInteger := DocID;
         IBCQueryDelivery.Post;
      end;
   except
      on e: Exception do
      begin
         IBCQueryDelivery.Cancel;
         raise;
      end;
   end;
end;

procedure TframeDocsDelivery.PrepareData(DocID: Integer);
begin
   fDocID := DocID;

   IBCQueryDelivery.Close;
   if IBCQueryDelivery.FindParam('DOCID') <> nil then
      IBCQueryDelivery.ParamByName('DOCID').AsInteger := DocID;
   IBCQueryDelivery.Open;

   UpdateControlsState;
end;

procedure TframeDocsDelivery.CancelData;
begin
   if IBCQueryDelivery.Active and (IBCQueryDelivery.State in dsEditModes) then
      IBCQueryDelivery.Cancel;
end;

procedure TframeDocsDelivery.CloseData;
begin
   IBCQueryDelivery.Close;
end;

end.
