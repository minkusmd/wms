unit frmSearchInDocsLogDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, StdCtrls, DBAccess,
  IBC, MemDS, cxGridBandedTableView, cxGridDBBandedTableView, cxLabel, cxMemo;

type
  TfrmSearchInDocsLogDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edDOCID: TEdit;
    edUSERID: TEdit;
    edGOODSID: TEdit;
    edSN: TEdit;
    edPARTNO: TEdit;
    btnSearch: TButton;
    cbUPDATES: TCheckBox;
    Label6: TLabel;
    cbDELETES: TCheckBox;
    cxGrid: TcxGrid;
    btnClose: TButton;
    IBCQuerySearch: TIBCQuery;
    IBCDataSourceSearch: TIBCDataSource;
    cxGridLevel: TcxGridLevel;
    cxGridTable: TcxGridDBBandedTableView;
    cxGridTable_DOCID: TcxGridDBBandedColumn;
    cxGridTable_DOCTYPE_NAME: TcxGridDBBandedColumn;
    cxGridTable_USERID: TcxGridDBBandedColumn;
    cxGridTable_USER_FULL_NAME: TcxGridDBBandedColumn;
    cxGridTable_DESCRIPTION: TcxGridDBBandedColumn;
    cxGridTable_USER_FIRMA_NAME: TcxGridDBBandedColumn;
    cxGridTable_DATETIME: TcxGridDBBandedColumn;
    lbWaitInfo: TLabel;
    Label7: TLabel;
    cmbResultCount: TComboBox;
    lbRecordCount: TLabel;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
    function CheckValues:Boolean;
    procedure OpenData;
    function GetResultCount:Integer;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmSearchInDocsLogDlg }

procedure TfrmSearchInDocsLogDlg.btnSearchClick(Sender: TObject);
begin
     if CheckValues then OpenData;
end;

function TfrmSearchInDocsLogDlg.CheckValues: Boolean;
var ErrorStr:String;
    N:integer;
begin
     ErrorStr:='';
     Result:=False;

     if edDOCID.Text<>'' then
     begin
          N:=StrToIntDef(edDOCID.Text,0);
          if (N<=0) then AddErrorToStr(ErrorStr,'Codul documentului!');
     end;
     if edUSERID.Text<>'' then
     begin
          N:=StrToIntDef(edUSERID.Text,0);
          if (N<=0) then AddErrorToStr(ErrorStr,'Codul utilizatorului!');
     end;
     if edGOODSID.Text<>'' then
     begin
          N:=StrToIntDef(edGOODSID.Text,0);
          if (N<=0) then AddErrorToStr(ErrorStr,'Codul marfii!');
     end;


     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmSearchInDocsLogDlg.GetResultCount: Integer;
begin
     case cmbResultCount.ItemIndex of
     1: Result:=200;
     2: Result:=300;
     3: Result:=500;
     else Result:=100;
     end;
end;

procedure TfrmSearchInDocsLogDlg.OpenData;
begin
     IBCQuerySearch.Close;
     // setup params
     if (edDOCID.Text<>'')
       then IBCQuerySearch.ParamByName('ADOCID').AsInteger:=StrToInt(edDOCID.Text)
       else IBCQuerySearch.ParamByName('ADOCID').Value:=Null;
     if (edUSERID.Text<>'')
       then IBCQuerySearch.ParamByName('AUSERID').AsInteger:=StrToInt(edUSERID.Text)
       else IBCQuerySearch.ParamByName('AUSERID').Value:=Null;
     if (edGOODSID.Text<>'')
       then IBCQuerySearch.ParamByName('AGOODSID').AsInteger:=StrToInt(edGOODSID.Text)
       else IBCQuerySearch.ParamByName('AGOODSID').Value:=Null;
     if (edSN.Text<>'')
       then IBCQuerySearch.ParamByName('ASN').AsString:=edSN.Text
       else IBCQuerySearch.ParamByName('ASN').Value:=Null;
     if (edPARTNO.Text<>'')
       then IBCQuerySearch.ParamByName('APARTNO').AsString:=edPARTNO.Text
       else IBCQuerySearch.ParamByName('APARTNO').Value:=Null;
     if cbUPDATES.Checked
       then IBCQuerySearch.ParamByName('AFLG_UPDATE').AsInteger:=1
       else IBCQuerySearch.ParamByName('AFLG_UPDATE').Value:=Null;
     if cbDELETES.Checked
       then IBCQuerySearch.ParamByName('AFLG_DELETE').AsInteger:=1
       else IBCQuerySearch.ParamByName('AFLG_DELETE').Value:=Null;
     IBCQuerySearch.ParamByName('RESULT_COUNT').AsInteger:=GetResultCount;
     // UI
     lbWaitInfo.Visible:=True;
     btnSearch.Enabled:=False;
     lbRecordCount.Caption:='';
     Application.ProcessMessages;

     try
        // open data
        IBCQuerySearch.Open;
     finally
        // UI
        btnSearch.Enabled:=True;
        lbWaitInfo.Visible:=False;
        lbRecordCount.Caption:=Format('Total inregistrari: %d',[cxGridTable.DataController.RecordCount]);
     end;
end;

procedure TfrmSearchInDocsLogDlg.Prepare;
begin
     lbWaitInfo.Visible:=False;
     lbRecordCount.Caption:='';
     cmbResultCount.ItemIndex:=2;
end;

end.
