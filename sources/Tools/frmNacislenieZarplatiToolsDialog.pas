unit frmNacislenieZarplatiToolsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmNacislenieZarplatiToolsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnClose: TButton;
    pcPageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    btnGen1: TButton;
    mmInfo1: TMemo;
    Label1: TLabel;
    dtpDate: TDateTimePicker;
    procedure btnGen1Click(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
  private
    { Private declarations }
    procedure NZ_VerifyMonth(const Date:TDateTime);
    procedure DoCreateDocsDB(const Date:TDateTime);

  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;

implementation

Uses IBC, DataModuleDB;

{$R *.dfm}

{ TfrmNacislenieZarplatiToolsDlg }

procedure TfrmNacislenieZarplatiToolsDlg.btnGen1Click(Sender: TObject);
begin
     DoCreateDocsDB(dtpDate.Date);
end;

procedure TfrmNacislenieZarplatiToolsDlg.DoCreateDocsDB(const Date:TDateTime);
var Query:TIBCQuery;
begin
     mmInfo1.Lines.Clear;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Add('SELECT CUSTOMERID, DISPLAYNAME FROM SP_FILL_NACISLENIE_ZARPLATA(:DATA)');
        Query.ParamByName('DATA').AsDate:=Date;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           while(Not Query.Eof) do
           begin
                mmInfo1.Lines.Add(Format('%d [%s] - готово!',[Query.Fields[0].AsInteger,Query.Fields[1].asString]));
                Query.Next;
           end;
           Query.Transaction.Commit;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                mmInfo1.Lines.Add(E.Message);
           end;
        end;
     finally
        Query.Free;
     end;
     mmInfo1.Lines.Add('Готово!');
end;

procedure TfrmNacislenieZarplatiToolsDlg.dtpDateChange(Sender: TObject);
begin
     NZ_VerifyMonth(dtpDate.Date);
end;

procedure TfrmNacislenieZarplatiToolsDlg.NZ_VerifyMonth(const Date:TDateTime);
var Query:TIBCQuery;
    total,bad:integer;
begin
     mmInfo1.Lines.Clear;
     mmInfo1.Lines.Add(FormatDateTime('MMMM yyyy',Date));
     total:=0;
     bad:=0;
     Query:=TIBCQuery.Create(Self);
     try
        try
           Query.Connection:=dmDB.IBCConnection;
           Query.SQL.Add('SELECT CUSTOMERID, DISPLAYNAME,');
           Query.SQL.Add('IIF(EXISTS(SELECT DOCID');
           Query.SQL.Add('FROM TDB_DOCS');
           Query.SQL.Add('WHERE DOCTYPEID=1514 AND');
           Query.SQL.Add('DT=A.CUSTOMERID AND');
           Query.SQL.Add('EXTRACT(MONTH FROM DATA) = EXTRACT(MONTH FROM CAST(:DATA AS DATE)) AND');
           Query.SQL.Add('EXTRACT(YEAR FROM DATA) = EXTRACT(YEAR FROM CAST(:DATA AS DATE))');
           Query.SQL.Add('),1,0)');
           Query.SQL.Add('FROM GET_FIRMS_BY_USER2 A');
           Query.ParamByName('DATA').AsDate:=Date;
           Query.ExecSQL;

           while Not Query.Eof do
           begin
                inc(total);
                if (Query.Fields[2].AsInteger=1) then
                begin
                     inc(bad);
                     mmInfo1.Lines.Add(Format('%d [%s] - есть документ на зарплату!',[Query.Fields[0].AsInteger,Query.Fields[1].asString]));
                end;

                Query.Next;
           end;

        except
      end;
     finally
        Query.Free;
     end;
     if (total>=0) and (bad=0) then
     begin
          mmInfo1.Lines.Add('Нет документов Начисление зарплаты!');
          btnGen1.Enabled:=True;
     end
     else
         if (total>0) and (bad=total) then btnGen1.Enabled:=False;

end;

procedure TfrmNacislenieZarplatiToolsDlg.Prepare;
begin
     dtpDate.Date:=Now;
     NZ_VerifyMonth(dtpDate.Date);
end;

end.
