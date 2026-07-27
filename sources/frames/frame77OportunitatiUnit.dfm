inherited frame77Oportunitati: Tframe77Oportunitati
  Font.Height = -15
  PixelsPerInch = 120
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 668
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object cxGridOportunitati: TcxGrid
      Left = 0
      Top = 0
      Width = 986
      Height = 668
      Align = alClient
      TabOrder = 0
      object cxGridOportunitatiTable: TcxGridDBTableView
        OnKeyDown = cxGridOportunitatiTableKeyDown
        OnCellDblClick = cxGridOportunitatiTableCellDblClick
        DataController.DataModeController.GridModeBufferCount = 40
        DataController.DataSource = dmDB.IBCDataSourceOportunitati
        DataController.KeyFieldNames = 'ID'
        FilterRow.SeparatorWidth = 8
        FilterRow.ApplyChanges = fracDelayed
        FilterRow.OperatorCustomization = True
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NavigatorOffset = 63
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GridLineColor = 13750737
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridOportunitatiTableID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
        end
        object cxGridOportunitatiTableDATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          PropertiesClassName = 'TcxDateEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 82
          Options.HorzSizing = False
          Width = 82
        end
        object cxGridOportunitatiTableSUBIECT: TcxGridDBColumn
          Caption = 'Subiect'
          DataBinding.FieldName = 'SUBIECT'
          PropertiesClassName = 'TcxTextEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 391
        end
        object cxGridOportunitatiTableCLIENT_POTENTIAL: TcxGridDBColumn
          Caption = 'Client potential'
          DataBinding.FieldName = 'CLIENT_POTENTIAL'
          PropertiesClassName = 'TcxTextEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 266
        end
        object cxGridOportunitatiTableDATA_ESTIMATA: TcxGridDBColumn
          Caption = 'Data estimata'
          DataBinding.FieldName = 'DATA_ESTIMATA'
          PropertiesClassName = 'TcxDateEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridOportunitatiTableVENIT_ESTIMAT: TcxGridDBColumn
          Caption = 'Venit estimat'
          DataBinding.FieldName = 'VENIT_ESTIMAT'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridOportunitatiTablePROBABILITATE: TcxGridDBColumn
          Caption = 'Probabilitate'
          DataBinding.FieldName = 'PROBABILITATE'
          PropertiesClassName = 'TcxProgressBarProperties'
          Properties.PeakSize = 3
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridOportunitatiTableEVALUARE: TcxGridDBColumn
          Caption = 'Evaluare'
          DataBinding.FieldName = 'EVALUARE'
          PropertiesClassName = 'TdxRatingControlProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridOportunitatiTableCREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de...'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 150
          Options.HorzSizing = False
          Width = 150
        end
        object cxGridOportunitatiTableRESPONSABIL: TcxGridDBColumn
          Caption = 'Responsabil'
          DataBinding.FieldName = 'RESPONSABIL_USER'
          HeaderAlignmentHorz = taCenter
          Width = 120
        end
        object cxGridOportunitatiTableStatus_ID: TcxGridDBColumn
          Caption = 'Statut'
          DataBinding.FieldName = 'STATUS_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
      end
      object cxGridOportunitatiLevel: TcxGridLevel
        GridView = cxGridOportunitatiTable
      end
    end
  end
  object dxBarManager: TdxBarManager
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
    Left = 464
    Top = 120
    PixelsPerInch = 120
  end
end
