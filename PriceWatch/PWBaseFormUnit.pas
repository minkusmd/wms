unit PWBaseFormUnit;

{ WMSPriceWatch - forma de baza, dupa modelul TSWNCustomForm din SWNBaseUnit (WMS):
  aceiasi pasi de viata (Prepare la deschidere, IsFormDataPosted la OK, WhenCancelForm
  la Renunta), acelasi font (Segoe UI 9), Esc inchide, Enter nu inchide din grid.

  SWNBaseUnit nu se poate folosi direct: trage dupa el DataModuleDB si practic
  toate cele ~840 de unitati ale WMS. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.Graphics,
  IBC;

type
  TPWCustomForm = class(TForm)
  private
    FOldOnCloseQuery: TCloseQueryEvent;
    FPrepared: Boolean;
    procedure WhenFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WhenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    // deschiderea seturilor de date / pornirea tranzactiei; o data, la prima afisare
    procedure Prepare; virtual;
    // la OK: validare + Post + Commit; False = forma nu se inchide
    function IsFormDataPosted: Boolean; virtual;
    // la Renunta / Esc / X: Cancel + Rollback
    procedure WhenCancelForm; virtual;
    procedure SetupFont;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ShowModal: Integer; override;
  end;

  // forma cu conexiunea primita de la apelant (ca TSWNBaseFormClass)
  TPWBaseFormClass = class(TPWCustomForm)
  protected
    FIBCConnection: TIBCConnection;
    procedure BindingDataSource; virtual;
  public
    constructor Create(AOwner: TComponent; AIBCConnection: TIBCConnection); reintroduce; virtual;
    property IBCConnection: TIBCConnection read FIBCConnection;
  end;

implementation

{ TPWCustomForm }

constructor TPWCustomForm.Create(AOwner: TComponent);
begin
  inherited;
  FOldOnCloseQuery := OnCloseQuery;
  OnCloseQuery := WhenFormCloseQuery;
  KeyPreview := True;
  OnKeyDown := WhenKeyDown;
  Position := poMainFormCenter;
  SetupFont;
end;

procedure TPWCustomForm.SetupFont;
begin
  Font.Name := 'Segoe UI';
  Font.Size := 9;
end;

procedure TPWCustomForm.DoShow;
begin
  inherited;
  if not FPrepared then
  begin
    FPrepared := True;
    Prepare;
  end;
end;

procedure TPWCustomForm.Prepare;
begin
  // in descendent
end;

function TPWCustomForm.IsFormDataPosted: Boolean;
begin
  Result := True;
end;

procedure TPWCustomForm.WhenCancelForm;
begin
  // in descendent
end;

function TPWCustomForm.ShowModal: Integer;
begin
  Result := inherited ShowModal;
end;

procedure TPWCustomForm.WhenFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if Assigned(FOldOnCloseQuery) then
    FOldOnCloseQuery(Sender, CanClose);
  if not CanClose then
    Exit;
  if fsModal in FormState then
  begin
    if ModalResult = mrOk then
      CanClose := IsFormDataPosted
    else
      WhenCancelForm;
  end;
end;

procedure TPWCustomForm.WhenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (fsModal in FormState) then
  begin
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

{ TPWBaseFormClass }

constructor TPWBaseFormClass.Create(AOwner: TComponent; AIBCConnection: TIBCConnection);
begin
  inherited Create(AOwner);
  FIBCConnection := AIBCConnection;
  BindingDataSource;
end;

procedure TPWBaseFormClass.BindingDataSource;
begin
  // in descendent: leaga seturile de date de FIBCConnection
end;

end.
