object frmCompositeScetFacturaDlg: TfrmCompositeScetFacturaDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Factur'#259' fiscal'#259' complex'#259
  ClientHeight = 602
  ClientWidth = 770
  Color = clBtnFace
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
    Width = 770
    Height = 64
    Title = 'Factur'#259' fiscal'#259' complex'#259
    Text = 
      #206'mpreunarea produselor din diferite transferuri '#238'ntr-o singur'#259' f' +
      'actur'#259' fiscal'#259
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
    ImageIndex = 10
    ExplicitTop = -3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 754
    Height = 477
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object cxGridD: TcxGrid
      Left = 0
      Top = 28
      Width = 750
      Height = 282
      Align = alClient
      TabOrder = 0
      object cxGridDTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridDTableFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Nu sunt '#238'nregistr'#259'ri>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.OnGetContentStyle = cxGridDTableStylesGetContentStyle
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridD_Selection: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridD_DOCID: TcxGridColumn
          Caption = 'Cod'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Editing = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridD_DATA: TcxGridColumn
          Caption = 'Data'
          DataBinding.ValueType = 'DateTime'
          OnGetDisplayText = cxGridD_DATAGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.Editing = False
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridD_CTDEP_NAME: TcxGridColumn
          Caption = 'Depozit destinatar'
          Options.Editing = False
          Width = 200
        end
        object cxGridD_CREATED_BY_NAME: TcxGridColumn
          Caption = 'Utilizator'
          Options.Editing = False
          Width = 100
        end
      end
      object cxGridDLevel: TcxGridLevel
        GridView = cxGridDTable
      end
    end
    object cxGridJ: TcxGrid
      AlignWithMargins = True
      Left = 0
      Top = 312
      Width = 750
      Height = 161
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      TabOrder = 1
      object cxGridJTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceJurnalLocal
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Nu sunt '#238'nregistr'#259'ri>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridJTableColumn1: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 26
          Options.HorzSizing = False
          Width = 26
        end
        object cxGridJ_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridJ_GOODS_NAME: TcxGridDBColumn
          Caption = 'Denumire produs'
          DataBinding.FieldName = 'GOODS_NAME'
        end
        object cxGridJ_QTY: TcxGridDBColumn
          AlternateCaption = 'Cantitate'
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridJ_UM_NAME: TcxGridDBColumn
          AlternateCaption = 'Unitate de m'#259'sur'#259
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridJ_PRICE: TcxGridDBColumn
          Caption = 'Pre'#539
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridJ_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGridJLevel: TcxGridLevel
        GridView = cxGridJTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 750
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 557
    Width = 770
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnCancel: TButton
      Left = 656
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      AlignWithMargins = True
      Left = 558
      Top = 4
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
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
    Left = 536
    Top = 8
    DockControlHeights = (
      0
      0
      0
      0)
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
      FloatLeft = 794
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 99
          Visible = True
          ItemName = 'bdcDate'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 283
          Visible = True
          ItemName = 'beiFirms'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bdcDate: TdxBarDateCombo
      Caption = 'Data'
      Category = 0
      Hint = 'Data'
      Visible = ivAlways
      OnChange = bdcDateChange
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD00000000000DDDDD0FFFFFFFFF0D00000F0000000F0D0FFF0FFFFFFF
        FF0D0F000FFF11FFFF0D0FFF0FFF11FFFF0D0FF10FFFF11FFF0D0FF10FFFFF11
        FF0D0FF10FF11111FF0D0FF10FFFFFFFFF0D0FF104444444440D0FFF04444444
        440D044400000000000D04444444440DDDDD00000000000DDDDD}
      ShowCaption = True
      ShowEditor = False
      ShowClearButton = False
      ShowDayText = False
    end
    object dxBarLookupCombo1: TdxBarLookupCombo
      Caption = #1060#1080#1088#1084#1072
      Category = 0
      Hint = #1060#1080#1088#1084#1072
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDD000000000000000D0FFFF0FFFFFFFF0D0F77F0F777777F0D0CCCC0CCCCCC
        CC0D0C77C0C777777C0D0CCCC0CCCCCCCC0D0F77F0F777777F0D0FFFF0FFFFFF
        FF0D0F77F0F777777F0D0FFFF0FFFFFFFF0D000000000000000D0FFFCCCCFFF0
        DDDD0F777777FFF0DDDD0FFFCCCCFFF0DDDD000000000000DDDD}
      ShowCaption = True
      ShowEditor = False
      KeyField = 'CUSTOMERID'
      ListField = 'DISPLAYNAME'
      ListSource = dmDB.IBCDataSourceFirms
      RowCount = 7
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = #1060#1080#1088#1084#1072
      Category = 0
      Hint = #1060#1080#1088#1084#1072
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxExtLookupComboBoxProperties'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      InternalEditValue = 0
    end
    object beiFirms: TcxBarEditItem
      Caption = 'Destinatar'
      Category = 0
      Hint = 'Destinatar'
      Visible = ivAlways
      OnChange = beiFirmsChange
      ShowCaption = True
      PropertiesClassName = 'TcxImageComboBoxProperties'
      Properties.DropDownRows = 16
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ImmediatePost = True
      Properties.Items = <>
      InternalEditValue = 0
    end
  end
  object IBCQueryDocsLocal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM VW_TDB_DOCS V'
      'WHERE '
      ' (FLG_CLOSED=1) AND '
      ' (FLG_ACNT=1) AND '
      ' (DT=:currFirma) AND'
      ' (CT=:targetFirma) AND '
      ' (CAST(DATA as DATE)=:data) AND'
      ' (DOCTYPEID = 114)'
      ''
      
        ' AND NOT EXISTS(SELECT 1 FROM TDB_DOCS D WHERE D.DOCTYPEID=112 A' +
        'ND D.PARENTDOCID=V.DOCID)'
      ' AND NOT EXISTS('
      '                SELECT 1'
      '                FROM TDB_DOCS_PARENTS P'
      '                INNER JOIN TDB_DOCS D2 ON D2.DOCID = P.DOCID'
      '                WHERE P.PARENT_ID = V.DOCID AND D2.DOCTYPEID=112'
      '               )')
    Left = 180
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'currFirma'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'targetFirma'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data'
        Value = nil
      end>
  end
  object IBCDataSourceDocsLocal: TIBCDataSource
    DataSet = IBCQueryDocsLocal
    Left = 180
    Top = 120
  end
  object IBCQueryJurnalLocal: TIBCQuery
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocsLocal
    Options.DetailDelay = 150
    Left = 340
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalLocal: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryJurnalLocal
    Left = 340
    Top = 144
  end
end
