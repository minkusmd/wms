unit frmGoodsFilterParamEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls,
  StdCtrls, cxDBEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxTextEdit, Vcl.ComCtrls, cxMaskEdit, cxDropDownEdit, cxCalc, dxUIAClasses;

type
  TfrmGoodsFilterParamEditor = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    edPARAM_VALUE: TcxDBTextEdit;
    edPARAM_VALUE_RUS: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    StatusBar1: TStatusBar;
    procedure edPARAM_VALUE_RUSEnter(Sender: TObject);
    procedure edPARAM_VALUEExit(Sender: TObject);
    procedure edPARAM_VALUEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fCreateNewValue: Boolean;
    fDefaultTitleRom: String;
    fDefaultTitleRus: String;
    fDefaultOrderNo: integer;

    function CheckParams:Boolean;
    procedure SetCreateNewValue(const Value: Boolean);
    procedure SetDefaultTitleRom(const Value: String);
    procedure SetDefaultTitleRus(const Value: String);
    procedure SetDefaultOrderNo(const Value: integer);

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewValue:Boolean read FCreateNewValue write SetCreateNewValue;
    property DefaultTitleRom:String read FDefaultTitleRom write SetDefaultTitleRom;
    property DefaultTitleRus:String read FDefaultTitleRus write SetDefaultTitleRus;
    property DefaultOrderNo:integer read FDefaultOrderNo write SetDefaultOrderNo;
  end;


implementation

uses SWNUtils, SWNConst, DataModuleDB;

{$R *.dfm}

{ TfrmGoodsFilterParamEditor }

function TfrmGoodsFilterParamEditor.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if (fMasterDataSet.FieldByName('PARAM_VALUE').IsNull) or (Trim(fMasterDataSet.FieldByName('PARAM_VALUE').AsString)='')
      then AddErrorToStr(ErrorStr,'Valoarea!');
     if (fMasterDataSet.FieldByName('PARAM_VALUE_RUS').IsNull) or (Trim(fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString)='') then
     begin
          if (not (fMasterDataSet.FieldByName('PARAM_VALUE').IsNull)) and (Trim(fMasterDataSet.FieldByName('PARAM_VALUE').AsString)<>'') then
          begin
               // copy value
               fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString := fMasterDataSet.FieldByName('PARAM_VALUE').AsString;
          end
          else AddErrorToStr(ErrorStr,'Значение!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsFilterParamEditor.edPARAM_VALUEExit(Sender: TObject);
begin
 if fCreateNewValue then
 begin
   fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString := fMasterDataSet.FieldByName('PARAM_VALUE').AsString;
 end;
end;

procedure TfrmGoodsFilterParamEditor.edPARAM_VALUE_RUSEnter(Sender: TObject);
begin
     if (fMasterDataSet.FieldByName('PARAM_VALUE_RUS').IsNull or (fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString='')) and (not (fMasterDataSet.FieldByName('PARAM_VALUE').IsNull))
      then fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString := fMasterDataSet.FieldByName('PARAM_VALUE').AsString;
end;

procedure TfrmGoodsFilterParamEditor.BindingDataSource;
begin
     FCreateNewValue := False;

     edPARAM_VALUE.DataBinding.DataSource:=fMasterDataSource;
     edPARAM_VALUE_RUS.DataBinding.DataSource:=fMasterDataSource;
//     cePValue.DataBinding.DataSource:=fMasterDataSource;
end;

procedure TfrmGoodsFilterParamEditor.edPARAM_VALUEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ( ((key=ord('c')) or (key = ord('C'))) and (ssAlt in Shift) or (key=VK_RETURN) and (ssAlt in Shift) ) then
    fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString := edParam_value.Text;
end;

function TfrmGoodsFilterParamEditor.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckParams then
     begin
          // trim input strings
          MasterDataSet.FieldByName('PARAM_VALUE').AsString := Trim(MasterDataSet.FieldByName('PARAM_VALUE').AsString);
          MasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString := Trim(MasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString);

          fMasterDataSet.Post;

          if fMasterDataSet.UpdateTransaction.Active then
            fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end;
end;

procedure TfrmGoodsFilterParamEditor.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewValue then
        begin
             // create new record
             dtDialogTitle.Text:='Создание нового значения';

             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('ORDERNO').AsInteger:=-1;
             if (fDefaultTitleRom<>'') then fMasterDataSet.FieldByName('PARAM_VALUE').AsString:=fDefaultTitleRom;
             if (fDefaultTitleRus<>'') then fMasterDataSet.FieldByName('PARAM_VALUE_RUS').AsString:=fDefaultTitleRus;
             if (fDefaultOrderNo<>-1) then fMasterDataSet.FieldByName('ORDERNO').AsInteger:=fDefaultOrderNo;
             StatusBar1.Panels[0].Text := dmdb.CurrentUserFullName;
        end
        else
        begin
             // modify record
             dtDialogTitle.Text:='Изменение значения';
             fMasterDataSet.Edit;
             StatusBar1.Panels[0].Text := fMasterDataSet.FieldByName('CREATED_BY_NAME').AsString;
        end;
     except on E:Exception do
        begin
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmGoodsFilterParamEditor.SetCreateNewValue(const Value: Boolean);
begin
     FCreateNewValue := Value;
end;

procedure TfrmGoodsFilterParamEditor.SetDefaultOrderNo(const Value: integer);
begin
     fDefaultOrderNo := Value;
end;

procedure TfrmGoodsFilterParamEditor.SetDefaultTitleRom(const Value: String);
begin
     fDefaultTitleRom := Value;
end;

procedure TfrmGoodsFilterParamEditor.SetDefaultTitleRus(const Value: String);
begin
     fDefaultTitleRus := Value;
end;

procedure TfrmGoodsFilterParamEditor.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
