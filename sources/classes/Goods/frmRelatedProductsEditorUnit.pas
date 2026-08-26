unit frmRelatedProductsEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons, Vcl.ExtCtrls,
  DialogTitle;

type
  TfrmRelatedProductsEditor = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Panel2: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    beGoods: TcxButtonEdit;
    Label1: TLabel;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    IsNewRecord: Boolean;
    { Public declarations }
  end;

//var
//  frmRelatedProductsEditor: TfrmRelatedProductsEditor;

implementation

uses
  Data.DB;

{$R *.dfm}

{ TfrmRelatedProductsEditor }

function TfrmRelatedProductsEditor.IsFormDataPosted: Boolean;
begin
    result := False;
    if MasterDataSet.State in dsEditmodes then
      MasterDataSet.Post;
end;

procedure TfrmRelatedProductsEditor.Prepare;
begin
    if IsNewRecord then
    begin
        MasterDataSet.Append;
        beGoods.Text := '';
        beGoods.Tag := -1;
    end
    else
    begin
        MasterDataSet.Edit;
        beGoods.Text := MasterDataSet.FieldByName('RELATED_GOODS_NAME').AsString;
        beGoods.Tag := MasterDataSet.FieldByName('RELATED_GOODSID').AsInteger;
    end;
  inherited;
end;

end.
