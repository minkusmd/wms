unit frmContentCommentUnit;

interface

uses
  DBAccess, IBC, MemDS, SWNBaseUnit, cxButtonEdit, cxButtons, cxContainer, cxControls, cxEdit, cxGraphics,
  cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxMemo, cxTextEdit,

  Data.DB,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TfrmContentCommentDlg = class(TSWNBaseFormClass)
    cxButtonEdit1: TcxButtonEdit;
    cxMemo1: TcxMemo;
    btnOK: TcxButton;
    CancelBnt: TcxButton;
    IBCQueryComments: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    GoodsID: Integer;
    PackageID: Integer;
    { Public declarations }
  end;

var
  frmContentCommentDlg: TfrmContentCommentDlg;

implementation

uses
  DataModuleDB;

{$R *.dfm}

{ TfrmContentCommentDlg }

procedure TfrmContentCommentDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  cxMemo1.Lines.Add(Format('%S - (%S) %S ', [FormatDateTime('DD-MM-YYYY HH:MI:SS', Now), dmdb.CurrentUserFullName,
    cxButtonEdit1.Text]));
end;

function TfrmContentCommentDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    IBCQueryComments.UpdateTransaction.StartTransaction;
    if IBCQueryComments.RecordCount=0 then
      IBCQueryComments.Insert
    else
      IBCQueryComments.Edit;

    IBCQueryComments.FieldByName('packageid').AsInteger := PackageID;
    IBCQueryComments.FieldByName('GoodsID').AsInteger := GoodsID;
    IBCQueryComments.FieldByName('COMMENTS').AsString := cxMemo1.Lines.Text;
    IBCQueryComments.Post;
    IBCQueryComments.UpdateTransaction.Commit;
    Result := True;
  except
    begin
      Result := False;
      IBCQueryComments.UpdateTransaction.Rollback;
      raise;
    end;
  end;

end;

procedure TfrmContentCommentDlg.Prepare;
begin
  inherited;
  IBCQueryComments.UpdateTransaction := dmDB.IBCTrDefaultUpdate;
  ibcqueryComments.ParamByName('packageID').AsInteger := PackageID;
  IBCQueryComments.ParamByName('goodsID').AsInteger := GoodsID;
  IBCQueryComments.Open;

  cxMemo1.Lines.Text := IBCQueryComments.FieldByName('COMMENTS').AsString;

  cxMemo1.Properties.ReadOnly := True;
end;

procedure TfrmContentCommentDlg.WhenCancelForm;
begin
  inherited;
end;

end.

