unit frmChangeGoodsSuppliersUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel,
    cxTextEdit, cxMaskEdit, cxButtonEdit, DBAccess, IBC;

type
    TfrmChangeGoodsSupplier = class(TForm)
        beOldCustomer: TcxButtonEdit;
        beNewCustomer: TcxButtonEdit;
        cxLabel1: TcxLabel;
        cxLabel2: TcxLabel;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
        IBCTrLocal: TIBCTransaction;
        procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure beNewCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure cxButton1Click(Sender: TObject);
    private    { Private declarations }
    public
        procedure MergeGoodsSupplier(OldCustomerID, NewCustomerID: Integer);
    { Public declarations }
    end;

var
    frmChangeGoodsSupplier: TfrmChangeGoodsSupplier;


implementation

uses
    frmCustomersDlg, DataModuleDB;

{$R *.dfm}

procedure TfrmChangeGoodsSupplier.beNewCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    d: TfrmCustomersDlg;
begin
    d := TfrmCustomersDlg.Create(Self);
    try
        if (d.SelectCustomer(beNewCustomer.Tag)) then
        begin
            beNewCustomer.Tag := d.CustomerID;
            beNewCustomer.Text := d.CustomerTitle;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmChangeGoodsSupplier.cxButton1Click(Sender: TObject);
begin
    MergeGoodsSupplier(beOldCustomer.Tag, beNewCustomer.Tag);
end;

procedure TfrmChangeGoodsSupplier.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    d: TfrmCustomersDlg;
begin
    d := TfrmCustomersDlg.Create(Self);
    try
        if (d.SelectCustomer(beOldCustomer.Tag)) then
        begin
            beOldCustomer.Tag := d.CustomerID;
            beOldCustomer.Text := d.CustomerTitle;
        end;
    finally
        d.Free;
    end;
end;

procedure TfrmChangeGoodsSupplier.MergeGoodsSupplier(OldCustomerID, NewCustomerID: Integer);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        IBCTrLocal.DefaultConnection := dmdb.IBCConnection;
        q.Connection := dmdb.IBCConnection;
        q.SQL.Clear;
        q.sql.Add('update ts_goods_foreign');
        q.sql.Add('set customerid = :newcustomerid');
        q.sql.Add('where customerid = :oldcustomerid;');
        q.ParamByName('newcustomerid').AsInteger := NewCustomerID;
        q.ParamByName('oldcustomerid').AsInteger := OldCustomerID;
        q.AutoCommit := False;
        q.Transaction := IBCTrLocal;
        try
            if not IBCTrLocal.Active then
                IBCTrLocal.StartTransaction;

            q.Execute;

            IBCTrLocal.Commit;
            ModalResult := mrOk;
        except
            on E: Exception do
            begin
                IBCTrLocal.Rollback;
                ModalResult := mrNone;
                raise;
            end;

        end;
    finally
        q.Free;
    end;

end;

end.

