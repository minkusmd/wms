unit frmMergeGoodsTypesUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
    cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit,
    cxMaskEdit, cxDropDownEdit, cxCalc, Vcl.Buttons, Vcl.Mask, cxButtonEdit,
    Data.DB, MemDS, DBAccess, IBC, dxUIAClasses, dxCoreGraphics;

type
    TfrmMergeGoodsTypesDlg = class(TSWNBaseFormClass)
        Label1: TLabel;
        Label2: TLabel;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
        edOldGoodsType: TcxButtonEdit;
        edNewGoodsType: TcxButtonEdit;
        IBCQuery1: TIBCQuery;
        IBCTrUpdate: TIBCTransaction;
        procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure cxButtonEdit2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    private
        FGoodsTypeID: Integer;
        procedure SetGoodsTypeID(const Value: Integer);
    { Private declarations }
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;

    public
        function CheckParams: Boolean;
        procedure DoMergeGoodsType(OldGoodsTypeID, NewGoodsTypeID: Integer);
        procedure SelectGoodsTypeDialog(MaskEdit: TcxButtonEdit);
        property GoodsTypeID: Integer read FGoodsTypeID write SetGoodsTypeID;
    { Public declarations }
    end;

var
    frmMergeGoodsTypesDlg: TfrmMergeGoodsTypesDlg;

implementation

{$R *.dfm}

uses
    DataModuleDB, frmGoodsTypeDialog, System.UITypes;

function TfrmMergeGoodsTypesDlg.CheckParams: Boolean;
var
    StrError: string;
begin
    Result := False;
    StrError := '';
    if (StrToIntDef(edOldGoodsType.Text, -1) = -1) or (edOldGoodsType.Text = '') then
        StrError := 'Codul pentru tipul vechi nu este corect!';

    if (StrToIntDef(edNewGoodsType.Text, -1) = -1) or (ednewGoodsType.Text = '') then
        StrError := 'Codul pentru tipul nou nu este corect!';

    if StrError <> '' then
        MessageDlg(StrError, mtError, [mbOK], 0);

    if StrError = '' then
        Result := True;
end;

{ TfrmMergeGoodsTypesDlg }

procedure TfrmMergeGoodsTypesDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
    SelectGoodsTypeDialog(edOldGoodsType);
end;

procedure TfrmMergeGoodsTypesDlg.cxButtonEdit2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
    SelectGoodsTypeDialog(edNewGoodsType);
end;

procedure TfrmMergeGoodsTypesDlg.DoMergeGoodsType(OldGoodsTypeID, NewGoodsTypeID: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_MERGE_GOODSTYPE(:OLDGOODSTYPE, :NEWGOODSTYPE);';
        Query.ParamByName('OLDGOODSTYPE').AsInteger := OldGoodsTypeID;
        Query.ParamByName('NEWGOODSTYPE').AsInteger := NewGoodsTypeID;
        Query.Transaction := IBCTrUpdate;

        if not Query.Transaction.Active then
            Query.Transaction.StartTransaction;

        try
            Query.Execute;
            Query.Transaction.Commit;
        except
            Query.Transaction.Rollback;
            raise;
        end;
    finally
        Query.Free;
    end;
end;

function TfrmMergeGoodsTypesDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    if CheckParams then
    begin
        DoMergeGoodsType(StrToInt(edOldGoodsType.Text), StrToInt(edNewGoodsType.Text));
        Result := True;
    end;
end;

procedure TfrmMergeGoodsTypesDlg.Prepare;
begin
    edOldGoodsType.Text := GoodsTypeID.ToString;
end;

procedure TfrmMergeGoodsTypesDlg.SetGoodsTypeID(const Value: Integer);
begin
    FGoodsTypeID := Value;
end;

procedure TfrmMergeGoodsTypesDlg.WhenCancelForm;
begin

end;

procedure TfrmMergeGoodsTypesDlg.SelectGoodsTypeDialog(MaskEdit: TcxButtonEdit);
var
    dialog: TfrmGoodsTypeDlg;
begin
    dialog := TfrmGoodsTypeDlg.Create(Self);
    try
        dialog.GoodsTypeID := FGoodsTypeID;
        if dialog.ShowModal = mrOK then
            MaskEdit.Text := dialog.GoodsTypeID.ToString;
    finally
        dialog.Free;
    end;
end;

end.

