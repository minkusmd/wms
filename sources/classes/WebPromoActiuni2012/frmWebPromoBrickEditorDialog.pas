unit frmWebPromoBrickEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, dxBar, cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxImage, cxDBEdit, Vcl.StdCtrls, cxBarEditItem, cxMaskEdit, cxTextEdit, cxCalc, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TfrmWebPromoBrickEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    imgIMAGE: TcxDBImage;
    Label2: TLabel;
    pnLinks: TPanel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridLevel: TcxGridLevel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridTableColumn1: TcxGridColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    FCreateNewRecord: Boolean;
    FPromoActionID: integer;
    { Private declarations }
    procedure LinksSelectionChanged;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure LoadLinksList(const ImageBrickID:integer);
    function SaveLinksToDB(const ImageBrickID:integer):Boolean;
    function CheckValues:Boolean;
    procedure SetPromoActionID(const Value: integer);

    procedure ShowCreateNewLinkDialog;
    procedure ShowModifyLinkDialog;
    procedure DeleteLink;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property PromoActionID:integer read FPromoActionID write SetPromoActionID;
  end;



implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, DB, SWNConst, SWNUtils, IBC, frmWebPromoBrickLinkEditorDialog,
  frmGoods, SWNValueStorageUnit;

procedure TfrmWebPromoBrickEditorDlg.bbDeleteClick(Sender: TObject);
begin
     DeleteLink;
end;

procedure TfrmWebPromoBrickEditorDlg.bbModifyClick(Sender: TObject);
begin
     ShowModifyLinkDialog;
end;

procedure TfrmWebPromoBrickEditorDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewLinkDialog;
end;

function TfrmWebPromoBrickEditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmWebPromoBrickEditorDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     LinksSelectionChanged;
end;

procedure TfrmWebPromoBrickEditorDlg.DeleteLink;
begin
     cxGridTable.DataController.DeleteFocused;
end;

procedure TfrmWebPromoBrickEditorDlg.BindingDataSource;
begin
     imgIMAGE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmWebPromoBrickEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.FieldByName('IMAGE_WIDTH').AsInteger:=imgIMAGE.Picture.Width;
          fMasterDataSet.FieldByName('IMAGE_HEIGHT').AsInteger:=imgIMAGE.Picture.Height;
          fMasterDataSet.Post;
          if SaveLinksToDB(fMasterDataSet.FieldByName('PAIMAGEBRICKID').AsInteger) then
          begin
               fMasterDataSet.UpdateTransaction.Commit;
               Result:=True;
          end;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.LinksSelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=True;
     fEdit:=False;
     fDelete:=False;
     if Assigned(cxGridTable.Controller.FocusedRecord) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;
     bbNew.Enabled:=fNew;
     bbModify.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmWebPromoBrickEditorDlg.LoadLinksList(const ImageBrickID:integer);
var Query:TIBCQuery;
    N:integer;
begin
     Query:=TIBCQuery.Create(Self);
     cxGridTable.BeginUpdate;
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='SELECT NAV_URL FROM TWEB_PA_IB_LINKS WHERE PAIMAGEBRICKID=:ID';
        Query.ParamByName('ID').AsInteger:=ImageBrickID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             N:=cxGridTable.DataController.AppendRecord;
             cxGridTable.DataController.Values[N,0]:=Query.Fields[0].AsString;
             Query.Next;
        end;
     finally
        cxGridTable.EndUpdate;
        Query.Free;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.LoadStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form position
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             // new
             dtDialogTitle.Text:='Creare bloc publicitar nou';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('PROMOACTIONID').AsInteger:=FPromoActionID;
        end
        else
        begin
             // edit
             dtDialogTitle.Text:='Modificare date';
             fMasterDataSet.Edit;
             LoadLinksList(fMasterDataSet.FieldByName('PAIMAGEBRICKID').AsInteger);
        end;
        LinksSelectionChanged;
     except on E: Exception do
        begin
             if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;

end;

function TfrmWebPromoBrickEditorDlg.SaveLinksToDB(const ImageBrickID:integer): Boolean;
var Query:TIBCQuery;
    i:integer;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        try
           if Not FCreateNewRecord then
           begin
                // delete existing values
                Query.SQL.Text:='DELETE FROM TWEB_PA_IB_LINKS WHERE PAIMAGEBRICKID=:ID';
                Query.ParamByName('ID').AsInteger:=ImageBrickID;
                Query.ExecSQL;
           end;
           // insert new values
           Query.SQL.Text:='INSERT INTO TWEB_PA_IB_LINKS (PAIMAGEBRICKID,NAV_URL) VALUES (:ID, :URL)';
           Query.ParamByName('ID').AsInteger:=ImageBrickID;
           for i := 0 to cxGridTable.DataController.RecordCount-1 do
           begin
                Query.ParamByName('URL').AsString:=cxGridTable.DataController.Values[i,0];
                Query.ExecSQL;
           end;
           Result:=True;
        except
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.SaveStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form pos
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
          then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmWebPromoBrickEditorDlg.SetPromoActionID(const Value: integer);
begin
     FPromoActionID := Value;
end;

procedure TfrmWebPromoBrickEditorDlg.ShowCreateNewLinkDialog;
var dialog:TfrmWebPromoBrickLinkEditorDlg;
    N:integer;
begin
     dialog:=TfrmWebPromoBrickLinkEditorDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then
        begin
             cxGridTable.BeginUpdate;
             try
                N:=cxGridTable.DataController.AppendRecord;
                cxGridTable.DataController.Values[N,0]:=dialog.URL;
             finally
                cxGridTable.EndUpdate;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.ShowModifyLinkDialog;
var dialog:TfrmWebPromoBrickLinkEditorDlg;
begin
     dialog:=TfrmWebPromoBrickLinkEditorDlg.Create(Self);
     try
        dialog.URL:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRecord.RecordIndex,0];
        if dialog.ShowModal=mrOk then
        begin
             cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRecord.RecordIndex,0]:=dialog.URL;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPromoBrickEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
