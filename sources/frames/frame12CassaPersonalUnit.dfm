inherited frame12CassaPersonal: Tframe12CassaPersonal
  Width = 1154
  Height = 658
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 1154
  ExplicitHeight = 658
  object pnBottom: TPanel
    Left = 0
    Top = 159
    Width = 1154
    Height = 499
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Padding.Top = 5
    TabOrder = 1
    object cxLabel1: TcxLabel
      Left = 0
      Top = 5
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Rezerve deschise'
      Style.TextStyle = [fsBold]
      TabOrder = 0
    end
    object cxGridOI: TcxGrid
      Left = 0
      Top = 24
      Width = 1154
      Height = 475
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 1
      object cxGridOITable: TcxGridDBTableView
        OnKeyDown = cxGridOITableKeyDown
        OnCustomDrawCell = cxGridOITableCustomDrawCell
        DataController.DataSource = IBCDataSourceOI
        DataController.KeyFieldNames = 'DOCID'
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridOI_DOCID: TcxGridDBColumn
          Caption = 'Docid'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridOI_DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 64
        end
        object cxGridOI_CT_NAME: TcxGridDBColumn
          Caption = 'Debitor'
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 13
          Width = 128
        end
        object cxGridOI_DOCTYPE_NAME: TcxGridDBColumn
          Caption = 'Tip document'
          DataBinding.FieldName = 'DOCTYPE_NAME'
          MinWidth = 13
          Width = 128
        end
        object cxGridOI_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridOI_CURRENCY_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
        end
        object cxGridOI_RATE: TcxGridDBColumn
          Caption = 'Rata'
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridOI_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 77
          Options.HorzSizing = False
          Width = 77
        end
      end
      object cxGridOILevel: TcxGridLevel
        GridView = cxGridOITable
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 0
    Width = 1154
    Height = 159
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    BevelOuter = bvNone
    Padding.Top = 2
    TabOrder = 0
    object pnMoneyTransfer: TPanel
      AlignWithMargins = True
      Left = 239
      Top = 2
      Width = 915
      Height = 157
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object cxLabel2: TcxLabel
        Left = 0
        Top = 0
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Transferuri neprimite'
        Style.TextStyle = [fsBold]
        TabOrder = 0
      end
      object cxGridToMe: TcxGrid
        Left = 0
        Top = 19
        Width = 915
        Height = 138
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        object cxGridToMeTable: TcxGridDBTableView
          PopupMenu = pmNonConfirmedTransfers
          OnKeyDown = cxGridToMeTableKeyDown
          OnCustomDrawCell = cxGridToMeTableCustomDrawCell
          DataController.DataSource = IBCDataSourceNonConfirmedTransfers
          DataController.KeyFieldNames = 'ID'
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA_DT'
            HeaderAlignmentHorz = taCenter
            MinWidth = 77
            Options.HorzSizing = False
            Width = 77
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'DT_NAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 13
            Width = 64
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'De la operator'
            DataBinding.FieldName = 'USER_DT_NAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 77
            Options.HorzSizing = False
            Width = 77
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Cntb'
            DataBinding.FieldName = 'FLG_ACNT_DT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 22
            Options.HorzSizing = False
            Width = 22
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA_DT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 45
            Options.HorzSizing = False
            Width = 45
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'Valuta'
            DataBinding.FieldName = 'CURRENCY_DT_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 38
            Options.HorzSizing = False
            Width = 38
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Beneficiar'
            DataBinding.FieldName = 'CT_NAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 13
            Width = 64
          end
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = #1050#1086#1084#1091
            DataBinding.FieldName = 'USER_CT_NAME'
            Visible = False
            MinWidth = 77
            Options.HorzSizing = False
            Width = 77
          end
          object cxGridDBColumn9: TcxGridDBColumn
            Caption = 'Cntb'
            DataBinding.FieldName = 'FLG_ACNT_CT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 22
            Options.HorzSizing = False
            Width = 22
          end
          object cxGridToMe_COMMENT: TcxGridDBColumn
            Caption = 'Mentiuni'
            DataBinding.FieldName = 'COMMENT'
            HeaderAlignmentHorz = taCenter
            MinWidth = 13
            Width = 64
          end
        end
        object cxGridToMeLevel: TcxGridLevel
          GridView = cxGridToMeTable
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 2
      Width = 237
      Height = 157
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 0
      object cxLabel8: TcxLabel
        Left = 0
        Top = 0
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Casa personala'
        Style.TextStyle = [fsBold]
        TabOrder = 0
      end
      object cxGridКасса: TcxGrid
        Left = 0
        Top = 19
        Width = 237
        Height = 138
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 1
        object cxGridКассаTable: TcxGridDBTableView
          PopupMenu = pmTransferMoney
          OnKeyDown = cxGridКассаTableKeyDown
          OnCustomDrawCell = cxGridКассаTableCustomDrawCell
          DataController.DataSource = IBCDataSourcePersonalCash
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssNone
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridКассаTable_CURRENCY_NAME: TcxGridDBColumn
            Caption = 'Valuta'
            DataBinding.FieldName = 'CURRENCY_TITLE'
            MinWidth = 70
            Width = 70
          end
          object cxGridКассаTable_AMOUNT: TcxGridDBColumn
            Caption = 'Total'
            DataBinding.FieldName = 'SUMA_TOT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 51
            Options.HorzSizing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            Width = 51
          end
          object cxGridКассаTable_AMOUNT_ACCOUNT: TcxGridDBColumn
            Caption = 'Transfer'
            DataBinding.FieldName = 'SUMA_CONTAB'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 51
            Options.HorzSizing = False
            Width = 51
          end
          object cxGridКассаTable_AMOUNT_CASH: TcxGridDBColumn
            Caption = 'Numerar'
            DataBinding.FieldName = 'SUMA_CASH'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 51
            Options.HorzSizing = False
            Width = 51
          end
        end
        object cxGridКассаLevel: TcxGridLevel
          GridView = cxGridКассаTable
        end
      end
    end
  end
  object IBCQueryPersonalCash: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' SP_CASA_PE_FIRMA_NEW(CURRENT_DATE)'
      'WHERE '
      ' (USERID=:USERID)'
      ' AND'
      ' ((SUMA_CASH<>0) OR (SUMA_CONTAB<>0))')
    Left = 324
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourcePersonalCash: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryPersonalCash
    Left = 172
    Top = 64
  end
  object IBCQueryOI: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      '* '
      'FROM '
      ' SP_SELECT_OPENINVOICES(:USERID,:DATA1,:DATA2)'
      'ORDER BY'
      ' DOCID')
    Left = 188
    Top = 332
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end>
  end
  object IBCDataSourceOI: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryOI
    Left = 84
    Top = 332
  end
  object IBCDataSourceNonConfirmedTransfers: TIBCDataSource
    DataSet = IBCQueryNonConfirmedTransfers
    Left = 596
    Top = 80
  end
  object IBCQueryNonConfirmedTransfers: TIBCQuery
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_CASH_JURNAL'
      'WHERE'
      '  ID = :ID')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM VW_TDB_CASH_JURNAL'
      'WHERE (FLG_CT_CONFIRMED=0) AND (USER_CT=:USERID)')
    Left = 596
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
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
    Left = 532
    Top = 348
    PixelsPerInch = 96
    object bbAcceptMoneyTransfer: TdxBarButton
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080'...'
      Category = 0
      Hint = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbAcceptMoneyTransferClick
    end
    object bbTransferMoneyToUser: TdxBarButton
      Caption = #1055#1077#1088#1077#1076#1072#1095#1072' '#1076#1077#1085#1077#1075' '#1076#1088#1091#1075#1086#1084#1091' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1102'...'
      Category = 0
      Hint = #1055#1077#1088#1077#1076#1072#1095#1072' '#1076#1077#1085#1077#1075' '#1076#1088#1091#1075#1086#1084#1091' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1102
      Visible = ivAlways
      ImageIndex = 48
      OnClick = bbTransferMoneyToUserClick
    end
    object bbTransferMoneyToSelf: TdxBarButton
      Caption = #1058#1088#1072#1085#1089#1092#1077#1088' '#1076#1077#1085#1077#1075' '#1089#1077#1073#1077'...'
      Category = 0
      Hint = #1058#1088#1072#1085#1089#1092#1077#1088' '#1076#1077#1085#1077#1075' '#1089#1077#1073#1077
      Visible = ivAlways
      ImageIndex = 48
      OnClick = bbTransferMoneyToSelfClick
    end
  end
  object pmTransferMoney: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbTransferMoneyToUser'
      end
      item
        Visible = True
        ItemName = 'bbTransferMoneyToSelf'
      end>
    UseOwnFont = False
    Left = 56
    Top = 104
    PixelsPerInch = 96
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 324
    Top = 112
  end
  object cxGridPopupMenuMe: TcxGridPopupMenu
    Grid = cxGridToMe
    PopupMenus = <
      item
        GridView = cxGridToMeTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmNonConfirmedTransfers
      end>
    Left = 784
    Top = 172
  end
  object pmNonConfirmedTransfers: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAcceptMoneyTransfer'
      end>
    UseOwnFont = False
    Left = 928
    Top = 172
    PixelsPerInch = 96
  end
end
