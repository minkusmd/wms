unit ReportSyssSelectorUnit;

interface

Uses Classes, frxClass, frxDsgnIntf, cxButtonEdit, cxTextEdit, fs_iinterpreter, frxClassRTTI, cxEdit,
     Controls, ExtCtrls, Buttons, SWNValueStorageUnit,
     cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
     cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridLevel, cxGrid,
     ReportSelectorPanelUnit;

type

  TfrxSyssSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector:TfrxSelectorPanel;
    fBtnAdd:TSpeedButton;
    fBtnDelete:TSpeedButton;
    fBtnClear:TSpeedButton;
    cxGridSelection: TcxGrid;
    xGridSelectionLevel: TcxGridLevel;
    cxGridTableView: TcxGridTableView;
    cxGridCol_ID: TcxGridColumn;
    cxGridCol_TITLE: TcxGridColumn;
    fSecureFirms: Boolean;
    function GetListOfID: string;
  protected
    { protected declarations }
    fLastSelectedID: integer;

    procedure InitSelectorControl(AOwner: TComponent);

    procedure cxGridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure SelectionChanged;

    procedure sbAddClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);

    procedure AddListOfGoods;

  public
    { public declarations }
    constructor Create(AOwner: TComponent);override;
    class function GetDescription:String;override;

    property Selector:TfrxSelectorPanel read FSelector;

    procedure WhenSaveToRepository(const Storage:TAppUserInternalDataStorage);
    procedure WhenReadFromRepository(const Storage:TAppUserInternalDataStorage);

  published
    { published declarations }
    property ListOfID:string read GetListOfID;
    procedure SetListOfID(const Values:String);

  end;


implementation

uses SysUtils, SWNUtils, DataModuleAdditions, frmSyssEditorWindow;


{ TfrxSyssSelector }

procedure TfrxSyssSelector.AddListOfGoods;
begin
end;

constructor TfrxSyssSelector.Create(AOwner: TComponent);
begin
     inherited;
     InitSelectorControl(AOwner);
     fLastSelectedID:=-1;
     fSecureFirms:=false;

     InitControl(fSelector);

     Width:=400;
     Height:=200;
end;

procedure TfrxSyssSelector.cxGridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrxSyssSelector.cxGridTableViewSelectionChanged(Sender: TcxCustomGridTableView);
begin
     SelectionChanged;
end;

class function TfrxSyssSelector.GetDescription: String;
begin
     Result:='Выбор элементов из справочника SYSS';
end;

function TfrxSyssSelector.GetListOfID: string;
var s:string;
    i:integer;
begin
     s:='';
     for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
     begin
          if (s<>'') then s:=s+',';
          s:=s+IntToStr(cxGridTableView.DataController.Values[i,0]);
     end;
     Result:=s;
end;

procedure TfrxSyssSelector.InitSelectorControl(AOwner: TComponent);
var panel:TPanel;
begin
     // holder
     fSelector:=TfrxSelectorPanel.Create(AOwner, Self);
     fSelector.ShowCaption:=False;
     fSelector.BevelOuter:=bvNone;
     fSelector.Constraints.MinWidth:=340;
     fSelector.Constraints.MinHeight:=140;
     fSelector.NeedSaveData:=True;
     fSelector.OnSaveToRepository:=WhenSaveToRepository;
     fSelector.OnReadFromRepository:=WhenReadFromRepository;

     // buttons panel
     panel:=TPanel.Create(fSelector);
     panel.ShowCaption:=False;
     panel.Align:=alBottom;
     panel.Height:=31;
     panel.Padding.Top:=4;
     panel.BevelOuter:=bvNone;
     panel.Parent:=fSelector;

     // button: Add
     fBtnAdd:=TSpeedButton.Create(panel);
     fBtnAdd.Align:=alLeft;
     fBtnAdd.Caption:='Добавить...';
     fBtnAdd.Width:=90;
     fBtnAdd.OnClick:=nil;
     fBtnAdd.Parent:=panel;
     fBtnAdd.OnClick:=sbAddClick;

     // button: Delete
     fBtnDelete:=TSpeedButton.Create(panel);
     fBtnDelete.Align:=alLeft;
     fBtnDelete.Caption:='Удалить...';
     fBtnDelete.AlignWithMargins:=True;
     fBtnDelete.Margins.Left:=8;
     fBtnDelete.Margins.Top:=0;
     fBtnDelete.Margins.Bottom:=0;
     fBtnDelete.Margins.Right:=0;
     fBtnDelete.Left:=100;
     fBtnDelete.Width:=90;
     fBtnDelete.OnClick:=nil;
     fBtnDelete.Parent:=panel;
     fBtnDelete.Enabled:=false;
     fBtnDelete.OnClick:=sbDeleteClick;

     // button: Clear
     fBtnClear:=TSpeedButton.Create(panel);
     fBtnClear.Align:=alRight;
     fBtnClear.Caption:='Очистить...';
     fBtnClear.Width:=90;
     fBtnClear.OnClick:=nil;
     fBtnClear.Parent:=panel;
     fBtnClear.OnClick:=sbClearClick;

     // Grid
     cxGridSelection:=TcxGrid.Create(fSelector);
     cxGridSelection.Align:=alClient;
     cxGridSelection.Parent:=fSelector;

     xGridSelectionLevel:=cxGridSelection.Levels.Add;

     cxGridTableView:=TcxGridTableView.Create(xGridSelectionLevel);
     xGridSelectionLevel.GridView:=cxGridTableView;

     // setup GridView props
     cxGridTableView.OptionsView.ColumnAutoWidth:=true;
     cxGridTableView.OptionsView.GridLineColor:=$00D1D1D1;
     cxGridTableView.OptionsView.GroupByBox:=false;
     cxGridTableView.OptionsView.NoDataToDisplayInfoText:='<Нет записей>';

     cxGridTableView.OptionsSelection.CellSelect:=false;
     cxGridTableView.OptionsSelection.MultiSelect:=true;

     cxGridTableView.OptionsData.Deleting:=false;
     cxGridTableView.OptionsData.Editing:=false;
     cxGridTableView.OptionsData.Inserting:=false;

     cxGridTableView.OptionsCustomize.ColumnFiltering:=false;
     cxGridTableView.OptionsCustomize.ColumnGrouping:=false;
     cxGridTableView.OptionsCustomize.ColumnSorting:=false;

     cxGridTableView.Styles.Header:=dmAdditions.cxStyle_GridHeader;

     cxGridTableView.OnFocusedRecordChanged:=cxGridTableViewFocusedRecordChanged;
     cxGridTableView.OnSelectionChanged:=cxGridTableViewSelectionChanged;

     // add columns

     cxGridCol_ID:=cxGridTableView.CreateColumn;
     cxGridCol_ID.Caption:='Код';
     cxGridCol_ID.DataBinding.ValueType:='Integer';
     cxGridCol_ID.Width:=50;
     cxGridCol_ID.Options.HorzSizing:=false;
     cxGridCol_ID.HeaderAlignmentHorz:=taCenter;

     cxGridCol_TITLE:=cxGridTableView.CreateColumn;
     cxGridCol_TITLE.Caption:='Название';
     cxGridCol_TITLE.Width:=100;
end;

procedure TfrxSyssSelector.sbAddClick(Sender: TObject);
var syssEditor:TfrmSelectSyssEditorWin;
    N:integer;
begin
     syssEditor:=TfrmSelectSyssEditorWin.Create(Self);
     try
        syssEditor.SelectMode:=True;
        syssEditor.CanSelectFolder:=True;

        if syssEditor.ShowModal=mrOk then
        begin
             cxGridTableView.BeginUpdate;
             try
                N:=cxGridTableView.DataController.AppendRecord;
                cxGridTableView.DataController.Values[N,0]:=syssEditor.SYSSID;
                cxGridTableView.DataController.Values[N,1]:=syssEditor.SyssTitle;
             finally
               cxGridTableView.EndUpdate;
               SelectionChanged;
             end;
        end;
     finally
        syssEditor.Free;
     end;
end;

procedure TfrxSyssSelector.sbClearClick(Sender: TObject);
begin
     if ShowAskDialog('Удаление всех записей','Удалить все записи?')=mrYes then
     begin
          cxGridTableView.BeginUpdate;
          try
             cxGridTableView.Controller.SelectAll;
             cxGridTableView.DataController.DeleteSelection;
          finally
             cxGridTableView.EndUpdate;
             SelectionChanged;
          end;
     end;
end;

procedure TfrxSyssSelector.sbDeleteClick(Sender: TObject);
var s1,s2:string;
begin
     if (cxGridTableView.Controller.SelectedRecordCount>0) then
     begin
          if (cxGridTableView.Controller.SelectedRecordCount>1) then
          begin
               s1:='Удаление записей';
               s2:='Удалить выбранные записи?';
          end
          else
          begin
               s1:='Удаление записи';
               s2:=Format('Удалить запись "%s"?',[cxGridTableView.Controller.SelectedRecords[0].Values[1]]);
          end;
          if ShowAskDialog(s1, s2)=mrYes then
          begin
               cxGridTableView.BeginUpdate;
               try
                  cxGridTableView.DataController.DeleteSelection;
               finally
                  cxGridTableView.EndUpdate;
                  SelectionChanged;
               end;
          end;
     end;
end;

procedure TfrxSyssSelector.SelectionChanged;
var fAdd,fDelete,fClear:Boolean;
begin
     fAdd:=true;
     fDelete:=false;
     fClear:=false;
     if (cxGridTableView.DataController.RecordCount>0) then
     begin
          fClear:=true;
          if (cxGridTableView.Controller.SelectedRecordCount>0) then
          begin
               fDelete:=true;
          end;
     end;

     fBtnAdd.Enabled:=fAdd;
     fBtnDelete.Enabled:=fDelete;
     fBtnClear.Enabled:=fClear;
end;

procedure TfrxSyssSelector.SetListOfID(const Values: String);
begin

end;

procedure TfrxSyssSelector.WhenReadFromRepository(const Storage: TAppUserInternalDataStorage);
var i,N,count,valInt:integer;
begin
     cxGridTableView.BeginUpdate;
     try
        cxGridTableView.Controller.SelectAll;
        cxGridTableView.DataController.DeleteSelection;

        count:=Storage.IntValues.GetValue('count');
        for i := 0 to count - 1 do
        begin
             N:=cxGridTableView.DataController.AppendRecord;
             valInt:=Storage.IntValues.GetValue(Format('Row%d_ID',[i]));
             cxGridTableView.DataController.Values[N,0]:=valInt;
             cxGridTableView.DataController.Values[N,1]:=Storage.TextValues.GetValue(Format('Row%d_TITLE',[i]));
             fLastSelectedID:=valInt;
        end;
     finally
        cxGridTableView.EndUpdate;
     end;
end;

procedure TfrxSyssSelector.WhenSaveToRepository(const Storage: TAppUserInternalDataStorage);
var i,valInt:integer;
    valStr:String;
begin
     // save control content to repository

     Storage.IntValues.SetValue('count',cxGridTableView.DataController.RecordCount);

     for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
     begin
          valInt:=cxGridTableView.DataController.Values[i,0]; // ID
          valStr:=cxGridTableView.DataController.Values[i,1]; // Title

          Storage.IntValues.SetValue(Format('Row%d_ID',[i]),valInt);
          Storage.TextValues.SetValue(Format('Row%d_TITLE',[i]),valStr);
     end;
end;

end.
