unit frmInventarizatiaPereotencaTovaraDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle,
  cxDBEdit,

  ExtCtrls, Menus, StdCtrls, cxButtons, DB,
  IBC, cxButtonEdit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, DBAccess,
  MemDS, cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxMemo, dxUIAClasses, dxCoreGraphics;

type
  TfrmInventarizatiaPereotencaTovaraDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    Bevel1: TBevel;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    IBCDataSourceDocProps: TIBCDataSource;
    Label1: TLabel;
    beCT_NAME: TcxButtonEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure edCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate:Boolean;

    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams:Boolean;
    procedure CloseAdditionalDataSources;

    procedure SelectDT;

    procedure ShowDocumentCommentsEditorDialog;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure SelectCT;
    procedure WhenCancelForm;override;

    procedure SetupSecurityItems;override;

  public
    { Public declarations }
    property CreateNewDocument:Boolean read fCreateNewDocument write SetCreateNewDocument;
  end;


implementation

uses DateUtils, DataModuleDB, SWNUtils, SWNConst,
     SWNValueStorageUnit, frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectDT;
end;

function TfrmInventarizatiaPereotencaTovaraDocDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     with dmDB.IBCQueryDocs do
     begin
          if FieldByName('DATA').IsNull then AddErrorToStr(ErrorStr,'Data')
          else
          begin
               if (DateOf(dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime)<DateOf(NOW)) and (Not fSECURITY_CanSetupPastDate) then AddErrorToStr(ErrorStr,'Дата документа слишком стара!');
          end;

          if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger=-1) then AddErrorToStr(ErrorStr,'Subdiviziunea!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     CloseAdditionalDataSources;
end;

function TfrmInventarizatiaPereotencaTovaraDocDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          dmDB.IBCQueryDocs.Post;
          if IBCQueryDocProps.State in dsEditModes then IBCQueryDocProps.Post;
          dmDB.IBCQueryDocs.UpdateTransaction.Commit;
          AppUserConfigStorage.IntValues.SetValue ('frmInventarizatiaPereotencaTovaraDocDlgCT', dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
     ShowDocumentCommentsEditorDialog;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.Prepare;
var DocumentAdditionalFlags:TDocumentAdditionalFlags;
begin
     SetupSecurityItems;

     dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
     try
        if fCreateNewDocument then
        begin
             dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
             dmDB.IBCQueryDocs.Append;

             dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger:=dmDB.CurrentDocTypeID;
             // system defaults
             if Not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID,dmDB.CurrentFirma,dmDB.IBCQueryDocs,DocumentAdditionalFlags) then
             begin
                  dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger:=-1;
                  dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
             end;

             // local defaults
             dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime:=NOW;
             dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency:=0;

             beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
             dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := AppUserConfigStorage.IntValues.GetValue('frmInventarizatiaPereotencaTovaraDocDlgCT', -1);
             beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

        end
        else
        begin
             dtDialogTitle.Text:=Format(cMSG_DIALOG_DOCUMENT_Edit,[dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
             // Edit
             dmDB.IBCQueryDocs.Edit;
             beDT_NAME.Text:=dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
             beCT_NAME.Text:=dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end;

        dmDB.IBCQueryAnalitica.Active:=True;
        dmDB.OpenAnalyticsDataSource;
        IBCQueryDocProps.Active:=True;

     except
        if dmDB.IBCQueryDocs.State in dsEditModes then dmDB.IBCQueryDocs.Cancel;
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

        CloseAdditionalDataSources;

        raise;
     end;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.SelectDT;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        dialog.CustomFilter:=[cfFirms,cfFranchises];
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger,False,0,'Alege subdiviziunea') then
        begin
             dmDB.IBCQueryDocs.FieldByName('DT').asInteger:=dialog.CustomerID;
             beDT_NAME.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
     fCreateNewDocument := Value;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.SetupSecurityItems;
begin
     fSECURITY_CanSetupPastDate:=SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.ShowDocumentCommentsEditorDialog;
var dialog:TfrmDocumentCommentsEditorDlg;
begin
     dialog:=TfrmDocumentCommentsEditorDlg.Create(Self,IBCQueryDocProps,IBCDataSourceDocProps);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.WhenCancelForm;
begin
     if IBCQueryDocProps.State in dsEditModes then IBCQueryDocProps.Cancel;
     dmDB.IBCQueryDocs.Cancel;
     dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
     dmDB.IBCQueryAnalitica.Close;
     dmDB.IBCQueryAnalytics.Close;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.edCT_NAMEPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmInventarizatiaPereotencaTovaraDocDlg.SelectCT;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        dialog.CustomFilter:=[cfCustomers, cfFirms];
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger,False,0,'Alege Furnizorul') then
        begin
             dmDB.IBCQueryDocs.FieldByName('CT').asInteger:=dialog.CustomerID;
             beCT_NAME.Text:= dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

end.
