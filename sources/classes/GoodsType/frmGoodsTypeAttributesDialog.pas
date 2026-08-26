unit frmGoodsTypeAttributesDialog;

{ Manager pentru atributele, valorile si template-urile de denumire ale unui
  tip de produs (TS_GOODS_TYPE). Se lanseaza din editorul de tip produs pentru
  un GOODSTYPEID existent.

  Trei grile:
    - Atribute  (TS_ATTRIBUTE, filtrat pe GOODS_TYPE_ID)
    - Valori    (TS_ATTRIBUTE_VALUE, master-detail dupa atributul selectat)
    - Template-uri denumire (TS_GOODS_NAME_TEMPLATE, filtrat pe GOODS_TYPE_ID)

  Tranzactie proprie (IBCTransactionUpdate): OK -> Commit, Renunta -> Rollback. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
  cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData,
  cxTextEdit, cxMemo;

type
  TfrmGoodsTypeAttributesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTransactionUpdate: TIBCTransaction;
    IBCQueryAttributes: TIBCQuery;
    IBCDataSourceAttributes: TIBCDataSource;
    IBCQueryValues: TIBCQuery;
    IBCDataSourceValues: TIBCDataSource;
    IBCQueryTemplates: TIBCQuery;
    IBCDataSourceTemplates: TIBCDataSource;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    pnLeft: TPanel;
    pnRight: TPanel;
    pnTmpl: TPanel;
    lbAttr: TLabel;
    lbVal: TLabel;
    lbTmpl: TLabel;
    cxGridAttr: TcxGrid;
    cxGridAttrTable: TcxGridDBTableView;
    cxGridAttrLevel: TcxGridLevel;
    cxGridAttr_NAME_RO: TcxGridDBColumn;
    cxGridAttr_NAME_RU: TcxGridDBColumn;
    cxGridAttr_FLG_FILTERABLE: TcxGridDBColumn;
    cxGridAttr_FLG_VARIATION: TcxGridDBColumn;
    cxGridAttr_FLG_IN_NAME: TcxGridDBColumn;
    cxGridAttr_FLG_RECOMMENDED: TcxGridDBColumn;
    cxGridAttr_FLG_MULTI: TcxGridDBColumn;
    cxGridAttr_FLG_FREE_VALUE: TcxGridDBColumn;
    cxGridAttr_UOM_RO: TcxGridDBColumn;
    cxGridVal: TcxGrid;
    cxGridValTable: TcxGridDBTableView;
    cxGridValLevel: TcxGridLevel;
    cxGridVal_VALUE_RO: TcxGridDBColumn;
    cxGridVal_VALUE_RU: TcxGridDBColumn;
    cxGridTmpl: TcxGrid;
    cxGridTmplTable: TcxGridDBTableView;
    cxGridTmplLevel: TcxGridLevel;
    cxGridTmpl_CONTEXT: TcxGridDBColumn;
    cxGridTmpl_TEMPLATE_RO: TcxGridDBColumn;
    cxGridTmpl_TEMPLATE_RU: TcxGridDBColumn;
    pnAttrButtons: TPanel;
    btnAttrNew: TcxButton;
    btnAttrEdit: TcxButton;
    btnAttrDelete: TcxButton;
    pnValButtons: TPanel;
    btnValNew: TcxButton;
    btnValEdit: TcxButton;
    btnValDelete: TcxButton;
    pnTmplButtons: TPanel;
    btnTmplNew: TcxButton;
    btnTmplEdit: TcxButton;
    btnTmplDelete: TcxButton;
    Splitter1: TSplitter;
    cxMemo1: TcxMemo;
    procedure btnAttrNewClick(Sender: TObject);
    procedure btnAttrEditClick(Sender: TObject);
    procedure btnAttrDeleteClick(Sender: TObject);
    procedure btnValNewClick(Sender: TObject);
    procedure btnValEditClick(Sender: TObject);
    procedure btnValDeleteClick(Sender: TObject);
    procedure btnTmplNewClick(Sender: TObject);
    procedure btnTmplEditClick(Sender: TObject);
    procedure btnTmplDeleteClick(Sender: TObject);
  private
    FGoodsTypeID: Integer;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
  end;

implementation

uses
  SWNUtils, DataModuleDB, System.UITypes,
  frmAttributeEditorDialog, frmAttributeValueEditorDialog, frmNameTemplateEditorDialog;

{$R *.dfm}

{ TfrmGoodsTypeAttributesDlg }

procedure TfrmGoodsTypeAttributesDlg.Prepare;
begin
  try
    IBCTransactionUpdate.StartTransaction;

    IBCQueryAttributes.ParamByName('gtid').AsInteger := FGoodsTypeID;
    IBCQueryTemplates.ParamByName('gtid').AsInteger := FGoodsTypeID;

    IBCQueryAttributes.Open;
    IBCQueryValues.Open; { detail: filtrat automat pe ATTRID prin master-detail }
    IBCQueryTemplates.Open;

    DialogTitle1.Text := 'Atribute si template-uri pentru tipul #' + IntToStr(FGoodsTypeID);
  except
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
    raise;
  end;
end;

function TfrmGoodsTypeAttributesDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if IBCQueryValues.State in dsEditModes then
    IBCQueryValues.Post;
  if IBCQueryAttributes.State in dsEditModes then
    IBCQueryAttributes.Post;
  if IBCQueryTemplates.State in dsEditModes then
    IBCQueryTemplates.Post;

  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Commit;
  Result := True;
end;

procedure TfrmGoodsTypeAttributesDlg.WhenCancelForm;
begin
  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Rollback;
end;

{ ---------- Atribute ---------- }

procedure TfrmGoodsTypeAttributesDlg.btnAttrNewClick(Sender: TObject);
var
  d: TfrmAttributeEditorDlg;
begin
  d := TfrmAttributeEditorDlg.Create(Self, IBCQueryAttributes, IBCDataSourceAttributes);
  try
    d.GoodsTypeID := FGoodsTypeID;
    d.CreateNewItem := True;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnAttrEditClick(Sender: TObject);
var
  d: TfrmAttributeEditorDlg;
begin
  if IBCQueryAttributes.IsEmpty then
    Exit;
  d := TfrmAttributeEditorDlg.Create(Self, IBCQueryAttributes, IBCDataSourceAttributes);
  try
    d.CreateNewItem := False;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnAttrDeleteClick(Sender: TObject);
begin
  if IBCQueryAttributes.IsEmpty then
    Exit;
  if MessageDlg(Format('Stergeti atributul [%s] cu toate valorile lui?',
    [IBCQueryAttributes.FieldByName('NAME_RO').AsString]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryAttributes.Delete;
end;

{ ---------- Valori ---------- }

procedure TfrmGoodsTypeAttributesDlg.btnValNewClick(Sender: TObject);
var
  d: TfrmAttributeValueEditorDlg;
begin
  if IBCQueryAttributes.IsEmpty then
  begin
    ShowMessage('Selectati mai intai un atribut.');
    Exit;
  end;
  { atributele cu valoare libera nu au dictionar - valorile se introduc manual
    pe fiecare produs, in tab-ul "Atribute" al editorului de produs }
  if IBCQueryAttributes.FieldByName('FLG_FREE_VALUE').AsInteger = 1 then
  begin
    ShowMessage('Atributul are valori libere - valorile se introduc direct pe produs, ' +
      'nu in dictionar.');
    Exit;
  end;
  d := TfrmAttributeValueEditorDlg.Create(Self, IBCQueryValues, IBCDataSourceValues);
  try
    d.AttrID := IBCQueryAttributes.FieldByName('ATTRID').AsInteger;
    d.CreateNewItem := True;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnValEditClick(Sender: TObject);
var
  d: TfrmAttributeValueEditorDlg;
begin
  if IBCQueryValues.IsEmpty then
    Exit;
  d := TfrmAttributeValueEditorDlg.Create(Self, IBCQueryValues, IBCDataSourceValues);
  try
    d.CreateNewItem := False;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnValDeleteClick(Sender: TObject);
begin
  if IBCQueryValues.IsEmpty then
    Exit;
  if MessageDlg(Format('Stergeti valoarea [%s]?', [IBCQueryValues.FieldByName('VALUE_RO').AsString]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryValues.Delete;
end;

{ ---------- Template-uri denumire ---------- }

procedure TfrmGoodsTypeAttributesDlg.btnTmplNewClick(Sender: TObject);
var
  d: TfrmNameTemplateEditorDlg;
begin
  d := TfrmNameTemplateEditorDlg.Create(Self, IBCQueryTemplates, IBCDataSourceTemplates);
  try
    d.GoodsTypeID := FGoodsTypeID;
    d.CreateNewItem := True;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnTmplEditClick(Sender: TObject);
var
  d: TfrmNameTemplateEditorDlg;
begin
  if IBCQueryTemplates.IsEmpty then
    Exit;
  d := TfrmNameTemplateEditorDlg.Create(Self, IBCQueryTemplates, IBCDataSourceTemplates);
  try
    d.CreateNewItem := False;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeAttributesDlg.btnTmplDeleteClick(Sender: TObject);
begin
  if IBCQueryTemplates.IsEmpty then
    Exit;
  if MessageDlg('Stergeti acest template de denumire?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryTemplates.Delete;
end;

end.
