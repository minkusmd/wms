unit frmWebActiuniEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxImage, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, StdCtrls, ExtCtrls, DB, DBAccess,
  IBC, MemDS, cxCheckBox;

type
  TfrmWebActiuniEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edTITLE_RUS: TcxDBTextEdit;
    edTITLE_ROM: TcxDBTextEdit;
    edTEXT_RUS: TcxDBTextEdit;
    edTEXT_ROM: TcxDBTextEdit;
    Label7: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    Label8: TLabel;
    Label9: TLabel;
    deEND_DATE: TcxDBDateEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edBUTTON_TITLE_RUS: TcxDBTextEdit;
    edBUTTON_TITLE_ROM: TcxDBTextEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edNAV_LINK: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    imgOVERLAY: TcxImage;
    imgICON: TcxImage;
    cbFLG_HIDE_BUTTON: TcxDBCheckBox;
    procedure imgOVERLAYPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    fCreateNewActiune: Boolean;
    fImagesChanged: Boolean;
    fDT: integer;
    procedure SetCreateNewActiune(const Value: Boolean);

    procedure ReadImages(const ActiuneID: integer);
    procedure UpdateImages(const ActiuneID: integer);
    procedure CreateImageFromStream(const Image: TcxImage; const Data: TMemoryStream);
    procedure GetStreamDataFromImage(const Image: TcxImage; const ResultData: TMemoryStream);

    function CheckInputParams: Boolean;
    procedure SetDT(const Value: integer);

  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewActiune: Boolean read fCreateNewActiune write SetCreateNewActiune;
    property DT: integer read fDT write SetDT;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst, PNGImage, DataModuleDB, dxGDIPlusClasses;

{$R *.dfm}
{ TfrmWebActiuniEditorDlg }

function TfrmWebActiuniEditorDlg.CheckInputParams: Boolean;
var
  Errors: String;
begin
  Errors := '';
  Result := False;

  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('TITLE_RUS').AsString = '') then
    AddErrorToStr(Errors, 'Denumire, Rusa?');
  if fMasterDataSet.FieldByName('TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('TITLE_ROM').AsString = '') then
    AddErrorToStr(Errors, 'Denumire, Romana?');
  if fMasterDataSet.FieldByName('TEXT_RUS').IsNull or (fMasterDataSet.FieldByName('TEXT_RUS').AsString = '') then
    AddErrorToStr(Errors, 'Descriere, Rusa?');
  if fMasterDataSet.FieldByName('TEXT_ROM').IsNull or (fMasterDataSet.FieldByName('TEXT_ROM').AsString = '') then
    AddErrorToStr(Errors, 'Descriere, Romana?');
  if fMasterDataSet.FieldByName('START_DATE').IsNull then
    AddErrorToStr(Errors, 'Data desfasurarii, Inceput?');
  if fMasterDataSet.FieldByName('END_DATE').IsNull then
    AddErrorToStr(Errors, 'Data desfasurarii, Sfarsit?');

  if (fMasterDataSet.FieldByName('FLG_HIDE_BUTTON').AsInteger = 0) then
  begin
    if fMasterDataSet.FieldByName('BUTTON_TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('BUTTON_TITLE_RUS').AsString = '') then
      AddErrorToStr(Errors, 'Denumirea butonului, Rusa?');
    if fMasterDataSet.FieldByName('BUTTON_TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('BUTTON_TITLE_ROM').AsString = '') then
      AddErrorToStr(Errors, 'Denumirea butonului, Romana?');
  end;

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmWebActiuniEditorDlg.CreateImageFromStream(const Image: TcxImage; const Data: TMemoryStream);
var
  PNGImage: TdxPNGImage;
begin
  Data.Position := 0;
  PNGImage := TdxPNGImage.Create;
  try
    PNGImage.LoadFromStream(Data);
    Image.Picture.Assign(PNGImage);
  finally
    PNGImage.Free;
  end;
end;

procedure TfrmWebActiuniEditorDlg.GetStreamDataFromImage(const Image: TcxImage; const ResultData: TMemoryStream);
begin
  ResultData.Clear;
  if Assigned(Image.Picture) and Assigned(Image.Picture.Graphic) then
    Image.Picture.Graphic.SaveToStream(ResultData);
end;

procedure TfrmWebActiuniEditorDlg.imgOVERLAYPropertiesChange(Sender: TObject);
begin
  fImagesChanged := True;
end;

procedure TfrmWebActiuniEditorDlg.BindingDataSource;
begin
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edTEXT_RUS.DataBinding.DataSource := fMasterDataSource;
  edTEXT_ROM.DataBinding.DataSource := fMasterDataSource;
  edBUTTON_TITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  edBUTTON_TITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edNAV_LINK.DataBinding.DataSource := fMasterDataSource;
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_HIDE_BUTTON.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebActiuniEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    if fImagesChanged then
      UpdateImages(fMasterDataSet.FieldByName('ACTIUNEID').AsInteger);
    Result := True;
  end;
end;

procedure TfrmWebActiuniEditorDlg.Prepare;
begin
  if fCreateNewActiune then
  begin
    dtDialogTitle.Text := 'Creare actiune noua';
    fMasterDataSet.Insert;
    fMasterDataSet.FieldByName('DT').AsInteger := fDT;
    fMasterDataSet.FieldByName('START_DATE').AsDateTime := NOW;
    fMasterDataSet.FieldByName('END_DATE').AsDateTime := NOW + 30;
  end
  else
  begin
    dtDialogTitle.Text := 'Modificare inregistrare';
    fMasterDataSet.Edit;
  end;
  ReadImages(fMasterDataSet.FieldByName('ACTIUNEID').AsInteger);
end;

procedure TfrmWebActiuniEditorDlg.ReadImages(const ActiuneID: integer);
var
  Query: TIBCQuery;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'SELECT IMAGE_MASK, IMAGE_LOGO FROM TWEB_ACTIUNI WHERE ACTIUNEID=:id';
    Query.ParamByName('id').AsInteger := ActiuneID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      if Not Query.Fields[0].IsNull then
      begin
        MS.Clear;
        TBlobField(Query.Fields[0]).SaveToStream(MS);
        if MS.Size > 0 then
          CreateImageFromStream(imgOVERLAY, MS);
      end;
      if Not Query.Fields[1].IsNull then
      begin
        MS.Clear;
        TBlobField(Query.Fields[1]).SaveToStream(MS);
        if MS.Size > 0 then
          CreateImageFromStream(imgICON, MS);
      end;
    end;
  finally
    Query.Free;
    MS.Free;
    fImagesChanged := False;
  end;
end;

procedure TfrmWebActiuniEditorDlg.SetCreateNewActiune(const Value: Boolean);
begin
  fCreateNewActiune := Value;
end;

procedure TfrmWebActiuniEditorDlg.SetDT(const Value: integer);
begin
  fDT := Value;
end;

procedure TfrmWebActiuniEditorDlg.UpdateImages(const ActiuneID: integer);
var
  Query: TIBCQuery;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'UPDATE TWEB_ACTIUNI SET IMAGE_MASK=:img1, IMAGE_LOGO=:img2 WHERE ACTIUNEID=:id';
    Query.ParamByName('id').AsInteger := ActiuneID;

    GetStreamDataFromImage(imgOVERLAY, MS);
    if MS.Size > 0 then
    begin
      MS.Position := 0;
      Query.ParamByName('img1').LoadFromStream(MS, ftBlob);
    end
    else
      Query.ParamByName('img1').Value := null;

    GetStreamDataFromImage(imgICON, MS);
    if MS.Size > 0 then
    begin
      MS.Position := 0;
      Query.ParamByName('img2').LoadFromStream(MS, ftBlob);
    end
    else
      Query.ParamByName('img2').Value := null;

    Query.ExecSQL;

  finally
    Query.Free;
    MS.Free;
  end;
end;

procedure TfrmWebActiuniEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.
