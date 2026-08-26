unit SWNCasaUnit;

interface
Uses Classes, SWNBaseUnit;


type

  TSWNCasa = class (TSWNBaseClass)
  private
    { private declarations }
  protected
    { protected declarations }
    fDocID:integer;
    procedure InitOutputValues;
  protected
    { protected declarations }
  public
    { public declarations }
    function New(const DocTypeID:integer):Boolean;
    function Modify:Boolean;

    // output
    property DocID:integer read fDocID write fDocID;
  end;

implementation

uses Controls, frmCasaDlg;


{ TSWNCasa }

procedure TSWNCasa.InitOutputValues;
begin
     fDocID:=-1;
end;

function TSWNCasa.Modify: Boolean;
var dialog:TfrmCasaDialog;
begin
     {
     Result:=False;
     dialog:=TfrmCasaDialog.Create(nil,fIBCConnection);
     try
        dialog.EditCurrentDoc(fDocID);
        Result:=dialog.ShowModal=mrOk;
     finally
        dialog.Free;
     end;
     }
end;

function TSWNCasa.New(const DocTypeID: integer): Boolean;
var dialog:TfrmCasaDialog;
begin
     {
     InitOutputValues;
     Result:=False;
     dialog:=TfrmCasaDialog.Create(nil,fIBCConnection);
     try
        dialog.NewDoc(DocTypeID);
        if dialog.ShowModal=mrOk then
        begin
             fDocID:=dialog.GetDocID;
             Result:=True;
        end;
     finally
        dialog.Free;
     end;
     }
end;

end.
