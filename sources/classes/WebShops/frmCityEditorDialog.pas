unit frmCityEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StdCtrls, cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxDBLookupComboBox, DB, IBC, Vcl.Menus, cxButtons, DBAccess, MemDS, cxLookupEdit, cxDBLookupEdit;

type
  TfrmCityEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    lcbCITYID: TcxDBLookupComboBox;
    edTELEFOANE: TcxDBTextEdit;
    edEMAIL: TcxDBTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IBCQueryCity: TIBCQuery;
    IBCDataSourceCity: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fCreateNewCity: Boolean;
    procedure SetCreateNewCity(const Value: Boolean);

    function CheckInputParams:Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewCity:Boolean read FCreateNewCity write SetCreateNewCity;
  end;


implementation

uses DataModuleDB, SWNConst, SWNUtils;

{$R *.dfm}

{ TfrmCityEditorDlg }

function TfrmCityEditorDlg.CheckInputParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('CITYID').IsNull or (fMasterDataSet.FieldByName('CITYID').AsInteger=-1) then AddErrorToStr(ErrorStr,'');
     if fMasterDataSet.FieldByName('TELEFOANE').IsNull or (fMasterDataSet.FieldByName('TELEFOANE').AsString='') then AddErrorToStr(ErrorStr,'');
     if fMasterDataSet.FieldByName('EMAIL').IsNull or (fMasterDataSet.FieldByName('EMAIL').AsString='') then AddErrorToStr(ErrorStr,'');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmCityEditorDlg.BindingDataSource;
begin
     inherited;

     fCreateNewCity:=False;

     lcbCITYID.DataBinding.DataSource:=fMasterDataSource;
     edTELEFOANE.DataBinding.DataSource:=fMasterDataSource;
     edEMAIL.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmCityEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmCityEditorDlg.Prepare;
begin
     inherited;

     try
        fMasterDataSet.UpdateTransaction.StartTransaction;

        if fCreateNewCity then
        begin
             dtDialogTitle.Text:='Добавление нового города';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FIRMAID').AsInteger:=dmDB.CurrentFirma;
             fMasterDataSet.FieldByName('CITYID').AsInteger:=2000;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение информации';
             fMasterDataSet.Edit;
        end;

        IBCQueryCity.Active:=True;

     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;

end;

procedure TfrmCityEditorDlg.SetCreateNewCity(const Value: Boolean);
begin
     fCreateNewCity := Value;
end;

procedure TfrmCityEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
