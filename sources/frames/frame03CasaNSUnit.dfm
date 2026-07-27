inherited frame03CasaNS: Tframe03CasaNS
  Width = 833
  Height = 342
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 833
  ExplicitHeight = 342
  object cxGridCasaNS: TcxGrid
    Left = 0
    Top = 0
    Width = 833
    Height = 342
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridCasaNSDBTable: TcxGridDBTableView
      OnKeyDown = cxGridCasaNSDBTableKeyDown
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
      OnCellDblClick = cxGridCasaNSDBTableCellDblClick
      DataController.KeyFieldNames = 'DOCID'
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridCasaNS_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridCasaNS_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridCasaNS_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 77
        Options.HorzSizing = False
        Width = 77
      end
      object cxGridCasaNS_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 13
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 128
      end
      object cxGridCasaNS_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridCasaNS_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridCasaNS_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridCasaNS_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.HorzSizing = False
        Width = 51
      end
      object cxGridCasaNS_PARENTDOCID: TcxGridDBColumn
        Caption = 'Cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridCasaNS_FLG_ACNT: TcxGridDBColumn
        Caption = 'Contab'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridCasaNS_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 13
        Width = 64
      end
      object cxGridCasaNS_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
    end
    object cxGridCasaNSLevel: TcxGridLevel
      GridView = cxGridCasaNSDBTable
    end
  end
end
