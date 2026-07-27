unit frmMagazinEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxDBLookupComboBox,
  cxTextEdit, cxDBEdit, DB, DBAccess, IBC, cxCheckBox, Buttons, cxImage, Vcl.Menus, cxButtons, MemDS, cxLookupEdit,
  cxDBLookupEdit;

type
  TfrmMagazinEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edADRESA: TcxDBTextEdit;
    edTELEFOANE: TcxDBTextEdit;
    edFAX: TcxDBTextEdit;
    edEMAIL: TcxDBTextEdit;
    lcbCUSTOMERID: TcxDBLookupComboBox;
    Label5: TLabel;
    IBCQueryFirme: TIBCQuery;
    IBCDataSourceFirme: TIBCDataSource;
    cmbFLG_SELF_PICKUP: TcxDBCheckBox;
    sbBringDetails: TSpeedButton;
    imgIMAGE: TcxDBImage;
    lbl1: TLabel;
    edGMap_URL: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure sbBringDetailsClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewMagazin: Boolean;
    fFirmaID: integer;
    fCityID: integer;
    procedure SetCreateNewMagazin(const Value: Boolean);
    procedure SetCityID(const Value: integer);
    procedure SetFirmaID(const Value: integer);

    function CheckInputParams:Boolean;
    procedure DoBringCustomerDetails;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewMagazin:Boolean read FCreateNewMagazin write SetCreateNewMagazin;
    property FirmaID:integer read FFirmaID write SetFirmaID;
    property CityID:integer read FCityID write SetCityID;
  end;



implementation

uses SWNUtils, SWNConst, DataModuleDB;

{$R *.dfm}

{ TfrmMagazinEditorDlg }

function TfrmMagazinEditorDlg.CheckInputParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('CUSTOMERID').IsNull or (fMasterDataSet.FieldByName('CUSTOMERID').AsInteger=-1) then AddErrorToStr(ErrorStr,'Фирма!');
     if fMasterDataSet.FieldByName('ADRESA').IsNull or (fMasterDataSet.FieldByName('ADRESA').AsString='') then AddErrorToStr(ErrorStr,'Адрес!');
     if fMasterDataSet.FieldByName('TELEFOANE').IsNull or (fMasterDataSet.FieldByName('TELEFOANE').AsString='') then AddErrorToStr(ErrorStr,'Телефоны!');
     if fMasterDataSet.FieldByName('EMAIL').IsNull or (fMasterDataSet.FieldByName('EMAIL').AsString='') then AddErrorToStr(ErrorStr,'Е-мэйл!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmMagazinEditorDlg.DoBringCustomerDetails;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT TELEFON1, TELEFON2, FAX, EMAIL, ADDRESS2 FROM TS_CUST_INFO WHERE CUSTOMERID=:id';
        Query.ParamByName('id').AsInteger:=fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             fMasterDataSet.FieldByName('ADRESA').AsString:=Query.Fields[4].AsString;
             fMasterDataSet.FieldByName('TELEFOANE').AsString:=Query.Fields[0].AsString+', '+Query.Fields[1].AsString;
             fMasterDataSet.FieldByName('FAX').AsString:=Query.Fields[2].AsString;;
             fMasterDataSet.FieldByName('EMAIL').AsString:=Query.Fields[3].AsString;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmMagazinEditorDlg.BindingDataSource;
begin
     inherited;

     fCreateNewMagazin:=False;

     lcbCUSTOMERID.DataBinding.DataSource:=fMasterDataSource;
     edADRESA.DataBinding.DataSource:=fMasterDataSource;
     edTELEFOANE.DataBinding.DataSource:=fMasterDataSource;
     edFAX.DataBinding.DataSource:=fMasterDataSource;
     edEMAIL.DataBinding.DataSource:=fMasterDataSource;
     cmbFLG_SELF_PICKUP.DataBinding.DataSource:=fMasterDataSource;
     imgIMAGE.DataBinding.DataSource:=fMasterDataSource;
     edGMap_URL.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmMagazinEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmMagazinEditorDlg.Prepare;
begin
     try
        fMasterDataSet.UpdateTransaction.StartTransaction;

        if fCreateNewMagazin then
        begin
             dtDialogTitle.Text:='Создание нового магазина';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FIRMAID').AsInteger:=fFirmaID;
             fMasterDataSet.FieldByName('CITYID').AsInteger:=fCityID;
             fMasterDataSet.FieldByName('FLG_SELF_PICKUP').AsInteger:=1;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
        end;

        IBCQueryFirme.Active:=True;

     except
        if fMasterDataSet.UpdateTransaction.Active then fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmMagazinEditorDlg.sbBringDetailsClick(Sender: TObject);
begin
     DoBringCustomerDetails;
end;

procedure TfrmMagazinEditorDlg.SetCityID(const Value: integer);
begin
     fCityID := Value;
end;

procedure TfrmMagazinEditorDlg.SetCreateNewMagazin(const Value: Boolean);
begin
     fCreateNewMagazin := Value;
end;

procedure TfrmMagazinEditorDlg.SetFirmaID(const Value: integer);
begin
     fFirmaID := Value;
end;

procedure TfrmMagazinEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
