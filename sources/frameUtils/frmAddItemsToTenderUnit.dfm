object frmAddItemsToTender: TfrmAddItemsToTender
  Left = 0
  Top = 0
  ActiveControl = beGoods
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 504
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    578
    504)
  PixelsPerInch = 96
  TextHeight = 15
  object tcxdblookupcombo: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 562
    Height = 444
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 3
    ExplicitTop = 12
    object cxLabel1: TLabel
      Left = 68
      Top = 10
      Width = 37
      Height = 15
      Caption = 'Produs'
      FocusControl = beGoods
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 10
      Width = 22
      Height = 15
      Caption = 'Cod'
      Transparent = True
    end
    object lbCPV: TLabel
      Left = 12
      Top = 61
      Width = 22
      Height = 15
      Caption = 'CPV'
      Transparent = True
    end
    object Label3: TLabel
      Left = 93
      Top = 63
      Width = 102
      Height = 15
      Caption = 'Denumirea bunului'
      Transparent = True
    end
    object Label4: TLabel
      Left = 8
      Top = 112
      Width = 85
      Height = 15
      Caption = 'Specificatia FDA'
      Transparent = True
    end
    object Label5: TLabel
      Left = 375
      Top = 111
      Width = 77
      Height = 15
      Caption = 'Tara de origine'
      Transparent = True
    end
    object Label6: TLabel
      Left = 8
      Top = 159
      Width = 59
      Height = 15
      Caption = 'Producator'
      Transparent = True
    end
    object Label8: TLabel
      Left = 375
      Top = 159
      Width = 44
      Height = 15
      Caption = 'Standart'
      Transparent = True
    end
    object pcPageControl: TcxPageControl
      Left = 8
      Top = 224
      Width = 541
      Height = 209
      Focusable = False
      TabOrder = 8
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 1
      Properties.TabPosition = tpBottom
      OnPageChanging = pcPageControlPageChanging
      ClientRectBottom = 183
      ClientRectLeft = 4
      ClientRectRight = 537
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Caption = 'Generale'
        ImageIndex = 0
        object lbQTY: TLabel
          Left = 12
          Top = 18
          Width = 48
          Height = 15
          Caption = 'Cantitate'
          Transparent = True
        end
        object lbPrice: TLabel
          Left = 12
          Top = 47
          Width = 21
          Height = 15
          Caption = 'Pret'
          Transparent = True
        end
        object lbSUMA: TLabel
          Left = 12
          Top = 76
          Width = 30
          Height = 15
          Caption = 'Suma'
          Transparent = True
        end
        object lbWARRANTY: TLabel
          Left = 12
          Top = 105
          Width = 44
          Height = 15
          Caption = 'Garantie'
          Transparent = True
        end
        object Label2: TLabel
          Left = 12
          Top = 134
          Width = 20
          Height = 15
          Caption = 'TVA'
          Transparent = True
        end
        object cbFLG_ACNT: TcxDBCheckBox
          Left = 356
          Top = 118
          Caption = 'Cntb'
          DataBinding.DataField = 'FLG_ACNT'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 7
        end
        object cbFLG_ACTIVE: TcxDBCheckBox
          Left = 356
          Top = 95
          Caption = 'Pozitie activa'
          DataBinding.DataField = 'FLG_ACTIVE'
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 5
        end
        object cbWARRANTY: TcxDBComboBox
          Left = 92
          Top = 102
          DataBinding.DataField = 'WARANTY'
          Properties.Alignment.Horz = taLeftJustify
          Properties.Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '6'
            '9'
            '12'
            '18'
            '24'
            '36'
            '60')
          TabOrder = 6
          Width = 97
        end
        object lbCURRENCY_NAME: TcxDBLabel
          Left = 188
          Top = 45
          DataBinding.DataField = 'CURRENCY_NAME'
          DataBinding.DataSource = dmDB.IBCDataSourceDocs
          Visible = False
          Height = 21
          Width = 29
        end
        object edPRICE: TcxDBCalcEdit
          Left = 92
          Top = 44
          DataBinding.DataField = 'PRICE'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.OnEditValueChanged = cePRICEPropertiesEditValueChanged
          TabOrder = 2
          Width = 97
        end
        object edSUMA: TcxDBCalcEdit
          Left = 92
          Top = 73
          DataBinding.DataField = 'SUMA'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.OnEditValueChanged = ceSUMAPropertiesEditValueChanged
          TabOrder = 4
          Width = 97
        end
        object edQTY: TcxDBCalcEdit
          Left = 92
          Top = 15
          DataBinding.DataField = 'QTY'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.Precision = 2
          Properties.OnEditValueChanged = ceQTYPropertiesEditValueChanged
          TabOrder = 0
          Width = 97
        end
        object cbVAT: TcxDBCalcEdit
          Left = 92
          Top = 131
          DataBinding.DataField = 'SUMAVAT'
          TabOrder = 8
          Width = 97
        end
        object cxButton1: TcxButton
          Left = 223
          Top = 40
          Width = 106
          Height = 25
          Caption = 'Grila de preturi'
          DropDownMenu = dxBarPopupMenu1
          Kind = cxbkOfficeDropDown
          TabOrder = 1
          TabStop = False
          Visible = False
        end
      end
    end
    object beGoods: TcxButtonEdit
      Left = 64
      Top = 28
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
        end
        item
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C0000000B744558745469746C65005A6F6F6D3BCF09FEBC000000
            A449444154785EA5D2C10984301484616F426A7AF73461115BC1C2369093772B
            1272F36A031690537690811D1E44B244F879A0E62368A65AEB50376066ECBE12
            CAA87026647CFE082CE840D5C7FBCB1360B278431105CE4D106B014916CF4877
            360B925A402610D1A4008B04720B2804827F81502050867730FA0D7641FFFB0B
            EC12A0FB1CF8DE04BA4FE28E2E8F28D0CAE31F87ACDD00A747CE2E8088B6A213
            BD7EC0405F9BEBFFA1F53765600000000049454E44AE426082}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.LookupItems.Strings = (
        'test'
        'qqq'
        'www')
      Properties.ReadOnly = False
      Properties.OnButtonClick = beGoodsPropertiesButtonClick
      TabOrder = 1
      Text = 'beGoods'
      OnDblClick = beGoodsDblClick
      Width = 486
    end
    object edGOODSID: TcxDBTextEdit
      Left = 9
      Top = 28
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 49
    end
    object teCPV: TcxDBTextEdit
      Left = 8
      Top = 81
      DataBinding.DataField = 'CPV'
      TabOrder = 2
      Width = 73
    end
    object teDenBun: TcxDBTextEdit
      Left = 93
      Top = 81
      DataBinding.DataField = 'DENUMIREA_BUNULUI'
      TabOrder = 3
      Width = 457
    end
    object teFDA: TcxDBTextEdit
      Left = 8
      Top = 129
      DataBinding.DataField = 'FDA_SPECIFICATION'
      TabOrder = 4
      Width = 361
    end
    object teCountry: TcxDBTextEdit
      Left = 375
      Top = 129
      DataBinding.DataField = 'COUNTRY_NAME'
      TabOrder = 5
      Width = 175
    end
    object teManufacturer: TcxDBTextEdit
      Left = 8
      Top = 177
      DataBinding.DataField = 'MANUFACTURER'
      TabOrder = 6
      Width = 361
    end
    object teStandart: TcxDBTextEdit
      Left = 375
      Top = 177
      DataBinding.DataField = 'STANDART'
      TabOrder = 7
      Width = 174
    end
  end
  object btnOk: TcxButton
    Left = 369
    Top = 467
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 465
    Top = 467
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 287
    Top = 192
    PixelsPerInch = 96
    object bb1: TdxBarButton
      Tag = 1
      Caption = '&1'
      Category = 0
      Hint = '1'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb2: TdxBarButton
      Tag = 2
      Caption = '&2'
      Category = 0
      Hint = '2'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb3: TdxBarButton
      Tag = 3
      Caption = '&3'
      Category = 0
      Hint = '3'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb4: TdxBarButton
      Tag = 4
      Caption = '&4'
      Category = 0
      Hint = '4'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb5: TdxBarButton
      Tag = 5
      Caption = '&5'
      Category = 0
      Hint = '5'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb6: TdxBarButton
      Tag = 6
      Caption = '&6'
      Category = 0
      Hint = '6'
      Visible = ivAlways
      OnClick = bb1Click
    end
    object bb7: TdxBarButton
      Tag = 7
      Caption = '&7'
      Category = 0
      Hint = '7'
      Visible = ivAlways
      OnClick = bb1Click
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bb1'
      end
      item
        Visible = True
        ItemName = 'bb2'
      end
      item
        Visible = True
        ItemName = 'bb3'
      end
      item
        Visible = True
        ItemName = 'bb4'
      end
      item
        Visible = True
        ItemName = 'bb5'
      end
      item
        Visible = True
        ItemName = 'bb6'
      end
      item
        Visible = True
        ItemName = 'bb7'
      end>
    UseOwnFont = False
    Left = 424
    Top = 248
    PixelsPerInch = 96
  end
end
