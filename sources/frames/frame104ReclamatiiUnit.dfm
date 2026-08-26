inherited frame104Reclamatii: Tframe104Reclamatii
  Width = 1245
  Height = 662
  Font.Height = -15
  ExplicitWidth = 1245
  ExplicitHeight = 662
  PixelsPerInch = 120
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1245
    Height = 385
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGridBRK: TcxGrid
      Left = 0
      Top = 0
      Width = 1241
      Height = 381
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridBRKDBTable: TcxGridDBTableView
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
        FindPanel.DisplayMode = fpdmManual
        FindPanel.UseExtendedSyntax = True
        DataController.KeyFieldNames = 'DOCID'
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.CellHints = True
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupRowStyle = grsOffice11
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridBRKDBTableColumn1: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'FLG_UPDATE_DATE'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageDocs
          Properties.Items = <
            item
              ImageIndex = 1
              Value = '1'
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Editing = False
          Options.Focusing = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridBRKDBTableDocID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridBRKDB_CREATED_DATE: TcxGridDBColumn
          Caption = 'Data crearii'
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 90
        end
        object cxGridBRKDBTableData: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridBRKDB_DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Width = 100
        end
        object cxGridBRKDB_CT_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 140
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 140
        end
        object cxGridBRKDBTableSuma: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridBRKDB_CURRENCY_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridBRKDBTableVAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'VAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 70
        end
        object cxGridBRKDBTableRate: TcxGridDBColumn
          Caption = 'Rata'
          DataBinding.FieldName = 'RATE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridBRKDBTableParentDocID: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1088#1086#1076'.'
          DataBinding.FieldName = 'PARENTDOCID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridBRKDB_RATEUSD: TcxGridDBColumn
          Caption = 'Rata $'
          DataBinding.FieldName = 'RATEUSD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridBRK_FLG_ACNT: TcxGridDBColumn
          Caption = 'Cntb'
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridBRKDB_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Width = 100
        end
        object cxGridBRKDB_DT: TcxGridDBColumn
          DataBinding.FieldName = 'DT'
          Visible = False
          HeaderAlignmentHorz = taCenter
          VisibleForCustomization = False
        end
        object cxGridBRKDB_CT: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          HeaderAlignmentHorz = taCenter
          VisibleForCustomization = False
        end
        object cxGridBRK_FLG_CLOSED: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_CLOSED'
          Visible = False
          HeaderAlignmentHorz = taCenter
          VisibleForCustomization = False
        end
        object cxGridBRKDB_dtsc_name: TcxGridDBColumn
          Caption = 'subcont 1'
          DataBinding.FieldName = 'dtsc_name'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridBRKDB_CTSC_NAME: TcxGridDBColumn
          Caption = 'subsconto 2'
          DataBinding.FieldName = 'ctsc_name'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 100
        end
        object cxGridBRKDB_STATE_NAME: TcxGridDBColumn
          Caption = 'Statut'
          DataBinding.FieldName = 'STATE_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object cxGridBRKDBTableColumn2: TcxGridDBColumn
          Caption = 'doc.p.'
          DataBinding.FieldName = 'PARENTDOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
        end
        object cxGridBRKDB_FLG_REZERVA: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_HAS_REZERVA'
          Visible = False
          HeaderAlignmentHorz = taCenter
          VisibleForCustomization = False
        end
        object cxGridBRKDB_FLG_PROFORMA: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_HAS_PROFORMA'
          Visible = False
          HeaderAlignmentHorz = taCenter
          VisibleForCustomization = False
        end
      end
      object cxGridBRKLevel: TcxGridLevel
        GridView = cxGridBRKDBTable
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 385
    Width = 1245
    Height = 277
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxDBMemo1: TcxDBMemo
      Left = 8
      Top = 4
      TabOrder = 0
      Height = 261
      Width = 745
    end
  end
end
