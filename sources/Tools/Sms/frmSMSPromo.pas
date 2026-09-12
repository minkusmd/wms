unit frmSMSPromo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, dxBar, cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxMemo, MemDS, DBAccess, IBC, cxButtonEdit, cxBarEditItem,
  dxBarBuiltInMenu, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGroupBox, cxPC, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmSMSPromoDialog = class(TSWNCustomForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    btnClose: TButton;
    IBCDataSource1: TIBCDataSource;
    IBCQuery1: TIBCQuery;
    cxBarEditItem1: TcxBarEditItem;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1SMSPROMOID: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED: TcxGridDBColumn;
    cxGrid1DBTableView1SMS_TEXT: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxTabSheet3: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    procedure IBCQuery1AfterInsert(DataSet: TDataSet);
    procedure cxBarEditItem1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure dxBarButton5Click(Sender: TObject);
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils;

{ TfrmSMSPromoDialog }

procedure TfrmSMSPromoDialog.cxBarEditItem1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
q : TIBCQuery;
begin
// trimite mesaj de test
   q := TIBCQuery.Create(self);
   try
     q.Transaction := dmdb.IBCTrDefaultUpdate;
     q.SQL.Text := 'INSERT INTO SMS_MESSAGES (SOURCE_TABLE, PHONE, SMS_TEXT) ' +
                   ' VALUES (4, :PHONE, :SMS_TEXT)';
     q.ParamByName('PHONE').AsString := cxBarEditItem1.EditValue;
     q.ParamByName('SMS_TEXT').AsString := IBCQuery1.FieldByName('SMS_Text').AsString;
     q.ExecSQL
   finally
     q.Free;
   end;
end;

procedure TfrmSMSPromoDialog.dxBarButton5Click(Sender: TObject);
var
q : TIBCQuery;
begin
  // trimite mesaj tuturor
   if IBCQuery1.FieldByName('State').AsInteger=1 then
   begin
     ShowErrorDialog('Mesajul a fost deja trimis');
     Exit;
   end;

   try
     q.Transaction := dmdb.IBCTrDefaultUpdate;

     q.SQL.Text := 'INSERT INTO SMS_MESSAGES (SOURCE_TABLE, PHONE, SMS_TEXT) ' +
                   ' select distinct 4, mobile, :sms_text from ts_cust_info where mobile is not null';
     q.ParamByName('SMS_TEXT').AsString := IBCQuery1.FieldByName('SMS_Text').AsString;
     q.ExecSQL;

     IBCQuery1.Edit;
     IBCQuery1.FieldByName('State').AsInteger := 1;
     IBCQuery1.Post;

   finally
     q.Free;
   end;

end;

procedure TfrmSMSPromoDialog.IBCQuery1AfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('CREATED').AsDateTime := Now;
  DataSet.FieldByName('DT').AsInteger := dmdb.CurrentFirma;
  DataSet.FieldByName('State').AsInteger := 0;
end;

procedure TfrmSMSPromoDialog.Prepare;
begin
  inherited;
  IBCQuery1.Open;
  cxDateEdit1.Date := Date;
  cxDateEdit2.Date := Date;
end;

end.
