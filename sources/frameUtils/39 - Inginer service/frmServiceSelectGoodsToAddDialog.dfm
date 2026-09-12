object frmServiceSelectGoodsToAddDlg: TfrmServiceSelectGoodsToAddDlg
  Left = 0
  Top = 0
  ActiveControl = beGoods
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 451
  ClientWidth = 591
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
    591
    451)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 591
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 575
    Height = 319
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
    TabOrder = 1
    object imgWarning: TImage
      Left = 372
      Top = 51
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
      Left = 396
      Top = 54
      Width = 155
      Height = 15
      Caption = #1044#1072#1085#1085#1099#1081' '#1090#1086#1074#1072#1088' '#1091#1078#1077' '#1074' '#1089#1087#1080#1089#1082#1077'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 18
      Width = 33
      Height = 15
      Caption = #1058#1086#1074#1072#1088
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 54
      Width = 33
      Height = 15
      Caption = #1057#1082#1083#1072#1076
      Transparent = True
    end
    object pcPageControl: TcxPageControl
      Left = 12
      Top = 88
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
        Caption = #1044#1072#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1072
        ImageIndex = 0
        object lbQTY: TLabel
          Left = 12
          Top = 18
          Width = 65
          Height = 15
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Transparent = True
        end
        object lbPrice: TLabel
          Left = 12
          Top = 47
          Width = 28
          Height = 15
          Caption = #1062#1077#1085#1072
          Transparent = True
        end
        object lbSUMA: TLabel
          Left = 12
          Top = 76
          Width = 38
          Height = 15
          Caption = #1057#1091#1084#1084#1072
          Transparent = True
        end
        object lbWARRANTY: TLabel
          Left = 12
          Top = 105
          Width = 50
          Height = 15
          Caption = #1043#1072#1088#1072#1085#1090#1080#1103
          Transparent = True
        end
        object cbFLG_ACNT: TcxDBCheckBox
          Left = 308
          Top = 38
          Caption = #1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1103
          DataBinding.DataField = 'FLG_ACNT'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 5
        end
        object cbFLG_ACTIVE: TcxDBCheckBox
          Left = 308
          Top = 15
          Caption = #1040#1082#1090#1080#1074#1085#1072#1103' '#1087#1086#1079#1080#1094#1080#1103
          DataBinding.DataField = 'FLG_ACTIVE'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 4
        end
        object cbWARRANTY: TcxDBComboBox
          Left = 91
          Top = 102
          DataBinding.DataField = 'WARRANTY'
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
          TabOrder = 3
          Width = 98
        end
        object lbCURRENCY_NAME: TcxDBLabel
          Left = 188
          Top = 45
          DataBinding.DataField = 'CURRENCY_NAME'
          DataBinding.DataSource = dmDB.IBCDataSourceDocs
          Height = 21
          Width = 29
        end
        object edQTY: TcxDBMaskEdit
          Left = 92
          Top = 15
          DataBinding.DataField = 'QTY'
          Properties.Alignment.Horz = taLeftJustify
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d+'
          Properties.MaxLength = 0
          Properties.OnEditValueChanged = ceQTYPropertiesEditValueChanged
          TabOrder = 0
          Width = 97
        end
        object edPRICE: TcxDBCalcEdit
          Left = 92
          Top = 44
          DataBinding.DataField = 'PRICE'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.OnEditValueChanged = cePRICEPropertiesEditValueChanged
          TabOrder = 1
          Width = 97
        end
        object edSUMA: TcxDBCalcEdit
          Left = 92
          Top = 73
          DataBinding.DataField = 'SUMA'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DisplayFormat = '0.00'
          Properties.OnEditValueChanged = ceSUMAPropertiesEditValueChanged
          TabOrder = 2
          Width = 97
        end
      end
      object tbsQtys: TcxTabSheet
        Caption = #1054#1089#1090#1072#1090#1086#1082
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
    end
    object lcbStock: TcxDBLookupComboBox
      Left = 55
      Top = 50
      DataBinding.DataField = 'DTDEP'
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          Fixed = True
          MinWidth = 30
          Width = 30
          FieldName = 'STOCKID'
        end
        item
          Width = 200
          FieldName = 'TITLE'
        end
        item
          Width = 150
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceStocks
      TabOrder = 2
      Width = 300
    end
    object beGoods: TcxButtonEdit
      Left = 99
      Top = 14
      Properties.Buttons = <
        item
          Default = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000000000000000000FFFF
            FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
            6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
            6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
            55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
            4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
            430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
            6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
            7F00A4C17E00B5CD980086B057008DB4610086B5580000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000020202022B24
            19020202020202020202023E3D3831321529231D130C02020202023E33333A3A
            1534393B3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E33
            1334393B3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E
            0E342C2D2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F18
            0E272C2D2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E
            07272025262D06020202023C09090D0B0E1A2025252606020202023C0309090B
            07202025252506020202023C03030A0F07201B1E252505020202023C16221C11
            1012121E1E120402020202373736302A28211513070802020202}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ReadOnly = True
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGoodsPropertiesButtonClick
      TabOrder = 1
      Text = 'beGoods'
      OnDblClick = beGoodsDblClick
      Width = 459
    end
    object edGOODSID: TcxDBTextEdit
      Left = 56
      Top = 15
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 41
    end
  end
  object btnOk: TcxButton
    Left = 367
    Top = 406
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 475
    Top = 406
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
