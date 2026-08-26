object frmSupplierGroupsDlg: TfrmSupplierGroupsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Grupe de furnizori'
  ClientHeight = 498
  ClientWidth = 935
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 935
    Height = 64
    Title = 'Grupe de furnizori'
    Text = 'Gestionarea grupelor de furnizori'
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 919
    Height = 373
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 409
      Height = 373
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvLowered
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object cxGridSupplierGroups: TcxGrid
        Left = 1
        Top = 31
        Width = 403
        Height = 105
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 337
        object cxGridSupplierGroupsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceSupplierGroups
          DataController.KeyFieldNames = 'SGID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridSupplierGroupsTable_GG_ID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'SGID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridSupplierGroupsTable_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 612
          end
          object cxGridSupplierGroupsTableColumn1: TcxGridDBColumn
            Caption = 'Cost'
            DataBinding.FieldName = 'flg_cost_in_price'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
          end
          object cxGridSupplierGroupsTableColumn2: TcxGridDBColumn
            Caption = 'Implicit'
            DataBinding.FieldName = 'FLG_DEFAULT_SUPPLIER'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
          end
        end
        object cxGridSupplierGroupsLevel: TcxGridLevel
          GridView = cxGridSupplierGroupsTable
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 1
        Top = 1
        Width = 403
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object Panel2: TPanel
        Left = 1
        Top = 136
        Width = 403
        Height = 232
        Align = alBottom
        BevelKind = bkFlat
        BevelOuter = bvLowered
        Color = clWindow
        ParentBackground = False
        TabOrder = 2
        object cxGrid1: TcxGrid
          Left = 1
          Top = 27
          Width = 397
          Height = 200
          Align = alClient
          TabOrder = 0
          ExplicitTop = 30
          ExplicitHeight = 115
          object cxGridDBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = IBCDataSourceSupplierGroupItems
            DataController.KeyFieldNames = 'SGID;SUPPLIERID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'SUPPLIERID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = 'Furnizor'
              DataBinding.FieldName = 'SUPPLIER_NAME'
              HeaderAlignmentHorz = taCenter
              Width = 612
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableView1
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 1
          Top = 1
          Width = 397
          Height = 26
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
    end
    object Panel3: TPanel
      Left = 409
      Top = 0
      Width = 510
      Height = 373
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      ExplicitTop = -2
      object cxGrid2: TcxGrid
        Left = 0
        Top = 0
        Width = 506
        Height = 369
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 128
        ExplicitTop = 72
        ExplicitWidth = 250
        ExplicitHeight = 200
        object cxGrid2DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 445
    Width = 935
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnSelect: TButton
      AlignWithMargins = True
      Left = 723
      Top = 12
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnClose: TButton
      Left = 821
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 432
    Top = 8
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
      FloatLeft = 728
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'SupplierToolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 953
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Adauga furnizor'
      Category = 0
      Hint = 'Adauga furnizor'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = dxBarButton2Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = dxBarButton5Click
    end
  end
  object IBCQuerySupplierGroups: TIBCQuery
    KeyFields = 'SGID'
    KeyGenerator = 'gen_tprice_supplier_groups_id'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TPRICE_SUPPLIER_GROUPS'
      '  (SGID, TITLE, FLG_COST_IN_PRICE, FLG_DEFAULT_SUPPLIER)'
      'VALUES'
      '  (:SGID, :TITLE, :FLG_COST_IN_PRICE, :FLG_DEFAULT_SUPPLIER)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE_SUPPLIER_GROUPS'
      'WHERE'
      '  SGID = :Old_SGID')
    SQLUpdate.Strings = (
      'UPDATE TPRICE_SUPPLIER_GROUPS'
      'SET'
      
        '  SGID = :SGID, TITLE = :TITLE, FLG_COST_IN_PRICE = :FLG_COST_IN' +
        '_PRICE, FLG_DEFAULT_SUPPLIER = :FLG_DEFAULT_SUPPLIER'
      'WHERE'
      '  SGID = :Old_SGID')
    SQLRefresh.Strings = (
      
        'SELECT SGID, TITLE, FLG_COST_IN_PRICE, FLG_DEFAULT_SUPPLIER FROM' +
        ' TPRICE_SUPPLIER_GROUPS'
      'WHERE'
      '  SGID = :SGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_SUPPLIER_GROUPS'
      'WHERE'
      'SGID = :Old_SGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE_SUPPLIER_GROUPS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGGUpdate
    SQL.Strings = (
      'select * from tprice_supplier_groups '
      'ORDER BY TITLE')
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 32
    Top = 104
  end
  object IBCDataSourceSupplierGroups: TIBCDataSource
    DataSet = IBCQuerySupplierGroups
    Left = 32
    Top = 160
  end
  object IBCTrGGUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 288
    Top = 12
  end
  object IBCQuerySupplierGroupItems: TIBCQuery
    KeyFields = 'gsid;supplierid'
    SQLInsert.Strings = (
      'INSERT INTO VW_SUPPLIER_GROUP_ITEMS'
      '  (SGID, SUPPLIERID, SUPPLIER_NAME)'
      'VALUES'
      '  (:SGID, :SUPPLIERID, :SUPPLIER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_SUPPLIER_GROUP_ITEMS'
      'WHERE'
      '  SGID = :Old_SGID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLUpdate.Strings = (
      'UPDATE VW_SUPPLIER_GROUP_ITEMS'
      'SET'
      
        '  SGID = :SGID, SUPPLIERID = :SUPPLIERID, SUPPLIER_NAME = :SUPPL' +
        'IER_NAME'
      'WHERE'
      '  SGID = :Old_SGID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLRefresh.Strings = (
      
        'SELECT SGID, SUPPLIERID, SUPPLIER_NAME FROM VW_SUPPLIER_GROUP_IT' +
        'EMS'
      'WHERE'
      '  SGID = :SGID AND SUPPLIERID = :SUPPLIERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_SUPPLIER_GROUP_ITEMS'
      'WHERE'
      'SGID = :Old_SGID AND SUPPLIERID = :Old_SUPPLIERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_SUPPLIER_GROUP_ITEMS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGGUpdate
    SQL.Strings = (
      'select * from VW_SUPPLIER_GROUP_ITEMS')
    MasterFields = 'SGID'
    DetailFields = 'SGID'
    MasterSource = IBCDataSourceSupplierGroups
    Left = 72
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SGID'
        Value = nil
      end>
  end
  object IBCDataSourceSupplierGroupItems: TIBCDataSource
    DataSet = IBCQuerySupplierGroupItems
    Left = 72
    Top = 344
  end
end
