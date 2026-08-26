unit frmNameTemplateEditorDialog;

{ Editor pentru un template de denumire (TS_GOODS_NAME_TEMPLATE):
  CONTEXT (1=catalog/web, 2=factura, 3=eticheta/raft) + TEMPLATE_RO / TEMPLATE_RU.
  Editeaza inregistrarea curenta a grilei de template-uri din editorul de tip produs. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls,
  cxDBEdit, ExtCtrls, DialogTitle, Data.DB, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxMemo, cxDropDownEdit,
  cxImageComboBox;

type
  TfrmNameTemplateEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    icbCONTEXT: TcxDBImageComboBox;
    mmTEMPLATE_RO: TcxDBMemo;
    mmTEMPLATE_RU: TcxDBMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    FCreateNewItem: Boolean;
    FGoodsTypeID: Integer;
    function CheckParams: Boolean;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmNameTemplateEditorDlg }

function TfrmNameTemplateEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;
  with fMasterDataSet do
  begin
    if FieldByName('CONTEXT').IsNull or (FieldByName('CONTEXT').AsInteger <= 0) then
      AddErrorToStr(ErrorStr, 'Context!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmNameTemplateEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewItem := False;
  FGoodsTypeID := 0;
  icbCONTEXT.DataBinding.DataSource := fMasterDataSource;
  mmTEMPLATE_RO.DataBinding.DataSource := fMasterDataSource;
  mmTEMPLATE_RU.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmNameTemplateEditorDlg.Prepare;
begin
  if FCreateNewItem then
  begin
    dtDialogTitle.Text := 'Template nou';
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger := FGoodsTypeID;
    fMasterDataSet.FieldByName('CONTEXT').AsInteger := 1;
  end
  else
  begin
    dtDialogTitle.Text := 'Modifica template-ul';
    fMasterDataSet.Edit;
  end;
end;

function TfrmNameTemplateEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmNameTemplateEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.
