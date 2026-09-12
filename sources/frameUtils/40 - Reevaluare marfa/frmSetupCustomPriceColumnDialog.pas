unit frmSetupCustomPriceColumnDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons;

type

  TIntClass = class
    ValueInt:integer;
    constructor Create(const Value:integer);
  end;

  TfrmSetupCustomPriceColumnDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    cmbSourceColumn: TComboBox;
    Label2: TLabel;
    cmbTargetColumn: TComboBox;
    Label3: TLabel;
    edPercent: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edValue: TEdit;
    Label6: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormDestroy(Sender: TObject);
  private
    FMarginValue: Double;
    { Private declarations }
    fTargetColumn: integer;
    fPercent: double;
    fSourceColumn: integer;

    procedure BuildPriceColumns;
    function CheckInputParams:Boolean;
    procedure SaveValues;

    procedure ClearLists;
    procedure SetMarginValue(const Value: Double);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    property MarginValue: Double read FMarginValue write SetMarginValue;
    { Public declarations }
    property SourceColumn:integer read fSourceColumn;
    property TargetColumn:integer read fTargetColumn;
    property Percent:double read fPercent;
  end;



implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

{ TfrmSetupCustomPriceColumnDlg }

procedure TfrmSetupCustomPriceColumnDlg.BuildPriceColumns;
var columns:array[0..7] of boolean;
    i:integer;
    value:TIntClass;
begin
     columns[0]:=true; // SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_
     columns[1]:=true;
     columns[2]:=true;
     columns[3]:=true;
     columns[4]:=true;
     columns[5]:=true;
     columns[6]:=true;
     columns[7]:=true;
     for i:= 0 to 7 do
     if columns[i] then
     begin
          value:=TIntClass.Create(i);
          cmbSourceColumn.Items.AddObject(Format('Pret %d',[i]),value);
          if i<>0 then
          begin
               value:=TIntClass.Create(i);
               cmbTargetColumn.Items.AddObject(Format('Pret %d',[i]),value);
          end;
     end;

end;

function TfrmSetupCustomPriceColumnDlg.CheckInputParams: Boolean;
var ErrorStr:String;
//    f, v:double;
    N1,N2:integer;
begin
     Result:=False;
     ErrorStr:='';

     N1:=-1;
     N2:=-1;

     if cmbSourceColumn.ItemIndex=-1 then AddErrorToStr(ErrorStr,'Grila initiala!')
     else N1:=TIntClass(cmbSourceColumn.Items.Objects[cmbSourceColumn.ItemIndex]).ValueInt;

//     f:=StrToFloatDef(edPercent.Text,0);
//     v:=StrToFloatDef(edValue.Text,0);
//     if (f=0) and (v=0) then AddErrorToStr(ErrorStr,'adaos comercial!');

     if cmbTargetColumn.ItemIndex=-1 then AddErrorToStr(ErrorStr,'Grila finala!')
     else N2:=TIntClass(cmbTargetColumn.Items.Objects[cmbTargetColumn.ItemIndex]).ValueInt;

     if N2=N1 then AddErrorToStr(ErrorStr,'Grile de preturi identice!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmSetupCustomPriceColumnDlg.ClearLists;
var i:integer;
    value:TIntClass;
begin
     for i := 0 to cmbSourceColumn.Items.Count - 1 do
     begin
          value:=TIntClass(cmbSourceColumn.Items.Objects[i]);
          value.Free;
     end;
     for i := 0 to cmbTargetColumn.Items.Count - 1 do
     begin
          value:=TIntClass(cmbTargetColumn.Items.Objects[i]);
          value.Free;
     end;
end;

procedure TfrmSetupCustomPriceColumnDlg.FormDestroy(Sender: TObject);
begin
     ClearLists;
end;

function TfrmSetupCustomPriceColumnDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          SaveValues;
          Result:=True;
     end;
end;

procedure TfrmSetupCustomPriceColumnDlg.Prepare;
begin
     BuildPriceColumns;
     if cmbSourceColumn.Items.Count>0 then cmbSourceColumn.ItemIndex:=0;
     //if cmbTargetColumn.Items.Count>1 then cmbTargetColumn.ItemIndex:=1;
end;

procedure TfrmSetupCustomPriceColumnDlg.SaveValues;
begin
     if cmbSourceColumn.ItemIndex<>-1 then fSourceColumn:=TIntClass(cmbSourceColumn.Items.Objects[cmbSourceColumn.ItemIndex]).ValueInt else fSourceColumn:=-1;
     if cmbTargetColumn.ItemIndex<>-1 then fTargetColumn:=TIntClass(cmbTargetColumn.Items.Objects[cmbTargetColumn.ItemIndex]).ValueInt else fTargetColumn:=-1;
     fPercent:=StrToFloatDef(edPercent.Text,0);
     fMarginValue := StrToFloatDef(edValue.Text, 0);
end;

procedure TfrmSetupCustomPriceColumnDlg.SetMarginValue(const Value: Double);
begin
   FMarginValue := Value;
end;

{ TIntClass }

constructor TIntClass.Create(const Value: integer);
begin
     ValueInt:=Value;
end;

end.
