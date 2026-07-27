object frmWebPacheteProduseDlg: TfrmWebPacheteProduseDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pachete de produse'
  ClientHeight = 591
  ClientWidth = 1014
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
    Width = 1014
    Height = 64
    Title = 'Pachete de produse'
    Text = 'Administrarea pachetelor de produse pentru pagina web'
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
    Width = 998
    Height = 465
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 998
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridP: TcxGrid
      Left = 0
      Top = 30
      Width = 998
      Height = 435
      Align = alClient
      TabOrder = 1
      object cxGridPTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = cxGridPTableCustomDrawCell
        OnFocusedRecordChanged = cxGridPTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourcePachete
        DataController.KeyFieldNames = 'PACHET_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridP_TITLU
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
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
        object cxGridP_PACHET_ID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'PACHET_ID'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridP_TITLU: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLU'
          DataBinding.IsNullValueType = True
          VisibleForCustomization = False
          Width = 257
        end
        object cxGridP_DATA_INCHEPUT: TcxGridDBColumn
          Caption = 'Inceput'
          DataBinding.FieldName = 'DATA_INCHEPUT'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 60
        end
        object cxGridP_DATA_SFIRSIT: TcxGridDBColumn
          Caption = 'Sfirsit'
          DataBinding.FieldName = 'DATA_SFIRSIT'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 60
        end
        object cxGridP_GOODS_ID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODS_ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridP_GOODS_TITLE: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_TITLE'
          DataBinding.IsNullValueType = True
          VisibleForCustomization = False
          Width = 234
        end
        object cxGridP_GOODS_COUNT: TcxGridDBColumn
          Caption = 'Cant prod'
          DataBinding.FieldName = 'GOODS_COUNT'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridP_FLG_ENABLED: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_ENABLED'
          DataBinding.IsNullValueType = True
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object cxGridPTable_SUMA: TcxGridDBColumn
          Caption = 'Suma retail'
          DataBinding.FieldName = 'SUMA_RETAIL'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridPTable_SUMA_CATALOG: TcxGridDBColumn
          Caption = 'Suma Web'
          DataBinding.FieldName = 'SUMA_CATALOG'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_Bold
          VisibleForCustomization = False
          Width = 80
        end
        object cxGridPTable_SUMA_DIFF: TcxGridDBColumn
          Caption = 'Diferenta'
          DataBinding.FieldName = 'SUMA_DIFF'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridP_CREATED_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_NAME'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 80
        end
        object cxGridPTable_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
      end
      object cxGridPLevel: TcxGridLevel
        GridView = cxGridPTable
      end
    end
  end
  object btnClose: TButton
    Left = 903
    Top = 548
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
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
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 384
    Top = 160
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
      FloatLeft = 657
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
          ItemName = 'bbEdit'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoods'
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
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
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
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbGoods: TdxBarButton
      Caption = 'Produse'
      Category = 0
      Hint = 'Produse'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 117
      OnClick = bbGoodsClick
    end
    object bbSort: TdxBarButton
      Caption = 'Ordoneaza'
      Category = 0
      Hint = 'Ordoneaza'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
  end
  object IBCQueryPachete: TIBCQuery
    KeyFields = 'PACHET_ID'
    KeyGenerator = 'SQ_TWEB_PACHETE_PRODUSE_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TWEB_PACHETE_PRODUSE'
      
        '  (PACHET_ID, TITLU, DESCRIERE, GOODS_ID, DATA_INCHEPUT, DATA_SF' +
        'IRSIT, FLG_ENABLED)'
      'VALUES'
      
        '  (:PACHET_ID, :TITLU, :DESCRIERE, :GOODS_ID, :DATA_INCHEPUT, :D' +
        'ATA_SFIRSIT, :FLG_ENABLED)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_PACHETE_PRODUSE'
      'WHERE'
      '  PACHET_ID = :Old_PACHET_ID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_PACHETE_PRODUSE'
      'SET'
      
        '  PACHET_ID = :PACHET_ID, TITLU = :TITLU, DESCRIERE = :DESCRIERE' +
        ', GOODS_ID = :GOODS_ID, DATA_INCHEPUT = :DATA_INCHEPUT, DATA_SFI' +
        'RSIT = :DATA_SFIRSIT, FLG_ENABLED = :FLG_ENABLED'
      'WHERE'
      '  PACHET_ID = :Old_PACHET_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' PACHET_ID, '
      ' TITLU, '
      ' DESCRIERE, '
      ' GOODS_ID, '
      ' GOODS_TITLE, '
      ' DATA_INCHEPUT, '
      ' DATA_SFIRSIT, '
      ' CREATED_BY, '
      ' CREATED_NAME, '
      ' CREATED_DATE, '
      ' FLG_ENABLED, '
      ' GOODS_COUNT,'
      ' SUMA_CATALOG,'
      ' SUMA_RETAIL,'
      ' SUMA_DIFF'
      'FROM '
      ' SP_WEB_GET_PACHETE_PRODUSE'
      'WHERE'
      ' PACHET_ID = :PACHET_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TWEB_PACHETE_PRODUSE'
      'WHERE'
      'PACHET_ID = :Old_PACHET_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' PACHET_ID, '
      ' TITLU, '
      ' DESCRIERE, '
      ' GOODS_ID, '
      ' GOODS_TITLE, '
      ' DATA_INCHEPUT, '
      ' DATA_SFIRSIT, '
      ' CREATED_BY, '
      ' CREATED_NAME, '
      ' CREATED_DATE, '
      ' FLG_ENABLED, '
      ' GOODS_COUNT,'
      ' SUMA_CATALOG,'
      ' SUMA_RETAIL,'
      ' SUMA_DIFF'
      'FROM '
      ' SP_WEB_GET_PACHETE_PRODUSE'
      'ORDER BY'
      ' ORDERNO')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 96
    Top = 152
  end
  object IBCDataSourcePachete: TIBCDataSource
    DataSet = IBCQueryPachete
    Left = 100
    Top = 213
  end
end
