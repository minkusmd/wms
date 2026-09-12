unit frmApplyPromoCodeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle, dxGDIPlusClasses;

type
  TfrmApplyPromoCodeDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    edCode: TEdit;
    btnCheck: TButton;
    Label1: TLabel;
    mmInfo: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnCheckClick(Sender: TObject);
  private
    { Private declarations }
    fIsCodeValid:Boolean;
    fPromoCode:String;

    function CheckPromoCode(const PromoCode:String):Boolean;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property PromoCode:String read fPromoCode;
  end;


implementation

uses DataModuleAdditions, SWNUtils, IBC, DataModuleDB;

{$R *.dfm}

{ TfrmApplyPromoCodeDlg }


procedure TfrmApplyPromoCodeDlg.btnCheckClick(Sender: TObject);
begin
     if Trim(edCode.Text)='' then
     begin
          ShowErrorDialog('Eroare','Introduceti promo cod!');
          Exit;
     end;

     if CheckPromoCode(Trim(edCode.Text)) then
     begin
          fIsCodeValid:=True;

          mmInfo.Lines.Add('Promo-cod valid!');
          mmInfo.Lines.Add('Puteţi utiliza acest promo-cod.');
          mmInfo.Lines.Add('În "Rezerva" va apărea o poziţie nouă cu valoarea reducerii.');

          fPromoCode:=Trim(edCode.Text);
          btnOk.Enabled:=True;
          btnOk.SetFocus;
     end;
end;

function TfrmApplyPromoCodeDlg.CheckPromoCode(const PromoCode: String): Boolean;
var Query:TIBCQuery;
begin
     Result:=True;

     mmInfo.Lines.BeginUpdate;
     mmInfo.Lines.Clear;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT ERROR FROM SP_VERIFY_PROMO_CODE(:code)';
        Query.ParamByName('code').AsString:=PromoCode;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             Result:=False;
             mmInfo.Lines.Add(Query.Fields[0].AsString);
             Query.Next;
        end;
     finally
        Query.Free;
        mmInfo.Lines.EndUpdate;
     end;
end;

function TfrmApplyPromoCodeDlg.IsFormDataPosted: Boolean;
begin
     Result:=fIsCodeValid;
end;

procedure TfrmApplyPromoCodeDlg.Prepare;
begin
     fIsCodeValid:=False;
     fPromoCode:='';
     btnOk.Enabled:=False;
     mmInfo.Lines.Clear;
end;

end.
