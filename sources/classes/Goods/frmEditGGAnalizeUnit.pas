unit frmEditGGAnalizeUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
   cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxMaskEdit, cxDropDownEdit,
   cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxDBEdit, Data.DB, DBAccess, IBC, MemDS;

type
   TfrmEditGGAnalizeDlg = class(TSWNMasteredFormClass)
      Label1: TLabel;
      edTitle: TcxDBTextEdit;
      Label2: TLabel;
      cbUsers: TcxDBLookupComboBox;
      cxButton1: TcxButton;
      cxButton2: TcxButton;
      IBCQueryUsers: TIBCQuery;
      IBCDataSourceUsers: TIBCDataSource;
   private
      FIsNewRecord: Boolean;
      procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
   protected
      procedure Prepare; override;
      procedure BindingDataSource; override;
      function IsFormDataPosted: Boolean; override;
      procedure WhenCancelForm; override;
      procedure SaveStates; override;
      procedure LoadStates; override;
   public
      property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
   end;

var
   frmEditGGAnalizeDlg: TfrmEditGGAnalizeDlg;

implementation

{$R *.dfm}

{ TfrmEditGGAnalizeDlg }

procedure TfrmEditGGAnalizeDlg.BindingDataSource;
begin

end;

function TfrmEditGGAnalizeDlg.IsFormDataPosted: Boolean;
begin
   try
      if fMasterDataSet.State in [dsEdit, dsInsert] then
         fMasterDataSet.Post;

      if fMasterDataSet.UpdateTransaction.Active then
         fMasterDataSet.UpdateTransaction.Commit;
   except
      begin
         if fMasterDataSet.State in [dsEdit, dsInsert] then
            fMasterDataSet.Cancel;

         raise;
      end;
   end;
   Result := True;
end;

procedure TfrmEditGGAnalizeDlg.LoadStates;
begin

end;

procedure TfrmEditGGAnalizeDlg.Prepare;
begin
   edTitle.DataBinding.DataSource := fMasterDataSource;
   cbUsers.DataBinding.DataSource := fMasterDataSource;

   IBCQueryUsers.Open;
end;

procedure TfrmEditGGAnalizeDlg.SaveStates;
begin
   inherited;

end;

procedure TfrmEditGGAnalizeDlg.SetIsNewRecord(const Value: Boolean);
begin
   FIsNewRecord := Value;
end;

procedure TfrmEditGGAnalizeDlg.WhenCancelForm;
begin
   if fMasterDataSet.State in [dsEdit, dsInsert] then
      fMasterDataSet.Cancel;
   if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

