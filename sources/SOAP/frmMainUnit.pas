unit frmMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Soap.InvokeRegistry, Vcl.StdCtrls, Soap.Rio, Soap.SOAPHTTPClient, b2b,
  System.Net.URLClient, Vcl.Menus, Vcl.ComCtrls, DBAccess, IBC, Data.DB;

type
  TForm1 = class(TForm)
    HTTPRIO1: THTTPRIO;
    Button1: TButton;
    edUUID: TEdit;
    lbTimer: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    File2: TMenuItem;
    IBCSQLNomenclature: TIBCSQL;
    IBCConnection1: TIBCConnection;
    IBCTrUpdate: TIBCTransaction;
    IBCTrSelect: TIBCTransaction;
    IBCSQL1: TIBCSQL;
    IBCSQLImages: TIBCSQL;
    IBCSQLDsc: TIBCSQL;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure File2Click(Sender: TObject);
  private
    procedure getData;
    procedure GetRates;
    { Private declarations }
  protected
    data: Ultra_B2B_Response;
    UUID: string;
    procedure GetPriceList;
  public
    procedure GetNomenclature;
    procedure UpdateTimer(msec: Integer);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.JSON, Xml.XMLDoc, Xml.XMLIntf, System.Diagnostics;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:
      GetNomenclature;
    5:
      GetPriceList;
    7:
      GetRates;
  end;
end;

procedure TForm1.File2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.getData;
var
  isready: Boolean;
  w: TStopwatch;
begin
  if (UUID = '') then begin
    UUID := (HTTPRIO1 as b2bPortType).requestData(ComboBox1.Text, True, '', False);
  end;
  edUUID.Text := UUID;
  isready := False;
  w := TStopwatch.Create;
  try
    w.Start;
    while not isready do begin
      isready := (HTTPRIO1 as b2bPortType).isready(UUID);
      UpdateTimer(Round(w.ElapsedMilliseconds / 1000));

    end;
    data := (HTTPRIO1 as b2bPortType).getDataByID(UUID);
    w.Stop;
  finally

  end;

end;

procedure TForm1.GetNomenclature;
var
  k2: Integer;
  nn: string;
  NomenclatureNode: IXMLNode;
  Response: string;
  rootNode: IXMLNode;
  xmlFile: TXMLDocument;
  xmlSource: string;
begin
  IBCConnection1.Connect;

// get Nomenclature
//  Memo1.Lines.Clear;
//  ListBox1.Items.Clear;

  getData;
  xmlSource := data.data;
  Response := data.message_;

  // develop only
//  Button2Click(nil);
//  xmlSource := Memo2.Lines.Text;
//  Response := 'OK';

  if (Response = 'OK') then begin
    xmlFile := TXMLDocument.Create(Application);

    // clear table tapi_ultra_comenclature
    IBCSQL1.transaction := IBCTrUpdate;
    if not IBCTrUpdate.Active then
      IBCTrUpdate.StartTransaction;
    try
      StatusBar1.SimpleText := 'clear tapi_ultra_nomenclature...';
      Application.ProcessMessages;
      IBCSQL1.sql.TExt := 'delete from tapi_ultra_nomenclature';
      IBCSQL1.execute;

      StatusBar1.SimpleText := 'clear tapi_ultra_images...';
      Application.ProcessMessages;
      IBCSQL1.sql.TExt := 'delete from tapi_ultra_images';
      IBCSQL1.execute;

      StatusBar1.SimpleText := 'clear tapi_ultra_dsc...';
      Application.ProcessMessages;
      IBCSQL1.sql.TExt := 'delete from tapi_ultra_dsc';
      IBCSQL1.execute;

      StatusBar1.SimpleText := 'Commiting...';
      Application.ProcessMessages;
      IBCTrUpdate.Commit;
    except
      raise;
    end;

    try
      xmlFile.LoadFromXML(xmlSource);
      xmlFile.Active := True;

      rootNode := xmlFile.DocumentElement;
      IBCSQLNomenclature.Transaction := IBCTrUpdate;

      if not IBCTrUpdate.Active then
        IBCTrUpdate.StartTransaction;

      IBCSQLNomenclature.Prepare;
      ProgressBar1.Min := 0;
      ProgressBar1.Max := rootNode.ChildNodes.Count - 1;

      for var i := 0 to rootNode.ChildNodes.Count - 1 do begin

        StatusBar1.SimpleText := format('Parse record [%d] of [%d]', [i, rootNode.ChildNodes.Count - 1]);
        ProgressBar1.Position := i;
        Application.ProcessMessages;

        NomenclatureNode := rootNode.ChildNodes[i];

        for var j := 0 to NomenclatureNode.ChildNodes.Count - 1 do begin
          nn := NomenclatureNode.ChildNodes[j].NodeName;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'UUID') then
            IBCSQLNomenclature.ParamByName('uuid').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'name') then
            IBCSQLNomenclature.ParamByName('name').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'parent') then
            IBCSQLNomenclature.ParamByName('parent').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'code') then
            IBCSQLNomenclature.ParamByName('code').AsString := VarToStr(NomenclatureNode.ChildNodes[j].NodeValue);
          if (NomenclatureNode.ChildNodes[j].NodeName = 'nomenclatureType') then
            IBCSQLNomenclature.ParamByName('nomenclatureType').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'mainImage') then
            IBCSQLNomenclature.ParamByName('mainImage').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'article') then
            IBCSQLNomenclature.ParamByName('article').AsString := VarToStr(NomenclatureNode.ChildNodes[j].NodeValue);
          if (NomenclatureNode.ChildNodes[j].NodeName = 'brand') then
            IBCSQLNomenclature.ParamByName('brand').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'fullName') then
            IBCSQLNomenclature.ParamByName('fullName').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'warranty') then
            IBCSQLNomenclature.ParamByName('warranty').AsString := NomenclatureNode.ChildNodes[j].NodeValue;

//          if (NomenclatureNode.ChildNodes[j].NodeName = 'name') then begin
////            Nomenclature.Name := NomenclatureNode.ChildNodes[j].NodeValue;
//            ListBox1.Items.Add(NomenclatureNode.ChildNodes[j].NodeValue);
//          end;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'imageList') then begin
            IBCSQLImages.Prepare;
            for var k := 0 to NomenclatureNode.ChildNodes[j].ChildNodes.Count - 1 do begin

              IBCSQLImages.ParamByName('goods_uuid').AsString := IBCSQLNomenclature.ParamByName('uuid').AsString;

              for k2 := 0 to  NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes.Count - 1 do begin

                if (NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeName = 'UUID') then
                  IBCSQLImages.ParamByName('uuid').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeValue);

                if (NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeName = 'name') then
                  IBCSQLImages.ParamByName('name').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeValue);

                if (NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeName = 'pathGlobal') then
                  IBCSQLImages.ParamByName('pathglobal').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeValue);

                if (NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeName = 'name') then
                  IBCSQLImages.ParamByName('name').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeValue);
              end;
            end;
          end;

          var dsc: string;
          if (NomenclatureNode.ChildNodes[j].NodeName = 'description') then begin
            dsc := vartostr(NomenclatureNode.ChildNodes[j].NodeValue);
            if dsc <> '' then begin
              IBCSQLDsc.Prepare;
              IBCSQLDsc.ParamByName('uuid').AsString := IBCSQLNomenclature.ParamByName('uuid').AsString;
              IBCSQLDsc.ParamByName('description').AsString := dsc;
            end;
          end;

        end;

        IBCSQLNomenclature.Execute;
//        ibctrupdate.Commit;
//        ibctrUpdate.StartTransaction;

        if (IBCSQLImages.ParamByName('pathglobal').AsString <> '') and
        (IBCSQLImages.ParamByName('uuid').AsString <> '')
        then  begin
          ibcsqlimages.Transaction := IBCTrUpdate;
          IBCSQLImages.Execute;
        end;

        if (IBCSQLDsc.ParamByName('description').AsString <> '') then begin
          IBCSQLDsc.Transaction := IBCTrUpdate;
          IBCSQLDsc.Execute;
        end;

        // commit all data
        IBCTrUpdate.Commit;

      end;

    finally
      xmlFile.Free;
    end;

//    // Production
//    (HTTPRIO1 as b2bPortType).CommitReceivingData(UUID);
  end
  else
    raise Exception.Create('Error Message: Can''t read data!');

  IBCConnection1.Disconnect;
  StatusBar1.SimpleText := 'Finished.';
end;

procedure TForm1.GetPriceList;
begin
  getData;
end;

procedure TForm1.GetRates;
var
  xmlFile: TXMLDocument;
  mainNode: IXMLNode;
  valuteNode: IXMLNode;
begin
//  Memo1.Lines.Clear;

  getData;

  if (Assigned(data)) and (data.message_ = 'OK') then begin
    xmlFile := TXMLDocument.Create(Application);
    try
      xmlFile.LoadFromXML(data.data);
      xmlFile.Active := True;

      mainNode := xmlFile.DocumentElement;

      for var i := 0 to mainNode.ChildNodes.Count - 1 do begin
        valuteNode := mainNode.ChildNodes[i].ChildNodes[0];
        for var j := 0 to valuteNode.ChildNodes.Count - 1 do begin
          if (valuteNode.ChildNodes[j].NodeName = 'code') and (valuteNode.ChildNodes[j].NodeValue = 840) then begin
//            ListBox1.Items.Add(mainNode.ChildNodes[i].ChildNodes[1].NodeValue);
            Break;
          end;
        end;
      end;

    finally
      xmlFile.Free;
    end;

    (HTTPRIO1 as b2bPortType).CommitReceivingData(UUID);
  end
  else
    raise Exception.Create('Error Message: Can''t read data!');
end;

procedure TForm1.UpdateTimer(msec: Integer);
begin
  lbTimer.Caption := msec.ToString;
  Application.ProcessMessages;
  sleep(1000);
end;

end.

