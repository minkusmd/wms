unit frmGoodsDescFilterButtonEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, DB, DBAccess, IBC, MemDS, Buttons;

type
  TfrmGoodsDescFilterButtonEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    cmbFILTER_BUTTON_ID: TcxDBLookupComboBox;
    IBCQueryButtons: TIBCQuery;
    IBCDataSourceButtons: TIBCDataSource;
    sbAdminButtons: TSpeedButton;
    procedure sbAdminButtonsClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewButton: Boolean;
    fGoodsID: integer;
    fDescriptionID: integer;
    procedure SetCreateNewButton(const Value: Boolean);
    function CheckInputParams:Boolean;
    procedure SetDescriptionID(const Value: integer);
    procedure SetGoodsID(const Value: integer);
    procedure ShowAdminButtonsDialog;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewButton:Boolean read fCreateNewButton write SetCreateNewButton;
    property GoodsID:integer read FGoodsID write SetGoodsID;
    property DescriptionID:integer read FDescriptionID write SetDescriptionID;
  end;


implementation

uses DataModuleDB, SWNUtils, SWNConst, frmWebFilterButtonsDialog;

{$R *.dfm}

{ TfrmDescriptionLinkButtonEditorDlg }

function TfrmGoodsDescFilterButtonEditorDlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('FILTER_BUTTON_ID').IsNull then AddErrorToStr(Errors,'Buton!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.BindingDataSource;
begin
     cmbFILTER_BUTTON_ID.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsDescFilterButtonEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.Prepare;
begin
     if fCreateNewButton then
     begin
          dtDialogTitle.Text:='Adauga un buton nou';
          fMasterDataSet.Insert;
          fMasterDataSet.FieldByName('GOODSID').AsInteger:=fGoodsID;
          fMasterDataSet.FieldByName('DESCRIPTIONID').AsInteger:=fDescriptionID;
     end
     else
     begin
          dtDialogTitle.Text:='Modifica butonul';
          fMasterDataSet.Edit;
     end;
     IBCQueryButtons.Active:=True;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.sbAdminButtonsClick(Sender: TObject);
begin
     ShowAdminButtonsDialog;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.SetCreateNewButton(const Value: Boolean);
begin
     fCreateNewButton := Value;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.SetDescriptionID(const Value: integer);
begin
     fDescriptionID := Value;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.SetGoodsID(const Value: integer);
begin
     fGoodsID := Value;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.ShowAdminButtonsDialog;
var dialog:TfrmWebFilterButtonsDlg;
begin
     dialog:=TfrmWebFilterButtonsDlg.Create(Self, fMasterDataSet.Connection);
     try
        dialog.SelectMode:=True;
        dialog.CurrentFilterButtonID := fMasterDataSet.FieldByName('FILTER_BUTTON_ID').AsInteger;
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryButtons.Refresh;
             fMasterDataSet.FieldByName('FILTER_BUTTON_ID').AsInteger:=dialog.FilterButtonID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsDescFilterButtonEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
