inherited frame43CashTransfer: Tframe43CashTransfer
  Width = 1181
  Height = 571
  Font.Height = -15
  ExplicitWidth = 1181
  ExplicitHeight = 571
  PixelsPerInch = 120
  object pnMyTransfer: TPanel
    Left = 0
    Top = 0
    Width = 1181
    Height = 571
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1181
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridMyTransfers: TcxGrid
      Left = 0
      Top = 34
      Width = 1181
      Height = 537
      Align = alClient
      TabOrder = 1
      object cxGridMyTransfersTable: TcxGridDBTableView
        OnKeyDown = cxGridMyTransfersTableKeyDown
        OnCustomDrawCell = cxGridMyTransfersTableCustomDrawCell
        DataController.DataSource = IBCDataSourceMyTransfers
        DataController.KeyFieldNames = 'ID'
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridMyTransfers_FLG_CLOSE_DOC: TcxGridDBColumn
          Caption = 'Inchis'
          DataBinding.FieldName = 'FLG_CLOSE_DOC'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridMyTransfersTableColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'TRANSFER_TYPE'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 48
              Value = 0
            end
            item
              ImageIndex = 10
              Value = 1
            end
            item
              ImageIndex = 49
              Value = 2
            end>
          MinWidth = 24
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridMyTransfersTableColumn3: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridMyTransfers_DATA_DT: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA_DT'
          MinWidth = 120
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 120
        end
        object cxGridMyTransfers_DT_NAME: TcxGridDBColumn
          Caption = 'Din subdiviziune'
          DataBinding.FieldName = 'DT_NAME'
          MinWidth = 100
          Width = 100
        end
        object cxGridMyTransfers_USER_DT_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'USER_DT_NAME'
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object Cntb: TcxGridDBColumn
          Caption = 'Cntb'
          DataBinding.FieldName = 'FLG_ACNT_DT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object Suma: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA_DT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridMyTransfers_CURRENCY_DT_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_DT_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridMyTransfers_RATE_DT: TcxGridDBColumn
          Caption = 'Rata'
          DataBinding.FieldName = 'RATE_DT'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridMyTransfers_CT_NAME: TcxGridDBColumn
          Caption = 'In subdiviziunea'
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 100
          Width = 100
        end
        object cxGridMyTransfers_USER_CT_NAME: TcxGridDBColumn
          Caption = 'Cui'
          DataBinding.FieldName = 'USER_CT_NAME'
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridMyTransfers_FLG_ACNT_CT: TcxGridDBColumn
          Caption = 'Cntb'
          DataBinding.FieldName = 'FLG_ACNT_CT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridMyTransfers_SUMA_CT: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA_CT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridMyTransfers_CURRENCY_CT_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_CT_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridMyTransfers_RATE_CT: TcxGridDBColumn
          Caption = 'Rata de schimb'
          DataBinding.FieldName = 'RATE_CT'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridMyTransfersTableColumn2: TcxGridDBColumn
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
          DataBinding.FieldName = 'COMMENT'
          Width = 100
        end
      end
      object cxGridMyTransfersLevel: TcxGridLevel
        GridView = cxGridMyTransfersTable
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 488
    Top = 124
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1096
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = False
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1096
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = False
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1096
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTransferMoneyToUser'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbMoneyTransfer'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCurrencyEchange'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExchangeLog'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarStatic1: TdxBarStatic
      Caption = #1052#1086#1080' '#1087#1077#1088#1077#1076#1072#1095#1080
      Category = 0
      Hint = #1052#1086#1080' '#1087#1077#1088#1077#1076#1072#1095#1080
      Visible = ivAlways
      RightIndent = 16
    end
    object bbTransferMoneyToUser: TdxBarButton
      Caption = 'Transfera MF altui operator'
      Category = 0
      Hint = 'Transfera MF altui operator'
      Visible = ivAlways
      ImageIndex = 48
      OnClick = bbTransferMoneyToUserClick
    end
    object bbMoneyTransfer: TdxBarButton
      Caption = 'Transfer MF'
      Category = 0
      Hint = 'Transfer MF'
      Visible = ivAlways
      ImageIndex = 10
      OnClick = bbMoneyTransferClick
    end
    object bbCurrencyEchange: TdxBarButton
      Caption = 'Schimb valutar'
      Category = 0
      Hint = 'Schimb valutar'
      Visible = ivAlways
      ImageIndex = 49
      OnClick = bbCurrencyEchangeClick
    end
    object bbExchangeLog: TdxBarButton
      Caption = 'Istoria schimbului'
      Category = 0
      Hint = 'Istoria schimbului'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = bbExchangeLogClick
    end
  end
  object IBCDataSourceMyTransfers: TIBCDataSource
    DataSet = IBCQueryMyTransfers
    Left = 148
    Top = 184
  end
  object IBCQueryMyTransfers: TIBCQuery
    SQLRefresh.Strings = (
      
        'SELECT VW_TDB_CASH_JURNAL.ID, VW_TDB_CASH_JURNAL.CURRENCYID, VW_' +
        'TDB_CASH_JURNAL.FLG_CLOSE_DOC, VW_TDB_CASH_JURNAL.FLG_DELETE, VW' +
        '_TDB_CASH_JURNAL.FLG_DT_CONFIRMED, VW_TDB_CASH_JURNAL.FLG_CT_CON' +
        'FIRMED, VW_TDB_CASH_JURNAL.DT, VW_TDB_CASH_JURNAL.USER_DT, VW_TD' +
        'B_CASH_JURNAL.USER_DT_NAME, VW_TDB_CASH_JURNAL.SUMA_DT, VW_TDB_C' +
        'ASH_JURNAL.DATA_DT, VW_TDB_CASH_JURNAL.FLG_ACNT_DT, VW_TDB_CASH_' +
        'JURNAL.CT, VW_TDB_CASH_JURNAL.USER_CT, VW_TDB_CASH_JURNAL.USER_C' +
        'T_NAME, VW_TDB_CASH_JURNAL.SUMA_CT, VW_TDB_CASH_JURNAL.DATA_CT, ' +
        'VW_TDB_CASH_JURNAL.FLG_ACNT_CT FROM VW_TDB_CASH_JURNAL'
      'WHERE'
      '  ID = :ID')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' A.*,'
      
        ' IIF(A.CURRENCYID_DT<>A.CURRENCYID_CT,2,IIF(A.USER_DT=A.USER_CT,' +
        '1,0)) TRANSFER_TYPE'
      'FROM'
      ' VW_TDB_CASH_JURNAL A'
      'ORDER BY '
      ' DATA_DT DESC')
    Left = 148
    Top = 240
  end
end
