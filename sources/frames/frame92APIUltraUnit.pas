unit frame92APIUltraUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox,
    cxCurrencyEdit, cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
    cxGridCustomView, cxGrid, cxSplitter, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS,
    cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
    dxBarBuiltInMenu, dxDateRanges, dxSpreadSheetReportDesignerActions, dxSpreadSheetConditionalFormattingRulesActions,
    dxSpreadSheetActions, dxPrinting, System.Actions, Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, cxImageList,
    dxScrollbarAnnotations, Soap.InvokeRegistry, System.Net.URLClient, Soap.Rio, Soap.SOAPHTTPClient, Vcl.ComCtrls,
    Vcl.StdCtrls, b2b, dxUIAClasses, System.JSON, Xml.XMLDoc, Xml.XMLIntf, System.Diagnostics, Datasnap.DBClient, Vcl.Grids,
    Vcl.DBGrids, Vcl.Menus, cxButtons, cxContainer;

type
    Tframe92APIUltra = class(TSWNBaseFrame)
        lbTimer: TLabel;
        Label2: TLabel;
        Button1: TButton;
        edUUID: TEdit;
        ComboBox1: TComboBox;
        StatusBar1: TStatusBar;
        ProgressBar1: TProgressBar;
        HTTPRIO1: THTTPRIO;
        IBCSQLNomenclature: TIBCSQL;
        IBCTrUpdate: TIBCTransaction;
        IBCTrSelect: TIBCTransaction;
        IBCSQL1: TIBCSQL;
        IBCSQLImages: TIBCSQL;
        IBCSQLDsc: TIBCSQL;
        ListBox1: TListBox;
        Label1: TLabel;
        IBCSQLPRICELIST: TIBCSQL;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1Level1: TcxGridLevel;
        cxGrid1: TcxGrid;
        IBCQuery1: TIBCQuery;
        IBCDataSource1: TIBCDataSource;
        cxGrid1DBTableView1CODE: TcxGridDBColumn;
        cxGrid1DBTableView1FULLNAME: TcxGridDBColumn;
        cxGrid1DBTableView1PRICE: TcxGridDBColumn;
        Button2: TButton;
        Button3: TButton;
    lbOperation: TcxLabel;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
    private
        procedure getData(Param: string);
        procedure GetNomenclature;
        procedure GetPriceList;
        procedure GetRates;
        procedure UpdateTimer(msec: Integer);
        procedure AddNomenclatureToDb;
    protected
    { Protected declarations }
        data: Ultra_B2B_Response;
        UUID: string;

        procedure AddPricelistToDb;
        procedure AddToPricelistTable(UUID, Price, PriceTypeName: string);
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure GetBrands;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure GetNomenclatureTypes;
        procedure ModifyRecord; override;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;
        procedure SetupSecurityItems; override;
    public
    { Public declarations }
        procedure SetupDefaultFocus; override;
    end;

implementation

{$R *.dfm}

uses
    SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, DataModuleAdditions,
    frm52ZamenaTovaraEditorDialog, frm54InventarizatiaDocDialog, SWNValueStorageUnit, frmGoods, frmSelectGoodsToAddDialog,
    System.Threading;

procedure Tframe92APIUltra.AddToPricelistTable(UUID, Price, PriceTypeName: string);
begin
    IBCSQLPRICELIST.ParamByName('UUID').AsString := UUID;
    IBCSQLPRICELIST.ParamByName('PRICE').AsString := Price;
    IBCSQLPRICELIST.ParamByName('PRICETYPE').AsString := PriceTypeName;
    IBCSQLPRICELIST.Execute;
end;

procedure Tframe92APIUltra.Button1Click(Sender: TObject);
begin
    case ComboBox1.ItemIndex of
        0:
            begin
                GetNomenclature;
                GetPriceList;
                MessageDlg('Finisat!', TMsgDlgType.mtInformation, [mbok], 0);
            end;
        1:
            begin
                GetNomenclature;
//                AddNomenclatureToDb;
            end;
        3:
            begin
                GetNomenclatureTypes;
            end;
        4:
            begin
                GetBrands;
            end;
        6:
            begin
                GetPriceList;
//                AddPricelistToDb;
            end;
        8:
            GetRates;
    end;
end;

procedure Tframe92APIUltra.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged

     // 2. De deconectat sursele de date de la griduri
    inherited;
end;

procedure Tframe92APIUltra.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele

     // 2. Selection handlers

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne

     // 4. Selection update
end;

procedure Tframe92APIUltra.GetBrands;
var
    k2: Integer;
    nn: string;
    NomenclatureNode: IXMLNode;
    Response: string;
    rootNode: IXMLNode;
    LxmlFile: TXMLDocument;
    xmlSource: string;
begin
// get Nomenclature

    getData('BRAND');
    xmlSource := data.data;

    Response := data.message_;

  // develop only
    if (Response = 'OK') then
    begin
        try
            LxmlFile := TXMLDocument.Create(Application);
            LxmlFile.LoadFromXML(xmlSource);
            LxmlFile.SaveToFile('Ultra-BRANDS.XML');
        finally
            FreeAndNil(LxmlFile);
        end;
    end
    else
        raise Exception.Create('Error Message: Can''t read data!');

    StatusBar1.SimpleText := 'Finished.';
end;

function Tframe92APIUltra.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsNONE];
end;

function Tframe92APIUltra.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe92APIUltra.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];

end;

function Tframe92APIUltra.InitFrameID: Integer;
begin
     // API Ultra
    Result := 92
end;

procedure Tframe92APIUltra.ModifyRecord;
begin

end;

procedure Tframe92APIUltra.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe92APIUltra.RefreshData;
begin
    inherited;
end;

procedure Tframe92APIUltra.SaveFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe92APIUltra.SetupDefaultFocus;
begin
     // grid

     // columns
end;

procedure Tframe92APIUltra.SetupSecurityItems;
begin

end;

procedure Tframe92APIUltra.getData(Param: string);
var
    isready: Boolean;
    w: TStopwatch;
begin
    UUID := (HTTPRIO1 as b2bPortType).requestData(Param, true, '', False);
    edUUID.Text := UUID;
    isready := False;
    w.Start;
    try
        while not isready do
        begin
            isready := (HTTPRIO1 as b2bPortType).isready(UUID);
            UpdateTimer(w.ElapsedMilliseconds);
            Application.ProcessMessages;
        end;

        try
            data := (HTTPRIO1 as b2bPortType).getDataByID(UUID);
        except
            on e: Exception do raise Exception.CreateFmt('Error retrieving data: %s', [e.Message]);
        end;
        (HTTPRIO1 as b2bPortType).CommitReceivingData(UUID);
        isready := true;
    finally

    end;
end;

procedure Tframe92APIUltra.AddNomenclatureToDb;
var
    cnt2: Integer;
    imageCount: Integer;
    k2: Integer;
    nn: string;
    NomenclatureNode: IXMLNode;
    Response: string;
    rootNode: IXMLNode;
    LXMLFile: TXMLDocument;
    name2: string;
begin
    StatusBar1.SimpleText := 'Loading XML file...';
    LXMLFile := TXMLDocument.Create(Application);
    try
        LXMLFile.LoadFromFile('Ultra-NOMENLATURE.XML');
        LXMLFile.Active := True;

    {$REGION 'clear data from tables'}
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
            on e: Exception do
            begin
        // Log and re-raise the exception with more context
                raise Exception.CreateFmt('Error retrieving data: %s', [e.Message]);
            end;
        end;
    {$endregion}

        rootNode := LXMLFile.DocumentElement;
        IBCSQLNomenclature.AutoCommit := true;

        // set update transaction
        IBCSQLNomenclature.Transaction := IBCTrUpdate;
        IBCSQLDsc.Transaction := IBCTrUpdate;
        IBCSQLImages.Transaction := IBCTrUpdate;

//        if not IBCTrUpdate.Active then
//            IBCTrUpdate.StartTransaction;

        IBCSQLNomenclature.Prepare;
        ProgressBar1.Min := 0;
        ProgressBar1.Max := rootNode.ChildNodes.Count - 1;

        for var i := 0 to rootNode.ChildNodes.Count - 1 do
        begin

            StatusBar1.SimpleText := format('Parse record [%d] of [%d]', [i, rootNode.ChildNodes.Count - 1]);
            ProgressBar1.Position := i;
            Application.ProcessMessages;

            NomenclatureNode := rootNode.ChildNodes[i];

            for var j := 0 to NomenclatureNode.ChildNodes.Count - 1 do
            begin
                nn := NomenclatureNode.ChildNodes[j].NodeName;
                if (nn = 'UUID') then
                begin
                    IBCSQLNomenclature.ParamByName('uuid').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'name') then
                begin
                    IBCSQLNomenclature.ParamByName('name').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'parent') then
                begin
                    IBCSQLNomenclature.ParamByName('parent').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'code') then
                begin
                    IBCSQLNomenclature.ParamByName('code').AsString := VarToStr(NomenclatureNode.ChildNodes[j].NodeValue);
                    continue;
                end;
                if (nn = 'nomenclatureType') then
                begin
                    IBCSQLNomenclature.ParamByName('nomenclatureType').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'mainImage') then
                begin
                    IBCSQLNomenclature.ParamByName('mainImage').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'article') then
                begin
                    IBCSQLNomenclature.ParamByName('article').AsString := VarToStr(NomenclatureNode.ChildNodes[j].NodeValue);
                    continue;
                end;
                if (nn = 'brand') then
                begin
                    IBCSQLNomenclature.ParamByName('brand').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'fullName') then
                begin
                    IBCSQLNomenclature.ParamByName('fullName').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'warranty') then
                begin
                    IBCSQLNomenclature.ParamByName('warranty').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (nn = 'active') then
                begin
                    IBCSQLNomenclature.ParamByName('isactive').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;

                if (nn = 'imageList') then
                begin
                    IBCSQLImages.Prepare;
                    imageCount := NomenclatureNode.ChildNodes[j].ChildNodes.Count;
                    for var k := 0 to imageCount - 1 do
                    begin

                        IBCSQLImages.ParamByName('goods_uuid').AsString := IBCSQLNomenclature.ParamByName('uuid').AsString;
                        cnt2 := NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes.Count;
                        for k2 := 0 to cnt2 - 1 do
                        begin
                            name2 := NomenclatureNode.ChildNodes[j].ChildNodes[k].ChildNodes[k2].NodeName;
                            if (name2 = 'UUID') then
                            begin
                                IBCSQLImages.ParamByName('uuid').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes
                                    [k].ChildNodes[k2].NodeValue);
                                Continue;
                            end
                            else
                            if (name2 = 'name') then
                            begin
                                IBCSQLImages.ParamByName('name').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes
                                    [k].ChildNodes[k2].NodeValue);
                                continue;
                            end
                            else
                            if (name2 = 'pathGlobal') then
                            begin
                                IBCSQLImages.ParamByName('pathglobal').AsString := VarToStr(NomenclatureNode.ChildNodes[j].ChildNodes
                                    [k].ChildNodes[k2].NodeValue);
                                continue;
                            end;
                        end;
                        if (IBCSQLImages.ParamByName('pathglobal').AsString <> '') and (IBCSQLImages.ParamByName('uuid').AsString
                            <> '') then
                        begin
                            IBCSQLImages.Execute;
                        end;
                    end;
                end;
//
                var dsc: string;
                if (NomenclatureNode.ChildNodes[j].NodeName = 'description') then
                begin
                    dsc := StringReplace(VarToStr(NomenclatureNode.ChildNodes[j].NodeValue), '$A', '$A$D', []);
                    if dsc <> '' then
                    begin
                        IBCSQLDsc.Prepare;
                        IBCSQLDsc.ParamByName('uuid').AsString := IBCSQLNomenclature.ParamByName('uuid').AsString;
                        IBCSQLDsc.ParamByName('DESCRIPTION').AsString := dsc;
                        IBCSQLDsc.Execute;
                    end;
                end;
            end;

            IBCSQLNomenclature.Execute;
//            FreeAndNil(NomenclatureNode);
        end;

//    // commit all data
//        if IBCTrUpdate.Active then
//        begin
//            IBCTrUpdate.Commit;
//        end;
    finally
        FreeAndNil(LXMLFile);
    end;
end;

procedure Tframe92APIUltra.AddPricelistToDb;
var
    LxmlFile: TXMLDocument;
    xmlSource: string;
    Response: string;
    NomenclatureNode: IXMLNode;
    rootNode: IXMLNode;
    N: string;
    Price: string;
    PriceTypeName: string;
begin
    if not IBCTrUpdate.Active then
        IBCTrUpdate.StartTransaction;

    var ibcsql := TIBCSQL.Create(nil);
    try
        ibcsql.Transaction := IBCTrUpdate;
        if not ibcsql.Transaction.Active then
            ibctrUpdate.StartTransaction;

        ibcsql.SQL.Text := 'delete from tapi_ultra_pricelist';
        ibcsql.Execute;

        if ibcsql.Transaction.Active then
            ibcsql.Transaction.Commit;
    finally
        ibcsql.Free;
    end;

    LxmlFile := TXMLDocument.Create(self);

    try
        LxmlFile.LoadFromFile('ultra_pricelist.xml');
        LxmlFile.Active := True;

        rootNode := LxmlFile.DocumentElement;
        ProgressBar1.Position := 0;
        ProgressBar1.Min := 0;
        ProgressBar1.Max := rootNode.ChildNodes.Count - 1;

        for var i := 0 to rootNode.ChildNodes.Count - 1 do
        begin
            StatusBar1.SimpleText := format('Parse record [%d] of [%d]', [i, rootNode.ChildNodes.Count - 1]);
            ProgressBar1.Position := i;
            Application.ProcessMessages;

            NomenclatureNode := rootNode.ChildNodes[i];

            for var j := 0 to NomenclatureNode.ChildNodes.Count - 1 do
            begin
                N := NomenclatureNode.ChildNodes[j].NodeName;
                if (NomenclatureNode.ChildNodes[j].NodeName = 'UUID') then
                begin
                    UUID := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
//            IBCSQLNomenclature.ParamByName('uuid').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                if (NomenclatureNode.ChildNodes[j].NodeName = 'Price') then
                begin
                    Price := NomenclatureNode.ChildNodes[j].NodeValue;
                    continue;
                end;
                if (NomenclatureNode.ChildNodes[j].NodeName = 'priceType') then
                begin

                    for var k := 0 to NomenclatureNode.ChildNodes[j].ChildNodes.Count - 1 do
                    begin
                        if NomenclatureNode.ChildNodes[j].ChildNodes[k].NodeName = 'name' then
                        begin
                            PriceTypeName := NomenclatureNode.ChildNodes[j].ChildNodes[k].NodeValue;
                            continue;
                        end;
                    end;
                    continue;
                end;
//                FreeAndNil(NomenclatureNode);
            end;
            if PriceTypeName = 'S' then
                AddToPricelistTable(UUID, Price, PriceTypeName);
        end;

        if IBCTrUpdate.Active then
            IBCTrUpdate.Commit;
    finally
        FreeAndNil(LxmlFile);
    end;
end;

procedure Tframe92APIUltra.Button2Click(Sender: TObject);
var
    w: TStopwatch;
begin
    w := TStopwatch.Create;
    w.Start;
//    lbOperation.Caption := 'Parse Nomenclature.xml';
//    application.processMessages;
//    AddNomenclatureToDb;
//    lbOperation.Caption := 'Parse Pricelist.xml';
//    application.processMessages;
//    AddPricelistToDb;
case ComboBox1.ItemIndex of
        0:
            begin
            end;
        1:
            begin
                lbOperation.Caption := 'Parse Nomenclature.xml';
                AddNomenclatureToDb;
                MessageDlg('Finisat!', TMsgDlgType.mtInformation, [mbok], 0);
            end;
        3:
            begin

            end;
        4:
            begin

            end;
        6:
            begin
                lbOperation.Caption := 'Parse Pricelist.xml';
                AddPricelistToDb;
                MessageDlg('Finisat!', TMsgDlgType.mtInformation, [mbok], 0);
            end;
    end;
    w.Stop;
    Beep;

    StatusBar1.SimpleText := 'Done! ' + Round(w.ElapsedMilliseconds / 1000).ToString + ' sec';
end;

procedure Tframe92APIUltra.Button3Click(Sender: TObject);
begin
//        TTask.Run(
//        procedure
//        begin
//            try
                dmdb.ExecuteQuery('execute procedure update_priceS_ultra', []);
//
//                TThread.Synchronize(nil,
//                      procedure
//                      begin
//                        // Code to run on the main thread
                        MessageDlg('Pretul S a fost cu succes modificat in baza de date!', mtInformation, [mbOK], 0);
//                      end);
//            except
//                raise;
//            end;
//        end);

        IBCQuery1.Close;
        ibcquery1.Open;

end;

procedure Tframe92APIUltra.GetNomenclature;
var
    k2: Integer;
    nn: string;
    NomenclatureNode: IXMLNode;
    Response: string;
    rootNode: IXMLNode;
    xmlSource: string;
begin
    getData('NOMENCLATURE');

    xmlSource := data.data;
    Response := data.message_;

    if (Response = 'OK') then
    begin
        var LxmlFile := TXMLDocument.Create(Application);
        try
            LxmlFile.LoadFromXML(xmlSource);
            LxmlFile.SaveToFile('Ultra-NOMENLATURE.XML');
        finally
            FreeAndNil(LxmlFile);
        end;
    end;

    StatusBar1.SimpleText := 'Finished NOMENCLATURE';
end;

procedure Tframe92APIUltra.GetNomenclatureTypes;
var
    LxmlFile: TXMLDocument;
    xmlSource: string;
    Response: string;
    NomenclatureNode: IXMLNode;
    rootNode: IXMLNode;
    N: string;
    Price: string;
    PriceTypeName: string;
begin
    getData('NOMENCLATURETYPELIST');
    xmlSource := data.data;
    Response := data.message_;
    if (Response = 'OK') then
    begin
        LxmlFile := TXMLDocument.Create(Application);
        LxmlFile.LoadFromXML(xmlSource);
        LxmlFile.SaveToFile('ultra_NOMENCLATURETYPELIST.xml');

        if not IBCTrUpdate.Active then
            IBCTrUpdate.StartTransaction;

        var ibcsql := TIBCSQL.Create(nil);
        try
            ibcsql.Transaction := IBCTrUpdate;
            if not ibcsql.Transaction.Active then
                ibctrUpdate.StartTransaction;

            ibcsql.SQL.Text := 'delete from tapi_ultra_pricelist';
            ibcsql.Execute;

            if ibcsql.Transaction.Active then
                ibcsql.Transaction.Commit;
        finally
            ibcsql.Free;
        end;

        try
            LxmlFile.Active := True;
            rootNode := LxmlFile.DocumentElement;

            for var i := 0 to rootNode.ChildNodes.Count - 1 do
            begin
                StatusBar1.SimpleText := format('Parse record [%d] of [%d]', [i, rootNode.ChildNodes.Count - 1]);
                ProgressBar1.Position := i;
                Application.ProcessMessages;

                NomenclatureNode := rootNode.ChildNodes[i];

                for var j := 0 to NomenclatureNode.ChildNodes.Count - 1 do
                begin
                    N := NomenclatureNode.ChildNodes[j].NodeName;
                    if (NomenclatureNode.ChildNodes[j].NodeName = 'UUID') then
                    begin
                        UUID := NomenclatureNode.ChildNodes[j].NodeValue;
                        continue;
                    end;
//            IBCSQLNomenclature.ParamByName('uuid').AsString := NomenclatureNode.ChildNodes[j].NodeValue;
                    if (NomenclatureNode.ChildNodes[j].NodeName = 'Price') then
                    begin
                        Price := NomenclatureNode.ChildNodes[j].NodeValue;
                        continue;
                    end;
                    if (NomenclatureNode.ChildNodes[j].NodeName = 'priceType') then
                    begin

                        for var k := 0 to NomenclatureNode.ChildNodes[j].ChildNodes.Count - 1 do
                        begin
                            if NomenclatureNode.ChildNodes[j].ChildNodes[k].NodeName = 'name' then
                            begin
                                PriceTypeName := NomenclatureNode.ChildNodes[j].ChildNodes[k].NodeValue;
                                continue;
                            end;
                        end;
                        continue;
                    end;
                end;

                if PriceTypeName = 'S' then
                    AddToPricelistTable(UUID, Price, PriceTypeName);
                if PriceTypeName = 'D' then
                    AddToPricelistTable(UUID, Price, PriceTypeName);
                if PriceTypeName = 'Online' then
                    AddToPricelistTable(UUID, Price, PriceTypeName);

            end;

            if IBCTrUpdate.Active then
                IBCTrUpdate.Commit;
        finally
            FreeAndNil(LxmlFile);
        end;
    end;
end;

procedure Tframe92APIUltra.GetPriceList;
var
    LxmlFile: TXMLDocument;
    xmlSource: string;
    Response: string;
    NomenclatureNode: IXMLNode;
    rootNode: IXMLNode;
    N: string;
    Price: string;
    PriceTypeName: string;
begin
    getData('PRICELIST');
    xmlSource := data.data;
    Response := data.message_;
    if (Response = 'OK') then
    begin
        LxmlFile := TXMLDocument.Create(Application);
        try
            LxmlFile.LoadFromXML(xmlSource);
//      xmlFile.Active := True;
            LxmlFile.SaveToFile('ultra_pricelist.xml');
        finally
            FreeAndNil(LxmlFile);
        end;

        StatusBar1.SimpleText := 'Finished PRICELSIT';
    end;
end;

procedure Tframe92APIUltra.GetRates;
var
    LxmlFile: TXMLDocument;
    mainNode: IXMLNode;
    valuteNode: IXMLNode;
begin
    ListBox1.Items.Clear;

    getData('RATES');

    if (Assigned(data)) and (data.message_ = 'OK') then
    begin
        LxmlFile := TXMLDocument.Create(Application);
        try
            LxmlFile.LoadFromXML(data.data);
            LxmlFile.SaveToFile('rates.xml');

//      ClientDataSet1.Close;
//      ClientDataSet1.LoadFromFile('rates.xml');
//      ClientDataSet1.Open;
            LxmlFile.Active := True;

            mainNode := LxmlFile.DocumentElement;

            for var i := 0 to mainNode.ChildNodes.Count - 1 do
            begin
                valuteNode := mainNode.ChildNodes[i].ChildNodes[0];
                for var j := 0 to valuteNode.ChildNodes.Count - 1 do
                begin
                    if (valuteNode.ChildNodes[j].NodeName = 'code') and (valuteNode.ChildNodes[j].NodeValue = 840) then
                    begin
                        ListBox1.Items.Add(mainNode.ChildNodes[i].ChildNodes[1].NodeValue);
                        Break;
                    end;
                end;
            end;
        finally
            FreeAndNil(LxmlFile);
        end;
    end
    else
        raise Exception.Create('Error Message: Can''t read data!');
end;

procedure Tframe92APIUltra.UpdateTimer(msec: Integer);
begin
    lbTimer.Caption := msec.ToString;
    Application.ProcessMessages;
    sleep(900);
end;

end.

