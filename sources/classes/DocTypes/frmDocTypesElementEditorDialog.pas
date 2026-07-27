unit frmDocTypesElementEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, cxButtonEdit, cxDropDownEdit, cxMaskEdit, cxImageComboBox, cxTextEdit,
  cxCheckListBox, ExtCtrls, cxCheckBox, cxLookAndFeelPainters,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxContainer, cxEdit, Vcl.Menus, cxCustomListBox;

type

  TOnGetNextFrameIndex = function:integer of object;

  TfrmDocTypesElementEditorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    clbStructure: TcxCheckListBox;
    edTITLE: TcxTextEdit;
    icbImageIndex: TcxImageComboBox;
    cxLabel4: TLabel;
    edSHORT: TcxTextEdit;
    cbFLG_MONEY: TCheckBox;
    cbFLG_DEBTS: TCheckBox;
    cbFLG_INVOICE: TCheckBox;
    cbFLG_TRANSFER: TCheckBox;
    cbFLG_SIGN: TcxComboBox;
    beTabIndex: TcxButtonEdit;
    cxLabel6: TLabel;
    cbHasFrame: TCheckBox;
    cbHasImage: TCheckBox;
    cxLabel3: TLabel;
    edDocTypeID: TcxTextEdit;
    Label1: TLabel;
    cbFLG_ACNT_INVOICE: TCheckBox;
    cbFLG_SERVICE_QTY: TCheckBox;
    cbFLG_ASSEMBLE: TCheckBox;
    cbFLG_ACHITARI: TCheckBox;
    cbCreateDefaultActions: TCheckBox;
    cbFLG_DBL_JURNAL: TCheckBox;
    cbAccessVisible: TcxCheckBox;
    cbFLG_UPR_UCET: TCheckBox;
    cbFLG_BUH_UCET: TCheckBox;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure cbHasFramePropertiesEditValueChanged(Sender: TObject);
    procedure cbHasImagePropertiesEditValueChanged(Sender: TObject);
    procedure clbStructureCheckStatesToEditValue(Sender: TObject; const ACheckStates: TcxCheckStates;
      out AEditValue: Variant);
    procedure clbStructureEditValueToCheckStates(Sender: TObject; const AEditValue: Variant;
      var ACheckStates: TcxCheckStates);
    procedure beTabIndexPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cbHasFrameClick(Sender: TObject);
    procedure cbHasImageClick(Sender: TObject);
  private
    { Private declarations }
    FOnGetNextFrameIndex: TOnGetNextFrameIndex;
    function GetImageIndex: integer;
    function GetStructMask: integer;
    function GetTitle: String;
    procedure SetImageIndex(const Value: integer);
    procedure SetStructMask(const Value: integer);
    procedure SetTitle(const Value: String);
    function GetShortName: String;
    procedure SetShortName(const Value: String);
    function GetFrameIndex: integer;
    procedure SetFrameIndex(const Value: integer);
    function GetFLG_MONEY: Boolean;
    procedure SetFLG_MONEY(const Value: Boolean);
    function GetFLG_DEBTS: Boolean;
    function GetFLG_INVOICE: Boolean;
    function GetFLG_SIGN: Boolean;
    function GetFLG_TRANSFER: Boolean;
    procedure SetFLG_DEBTS(const Value: Boolean);
    procedure SetFLG_INVOICE(const Value: Boolean);
    procedure SetFLG_SIGN(const Value: Boolean);
    procedure SetFLG_TRANSFER(const Value: Boolean);

    procedure InitImageList;
    function CheckParams:Boolean;
    procedure SetOnGetNextFrameIndex(const Value: TOnGetNextFrameIndex);
    procedure SetDocTypeID(const Value: integer);
    function GetFLG_ACNT_INVOICE: Boolean;
    procedure SetFLG_ACNT_INVOICE(const Value: Boolean);
    function GetFLG_SERVICE_QTY: Boolean;
    procedure SetFLG_SERVICE_QTY(const Value: Boolean);
    procedure SetFLG_ASSEMBLE(const Value: Boolean);
    function GetFLG_ASSEMBLE: Boolean;
    function GetFLG_ACHITARI: Boolean;
    procedure SetFLG_ACHITARI(const Value: Boolean);
    procedure SetFLG_DBL_JURNAL(const Value: Boolean);
    function GetFLG_DBL_JURNAL: Boolean;
    function GetFLG_ACCESS_VISIBLE: Boolean;
    function GetFLG_BUH_UCET: boolean;
    function GetFLG_UPR_UCET: boolean;
    procedure SetFLG_ACCESS_VISIBLE(const Value: Boolean);
    procedure SetFLG_BUH_UCET(const Value: boolean);
    procedure SetFLG_UPR_UCET(const Value: boolean);

  protected
    { protected declarations }
    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;

    property Title:String read GetTitle write SetTitle;
    property ShortName:String read GetShortName write SetShortName;
    property ImageIndex:integer read GetImageIndex write SetImageIndex;
    property StructMask:integer read GetStructMask write SetStructMask;
    property FrameIndex:integer read GetFrameIndex write SetFrameIndex;
    property FLG_MONEY:Boolean read GetFLG_MONEY write SetFLG_MONEY;
    property FLG_DEBTS:Boolean read GetFLG_DEBTS write SetFLG_DEBTS;
    property FLG_INVOICE:Boolean read GetFLG_INVOICE write SetFLG_INVOICE;
    property FLG_SIGN:Boolean read GetFLG_SIGN write SetFLG_SIGN;
    property FLG_TRANSFER:Boolean read GetFLG_TRANSFER write SetFLG_TRANSFER;
    property FLG_ACNT_INVOICE:Boolean read GetFLG_ACNT_INVOICE write SetFLG_ACNT_INVOICE;
    property FLG_SERVICE_QTY:Boolean read GetFLG_SERVICE_QTY write SetFLG_SERVICE_QTY;
    property FLG_ASSEMBLE:Boolean read GetFLG_ASSEMBLE write SetFLG_ASSEMBLE;
    property FLG_ACHITARI:Boolean read GetFLG_ACHITARI write SetFLG_ACHITARI;
    property FLG_DBL_JURNAL: Boolean read GetFLG_DBL_JURNAL write SetFLG_DBL_JURNAL;
    property FLG_ACCESS_VISIBLE:Boolean read GetFLG_ACCESS_VISIBLE write SetFLG_ACCESS_VISIBLE;
    property DocTypeID:integer write SetDocTypeID;
    property FLG_BUH_UCET: boolean read GetFLG_BUH_UCET write SetFLG_BUH_UCET;
    property FLG_UPR_UCET: boolean read GetFLG_UPR_UCET write SetFLG_UPR_UCET;

    property OnGetNextFrameIndex:TOnGetNextFrameIndex read FOnGetNextFrameIndex write SetOnGetNextFrameIndex;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmDocTypesElementEditorDlg }

procedure TfrmDocTypesElementEditorDlg.beTabIndexPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     if Assigned(FOnGetNextFrameIndex)
      then beTabIndex.Text:=IntToStr(FOnGetNextFrameIndex);
end;

procedure TfrmDocTypesElementEditorDlg.cbHasFrameClick(Sender: TObject);
begin
     beTabIndex.Enabled:=cbHasFrame.Checked;
end;

procedure TfrmDocTypesElementEditorDlg.cbHasFramePropertiesEditValueChanged(Sender: TObject);
begin
     beTabIndex.Enabled:=cbHasFrame.Checked;
     if Not cbHasFrame.Checked then beTabIndex.EditValue:=Null;
end;

procedure TfrmDocTypesElementEditorDlg.cbHasImageClick(Sender: TObject);
begin
     icbImageIndex.Enabled:=cbHasImage.Checked;
end;

procedure TfrmDocTypesElementEditorDlg.cbHasImagePropertiesEditValueChanged(Sender: TObject);
begin
     icbImageIndex.Enabled:=cbHasImage.Checked;
     if Not cbHasImage.Checked then icbImageIndex.EditValue:=-1;
end;

function TfrmDocTypesElementEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
    N:integer;
begin
     Result:=False;
     ErrorStr:='';
     if Trim(edTITLE.Text)='' then AddErrorToStr(ErrorStr,'Denumire!');
     if cbHasFrame.Checked then
     begin
          N:=StrToIntDef(beTabIndex.EditText,-2);
          if (N<-1) then AddErrorToStr(ErrorStr,'Index frame!');
     end;
     if cbHasImage.Checked then
     begin
          N:=icbImageIndex.EditValue;
          if N<0 then AddErrorToStr(ErrorStr,'Iconita!');
     end;

     if ErrorStr='' then Result:=True
     else
     ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmDocTypesElementEditorDlg.clbStructureCheckStatesToEditValue(Sender: TObject;
  const ACheckStates: TcxCheckStates; out AEditValue: Variant);
var i:integer;
    bits:integer;
    cb:TcxCheckListBoxItem;
begin
     AEditValue:=0;
     for i := Low(ACheckStates) to High(ACheckStates) do
     begin
          cb:=clbStructure.Items[i];
          if ACheckStates[i]=cbsChecked then
          begin
               bits:=1 shl cb.Tag;
               AEditValue:=AEditValue or bits;
          end;
     end;
end;

procedure TfrmDocTypesElementEditorDlg.clbStructureEditValueToCheckStates(Sender: TObject; const AEditValue: Variant;
  var ACheckStates: TcxCheckStates);
var i:integer;
    cb:TcxCheckListBoxItem;
begin
     for i := 0 to clbStructure.Items.Count-1 do
     begin
          cb:=clbStructure.Items[i];
          if ((AEditValue shr cb.Tag) and 1)=1
           then ACheckStates[i]:=cbsChecked
           else ACheckStates[i]:=cbsUnchecked;
     end;
end;

constructor TfrmDocTypesElementEditorDlg.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     InitImageList;
     beTabIndex.EditValue:=-1;
     FOnGetNextFrameIndex := nil;
     cbCreateDefaultActions.Visible:=False;
     cbCreateDefaultActions.Checked:=False;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_ACCESS_VISIBLE: Boolean;
begin
     Result:=cbAccessVisible.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_ACHITARI: Boolean;
begin
     Result:=cbFLG_ACHITARI.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_ACNT_INVOICE: Boolean;
begin
     Result:=cbFLG_ACNT_INVOICE.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_ASSEMBLE: Boolean;
begin
     Result:=cbFLG_ASSEMBLE.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_BUH_UCET: boolean;
begin
      Result := cbFLG_BUH_UCET.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_DBL_JURNAL: Boolean;
begin
     Result:=cbFLG_DBL_JURNAL.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_DEBTS: Boolean;
begin
     Result:=cbFLG_DEBTS.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_INVOICE: Boolean;
begin
     Result:=cbFLG_INVOICE.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_MONEY: Boolean;
begin
     Result:=cbFLG_MONEY.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_SERVICE_QTY: Boolean;
begin
     Result:=cbFLG_SERVICE_QTY.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_SIGN: Boolean;
begin
     // FLG_SIGN (1=[+]. 0=[-])
     Result:=cbFLG_SIGN.ItemIndex=1;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_TRANSFER: Boolean;
begin
     Result:=cbFLG_TRANSFER.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFLG_UPR_UCET: boolean;
begin
      Result := cbFLG_UPR_UCET.Checked;
end;

function TfrmDocTypesElementEditorDlg.GetFrameIndex: integer;
begin
     if cbHasFrame.Checked then
     begin
          Result:=beTabIndex.EditValue;
     end
     else Result:=-1;
end;

function TfrmDocTypesElementEditorDlg.GetImageIndex: integer;
begin
     if cbHasImage.Checked then
     begin
          Result:=icbImageIndex.EditValue;
     end
     else Result:=-1;
end;

function TfrmDocTypesElementEditorDlg.GetShortName: String;
begin
     Result:=Trim(edSHORT.Text);
end;

function TfrmDocTypesElementEditorDlg.GetStructMask: integer;
begin
     Result:=clbStructure.EditValue;
end;

function TfrmDocTypesElementEditorDlg.GetTitle: String;
begin
     Result:=Trim(edTITLE.Text);
end;

procedure TfrmDocTypesElementEditorDlg.InitImageList;
var i:integer;
    item:TcxImageComboBoxItem;
begin
     icbImageIndex.Properties.Items.BeginUpdate;
     try
        for i := 0 to dmAdditions.cxImageList_MainTabs.Count - 1 do
        begin
          item:=icbImageIndex.Properties.Items.Add;
          item.ImageIndex:=i;
          item.Value:=i;
        end;
     finally
        icbImageIndex.Properties.Items.EndUpdate;
     end;
end;

function TfrmDocTypesElementEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams
      then Result:=True
      else Result:=False;
end;

procedure TfrmDocTypesElementEditorDlg.SetDocTypeID(const Value: integer);
begin
     edDocTypeID.Text:=IntToStr(Value);
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_ACCESS_VISIBLE(const Value: Boolean);
begin
     cbAccessVisible.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_ACHITARI(const Value: Boolean);
begin
     cbFLG_ACHITARI.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_ACNT_INVOICE(const Value: Boolean);
begin
     cbFLG_ACNT_INVOICE.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_ASSEMBLE(const Value: Boolean);
begin
     cbFLG_ASSEMBLE.Checked := Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_BUH_UCET(const Value: boolean);
begin
   cbFLG_BUH_UCET.Checked := Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_DBL_JURNAL(const Value: Boolean);
begin
     cbFLG_DBL_JURNAL.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_DEBTS(const Value: Boolean);
begin
     cbFLG_DEBTS.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_INVOICE(const Value: Boolean);
begin
     cbFLG_INVOICE.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_MONEY(const Value: Boolean);
begin
     cbFLG_MONEY.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_SERVICE_QTY(const Value: Boolean);
begin
     cbFLG_SERVICE_QTY.Checked := Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_SIGN(const Value: Boolean);
begin
     // FLG_SIGN (1=[+]. 0=[-])
     // 0 = Отрицательный (-)
     // 1 - Положительный (+)
     cbFLG_SIGN.ItemIndex:=Ord(Value);
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_TRANSFER(const Value: Boolean);
begin
     cbFLG_TRANSFER.Checked:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFLG_UPR_UCET(const Value: boolean);
begin
   cbFLG_UPR_UCET.Checked := Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetFrameIndex(const Value: integer);
begin
     if Value=-1 then
     begin
          cbHasFrame.Checked:=False;
     end
     else
     begin
          cbHasFrame.Checked:=True;
          beTabIndex.EditValue:=Value;
     end;
     cbHasFramePropertiesEditValueChanged(cbHasFrame);
end;

procedure TfrmDocTypesElementEditorDlg.SetImageIndex(const Value: integer);
begin
     if Value=-1 then
     begin
          cbHasImage.Checked:=False;
     end
     else
     begin
          cbHasImage.Checked:=True;
          icbImageIndex.EditValue:=Value;
     end;
     cbHasImagePropertiesEditValueChanged(cbHasImage);
end;

procedure TfrmDocTypesElementEditorDlg.SetOnGetNextFrameIndex(const Value: TOnGetNextFrameIndex);
begin
     FOnGetNextFrameIndex := Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetShortName(const Value: String);
begin
     edSHORT.Text:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetStructMask(const Value: integer);
begin
     clbStructure.EditValue:=Value;
end;

procedure TfrmDocTypesElementEditorDlg.SetTitle(const Value: String);
begin
     edTITLE.Text:=Value;
end;

end.
