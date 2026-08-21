unit frmWebVirtualCategoryEditorDialog;

(* Editor pentru o categorie virtuala a meniului web (TWEB_VIRTUAL_CATEGORIES):
   NAME_RO / NAME_RU + imagine (click dreapta pe imagine -> Load/Save/Clear). *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
    StdCtrls, cxDBEdit, ExtCtrls, DialogTitle, Data.DB, IBC, cxButtons, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxImage;

type
    TfrmWebVirtualCategoryEditorDlg = class(TSWNMasteredFormClass)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        edNAME_RO: TcxDBTextEdit;
        edNAME_RU: TcxDBTextEdit;
        imgIMAGE: TcxDBImage;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure edNAME_ROExit(Sender: TObject);
    private
        FCreateNewItem: Boolean;
        function CheckParams: Boolean;
    protected
        procedure BindingDataSource; override;
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public
        property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
    end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmWebVirtualCategoryEditorDlg }

function TfrmWebVirtualCategoryEditorDlg.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    ErrorStr := '';
    Result := False;
    with fMasterDataSet do
    begin
        if FieldByName('NAME_RO').IsNull or (Trim(FieldByName('NAME_RO').AsString) = '') then
            AddErrorToStr(ErrorStr, 'Denumire RO!');
        if FieldByName('NAME_RU').IsNull or (Trim(FieldByName('NAME_RU').AsString) = '') then
            AddErrorToStr(ErrorStr, 'Denumire RU!');
    end;
    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebVirtualCategoryEditorDlg.BindingDataSource;
begin
    inherited;
    FCreateNewItem := False;
    edNAME_RO.DataBinding.DataSource := fMasterDataSource;
    edNAME_RU.DataBinding.DataSource := fMasterDataSource;
    imgIMAGE.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmWebVirtualCategoryEditorDlg.Prepare;
begin
    if FCreateNewItem then
    begin
        dtDialogTitle.Text := 'Categorie virtuala noua';
        fMasterDataSet.Append;
    end
    else
    begin
        dtDialogTitle.Text := 'Modifica categoria virtuala';
        fMasterDataSet.Edit;
    end;
end;

procedure TfrmWebVirtualCategoryEditorDlg.edNAME_ROExit(Sender: TObject);
begin
    { daca denumirea RU e goala, se preia automat textul din RO }
    if (Trim(edNAME_RU.Text) = '') and (Trim(edNAME_RO.Text) <> '') then
    begin
        if not (fMasterDataSet.State in dsEditModes) then
            fMasterDataSet.Edit;
        fMasterDataSet.FieldByName('NAME_RU').AsString := edNAME_RO.Text;
    end;
end;

function TfrmWebVirtualCategoryEditorDlg.IsFormDataPosted: Boolean;
begin
    if CheckParams then
    begin
        fMasterDataSet.Post;
        Result := True;
    end
    else
        Result := False;
end;

procedure TfrmWebVirtualCategoryEditorDlg.WhenCancelForm;
begin
    if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Cancel;
end;

end.
