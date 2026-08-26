object frmCustomerCardDialog: TfrmCustomerCardDialog
  Left = 0
  Top = 0
  ActiveControl = cxGridCards
  BorderStyle = bsDialog
  Caption = 'Cartele de discount'
  ClientHeight = 402
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    791
    402)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 791
    Height = 64
    Title = 'Gestionare cartele discount'
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
    ImageIndex = 3
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 775
    Height = 273
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 775
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
    end
    object cxGridCards: TcxGrid
      Left = 0
      Top = 31
      Width = 775
      Height = 242
      Align = alClient
      TabOrder = 1
      object cxGridCardsDB: TcxGridDBTableView
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
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridCardsDBCellDblClick
        OnFocusedRecordChanged = cxGridCardsDBFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCards
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN;CUSTOMERID;'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridCards_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 21
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridCards_SN: TcxGridDBColumn
          Caption = 'Numar card'
          DataBinding.FieldName = 'SN'
          Width = 140
        end
        object cxGridCards_PRICE_COLUMN: TcxGridDBColumn
          Caption = 'Grila pret'
          DataBinding.FieldName = 'PRICE_COLUMN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGridCards_PRICE_COLUMNGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridCards_FLG_ENABLED: TcxGridDBColumn
          AlternateCaption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1082#1090#1080#1074#1085#1072
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ENABLED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridCards_REG_DATE: TcxGridDBColumn
          Caption = 'Data eliberarii'
          DataBinding.FieldName = 'REG_DATE'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.SaveTime = False
          Properties.ShowTime = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridCards_VALID_UNTIL_DATE: TcxGridDBColumn
          Caption = 'Valabil pina la'
          DataBinding.FieldName = 'VALID_UNTIL_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 110
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 110
        end
        object cxGridCards_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Eliberat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
      end
      object cxGridCardsLevel: TcxGridLevel
        GridView = cxGridCardsDB
      end
    end
  end
  object btnOk: TcxButton
    Left = 577
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 681
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 320
    Top = 144
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 38
      FloatTop = 185
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddCard'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyCard'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveCard'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddCard: TdxBarButton
      Caption = 'Adauga card'
      Category = 0
      Hint = 'Adauga card'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddCardClick
    end
    object bbModifyCard: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbModifyCardClick
    end
    object bbRemoveCard: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbRemoveCardClick
    end
  end
  object IBCDataSourceCards: TIBCDataSource
    DataSet = IBCQueryCards
    Left = 56
    Top = 152
  end
  object IBCQueryCards: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_DISCOUNT'
      
        '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, CUSTOMERI' +
        'D, FLG_ENABLED, PRICE_COLUMN, VALID_UNTIL_DATE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :SN, :CU' +
        'STOMERID, :FLG_ENABLED, :PRICE_COLUMN, :VALID_UNTIL_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_DISCOUNT'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN AND CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_DISCOUNT'
      'SET'
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_' +
        'ID = :GOODSCOMPLECT_ID, GOODSID = :GOODSID, SN = :SN, '
      '  CUSTOMERID = :CUSTOMERID, FLG_ENABLED = :FLG_ENABLED, '
      
        '  PRICE_COLUMN = :PRICE_COLUMN, VALID_UNTIL_DATE = :VALID_UNTIL_' +
        'DATE'
      'WHERE'
      '  DOCID = :Old_DOCID AND '
      '  DTDEP = :Old_DTDEP AND '
      '  CTDEP = :Old_CTDEP AND '
      '  GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      '  GOODSID = :Old_GOODSID AND '
      '  SN = :Old_SN AND '
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT'
      '    DOCID,'
      '    DTDEP,'
      '    CTDEP,'
      '    GOODSCOMPLECT_ID,'
      '    GOODSID,'
      '    SN,'
      '    CUSTOMERID,'
      '    FLG_ENABLED,'
      '    REG_DATE,'
      '    VALID_UNTIL_DATE,'
      '    CREATED_BY,'
      '    CREATED_BY_NAME,'
      '    PRICE_COLUMN'
      'FROM'
      ' VW_TS_CUST_DISCOUNT'
      'WHERE'
      
        '  DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP AND GOODS' +
        'COMPLECT_ID = :GOODSCOMPLECT_ID AND GOODSID = :GOODSID AND SN = ' +
        ':SN AND CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_DISCOUNT'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND SN = :Old_SN AND CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' DTDEP,'
      ' CTDEP,'
      ' GOODSCOMPLECT_ID,'
      ' GOODSID,'
      ' SN,'
      ' CUSTOMERID,'
      ' FLG_ENABLED,'
      ' REG_DATE,'
      ' VALID_UNTIL_DATE,'
      ' CREATED_BY,'
      ' CREATED_BY_NAME,'
      ' PRICE_COLUMN'
      'FROM'
      ' VW_TS_CUST_DISCOUNT')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 56
    Top = 208
  end
end
