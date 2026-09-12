unit frmDocTypesRegionEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, Menus, StdCtrls, cxImageComboBox, cxTextEdit,
  cxCheckListBox, cxCheckBox, cxLookAndFeelPainters, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCustomListBox;

type

  TfrmDocTypesRegionEditorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    clbStructure: TcxCheckListBox;
    edTITLE: TcxTextEdit;
    cxLabel3: TLabel;
    icbImageIndex: TcxImageComboBox;
    cxLabel4: TLabel;
    edDocTypeID: TcxTextEdit;
    cbAccessVisible: TcxCheckBox;
    Label1: TLabel;
    teOrderNo: TcxTextEdit;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure clbStructureEditValueToCheckStates(Sender: TObject; const AEditValue: Variant; var ACheckStates: TcxCheckStates);
    procedure clbStructureCheckStatesToEditValue(Sender: TObject; const ACheckStates: TcxCheckStates; out AEditValue: Variant);
  private
    { Private declarations }
    function GetImageIndex: integer;
    function GetStructMask: integer;
    function GetTitle: String;
    procedure SetImageIndex(const Value: integer);
    procedure SetStructMask(const Value: integer);
    procedure SetTitle(const Value: String);
    function CheckParams:Boolean;
    procedure InitImageList;
    procedure SetDocTypeID(const Value: integer);
    function GetAccessVisible: Boolean;
    function GetOrderNo: Integer;
    procedure SetAccessVisible(const Value: Boolean);
    procedure SetOrderNo(const Value: Integer);
  protected
    { protected declarations }
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    property Title:String read GetTitle write SetTitle;
    property ImageIndex:integer read GetImageIndex write SetImageIndex;
    property StructMask:integer read GetStructMask write SetStructMask;
    property AccessVisible:Boolean read GetAccessVisible write SetAccessVisible;
    property DocTypeID:integer write SetDocTypeID;
    property OrderNo: Integer read GetOrderNo write SetOrderNo;
  end;



implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmDocTypesRegionEditorDlg }

function TfrmDocTypesRegionEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';
     if Trim(edTITLE.Text)='' then AddErrorToStr(ErrorStr,'Denumire!');

     if ErrorStr='' then Result:=True
     else
     ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmDocTypesRegionEditorDlg.clbStructureCheckStatesToEditValue(Sender: TObject;
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

procedure TfrmDocTypesRegionEditorDlg.clbStructureEditValueToCheckStates(Sender: TObject; const AEditValue: Variant;
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

constructor TfrmDocTypesRegionEditorDlg.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     InitImageList;
end;

function TfrmDocTypesRegionEditorDlg.GetAccessVisible: Boolean;
begin
     Result:=cbAccessVisible.Checked;
end;

function TfrmDocTypesRegionEditorDlg.GetImageIndex: integer;
begin
     Result:=icbImageIndex.EditValue;
end;

function TfrmDocTypesRegionEditorDlg.GetOrderNo: Integer;
begin
   Result := teOrderNo.EditValue;
end;

function TfrmDocTypesRegionEditorDlg.GetStructMask: integer;
begin
     Result:=clbStructure.EditValue;
end;

function TfrmDocTypesRegionEditorDlg.GetTitle: String;
begin
     Result:=Trim(edTITLE.Text);
end;

procedure TfrmDocTypesRegionEditorDlg.InitImageList;
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

function TfrmDocTypesRegionEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams
      then Result:=True
      else Result:=False;
end;

procedure TfrmDocTypesRegionEditorDlg.SetAccessVisible(const Value: Boolean);
begin
     cbAccessVisible.Checked:=Value;
end;

procedure TfrmDocTypesRegionEditorDlg.SetDocTypeID(const Value: integer);
begin
     edDocTypeID.Text:=InttoStr(Value);
end;

procedure TfrmDocTypesRegionEditorDlg.SetImageIndex(const Value: integer);
begin
     icbImageIndex.EditValue:=Value;
end;

procedure TfrmDocTypesRegionEditorDlg.SetOrderNo(const Value: Integer);
begin
      teOrderNo.EditValue := Value;
end;

procedure TfrmDocTypesRegionEditorDlg.SetStructMask(const Value: integer);
begin
     clbStructure.EditValue:=Value;
end;

procedure TfrmDocTypesRegionEditorDlg.SetTitle(const Value: String);
begin
     edTITLE.Text:=Value;
end;

end.
