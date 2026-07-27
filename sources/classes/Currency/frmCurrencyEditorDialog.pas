unit frmCurrencyEditorDialog;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls, cxDBEdit, ExtCtrls, DialogTitle,
    cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxMaskEdit,
    cxDropDownEdit, cxCalc, Vcl.Buttons, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
    TfrmCurrencyEditorDlg = class(TSWNMasteredFormClass)
        dtDialogTitle: TDialogTitle;
        Panel1: TPanel;
        Label4: TLabel;
        edTRANSFER_RATE: TcxDBCalcEdit;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        NetHTTPClient1: TNetHTTPClient;
        procedure SpeedButton1Click(Sender: TObject);
    private
        OldTransferRate: Double;
    { Private declarations }
        function CheckParams: Boolean;
    protected    { protected declarations }
        procedure BindingDataSource; override;
        procedure GetMAIBUsdRate;
        procedure Prepare; override;

        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public    { Public declarations }
    end;

implementation

uses
    MSHTML, DB, SWNUtils, SWNConst, Vcl.Dialogs;

{$R *.dfm}

{ TfrmCurrencyEditorDlg }

function TfrmCurrencyEditorDlg.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    Result := False;
    ErrorStr := '';

    if fMasterDataSet.FieldByName('BNM_RATE').IsNull or (fMasterDataSet.FieldByName('BNM_RATE').AsFloat <= 0) then
        AddErrorToStr(ErrorStr, 'Rata BNM!');
    if fMasterDataSet.FieldByName('EXCHANGE_RATE').IsNull or (fMasterDataSet.FieldByName('EXCHANGE_RATE').AsFloat <= 0) then
        AddErrorToStr(ErrorStr, 'Rata numerar!');
    if fMasterDataSet.FieldByName('TRANSFER_RATE').IsNull or (fMasterDataSet.FieldByName('TRANSFER_RATE').AsFloat <= 0) then
        AddErrorToStr(ErrorStr, 'Rata transfer!');
    if fMasterDataSet.FieldByName('DEGHEST_RATE').IsNull or (fMasterDataSet.FieldByName('DEGHEST_RATE').AsFloat <= 0) then
        AddErrorToStr(ErrorStr, 'Rata Deghest!');

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCurrencyEditorDlg.BindingDataSource;
begin
    edTRANSFER_RATE.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmCurrencyEditorDlg.GetMAIBUsdRate;
//var
//    HtmlCode: TStringList;
//    doc: OleVariant;
//    el: OleVariant;
//    i: Integer;
begin
//    HtmlCode := TStringlist.Create;
//    doc := coHTMLDocument.Create as IHTMLDocument2;
//    try
//        HtmlCode.LoadFromStream(NetHTTPClient1.Get('https://maib.md/ro').ContentStream);
//        doc.write(HtmlCode.Text);
//        doc.close;
//        for i := 0 to doc.body.all.length - 1 do
//        begin
//            el := doc.body.all.item(i);
//            if (el.tagName = 'TD') and (el.innertext = 'USD') then
//                ShowMessage(el.innerHTML);
//        end;
//    finally
//        HtmlCode.Free;
//    end;
end;

function TfrmCurrencyEditorDlg.IsFormDataPosted: Boolean;
begin
    if CheckParams then
    begin
        fMasterDataSet.FieldByName('BNM_RATE').Value := fMasterDataSet.FieldByName('TRANSFER_RATE').Value;
        fMasterDataSet.FieldByName('EXCHANGE_RATE').Value := fMasterDataSet.FieldByName('TRANSFER_RATE').Value;
        fMasterDataSet.FieldByName('DEGHEST_RATE').Value := fMasterDataSet.FieldByName('TRANSFER_RATE').Value;

        if fMasterDataSet.State in dsEditModes then
            fMasterDataSet.Post;
        fMasterDataSet.UpdateTransaction.Commit;

        Result := True;
    end
    else
        Result := False;
end;

procedure TfrmCurrencyEditorDlg.Prepare;
begin
    inherited;
    OldTransferRate := fMasterDataSet.FieldByName('TRANSFER_RATE').AsFloat;
    fMasterDataSet.UpdateTransaction.StartTransaction;
    try
        dtDialogTitle.Text := 'Valuta "' + fMasterDataSet.FieldByName('TITLE').AsString + '"';
        fMasterDataSet.Edit;
    except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
    end;
end;

procedure TfrmCurrencyEditorDlg.SpeedButton1Click(Sender: TObject);
begin
    GetMAIBUsdRate;
end;

procedure TfrmCurrencyEditorDlg.WhenCancelForm;
begin
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

