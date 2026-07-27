inherited frame30CassaFirma: Tframe30CassaFirma
  Width = 1264
  Height = 754
  Font.Height = -15
  ExplicitWidth = 1264
  ExplicitHeight = 754
  PixelsPerInch = 120
  object pnClient: TPanel
    Left = 441
    Top = 0
    Width = 823
    Height = 754
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnTop: TPanel
      Left = 0
      Top = 0
      Width = 823
      Height = 145
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 2
      TabOrder = 0
      object pnPersonalCassa: TPanel
        Left = 2
        Top = 0
        Width = 821
        Height = 145
        Margins.Left = 2
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnPersonalCassa'
        Padding.Left = 2
        TabOrder = 0
        object Label2: TLabel
          Left = 2
          Top = 0
          Width = 819
          Height = 20
          Align = alTop
          AutoSize = False
          Caption = 'Casa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
          ExplicitWidth = 911
        end
        object cxGridКасса: TcxGrid
          Left = 2
          Top = 20
          Width = 819
          Height = 125
          Align = alClient
          TabOrder = 0
          object cxGridКассаTable: TcxGridDBTableView
            PopupMenu = pmTransferMoney
            OnKeyDown = cxGridКассаTableKeyDown
            OnCustomDrawCell = cxGridКассаTableCustomDrawCell
            DataController.DataSource = IBCDataSourcePersonalCash
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssNone
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridКассаTable_CURRENCY_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_TITLE'
              MinWidth = 110
              Width = 110
            end
            object cxGridКассаTable_AMOUNT_ACCOUNT: TcxGridDBColumn
              Caption = 'Transfer'
              DataBinding.FieldName = 'SUMA_CONTAB'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridКассаTable_AMOUNT_CASH: TcxGridDBColumn
              Caption = 'Numerar'
              DataBinding.FieldName = 'SUMA_CASH'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridКассаTable_AMOUNT: TcxGridDBColumn
              Caption = 'Total'
              DataBinding.FieldName = 'SUMA_TOT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Styles.Content = dmAdditions.cxStyle_Bold
              Width = 100
            end
          end
          object cxGridКассаLevel: TcxGridLevel
            GridView = cxGridКассаTable
          end
        end
      end
    end
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 2
      Top = 153
      Width = 821
      Height = 373
      Margins.Left = 2
      Margins.Top = 8
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Transferuri neprimite'
        object cxGridToMe: TcxGrid
          Left = 0
          Top = 0
          Width = 813
          Height = 338
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 343
          object cxGridToMeTable: TcxGridDBTableView
            OnKeyDown = cxGridToMeTableKeyDown
            OnCustomDrawCell = cxGridToMeTableCustomDrawCell
            DataController.DataSource = IBCDataSourceNonConfirmedTransfers
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
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA_DT'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = 'Furnizor'
              DataBinding.FieldName = 'DT_NAME'
              MinWidth = 100
              Styles.Content = dmAdditions.cxStyle_MarginGroup
              Width = 100
            end
            object cxGridDBColumn3: TcxGridDBColumn
              Caption = 'de la operatorul'
              DataBinding.FieldName = 'USER_DT_NAME'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridToMeTRANSFERAT_PRIN: TcxGridDBColumn
              Caption = 'Transmis prin...'
              DataBinding.FieldName = 'TRANSFERAT_PRIN_NAME'
              Width = 100
            end
            object cxGridDBColumn4: TcxGridDBColumn
              Caption = 'Cntb'
              DataBinding.FieldName = 'FLG_ACNT_DT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 34
              Options.HorzSizing = False
              Width = 34
            end
            object cxGridDBColumn5: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA_DT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBColumn6: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_DT_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDBColumn7: TcxGridDBColumn
              Caption = 'Beneficiar'
              DataBinding.FieldName = 'CT_NAME'
              MinWidth = 100
              Styles.Content = dmAdditions.cxStyle_MarginGroup
              Width = 100
            end
            object cxGridDBColumn8: TcxGridDBColumn
              Caption = #1050#1086#1084#1091
              DataBinding.FieldName = 'USER_CT_NAME'
              Visible = False
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridDBColumn10: TcxGridDBColumn
              Caption = 'catre operatorul'
              DataBinding.FieldName = 'USER_CT_NAME'
              Width = 70
            end
            object cxGridDBColumn9: TcxGridDBColumn
              Caption = 'Cntb'
              DataBinding.FieldName = 'FLG_ACNT_CT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 34
              Options.HorzSizing = False
              Width = 34
            end
            object cxGridToMe_COMMENT: TcxGridDBColumn
              Caption = 'Mentiuni'
              DataBinding.FieldName = 'COMMENT'
              Width = 100
            end
            object cxGridToMeTableColumn1: TcxGridDBColumn
              Caption = 'DocID'
              DataBinding.FieldName = 'RASHOD_DOCID'
            end
          end
          object cxGridToMeLevel: TcxGridLevel
            GridView = cxGridToMeTable
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Rezerve deschize'
        ImageIndex = 1
        object cxGridOI: TcxGrid
          Left = 0
          Top = 0
          Width = 813
          Height = 345
          Align = alClient
          TabOrder = 0
          object cxGridOITable: TcxGridDBTableView
            OnKeyDown = cxGridOITableKeyDown
            OnCustomDrawCell = cxGridOITableCustomDrawCell
            DataController.KeyFieldNames = 'DOCID'
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnSorting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridOI_DOCID: TcxGridDBColumn
              Caption = 'Docid'
              DataBinding.FieldName = 'DOCID'
              HeaderAlignmentHorz = taRightJustify
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridOI_DATA: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridOI_CT_NAME: TcxGridDBColumn
              Caption = 'Debitor'
              DataBinding.FieldName = 'CT_NAME'
              Width = 200
            end
            object cxGridOI_DOCTYPE_NAME: TcxGridDBColumn
              Caption = 'Tip document'
              DataBinding.FieldName = 'DOCTYPE_NAME'
              Width = 200
            end
            object cxGridOI_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridOI_CURRENCY_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridOI_RATE: TcxGridDBColumn
              Caption = 'Curs'
              DataBinding.FieldName = 'RATE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridOI_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Operator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
          end
          object cxGridOILevel: TcxGridLevel
            GridView = cxGridOITable
          end
        end
      end
    end
    object pnBottom: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 536
      Width = 821
      Height = 218
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Padding.Left = 2
      TabOrder = 3
      object cxLabel2: TcxLabel
        Left = 2
        Top = 0
        Align = alTop
        Caption = 'Istoria transferurilor'
        Style.TextStyle = [fsBold]
        TabOrder = 0
      end
      object cxGridHis: TcxGrid
        Left = 2
        Top = 24
        Width = 819
        Height = 194
        Align = alClient
        TabOrder = 1
        ExplicitTop = 19
        ExplicitHeight = 199
        object cxGridHisTable: TcxGridDBTableView
          OnCustomDrawCell = cxGridHisTableCustomDrawCell
          DataController.DataSource = IBCDataSourceHist
          DataController.KeyFieldNames = 'ID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 63
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.Column = cxGridHis_COMMENT
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          Preview.Visible = True
          RowLayout.MinValueWidth = 100
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridHis_DATA_DT: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA_DT'
            OnGetDisplayText = cxGridHis_DATA_DTGetDisplayText
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soDescending
            Width = 60
          end
          object cxGridHis_DT_NAME: TcxGridDBColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'DT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridHis_USER_DT_NAME: TcxGridDBColumn
            Caption = 'de la operator'
            DataBinding.FieldName = 'USER_DT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridHis_SUMA_DT: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA_DT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridHis_CURRENCY_DT_NAME: TcxGridDBColumn
            Caption = 'Valuta'
            DataBinding.FieldName = 'CURRENCY_DT_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 46
            Options.HorzSizing = False
            Width = 46
          end
          object cxGridHis_RATE_DT: TcxGridDBColumn
            Caption = 'Curs'
            DataBinding.FieldName = 'RATE_DT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taCenter
            MinWidth = 46
            Options.HorzSizing = False
            Width = 46
          end
          object cxGridHis_FLG_ACNT_DT: TcxGridDBColumn
            Caption = 'Cntb'
            DataBinding.FieldName = 'FLG_ACNT_DT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 30
            Options.HorzSizing = False
            Width = 30
          end
          object cxGridHis_DATA_CT: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA_CT'
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object cxGridHis_CT_NAME: TcxGridDBColumn
            Caption = 'Beneficiar'
            DataBinding.FieldName = 'CT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridHis_USER_CT_NAME: TcxGridDBColumn
            Caption = 'catre operatorul'
            DataBinding.FieldName = 'USER_CT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridHis_FLG_CT_CONFIRMED: TcxGridDBColumn
            Caption = 'Primit'
            DataBinding.FieldName = 'FLG_CT_CONFIRMED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 34
            Options.HorzSizing = False
            Width = 34
          end
          object cxGridHis_COMMENT: TcxGridDBColumn
            Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
            DataBinding.FieldName = 'COMMENT'
            Width = 100
          end
        end
        object cxGridHisLevel: TcxGridLevel
          GridView = cxGridHisTable
        end
      end
    end
    object cxSplitter: TcxSplitter
      Left = 0
      Top = 526
      Width = 823
      Height = 10
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salBottom
      PositionAfterOpen = 200
      MinSize = 200
      Control = pnBottom
    end
  end
  object pnLeft: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 754
    Align = alLeft
    BevelOuter = bvNone
    Padding.Top = 2
    TabOrder = 0
    object Label5: TLabel
      Left = 0
      Top = 2
      Width = 441
      Height = 20
      Align = alTop
      AutoSize = False
      Caption = 'Operatori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlBottom
    end
    object cxGridUsers: TcxGrid
      Left = 0
      Top = 22
      Width = 441
      Height = 732
      Align = alClient
      TabOrder = 0
      object cxGridUsersDBTable: TcxGridDBTableView
        PopupMenu = pmTransferMoney
        OnKeyDown = cxGridUsersDBTableKeyDown
        OnCustomDrawCell = cxGridUsersDBTableCustomDrawCell
        DataController.DataSource = IBCDataSourceUsers
        DataController.KeyFieldNames = 'USERID;CURRENCYID'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMA_TOT'
            VisibleForCustomization = False
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
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
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Group = dmAdditions.cxStyle_Bold
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridUsers_USERID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'USERID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 40
        end
        object cxGridUsers_USER_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'USERNAME'
          Width = 157
        end
        object cxGridUsers_CURRENCYTITLE: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_TITLE'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          VisibleForCustomization = False
        end
        object cxGridUsersDB_SUMA_CONTAB: TcxGridDBColumn
          Caption = 'Banca'
          DataBinding.FieldName = 'SUMA_CONTAB'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 80
          Options.HorzSizing = False
        end
        object cxGridUsers_SUMA_CASH: TcxGridDBColumn
          Caption = 'Numerar'
          DataBinding.FieldName = 'SUMA_CASH'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 80
          Options.Editing = False
          Options.HorzSizing = False
        end
        object cxGridUsers_SUMA_TOTAL: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA_TOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 80
        end
      end
      object cxGridUsersLevel: TcxGridLevel
        GridView = cxGridUsersDBTable
      end
    end
  end
  object IBCDataSourcePersonalCash: TIBCDataSource
    DataSet = IBCQueryPersonalCash
    Left = 424
    Top = 72
  end
  object IBCQueryPersonalCash: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      'USERID,'
      'USERNAME,'
      'CURRENCYID,'
      'CURRENCY_TITLE,'
      'SUM(SUMA_CONTAB) SUMA_CONTAB,'
      'SUM(SUMA_CASH) SUMA_CASH,'
      'SUM(SUMA_TOT) SUMA_TOT'
      'FROM'
      ' SP_CASA_PE_FIRMA_NEW(CURRENT_DATE)'
      'WHERE'
      ' ((SUMA_CASH<>0) OR (SUMA_CONTAB<>0))'
      'GROUP BY'
      'USERID,'
      'USERNAME,'
      'CURRENCYID,'
      'CURRENCY_TITLE')
    MasterFields = 'USERID'
    DetailFields = 'USERID'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 100
    Left = 584
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
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
    MasterFields = 'USERID'
    DetailFields = 'CREATED_BY'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 100
    Left = 432
    Top = 340
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
      end
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourceOI: TIBCDataSource
    DataSet = IBCQueryOI
    Left = 344
    Top = 340
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    OnDataChange = IBCDataSourceUsersDataChange
    Left = 132
    Top = 120
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' SP_CASA_PE_FIRMA_NEW(CURRENT_DATE)'
      'WHERE'
      ' (DT=:DT)'
      ' AND'
      ' ((SUMA_CASH<>0) OR (SUMA_CONTAB<>0))')
    Left = 132
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
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
    Left = 232
    Top = 8
    PixelsPerInch = 120
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
    MasterFields = 'USERID'
    DetailFields = 'USER_CT'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 100
    Left = 492
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourceNonConfirmedTransfers: TIBCDataSource
    DataSet = IBCQueryNonConfirmedTransfers
    Left = 492
    Top = 280
  end
  object pmNonConfirmedTransfers: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAcceptMoneyTransfer'
      end>
    UseOwnFont = False
    OnPopup = pmNonConfirmedTransfersPopup
    Left = 668
    Top = 248
    PixelsPerInch = 120
  end
  object pmTransferMoney: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
      end
      item
        Visible = True
      end
      item
        Visible = True
        ItemName = 'bbTransferMoneyToUser'
      end
      item
        Visible = True
        ItemName = 'bbTransferMoneyToSelf'
      end>
    UseOwnFont = False
    Left = 440
    Top = 144
    PixelsPerInch = 120
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 132
    Top = 228
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
    Left = 816
    Top = 84
  end
  object IBCQueryHist: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' * '
      'FROM'
      ' SPM_CASH_TRANSFER_HISTORY(:USERID, CURRENT_DATE, 30)'
      'ORDER BY DATA_DT DESC')
    MasterFields = 'USERID'
    DetailFields = 'USERID'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 100
    Left = 640
    Top = 404
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourceHist: TIBCDataSource
    DataSet = IBCQueryHist
    Left = 536
    Top = 408
  end
end
