unit frmSyssEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxLabel, Vcl.ExtCtrls, dxGDIPlusClasses, DialogTitle;

type

  TfrmSyssEditorViewMode = (seemTitle,seemTitleValueStr,seemTitleValueInt);

  TfrmSyssEditorDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    pnValueInt: TPanel;
    lbValueInt: TcxLabel;
    pnTitle: TPanel;
    lbTitle: TcxLabel;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    edValueIntEditor: TcxDBLookupComboBox;
    edTitle: TcxDBTextEdit;
    pnValueStr: TPanel;
    lbValueStr: TcxLabel;
    edValueStrEditor: TcxDBTextEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fViewMode: TfrmSyssEditorViewMode;
    fLabelTitle, fLabelValue: String;
    fPrimaryDataSet:TIBCQuery;
    fSecondaryDataSet:TIBCTable;
    fPrimaryDataSouce,fSecondaryDataSouce:TIBCDataSource;
    FEditMode: Boolean;
    procedure SetViewMode(const Value: TfrmSyssEditorViewMode);

    procedure PrepareView;
    procedure SetEditMode(const Value: Boolean);

    function CheckParams:Boolean;
  public
    { Public declarations }
    constructor Create(const AOwner:TComponent; const PrimaryDataSet:TIBCQuery; const SecondaryDataSet:TIBCTable; const PrimaryDataSouce,SecondaryDataSouce:TIBCDataSource);reintroduce;

    property EditMode:Boolean read FEditMode write SetEditMode;
    property ViewMode:TfrmSyssEditorViewMode read fViewMode write SetViewMode;

    procedure SetTitles(const LabelTitle:String; const LabelValue:String='');
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmSyssEditorDlg }

procedure TfrmSyssEditorDlg.btnOkClick(Sender: TObject);
begin
     if CheckParams then
     begin
          fPrimaryDataSet.Post;
          fPrimaryDataSet.UpdateTransaction.Commit;
          ModalResult:=mrOk;
     end;
end;

function TfrmSyssEditorDlg.CheckParams: Boolean;
var S:String;
begin
     Result:=False;
     S:='';
     if fPrimaryDataSet.FieldByName('TITLE').IsNull or (fPrimaryDataSet.FieldByName('TITLE').AsWideString='')
      then AddErrorToStr(S,lbTitle.Caption+'!');

     if S=''
      then Result:=True
      else ShowErrorDialog(cMSG_LOGIN_GeneralInputError_Title,cMSG_LOGIN_GeneralInputError_Text,S);
end;

constructor TfrmSyssEditorDlg.Create(const AOwner:TComponent; const PrimaryDataSet:TIBCQuery; const SecondaryDataSet:TIBCTable; const PrimaryDataSouce, SecondaryDataSouce: TIBCDataSource);
begin
     inherited Create(AOwner);
     fPrimaryDataSet:=PrimaryDataSet;
     fSecondaryDataSet:=SecondaryDataSet;
     fPrimaryDataSouce:=PrimaryDataSouce;
     fSecondaryDataSouce:=SecondaryDataSouce;

     edTitle.DataBinding.DataSource:=fPrimaryDataSouce;
     edValueStrEditor.DataBinding.DataSource:=fPrimaryDataSouce;
     edValueIntEditor.DataBinding.DataSource:=fPrimaryDataSouce;

     EditMode:=True;
end;

procedure TfrmSyssEditorDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if ModalResult<>mrOk then
     begin
          fPrimaryDataSet.Cancel;
          fPrimaryDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmSyssEditorDlg.FormShow(Sender: TObject);
begin
     PrepareView;
end;

procedure TfrmSyssEditorDlg.PrepareView;
var Props:TcxLookupComboBoxProperties;
begin
     lbTitle.Caption:=fLabelTitle;

     case fViewMode of
       seemTitle:           begin
                                 pnValueStr.Visible:=False;
                                 pnValueInt.Visible:=False;
                                 btnOk.Default:=True;
                            end;
       seemTitleValueStr:   begin
                                 lbValueStr.Caption:=fLabelValue;
                                 pnValueInt.Visible:=False;
                            end;
       seemTitleValueInt:   begin
                                 lbValueInt.Caption:=fLabelValue;
                                 pnValueStr.Visible:=False;

                                 Props:=TcxLookupComboBoxProperties(edValueIntEditor.Properties);
                                 Props.ListSource:=fSecondaryDataSouce;
                            end;
     end;

     fPrimaryDataSet.UpdateTransaction.StartTransaction;
     
     if FEditMode then fPrimaryDataSet.Edit
     else
     begin
          fPrimaryDataSet.Append;
          //fPrimaryDataSet.FieldByName('STYPE').AsString:=fSecondaryDataSet.ParamByName('STYPE').AsString;
          //fPrimaryDataSet.FieldByName('SNO').AsInteger:=fSecondaryDataSet.ParamByName('SNO').AsInteger;
     end;
end;

procedure TfrmSyssEditorDlg.SetViewMode(const Value: TfrmSyssEditorViewMode);
begin
     fViewMode := Value;
end;

procedure TfrmSyssEditorDlg.SetEditMode(const Value: Boolean);
begin
     FEditMode := Value;
     if FEditMode then
     begin
          Caption:='Modificare';
          dtDialogTitle.Text:='Modificati valorile in campurile necesare';
     end
     else
     begin
          Caption:='Inregistrare noua';
          dtDialogTitle.Text:='Introduceti valorile noi';
     end;
end;

procedure TfrmSyssEditorDlg.SetTitles(const LabelTitle, LabelValue: String);
begin
     fLabelTitle:=LabelTitle;
     fLabelValue:=LabelValue;

     dtDialogTitle.Title:=LabelTitle;
end;

end.
