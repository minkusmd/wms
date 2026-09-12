unit frameGoodsEditDescriptionUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, cxMemo, cxDBEdit, cxTextEdit, cxMaskEdit,
    cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.Buttons, Vcl.StdCtrls,
    Data.DB, DBAccess, IBC, MemDS, SWNBaseFrameUnit, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid,
    Vcl.Menus, cxButtons, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxDBExtLookupComboBox, Vcl.ExtCtrls, dxUIAClasses;

type
    TframeGoodsEditDescription = class(TFrame)
        cxLabel2: TLabel;
        cxLabel17: TLabel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        lcbVENDOR_ID: TcxDBLookupComboBox;
        cmbWEBGOODSTYPE_ID: TcxDBLookupComboBox;
        edCODE: TcxDBTextEdit;
        edBASE_PARAM: TcxDBTextEdit;
        edDETAILS: TcxDBTextEdit;
        IBCDataSourceGOODS: TIBCDataSource;
        IBCQueryVendors: TIBCQuery;
        IBCDataSourceVendors: TIBCDataSource;
        IBCQueryWebGoodsType: TIBCQuery;
        IBCDataSourceWebGoodsType: TIBCDataSource;
        edCODE_RU: TcxDBTextEdit;
        edBASE_PARAM_RU: TcxDBTextEdit;
        IBCQueryGOODS: TIBCQuery;
        cmbColors: TcxDBLookupComboBox;
        IBCQueryColors: TIBCQuery;
        IBCDataSourceColors: TIBCDataSource;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    Panel1: TPanel;
    lbWebNameRo: TLabel;
    Label4: TLabel;
        procedure cmbWEBGOODSTYPE_IDExit(Sender: TObject);
        procedure edBASE_PARAMExit(Sender: TObject);
        procedure edCODEExit(Sender: TObject);
        procedure Label3Click(Sender: TObject);
        procedure lcbVENDOR_IDPropertiesChange(Sender: TObject);
        procedure cmbWEBGOODSTYPE_IDPropertiesChange(Sender: TObject);
        procedure cxButton1Click(Sender: TObject);
        procedure edBASE_PARAMKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure edCODEKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxButton2Click(Sender: TObject);
    private
        FTabStopRuValue: Integer;
        FtrUpdateTransaction: TIBCTransaction;
        procedure SettrUpdateTransaction(const Value: TIBCTransaction);
    { Private declarations }
    protected
        function GetTabStopValue: Integer;
        procedure SetTabStopValue;
    public    { Public declarations }
        constructor Create(AOwner: TComponent); override;
        procedure GetDefaultValueFromGoodsType(GoodsTypeID: Integer; var base_param_ro,
            base_param_ru: string);
        procedure UpdatelbWebName;
        property trUpdateTransaction: TIBCTransaction read FtrUpdateTransaction write SettrUpdateTransaction;
    end;

implementation

uses
    frmGoodsTypeDialog, frmSyssEditorWindow, SWNUtils, SWNValueStorageUnit, DataModuleDB,
    System.UITypes, SWNGoodsUtils;

{$R *.dfm}

procedure TframeGoodsEditDescription.cmbWEBGOODSTYPE_IDPropertiesChange(Sender: TObject);
begin
    UpdatelbWebName;
end;

constructor TframeGoodsEditDescription.Create(AOwner: TComponent);
begin
    inherited;
    IBCQueryVendors.Open;
    IBCQueryVendors.UpdateTransaction := trUpdateTransaction;

    IBCQueryWebGoodsType.Open;
    IBCQueryWebGoodsType.UpdateTransaction := trUpdateTransaction;

    IBCQueryColors.Open;
  // if GetTabStopValue = 1 then
  // begin
  // edCODE_RU.TabStop := False;
  // edBASE_PARAM_RU.TabStop := False;
  // end
  // UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.cmbWEBGOODSTYPE_IDExit(Sender: TObject);
begin
    UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.cxButton1Click(Sender: TObject);
var
    editor: TfrmGoodsTypeDlg;
begin
    editor := TfrmGoodsTypeDlg.Create(self);
    try
        if not IBCDataSourceGOODS.DataSet.FieldByName('WEBGOODSTYPE_ID').IsNull then
            editor.DefaultGoodsTypeID := IBCDataSourceGOODS.DataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger;

        editor.ShowModal;
        IBCQueryWebGoodsType.Refresh;
    finally
        editor.Free;
    end;
    UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.cxButton2Click(Sender: TObject);
var
    syssEditor: TfrmSelectSyssEditorWin;
begin
    syssEditor := TfrmSelectSyssEditorWin.Create(self);
    try

        if not IBCDataSourceGOODS.DataSet.FieldByName('VENDOR_ID').IsNull then
            syssEditor.SYSSID := IBCDataSourceGOODS.DataSet.FieldByName('VENDOR_ID').AsInteger;

        syssEditor.SetDefaultGroup(1); // Producatori
        syssEditor.ShowModal;
        IBCQueryVendors.Refresh;
    finally
        syssEditor.Free;
    end;
end;

procedure TframeGoodsEditDescription.edBASE_PARAMExit(Sender: TObject);
begin
    if IBCDataSourceGOODS.DataSet.State in [dsInsert, dsEdit] then
        if (IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString = '') then
            IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsVariant := edBASE_PARAM.EditingValue;

    UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.edBASE_PARAMKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_RIGHT) and (ssCtrl in Shift) and (IBCDataSourceGOODS.DataSet.State in dsEditModes) then
    begin
        edBASE_PARAM.PostEditValue;
        IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString := IBCDataSourceGOODS.DataSet.FieldByName
            ('BASE_PARAM').AsString.Trim;
    end;
end;

procedure TframeGoodsEditDescription.edCODEExit(Sender: TObject);
begin
//    if IBCDataSourceGOODS.DataSet.State in [dsInsert, dsEdit] then
//        if (IBCDataSourceGOODS.DataSet.FieldByName('CODE_RU').AsString = '') then
//        begin
//            IBCDataSourceGOODS.DataSet.FieldByName('CODE_RU').AsVariant := edCODE.EditingValue;
//        end;
//
    UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.edCODEKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_RIGHT) and (ssCtrl in Shift) and (IBCDataSourceGOODS.DataSet.State in dsEditModes) then
    begin
        edCODE.EditingText := Trim(edCODE.EditingText);
        edCODE.PostEditValue;
        IBCDataSourceGOODS.DataSet.FieldByName('CODE_RU').AsString := IBCDataSourceGOODS.DataSet.FieldByName
            ('CODE').AsString.Trim;
    end;
end;

procedure TframeGoodsEditDescription.GetDefaultValueFromGoodsType(GoodsTypeID: Integer; var
    base_param_ro, base_param_ru: string);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(self);
    try
        q.sql.Text :=
            'select base_param_ro, base_param_ru from ts_goods_type where goodstypeid = :goodstypeid';
        q.ParamByName('GOODSTYPEID').AsInteger := GoodsTypeID;
        try
            q.Open;
        except
            on e: Exception do
                raise;
        end;
        if (q.RecordCount > 1) then
        begin
            base_param_ro := q.FieldByName('base_param_ro').AsString;
            base_param_ru := q.FieldByName('base_param_ru').AsString;
        end;
    finally
        q.Free;
    end;
end;

function TframeGoodsEditDescription.GetTabStopValue: Integer;
begin
    FTabStopRuValue := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_TabStopValue', 1);
    Result := FTabStopRuValue;
end;

procedure TframeGoodsEditDescription.Label3Click(Sender: TObject);
var
    base_param_ro, base_param_ru: string;
begin
    if Assigned(IBCDataSourceGOODS.DataSet) then
    begin
        base_param_ro := IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString;
        base_param_ru := IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString;
        if ((base_param_ro <> '') or (base_param_ru <> '')) then
        begin
            if (MessageDlg('Cimpurile cu parametri contin date, aducem valorile implicite ?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            begin
                GetDefaultValueFromGoodsType(IBCDataSourceGOODS.DataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger,
                    base_param_ro, base_param_ru);
                IBCDataSourceGOODS.DataSet.Edit;
                IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString := base_param_ro;
                IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM_RU').AsString := base_param_ru;
            end;
        end;
    end
    else
        raise Exception.Create('Nu este conectat query!');
end;

procedure TframeGoodsEditDescription.lcbVENDOR_IDPropertiesChange(Sender: TObject);
begin
    UpdatelbWebName;
end;

procedure TframeGoodsEditDescription.SetTabStopValue;
begin
    AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_TabStopValue', FTabStopRuValue);
end;

procedure TframeGoodsEditDescription.SettrUpdateTransaction(const Value: TIBCTransaction);
begin
    FtrUpdateTransaction := Value;
end;

procedure TframeGoodsEditDescription.UpdatelbWebName;
begin
    if Assigned(IBCDataSourceGOODS.DataSet) then
    begin
        lbWebNameRo.Caption := GenerateGoodsTitle(IBCQueryWebGoodsType.FieldByName('TITLE').AsString,
            IBCQueryVendors.FieldByName('TITLE').AsString, IBCDataSourceGOODS.DataSet.FieldByName('CODE').AsString,
            IBCDataSourceGOODS.DataSet.FieldByName('BASE_PARAM').AsString, IBCDataSourceGOODS.DataSet.FieldByName
            ('DETAILS').AsString);
    end;
end;

end.

