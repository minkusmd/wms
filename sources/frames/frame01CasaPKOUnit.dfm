inherited frame01CasaPKO: Tframe01CasaPKO
  Width = 1064
  Height = 500
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Charset = RUSSIAN_CHARSET
  Font.Height = -15
  ExplicitWidth = 1064
  ExplicitHeight = 500
  PixelsPerInch = 120
  object cxGridCasaPKO: TcxGrid
    Left = 0
    Top = 0
    Width = 1064
    Height = 500
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridCasaPKODBTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuPKO
      OnKeyDown = cxGridCasaPKODBTableKeyDown
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
      OnCellDblClick = cxGridCasaPKODBTableCellDblClick
      OnCustomDrawCell = cxGridCasaPKODBTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridCasaPKODBTableSuma
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
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      object cxGridCasaPKO_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridCasaPKODBTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridCasaPKO_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridCasaPKO_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridCasaPKO_CT_NAME: TcxGridDBColumn
        Caption = 'Incasat de la'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 160
      end
      object cxGridCasaPKODBTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridCasaPKODBTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridCasaPKODBTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridCasaPKODBTableRate: TcxGridDBColumn
        Caption = 'Rata doc.'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridCasaPKO_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridCasaPKODBTableParentDocID: TcxGridDBColumn
        Caption = 'Cod Parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridCasaPKO_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridCasaPKODBTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridCasaPKO_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridCasaPKODB_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        Visible = False
        MinWidth = 16
        Width = 40
      end
      object cxGridCasaPKODB_State: TcxGridDBColumn
        Caption = 'Stare'
        DataBinding.FieldName = 'State_NAME'
        MinWidth = 16
        Width = 64
      end
    end
    object cxGridCasaPKOLevel: TcxGridLevel
      GridView = cxGridCasaPKODBTable
    end
  end
  object dxBarManagerPKO: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 528
    Top = 92
    PixelsPerInch = 120
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGotoParentDocClick
    end
    object bbDebtsNotify: TdxBarButton
      Caption = 'Alerta "Datorii"'
      Category = 0
      Hint = 'Alerta "Datorii"'
      Visible = ivAlways
      OnClick = bbDebtsNotifyClick
    end
    object bbPrintReceipe: TdxBarButton
      Caption = 'Tipar "Bon fiscal"'
      Category = 0
      Hint = 'Tipar "Bon fiscal"'
      Visible = ivAlways
      ImageIndex = 47
      OnClick = bbPrintReceipeClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni...'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCloseDoc: TdxBarButton
      Caption = 'Valideaza transactia...'
      Category = 0
      Hint = 'Valideaza transactia'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = 'Anuleaza validarea...'
      Category = 0
      Hint = 'Anuleaza validarea'
      Visible = ivAlways
      ShortCut = 8312
      OnClick = bbOpenDocClick
    end
    object bbTransferMoneyToUser: TdxBarButton
      Caption = 'Transfera suma documentuli...'
      Category = 0
      Hint = 'Transfera suma documentuli'
      Visible = ivAlways
      OnClick = bbTransferMoneyToUserClick
    end
  end
  object dxBarPopupMenuPKO: TdxBarPopupMenu
    BarManager = dxBarManagerPKO
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        Visible = True
        ItemName = 'bbTransferMoneyToUser'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        Visible = True
        ItemName = 'bbDebtsNotify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPKOPopup
    Left = 240
    Top = 88
    PixelsPerInch = 120
  end
  object cxGridPopupMenuDoc: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuPKO
      end>
    Left = 392
    Top = 168
  end
end
