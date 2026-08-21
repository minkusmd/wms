unit frmMergeFiltersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  RzPanel, RzDlgBtn, swnBaseUnit, DBAccess, IBC, dxUIAClasses;

type
  TfrmMergeFiltersDlg = class(TSWNBaseFormClass)
    RzDialogButtons1: TRzDialogButtons;
    teOldFilterID: TcxTextEdit;
    cxLabel1: TcxLabel;
    teNewFilterID: TcxTextEdit;
    cxLabel2: TcxLabel;
    IBCTrLocal: TIBCTransaction;
  private
    { Private declarations }
  protected
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleDB;

{ TfrmMergeFilters }

function TfrmMergeFiltersDlg.IsFormDataPosted: boolean;
var
  q: TIBCQuery;
begin
  Result := False;
  q:=TIBCQUery.Create(nil);
  try
    q.SQL.Text := 'update ts_filter_params set filterid = :new_filterid where filterid = :old_filterid';
    q.Parambyname('old_filterid').AsInteger :=StrToInt(teOldFilterID.Text);
    q.parambyname('new_filterid').AsInteger := StrToInt(teNewFilterID.Text);
    q.Transaction := IBCTrLocal;
    try
      q.Execute;
      if ibctrLocal.Active then
        ibctrlocal.Commit;
    except on E: Exception do
      begin
        ibctrlocal.Rollback;
      end;
    end;



    Result := True;
  finally
    q.Free;
  end;
end;

end.
