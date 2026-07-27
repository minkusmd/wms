object frmGoodsKitEditorDialog: TfrmGoodsKitEditorDialog
  Left = 0
  Top = 0
  ActiveControl = cxGridComplecte
  BorderStyle = bsDialog
  Caption = 'Complecte'
  ClientHeight = 685
  ClientWidth = 923
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    923
    685)
  TextHeight = 15
  object Label1: TLabel
    Left = 18
    Top = 650
    Width = 241
    Height = 15
    Caption = 'Folositi "+" si "-" pentru modificarea cantitatii'
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 923
    Height = 64
    Title = 'Complectatia'
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
    ImageIndex = 21
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 907
    Height = 563
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 903
      Height = 47
      Align = alTop
      Shape = bsSpacer
      ExplicitWidth = 858
    end
    object cxLabel1: TLabel
      Left = 8
      Top = 15
      Width = 52
      Height = 15
      Caption = 'Complect'
    end
    object edGoodsID: TcxDBTextEdit
      Left = 72
      Top = 12
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 72
    end
    object edGoodsTitle: TcxDBTextEdit
      Left = 148
      Top = 12
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 747
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 8
      Top = 47
      Width = 887
      Height = 30
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridComplecte: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 77
      Width = 887
      Height = 474
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      TabOrder = 3
      object cxGridComplecteTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu
        OnKeyDown = cxGridComplecteTableKeyDown
        Navigator.Buttons.CustomButtons = <>
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
        FindPanel.DisplayMode = fpdmAlways
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridComplecteTableCellDblClick
        OnFocusedRecordChanged = cxGridComplecteTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGoodsComplecte
        DataController.KeyFieldNames = 'PARENTGOODS_ID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            Column = cxGridComplecte_QTY
          end
          item
            Kind = skCount
            Column = cxGridComplecte_GOODSID
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridComplecte_SUMA
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
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
        object cxGridComplecte_ORDERNO: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 40
        end
        object cxGridComplecte_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridComplecte_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Items = <>
          MinWidth = 24
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridComplecte_TITLE: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_TITLE'
          DataBinding.IsNullValueType = True
          Options.Editing = False
          Options.Moving = False
        end
        object cxGridComplecte_UM_TITLE: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_TITLE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridComplecte_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 80
        end
        object cxGridComplecte_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridComplecte_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.Expression = #1'[Cant]*[Pret]'
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridComplecte_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 36
        end
        object cxGridComplecte_FLG_FORCED_ADDON: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FORCED_ADDON'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = frmGoodsBrowser.cxImageList1
          Properties.Items = <
            item
              Description = 'putin'
              ImageIndex = 0
              Value = 2
            end
            item
              Description = 'mult'
              ImageIndex = 1
              Value = 1
            end
            item
              Description = 'la comanda'
              ImageIndex = 2
              Value = 4
            end
            item
              Description = 'in asteptare'
              ImageIndex = 3
              Value = 3
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridComplecte_FLG_FORCED: TcxGridDBColumn
          Caption = 'F'
          DataBinding.FieldName = 'FLG_FORCED'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridComplecte_FLG_MODIFY_QTY: TcxGridDBColumn
          Caption = 'MQ'
          DataBinding.FieldName = 'FLG_MODIFY_QTY'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
      end
      object cxGridComplecteLevel: TcxGridLevel
        GridView = cxGridComplecteTable
      end
    end
  end
  object btnCancel: TcxButton
    Left = 811
    Top = 651
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object btnOk: TcxButton
    Left = 711
    Top = 651
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 424
    Top = 216
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Info'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 515
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewItem'
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
          ItemName = 'bbRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSortItems'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewItem: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewItemClick
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
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbImportFromDoc: TdxBarButton
      Caption = 'Import din document'
      Category = 0
      Hint = 'Import din document'
      Visible = ivAlways
      ImageIndex = 14
      OnClick = bbImportFromDocClick
    end
    object bbSortItems: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortItemsClick
    end
    object bbChangeActiveState: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100
      Visible = ivAlways
      ShortCut = 16449
      OnClick = bbChangeActiveStateClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Aditional'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbEditGoodsPrice'
        end
        item
          Visible = True
          ItemName = 'bbForeignGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPasteFromClipboard'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportFromDoc'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'bbCopyNames'
        end>
    end
    object bbEditGoodsPrice: TdxBarButton
      Caption = 'Modifica preturi produs'
      Category = 0
      Hint = 'Modifica preturi produs'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbEditGoodsPriceClick
    end
    object bbForeignGoods: TdxBarButton
      Caption = 'Coduri produse furnizori'
      Category = 0
      Hint = 'Coduri produse furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbForeignGoodsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Modifica pretul in complect'
      Category = 0
      Hint = 'Modifica pretul in complect'
      Visible = ivAlways
      ShortCut = 117
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Action = actImportFromAnotherGoods
      Category = 0
    end
    object bbCopyNames: TdxBarButton
      Caption = 'Copy'
      Category = 0
      Hint = 'Copy'
      Visible = ivAlways
      OnClick = bbCopyNamesClick
    end
    object bbPasteFromClipboard: TdxBarButton
      Caption = 'Paste Cod Intern'
      Category = 0
      Hint = 'Paste Cod Intern'
      Visible = ivAlways
      OnClick = bbPasteFromClipboardClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Nuleaza cantitatea'
      Category = 0
      Hint = 'Nuleaza cantitatea'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Paste Cod Furnizor'
      Category = 0
      Hint = 'Paste Cod Furnizor'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
  end
  object IBCDataSourceGoodsComplecte: TIBCDataSource
    DataSet = IBCQueryGoodsComplecte
    Left = 92
    Top = 220
  end
  object IBCQueryGoodsComplecte: TIBCQuery
    KeyFields = 'PARENTGOODS_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_COMPLECTE'
      
        '  (PARENTGOODS_ID, GOODSID, QTY, ORDERNO, FLG_ACTIVE, FLG_MODIFY' +
        '_QTY)'
      'VALUES'
      
        '  (:PARENTGOODS_ID, :GOODSID, :QTY, :ORDERNO, :FLG_ACTIVE, :FLG_' +
        'MODIFY_QTY)')
    SQLDelete.Strings = (
      'DELETE FROM TS_COMPLECTE'
      'WHERE'
      '  PARENTGOODS_ID = :Old_PARENTGOODS_ID '
      '  AND '
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_COMPLECTE'
      'SET'
      '  PARENTGOODS_ID = :PARENTGOODS_ID, '
      '  GOODSID = :GOODSID, '
      '  QTY = :QTY, '
      '  ORDERNO = :ORDERNO, '
      '  FLG_ACTIVE = :FLG_ACTIVE,'
      '  FLG_MODIFY_QTY = :FLG_MODIFY_QTY'
      'WHERE'
      '  PARENTGOODS_ID = :Old_PARENTGOODS_ID AND '
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TS_COMPLECTE'
      'WHERE'
      ' (PARENTGOODS_ID = :PARENTGOODS_ID) AND (GOODSID = :GOODSID)')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_COMPLECTE'
      'WHERE'
      ' PARENTGOODS_ID = :Old_PARENTGOODS_ID '
      ' AND '
      ' GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateGoodsComplecte
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TS_COMPLECTE'
      'ORDER BY '
      ' ORDERNO')
    MasterFields = 'GOODSID'
    DetailFields = 'PARENTGOODS_ID'
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.StrictUpdate = False
    Left = 93
    Top = 272
  end
  object IBCTrUpdateGoodsComplecte: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 92
    Top = 328
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewItem'
      end
      item
        Visible = True
        ItemName = 'bbImportFromDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbModify'
      end
      item
        Visible = True
        ItemName = 'bbChangeActiveState'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemove'
      end>
    UseOwnFont = False
    Left = 260
    Top = 220
    PixelsPerInch = 96
  end
  object ActionList1: TActionList
    Left = 424
    Top = 280
    object actImportFromAnotherGoods: TAction
      Caption = 'Import din alt complect'
      OnExecute = actImportFromAnotherGoodsExecute
    end
  end
end
