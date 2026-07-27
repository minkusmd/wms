object frmWebPacheteGoodsDlg: TfrmWebPacheteGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse din pachet'
  ClientHeight = 389
  ClientWidth = 811
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 811
    Height = 64
    Title = 'Produse din pachet'
    Text = 'Administrarea produselor din componen'#539'a pachetului'
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
    Width = 795
    Height = 262
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 30
      Width = 795
      Height = 232
      Align = alClient
      TabOrder = 1
      ExplicitTop = 29
      object cxGridGoodsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'PACHET_ID;GOODS_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridGoods_GOODSID
          end
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'PRICE_CATALOG'
            Column = cxGridGoods_PRICE_CATALOG
          end
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'PRICE'
            Column = cxGridGoods_PRICE
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoods_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODS_ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Editing = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_IMG: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Editing = False
          Options.Focusing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridGoods_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          DataBinding.IsNullValueType = True
          Options.Editing = False
          Width = 320
        end
        object cxGridGoods_ORDERNO: TcxGridDBColumn
          Caption = 'Ordine'
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
        object cxGridGoods_PRICE_CATALOG: TcxGridDBColumn
          Caption = 'Pret catalog'
          DataBinding.FieldName = 'PRICE_CATALOG'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
        end
        object cxGridGoods_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 78
        end
        object cxGridGoods_DISCOUNT: TcxGridDBColumn
          Caption = 'Reducere'
          DataBinding.FieldName = 'discount'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 63
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 795
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object btnOk: TButton
    Left = 600
    Top = 353
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 700
    Top = 353
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
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
    Left = 380
    Top = 28
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
      FloatLeft = 589
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSort'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbSort: TdxBarButton
      Caption = 'Sorteaza'
      Category = 0
      Hint = 'Sorteaza'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PACHET_CONTINUT'
      '  (PACHET_ID, GOODS_ID, ORDERNO, GOODS_NAME, PRICE, DISCOUNT)'
      'VALUES'
      
        '  (:PACHET_ID, :GOODS_ID, :ORDERNO, :GOODS_NAME, :PRICE, :DISCOU' +
        'NT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_PACHET_CONTINUT'
      'WHERE'
      '  PACHET_ID = :Old_PACHET_ID AND GOODS_ID = :Old_GOODS_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PACHET_CONTINUT'
      'SET'
      
        '  PACHET_ID = :PACHET_ID, GOODS_ID = :GOODS_ID, ORDERNO = :ORDER' +
        'NO, GOODS_NAME = :GOODS_NAME, PRICE = :PRICE, DISCOUNT = :DISCOU' +
        'NT'
      'WHERE'
      '  PACHET_ID = :Old_PACHET_ID AND GOODS_ID = :Old_GOODS_ID')
    SQLRefresh.Strings = (
      
        'SELECT PACHET_ID, GOODS_ID, ORDERNO, GOODS_NAME, PRICE, DISCOUNT' +
        ' FROM VW_TWEB_PACHET_CONTINUT'
      'WHERE'
      '  PACHET_ID = :PACHET_ID AND GOODS_ID = :GOODS_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PACHET_CONTINUT'
      'WHERE'
      'PACHET_ID = :Old_PACHET_ID AND GOODS_ID = :Old_GOODS_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_PACHET_CONTINUT'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' PACHET_ID, '
      ' GOODS_ID, '
      ' GOODS_NAME,'
      
        '( select price_mdl from get_goods_price(goods_id, 1, 498, 498)) ' +
        'price_catalog,'
      ' PRICE,'
      ' ORDERNO,'
      ' DISCOUNT '
      'FROM '
      ' VW_TWEB_PACHET_CONTINUT'
      'ORDER BY'
      ' ORDERNO')
    MasterFields = 'PACHET_ID'
    DetailFields = 'PACHET_ID'
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 96
    Top = 172
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 100
    Top = 128
  end
end
