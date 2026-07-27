unit frmBonusGoods2EditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, Vcl.ExtCtrls, SWNBaseUnit, Vcl.StdCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxTextEdit;

type
  TfrmBonusGoods2EditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    edREQ_QTY: TcxDBMaskEdit;
    edBONUS_POINTS: TcxDBMaskEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    edORDERNO: TcxDBMaskEdit;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;

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

{$R *.dfm}

uses DataModuleAdditions, SWNUpdateClientDBClass, SWNUtils, SWNConst;

{ TfrmBonusGoods2EditorDlg }

function TfrmBonusGoods2EditorDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString='')
       then AddErrorToStr(ErrorStr,'Название!');
     if fMasterDataSet.FieldByName('START_DATE').IsNull or fMasterDataSet.FieldByName('END_DATE').IsNull
       then AddErrorToStr(ErrorStr,'Период!');
     if fMasterDataSet.FieldByName('REQ_QTY').IsNull or (fMasterDataSet.FieldByName('REQ_QTY').AsInteger<=0)
       then AddErrorToStr(ErrorStr,'Минимальное количества!');
     if fMasterDataSet.FieldByName('BONUS_POINTS').IsNull or (fMasterDataSet.FieldByName('BONUS_POINTS').AsInteger<=0)
       then AddErrorToStr(ErrorStr,'Бонусные очки!');
     if NOT fMasterDataSet.FieldByName('ORDERNO').IsNull and (fMasterDataSet.FieldByName('ORDERNO').AsInteger<=0)
       then AddErrorToStr(ErrorStr,'Приоритет группы!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmBonusGoods2EditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     deSTART_DATE.DataBinding.DataSource:=fMasterDataSource;
     deEND_DATE.DataBinding.DataSource:=fMasterDataSource;
     edREQ_QTY.DataBinding.DataSource:=fMasterDataSource;
     edBONUS_POINTS.DataBinding.DataSource:=fMasterDataSource;
     edORDERNO.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmBonusGoods2EditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmBonusGoods2EditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание новой записи';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('START_DATE').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('BONUS_POINTS').AsInteger:=0;
             fMasterDataSet.FieldByName('REQ_QTY').AsInteger:=1;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
        end;
     except on E:Exception do
        begin
             fMasterDataSet.Cancel;
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmBonusGoods2EditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmBonusGoods2EditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
