object frmPriceListImportDlg: TfrmPriceListImportDlg
  Left = 0
  Top = 0
  Caption = 'Import liste de preturi furnizori'
  ClientHeight = 682
  ClientWidth = 1392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  TextHeight = 13
  object dxWizardControl1: TdxWizardControl
    Left = 0
    Top = 0
    Width = 1392
    Height = 662
    Buttons.CustomButtons.Buttons = <>
    OnButtonClick = dxWizardControl1ButtonClick
    OnPageChanging = dxWizardControl1PageChanging
    object dxWizardControlPage1: TdxWizardControlPage
      Header.Description = 'Introducetiti lista de preturi'
      Header.Title = 'Import lista de preturi'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1370
        Height = 108
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 48
          Width = 24
          Height = 13
          Caption = 'Data'
        end
        object Label3: TLabel
          Left = 179
          Top = 49
          Width = 47
          Height = 13
          Caption = 'Mentiuni'
        end
        object cxDateEdit1: TcxDateEdit
          Left = 38
          Top = 43
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 135
        end
        object cxProgressBar1: TcxProgressBar
          Left = 8
          Top = 72
          ParentFont = False
          Properties.BarStyle = cxbsLEDs
          Properties.BeginColor = 54056
          Properties.ShowText = False
          Properties.ShowTextStyle = cxtsText
          TabOrder = 3
          Width = 1353
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1370
          Height = 28
          Align = dalTop
          BarManager = dxBarManager1
        end
        object teMentiuni: TcxTextEdit
          Left = 232
          Top = 43
          ParentFont = False
          TabOrder = 1
          Text = 'teMentiuni'
          Width = 1129
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 108
        Width = 1370
        Height = 418
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 0
        object dxSpreadSheet1: TdxSpreadSheet
          Left = 0
          Top = 32
          Width = 1370
          Height = 386
          Align = alClient
          Data = {
            9802000044585353763242461000000042465320000000000000000001000101
            010100000100000001004246532000000000424653200100000001000000200B
            00000007000000430061006C0069006200720069000000000000002000000020
            0000000020000000000020000000000020000000000020000007000000470045
            004E004500520041004C00000000000002000000000000000001424653200100
            0000424653201700000054006400780053007000720065006100640053006800
            6500650074005400610062006C00650056006900650077000600000053006800
            650065007400310001FFFFFFFFFFFFFFFF640000000200000002000000020000
            0055000000140000000200000002000000000200000002000000000000010000
            0000000101000042465320550000000000000042465320000000004246532014
            0000000000000042465320000000000000000000000000010000000000000000
            0000000000000000000000424653200000000002020000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000064000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000200020200020000000000000000000000000000000000020000000000
            0000000000000000000000000000000000000000000000000000000000000202
            0000000000000000424653200000000000000000000000000000000000000000
            0C00000053002E004D0069006E00630068006500760069006300690000000000
            000000000000000000000000C92F963C5A81E6400000000000000000}
        end
        object dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar
          AlignWithMargins = True
          Left = 0
          Top = 3
          Width = 1370
          Height = 21
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 8
          Align = alTop
          SpreadSheet = dxSpreadSheet1
          TabOrder = 0
          ExplicitWidth = 0
        end
      end
    end
    object dxWizardControlPage2: TdxWizardControlPage
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 662
    Width = 1392
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'MDL, USD, EUR'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object IBCTrWrite: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 752
    Top = 288
  end
  object IBCQueryImportedGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_pricelist_items where plid = :plid')
    Left = 720
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'plid'
        Value = nil
      end>
  end
  object IBCDataSourceImportedGoods: TIBCDataSource
    DataSet = IBCQueryImportedGoods
    Left = 568
    Top = 168
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 560
    Top = 312
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1164
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOpenFile'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSave'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCurrencies'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbOpenFile: TdxBarButton
      Caption = 'Open'
      Category = 0
      Hint = 'Open'
      Visible = ivAlways
      ImageIndex = 138
      OnClick = bbOpenFileClick
    end
    object bbSave: TdxBarButton
      Caption = 'Save'
      Category = 0
      Hint = 'Save'
      Visible = ivAlways
      ImageIndex = 139
      OnClick = bbSaveClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Identifica brandul'
      Category = 0
      Hint = 'Identifica brandul'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000014744558745469746C65004C6F6F6B75703B5365617263
        683B70F2E8420000028249444154785E8593CB6A54591486BF7DAA2A174D25DE
        12ED081D50B0031A958E56D490B24C40A21DBC0F049D093A141C758FA22FE050
        B01B44D05994C490406248BC94654C14235EE240B00421899234E45675CED937
        A98395106AE0827FB360ADFDF1AFB5D9616B2D4208001168650880426173CA45
        38DF78BDE7FD9010A104D6FE2C2F7561ADC062831C406BF5E49F33BB5B00BD04
        D08A447D4D94C4AE6A8CB1E84006AD73B2286383DC58C3BF83E98379774B8045
        57D2914C07FA5594454B2800F8BEE1E2D97A04501472880881830601DA08A405
        69C002B73BDF1400F07C85AF0C53B392907449263F30393983B1964D556B688A
        EF80E2554422215C4F173AC864FD60766F6E9EAEAE14FB63B51C3B1A4300AFC6
        3E71E7CE20274F34B2B66A1DD9AC0FC04A079E46FA9A64F22DB1BD7F106FAAA3
        BADC613A63F9B3A10E630C8F1E8FD1763C8EEB4A0031702DCEF20EA44229C397
        F414274E25D858E6E06B708039CFB02F564B77CF3046297CA90184F4D432C0F3
        0D9ECC15254A1B26160CC521F83AAB3180B5A0739795C6970600DFD34B00A454
        CC663495956B181919677BC36E3C69298A08D69738A4521FA82C5EC073B3FCB6
        B694C081AB573EE3FF19C5CEFA5AFABA930801B13DB54404BC4A7DA4AFF72997
        F74CF0FDE55D36449B0142BE2B57EEE0DBBC241289D27A3CCE48728CFEDE14D6
        1A2AEC0C17B6A5696D6964FCC51853E3F701CACEDF7ABBB83C8232643DCD8CAB
        A8282D656FF3014AC280D11825F9D87F83A79D0F69696BC0B8EFD0AD5BDADBFB
        3E5FC903B4EF661F3D1B7873C802D658AC006B098EDF3796B379EB69EE3DBF85
        F68638FCD72E4607C39780BFF30035FCDFB92340180ABFF42800384074BA66F5
        D5071DAF2FB821E726207F00836854BD33FCF2A90000000049454E44AE426082}
    end
    object bbCurrencies: TdxBarButton
      Caption = 'Valute'
      Category = 0
      Hint = 'Valuta RRP si valuta pretului de intrare'
      Visible = ivAlways
      ImageIndex = 49
      OnClick = bbCurrenciesClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Importa din JSON'
      Category = 0
      Hint = 'Importa din JSON'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
  end
  object IBCQueryCurrency: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_currency')
    Left = 368
    Top = 280
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 368
    Top = 200
  end
end
