unit frmBSToolsCopyGridClipboardDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit,
  cxGridTableView;

type
  TfrmBSToolsCopyGridClipboardDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmbSource: TComboBox;
    cmbTarget: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    lbInfo: TLabel;
    cbHeaders: TCheckBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGrid: TcxGridTableView;
    procedure SetGrid(const Value: TcxGridTableView);

    procedure DoCopy;

    procedure GetAllData(const Text:TStringList);
    procedure GetColumnData(const Text:TStringList);
    procedure GetRowData(const Text:TStringList);

    procedure SaveDataToFile(const Text:TStringList);

  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean;override;
  public
    { Public declarations }
    property Grid: TcxGridTableView read FGrid write SetGrid;
  end;


implementation

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

uses DataModuleAdditions, Vcl.Clipbrd;

{ TfrmBSToolsCopyGridClipboardDlg }

procedure TfrmBSToolsCopyGridClipboardDlg.DoCopy;
var S:TStringList;
begin
     S:=TStringList.Create;
     try
        case cmbSource.ItemIndex of
        0: GetAllData(S);
        1: GetColumnData(S);
        2: GetRowData(S);
        end;

        case cmbTarget.ItemIndex of
        0: Clipboard.AsText:=S.Text;
        1: SaveDataToFile(S);
        end;

     finally
        S.Free;
     end;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.FormCreate(Sender: TObject);
begin
     fGrid:=nil;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.GetAllData(const Text: TStringList);
var i,j:integer;
    S:String;
begin
     // header
     if cbHeaders.Checked then
     begin
          S:='';
          for i := 0 to Grid.VisibleItemCount-1 do
          begin
               if S <> '' then S:=S+#9;
               S := S + Grid.DataController.GridView.VisibleItems[i].Caption;
          end;
          Text.Add(S);
     end;

     // data
     for i := 0 to Grid.ViewData.RecordCount-1 do
     begin
          S:='';
          for j := 0 to Grid.VisibleItemCount-1 do
          begin
               if S<>'' then S:=S+#9;
               // din rows am schimbat in records, pentru filtru aplicat pe grid
               S:=S+Trim(Grid.DataController.GetDisplayText(Grid.ViewData.Records[i].RecordIndex, Grid.ViewData.GridView.VisibleItems[j].Index));
          end;
          Text.Add(S);
     end;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.GetColumnData(const Text: TStringList);
var i:integer;
begin
     // header
     if cbHeaders.Checked then Text.Add(Grid.Controller.FocusedItem.Caption);

     for i := 0 to Grid.DataController.GridView.ViewData.RecordCount-1 do
     begin
          Text.Add(Trim(Grid.DataController.GetDisplayText(Grid.ViewData.Records[i].RecordIndex, Grid.Controller.FocusedItem.Index)));
     end;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.GetRowData(const Text: TStringList);
var i:integer;
    S:String;
begin
     // header
     if cbHeaders.Checked then
     begin
          S:='';
          for i := 0 to Grid.VisibleItemCount-1 do
          begin
               if S<>'' then S:=S+#9;
               S:=S+Grid.VisibleItems[i].Caption;
          end;
          Text.Add(S);
     end;

     S:='';
     for i := 0 to Grid.DataController.GridView.VisibleItemCount-1 do
     begin
          if S<>'' then S:=S+#9;
          S:=S+Trim(Grid.DataController.GetDisplayText(fGrid.Controller.FocusedRowIndex,Grid.VisibleItems[i].Index));
     end;
     Text.Add(S);
end;

function TfrmBSToolsCopyGridClipboardDlg.IsFormDataPosted: Boolean;
begin
     Result:=True;
     DoCopy;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.Prepare;
begin
     cmbSource.ItemIndex:=0;
     cmbTarget.ItemIndex:=0;
     if Assigned(fGrid) then
     begin
          lbInfo.Caption:=Format('Inregistrari: %d, coloane: %d', [Grid.VisibleItemCount,
                                                          Grid.VisibleColumnCount]);
     end
     else btnOk.Enabled:=False;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.SaveDataToFile(const Text: TStringList);
var dialog:TFileSaveDialog;
    item:TFileTypeItem;
    S:String;
begin
     dialog:=TFileSaveDialog.Create(Self);
     try
        item:=dialog.FileTypes.Add;
        item.DisplayName:='Text files';
        item.FileMask:='*.txt';
        dialog.DefaultExtension:='txt';
        if dialog.Execute then
        begin
             S:=dialog.FileName;
             if pos('.',S)=0 then S:=S+'.txt';
             Text.SaveToFile(S);
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBSToolsCopyGridClipboardDlg.SetGrid(const Value:
    TcxGridTableView);
begin
     fGrid := Value;
end;

end.
