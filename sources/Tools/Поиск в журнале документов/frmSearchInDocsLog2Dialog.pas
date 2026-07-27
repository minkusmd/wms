unit frmSearchInDocsLog2Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtonEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, cxCheckBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, cxCalendar, Vcl.ComCtrls, dxCore, cxDateUtils, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmSearchInDocsLog2Dlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnFilters: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edDOCID: TEdit;
    lcbDT: TcxLookupComboBox;
    beCT: TcxButtonEdit;
    edSNPARTS: TEdit;
    lcbUSERS: TcxLookupComboBox;
    btnSearch: TButton;
    cbMOD_UPDATE: TcxCheckBox;
    cbMOD_DELETE: TcxCheckBox;
    cbMOD_FLG_CLOSED: TcxCheckBox;
    cbMOD_FLG_SHIP: TcxCheckBox;
    Label3: TLabel;
    cmbResultCount: TComboBox;
    cxGridView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    beGOODS: TcxButtonEdit;
    lcbDocType: TcxLookupComboBox;
    Label8: TLabel;
    lbRecordCount: TLabel;
    IBCQueryLog: TIBCQuery;
    IBCDataSourceLog: TIBCDataSource;
    cxGridView_DATETIME: TcxGridDBColumn;
    cxGridView_DOCID: TcxGridDBColumn;
    cxGridView_DOCTYPE_TITLE: TcxGridDBColumn;
    cxGridView_DESCRIPTION: TcxGridDBColumn;
    cxGridView_CREATED_BY_NAME: TcxGridDBColumn;
    Label9: TLabel;
    deStartDate: TcxDateEdit;
    deEndDate: TcxDateEdit;
    cxGridView_DT_NAME: TcxGridDBColumn;
    cxGridView_CT_NAME: TcxGridDBColumn;
    IBCQueryFIRMS: TIBCQuery;
    IBCDataSourceFIRMS: TIBCDataSource;
    IBCQueryDOCTYPE: TIBCQuery;
    IBCDataSourceDOCTYPE: TIBCDataSource;
    cbMOD_JURNAL: TcxCheckBox;
    cbMOD_SN: TcxCheckBox;
    cbMOD_PARTS: TcxCheckBox;
    IBCQueryUSERS: TIBCQuery;
    IBCDataSourceUSERS: TIBCDataSource;
    lbWaitInfo: TLabel;
    cxGridView_MOD_FLG_CLOSED: TcxGridDBColumn;
    cxGridView_MOD_DELETE: TcxGridDBColumn;
    cxGridView_MOD_SN: TcxGridDBColumn;
    cxGridView_MOD_PARTS: TcxGridDBColumn;
    procedure btnSearchClick(Sender: TObject);
    procedure cxGridView_DESCRIPTIONGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
    procedure cxGridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridViewStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    opDocID,opDate,opSN,opDT,opDocType,opUser:Boolean;
    valDocID,valCT,valDT,valDocType,valGoodsID,valUserID:integer;
    valDateStart,valDateEnd:TDateTime;
    valSN:String;

    function CheckInputs:Boolean;
    procedure DoSearch;
    procedure PrepareConditions;
    procedure PrepareColumnsView;

    procedure SelectCT;
    procedure SelectGoods;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNSearchUnit, StrUtils, DateUtils,
  frmCustomersDlg, frmGoods;

procedure TfrmSearchInDocsLog2Dlg.beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     if AButtonIndex=0 then SelectCT
     else
     if AButtonIndex=1 then
     begin
          valCT:=-1;
          beCT.Text:='';
     end;
end;

procedure TfrmSearchInDocsLog2Dlg.beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     if AButtonIndex=0 then SelectGoods
     else
     begin
          valGoodsID:=-1;
          beGOODS.Text:='';
     end
end;

procedure TfrmSearchInDocsLog2Dlg.btnSearchClick(Sender: TObject);
begin
     DoSearch;
end;

function TfrmSearchInDocsLog2Dlg.CheckInputs: Boolean;
var ErrorStr:String;
    N:integer;
begin
     Result:=False;
     ErrorStr:='';

     // DocID
     opDocID:=False;
     if (edDOCID.Text<>'') then
     begin
          N:=StrToIntDef(edDOCID.Text,0);
          if N>0 then
          begin
               opDocID:=True;
               valDocID:=N;
          end
          else AddErrorToStr(ErrorStr,'Код документа!');
     end;

     // Date
     opDate:=False;
     if Not VarIsNull(deStartDate.EditValue) and Not VarIsNull(deEndDate.EditValue) then
     begin
          opDate:=True;
          valDateStart:=DateOf(deStartDate.EditValue);
          valDateEnd:=DateOf(deEndDate.EditValue);
     end;

     // SN
     opSN:=False;
     if (edSNPARTS.Text<>'') then
     begin
          opSN:=True;
          valSN:=Trim(edSNPARTS.Text);
     end;

     // Firma
     opDT:=False;
     if Not VarIsNull(lcbDT.EditValue) and (lcbDT.EditValue>0) then
     begin
          opDT:=True;
          valDT:=lcbDT.EditValue;
     end;

     // DocType
     opDocType:=False;
     if Not VarIsNull(lcbDocType.EditValue) and (lcbDocType.EditValue>0) then
     begin
          opDocType:=True;
          valDocType:=lcbDocType.EditValue;
     end;

     // UserID
     opUser:=False;
     if Not VarIsNull(lcbUSERS.EditValue) and (lcbUSERS.EditValue>0) then
     begin
          opUser:=True;
          valUserID:=lcbUSERS.EditValue;
     end;




     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmSearchInDocsLog2Dlg.cxGridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
//     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
//     begin
//          ACanvas.Brush.Color:=$E8E8E8;
//     end;
end;

procedure TfrmSearchInDocsLog2Dlg.cxGridViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     CopyGridCellTextToClipboard(cxGridView);
end;

procedure TfrmSearchInDocsLog2Dlg.cxGridViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Not VarIsNull(ARecord.Values[cxGridView_MOD_DELETE.Index]) and
     Not VarIsNull(ARecord.Values[cxGridView_MOD_FLG_CLOSED.Index]) and
     Not VarIsNull(ARecord.Values[cxGridView_MOD_SN.Index]) and
     Not VarIsNull(ARecord.Values[cxGridView_MOD_PARTS.Index])
  then
  begin
       if ARecord.Values[cxGridView_MOD_DELETE.Index]=1 then AStyle:=dmAdditions.cxStyle_TextColorRed
       else
       if ARecord.Values[cxGridView_MOD_FLG_CLOSED.Index]=1 then AStyle:=dmAdditions.cxStyle_TextTeal
       else
       if (ARecord.Values[cxGridView_MOD_SN.Index]=1) or (ARecord.Values[cxGridView_MOD_PARTS.Index]=1) then AStyle:=dmAdditions.cxStyle_TextColorDarkYellow;
  end;
end;

procedure TfrmSearchInDocsLog2Dlg.cxGridView_DESCRIPTIONGetDataText(Sender: TcxCustomGridTableItem;
  ARecordIndex: Integer; var AText: string);
//var S:String;
begin
//     S:=StringReplace(Trim(cxGridView.DataController.Values[ARecordIndex,cxGridView_DESCRIPTION.Index]),'00000000000','',[rfReplaceAll]);
//     S:=StringReplace(S,'0000000000','',[rfReplaceAll]);
//     AText:=S;
end;

procedure TfrmSearchInDocsLog2Dlg.DoSearch;
begin
     if CheckInputs then
     begin
          lbWaitInfo.Visible:=True;
          Application.ProcessMessages;
          IBCQueryLog.Close;
          try
             PrepareConditions;
             IBCQueryLog.ParamByName('DOC_COUNT').AsInteger:=StrToInt(cmbResultCount.Text);
             IBCQueryLog.Active:=True;
             PrepareColumnsView;
          finally
             lbWaitInfo.Visible:=False;
             lbRecordCount.Caption:=Format('Найдено: %d',[IBCQueryLog.RecordCount]);
          end;

     end;
end;

procedure TfrmSearchInDocsLog2Dlg.Prepare;
begin
     valCT:=-1;
     beCT.Text:='';
     valGoodsID:=-1;
     beGOODS.Text:='';
     cmbResultCount.ItemIndex:=2;

     lbWaitInfo.Visible:=False;

     IBCQueryFIRMS.Active:=True;
     IBCQueryDOCTYPE.Active:=True;
     IBCQueryUSERS.Active:=True;
end;

procedure TfrmSearchInDocsLog2Dlg.PrepareColumnsView;
begin
     cxGridView_DOCID.Visible:=Not opDocID;
end;

procedure TfrmSearchInDocsLog2Dlg.PrepareConditions;
var where,where2:String;
begin
     where:='';

     // DocID
     if opDocID then AddConditionToWHERE(where,Format('DOCID=%d',[valDocID]));
     // Date
     if opDate then
     begin
          AddConditionToWHERE(where,'CAST(DATETIME AS DATE)>=:DATA1');
          AddConditionToWHERE(where,'CAST(DATETIME AS DATE)<=:DATA2');
     end;
     // SN
     if opSN then AddConditionToWHERE(where,Format('DESCRIPTION CONTAINING ''SN=%s'' OR DESCRIPTION CONTAINING ''PARTNO=%s''',[valSN,valSN]));
     // CT
     if valCT<>-1 then AddConditionToWHERE(where,Format('CT=%d',[valCT]));
     // DT
     if opDT then AddConditionToWHERE(where,Format('DT=%d',[valDT]));
     // DocType
     if opDocType then AddConditionToWHERE(where,Format('DOCTYPEID=%d',[valDocType]));
     // GoodsID
     if valGoodsID>0 then AddConditionToWHERE(where,Format('DESCRIPTION CONTAINING ''GOODSID=%d''',[valGoodsID]));
     // UserID
     if opUser then AddConditionToWHERE(where,Format('CREATED_BY=%d',[valUserID]));


     // modifiers
     where2:='';
     if cbMOD_UPDATE.Checked then AddConditionToWHERE(where2,'MOD_UPDATE=1','OR');
     if cbMOD_DELETE.Checked then AddConditionToWHERE(where2,'MOD_DELETE=1','OR');
     if cbMOD_FLG_CLOSED.Checked then AddConditionToWHERE(where2,'MOD_FLG_CLOSED=1','OR');
     if cbMOD_FLG_SHIP.Checked then AddConditionToWHERE(where2,'MOD_FLG_SHIP=1','OR');
     if cbMOD_JURNAL.Checked then AddConditionToWHERE(where2,'MOD_JURNAL=1','OR');
     if cbMOD_SN.Checked then AddConditionToWHERE(where2,'MOD_SN=1','OR');
     if cbMOD_PARTS.Checked then AddConditionToWHERE(where2,'MOD_PARTS=1','OR');

     if (where2<>'') then AddConditionToWHERE(where,where2);

     // apply WHERE
     IBCQueryLog.FilterSQL:=where;

     // setup params
     if opDate then
     begin
          IBCQueryLog.ParamByName('DATA1').AsDate:=valDateStart;
          IBCQueryLog.ParamByName('DATA2').AsDate:=valDateEnd;
     end;
end;

procedure TfrmSearchInDocsLog2Dlg.SelectCT;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(valCT,false,0,'Выбор контрагента для поиска в журнале документов') then
        begin
             valCT:=dialog.CustomerID;
             beCT.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSearchInDocsLog2Dlg.SelectGoods;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(valGoodsID,false,0,'Выберите товар для поиска в журнале документов') then
        begin
             valGoodsID:=dialog.GoodsID;
             beGOODS.Text:=dialog.GoodsTitle;
        end;
     finally
        dialog.Free;
     end;
end;

end.
