unit frmCertificationsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus, cxStyles,
  DB, cxDBData, IBC, dxBar,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, ExtCtrls, StdCtrls,
  cxButtons, DialogTitle, cxDBEdit, cxSplitter, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel,
  cxContainer, MemDS, DBAccess, cxClasses, cxTextEdit, cxMemo, cxGridTableView, cxGridCustomView;

type
  TfrmCertificationsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    dxBarDockControl: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNewCertificat: TdxBarButton;
    bbModifyCertificat: TdxBarButton;
    bbRemoveCertificat: TdxBarButton;
    cxGridCertTable: TcxGridDBTableView;
    cxGridCertLevel: TcxGridLevel;
    cxGridCert: TcxGrid;
    IBCDataSourceCertif: TIBCDataSource;
    cxGridCert_CERTIFICATID: TcxGridDBColumn;
    cxGridCert_DENUMIREA: TcxGridDBColumn;
    cxGridCert_NUMAR_INREG: TcxGridDBColumn;
    cxGridCert_SOLICITANT_ID: TcxGridDBColumn;
    cxGridCert_PERIOADA_START: TcxGridDBColumn;
    cxGridCert_PERIOADA_END: TcxGridDBColumn;
    IBCTrUpdateCertif: TIBCTransaction;
    bbGoods: TdxBarButton;
    pnClient: TPanel;
    cxGridCert_IMAGE_COUNT: TcxGridDBColumn;
    bbSearch: TdxBarButton;
    pnButtons: TPanel;
    btnCancel: TcxButton;
    cxSplitter1: TcxSplitter;
    pnInfo: TPanel;
    Label1: TLabel;
    cxDBMemo1: TcxDBMemo;
    cxGridCert_CREATED_BY_NAME: TcxGridDBColumn;
    IBCQueryCertif: TIBCQuery;
    procedure cxGridCertTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewCertificatClick(Sender: TObject);
    procedure bbModifyCertificatClick(Sender: TObject);
    procedure cxGridCertTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbRemoveCertificatClick(Sender: TObject);
    procedure cxGridCertTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbGoodsClick(Sender: TObject);
    procedure bbSearchClick(Sender: TObject);
  private
    { Private declarations }
    fInSearch:Boolean;
    procedure SelectionChanged;
    procedure ShowAddNewCertificatDialog;
    procedure ShowModifyCertificatDialog;
    procedure DeleteCurrentCertificat;
    procedure ShowLinkGoodsToCertificatDialog;

    procedure ShowSearchDialog;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure ManageCertificates;
  end;


implementation

uses DataModuleAdditions, frmCertificatEditorDialog, SWNUtils, frmCertificateGoodsDialog, SWNSecurityFlags,
  SWNSearchUnit;

{$R *.dfm}

procedure TfrmCertificationsDlg.bbGoodsClick(Sender: TObject);
begin
     ShowLinkGoodsToCertificatDialog;
end;

procedure TfrmCertificationsDlg.bbModifyCertificatClick(Sender: TObject);
begin
     ShowModifyCertificatDialog;
end;

procedure TfrmCertificationsDlg.bbNewCertificatClick(Sender: TObject);
begin
     ShowAddNewCertificatDialog;
end;

procedure TfrmCertificationsDlg.bbRemoveCertificatClick(Sender: TObject);
begin
     DeleteCurrentCertificat;
end;

procedure TfrmCertificationsDlg.bbSearchClick(Sender: TObject);
begin
     if fInSearch then
     begin
          IBCQueryCertif.Active:=False;
          IBCQueryCertif.FilterSQL:='';
          IBCQueryCertif.Active:=True;
          fInSearch:=False;
          bbSearch.Caption:='Cauta';
     end
     else ShowSearchDialog;
end;

procedure TfrmCertificationsDlg.cxGridCertTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbModifyCertificat.Enabled and (bbModifyCertificat.Visible=ivAlways) then
     begin
          ShowModifyCertificatDialog;
          AHandled:=True;
     end;
end;

procedure TfrmCertificationsDlg.cxGridCertTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmCertificationsDlg.cxGridCertTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridCert_PERIOADA_END.Index]<NOW then AStyle:=dmAdditions.cxStyle_BackgroundRED;
end;

procedure TfrmCertificationsDlg.DeleteCurrentCertificat;
begin
     if ShowAskDialog('Eliminare certificat','Elimia certificat nr.'+#13#10+IBCQueryCertif.FieldByName('NUMAR_INREG').asWideString+' ?','Соответсвтующие товары будут лишены данного сертификаты!')=mrYes then
     begin
          IBCQueryCertif.Delete;
          IBCTrUpdateCertif.Commit;
     end;
end;

procedure TfrmCertificationsDlg.ManageCertificates;
begin
     ShowModal;
end;

procedure TfrmCertificationsDlg.Prepare;
begin
     fInSearch:=False;

     SetupSecurityItems;

     SelectionChanged;
     IBCQueryCertif.Active:=True;
end;

procedure TfrmCertificationsDlg.SelectionChanged;
var fNew,fModify,fDelete,fGoods:Boolean;
begin
     fNew:=True; // New
     fModify:=False;
     fDelete:=False;
     fGoods:=False;
     if cxGridCertTable.DataController.RecNo>0 then
     begin
          fModify:=True; // Modify
          fDelete:=True; // Delete
          fGoods:=True; // Goods
     end;
     // buttons
     bbNewCertificat.Enabled:=fNew;
     bbModifyCertificat.Enabled:=fModify;
     bbRemoveCertificat.Enabled:=fDelete;
     bbGoods.Enabled:=fGoods;
end;

procedure TfrmCertificationsDlg.SetupSecurityItems;
var viewAny:Boolean;
begin
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Сертификаты_Создать) then bbNewCertificat.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Сертификаты_Редактировать) then bbModifyCertificat.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Сертификаты_Удалить) then bbRemoveCertificat.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Сертификаты_Просмотр_сертифицированных_товаров) then bbGoods.Visible:=ivNever;

     viewAny:=(bbNewCertificat.Visible=ivAlways) or (bbModifyCertificat.Visible=ivAlways) or (bbRemoveCertificat.Visible=ivAlways) or (bbGoods.Visible=ivAlways);

     if Not viewAny then
     begin
          dxBarManager1Bar1.Visible:=False;
          dxBarDockControl.Visible:=False;
     end;
end;

procedure TfrmCertificationsDlg.ShowAddNewCertificatDialog;
var dialog:TfrmCertificatEditorDlg;
begin
     dialog:=TfrmCertificatEditorDlg.Create(Self,IBCQueryCertif,IBCDataSourceCertif);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCertificationsDlg.ShowLinkGoodsToCertificatDialog;
var dialog:TfrmCertificateGoodsDlg;
begin
     dialog:=TfrmCertificateGoodsDlg.Create(Self,IBCQueryCertif,IBCDataSourceCertif);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCertificationsDlg.ShowModifyCertificatDialog;
var dialog:TfrmCertificatEditorDlg;
begin
     dialog:=TfrmCertificatEditorDlg.Create(Self,IBCQueryCertif,IBCDataSourceCertif);
     try
        dialog.CreateNewRecord:=False;
        if dialog.Showmodal=mrOk then
        begin

        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCertificationsDlg.ShowSearchDialog;
var Search:TSWNSearchDialog;
    SearchInWhere:String;
    SC:TSearchCriteria;
    i:integer;
begin
     SearchInWhere:='';

     Search:=TSWNSearchDialog.Create(Self);
     try
        if Search.GetSearchCritera(stCertificate) then
        begin
             for i := 0 to Search.SearchCriteriasCount - 1 do
             begin
                  SC:=Search.SearchCriterias[i];
                  if (SC.SearchField=sfName) then AddConditionToWHERE(SearchInWhere,Format('(DENUMIREA CONTAINING ''%S'')',[SC.SearchText]))
                  else
                  if (SC.SearchField=sfID) then AddConditionToWHERE(SearchInWhere,Format('(NUMAR_INREG CONTAINING ''%S'')',[SC.SearchText]))
                  else
                  if (SC.SearchField=sfArticul) then AddConditionToWHERE(SearchInWhere,Format('(INFO_SUPLIMENTAR CONTAINING ''%S'')',[SC.SearchText]))
             end;
        end;
     finally
        Search.Free;
     end;

     if SearchInWhere<>'' then
     begin
          IBCQueryCertif.Active:=False;
          IBCQueryCertif.FilterSQL:=SearchInWhere;
          IBCQueryCertif.Active:=True;
          fInSearch:=True;
          bbSearch.Caption:='Arata tot';
     end;
end;

end.
