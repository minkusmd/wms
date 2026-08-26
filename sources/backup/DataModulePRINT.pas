unit DataModulePRINT;

interface

uses
  SysUtils, Classes, frxClass, frxChBox, frxDesgn, frxDACComponents, frxIBDACComponents;

type
  TdmPrint = class(TDataModule)
    frxReport: TfrxReport;
    frxIBDACComponents: TfrxIBDACComponents;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrint: TdmPrint;

implementation

uses DataModuleDB;

{$R *.dfm}

end.
