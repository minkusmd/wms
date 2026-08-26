object frmImportForeignGoodsIntoTableDlg: TfrmImportForeignGoodsIntoTableDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084' '#1074' '#1090#1072#1073#1083#1080#1094#1091
  ClientHeight = 662
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1039
    Height = 64
    Title = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084' '#1074' '#1090#1072#1073#1083#1080#1094#1091
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
    ImageIndex = 0
  end
  object pnButtons: TPanel
    Left = 0
    Top = 601
    Width = 1039
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 16
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 1
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 929
      Top = 16
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
    object btnNext: TButton
      AlignWithMargins = True
      Left = 791
      Top = 16
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 48
      Margins.Bottom = 0
      Align = alRight
      Caption = #1044#1072#1083#1077#1077' >>'
      TabOrder = 1
      OnClick = btnNextClick
    end
    object btnPrev: TButton
      AlignWithMargins = True
      Left = 689
      Top = 16
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = '<< '#1042#1077#1088#1085#1091#1090#1089#1103
      TabOrder = 2
      OnClick = btnPrevClick
    end
  end
  object Notebook: TNotebook
    Left = 0
    Top = 64
    Width = 1039
    Height = 537
    Align = alClient
    PageIndex = 1
    TabOrder = 2
    object TPage
      Left = 0
      Top = 0
      Caption = 'SETTINGS'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnSettings: TPanel
        Left = 0
        Top = 0
        Width = 1039
        Height = 537
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          Left = 64
          Top = 68
          Width = 123
          Height = 31
          Caption = #1056#1077#1072#1083#1080#1079#1072#1094#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 65
          Top = 188
          Width = 119
          Height = 20
          Caption = #1055#1077#1088#1080#1086#1076' '#1088#1072#1089#1089#1095#1077#1090#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 64
          Top = 226
          Width = 48
          Height = 20
          Caption = #1060#1080#1088#1084#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 64
          Top = 263
          Width = 77
          Height = 20
          Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 64
          Top = 132
          Width = 197
          Height = 20
          Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1072#1095#1072#1083#1100#1085#1099#1077' '#1076#1072#1085#1085#1099#1077':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object sbFirmsPresets: TSpeedButton
          Left = 604
          Top = 224
          Width = 81
          Height = 25
          Caption = #1060#1080#1088#1084#1099
          OnClick = sbFirmsPresetsClick
        end
        object sbWeekPresets: TSpeedButton
          Left = 500
          Top = 186
          Width = 81
          Height = 25
          Caption = #1085#1077#1076#1077#1083#1080
          OnClick = sbWeekPresetsClick
        end
        object deSTART: TcxDateEdit
          Left = 201
          Top = 185
          ParentFont = False
          Properties.SaveTime = False
          Properties.ShowTime = False
          Properties.WeekNumbers = True
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 136
        end
        object deEND: TcxDateEdit
          Left = 343
          Top = 185
          ParentFont = False
          Properties.SaveTime = False
          Properties.ShowTime = False
          Properties.WeekNumbers = True
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 136
        end
        object beCT: TcxButtonEdit
          Left = 201
          Top = 223
          ParentFont = False
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                424D360400000000000036000000280000001000000010000000010020000000
                000000000000C40E0000C40E00000000000000000000FF00FF008C8C8CFF5757
                57FF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ABABABFF737589FFAA87
                8EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0089B0CAFF4088DFFF7376
                A8FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDE3FFFF52B8FFFF4385
                D9FF7979A7FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5D8FFFF53B9
                FFFF4385D9FF7979A7FFAD898EFF5F5B5BFF969696FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CCC
                FFFF53B8FEFF4483D6FF7979A7FF987D82FF818181FFA1A1A1FF6C6C6CFF5757
                57FF575757FF626262FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF008ECEFFFF53B8FEFF588CCFFF8B8B8EFF8B7575FFBC9A86FFCEB096FFE0C7
                AEFFD2B4A4FF8B7472FF575757FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00A5D8FFFFC9D0D4FFAB8B88FFF1CFA9FFFFF5C5FFFFFDD1FFFFFF
                DBFFFFFFDCFFF5EFE0FF9F8581FF575757FF8C8C8CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E2CECEFFEFC9A6FFFFF2C0FFFFF7C4FFFFFFD8FFFFFF
                E8FFFFFFF8FFFFFFFFFFF3EDDAFF7B6161FF6C6C6CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E0BDB3FFFFF1C2FFFFE4B1FFFFF9C6FFFFFFDBFFFFFF
                ECFFFFFFFBFFFFFFF7FFFFFFDAFFB79E8CFF575757FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E5BDA3FFFFF5C9FFFFDDAAFFFFF5C2FFFFFFD6FFFFFF
                E5FFFFFFECFFFFFFE7FFFFFFD9FFCCB299FF575757FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E5BFA6FFFFF5C9FFFFE6B9FFFFEFBCFFFFFFCDFFFFFF
                D7FFFFFFDBFFFFFFD8FFFFFCD1FFCCAC93FF6C6C6CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E0C0B6FFFFF6CDFFFFF2D7FFFFE3B9FFFFF1BFFFFFF5
                C2FFFFF9C7FFFFF7C4FFFFF6C6FFB79481FF8C8C8CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00DCC5C5FFEFDAC2FFFFFFFFFFFFF7EAFFFFECBFFFFFDF
                ACFFFFE3B0FFFFF0BDFFF3D2A8FF907676FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00D8BCBAFFF1E5DDFFFFFBE8FFFFF8CDFFFFEE
                BCFFFFF3C6FFF5CFA4FFB9938AFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00DCC5C5FFD2B19EFFCEA88EFFE0B8
                9EFFDCB3A0FF8C8C8CFFFF00FF00FF00FF00FF00FF00}
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beCTPropertiesButtonClick
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Width = 380
        end
        object beSUPPLIER: TcxButtonEdit
          Left = 201
          Top = 259
          ParentFont = False
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                424D360400000000000036000000280000001000000010000000010020000000
                000000000000C40E0000C40E00000000000000000000FF00FF008C8C8CFF5757
                57FF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ABABABFF737589FFAA87
                8EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0089B0CAFF4088DFFF7376
                A8FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDE3FFFF52B8FFFF4385
                D9FF7979A7FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5D8FFFF53B9
                FFFF4385D9FF7979A7FFAD898EFF5F5B5BFF969696FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CCC
                FFFF53B8FEFF4483D6FF7979A7FF987D82FF818181FFA1A1A1FF6C6C6CFF5757
                57FF575757FF626262FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF008ECEFFFF53B8FEFF588CCFFF8B8B8EFF8B7575FFBC9A86FFCEB096FFE0C7
                AEFFD2B4A4FF8B7472FF575757FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00A5D8FFFFC9D0D4FFAB8B88FFF1CFA9FFFFF5C5FFFFFDD1FFFFFF
                DBFFFFFFDCFFF5EFE0FF9F8581FF575757FF8C8C8CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E2CECEFFEFC9A6FFFFF2C0FFFFF7C4FFFFFFD8FFFFFF
                E8FFFFFFF8FFFFFFFFFFF3EDDAFF7B6161FF6C6C6CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E0BDB3FFFFF1C2FFFFE4B1FFFFF9C6FFFFFFDBFFFFFF
                ECFFFFFFFBFFFFFFF7FFFFFFDAFFB79E8CFF575757FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E5BDA3FFFFF5C9FFFFDDAAFFFFF5C2FFFFFFD6FFFFFF
                E5FFFFFFECFFFFFFE7FFFFFFD9FFCCB299FF575757FFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E5BFA6FFFFF5C9FFFFE6B9FFFFEFBCFFFFFFCDFFFFFF
                D7FFFFFFDBFFFFFFD8FFFFFCD1FFCCAC93FF6C6C6CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00E0C0B6FFFFF6CDFFFFF2D7FFFFE3B9FFFFF1BFFFFFF5
                C2FFFFF9C7FFFFF7C4FFFFF6C6FFB79481FF8C8C8CFFFF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00DCC5C5FFEFDAC2FFFFFFFFFFFFF7EAFFFFECBFFFFFDF
                ACFFFFE3B0FFFFF0BDFFF3D2A8FF907676FFFF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00D8BCBAFFF1E5DDFFFFFBE8FFFFF8CDFFFFEE
                BCFFFFF3C6FFF5CFA4FFB9938AFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00DCC5C5FFD2B19EFFCEA88EFFE0B8
                9EFFDCB3A0FF8C8C8CFFFF00FF00FF00FF00FF00FF00}
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beSUPPLIERPropertiesButtonClick
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 3
          Width = 380
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'SELECT'
      object cxGridS: TcxGrid
        Left = 0
        Top = 30
        Width = 1039
        Height = 507
        Align = alClient
        TabOrder = 0
        object cxGridSTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridS_GOODSID
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridS_SUPPLIERID: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
            DataBinding.FieldName = 'SUPPLIERGOODSID'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridS_GOODSID: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1053#1077#1091#1088#1086#1085
            DataBinding.FieldName = 'GOODSID'
            DataBinding.IsNullValueType = True
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridS_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'TITLE'
            DataBinding.IsNullValueType = True
            Width = 300
          end
          object cxGridS_QTY: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'QTY'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridS_FLG_SLD: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_SLD'
            DataBinding.IsNullValueType = True
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridSLevel: TcxGridLevel
          GridView = cxGridSTable
        end
      end
      object dxBarDockControl3: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1039
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'EXCEL - Input'
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1039
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object pnLegend: TPanel
        Left = 0
        Top = 500
        Width = 1039
        Height = 37
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object Label2: TLabel
          Left = 51
          Top = 6
          Width = 72
          Height = 15
          Caption = #1085#1077#1090' '#1079#1085#1072#1095#1077#1085#1080#1103
        end
        object Shape4: TShape
          Left = 12
          Top = 6
          Width = 33
          Height = 17
          Brush.Color = clGray
        end
        object lbCodeRepeated: TLabel
          Left = 191
          Top = 6
          Width = 168
          Height = 15
          Caption = #1082#1086#1076' FANTASTIC '#1087#1086#1074#1090#1086#1088#1103#1077#1090#1089#1103' - 0'
        end
        object Shape2: TShape
          Left = 152
          Top = 6
          Width = 33
          Height = 17
          Brush.Color = 26367
        end
        object lbNotFound: TLabel
          Left = 439
          Top = 8
          Width = 72
          Height = 15
          Caption = #1085#1077' '#1085#1072#1081#1076#1077#1085' - 0'
        end
        object Shape3: TShape
          Left = 400
          Top = 6
          Width = 33
          Height = 17
          Brush.Color = clMaroon
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'COMBINE'
      object cxGridR: TcxGrid
        Left = 0
        Top = 30
        Width = 1039
        Height = 507
        Align = alClient
        TabOrder = 0
        object cxGridRTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridR_GOODSID
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CellMultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridR_SUPPLIERGOODSID: TcxGridColumn
            Caption = #1050#1086#1076' '#1087#1086#1089#1090#1072#1074#1097#1080#1082
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridR_GOODSID: TcxGridColumn
            Caption = #1050#1086#1076' '#1053#1077#1091#1088#1086#1085
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridR_TITLE: TcxGridColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 200
          end
          object cxGridR_SELL_QTY: TcxGridColumn
            Caption = #1055#1088#1086#1076#1072#1085#1085#1086' '#1053#1077#1091#1088#1086#1085
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridR_SUPPLIER_QTY: TcxGridColumn
            Caption = #1054#1089#1090'. '#1087#1086#1089#1090#1072#1074#1097'.'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
        end
        object cxGridRLevel: TcxGridLevel
          GridView = cxGridRTable
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1039
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
  end
  object dxSpreadSheet1: TdxSpreadSheet
    Left = 0
    Top = 64
    Width = 1039
    Height = 537
    Align = alClient
    Data = {
      8002000044585353763242461000000042465320000000000000000001000101
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
      0000000000000000000000000000000000000000000000000000000000000000
      00000000}
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 588
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 1007
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
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearAll'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCheckGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoods'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
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
      FloatLeft = 1073
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExportExcel'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
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
      FloatLeft = 1073
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCopySourceAll'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbOpenFile: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbOpenFileClick
    end
    object bbClearAll: TdxBarButton
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Category = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearAllClick
    end
    object bbCheckGoods: TdxBarButton
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1090#1086#1074#1072#1088#1099
      Category = 0
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1090#1086#1074#1072#1088#1099
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbCheckGoodsClick
    end
    object bbGridHeader: TdxBarButton
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1086#1085#1086#1082
      Category = 0
      Hint = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1086#1085#1086#1082
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1042#1080#1076
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowFormulas'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGridHeader'
        end>
    end
    object bbShowFormulas: TdxBarButton
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1099
      Category = 0
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1099
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbShowFormulasClick
    end
    object bbGoods: TdxBarButton
      Caption = #1053#1072#1081#1090#1080' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1053#1072#1081#1090#1080' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 16468
      OnClick = bbGoodsClick
    end
    object bbExportExcel: TdxBarButton
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      Category = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbExportExcelClick
    end
    object bbCopySourceAll: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 24
      OnClick = bbCopySourceAllClick
    end
  end
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    Left = 476
    Top = 12
  end
  object IBCQuerySource: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT WEBGOODSTYPE_ID,'
      '       GOODSID,'
      '       TITLE,'
      '       SUPPLIERGOODSID,'
      '       PRICEUSD,'
      '       FLG_SLD,'
      '       SUM(QTY) QTY'
      'FROM SPM_VINZARI_REALIZARE(:DATA1, :DATA2, :CT, :SUPPLIERCODE) A'
      
        'GROUP BY WEBGOODSTYPE_ID, GOODSID, TITLE, SUPPLIERGOODSID, PRICE' +
        'USD, FLG_SLD')
    Left = 756
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERCODE'
        Value = nil
      end>
  end
  object IBCDataSourceSource: TIBCDataSource
    DataSet = IBCQuerySource
    Left = 872
    Top = 16
  end
  object pmFirms: TPopupMenu
    Left = 688
    Top = 328
    object miFirms1: TMenuItem
      Tag = 1
      Caption = 'ULTRACOM REALIZAREA / ULTRACOM-ELECTRONIC SRL'
      OnClick = miFirms1Click
    end
  end
  object pmWeeks: TPopupMenu
    Left = 528
    Top = 196
    object miWeekPreset1: TMenuItem
      Tag = 1
      Caption = #1055#1088#1086#1096#1083#1072#1103' '#1085#1077#1076#1077#1083#1103
      OnClick = miWeekPreset2Click
    end
    object miWeekPreset2: TMenuItem
      Tag = 2
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1085#1077#1076#1077#1083#1103
      OnClick = miWeekPreset2Click
    end
  end
end
