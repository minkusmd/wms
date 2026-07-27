unit frmGoodsFilterEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle,
  cxDBEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  cxTextEdit, cxCheckBox, dxUIAClasses;

type
  TfrmGoodsFilterEditor = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edFILTERNAME_RUS: TcxDBTextEdit;
    Label2: TLabel;
    edFILTERNAME: TcxDBTextEdit;
    Label3: TLabel;
    edFILTERID: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    chkFLG_ORDINARY_FILTER: TcxDBCheckBox;
    chkFlg_Is_Filter: TcxDBCheckBox;
  private
    { Private declarations }
    FCreateNewFilter: Boolean;
    fIsFolder: Boolean;
    FParentID: integer;
    procedure SetCreateNewFilter(const Value: Boolean);
    function CheckParams:Boolean;
    procedure SetIsFolder(const Value: Boolean);
    procedure SetParentID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property CreateNewFilter:Boolean read FCreateNewFilter write SetCreateNewFilter;
    property ParentID:integer read FParentID write SetParentID;
    property IsFolder:Boolean read FIsFolder write SetIsFolder;
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsFilterEditor }

function TfrmGoodsFilterEditor.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('FILTERID').IsNull then AddErrorToStr(ErrorStr,'Код!');
     if (fMasterDataSet.FieldByName('FILTERNAME').IsNull) or (Trim(fMasterDataSet.FieldByName('FILTERNAME').AsString)='')
      then AddErrorToStr(ErrorStr,'Denumirea filtrului!');
     if (fMasterDataSet.FieldByName('FILTERNAME_RUS').IsNull) or (Trim(fMasterDataSet.FieldByName('FILTERNAME_RUS').AsString)='')
      then AddErrorToStr(ErrorStr,'Название фильтра!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsFilterEditor.BindingDataSource;
begin
     inherited;
     FCreateNewFilter := False;
     fIsFolder:=False;

     edFILTERID.DataBinding.DataSource:=fMasterDataSource;
     edFILTERNAME.DataBinding.DataSource:=fMasterDataSource;
     edFILTERNAME_RUS.DataBinding.DataSource:=fMasterDataSource;
     chkFLG_ORDINARY_FILTER.DataBinding.DataSource:=fMasterDataSource;
     chkFlg_Is_Filter.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsFilterEditor.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end;
end;

procedure TfrmGoodsFilterEditor.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewFilter then
        begin
             // create new record
             fMasterDataSet.Insert;
             if fIsFolder then
             begin
                  dtDialogTitle.Text:='Создание новой папки';
                  fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=1;
                  fMasterDataSet.FieldByName('FLG_ORDINARY_FILTER').AsInteger := 0;
                  chkFLG_ORDINARY_FILTER.Enabled := False;
             end
             else
             begin
                  dtDialogTitle.Text:='Создание нового фильтра';
                  fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=0;
                  chkFLG_ORDINARY_FILTER.Enabled := True;
             end;
             fMasterDataSet.FieldByName('PARENTID').AsInteger:=FParentID;
             fMasterDataSet.FieldByName('ORDERNO').AsInteger:=-1;
        end
        else
        begin
             // edit record
             if fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger=0
              then dtDialogTitle.Text:='Изменение фильтра'
              else dtDialogTitle.Text:='Изменение папки';

             fMasterDataSet.Edit;
        end;
     except on E:Exception do
        begin
             fMasterDataSet.UpdateTransaction.Rollback;
             raise;
        end;
     end;
end;

procedure TfrmGoodsFilterEditor.SetCreateNewFilter(const Value: Boolean);
begin
     FCreateNewFilter := Value;
end;

procedure TfrmGoodsFilterEditor.SetIsFolder(const Value: Boolean);
begin
     fIsFolder := Value;
end;

procedure TfrmGoodsFilterEditor.SetParentID(const Value: integer);
begin
     FParentID := Value;
end;

procedure TfrmGoodsFilterEditor.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
