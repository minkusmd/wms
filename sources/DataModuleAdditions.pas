unit DataModuleAdditions;

interface

uses
    SysUtils, Classes, ImgList, Controls, cxGraphics, cxStyles, cxClasses, System.ImageList, cxImageList, Vcl.Forms;

type
    TdmAdditions = class(TDataModule)
        cxImageList_SWN: TcxImageList;
        cxMainStyleRepository: TcxStyleRepository;
        cxStyle_Goods_InfoHeader: TcxStyle;
        cxStyle_Goods_GeneralHeader: TcxStyle;
        cxStyle_Goods_Price2: TcxStyle;
        cxStyle_Goods_Price3Club: TcxStyle;
        cxStyle_Goods_Currency: TcxStyle;
        cxImageList_MainTabs: TcxImageList;
        cxStyle_GoodsOutOfStock: TcxStyle;
        cxStyle_Bold: TcxStyle;
        cxStyle_GirdContentInactive: TcxStyle;
        cxStyle_GridContentEven: TcxStyle;
        cxStyle_GridColumnBOLD: TcxStyle;
        cxStyle_GridGroup: TcxStyle;
        cxStyle_MoneyCounter_Total: TcxStyle;
        cxStyle_GridHeader: TcxStyle;
        cxStyle_FirmaName: TcxStyle;
        cxStyle_PriceGroup: TcxStyle;
        cxStyle_SerialDisabled: TcxStyle;
        cxStyle_BackgroundRED: TcxStyle;
        cxStyle_BoldYellowBack: TcxStyle;
        cxImageList_DialogIcons: TcxImageList;
        cxStyle_DocTypeFlag: TcxStyle;
        cxStyle_FilterButton: TcxStyle;
        cxStyle_ПеремешениеДокДА: TcxStyle;
        cxStyle_ПеремешениеДокНЕТ: TcxStyle;
        cxStyle_ПеремешениеПринято: TcxStyle;
        cxStyle_ПеремешениеНЕпринято: TcxStyle;
        cxStyle_ПеремешениеДокЗакрыт: TcxStyle;
        cxStyle_ПеремешениеДокПринят: TcxStyle;
        cxStyle_TextBoldRed: TcxStyle;
        cxStyle_TextBoldGreen: TcxStyle;
        cxStyle_MarginGroup: TcxStyle;
        cxStyle_TextGray: TcxStyle;
        cxStyle_Italic: TcxStyle;
        cxStyle_TextColorRed: TcxStyle;
        cxStyle_TextColorGreen: TcxStyle;
        cxStyle_PriceGroup67: TcxStyle;
        cxStyle_ParamGroup: TcxStyle;
        cxStyle_EventGrid: TcxStyle;
        cxStyle_CalcProfit_Red: TcxStyle;
        cxStyle_CalcProfitYellow: TcxStyle;
        cxStyle_CalcProfitGreen: TcxStyle;
        cxStyle_TextGrayStrike: TcxStyle;
        cxStyle_TextTeal: TcxStyle;
        cxStyle_FilterGroupAutoG: TcxStyle;
        cxStyle_FilterGroupDelimiters: TcxStyle;
        cxStyle_Link: TcxStyle;
        cxStyle_TextColorDarkYellow: TcxStyle;
        cxStyle_SCSelection: TcxStyle;
        cxStyle_ServiceFont: TcxStyle;
        cxStyle_CustomerDebtsDatorie: TcxStyle;
        cxStyle_CustomerDebtsNoiDatoram: TcxStyle;
        cxStyle_TreeContentInactive: TcxStyle;
        cxStyle_DocInSpector_CurrDoc: TcxStyle;
        cxStyle_DocInSpector_Parent: TcxStyle;
        cxStyle_GridPriceColumnRed: TcxStyle;
        cxStyle_GoodsActiune: TcxStyle;
        cxStyle_SN: TcxStyle;
        cxStyle_ChatUser: TcxStyle;
        cxStyle_ChatSelection: TcxStyle;
        cxStyle_ChatText: TcxStyle;
        cxStyle_ChatGroupInactive: TcxStyle;
        cxStyle_ChatGroupSelected: TcxStyle;
        cxStyle_ChatUnread: TcxStyle;
        cxStyle1_ExpiredRecord: TcxStyle;
        cxStyle_MINQTY: TcxStyle;
        cxSmallImageListStructure: TcxImageList;
        cxLargeImageListStructure: TcxImageList;
        ilFlags: TcxImageList;
        cxImageDocs: TcxImageList;
        cxImagesJurnal: TcxImageList;
        cxImageList1: TcxImageList;
        ilGoodsProperties: TcxImageList;
        cxStyle1: TcxStyle;
        cxStyle2: TcxStyle;
    ilStates: TcxImageList;
    private    { Private declarations }
        highDPIImageListContainer: TImageList;
    public    { Public declarations }
        procedure SetupStyleFont;
    end;

var
    dmAdditions: TdmAdditions;


implementation

uses
    Vcl.Graphics, SWNConst, SWNValueStorageUnit, Winapi.Windows, Winapi.CommCtrl;

{$R *.dfm}

procedure TdmAdditions.SetupStyleFont;
var
    i: integer;
    Style: TcxStyle;
    fn: string;
    fs: integer;
begin
    with cFontSizeItems[AppUserConfigStorage.IntValues.GetValue('FontSize', cAppDefaultFontIndex)] do
    begin
        fn := FontName;
        fs := FontSize;
    end;

    for i := 0 to cxMainStyleRepository.Count - 1 do
    begin
        Style := TcxStyle(cxMainStyleRepository.Items[i]);
        if Style.Tag = 1 then // marked for Font change
        begin
            Style.Font.Name := fn;
            Style.Font.Size := fs;
      // Style.AssignedValues:=Style.AssignedValues+[svFont];
        end;
    end;
end;

end.

