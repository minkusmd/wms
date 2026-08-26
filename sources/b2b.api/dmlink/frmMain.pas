unit frmMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    B2B.DMlink, Vcl.StdCtrls, B2B.DMLinkClient, B2B.DMLink.Thread;

const
    C_eMail = 'duca.al@gmail.com';
    C_Password = 'Uno2025!@';

type
    TForm12 = class(TForm)
        edtSKU: TEdit;
        Button1: TButton;
        memoResults: TMemo;
        procedure Button1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
    private
    { Private declarations }
//  FB2BDMlink : TB2BDMlink;
        FClient: TB2BDMLinkClient;
        FToken: string;
        procedure Log(const Msg: string);
        procedure HandleLoginComplete(const AResult: TB2BThreadResult);
        procedure OnLoginDone(const AResult: TB2BThreadResult);
        procedure OnProductDone(const AResult: TB2BThreadResult);
    public
    { Public declarations }
        destructor Destroy; override;
    end;

var
    Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.HandleLoginComplete(const AResult: TB2BThreadResult);
begin
    ShowMessage(AResult.Token);  // Acum funcționează!
end;

destructor TForm12.Destroy;
begin
    if Assigned(FClient) then
        FClient.Free;

    inherited;
end;

procedure TForm12.Button1Click(Sender: TObject);
var
    T: TB2BThread;
begin
    memoResults.Lines.Add('Getting product: ' + edtSKU.Text + '...');

  // Create thread and setup
    T := TB2BThread.Create('B2BDMlinkDLL.dll');
    T.SetupLogin(C_eMail, C_Password, OnLoginDone);
//  T.SetupGetProduct(edtSKU.Text, OnProductDone);
    T.Start;
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
    memoResults.Clear;
    FClient := nil;

  // Set default values
//  edtEmail.Text := 'duca.al@gmail.com';
//  edtPassword.Text := 'Uno2025!@';
//  edtSKU.Text := 'VT75';

    try
        Log('Loading DLL...');
        FClient := TB2BDMLinkClient.Create('B2BDMlinkDLL.dll');
        Log('DLL loaded successfully');

        if FClient.Initialize then
            Log('API initialized successfully')
        else
        begin
            Log('Failed to initialize API: ' + FClient.LastError);
            FreeAndNil(FClient);
        end;
    except
        on E: Exception do
        begin
            Log('Error loading DLL: ' + E.Message);
            FreeAndNil(FClient);
            ShowMessage('Failed to load B2BDMlinkDLL.dll. Make sure it is in the same folder as the application.');
        end;
    end;
end;

procedure TForm12.Log(const Msg: string);
begin
    memoResults.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' - ' + Msg);
end;

procedure TForm12.OnLoginDone(const AResult: TB2BThreadResult);
var
  T: TB2BThread;
begin
  if AResult.Success then
  begin
    // Login succeeded
    FToken := AResult.Token;
    memoResults.Lines.Add('✓ Login successful!');
    memoResults.Lines.Add('Token: ' + FToken);
    memoResults.Lines.Add('');
    memoResults.Lines.Add('Now getting product: ' + edtSKU.Text + '...');

    // Step 2: Start GetProduct thread immediately
    T := TB2BThread.Create('B2BDMlinkDLL.dll');
    T.SetupGetProduct(edtSKU.Text, OnProductDone);
    T.Start;
  end
  else
  begin
    // Login failed - stop here
    memoResults.Lines.Add('✗ Login failed: ' + AResult.ErrorMsg);
    memoResults.Lines.Add('━━━━━━━━━━━━━━━━━━━━━━━━━━');
//    btnLoginAndGetProduct.Enabled := True;
    ShowMessage('Login failed: ' + AResult.ErrorMsg);
  end;
end;

procedure TForm12.OnProductDone(const AResult: TB2BThreadResult);
var
    P: TB2BProductInfo;
begin
  // Check result
    if AResult.Success then
    begin
    // Product found
        P := AResult.ProductInfo;

        memoResults.Lines.Add('✓ Product found!');
        memoResults.Lines.Add('━━━━━━━━━━━━━━━━━━━━━━━━━━');
        memoResults.Lines.Add('ID: ' + string(P.ID));
        memoResults.Lines.Add('Name: ' + string(P.Name));
        memoResults.Lines.Add('SKU: ' + string(P.SKU));
        memoResults.Lines.Add('EAN: ' + string(P.EAN));
        memoResults.Lines.Add('Brand: ' + string(P.BrandName));
        memoResults.Lines.Add('Category: ' + string(P.CategoryName));
        memoResults.Lines.Add('');
        memoResults.Lines.Add('Retail Price: ' + FormatFloat('#,##0.00', P.RPrice) + ' MDL');
        memoResults.Lines.Add('Sale Price: ' + FormatFloat('#,##0.00', P.SPrice) + ' MDL');
        memoResults.Lines.Add('Net Price: ' + FormatFloat('#,##0.00', P.NPrice) + ' MDL');
        memoResults.Lines.Add('');
        memoResults.Lines.Add('Stock: ' + IntToStr(P.Stock));
        memoResults.Lines.Add('Transit: ' + IntToStr(P.Transit));
        memoResults.Lines.Add('Warranty: ' + IntToStr(P.WarrantyPeriod) + ' months');

        if string(P.Description) <> '' then
        begin
            memoResults.Lines.Add('');
            memoResults.Lines.Add('Description:');
            memoResults.Lines.Add(string(P.Description));
        end;

        memoResults.Lines.Add('━━━━━━━━━━━━━━━━━━━━━━━━━━');
        memoResults.Lines.Add('');

        ShowMessage(Format('Product: %s'#13#10'Price: %.2f MDL'#13#10'Stock: %d', [string(P.Name), P.NPrice, P.Stock]));
    end
    else
    begin
    // Product not found or error
        memoResults.Lines.Add('✗ Error getting product!');
        memoResults.Lines.Add('Error: ' + AResult.ErrorMsg);
        memoResults.Lines.Add('');

        ShowMessage('Error: ' + AResult.ErrorMsg);
    end;
end;

end.

