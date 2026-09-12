unit frmSelfPickupEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS;

type

  TOnSelfPickupCheckIfExists = function (const FirmaID, OrasID, CustomerID:integer):Boolean of Object;

  TfrmSelfPickupEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQuerySP: TIBCQuery;
    IBCDataSourceSP: TIBCDataSource;
    cxGridTable_CUSTOMER_DISPLAYNAME: TcxGridDBColumn;
    cxGridTable_ORAS_DENUMIRE: TcxGridDBColumn;
    cxGridTable_CUSTOMER_ADRESA: TcxGridDBColumn;
    cxGridTable_FIRMAID: TcxGridDBColumn;
    cxGridTable_ORASID: TcxGridDBColumn;
    cxGridTable_CUSTOMERID: TcxGridDBColumn;
  private
    { Private declarations }
    fCreateNewSelfPickup: Boolean;
    fOnSelfPickupCheckIfExists: TOnSelfPickupCheckIfExists;
    procedure SetCreateNewSelfPickup(const Value: Boolean);
    function CheckParams:Boolean;
    procedure LocateRecord;
    procedure SetOnSelfPickupCheckIfExists(const Value: TOnSelfPickupCheckIfExists);
  protected
    { protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewSelfPickup:Boolean read FCreateNewSelfPickup write SetCreateNewSelfPickup;
    property OnSelfPickupCheckIfExists:TOnSelfPickupCheckIfExists read FOnSelfPickupCheckIfExists write SetOnSelfPickupCheckIfExists;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmSelfPickupEditorDlg }

function TfrmSelfPickupEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
    FirmaID, OrasID, CustomerID :integer;
begin
     Result:=False;
     ErrorStr:='';

     // save value
     if Assigned(cxGridTable.Controller.FocusedRecord) then
     begin
          if Assigned(fOnSelfPickupCheckIfExists) then
          begin
               FirmaID:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_FIRMAID.Index];
               OrasID:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_ORASID.Index];
               CustomerID:=cxGridTable.Controller.FocusedRecord.Values[cxGridTable_CUSTOMERID.Index];

               if fOnSelfPickupCheckIfExists(FirmaID, OrasID, CustomerID) then AddErrorToStr(ErrorStr,'Acest punct de ridicare exista deja!');
          end;

          fMasterDataSet.FieldByName('FIRMAID').AsInteger:=IBCQuerySP.FieldByName('FIRMAID').AsInteger;
          fMasterDataSet.FieldByName('ORASID').AsInteger:=IBCQuerySP.FieldByName('ORASID').AsInteger;
          fMasterDataSet.FieldByName('CUSTOMERID').AsInteger:=IBCQuerySP.FieldByName('CUSTOMERID').AsInteger;
     end
     else AddErrorToStr(ErrorStr,'Selectati punctul de ridicare!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,ErrorStr);
end;

procedure TfrmSelfPickupEditorDlg.InitValues;
begin
     inherited;
     fOnSelfPickupCheckIfExists := nil;
     fCreateNewSelfPickup:=False;

     IBCQuerySP.Transaction:=fMasterDataSet.UpdateTransaction;
end;

function TfrmSelfPickupEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmSelfPickupEditorDlg.LocateRecord;
var i:integer;
    FirmaID, OrasID, CustomerID :integer;
begin
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     begin
          FirmaID:=cxGridTable.DataController.Values[i,cxGridTable_FIRMAID.Index];
          OrasID:=cxGridTable.DataController.Values[i,cxGridTable_ORASID.Index];
          CustomerID:=cxGridTable.DataController.Values[i,cxGridTable_CUSTOMERID.Index];

          with fMasterDataSet do
          if (FieldByName('FIRMAID').AsInteger=FirmaID) and (FieldByName('ORASID').AsInteger=OrasID) and (FieldByName('CUSTOMERID').AsInteger=CustomerID) then
          begin
               cxGridTable.Controller.FocusedRecordIndex:=i;
               Break;
          end;
     end;
end;

procedure TfrmSelfPickupEditorDlg.Prepare;
var S:String;
begin
     try
        fMasterDataSet.UpdateTransaction.StartTransaction;

        IBCQuerySP.Active:=True;

        if fCreateNewSelfPickup then
        begin
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('ORDERNO').AsInteger:=-1;
        end
        else
        begin
             LocateRecord;
             fMasterDataSet.Edit;
        end;

     except
        if fMasterDataSet.UpdateTransaction.Active then fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSelfPickupEditorDlg.SetCreateNewSelfPickup(const Value: Boolean);
begin
     fCreateNewSelfPickup := Value;
end;

procedure TfrmSelfPickupEditorDlg.SetOnSelfPickupCheckIfExists(const Value: TOnSelfPickupCheckIfExists);
begin
     fOnSelfPickupCheckIfExists := Value;
end;

procedure TfrmSelfPickupEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
