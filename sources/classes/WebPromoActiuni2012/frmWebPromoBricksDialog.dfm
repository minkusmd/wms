object frmWebPromoBricksDlg: TfrmWebPromoBricksDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Blocuri de reclama'
  ClientHeight = 535
  ClientWidth = 729
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 745
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 729
    Height = 64
    Title = 'Blocuri de reclama'
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 713
    Height = 406
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 713
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 713
      Height = 376
      Align = alClient
      TabOrder = 1
      ExplicitTop = 32
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceBlocks
        DataController.KeyFieldNames = 'PAIMAGEBRICKID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGrid_IMAGE
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTableColumn1: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'ORDERNO'
        end
        object cxGrid_IMAGE: TcxGridDBColumn
          DataBinding.FieldName = 'IMAGE'
          PropertiesClassName = 'TcxImageProperties'
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ShowFocusRect = False
          BestFitMaxWidth = 700
          FooterAlignmentHorz = taRightJustify
          MinWidth = 700
          Options.Editing = False
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Width = 700
        end
        object cxGrid_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 486
    Width = 729
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 16
    TabOrder = 5
    ExplicitTop = 484
    object btnCancel: TButton
      Left = 615
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 312
    Top = 12
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
      FloatLeft = 970
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbMoveUp'
        end
        item
          Visible = True
          ItemName = 'bbMoveDown'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbMoveUp: TdxBarButton
      Caption = 'In sus'
      Category = 0
      Hint = 'In sus'
      Visible = ivAlways
      ImageIndex = 9
      OnClick = bbMoveUpClick
    end
    object bbMoveDown: TdxBarButton
      Caption = 'In jos'
      Category = 0
      Hint = 'In jos'
      Visible = ivAlways
      ImageIndex = 8
      OnClick = bbMoveDownClick
    end
  end
  object IBCQueryBlocks: TIBCQuery
    KeyFields = 'PAIMAGEBRICKID'
    KeyGenerator = 'SQ_TWEB_PA_IMAGEBRICKS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PA_IMAGEBRICKS'
      
        '  (PAIMAGEBRICKID, PROMOACTIONID, IMAGE, IMAGE_WIDTH, IMAGE_HEIG' +
        'HT)'
      'VALUES'
      
        '  (:PAIMAGEBRICKID, :PROMOACTIONID, :IMAGE, :IMAGE_WIDTH, :IMAGE' +
        '_HEIGHT)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_PA_IMAGEBRICKS'
      'WHERE'
      '  PAIMAGEBRICKID = :Old_PAIMAGEBRICKID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PA_IMAGEBRICKS'
      'SET'
      '  PAIMAGEBRICKID = :PAIMAGEBRICKID,'
      '  PROMOACTIONID = :PROMOACTIONID,'
      '  IMAGE = :IMAGE,'
      '  IMAGE_WIDTH = :IMAGE_WIDTH,'
      '  IMAGE_HEIGHT = :IMAGE_HEIGHT'
      'WHERE'
      '  PAIMAGEBRICKID = :Old_PAIMAGEBRICKID')
    SQLRefresh.Strings = (
      'SELECT '
      ' PAIMAGEBRICKID, '
      ' PROMOACTIONID, '
      ' IMAGE, '
      ' ORDERNO,'
      ' IMAGE_WIDTH,'
      ' IMAGE_HEIGHT'
      'FROM '
      ' VW_TWEB_PA_IMAGEBRICKS'
      'WHERE'
      ' PAIMAGEBRICKID = :PAIMAGEBRICKID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PA_IMAGEBRICKS'
      'WHERE'
      'PAIMAGEBRICKID = :Old_PAIMAGEBRICKID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' PAIMAGEBRICKID, '
      ' PROMOACTIONID, '
      ' IMAGE, '
      ' ORDERNO,'
      ' IMAGE_WIDTH,'
      ' IMAGE_HEIGHT'
      'FROM '
      ' VW_TWEB_PA_IMAGEBRICKS'
      'WHERE'
      ' PROMOACTIONID = :ID'
      'ORDER BY ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 84
    Top = 204
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceBlocks: TIBCDataSource
    DataSet = IBCQueryBlocks
    Left = 84
    Top = 268
  end
end
