object frmWebCatalogLevel3Dlg: TfrmWebCatalogLevel3Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Web Catalog - Nivelul 3'
  ClientHeight = 735
  ClientWidth = 1131
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    1131
    735)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1131
    Height = 64
    Title = 'Web Catalog - Nivelul 3'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 23
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 70
    Width = 1123
    Height = 612
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 608
    ClientRectLeft = 4
    ClientRectRight = 1119
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = 'General'
      ImageIndex = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1115
        Height = 582
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label4: TLabel
          Left = 262
          Top = 109
          Width = 104
          Height = 15
          Caption = 'ReWrite URL (Rus)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 16
          Top = 110
          Width = 110
          Height = 15
          Caption = 'ReWrite URL (Rom)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 16
          Top = 66
          Width = 99
          Height = 15
          Caption = 'Denumirea mapei'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 261
          Top = 63
          Width = 94
          Height = 15
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 16
          Top = 259
          Width = 114
          Height = 15
          Caption = 'Modul de vizualizare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 241
          Top = 259
          Width = 145
          Height = 15
          Caption = 'Politica formarii preturilor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 1015
          Top = 612
          Width = 53
          Height = 15
          Cursor = crHandPoint
          Caption = 'genereaza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 16
          Top = 496
          Width = 70
          Height = 15
          Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
          Caption = 'Icon (24x24)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label19: TLabel
          Left = 16
          Top = 320
          Width = 102
          Height = 15
          Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
          Caption = #1055#1083#1080#1090#1082#1072' (272'#1093'268)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object lbVirtualFilter: TLabel
          Left = 245
          Top = 430
          Width = 280
          Height = 45
          AutoSize = False
          Caption = 
            'Mapele virtuale se administreaza din butonul "Mape virtuale..." ' +
            'al catalogului.'
          WordWrap = True
        end
        object lbURL_RO: TLabel
          Left = 245
          Top = 480
          Width = 200
          Height = 15
          Caption = 'Link RO (doar pentru grupa dinamica)'
        end
        object lbURL_RU: TLabel
          Left = 245
          Top = 528
          Width = 40
          Height = 15
          Caption = 'Link RU'
        end
        object edREWRITE_URL_RUS: TcxDBTextEdit
          Left = 259
          Top = 130
          DataBinding.DataField = 'REWRITE_URL_RUS'
          ParentFont = False
          Properties.CharCase = ecLowerCase
          TabOrder = 7
          Width = 241
        end
        object edREWRITE_URL_ROM: TcxDBTextEdit
          Left = 16
          Top = 130
          DataBinding.DataField = 'REWRITE_URL_ROM'
          ParentFont = False
          Properties.CharCase = ecLowerCase
          TabOrder = 6
          Width = 237
        end
        object edTITLE: TcxDBTextEdit
          Left = 19
          Top = 81
          DataBinding.DataField = 'TITLE'
          ParentFont = False
          TabOrder = 4
          Width = 237
        end
        object edTITLE_RUS: TcxDBTextEdit
          Left = 262
          Top = 83
          DataBinding.DataField = 'TITLE_RUS'
          ParentFont = False
          TabOrder = 5
          Width = 238
        end
        object cbFLG_CUSTOM_PRICE_COLUMN: TcxDBCheckBox
          Left = 19
          Top = 207
          Caption = 'Grila de pret '
          DataBinding.DataField = 'FLG_CUSTOM_PRICE_COLUMN'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Properties.OnChange = cbFLG_CUSTOM_PRICE_COLUMNPropertiesChange
          Style.TransparentBorder = False
          TabOrder = 10
        end
        object cmbCUSTOM_PRICE_COLUMN: TcxDBComboBox
          Left = 110
          Top = 205
          DataBinding.DataField = 'CUSTOM_PRICE_COLUMN'
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5')
          TabOrder = 9
          Width = 77
        end
        object cmbViewMode: TcxComboBox
          Left = 16
          Top = 280
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
            #1042#1080#1090#1088#1080#1085#1072)
          Properties.OnCloseUp = cmbViewModePropertiesCloseUp
          TabOrder = 13
          Text = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
          Width = 171
        end
        object cxDBLookupComboBox1: TcxDBLookupComboBox
          Left = 240
          Top = 280
          DataBinding.DataField = 'PGT_ID'
          ParentFont = False
          Properties.ClearKey = 16430
          Properties.KeyFieldNames = 'PGT_ID'
          Properties.ListColumns = <
            item
              Caption = 'Cod'
              FieldName = 'PGT_ID'
            end
            item
              Caption = 'Denumire'
              Width = 300
              FieldName = 'TITLE'
            end>
          Properties.ListFieldIndex = 1
          Properties.ListSource = IBCDataSourcePrice
          TabOrder = 14
          Width = 203
        end
        object cxButton2: TcxButton
          Left = 449
          Top = 275
          Width = 26
          Height = 29
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C00000023744558745469746C650043616E63656C3B53746F703B
            457869743B426172733B526962626F6E3B4C9696B20000009449444154785E95
            93410A834010047D5C2027F3093F104C6461C5CD37F312C5D3641AD27810BAF1
            5030CC587510B68B88EE3BDCFAA46236F0FB190E66CA7B12C9125EFE24F1771E
            584C9009234626230FE514F1F21B2E8E22A2650654A42999011951320322A265
            E0FFF6411301219B88935F49511129F3A622567611C8B3905DA462794FD693EC
            231B5C2C19795E78CE131CCC3FD2409CCC2C3656140000000049454E44AE4260
            82}
          TabOrder = 11
          TabStop = False
          OnClick = cxButton2Click
        end
        object cbFLG_PROMO: TcxDBCheckBox
          Left = 435
          Top = 320
          Caption = 'Promo'
          DataBinding.DataField = 'FLG_PROMO'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 15
        end
        object cbFLG_NEW: TcxDBCheckBox
          Left = 435
          Top = 345
          Caption = 'New'
          DataBinding.DataField = 'FLG_NEW'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 18
        end
        object ImgCatalog: TcxDBImage
          Left = 27
          Top = 512
          DataBinding.DataField = 'IMAGE'
          Properties.Caption = 'Icon Level3'
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ImmediatePost = True
          TabOrder = 17
          Height = 54
          Width = 65
        end
        object cxButton3: TcxButton
          Left = 474
          Top = 277
          Width = 26
          Height = 29
          Caption = 'cxButton3'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001F744558745469746C650043757272656E63793B446F6C6C61723B42
            75636B3B4575726FF8F3458F0000037549444154785E6D926D4C93571CC59F39
            5DB2AF33CE148863049C18A0C01282056513A180AB9452DE6A7989348E017333
            5829C2267305B514C69649E54DB4D5A69A011554E22842B7156A2BD8F1566AC1
            021D6BC065166921B097B3E721DB87A5DEE42437B9E7FCEEF9DF5CE2EF753341
            AE571E5EE0FA8ED767C926EA797313F55918ABCB9A1FADCD6C1EACE2F852E71B
            4B1A62549A4100F89F36C3C3920CE6F857992BBF6AEAE0B2F5E0CF65035CD36A
            D87BCEC35493BE3224662750BEC717389E809FCEA5F8FE2C4D77BEB076617DB1
            0723120E7A78013056B1B03AA3C0EFA636729FB2DC752ADECFF0E5114F8051CC
            BEF44B6F1D3696DA31DE948B87D51CB866D4183C7704F3B78BB0325E035B6739
            7EF82CA9816CB1C503A0AF642DB89EDEC4FA5C33BAF342F1DBA306B8CDB5587B
            AAC0CAD8C559A7FEB46E492756F78BE2BE21015B2908354E590B83A044FC5891
            B8BE36DB02458237E44C2FC8E3BD70358EB6EA349C314E690ADA9B9489962FAE
            1C709166889A1976A16C5F6B9124DC8F02599C32827870FAD0C2F3E16A72845E
            A83243B068B88CB5B976E3832E5E6F794BD41FD7B5020CD9AA61792EC3A04D0C
            F9C0319436EE737D2C7DF7F0669B3B27F63759941FE285A912BADA1C741747CE
            8EA8733ACA1A191BDA2767F168B102FD7601B865BEE89B3F06BDA3147D536528
            B914B1CC17ED0D205AB3C377DFFD24DA65BF5B08E7480D3A8B6374A5C2C029C5
            403E193C8E7BB634A4087781FDAF64030771DF968D2B1A3E0A2ED29B08AAC655
            7EE8079DC7235CC35FB3B1A015AB85DF46AE7E6F2D42F70C07D71F2781F5A90F
            EE4F17406B2FC66D2B07B7A612D165CE2301410E626DEE3B0AF2AA3479CF1EC5
            D190367956B0EC2349F05FDDD634743C61A1D39A8CF3B70E815944C3898620A8
            CC71504EC64235990041D5DE0D42954D2754FCE0CD1F498148BD9E2F0E742846
            E2C99B98A4310E6A6B2A593B1F07053B51A1A4E3DAE87E5CD64721E7EC6EC7CB
            FEF656DE19FFB6EA0E066E4CBC0F998E8198BC1D9B3A90BB038DBAF7D06A8A44
            E5CD3070856F5F7B19604B6C362D88FFB9BFBBBE3F02F2D118DC99E6218ABF9D
            9C3F830C3320D58422B3DCCF1DCD7D93EE014817BD4541B631055EA969A25D6E
            615B206AFBC2A0B67051D3178292D677902AF471C7E6EC4C277DAF7900524FF9
            FCF71EDB1829DBE9870B6937924FFA3C63977823F9A4F7B3A4429A3282F54618
            15A67CFF00D461458D1C2631660000000049454E44AE426082}
          PaintStyle = bpsGlyph
          TabOrder = 12
          OnClick = cxButton3Click
        end
        object cxDBCheckBox1: TcxDBCheckBox
          Left = 435
          Top = 370
          Caption = 'Info'
          DataBinding.DataField = 'FLG_INFO'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 19
        end
        object cbFLG_POPULAR: TcxDBCheckBox
          Left = 435
          Top = 395
          Caption = 'Popular'
          DataBinding.DataField = 'FLG_POPULAR'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 20
        end
        object imgBIG_IMAGE: TcxDBImage
          Left = 27
          Top = 338
          DataBinding.DataField = 'BIG_IMAGE'
          Properties.Caption = #1087#1083#1080#1090#1082#1072' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
          Properties.GraphicClassName = 'TdxPNGImage'
          TabOrder = 16
          Height = 150
          Width = 207
        end
        object cbFLG_LEVEL4: TcxDBCheckBox
          Left = 161
          Top = 33
          Caption = 'Este parinte pentru nivelul 4'
          DataBinding.DataField = 'FLG_4LEVEL'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 2
        end
        object cbFLG_GROUP_IS_LINK: TcxDBCheckBox
          Left = 41
          Top = 33
          Caption = 'Grupa dinamica'
          DataBinding.DataField = 'FLG_GROUP_IS_LINK'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 1
        end
        object teURL_RO: TcxDBTextEdit
          Left = 245
          Top = 499
          DataBinding.DataField = 'URL_RO'
          TabOrder = 21
          Width = 255
        end
        object teURL_RU: TcxDBTextEdit
          Left = 245
          Top = 547
          DataBinding.DataField = 'URL_RU'
          TabOrder = 22
          Width = 255
        end
        object cbFLG_ENABLED: TcxDBCheckBox
          Left = 16
          Top = 8
          Caption = 'Grupa este activa'
          DataBinding.DataField = 'FLG_ENABLED'
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Style.TransparentBorder = False
          TabOrder = 0
        end
        object cxScrollBox1: TcxScrollBox
          Left = 516
          Top = 63
          Width = 585
          Height = 509
          TabOrder = 3
          object Label10: TLabel
            Left = 3
            Top = 1
            Width = 105
            Height = 15
            Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
            Caption = 'Meta Title RO / RU'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 3
            Top = 77
            Width = 142
            Height = 15
            Hint = 
              #1050#1091#1087#1080#1090#1100' '#1057#1090#1072#1088#1090#1092#1086#1085#1099' '#1074' '#1050#1080#1096#1080#1085#1077#1074#1077' '#1087#1086' '#1087#1088#1080#1077#1084#1083#1077#1084#1086#1081' '#1094#1077#1085#1077'. '#1054#1088#1080#1075#1080#1085#1072#1083#1100#1085#1099#1081' '#1089#1084#1072 +
              #1088#1090#1092#1086#1085#1099', '#1075#1072#1088#1072#1085#1090#1080#1103' 2 '#1075#1086#1076#1072', '#1076#1086#1089#1090#1072#1074#1082#1072' '#1082#1091#1088#1100#1077#1088#1086#1084' '#1087#1086' '#1052#1086#1083#1076#1086#1074#1077'. '#1058#1077#1093#1085#1080#1095#1077#1089#1082 +
              #1080#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080'.'
            Caption = 'Meta description RO / RU'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 3
            Top = 183
            Width = 124
            Height = 30
            AutoSize = False
            Caption = 'Keywords RO /RU'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object teTITLE_RO: TcxDBTextEdit
            Left = 14
            Top = 19
            DataBinding.DataField = 'META_TITLE_RO'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            TabOrder = 0
            Width = 547
          end
          object teTITLE_RU: TcxDBTextEdit
            Left = 14
            Top = 48
            DataBinding.DataField = 'META_TITLE_RU'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            TabOrder = 1
            Width = 548
          end
          object cxDBMemo4: TcxDBMemo
            Left = 16
            Top = 256
            DataBinding.DataField = 'META_KEYWORDS_RU'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            Properties.ScrollBars = ssVertical
            Properties.VisibleLineCount = 2
            TabOrder = 5
            Width = 547
          end
          object cxDBMemo3: TcxDBMemo
            Left = 16
            Top = 212
            DataBinding.DataField = 'META_KEYWORDS_RO'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            Properties.ScrollBars = ssVertical
            Properties.VisibleLineCount = 2
            TabOrder = 4
            Width = 547
          end
          object teDescription_RU: TcxDBMemo
            Left = 16
            Top = 139
            DataBinding.DataField = 'META_DESCRIPTION_RU'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            Properties.VisibleLineCount = 2
            TabOrder = 3
            Width = 547
          end
          object teDescription_RO: TcxDBMemo
            Left = 15
            Top = 95
            DataBinding.DataField = 'META_DESCRIPTION_RO'
            DataBinding.DataSource = IBCDS_SeoDescription
            ParentFont = False
            Properties.VisibleLineCount = 2
            TabOrder = 2
            Width = 548
          end
          object cxPageControl3: TcxPageControl
            Left = 3
            Top = 300
            Width = 560
            Height = 386
            TabOrder = 6
            Properties.ActivePage = tbArticleRO
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 382
            ClientRectLeft = 4
            ClientRectRight = 556
            ClientRectTop = 26
            object tbArticleRO: TcxTabSheet
              Caption = 'SEO Footer content Romana'
              ImageIndex = 0
              object cxDBMemo1: TcxDBMemo
                Left = 3
                Top = 3
                DataBinding.DataField = 'SEO_ARTICLE_RO'
                DataBinding.DataSource = IBCDS_SeoDescription
                TabOrder = 0
                Height = 174
                Width = 550
              end
            end
            object tsArticleRU: TcxTabSheet
              Caption = 'Seo Footer content Russian'
              ImageIndex = 1
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object cxDBMemo2: TcxDBMemo
                Left = 2
                Top = 3
                DataBinding.DataField = 'SEO_ARTICLE_RU'
                DataBinding.DataSource = IBCDS_SeoDescription
                TabOrder = 0
                Height = 174
                Width = 550
              end
            end
          end
        end
        object btnGenereazaSeo: TcxButton
          Left = 370
          Top = 159
          Width = 130
          Height = 25
          Caption = 'Genereaza'
          TabOrder = 8
          OnClick = btnGenereazaSeoClick
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 886
    Top = 698
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object btnCancel: TcxButton
    Left = 992
    Top = 698
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object IBCQuerySeoDescription: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_SEO'
      
        '  (CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION_RO,' +
        ' META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SEO_AR' +
        'TICLE_RO, SEO_ARTICLE_RU)'
      'VALUES'
      
        '  (:CATALOGID, :META_TITLE_RO, :META_TITLE_RU, :META_DESCRIPTION' +
        '_RO, :META_DESCRIPTION_RU, :META_KEYWORDS_RO, :META_KEYWORDS_RU,' +
        ' :SEO_ARTICLE_RO, :SEO_ARTICLE_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_SEO'
      'SET'
      
        '  CATALOGID = :CATALOGID, META_TITLE_RO = :META_TITLE_RO, META_T' +
        'ITLE_RU = :META_TITLE_RU, META_DESCRIPTION_RO = :META_DESCRIPTIO' +
        'N_RO, META_DESCRIPTION_RU = :META_DESCRIPTION_RU, META_KEYWORDS_' +
        'RO = :META_KEYWORDS_RO, META_KEYWORDS_RU = :META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO = :SEO_ARTICLE_RO, SEO_ARTICLE_RU = :SEO_ARTICLE_RU'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      
        'SELECT CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION' +
        '_RO, META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO, SEO_ARTICLE_RU FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_SEO'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_CATALOG_SEO'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from tweb_catalog_seo where catalogid=:catalogid')
    AutoCommit = False
    Left = 703
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'catalogid'
        Value = nil
      end>
  end
  object IBCDS_SeoDescription: TIBCDataSource
    DataSet = IBCQuerySeoDescription
    Left = 576
    Top = 8
  end
  object IBCQueryPrice: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TPRICE')
    Left = 360
    Top = 464
  end
  object IBCDataSourcePrice: TIBCDataSource
    DataSet = IBCQueryPrice
    Left = 360
    Top = 416
  end
end
