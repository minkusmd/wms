unit u57ActEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, IBC,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Vcl.ExtCtrls, DialogTitle, cxMemo, cxDBEdit, cxLabel, cxPCdxBarPopupMenu, cxPC, dxBarBuiltInMenu;

type
  Tfrm57ActEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxLabel5: TcxLabel;
    teActNo: TcxDBTextEdit;
    lbCreatedByName: TcxLabel;
    beCreatedBy: TcxButtonEdit;
    cxPageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxTabSheet4: TcxTabSheet;
    cxDBMemo1: TcxDBMemo;
    cxDBMemo2: TcxDBMemo;
    cxDBMemo3: TcxDBMemo;
    cxDBMemo4: TcxDBMemo;
    procedure beCreatedByPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
    procedure SetupSecurityItems;override;

  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DB, DataModuleDB, uChangeUser, SWNSecurity;

{ TForm2 }



procedure Tfrm57ActEditorDlg.beCreatedByPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var dialog:Tfrm57ChangeUser;
begin
     dialog:=Tfrm57ChangeUser.Create(Self, fMasterDataSet, fMasterDataSource);
     try
        //dialog.NewUserID:=fMasterDataSet.FieldByName('CREATED_BY').AsInteger;
        if dialog.ShowModal = mrOK then
        begin
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tfrm57ActEditorDlg.BindingDataSource;
begin
     inherited;

     cxDBMemo1.DataBinding.DataSource := fMasterDataSource;
     cxDBMemo2.DataBinding.DataSource := fMasterDataSource;
     cxDBMemo3.DataBinding.DataSource := fMasterDataSource;
     cxDBMemo4.DataBinding.DataSource := fMasterDataSource;
     teActNo.DataBinding.DataSource := fMasterDataSource;
end;

function Tfrm57ActEditorDlg.IsFormDataPosted: Boolean;
begin
     if fMasterDataSet.State in dsEditModes then fMasterDataSet.Post;
     fMasterDataSet.UpdateTransaction.Commit;
     Result := True;
end;

procedure Tfrm57ActEditorDlg.Prepare;
begin
     cxPageControl.ActivePageIndex:=0;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        dtDialogTitle.Text:='Modificare act';
        fMasterDataSet.Edit;
        beCreatedBy.Text := fMasterDataSet.FieldByName('CREATED_BY_NAME').AsString;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure Tfrm57ActEditorDlg.SetupSecurityItems;
begin
  inherited;
  if Not SWNSecurityManager.UserHasSecurityFlag(2002) then
     beCreatedBy.Visible:=false;  //2002 - Modificare utilizator
end;


procedure Tfrm57ActEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;


//SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату)
end.
