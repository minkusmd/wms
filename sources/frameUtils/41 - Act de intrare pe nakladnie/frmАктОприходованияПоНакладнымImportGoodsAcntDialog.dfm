object Frame41ImportGoodsAcntDlg: TFrame41ImportGoodsAcntDlg
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
  ClientHeight = 780
  ClientWidth = 1006
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 120
  TextHeight = 20
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1006
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -18
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -15
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 90
    Width = 986
    Height = 621
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object pcPageControl: TPageControl
      Left = 0
      Top = 34
      Width = 986
      Height = 587
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = tbsGoods
      Align = alClient
      MultiLine = True
      TabOrder = 1
      object tbsGoods: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1058#1086#1074#1072#1088#1099
        object cxGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 978
          Height = 552
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 0
          object cxGridTable: TcxGridTableView
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGridTable_ID
              end
              item
                Kind = skSum
                Column = cxGridTable_QTY
              end>
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridTable_IMG: TcxGridColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 22
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridTable_ID: TcxGridColumn
              Caption = #1050#1086#1076' '#1073#1091#1093#1075'.'
              DataBinding.ValueType = 'Integer'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.Alignment.Vert = taVCenter
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.HorzSizing = False
              Width = 75
            end
            object cxGridTable_QTY: TcxGridColumn
              Caption = #1050#1086#1083'.'
              DataBinding.ValueType = 'Float'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.Alignment.Vert = taVCenter
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridTable_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              MinWidth = 25
              Width = 125
            end
            object cxGridTable_TITLE2: TcxGridColumn
              Caption = #1057#1080#1089#1090#1077#1084#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              MinWidth = 25
              Width = 250
            end
            object cxGridTable_ERROR: TcxGridColumn
              DataBinding.ValueType = 'Boolean'
              Visible = False
              MinWidth = 25
              VisibleForCustomization = False
            end
            object cxGridTable_GOODSID: TcxGridColumn
              DataBinding.ValueType = 'Integer'
              Visible = False
              MinWidth = 25
              VisibleForCustomization = False
            end
            object cxGridTable_UMID: TcxGridColumn
              DataBinding.ValueType = 'Integer'
              Visible = False
              MinWidth = 25
              VisibleForCustomization = False
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridTable
          end
        end
      end
      object tbsErrors: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1054#1096#1080#1073#1082#1080
        ImageIndex = 1
        object mmErrors: TMemo
          Left = 0
          Top = 0
          Width = 974
          Height = 546
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object btnClose: TButton
    Left = 865
    Top = 725
    Width = 113
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnImport: TButton
    Left = 705
    Top = 725
    Width = 143
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
    ModalResult = 1
    TabOrder = 2
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    Left = 388
    Top = 12
    PixelsPerInch = 120
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
      FloatLeft = 715
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClear'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPaste'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbClear: TdxBarButton
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Category = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearClick
    end
    object bbPaste: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16470
      OnClick = bbPasteClick
    end
  end
  object IBCQueryInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_GOODS_ACNT.GOODS_ACNT_ID,'
      ' NAMEACNT,'
      ' GOODS.GOODSID,'
      ' GOODS.TITLE,'
      ' GOODS.UMID'
      'FROM TS_GOODS_ACNT'
      
        'INNER JOIN (SELECT FIRST 1 GOODSID,TITLE,UMID,GOODS_ACNT_ID FROM' +
        ' TS_GOODS WHERE TS_GOODS.GOODS_ACNT_ID=:ID) GOODS ON (GOODS.GOOD' +
        'S_ACNT_ID=TS_GOODS_ACNT.GOODS_ACNT_ID)'
      
        'WHERE (TS_GOODS_ACNT.GOODS_ACNT_ID=:ID) AND (TS_GOODS_ACNT.FLG_F' +
        'OLDER=0)')
    ReadOnly = True
    Left = 136
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
end
