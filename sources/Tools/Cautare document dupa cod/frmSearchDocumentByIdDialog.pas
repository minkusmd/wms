unit frmSearchDocumentByIdDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, DB,
  DBAccess, IBC, MemDS, cxInplaceContainer, cxVGrid, cxDBVGrid, StdCtrls, ExtCtrls, cxCheckBox, cxLabel,
  cxButtonEdit, cxPCdxBarPopupMenu, cxPC, cxCurrencyEdit, dxBarBuiltInMenu, dxUIAClasses, cxFilter,
  dxScrollbarAnnotations;

type

  TfrmSearchDocumentByIdDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    btnSearch: TButton;
    edDocID: TEdit;
    btnGotoDoc: TButton;
    btnCancel: TButton;
    IBCQueryDOCS: TIBCQuery;
    IBCDataSourceDOCS: TIBCDataSource;
    btnSearchParent: TButton;
    tabControlDocs: TcxTabControl;
    cxDBVerticalGrid: TcxDBVerticalGrid;
    rowDOCTYPE_NAME: TcxDBEditorRow;
    rowDOCID: TcxDBEditorRow;
    rowPARENTDOCID: TcxDBEditorRow;
    rowDATA: TcxDBEditorRow;
    rowDT_NAME: TcxDBEditorRow;
    rowCT_NAME: TcxDBEditorRow;
    rowCURRENCY_NAME: TcxDBEditorRow;
    rowSUMA: TcxDBEditorRow;
    rowRATE: TcxDBEditorRow;
    rowRATEUSD: TcxDBEditorRow;
    rowCREATED_BY_NAME: TcxDBEditorRow;
    cxDBVerticalGridFlags: TcxDBVerticalGrid;
    cxDBVerticalGridFlagsDBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow6: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow8: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow9: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow10: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow11: TcxDBEditorRow;
    cxDBVerticalGridFlagsDBEditorRow12: TcxDBEditorRow;
    procedure edDocIDChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSearchParentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tabControlDocsChange(Sender: TObject);
    procedure edDocIDEnter(Sender: TObject);
    procedure tabControlDocsTcxTabControlPropertiesTcxPCCustomButtonsButtons0Click(Sender: TObject);
  private
    { Private declarations }
    fDocID:integer;
    procedure SearchDocID(const DocID:integer; const ChildDocID:Integer);
    procedure DisableControls;
  protected
    { protected declarations }
    procedure Prepare;override;

    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    property DocID:integer read fDocID;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNValueStorageUnit;

{$R *.dfm}

type
    TIntegerValue = class
      Value:integer;
      constructor Create(const AValue:Integer);
    end;


{ TfrmSearchDocumentByIdDlg }

procedure TfrmSearchDocumentByIdDlg.btnSearchClick(Sender: TObject);
begin
     SearchDocID(StrToInt(edDocID.Text),-1);
end;

procedure TfrmSearchDocumentByIdDlg.btnSearchParentClick(Sender: TObject);
begin
     SearchDocID(IBCQueryDOCS.FieldByName('PARENTDOCID').AsInteger,IBCQueryDOCS.FieldByName('DOCID').AsInteger);
end;

procedure TfrmSearchDocumentByIdDlg.DisableControls;
begin
     cxDBVerticalGrid.Enabled:=False;
     cxDBVerticalGridFlags.Enabled:=False;
     btnSearchParent.Visible:=False;
     btnGotoDoc.Enabled:=False;
     btnSearch.Default:=True;
end;

procedure TfrmSearchDocumentByIdDlg.edDocIDChange(Sender: TObject);
var N:integer;
begin
     N:=StrToIntDef(edDocID.Text,0);
     btnSearch.Enabled:=N>0;
end;

procedure TfrmSearchDocumentByIdDlg.edDocIDEnter(Sender: TObject);
begin
     btnGotoDoc.Default:=False;
     btnSearch.Default:=True;
end;

procedure TfrmSearchDocumentByIdDlg.FormCreate(Sender: TObject);
begin
     fDocID:=-1;
     tabControlDocs.Properties.Tabs.Clear;
end;

procedure TfrmSearchDocumentByIdDlg.LoadStates;
var i,intVal,count:integer;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        count:=AppUserConfigStorage.IntValues.GetValue('VALUES');
        if count>0 then
        begin
             tabControlDocs.Tabs.BeginUpdate;
             try
                for i := 0 to Count-1 do
                begin
                     intVal:=AppUserConfigStorage.IntValues.GetValue('VALUE_'+IntToStr(i));
                     if (intVal>0) then tabControlDocs.Tabs.AddObject(IntToStr(intVal),TIntegerValue.Create(intVal));
                end;
                tabControlDocs.TabIndex:=AppUserConfigStorage.IntValues.GetValue('LAST_TAB');
             finally
                tabControlDocs.Tabs.EndUpdate();
             end;
             tabControlDocsChange(tabControlDocs);
        end;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmSearchDocumentByIdDlg.Prepare;
begin
     btnSearch.Enabled:=False;
     if tabControlDocs.TabIndex=-1 then
     begin
          btnGotoDoc.Enabled:=False;
          cxDBVerticalGrid.Enabled:=False;
          cxDBVerticalGridFlags.Enabled:=False;
          btnSearchParent.Visible:=False;
     end
     else
     begin
          tabControlDocs.Visible:=true;
     end;
end;

procedure TfrmSearchDocumentByIdDlg.SaveStates;
var i:integer;
    intVal:TIntegerValue;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        AppUserConfigStorage.IntValues.SetValue('LAST_TAB',tabControlDocs.TabIndex);
        AppUserConfigStorage.IntValues.SetValue('VALUES',tabControlDocs.Tabs.Count);
        for i := 0 to tabControlDocs.Tabs.Count-1 do
        begin
             intVal:=TIntegerValue(tabControlDocs.Tabs.Objects[i]);
             AppUserConfigStorage.IntValues.SetValue('VALUE_'+IntToStr(i),intVal.Value);
        end;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmSearchDocumentByIdDlg.SearchDocID(const DocID: integer; const ChildDocID:Integer);
var Query:TIBCQuery;
    S:String;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT DOCID FROM TDB_DOCS WHERE DOCID=:ID';
        Query.ParamByName('ID').AsInteger:=DocID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             if ChildDocID=-1
               then S:=IntToStr(DocID)
               else S:=Format('%d (Parinte %d)',[DocID,ChildDocID]);
             tabControlDocs.TabIndex:=tabControlDocs.Properties.Tabs.AddObject(S,TIntegerValue.Create(DocID));
             tabControlDocs.Visible:=True;
             tabControlDocsChange(tabControlDocs);
        end
        else ShowErrorDialog(cMSG_GeneralError_Title,Format('Documentul nr.%d nu exista!',[DocID]));
     finally
        Query.Free;
     end;
end;

procedure TfrmSearchDocumentByIdDlg.tabControlDocsChange(Sender: TObject);
var intVal:TIntegerValue;
begin
     if (tabControlDocs.TabIndex=-1) then
     begin
          DisableControls;
          tabControlDocs.Visible:=False;
          Exit;
     end;

     intVal:=TIntegerValue(tabControlDocs.Tabs.Objects[tabControlDocs.TabIndex]);

     // kind se schimba tabul
     IBCQueryDOCS.Active:=False;
     IBCQueryDOCS.ParamByName('DOCID').AsInteger:=intVal.Value;
     IBCQueryDOCS.Active:=True;

     cxDBVerticalGrid.Enabled:=True;
     cxDBVerticalGridFlags.Enabled:=True;
     btnSearchParent.Visible:=Not IBCQueryDOCS.FieldByName('PARENTDOCID').IsNull;
     fDocID:=IBCQueryDOCS.FieldByName('DOCID').asInteger;
     btnSearch.Default:=False;
     btnGotoDoc.Enabled:=True;
     btnGotoDoc.Default:=True;
     if Self.Visible then btnGotoDoc.SetFocus;
end;

procedure TfrmSearchDocumentByIdDlg.tabControlDocsTcxTabControlPropertiesTcxPCCustomButtonsButtons0Click(Sender: TObject);
begin
     tabControlDocs.Properties.Tabs.BeginUpdate;
     try
        tabControlDocs.Properties.Tabs.Clear;
     finally
        tabControlDocs.Properties.Tabs.EndUpdate;
     end;

end;

{ TIntegerValue }

constructor TIntegerValue.Create(const AValue: Integer);
begin
     Value:=AValue;
end;

end.
