object frmImportGoodsByTitlesDlg: TfrmImportGoodsByTitlesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import produse noi'
  ClientHeight = 569
  ClientWidth = 1178
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1178
    Height = 64
    Title = 'Import produse noi'
    Text = 'Importul produselor cu denumire, si preturi'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Arial'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -11
    FontText.Name = 'Arial'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 22
  end
  object Notebook: TNotebook
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1162
    Height = 436
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    PageIndex = 3
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = 'Welcome'
      object pnWelcome: TPanel
        Left = 0
        Top = 0
        Width = 1162
        Height = 436
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label5: TLabel
          Left = 44
          Top = 36
          Width = 223
          Height = 19
          Caption = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1085#1072#1079#1074#1072#1085#1080#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 44
          Top = 72
          Width = 428
          Height = 64
          Caption = 
            #1044#1083#1103' '#1080#1084#1087#1086#1088#1090#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1085#1072#1079#1074#1072#1085#1080#1081', '#1090#1088#1077#1073#1091#1077#1090#1089#1103' '#1087#1088#1086#1081#1090#1080' '#1089#1083#1077#1076#1091#1102#1097#1080#1077' '#1096#1072#1075#1080 +
            ':'#13'1. '#1042#1099#1073#1086#1088' '#1085#1072#1079#1074#1072#1085#1080#1081' '#1076#1083#1103' '#1073#1091#1076#1091#1097#1080#1093' '#1090#1086#1074#1072#1088#1086#1074' ('#1082#1086#1076', '#1085#1072#1079#1074#1072#1085#1080#1077', '#1094#1077#1085#1099'),'#13'2' +
            '. '#1042#1099#1073#1086#1088' '#1090#1080#1087#1086#1074#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1076#1083#1103' '#1073#1091#1076#1091#1097#1080#1093' '#1090#1086#1074#1072#1088#1086#1074','#13'3. '#1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1099#1093' ' +
            #1090#1086#1074#1072#1088#1086#1074'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 40
          Top = 340
          Width = 276
          Height = 15
          Caption = #1053#1072#1078#1084#1080#1090#1077' '#1085#1072' '#1082#1085#1086#1087#1082#1091' '#1057#1083#1077#1076' >> '#1076#1083#1103' '#1087#1088#1086#1076#1086#1083#1078#1077#1085#1080#1103'...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Step1'
      object pnStep1: TPanel
        Left = 0
        Top = 0
        Width = 1162
        Height = 436
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1158
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxSpreadSheet: TdxSpreadSheet
          Left = 0
          Top = 53
          Width = 1158
          Height = 379
          Align = alClient
          OptionsView.ShowFormulas = True
          Data = {
            8002000044585353763242461000000042465320000000000000000001010101
            010100000000000001004246532000000000424653200100000001000000200B
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
            0000000000000000000000000000000000000000000000000000000000000000
            00000000}
        end
        object dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar
          Left = 0
          Top = 30
          Width = 1158
          Height = 23
          Align = alTop
          SpreadSheet = cxSpreadSheet
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Step2'
      object pnClient: TPanel
        Left = 0
        Top = 0
        Width = 1162
        Height = 436
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          Left = 17
          Top = 140
          Width = 200
          Height = 15
          Caption = 'Mapa, unde vor fi adaugate produsele'
        end
        object Label2: TLabel
          Left = 158
          Top = 199
          Width = 59
          Height = 15
          Caption = 'Producator'
        end
        object Label3: TLabel
          Left = 128
          Top = 244
          Width = 89
          Height = 15
          Caption = 'Valuta indicativ 7'
        end
        object Label4: TLabel
          Left = 153
          Top = 343
          Width = 64
          Height = 15
          Caption = 'Tip evidenta'
        end
        object cxLabel19: TLabel
          Left = 136
          Top = 289
          Width = 81
          Height = 15
          Caption = 'Unitate metrica'
          Transparent = True
        end
        object cxLabel20: TLabel
          Left = 173
          Top = 318
          Width = 44
          Height = 15
          Caption = 'Garantie'
          Transparent = True
        end
        object Label8: TLabel
          Left = 69
          Top = 60
          Width = 148
          Height = 15
          Caption = 'Total produse pentru import'
        end
        object Label9: TLabel
          Left = 128
          Top = 110
          Width = 89
          Height = 15
          Caption = 'Furnizor produse'
        end
        object Label12: TLabel
          Left = 134
          Top = 169
          Width = 83
          Height = 15
          Caption = 'Web Tip produs'
        end
        object Label13: TLabel
          Left = 596
          Top = 243
          Width = 58
          Height = 15
          Caption = 'Valuta Calc'
        end
        object Label14: TLabel
          Left = 161
          Top = 375
          Width = 56
          Height = 15
          Caption = 'Tip produs'
        end
        object Label15: TLabel
          Left = 753
          Top = 243
          Width = 56
          Height = 15
          Caption = 'Valuta RRP'
        end
        object Label16: TLabel
          Left = 465
          Top = 243
          Width = 41
          Height = 15
          Caption = 'Valuta 5'
        end
        object Label17: TLabel
          Left = 333
          Top = 243
          Width = 41
          Height = 15
          Caption = 'Valuta 6'
        end
        object beGoodsFolder: TcxButtonEdit
          Left = 227
          Top = 136
          ParentFont = False
          Properties.AutoSelect = False
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                424D360400000000000036000000280000001000000010000000010020000000
                000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
                FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
                61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
                49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
                7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
                7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
                7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
                78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
                98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
                78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
                96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
                76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
                96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
                74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
                96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
                74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
                96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
                6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
                95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
                6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
                94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
                6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
                94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
                6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
                94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
                5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
                91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
                63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
                40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
              Kind = bkGlyph
            end>
          Properties.ClickKey = 115
          Properties.IncrementalSearch = False
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beGoodsFolderPropertiesButtonClick
          TabOrder = 3
          Text = 'beGoodsFolder'
          Width = 281
        end
        object lcbVENDOR: TcxLookupComboBox
          Left = 228
          Top = 195
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.KeyFieldNames = 'VENDORID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceVendors
          EditValue = 0
          TabOrder = 7
          Width = 281
        end
        object lcbCURRENCY7: TcxLookupComboBox
          Left = 228
          Top = 240
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceCurrency
          EditValue = 0
          TabOrder = 11
          Width = 69
        end
        object lcbSERIALTYPE: TcxLookupComboBox
          Left = 228
          Top = 343
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'GOODSSERIALTYPEID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceGST
          TabOrder = 15
          Width = 277
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1158
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object edGoodsCount: TcxTextEdit
          Left = 228
          Top = 57
          TabStop = False
          ParentFont = False
          Properties.ReadOnly = True
          TabOrder = 1
          Text = 'edGoodsCount'
          Width = 121
        end
        object lcbUM: TcxLookupComboBox
          Left = 229
          Top = 285
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'UMID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceUM
          EditValue = 0
          TabOrder = 13
          Width = 132
        end
        object cbWARRANTY: TcxComboBox
          Left = 228
          Top = 314
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.Items.Strings = (
            '0'
            '1'
            '3'
            '6'
            '9'
            '12'
            '24'
            '36'
            '60')
          TabOrder = 14
          Width = 185
        end
        object beCustomerID: TcxButtonEdit
          Left = 226
          Top = 106
          ParentFont = False
          Properties.AutoSelect = False
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                424D360400000000000036000000280000001000000010000000010020000000
                000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
                FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
                61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
                49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
                7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
                7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
                7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
                98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
                78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
                98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
                78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
                96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
                76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
                96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
                74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
                96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
                74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
                96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
                6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
                95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
                6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
                94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
                6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
                94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
                6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
                94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
                5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
                91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
                63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
                40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
              Kind = bkGlyph
            end>
          Properties.ClickKey = 115
          Properties.IncrementalSearch = False
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beCustomerIDPropertiesButtonClick
          TabOrder = 2
          Text = 'beCustomerID'
          Width = 281
        end
        object lcbGoodsType: TcxLookupComboBox
          Left = 228
          Top = 166
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.DropDownWidth = 400
          Properties.KeyFieldNames = 'GOODSTYPEID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end
            item
              FieldName = 'TITLE_RUS'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListOptions.SyncMode = True
          Properties.ListSource = IBCDataSourceWebGoodsType
          EditValue = 0
          TabOrder = 5
          Width = 281
        end
        object lcbCURRENCY4: TcxLookupComboBox
          Left = 660
          Top = 238
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceCurrency
          EditValue = 0
          TabOrder = 9
          Width = 69
        end
        object lcbTipProdus: TcxLookupComboBox
          Left = 228
          Top = 372
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.DropDownWidth = 400
          Properties.KeyFieldNames = 'SYSSID'
          Properties.ListColumns = <
            item
              Caption = 'Cod'
              HeaderAlignment = taCenter
              FieldName = 'SYSSID'
            end
            item
              Caption = 'Denumire'
              HeaderAlignment = taCenter
              Width = 250
              FieldName = 'TITLE'
            end>
          Properties.ListFieldIndex = 1
          Properties.ListOptions.ShowHeader = False
          Properties.ListOptions.SyncMode = True
          Properties.ListSource = IBCDataSourceTipProdus
          EditValue = 0
          TabOrder = 16
          Width = 277
        end
        object cxButton1: TcxButton
          Left = 512
          Top = 165
          Width = 25
          Height = 25
          Caption = '+'
          TabOrder = 4
          OnClick = cxButton1Click
        end
        object cxButton2: TcxButton
          Left = 512
          Top = 192
          Width = 25
          Height = 25
          Caption = '+'
          TabOrder = 6
          OnClick = cxButton2Click
        end
        object lcbCURRENCY3: TcxLookupComboBox
          Left = 820
          Top = 238
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceCurrency
          EditValue = 0
          TabOrder = 10
          Width = 61
        end
        object lcbCURRENCY5: TcxLookupComboBox
          Left = 516
          Top = 238
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceCurrency
          EditValue = 0
          TabOrder = 8
          Width = 69
        end
        object lcbCURRENCY6: TcxLookupComboBox
          Left = 382
          Top = 240
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = IBCDataSourceCurrency
          EditValue = 0
          TabOrder = 12
          Width = 61
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Progress'
      object pnProgress: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1156
        Height = 430
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object dxBarDockControl3: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1152
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object mmLog: TMemo
          Left = 0
          Top = 30
          Width = 1152
          Height = 396
          Align = alClient
          Lines.Strings = (
            ''
            '')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Finish'
      object pnFinish: TPanel
        Left = 0
        Top = 0
        Width = 1162
        Height = 436
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        object Label10: TLabel
          Left = 44
          Top = 72
          Width = 242
          Height = 20
          Caption = #1053#1086#1074#1099#1077' '#1090#1086#1074#1072#1088#1099' '#1091#1089#1087#1077#1096#1085#1086' '#1089#1086#1079#1076#1072#1085#1085#1099'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 44
          Top = 36
          Width = 59
          Height = 23
          Caption = #1043#1086#1090#1086#1074#1086'!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lbTotalGoods: TLabel
          Left = 44
          Top = 112
          Width = 8
          Height = 20
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object pnButtons: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 524
    Width = 1162
    Height = 29
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 16
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object btnClose: TcxButton
      AlignWithMargins = True
      Left = 1056
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object btnPrev: TcxButton
      AlignWithMargins = True
      Left = 836
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = '<< Precedent'
      TabOrder = 0
      OnClick = btnPrevClick
    end
    object btnNext: TcxButton
      AlignWithMargins = True
      Left = 934
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 32
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Urmator >>'
      TabOrder = 1
      OnClick = btnNextClick
    end
  end
  object dxBarManager: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 532
    Top = 16
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 938
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbLoadFromFile'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbOptions'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCheckForeignCode'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 235
          Visible = True
          ItemName = 'beCustomer'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 938
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 938
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic3'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCreateGoods'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarStatic1: TdxBarStatic
      Caption = 
        '1. Importa denumirile si codurile produselor pentru a fi importa' +
        'te'
      Category = 0
      Hint = 
        '1. Importa denumirile si codurile produselor pentru a fi importa' +
        'te'
      Visible = ivAlways
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton1Click
    end
    object dxBarStatic2: TdxBarStatic
      Caption = '2. Selectarea valorilor comune pentru produsele importate'
      Category = 0
      Hint = '2. Selectarea valorilor comune pentru produsele importate'
      Visible = ivAlways
      Height = 24
    end
    object dxBarStatic3: TdxBarStatic
      Caption = '3.Crearea produselor'
      Category = 0
      Hint = '3.Crearea produselor'
      Visible = ivAlways
    end
    object bbCreateGoods: TdxBarButton
      Caption = 'Creaza produsele'
      Category = 0
      Hint = 'Creaza produsele'
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbCreateGoodsClick
    end
    object bbLoadFromFile: TdxBarButton
      Caption = 'File'
      Category = 0
      Hint = 'File'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbLoadFromFileClick
    end
    object bbOptions: TdxBarSubItem
      Align = iaRight
      Caption = 'Optiuni'
      Category = 0
      Visible = ivAlways
      ImageIndex = 25
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          Visible = True
          ItemName = 'bbHasColumnTitles'
        end>
    end
    object bbHasColumnTitles: TdxBarButton
      Caption = 'Denumirea colonitelor'
      Category = 0
      Hint = 'Denumirea colonitelor'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Sterge'
      Category = 0
      Visible = ivAlways
      ImageIndex = 35
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbDeleteRow'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    object bbDeleteRow: TdxBarButton
      Caption = 'Sterge un produs'
      Category = 0
      Hint = 'Sterge un produs'
      Visible = ivAlways
      ShortCut = 16430
      OnClick = bbDeleteRowClick
    end
    object bbCheckForeignCode: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Hint = 'Valideaza'
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbCheckForeignCodeClick
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Importa din lista de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPaste_Foxtrot'
        end
        item
          Visible = True
          ItemName = 'bbPaste_NIPPON'
        end>
    end
    object bbPaste_Foxtrot: TdxBarButton
      Caption = #1060#1054#1050#1057#1058#1056#1054#1058
      Category = 0
      Hint = #1060#1054#1050#1057#1058#1056#1054#1058
      Visible = ivAlways
      OnClick = bbPaste_FoxtrotClick
    end
    object bbPaste_NIPPON: TdxBarButton
      Caption = 'NIPPON'
      Category = 0
      Hint = 'NIPPON'
      Visible = ivAlways
      OnClick = bbPaste_NIPPONClick
    end
    object dxBarEdit1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object beCustomer: TcxBarEditItem
      Caption = 'Furnizor'
      Category = 0
      Hint = 'Furnizor'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxBarEditItem1PropertiesButtonClick
    end
  end
  object IBCDataSourceUM: TIBCDataSource
    DataSet = IBCQueryUM
    Left = 784
    Top = 176
  end
  object IBCQueryUM: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    UMID,'
      '    TITLE'
      'FROM'
      '    TS_UM'
      'WHERE'
      ' UMID<>-1')
    Left = 784
    Top = 124
  end
  object IBCQueryGST: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    goodsserialtypeid,'
      '    TITLE'
      'FROM'
      '    GET_GOODS_SERIAL_TYPES')
    Left = 676
    Top = 124
  end
  object IBCDataSourceGST: TIBCDataSource
    DataSet = IBCQueryGST
    Left = 676
    Top = 176
  end
  object IBCDataSourceVendors: TIBCDataSource
    DataSet = IBCQueryVendors
    Left = 784
    Top = 300
  end
  object IBCQueryVendors: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    VENDORID,'
      '    TITLE,'
      '    URL'
      'FROM'
      '    GET_VENDORS')
    Left = 784
    Top = 248
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 664
    Top = 300
  end
  object IBCQueryCurrency: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    CURRENCYID,'
      '    TITLE'
      'FROM'
      '    TS_CURRENCY')
    Left = 664
    Top = 248
  end
  object IBCDataSourceWebGoodsType: TIBCDataSource
    DataSet = IBCQueryWebGoodsType
    Left = 552
    Top = 400
  end
  object IBCQueryWebGoodsType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' GOODSTYPEID,'
      ' TITLE,'
      ' TITLE_RUS'
      'FROM'
      ' TS_GOODS_TYPE'
      'WHERE'
      ' GOODSTYPEID<>-1')
    Left = 552
    Top = 356
  end
  object IBCQueryTipProdus: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid=6')
    Left = 856
    Top = 416
  end
  object IBCDataSourceTipProdus: TIBCDataSource
    DataSet = IBCQueryTipProdus
    Left = 752
    Top = 416
  end
end
