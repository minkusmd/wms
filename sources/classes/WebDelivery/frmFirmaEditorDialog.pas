unit frmFirmaEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls,
  cxButtonEdit, cxDBEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxMemo, cxTextEdit, cxMaskEdit, dxUIAClasses, dxCoreGraphics;

type
  TfrmFirmaEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beFIRMA: TcxButtonEdit;
    Label2: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    Label3: TLabel;
    Label4: TLabel;
    mmDESCRIPTION_ROM: TcxDBMemo;
    mmDESCRIPTION_RUS: TcxDBMemo;
    Label5: TLabel;
    edTITLE_ROM: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beFIRMAPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewFirma: Boolean;
    procedure SetCreateNewFirma(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SelectFirma;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewFirma: Boolean read fCreateNewFirma write SetCreateNewFirma;
  end;

implementation

uses SWNUtils, SWNConst, frmCustomersDlg;

{$R *.dfm}
{ TfrmFirmaEditorDlg }

procedure TfrmFirmaEditorDlg.beFIRMAPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectFirma;
end;

function TfrmFirmaEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  ErrorStr := '';
  Result := False;

  if fMasterDataSet.FieldByName('CUSTOMERID').IsNull then
    AddErrorToStr(ErrorStr, 'Фирма перевозчик!');
  if fMasterDataSet.FieldByName('TITLE_ROM').IsNull then
    AddErrorToStr(ErrorStr, 'Denumirea Web a firmei!');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull then
    AddErrorToStr(ErrorStr, 'Web название фирмы!');
  if fMasterDataSet.FieldByName('DESCRIPTION_ROM').IsNull then
    AddErrorToStr(ErrorStr, 'Descriere!');
  if fMasterDataSet.FieldByName('DESCRIPTION_RUS').IsNull then
    AddErrorToStr(ErrorStr, 'Описание!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmFirmaEditorDlg.BindingDataSource;
begin
  inherited;
  fCreateNewFirma := False;

  edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION_ROM.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION_RUS.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmFirmaEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmFirmaEditorDlg.Prepare;
begin
  inherited;

  try
    fMasterDataSet.UpdateTransaction.StartTransaction;

    if fCreateNewFirma then
    begin
      dtDialogTitle.Text := 'Регистрация новой фирмы';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FIRMAID').AsInteger := FirmaID;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение данных';
      beFIRMA.Text := fMasterDataSet.FieldByName('DISPLAYNAME').AsString;

      fMasterDataSet.Edit;
    end;
  except
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmFirmaEditorDlg.SelectFirma;
var
  dialog: TfrmCustomersDlg;
  id: Integer;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    id := -1;
    if Not fMasterDataSet.FieldByName('CUSTOMERID').IsNull then
      id := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    if dialog.SelectCustomer(id, False, 0, 'Выбор контрагента для Web-перевозок') then
    begin
      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := dialog.CustomerID;
      beFIRMA.Text := dialog.CustomerTitle;
      fMasterDataSet.FieldByName('TITLE_ROM').AsString := dialog.CustomerTitle;
      fMasterDataSet.FieldByName('TITLE_RUS').AsString := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFirmaEditorDlg.SetCreateNewFirma(const Value: Boolean);
begin
  fCreateNewFirma := Value;
end;

procedure TfrmFirmaEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
