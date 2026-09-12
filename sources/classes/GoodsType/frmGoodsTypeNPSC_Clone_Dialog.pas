unit frmGoodsTypeNPSC_Clone_Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.ExtCtrls, DialogTitle, Data.DB, DBAccess, IBC, MemDS;

type
  TfrmGoodsTypeNPSC_Clone_Dlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lcbSource: TcxLookupComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryGT: TIBCQuery;
    IBCDataSourceGT: TIBCDataSource;
    lcbTarget: TcxLookupComboBox;
  private
    { Private declarations }
    fSourceGoodsTypeID: Integer;
    fTargetGoodsTypeID: Integer;
    function CheckInputParams:Boolean;
    function AskUser:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property SourceGoodsTypeID:Integer read fSourceGoodsTypeID;
    property TargetGoodsTypeID:Integer read fTargetGoodsTypeID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{ TfrmGoodsTypeNPSC_Clone_Dlg }

function TfrmGoodsTypeNPSC_Clone_Dlg.AskUser: Boolean;
begin
     Result:=ShowAskDialog('Copiere tipizare',
       Format('Doriti sa copiati tipizarea din'#13#10'"%s"'#13#10'in'#13#10'"%s"?',[lcbSource.Text,lcbTarget.Text]),
       'Toate componentele curente vor fi sterse!')=mrYes;
end;

function TfrmGoodsTypeNPSC_Clone_Dlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=True;
     if VarIsNull(lcbSource.EditValue) or (lcbSource.EditValue<=0) then AddErrorToStr(Errors,'Din ce tip de marfa?');
     if VarIsNull(lcbTarget.EditValue) or (lcbTarget.EditValue<=0) then AddErrorToStr(Errors,'In ce tip de marfa?');

     if (Errors='')
       then Result:=True
       else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

function TfrmGoodsTypeNPSC_Clone_Dlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams and AskUser then
     begin
          fSourceGoodsTypeID:=lcbSource.EditValue;
          fTargetGoodsTypeID:=lcbTarget.EditValue;
          Result:=True;
     end;
end;

procedure TfrmGoodsTypeNPSC_Clone_Dlg.Prepare;
begin
     IBCQueryGT.Active:=True;
     lcbSource.EditValue:=fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger;
end;

end.
