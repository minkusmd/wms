unit frmMergeGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxImage, cxDBEdit, cxTextEdit, StdCtrls, cxMaskEdit, cxButtonEdit, cxMemo, Buttons, dxGDIPlusClasses,
  DB, DBAccess, IBC, Vcl.Menus, cxButtons, MemDS, dxUIAClasses, dxCoreGraphics;

type
  TfrmMergeGoodsDlg = class(TForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    imgSource_IMAGE: TcxDBImage;
    imgTarget_IMAGE: TcxDBImage;
    Label1: TLabel;
    Label2: TLabel;
    IBCQuerySource: TIBCQuery;
    IBCDataSourceSource: TIBCDataSource;
    IBCQueryTarget: TIBCQuery;
    IBCDataSourceTarget: TIBCDataSource;
    Label3: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    beTargetGoodsID: TcxButtonEdit;
    beSourceGoodsID: TcxButtonEdit;
    procedure sbSelectTargetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beSourceGoodsIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSourceGoodsID:integer;
    fTargetGoodsID:integer;
    procedure SelectSourceGoods;
    procedure SelectTargetGoods;

    procedure OpenSourceGoodsInfo(const GoodsID:integer);
    procedure OpenTargetGoodsInfo(const GoodsID:integer);

    function DoMergeGoods:Boolean;
    procedure SetSourceGoodsID(const Value: Integer);
  public
    procedure LookupGoodsValue(GoodsID: Integer);
    property SourceGoodsID: Integer read FSourceGoodsID write SetSourceGoodsID;
    { Public declarations }
  end;


implementation

uses frmGoods, DataModuleDB, SWNUtils, SWNDBErrors;

{$R *.dfm}

procedure TfrmMergeGoodsDlg.beSourceGoodsIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectSourceGoods;
end;

procedure TfrmMergeGoodsDlg.btnOkClick(Sender: TObject);
begin
     if (fSourceGoodsID=-1) or (fTargetGoodsID=-1) then ShowErrorDialog('Ошибка','Выберите товары!')
     else
     if DoMergeGoods then
     begin
          ShowInfoDialog('Обьединение 2-х товаров','Обьединение товаров готово.');
          ModalResult:=mrOk;
     end
end;

procedure TfrmMergeGoodsDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if AButtonIndex = 1 then
     SelectTargetGoods;
  if AButtonIndex = 0 then
    LookupGoodsValue(StrToInt(beTargetGoodsID.Text));
end;

function TfrmMergeGoodsDlg.DoMergeGoods: Boolean;
var Query:TIBCQuery;
    Transaction:TIBCTransaction;
begin
     Result:=False;

     Transaction:=TIBCTransaction.Create(Self);
     Query:=TIBCQuery.Create(Self);
     try
        Transaction.DefaultConnection:=dmDB.IBCConnection;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=Transaction;

        Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_MERGE_GOODS(:oldID,:newID)';
           Query.ParamByName('oldID').AsInteger:=fSourceGoodsID;
           Query.ParamByName('newID').AsInteger:=fTargetGoodsID;
           Query.ExecSQL;
           Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
        Transaction.Free;
     end;
end;

procedure TfrmMergeGoodsDlg.FormCreate(Sender: TObject);
begin
     fSourceGoodsID:=-1;
     fTargetGoodsID:=-1;

end;

procedure TfrmMergeGoodsDlg.LookupGoodsValue(GoodsID: Integer);
begin
    OpenTargetGoodsInfo(GoodsID);
end;

procedure TfrmMergeGoodsDlg.OpenSourceGoodsInfo(const GoodsID:integer);
begin
     IBCQuerySource.Close;
     IBCQuerySource.ParamByName('id').AsInteger:=GoodsID;
     IBCQuerySource.Open;
     beSourceGoodsID.Text := IBCQuerySource.FieldByName('TITLE').AsString;
     beSourceGoodsID.Tag := GoodsID;
     fSourceGoodsID:=GoodsID;
end;

procedure TfrmMergeGoodsDlg.OpenTargetGoodsInfo(const GoodsID:integer);
begin
     IBCQueryTarget.Close;
     IBCQueryTarget.ParamByName('id').AsInteger:=GoodsID;
     IBCQueryTarget.Open;
     fTargetGoodsID:=GoodsID;
end;

procedure TfrmMergeGoodsDlg.sbSelectTargetClick(Sender: TObject);
begin
     SelectTargetGoods;
end;

procedure TfrmMergeGoodsDlg.SelectSourceGoods;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fSourceGoodsID,false,0,'Выберите товар для копирования') then
        begin
            OpenSourceGoodsInfo(dialog.GoodsID);
//            beSourceGoodsID.Tag := dialog.goodsid;
        end
     finally
        dialog.Free;
     end;
end;

procedure TfrmMergeGoodsDlg.SelectTargetGoods;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fTargetGoodsID,false,0,'Выберите товар для куда скопировать') then
        begin
            OpenTargetGoodsInfo(dialog.GoodsID);
            beTargetGoodsID.Tag := dialog.GoodsID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmMergeGoodsDlg.SetSourceGoodsID(const Value: Integer);
begin
  OpenSourceGoodsInfo(Value);
end;

end.
