unit frmCertificatEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, MemDS, IBC, dxBar,
  StdCtrls, cxDBEdit, cxButtonEdit,
  ExtCtrls, DialogTitle,
  cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, frxClass, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxImage, Vcl.Menus, DBAccess, cxClasses, cxGridTableView, cxGridCustomView, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxMemo, cxTextEdit;

type
  TfrmCertificatEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edNUMAR_INREG: TcxDBTextEdit;
    cxLabel2: TLabel;
    mmDENUMIREA: TcxDBMemo;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    dePERIOADA_START: TcxDBDateEdit;
    dePERIOADA_END: TcxDBDateEdit;
    cxLabel5: TLabel;
    mmINFO_SUPLIMENTAR: TcxDBMemo;
    cxLabel6: TLabel;
    beSolicitant: TcxButtonEdit;
    dxBarManager: TdxBarManager;
    Label1: TLabel;
    pnPhotos: TPanel;
    cxGrid: TcxGrid;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbNewPhoto: TdxBarButton;
    bbModifyPhoto: TdxBarButton;
    bbDeletePhoto: TdxBarButton;
    bbPrintPhoto: TdxBarButton;
    IBCQueryImages: TIBCQuery;
    IBCDataSourceImages: TIBCDataSource;
    cxGridDBTable_IMAGEID: TcxGridDBColumn;
    frxReportImage: TfrxReport;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beSolicitantPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewPhotoClick(Sender: TObject);
    procedure bbDeletePhotoClick(Sender: TObject);
    procedure bbPrintPhotoClick(Sender: TObject);
    procedure bbModifyPhotoClick(Sender: TObject);
    procedure cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure frxReportImageGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    fCurr_CertificatID:integer;
    fCurr_ImageID:integer;
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams:Boolean;
    procedure SelectCustomer;

    procedure PhotoSelectionChanged;
    procedure ShowCreateNewImageDialog;
    procedure ShowEditImageDialog;
    procedure DoDeleteImage;
    procedure DoPrintCertificat(const CertificatID, ImageID:integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;



implementation

uses SWNUtils, SWNConst,
  frmCustomersDlg, SWNDBErrors, frmCertificatImageEditorDialog;

{$R *.dfm}

{ TfrmCertificatEditorDlg }

procedure TfrmCertificatEditorDlg.bbDeletePhotoClick(Sender: TObject);
begin
     DoDeleteImage;
end;

procedure TfrmCertificatEditorDlg.bbModifyPhotoClick(Sender: TObject);
begin
     ShowEditImageDialog;
end;

procedure TfrmCertificatEditorDlg.bbNewPhotoClick(Sender: TObject);
begin
     ShowCreateNewImageDialog;
end;

procedure TfrmCertificatEditorDlg.bbPrintPhotoClick(Sender: TObject);
begin
     DoPrintCertificat(IBCQueryImages.FieldByName('CERTIFICATID').AsInteger, IBCQueryImages.FieldByName('IMAGEID').AsInteger);
end;

procedure TfrmCertificatEditorDlg.beSolicitantPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectCustomer;
end;

function TfrmCertificatEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=false;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('NUMAR_INREG').IsNull or (fMasterDataSet.FieldByName('NUMAR_INREG').asString='') then AddErrorToStr(ErrorStr,'Регистрационный номер!');
     if fMasterDataSet.FieldByName('DENUMIREA').IsNull or (fMasterDataSet.FieldByName('DENUMIREA').asString='') then AddErrorToStr(ErrorStr,'Название!');
     if fMasterDataSet.FieldByName('SOLICITANT_ID').IsNull then AddErrorToStr(ErrorStr,'Поставщик!');
     if fMasterDataSet.FieldByName('PERIOADA_START').IsNull or fMasterDataSet.FieldByName('PERIOADA_END').IsNull then AddErrorToStr(ErrorStr,'Период годности!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmCertificatEditorDlg.cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbModifyPhoto.Enabled then
     begin
          bbModifyPhotoClick(bbModifyPhoto);
          AHandled:=True;
     end;
end;

procedure TfrmCertificatEditorDlg.cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     PhotoSelectionChanged;
end;

procedure TfrmCertificatEditorDlg.DoDeleteImage;
begin
     if ShowAskDialog('Elimina imagine certificat','Doriti eliminearea imaginii certificatului?')=mrYes then
     begin
          try
             IBCQueryImages.Delete;
          except on E:Exception do
             begin
                  if Not ProcessSWNError(e) then raise;
             end;
          end;
     end;
end;

procedure TfrmCertificatEditorDlg.DoPrintCertificat(const CertificatID, ImageID: integer);
begin
     fCurr_CertificatID:=CertificatID;
     fCurr_ImageID:=ImageID;
     frxReportImage.PrepareReport;
     frxReportImage.ShowPreparedReport;
end;

procedure TfrmCertificatEditorDlg.frxReportImageGetValue(const VarName: string; var Value: Variant);
begin
     if VarName='CERTIFICATID' then Value:=fCurr_CertificatID
     else
     if VarName='IMAGEID' then Value:=fCurr_ImageID;
end;

procedure TfrmCertificatEditorDlg.BindingDataSource;
begin
     inherited;

     FCreateNewRecord := False;
     
     IBCQueryImages.Connection:=fMasterDataSet.Connection;
     IBCQueryImages.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryImages.MasterSource:=fMasterDataSource;

     edNUMAR_INREG.DataBinding.DataSource:=fMasterDataSource;
     mmDENUMIREA.DataBinding.DataSource:=fMasterDataSource;
     dePERIOADA_START.DataBinding.DataSource:=fMasterDataSource;
     dePERIOADA_END.DataBinding.DataSource:=fMasterDataSource;
     mmINFO_SUPLIMENTAR.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmCertificatEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmCertificatEditorDlg.PhotoSelectionChanged;
var fNew,fEdit,fDelete,fPrint:Boolean;
begin
     fNew:=IBCQueryImages.Active;
     fEdit:=false;
     fDelete:=false;
     fPrint:=false;
     if (cxGridDBTable.DataController.RecNo>0) then
     begin
          fEdit:=true;
          fDelete:=true;
          fPrint:=true;
     end;
     bbNewPhoto.Enabled:=fNew;


end;

procedure TfrmCertificatEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Adaugarea unui certificiat';

             fMasterDataSet.Append;

             fMasterDataSet.FieldByName('CREATED_BY').AsInteger:=UserID;
             fMasterDataSet.FieldByName('PERIOADA_START').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('PERIOADA_END').AsDateTime:=NOW;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare certificat';

             fMasterDataSet.Edit;

             beSolicitant.Text:=fMasterDataSet.FieldByName('SOLICITANT_NAME').asString;

             // images only in edit mode
             IBCQueryImages.Active:=true;
        end;

        PhotoSelectionChanged;

     except on E:Exception do
        begin
             fMasterDataSet.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmCertificatEditorDlg.SelectCustomer;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(fMasterDataSet.FieldByName('SOLICITANT_ID').asInteger,False,0,'Alege furnizorul certificatului') then
        begin
             fMasterDataSet.FieldByName('SOLICITANT_ID').asInteger:=dialog.CustomerID;
             beSolicitant.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end; 
end;

procedure TfrmCertificatEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmCertificatEditorDlg.ShowCreateNewImageDialog;
var dialog:TfrmCertificatImageEditorDlg;
begin
     dialog:=TfrmCertificatImageEditorDlg.Create(Self,IBCQueryImages, IBCDataSourceImages);
     try
        dialog.CreateNewImage:=True;
        dialog.CertificatID:=fMasterDataSet.FieldByName('CERTIFICATID').AsInteger;

        if dialog.ShowModal=mrOk then IBCQueryImages.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCertificatEditorDlg.ShowEditImageDialog;
var dialog:TfrmCertificatImageEditorDlg;
begin
     dialog:=TfrmCertificatImageEditorDlg.Create(Self,IBCQueryImages, IBCDataSourceImages);
     try
        dialog.CreateNewImage:=False;
        dialog.CertificatID:=fMasterDataSet.FieldByName('CERTIFICATID').AsInteger;
        if dialog.ShowModal=mrOk then IBCQueryImages.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCertificatEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
