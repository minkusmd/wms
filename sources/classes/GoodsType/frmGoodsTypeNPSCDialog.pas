unit frmGoodsTypeNPSCDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBAseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, Vcl.Buttons, Data.DB, DBAccess, IBC, MemDS, cxMaskEdit, cxDropDownEdit;

type
  TfrmGoodsTypeNPSCDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    sbEditBaseParam_Params: TSpeedButton;
    sbEditAddParams_Params: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    Label6: TLabel;
    IBCQueryBP: TIBCQuery;
    IBCDataSourceBP: TIBCDataSource;
    IBCQueryAdd: TIBCQuery;
    IBCDataSourceAdd: TIBCDataSource;
    cmbSEPARATOR1: TcxDBComboBox;
    cmbSEPARATOR2: TcxDBComboBox;
    Label7: TLabel;
    Label8: TLabel;
    procedure sbEditBaseParam_ParamsClick(Sender: TObject);
    procedure sbEditAddParams_ParamsClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowBaseParamCompenentsDialog;
    procedure ShowAddPamarsComponentsDialog;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, frmGoodsTypeNPSC_BPList_Editor_Dialog, frmGoodsTypeNPSC_APList_Editor_Dialog;

{ TfrmGoodsTypeNPSCDlg }

procedure TfrmGoodsTypeNPSCDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     edTITLE_RUS.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryBP.MasterSource:=fMasterDataSource;
     IBCQueryBP.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryBP.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryAdd.MasterSource:=fMasterDataSource;
     IBCQueryAdd.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryAdd.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

function TfrmGoodsTypeNPSCDlg.IsFormDataPosted: Boolean;
begin
     if IBCQueryBP.State in dsEditModes then IBCQueryBP.Post;
     if IBCQueryAdd.State in dsEditModes then IBCQueryAdd.Post;
     fMasterDataSet.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmGoodsTypeNPSCDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        IBCQueryBP.Active:=True;
        IBCQueryAdd.Active:=True;

        if (IBCQueryBP.Eof) then
        begin
             // create new record
             IBCQueryBP.Insert;
             IBCQueryBP.FieldByName('GOODSTYPEID').AsInteger:=fMasterDataSet.FieldByName('GOODSTYPEID').asInteger;
             IBCQueryBP.FieldByName('SEPARATOR').AsString:=' ';
        end
        else IBCQueryBP.Edit;
        if (IBCQueryAdd.Eof) then
        begin
             // create new record
             IBCQueryAdd.Insert;
             IBCQueryAdd.FieldByName('GOODSTYPEID').AsInteger:=fMasterDataSet.FieldByName('GOODSTYPEID').asInteger;
             IBCQueryAdd.FieldByName('SEPARATOR').AsString:='/';
        end
        else IBCQueryAdd.Edit;
     except
        if IBCQueryBP.State in dsEditModes then IBCQueryBP.Cancel;
        if IBCQueryAdd.State in dsEditModes then IBCQueryAdd.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmGoodsTypeNPSCDlg.sbEditAddParams_ParamsClick(Sender: TObject);
begin
     if IBCQueryAdd.State in dsEditModes then IBCQueryAdd.Post;
     ShowAddPamarsComponentsDialog;
end;

procedure TfrmGoodsTypeNPSCDlg.sbEditBaseParam_ParamsClick(Sender: TObject);
begin
     if IBCQueryBP.State in dsEditModes then IBCQueryBP.Post;
     ShowBaseParamCompenentsDialog;
end;

procedure TfrmGoodsTypeNPSCDlg.ShowAddPamarsComponentsDialog;
var dialog:TfrmGoodsTypeNPSC_APList_Editor_Dlg;
begin
     dialog:=TfrmGoodsTypeNPSC_APList_Editor_Dlg.Create(Self,IBCQueryAdd,IBCDataSourceAdd);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsTypeNPSCDlg.ShowBaseParamCompenentsDialog;
var dialog:TfrmGoodsTypeNPSC_BPList_Editor_Dlg;
begin
     dialog:=TfrmGoodsTypeNPSC_BPList_Editor_Dlg.Create(Self,IBCQueryBP,IBCDataSourceBP);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsTypeNPSCDlg.WhenCancelForm;
begin
     if IBCQueryBP.State in dsEditModes then IBCQueryBP.Cancel;
     if IBCQueryAdd.State in dsEditModes then IBCQueryAdd.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
