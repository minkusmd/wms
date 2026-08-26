inherited frame77Oportunitati: Tframe77Oportunitati
  Width = 1156
  Height = 645
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 1156
    Height = 645
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 451
    ExplicitHeight = 305
    object cxGridOportunitati: TcxGrid
      Left = 0
      Top = 0
      Width = 1156
      Height = 645
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 451
      ExplicitHeight = 305
      object cxGridOportunitatiTable: TcxGridDBTableView
        OnKeyDown = cxGridOportunitatiTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridOportunitatiTableCellDblClick
        DataController.DataModeController.GridModeBufferCount = 40
        DataController.KeyFieldNames = 'INCIDENTID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.Indicator = True
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      end
      object cxGridOportunitatiLevel: TcxGridLevel
        GridView = cxGridOportunitatiTable
      end
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
    Left = 464
    Top = 120
    PixelsPerInch = 96
  end
end
