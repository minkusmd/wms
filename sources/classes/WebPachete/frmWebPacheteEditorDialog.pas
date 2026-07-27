unit frmWebPacheteEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.StdCtrls, cxMaskEdit, cxButtonEdit, cxDBEdit, cxTextEdit, cxMemo, Vcl.ExtCtrls, cxDropDownEdit, cxCalendar, cxCheckBox;

type
  TfrmWebPacheteEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmDESCRIERE: TcxDBMemo;
    edTITLU: TcxDBTextEdit;
    beGOODSID: TcxButtonEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    Label5: TLabel;
    deDATA_INCHEPUT: TcxDBDateEdit;
    deDATA_SFIRSIT: TcxDBDateEdit;
    cbFLG_ENABLED: TcxDBCheckBox;
    procedure beGOODSIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DB, DataModuleAdditions, SWNUtils, SWNConst, frmGoods;

{ TfrmWebPacheteEditorDlg }

procedure TfrmWebPacheteEditorDlg.beGOODSIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODS_ID').AsInteger,False,0,'') then
        begin
             fMasterDataSet.FieldByName('GOODS_ID').AsInteger:=dialog.GoodsID;
             beGOODSID.Text:=dialog.GoodsTitle;
        end;
     finally
        dialog.Free;
     end;
end;

function TfrmWebPacheteEditorDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;

     if (fMasterDataSet.FieldByName('TITLU').IsNull) or (Trim(fMasterDataSet.FieldByName('TITLU').AsString)='')
       then AddErrorToStr(Error,'Denumire!');
     if (fMasterDataSet.FieldByName('GOODS_ID').IsNull) or (fMasterDataSet.FieldByName('GOODS_ID').AsInteger=-1)
       then AddErrorToStr(Error,'Produs!');
     if (fMasterDataSet.FieldByName('DATA_INCHEPUT').IsNull) then AddErrorToStr(Error,'Data inceput!');
     if (fMasterDataSet.FieldByName('DATA_SFIRSIT').IsNull) then AddErrorToStr(Error,'Data sfirsit!');

     if (Error='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmWebPacheteEditorDlg.BindingDataSource;
begin
     edTITLU.DataBinding.DataSource:=fMasterDataSource;
     mmDESCRIERE.DataBinding.DataSource:=fMasterDataSource;
     deDATA_INCHEPUT.DataBinding.DataSource:=fMasterDataSource;
     deDATA_SFIRSIT.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_ENABLED.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmWebPacheteEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmWebPacheteEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Creare pachet nou';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DATA_INCHEPUT').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('DATA_SFIRSIT').AsDateTime:=NOW+14;
             fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare înregistrare';
             fMasterDataSet.Edit;
        end;
        beGOODSID.Text:=fMasterDataSet.FieldByName('GOODS_TITLE').AsString;
     except
        if (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmWebPacheteEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     fCreateNewRecord := Value;
end;

procedure TfrmWebPacheteEditorDlg.WhenCancelForm;
begin
     if (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
