unit frmGroupGoodsAnalizeUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   SWNBaseUnit, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
   cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
   dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus,
   Vcl.StdCtrls, cxButtons, dxBar, cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, MemDS, DBAccess, IBC, DialogTitle, dxScrollbarAnnotations;

type
   TfrmGroupGoodsAnalizeDlg = class(TSWNBaseFormClass)
      Panel1: TPanel;
      dxBarDockControl1: TdxBarDockControl;
      cxGrid1DBTableView1: TcxGridDBTableView;
      cxGrid1Level1: TcxGridLevel;
      cxGrid1: TcxGrid;
      Panel2: TPanel;
      dxBarDockControl2: TdxBarDockControl;
      cxGrid2: TcxGrid;
      cxGridDBTableView1: TcxGridDBTableView;
      cxGridLevel1: TcxGridLevel;
      dxBarManager1: TdxBarManager;
      dxBarManager1Bar1: TdxBar;
      bbgaNew: TdxBarButton;
      bbgaEdit: TdxBarButton;
      bbaDelete: TdxBarButton;
      bbggNew: TdxBarButton;
      bbggDelete: TdxBarButton;
      dxBarManager1Bar2: TdxBar;
      btnOK: TcxButton;
      IBCQueryAG: TIBCQuery;
      IBCDataSourceAG: TIBCDataSource;
      IBCQueryGG: TIBCQuery;
      cxGrid1DBTableView1GGID: TcxGridDBColumn;
      cxGrid1DBTableView1TITLE: TcxGridDBColumn;
      IBCDataSourceGG: TIBCDataSource;
      IBCTrLocalUpdate: TIBCTransaction;
      cxGridDBTableView1FOLDERGOODSID: TcxGridDBColumn;
      cxGridDBTableView1FOLDERNAME: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    DialogTitle1: TDialogTitle;
      procedure bbgaNewClick(Sender: TObject);
      procedure bbgaEditClick(Sender: TObject);
      procedure bbggNewClick(Sender: TObject);
      procedure bbggDeleteClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
   private
    { Private declarations }
      procedure AddGoodsFolderDB(const GoodsParentID: Integer; FolderName: string);
   protected
      procedure Prepare; override;
      procedure BindingDataSource; override;
      function IsFormDataPosted: Boolean; override;
      procedure WhenCancelForm; override;
   public
    { Public declarations }
   end;

var
   frmGroupGoodsAnalizeDlg: TfrmGroupGoodsAnalizeDlg;

implementation

uses
   frmEditGGAnalizeUnit, DataModuleAdditions, frmGoods, SWNDBErrors, SWNUtils, SWNConst, frmAnalizaVinzariUnit, DataModuleDB;

{$R *.dfm}

procedure TfrmGroupGoodsAnalizeDlg.bbgaEditClick(Sender: TObject);
var
   dialog: TfrmEditGGAnalizeDlg;
begin
   dialog := TfrmEditGGAnalizeDlg.Create(Self, IBCQueryAG, IBCDataSourceAG);
   try
      dialog.IsNewRecord := False;
      IBCQueryAG.Edit;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.bbgaNewClick(Sender: TObject);
var
   dialog: TfrmEditGGAnalizeDlg;
begin
   dialog := TfrmEditGGAnalizeDlg.Create(Self, IBCQueryAG, IBCDataSourceAG);
   try
      dialog.IsNewRecord := True;
      IBCQueryAG.Append;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.AddGoodsFolderDB(const GoodsParentID: Integer; FolderName: string);
begin
   if not IBCQueryGG.UpdateTransaction.Active then
      IBCQueryGG.UpdateTransaction.StartTransaction;

   try
      IBCQueryGG.Append;
      IBCQueryGG.FieldByName('FOLDERGOODSID').AsInteger := GoodsParentID;
      IBCQueryGG.FieldByName('FOLDERNAME').AsString := FolderName;
      IBCQueryGG.Post;
      IBCQueryGG.UpdateTransaction.Commit;
   except
      on E: Exception do
      begin
         IBCQueryGG.Cancel;
         IBCQueryGG.UpdateTransaction.Rollback;
         if not ProcessSWNError(E) then
            raise;
      end;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.bbggDeleteClick(Sender: TObject);
begin
   if ShowAskDialog('Grupe de produse', 'Doriti sa stergeti inregistrarea data?') = mrYes then
   begin
      try
         IBCQueryGG.Delete;
         if IBCTrLocalUpdate.Active then
            IBCTrLocalUpdate.Commit
      except
         IBCTrLocalUpdate.Rollback;
      end;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.bbggNewClick(Sender: TObject);
var
   dialog: TfrmGoodsBrowser;
begin
   dialog := TfrmGoodsBrowser.Create(Self);
   try
      if dialog.SelectGoods(IBCQueryGG.FieldByName('FolderGoodsID').AsInteger, True, 0, Format('Alegeti grupa de produse "%s"',
         [IBCQueryAG.FieldByName('TITLE').AsString])) then
      begin
         if dialog.GoodsIsFolder then
         begin
            AddGoodsFolderDB(dialog.GoodsID, dialog.GoodsTitle);
         end
         else
         begin
            ShowErrorDialog(cMSG_GeneralError_Title, 'Se accepta doar mape din nomenclatorul de produse!');
         end;
      end;
   finally
      dialog.Free;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.dxBarButton1Click(Sender: TObject);
var
   dialog: TfrmAnalizaVinzariDlg;
begin
   dialog := TfrmAnalizaVinzariDlg.Create(Self, dmdb.IBCConnection);
   try
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TfrmGroupGoodsAnalizeDlg.BindingDataSource;
begin
   IBCQueryAG.Connection := IBCConnection;
   IBCQueryGG.Connection := IBCConnection;
   IBCTrLocalUpdate.DefaultConnection := IBCConnection;
end;

function TfrmGroupGoodsAnalizeDlg.IsFormDataPosted: Boolean;
begin
   Result := True;
end;

procedure TfrmGroupGoodsAnalizeDlg.Prepare;
begin
   IBCQueryAG.Open;
   IBCQueryGG.Open;
end;

procedure TfrmGroupGoodsAnalizeDlg.WhenCancelForm;
begin

end;

end.

