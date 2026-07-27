inherited frame21Zarplata: Tframe21Zarplata
  Width = 874
  Height = 581
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -10
  ExplicitWidth = 874
  ExplicitHeight = 581
  object cxGridZ: TcxGrid
    Left = 0
    Top = 0
    Width = 874
    Height = 581
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridZTable: TcxGridDBTableView
      OnKeyDown = cxGridZTableKeyDown
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      OnCellDblClick = cxGridZTableCellDblClick
      OnCustomDrawCell = cxGridZTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skSum
          Column = cxGridZ_SUMA
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridZ_SUMA
        end>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridZ_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridZ_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridZ_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDataText = cxGridZ_DATAGetDataText
        HeaderAlignmentHorz = taCenter
        MinWidth = 96
        Options.HorzSizing = False
        Width = 96
      end
      object cxGridZTable_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 64
      end
      object cxGridZ_CT_NAME: TcxGridDBColumn
        Caption = 'Beneficiar'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 160
      end
      object cxGridZ_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 72
        Options.HorzSizing = False
        Width = 72
      end
      object cxGridZ_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridZ_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridZ_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridZ_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridZ_FLG_ACNT: TcxGridDBColumn
        AlternateCaption = #1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1103
        Caption = 'Cnt'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridZ_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridZ_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 16
        Width = 80
      end
    end
    object cxGridZLevel: TcxGridLevel
      GridView = cxGridZTable
    end
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 492
    Top = 112
    PixelsPerInch = 96
    object bbCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'....'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'.'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072'...'
      Category = 0
      Hint = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072
      Visible = ivAlways
      ShortCut = 16452
      OnClick = dxBarButton1Click
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenu1Popup
    Left = 696
    Top = 280
    PixelsPerInch = 96
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridZ
    PopupMenus = <
      item
        GridView = cxGridZTable
        HitTypes = [gvhtCell]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    OnPopup = cxGridPopupMenu1Popup
    AlwaysFireOnPopup = True
    Left = 496
    Top = 280
  end
end
