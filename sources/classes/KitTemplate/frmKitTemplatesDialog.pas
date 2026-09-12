unit frmKitTemplatesDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxStyles, DB, cxDBData,
  Menus, IBC, dxBar, StdCtrls, cxButtons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, cxCalc, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxImageComboBox, cxCheckBox, cxLabel, DBAccess, MemDS, cxClasses, cxGridCustomView;

type
  TfrmKitTemplatesDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    bbNewTemplate: TdxBarButton;
    IBCQueryKit: TIBCQuery;
    IBCDataSourceKit: TIBCDataSource;
    IBCTrUpdateKit: TIBCTransaction;
    bbModifyTemplate: TdxBarButton;
    bbRemoveTemplate: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbTemplateItems: TdxBarButton;
    IBCQueryItems: TIBCQuery;
    IBCDataSourceItems: TIBCDataSource;
    Panel1: TPanel;
    cxGridTemplate: TcxGrid;
    cxGridTemplateTable: TcxGridDBTableView;
    cxGridTemplate_KITTEMPLATEID: TcxGridDBColumn;
    cxGridTemplate_TITLE: TcxGridDBColumn;
    cxGridTemplate_FLG_PUBLIC: TcxGridDBColumn;
    cxGridTemplate_DESCRIPTION: TcxGridDBColumn;
    cxGridTemplate_USER_NAME: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridTemplateDetails: TcxGrid;
    cxGridTemplateDetailsTable: TcxGridDBTableView;
    cxGridTemplateItemCol_ID: TcxGridDBColumn;
    cxGridTemplateItemCol_GOODS_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_UM_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_QTY: TcxGridDBColumn;
    cxGridTemplateItemCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridTemplateLevel: TcxGridLevel;
    cxGridTemplate_GOODS_COUNT: TcxGridDBColumn;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cbViewItems: TdxBarButton;
    cxGridTemplateItemCol_IMG: TcxGridDBColumn;
    cxGridTemplate_IMG: TcxGridDBColumn;
    procedure IBCDataSourceKitDataChange(Sender: TObject; Field: TField);
    procedure bbNewTemplateClick(Sender: TObject);
    procedure bbModifyTemplateClick(Sender: TObject);
    procedure bbRemoveTemplateClick(Sender: TObject);
    procedure cxGridTemplateTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure bbTemplateItemsClick(Sender: TObject);
    procedure cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cbViewItemsClick(Sender: TObject);
    procedure cxGridTemplate_TITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FSelectMode: Boolean;
    fKitTemplateID: integer;
    fKitTemplateName: String;
    procedure SetSelectMode(const Value: Boolean);
    procedure PrepareView;
    procedure SelectedTemplateChanged;

    procedure ShowAddNewKitTemplateDialog;
    procedure ShowModifySelectedKitTemplateDialog;
    procedure DeleteCurrentSelectedTemplate;

    procedure ShowEditTemplateItemsDialog;

    procedure TemplateSelected;
    procedure SetupQtyFields;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    procedure LoadStates;override;
    procedure SaveStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }

    property SelectMode:Boolean read FSelectMode write SetSelectMode;
    property KitTemplateID:integer read fKitTemplateID;
    property KitTemplateName:String read fKitTemplateName;
  end;

implementation

uses DataModuleAdditions, frmKitTemplateEditorDialog, frmKitTemplateItemsEditorDialog,
     SWNUtils, SWNConst, SWNValueStorageUnit, SWNSecurityFlags, DataModuleDB, SWNDBErrors;

{$R *.dfm}

{ TfrmKitTemplatesDlg }

procedure TfrmKitTemplatesDlg.bbModifyTemplateClick(Sender: TObject);
begin
     ShowModifySelectedKitTemplateDialog;
end;

procedure TfrmKitTemplatesDlg.bbNewTemplateClick(Sender: TObject);
begin
     ShowAddNewKitTemplateDialog;
end;

procedure TfrmKitTemplatesDlg.bbRemoveTemplateClick(Sender: TObject);
begin
     DeleteCurrentSelectedTemplate;
end;

procedure TfrmKitTemplatesDlg.bbTemplateItemsClick(Sender: TObject);
begin
     ShowEditTemplateItemsDialog;
end;

procedure TfrmKitTemplatesDlg.btnOkClick(Sender: TObject);
begin
     if IBCQueryKit.RecordCount>0 then TemplateSelected;
end;

procedure TfrmKitTemplatesDlg.cbViewItemsClick(Sender: TObject);
begin
     if cbViewItems.Down=True then
     begin
          // expand
          cxGridTemplateDetails.Visible:=True;
          if IBCQueryKit.Active then IBCQueryItems.Active:=True;
     end
     else
     begin
          // collapse
          cxGridTemplateDetails.Visible:=False;
          IBCQueryItems.Active:=False;
     end;
end;

procedure TfrmKitTemplatesDlg.cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbTemplateItems.Enabled and (bbTemplateItems.Visible=ivAlways) then
     begin
          ShowEditTemplateItemsDialog;
          AHandled:=True;
     end;
end;

procedure TfrmKitTemplatesDlg.cxGridTemplateTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if FSelectMode then
     begin
          TemplateSelected;
          AHandled:=True;
     end
     else
     if bbModifyTemplate.Enabled and (bbModifyTemplate.Visible=ivAlways) then
     begin
          ShowModifySelectedKitTemplateDialog;
          AHandled:=True;
     end;
end;

procedure TfrmKitTemplatesDlg.cxGridTemplate_TITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridTemplate_FLG_PUBLIC.Index]=1 then AStyle:=dmAdditions.cxStyle_Bold;
end;

procedure TfrmKitTemplatesDlg.DeleteCurrentSelectedTemplate;
var S,S2:String;
begin
     S2:='';
     S:=Format(cMSG_DELETERECORD_KitTemplate_DeleteTemplate,[IBCQueryKit.FieldByName('TITLE').AsString]);
     if (IBCQueryKit.FieldByName('FLG_PUBLIC').AsInteger=1) then S2:='Acest sablon este pentru uz general!';

     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,S,S2)=mrYes then
     begin
          IBCTrUpdateKit.StartTransaction;
          try
             IBCQueryKit.Delete;
             IBCTrUpdateKit.Commit;
          except on E:Exception do
             begin
                  IBCTrUpdateKit.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmKitTemplatesDlg.IBCDataSourceKitDataChange(Sender: TObject; Field: TField);
begin
     SelectedTemplateChanged;
end;

procedure TfrmKitTemplatesDlg.BindingDataSource;
begin
     inherited;

     fKitTemplateName:='';
     fKitTemplateID:=-1;
     FSelectMode := True;
     IBCQueryKit.Connection:=fIBCConnection;
     IBCQueryItems.Connection:=fIBCConnection;
end;

procedure TfrmKitTemplatesDlg.LoadStates;
var i:integer;
    Col:TcxGridDBColumn;
begin
     AppUserConfigStorage.FormPositions.ReadFormPos(Self);
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // save column visibility and width
        for i := 0 to cxGridTemplateTable.ColumnCount-1 do
        begin
             Col:=cxGridTemplateTable.Columns[i];
             Col.Width:=AppUserConfigStorage.IntValues.GetValue(Col.Name,Col.Width);
             if Col.VisibleForCustomization then Col.Visible:=AppUserConfigStorage.BooleanValues.GetValue(Col.Name,Col.Visible);
        end;
        // details
        cbViewItems.Down:=AppUserConfigStorage.BooleanValues.GetValue('Details');
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmKitTemplatesDlg.Prepare;
begin
     SetupSecurityItems;
     SetupQtyFields;

     if FSelectMode
      then dtDialogTitle.Text:='Selectati configuratia pentru utilizare'
      else dtDialogTitle.Text:='Gestionare configuratii gata';

     dmDB.CreateGridImageColumnItems(cxGridTemplateItemCol_IMG);

     PrepareView;
     // Open data
     IBCQueryKit.ParamByName('UserID').AsInteger:=UserID;
     IBCQueryKit.Active:=True;
     if cbViewItems.Down=True then IBCQueryItems.Active:=True;
     cbViewItemsClick(cbViewItems);
end;

procedure TfrmKitTemplatesDlg.PrepareView;
begin
     if FSelectMode then
     begin
          cxGridTemplateDetails.Visible:=False;
     end
     else
     begin
          btnOk.Visible:=False;
          btnCancel.Caption:='Inchide';
     end;
end;

procedure TfrmKitTemplatesDlg.SaveStates;
var i:integer;
    Col:TcxGridDBColumn;
begin
     AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // save column visibility and width
        for i := 0 to cxGridTemplateTable.ColumnCount-1 do
        begin
             Col:=cxGridTemplateTable.Columns[i];
             AppUserConfigStorage.IntValues.SetValue(Col.Name,Col.Width);
             if Col.VisibleForCustomization then AppUserConfigStorage.BooleanValues.SetValue(Col.Name,Col.Visible);
        end;
        // details
        AppUserConfigStorage.BooleanValues.SetValue('Details',cbViewItems.Down);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmKitTemplatesDlg.SelectedTemplateChanged;
var fKitNew,fKitEdit,fKitDelete:Boolean;
begin
     fKitNew:=True; // Sablon nou + Security
     fKitEdit:=False;
     fKitDelete:=False;
     if (cxGridTemplateTable.DataController.RecNo>0) then
     begin
          fKitEdit:=IBCQueryKit.FieldByName('USERID').AsInteger=UserID; // Modifica sablonul + Security
          fKitDelete:=IBCQueryKit.FieldByName('USERID').AsInteger=UserID; // Sterge sablonul + Security
     end;
     bbNewTemplate.Enabled:=fKitNew;
     bbModifyTemplate.Enabled:=fKitEdit;
     bbRemoveTemplate.Enabled:=fKitDelete;
     bbTemplateItems.Enabled:=fKitEdit;
end;

procedure TfrmKitTemplatesDlg.SetSelectMode(const Value: Boolean);
begin
     FSelectMode := Value;
     if FSelectMode then cbViewItems.Down:=False;
end;

procedure TfrmKitTemplatesDlg.SetupQtyFields;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
     TcxCalcEditProperties(cxGridTemplateItemCol_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
     cxGridTemplateItemCol_QTY.Summary.FooterFormat:=cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmKitTemplatesDlg.SetupSecurityItems;
begin
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_ШК_Создать) then bbNewTemplate.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_ШК_Редактировать) then bbModifyTemplate.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_ШК_Удалить) then bbRemoveTemplate.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_ШК_Изменить_состав_шаблона) then bbTemplateItems.Visible:=ivNever;
end;

procedure TfrmKitTemplatesDlg.ShowAddNewKitTemplateDialog;
var dialog:TfrmKitTemplateEditorDlg;
begin
     dialog:=TfrmKitTemplateEditorDlg.Create(Self,IBCQueryKit,IBCDataSourceKit);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplatesDlg.ShowEditTemplateItemsDialog;
var dialog:TfrmKitTemplateItemsEditorDlg;
begin
     dialog:=TfrmKitTemplateItemsEditorDlg.Create(self,IBCQueryKit,IBCDataSourceKit);
     try
        if dialog.ShowModal=mrOk then
        begin
             if IBCQueryItems.Active then IBCQueryItems.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplatesDlg.ShowModifySelectedKitTemplateDialog;
var dialog:TfrmKitTemplateEditorDlg;
begin
     dialog:=TfrmKitTemplateEditorDlg.Create(Self,IBCQueryKit,IBCDataSourceKit);
     try
        dialog.CreateNewRecord:=False;
        if dialog.ShowModal=mrOk then IBCQueryKit.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplatesDlg.TemplateSelected;
begin
     fKitTemplateID:=IBCQueryKit.FieldByName('KITTEMPLATEID').AsInteger;
     fKitTemplateName:=IBCQueryKit.FieldByName('TITLE').AsString;
     ModalResult:=mrOk;
end;

end.
