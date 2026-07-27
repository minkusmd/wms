inherited frame42CassaGlobalFirme: Tframe42CassaGlobalFirme
  Width = 1538
  Height = 982
  Font.Height = -15
  ExplicitWidth = 1538
  ExplicitHeight = 982
  PixelsPerInch = 120
  object pnClient: TPanel
    Left = 401
    Top = 0
    Width = 1137
    Height = 982
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnTop: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 1129
      Height = 722
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 2
      Padding.Bottom = 2
      TabOrder = 0
      object pnMoneyTransfer: TPanel
        AlignWithMargins = True
        Left = 2
        Top = 149
        Width = 1127
        Height = 571
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 2
        TabOrder = 1
        object Panel3: TPanel
          Left = 2
          Top = 0
          Width = 1125
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label4: TLabel
            Left = 0
            Top = 0
            Width = 1125
            Height = 25
            Align = alClient
            Caption = 'Transferuri neprimite'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 119
            ExplicitHeight = 15
          end
        end
        object cxGridToMe: TcxGrid
          Left = 2
          Top = 25
          Width = 1125
          Height = 546
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object cxGridToMeTable: TcxGridDBTableView
            PopupMenu = pmNonConfirmedTransfers
            OnKeyDown = cxGridToMeTableKeyDown
            OnCustomDrawCell = cxGridToMeTableCustomDrawCell
            DataController.DataSource = IBCDataSourceNonConfirmedTransfers
            DataController.KeyFieldNames = 'ID'
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = '0.00'
                Kind = skSum
                FieldName = 'SUMA_DT'
                Column = cxGridDB_SUMA_DT
              end>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0.00'
                Kind = skSum
                FieldName = 'SUMA_DT'
                Column = cxGridDB_SUMA_DT
              end>
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            Preview.Visible = True
            RowLayout.MinValueWidth = 100
            Styles.Group = dmAdditions.cxStyle_Bold
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridToMe_FLG_LIVRARE: TcxGridDBColumn
              Caption = 'Livrare'
              DataBinding.FieldName = 'FLG_LIVRARE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.DisplayChecked = 'Da'
              Properties.DisplayUnchecked = 'Nu'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 42
              Options.HorzSizing = False
              Width = 42
            end
            object cxGridDB_DATA_DT: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA_DT'
              MinWidth = 60
              Options.Grouping = False
              Styles.Content = dmAdditions.cxStyle_Bold
              Width = 60
            end
            object cxGridDB_DT_NAME: TcxGridDBColumn
              Caption = 'Furnizor'
              DataBinding.FieldName = 'DT_NAME'
              MinWidth = 60
              Width = 120
            end
            object cxGridDB_USER_DT_NAME: TcxGridDBColumn
              Caption = 'De la operator'
              DataBinding.FieldName = 'USER_DT_NAME'
              MinWidth = 60
              Styles.Content = dmAdditions.cxStyle_CalcProfitGreen
              Width = 100
            end
            object cxGridToMe_TRANSFERAT_PRIN: TcxGridDBColumn
              Caption = 'Transmis prin...'
              DataBinding.FieldName = 'TRANSFERAT_NAME'
              HeaderAlignmentHorz = taCenter
              Width = 150
            end
            object cxGridDB_FLG_ACNT_DT: TcxGridDBColumn
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
            object cxGridDB_SUMA_DT: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA_DT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 120
              Options.HorzSizing = False
              Styles.Content = dmAdditions.cxStyle_Bold
              Width = 120
            end
            object cxGridDB_CURRENCY_DT_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_DT_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDB_CT_NAME: TcxGridDBColumn
              Caption = 'Beneficiar'
              DataBinding.FieldName = 'CT_NAME'
              MinWidth = 60
              Width = 120
            end
            object cxGridDB_USER_CT_NAME: TcxGridDBColumn
              Caption = 'Operator'
              DataBinding.FieldName = 'USER_CT_NAME'
              MinWidth = 60
              Styles.Content = dmAdditions.cxStyle_MarginGroup
              Width = 100
            end
            object cxGridDB_FLG_ACNT_CT: TcxGridDBColumn
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
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              DataBinding.FieldName = 'COMMENT'
              OnGetDisplayText = cxGridToMe_COMMENTGetDisplayText
              Width = 100
            end
            object cxGridToMe_ID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridToMeTableColumn1: TcxGridDBColumn
              Caption = 'pt document'
              DataBinding.FieldName = 'RASHOD_DOCID'
            end
            object cxGridToMeTable_USERDT: TcxGridDBColumn
              DataBinding.FieldName = 'USER_DT'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridToMeTable_USERCT: TcxGridDBColumn
              DataBinding.FieldName = 'USER_CT'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridToMeLevel: TcxGridLevel
            GridView = cxGridToMeTable
          end
        end
      end
      object pnPersonalCassa: TPanel
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 1127
        Height = 147
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnPersonalCassa'
        Padding.Left = 2
        TabOrder = 0
        object cxGridКасса: TcxGrid
          Left = 2
          Top = 25
          Width = 1125
          Height = 122
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alLeft
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
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
            Styles.OnGetContentStyle = cxGridКассаTableStylesGetContentStyle
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridКассаTable_CURRENCY_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_TITLE'
              MinWidth = 110
              Width = 110
            end
            object cxGridКассаTable_AMOUNT_ACCOUNT: TcxGridDBColumn
              Caption = 'Banca'
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
        object Panel2: TPanel
          Left = 2
          Top = 0
          Width = 1125
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 1125
            Height = 25
            Align = alClient
            Caption = 'Casa personala'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 80
            ExplicitHeight = 15
          end
        end
      end
    end
    object pnBottom: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 732
      Width = 1135
      Height = 250
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Padding.Left = 2
      TabOrder = 2
      object cxLabel2: TcxLabel
        Left = 2
        Top = 32
        Align = alTop
        Caption = 'Istoria transferurilor'
        Style.TextStyle = [fsBold]
        TabOrder = 0
      end
      object cxGridHis: TcxGrid
        Left = 2
        Top = 56
        Width = 1133
        Height = 194
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ExplicitTop = 51
        ExplicitHeight = 199
        object cxGridHisTable: TcxGridDBTableView
          OnKeyDown = cxGridHisTableKeyDown
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
            Caption = 'De la Operator'
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
            Caption = 'Rata'
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
            Caption = 'Operator'
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
      object bdcHistoryPeriod: TdxBarDockControl
        Left = 2
        Top = 0
        Width = 1133
        Height = 32
        Align = dalTop
        BarManager = dxBarManager
      end
    end
    object cxSplitter: TcxSplitter
      Left = 0
      Top = 722
      Width = 1137
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
    Width = 393
    Height = 982
    Align = alLeft
    BevelOuter = bvNone
    Padding.Top = 2
    TabOrder = 0
    object Label5: TLabel
      Left = 0
      Top = 2
      Width = 393
      Height = 25
      Align = alTop
      AutoSize = False
      Caption = 'Operatori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 2
      ExplicitTop = -1
      ExplicitWidth = 501
    end
    object cxGridUsers: TcxGrid
      Left = 0
      Top = 27
      Width = 393
      Height = 955
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cxGridUsersDBTable: TcxGridDBTableView
        PopupMenu = pmTransferMoney
        OnKeyDown = cxGridUsersDBTableKeyDown
        OnCustomDrawCell = cxGridUsersDBTableCustomDrawCell
        DataController.DataSource = IBCDataSourceUsers
        DataController.KeyFieldNames = 'USERID;CURRENCYID;DT'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = #1058': #,##0.00'
            Kind = skSum
            FieldName = 'SUMA_TOT'
            VisibleForCustomization = False
          end
          item
            Format = '  '#1050': #,##0.00'
            Kind = skSum
            Column = cxGridUsers_SUMA_CASH
            VisibleForCustomization = False
          end
          item
            Format = ' '#1041': #,##0.00'
            Kind = skSum
            Column = cxGridUsers_SUMA_CONTAB
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxGridUsers_CURRENCYTITLE
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
        Styles.OnGetContentStyle = cxGridUsersDBTableStylesGetContentStyle
        Styles.Group = dmAdditions.cxStyle_TextGray
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.GroupSummary = dmAdditions.cxStyle_CustomerDebtsNoiDatoram
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.OnGetGroupStyle = cxGridUsersDBTableStylesGetGroupStyle
        object cxGridUsers_USERID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'USERID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 40
        end
        object cxGridUsers_USER_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'USERNAME'
          Width = 224
        end
        object cxGridUsers_CURRENCYTITLE: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_TITLE'
          Visible = False
          GroupIndex = 0
          VisibleForCustomization = False
        end
        object cxGridUsers_SUMA_CONTAB: TcxGridDBColumn
          Caption = 'Banca'
          DataBinding.FieldName = 'SUMA_CONTAB'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridUsers_SUMA_CASH: TcxGridDBColumn
          Caption = 'Numerar'
          DataBinding.FieldName = 'SUMA_CASH'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridUsers_SUMA_LIVRARE: TcxGridDBColumn
          Caption = 'in livrare'
          DataBinding.FieldName = 'SUMA_LIVRARE'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object cxGridUsers_SUMA_TOTAL: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA_TOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_Bold
          VisibleForCustomization = False
          Width = 80
        end
        object cxGridUsers_DISPLAYNAME: TcxGridDBColumn
          Caption = 'Subdiviziune'
          DataBinding.FieldName = 'DISPLAYNAME'
          Visible = False
          GroupIndex = 1
          VisibleForCustomization = False
        end
      end
      object cxGridUsersLevel: TcxGridLevel
        GridView = cxGridUsersDBTable
      end
    end
  end
  object cxSpliter1: TcxSplitter
    Left = 393
    Top = 0
    Width = 8
    Height = 982
    Control = pnLeft
  end
  object IBCDataSourcePersonalCash: TIBCDataSource
    DataSet = IBCQueryPersonalCash
    Left = 432
    Top = 152
  end
  object IBCQueryPersonalCash: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' SP_CASA_PE_FIRMA_NEW(CURRENT_DATE)'
      'WHERE'
      ' (SUMA_CASH<>0) OR (SUMA_CONTAB<>0)')
    MasterFields = 'DT;USERID'
    DetailFields = 'DT;USERID'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 500
    Left = 432
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DT'
        ParamType = ptInput
        Value = 5213
      end
      item
        DataType = ftInteger
        Name = 'USERID'
        ParamType = ptInput
        Value = 196
      end>
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 132
    Top = 120
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' A.*,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=A.DT)'
      'FROM SP_CASA_PE_FIRMA_NEW(CURRENT_DATE) A'
      'WHERE'
      ' (SUMA_CASH<>0) OR (SUMA_CONTAB<>0) or (SUMA_LIVRARE<>0)')
    Left = 132
    Top = 172
  end
  object dxBarManager: TdxBarManager
    Scaled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 276
    Top = 232
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = bdcHistoryPeriod
      DockedDockControl = bdcHistoryPeriod
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1253
      FloatTop = 641
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'edDateEditHistory1'
        end
        item
          Visible = True
          ItemName = 'cxBarEditItem4'
        end
        item
          Visible = True
          ItemName = 'cxBarEditItem3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbAcceptMoneyTransfer: TdxBarButton
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080'...'
      Category = 0
      Hint = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
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
    object bbChangeNotReceivedTarget: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103'...'
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
      Visible = ivAlways
      ShortCut = 117
      OnClick = bbChangeNotReceivedTargetClick
    end
    object edDateEditHistory1: TcxBarEditItem
      Caption = 'Perioada'
      Category = 0
      Hint = 'Perioada'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      InternalEditValue = 42339d
    end
    object cxBarEditItem2: TcxBarEditItem
      Caption = #1055#1077#1088#1080#1086#1076
      Category = 0
      Hint = #1055#1077#1088#1080#1086#1076
      Visible = ivAlways
      PropertiesClassName = 'TcxLabelProperties'
    end
    object cxBarEditItem3: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object cxBarEditItem4: TcxBarEditItem
      Caption = ' - '
      Category = 0
      Hint = ' - '
      Visible = ivAlways
      PropertiesClassName = 'TcxLabelProperties'
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 243
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton1Click
    end
  end
  object IBCDataSourceNonConfirmedTransfers: TIBCDataSource
    DataSet = IBCQueryNonConfirmedTransfers
    Left = 928
    Top = 308
  end
  object IBCQueryNonConfirmedTransfers: TIBCQuery
    SQLInsert.Strings = (
      '/*INSERT INTO VW_TDB_CASH_JURNAL'
      
        '  (ID, CURRENCYID_DT, CURRENCY_DT_NAME, FLG_CLOSE_DOC, FLG_DELET' +
        'E, FLG_DT_CONFIRMED, FLG_CT_CONFIRMED, FLG_LIVRARE, DT, DT_NAME,' +
        ' USER_DT, USER_DT_NAME, SUMA_DT, DATA_DT, FLG_ACNT_DT, CT, CT_NA' +
        'ME, USER_CT, USER_CT_NAME, SUMA_CT, DATA_CT, FLG_ACNT_CT, CURREN' +
        'CYID_CT, CURRENCY_CT_NAME, RATE_DT, RATE_CT, COMMENT, rashod_doc' +
        'id)'
      'VALUES'
      
        '  (:ID, :CURRENCYID_DT, :CURRENCY_DT_NAME, :FLG_CLOSE_DOC, :FLG_' +
        'DELETE, :FLG_DT_CONFIRMED, :FLG_CT_CONFIRMED, :FLG_LIVRARE, :DT,' +
        ' :DT_NAME, :USER_DT, :USER_DT_NAME, :SUMA_DT, :DATA_DT, :FLG_ACN' +
        'T_DT, :CT, :CT_NAME, :USER_CT, :USER_CT_NAME, :SUMA_CT, :DATA_CT' +
        ', :FLG_ACNT_CT, :CURRENCYID_CT, :CURRENCY_CT_NAME, :RATE_DT, :RA' +
        'TE_CT, :COMMENT, :rashod_docid)'
      '*/')
    SQLDelete.Strings = (
      '/*DELETE FROM VW_TDB_CASH_JURNAL'
      'WHERE'
      '  ID = :Old_ID*/')
    SQLUpdate.Strings = (
      '/*UPDATE VW_TDB_CASH_JURNAL'
      'SET'
      
        '  ID = :ID, CURRENCYID_DT = :CURRENCYID_DT, CURRENCY_DT_NAME = :' +
        'CURRENCY_DT_NAME, FLG_CLOSE_DOC = :FLG_CLOSE_DOC, FLG_DELETE = :' +
        'FLG_DELETE, FLG_DT_CONFIRMED = :FLG_DT_CONFIRMED, FLG_CT_CONFIRM' +
        'ED = :FLG_CT_CONFIRMED, FLG_LIVRARE = :FLG_LIVRARE, DT = :DT, DT' +
        '_NAME = :DT_NAME, USER_DT = :USER_DT, USER_DT_NAME = :USER_DT_NA' +
        'ME, SUMA_DT = :SUMA_DT, DATA_DT = :DATA_DT, FLG_ACNT_DT = :FLG_A' +
        'CNT_DT, CT = :CT, CT_NAME = :CT_NAME, USER_CT = :USER_CT, USER_C' +
        'T_NAME = :USER_CT_NAME, SUMA_CT = :SUMA_CT, DATA_CT = :DATA_CT, ' +
        'FLG_ACNT_CT = :FLG_ACNT_CT, CURRENCYID_CT = :CURRENCYID_CT, CURR' +
        'ENCY_CT_NAME = :CURRENCY_CT_NAME, RATE_DT = :RATE_DT, RATE_CT = ' +
        ':RATE_CT, COMMENT = :COMMENT,'
      '  rashod_docid = :rashod_docid'
      'WHERE'
      '  ID = :Old_ID'
      '*/')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_CASH_JURNAL'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      '/*SELECT NULL FROM TDB_CASH_JURNAL'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK*/')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_CASH_JURNAL'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM SPM_CASH_OPEN_TRANSFER'
      'order by DATA_DT')
    Options.DetailDelay = 500
    Left = 928
    Top = 364
  end
  object pmNonConfirmedTransfers: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAcceptMoneyTransfer'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbChangeNotReceivedTarget'
      end>
    UseOwnFont = False
    OnPopup = pmNonConfirmedTransfersPopup
    Left = 640
    Top = 316
    PixelsPerInch = 96
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
    Left = 280
    Top = 96
    PixelsPerInch = 96
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 132
    Top = 228
  end
  object IBCDataSourceHist: TIBCDataSource
    DataSet = IBCQueryHist
    Left = 640
    Top = 552
  end
  object IBCQueryHist: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' * '
      'FROM'
      ' SPM_CASH_TRANSFER_HISTORY(:USERID,CURRENT_DATE, 60)'
      'ORDER BY DATA_DT DESC')
    MasterFields = 'USERID'
    DetailFields = 'USERID'
    MasterSource = IBCDataSourceUsers
    Options.DetailDelay = 500
    Left = 640
    Top = 604
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
end
