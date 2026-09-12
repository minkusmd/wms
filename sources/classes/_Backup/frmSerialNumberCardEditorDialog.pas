unit frmSerialNumberCardEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxGraphics, StdCtrls, cxDropDownEdit, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, ExtCtrls, DialogTitle, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmSerialNumberCardEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    edSERVICEDISCOUNT: TcxDBMaskEdit;
    edSN: TcxDBMaskEdit;
    cbPRICECOLUMN: TcxDBComboBox;
  private
    { Private declarations }
    fCreateNewSerial: Boolean;
    FComplect_SN: String;
    procedure SetCreateNewSerial(const Value: Boolean);
    function CheckParams:Boolean;
    procedure SetComplect_SN(const Value: String);
    procedure CreateColumnList;
  protected
    { Protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewSerial:Boolean read fCreateNewSerial write SetCreateNewSerial;
    property Complect_SN:String write SetComplect_SN;
  end;


implementation

uses SWNUtils, SWNConst, DataModuleAdditions, SWNSecurityFlags;

{$R *.dfm}

{ TfrmSerialNumberEditorDlg }

function TfrmSerialNumberCardEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('SN').IsNull
        or (fMasterDataSet.FieldByName('SN').AsString='')
        or (Not ValidateTextForSerial(fMasterDataSet.FieldByName('SN').AsString)) then AddErrorToStr(ErrorStr,'Numarul serial!');
     if fMasterDataSet.FieldByName('PRICECOLUMN').IsNull or (fMasterDataSet.FieldByName('PRICECOLUMN').AsInteger<0) or (fMasterDataSet.FieldByName('PRICECOLUMN').AsInteger>5) then AddErrorToStr(ErrorStr,'Coloana preturi!');
     if fMasterDataSet.FieldByName('SERVICEDISCOUNT').IsNull or (fMasterDataSet.FieldByName('SERVICEDISCOUNT').AsInteger<0) then AddErrorToStr(ErrorStr,'Discount service!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmSerialNumberCardEditorDlg.CreateColumnList;
begin
     cbPRICECOLUMN.Properties.Items.Clear;
     if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then cbPRICECOLUMN.Properties.Items.Add('1');
     if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then cbPRICECOLUMN.Properties.Items.Add('2');
     if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then cbPRICECOLUMN.Properties.Items.Add('3');
     if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then cbPRICECOLUMN.Properties.Items.Add('4');
end;

procedure TfrmSerialNumberCardEditorDlg.InitValues;
begin
     inherited;

     fCreateNewSerial := False;
     FComplect_SN := ''; // = NULL

     edSN.DataBinding.DataSource:=fMasterDataSource;
     edSERVICEDISCOUNT.DataBinding.DataSource:=fMasterDataSource;
     cbPRICECOLUMN.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmSerialNumberCardEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmSerialNumberCardEditorDlg.Prepare;
begin
     CreateColumnList;

     try
       if fCreateNewSerial then
        begin
             dtDialogTitle.Text:='Numar de card nou';

             fMasterDataSet.Append;
             fMasterDataSet.FieldByName('PRICECOLUMN').asInteger:=3;
             fMasterDataSet.FieldByName('SERVICEDISCOUNT').asInteger:=5;
             fMasterDataSet.FieldByName('CREATED_BY').asInteger:=UserID;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare date';

             fMasterDataSet.Edit;
             fMasterDataSet.FieldByName('CREATED_BY').asInteger:=UserID;
        end;
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmSerialNumberCardEditorDlg.SetComplect_SN(const Value: String);
begin
     FComplect_SN := Value;
end;

procedure TfrmSerialNumberCardEditorDlg.SetCreateNewSerial(const Value: Boolean);
begin
     fCreateNewSerial := Value;
end;

procedure TfrmSerialNumberCardEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
