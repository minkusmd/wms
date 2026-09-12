unit frmGoodsTypeNPSC_AP_Item_Editor_Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.StdCtrls, cxTextEdit, cxDBEdit, cxCheckBox;

type
  TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edPARAM_NAME_RUS: TcxDBTextEdit;
    edPARAM_NAME_ROM: TcxDBTextEdit;
    edPARAM_VALUE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cbFLG_VALUE_IS_COMMENT: TcxDBCheckBox;
    cbFLG_OPTIONAL: TcxDBCheckBox;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    FGoodsTypeID: Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputParams:Boolean;
    procedure SetGoodsTypeID(const Value: Integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property GoodsTypeID:Integer read FGoodsTypeID write SetGoodsTypeID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst;

{ TForm2 }

function TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('PARAM_NAME_RUS').IsNull or (fMasterDataSet.FieldByName('PARAM_NAME_RUS').AsString='')
       then AddErrorToStr(Errors,'Denumirea in rusa!');
     if fMasterDataSet.FieldByName('PARAM_NAME_ROM').IsNull or (fMasterDataSet.FieldByName('PARAM_NAME_ROM').AsString='')
       then AddErrorToStr(Errors,'Denumirea in romana!');
     if fMasterDataSet.FieldByName('PARAM_VALUE').IsNull or (fMasterDataSet.FieldByName('PARAM_VALUE').AsString='')
       then AddErrorToStr(Errors,'Valoarea(ile)!');

     if fMasterDataSet.FieldByName('FLG_VALUE_IS_COMMENT').IsNull then AddErrorToStr(Errors,'Valoare comentariu?');
     if fMasterDataSet.FieldByName('FLG_OPTIONAL').IsNull then AddErrorToStr(Errors,'Componenta este optionala?');

     if (Errors='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.BindingDataSource;
begin
     FCreateNewRecord := false;

     edPARAM_NAME_RUS.DataBinding.DataSource:=fMasterDataSource;
     edPARAM_NAME_ROM.DataBinding.DataSource:=fMasterDataSource;
     edPARAM_VALUE.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_VALUE_IS_COMMENT.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_OPTIONAL.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.Prepare;
begin
     if FCreateNewRecord then
     begin
          dtDialogTitle.Text:='Creare componenta noua';
          fMasterDataSet.Insert;
          fMasterDataSet.FieldByName('FLG_VALUE_IS_COMMENT').AsInteger:=0;
          fMasterDataSet.FieldByName('FLG_OPTIONAL').AsInteger:=0;
          fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger:=FGoodsTypeID;
     end
     else
     begin
          dtDialogTitle.Text:='Modificare inregistrare';
          fMasterDataSet.Edit;
     end;

end;

procedure TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.SetGoodsTypeID(const Value: Integer);
begin
     FGoodsTypeID := Value;
end;

procedure TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
