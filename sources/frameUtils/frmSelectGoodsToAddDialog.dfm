object frmSelectGoodsToAddDlg: TfrmSelectGoodsToAddDlg
  Left = 0
  Top = 0
  ActiveControl = beGoods
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 386
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    591
    386)
  TextHeight = 15
  object tcxdblookupcombo: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 575
    Height = 322
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object imgWarning: TImage
      Left = 411
      Top = 19
      Width = 18
      Height = 18
      Picture.Data = {
        07544269746D6170C2010000424DC201000000000000C2000000280000001000
        000010000000010008000000000000010000120B0000120B0000230000002300
        000000000000FFFFFF00FF00FF005BF6FB004BF0FA0051F4FB0045EAF90047EA
        F60049EEF90048E8F3001C6871003EE4F7003FE6F8002CC6DD0034DBF40024BB
        D60026BFD9002BC6DF0030D9F50021C3E40026D1F30025C9E90028D3F4000F8C
        A90018C5F1001BC8F10017ACCD0018AECF0021CCF20026AECE0037B4D10047BB
        D50072CADF0082D0E20015C2F000020202020202020202020202020202021F17
        171717171717171717171717171F1E15182222222222222222222222131E201B
        1C192222220000181919191C1A20021E13161C191C00001C141616131E020221
        1B0E0E1216160E12120E0E1B210202021E110C0B0B0A0A0B0B0B111E02020202
        021A070408000006060B1A0202020202021E11040400000808111E0202020202
        02021A0905000004091A02020202020202021E10030000050D1E020202020202
        0202021A090505091B020202020202020202021E0F05050D1E02020202020202
        020202021A09091A0202020202020202020202021E0F111E0202020202020202
        02020202021D1D02020202020202}
      Transparent = True
    end
    object lbGoodsExistsWarning: TLabel
      Left = 435
      Top = 22
      Width = 119
      Height = 15
      Caption = 'Produsul  exista in lista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 58
      Width = 37
      Height = 15
      Caption = 'Produs'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 13
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Depozit'
      Transparent = True
    end
    object pcPageControl: TcxPageControl
      Left = 13
      Top = 96
      Width = 546
      Height = 209
      Focusable = False
      TabOrder = 3
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 1
      Properties.TabPosition = tpBottom
      OnChange = pcPageControlChange
      OnPageChanging = pcPageControlPageChanging
      ClientRectBottom = 183
      ClientRectLeft = 4
      ClientRectRight = 542
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
        object Label1: TLabel
          Left = 195
          Top = 16
          Width = 133
          Height = 15
          Caption = '<- Aici sunt 2 controale!!!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label2: TLabel
          Left = 12
          Top = 134
          Width = 21
          Height = 15
          Caption = 'TVA'
          Transparent = True
        end
        object cbFLG_ACNT: TcxDBCheckBox
          Left = 356
          Top = 118
          Caption = 'Cntb'
          DataBinding.DataField = 'FLG_ACNT'
          ParentFont = False
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
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 4
        end
        object cbWARRANTY: TcxDBComboBox
          Left = 92
          Top = 102
          DataBinding.DataField = 'WARRANTY'
          ParentFont = False
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
          TabOrder = 5
          Width = 97
        end
        object lbCURRENCY_NAME: TcxDBLabel
          Left = 188
          Top = 45
          DataBinding.DataField = 'CURRENCY_NAME'
          DataBinding.DataSource = dmDB.IBCDataSourceDocs
          ParentFont = False
          TabOrder = 6
          Visible = False
          Height = 21
          Width = 29
        end
        object edPRICE: TcxDBCalcEdit
          Left = 92
          Top = 45
          DataBinding.DataField = 'PRICE'
          ParentFont = False
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
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.OnEditValueChanged = ceSUMAPropertiesEditValueChanged
          TabOrder = 3
          Width = 97
        end
        object edQTY: TcxDBCalcEdit
          Left = 92
          Top = 16
          DataBinding.DataField = 'QTY'
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.000'
          Properties.Precision = 12
          Properties.OnEditValueChanged = ceQTYPropertiesEditValueChanged
          TabOrder = 0
          Width = 97
        end
        object cbVAT: TcxDBCalcEdit
          Left = 92
          Top = 131
          DataBinding.DataField = 'SUMAVAT'
          ParentFont = False
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
      object tbsQtys: TcxTabSheet
        Caption = 'Sold'
        ImageIndex = 1
        inline frameGoodsStock: TframeGoodsStock
          Left = 0
          Top = 0
          Width = 538
          Height = 179
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 538
          ExplicitHeight = 179
          inherited cxTree: TcxTreeList
            Width = 538
            Height = 179
            Styles.OnGetContentStyle = frameGoodsStockcxTreeStylesGetContentStyle
            ExplicitWidth = 538
            ExplicitHeight = 179
          end
        end
      end
      object tsSuppliers: TcxTabSheet
        Caption = 'Furnizori'
        ImageIndex = 2
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 538
          Height = 28
          Align = dalTop
          BarManager = dxBarManager1
        end
        object cxGrid1: TcxGrid
          Left = 0
          Top = 28
          Width = 538
          Height = 151
          Align = alClient
          TabOrder = 1
          object cxGrid1DBTableView1: TcxGridDBTableView
            OptionsView.GroupByBox = False
            object cxGrid1DBTableView1SupplierID: TcxGridDBColumn
              Caption = 'Cod furnizor'
              Width = 76
            end
            object cxGrid1DBTableView1SupplierName: TcxGridDBColumn
              Caption = 'Furnizor'
              Width = 248
            end
            object cxGrid1DBTableView1SupplierGoodsCode: TcxGridDBColumn
              Caption = 'CPF'
            end
            object cxGrid1DBTableView1QTY: TcxGridDBColumn
              Caption = 'Cant'
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
    end
    object lcbStock: TcxDBLookupComboBox
      Left = 64
      Top = 19
      DataBinding.DataField = 'DTDEP'
      ParentFont = False
      Properties.DropDownAutoSize = True
      Properties.DropDownRows = 16
      Properties.ImmediateDropDownWhenActivated = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          Fixed = True
          MinWidth = 30
          Width = 30
          FieldName = 'STOCKID'
        end
        item
          Width = 300
          FieldName = 'TITLE'
        end
        item
          Width = 150
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceStocks
      TabOrder = 0
      Width = 341
    end
    object beGoods: TcxButtonEdit
      Left = 119
      Top = 48
      ParentFont = False
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
      Properties.ReadOnly = False
      Properties.OnButtonClick = beGoodsPropertiesButtonClick
      TabOrder = 1
      Text = 'beGoods'
      OnDblClick = beGoodsDblClick
      Width = 442
    end
    object edGOODSID: TcxDBTextEdit
      Left = 64
      Top = 48
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 49
    end
  end
  object btnOk: TcxButton
    Left = 367
    Top = 341
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 475
    Top = 341
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
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      'Suppliers')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 287
    Top = 192
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Suppliers'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 619
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddSupplier'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
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
    object bbAddSupplier: TdxBarButton
      Caption = 'Adauga furnizor'
      Category = 1
      Hint = 'Adauga furnizor'
      Visible = ivAlways
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
    Left = 288
    Top = 248
    PixelsPerInch = 96
  end
end
