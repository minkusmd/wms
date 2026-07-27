inherited frame04BankPDNS: Tframe04BankPDNS
  Width = 806
  Height = 418
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 806
  ExplicitHeight = 418
  object cxGridBankPDNS: TcxGrid
    Left = 0
    Top = 0
    Width = 806
    Height = 418
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridBankPDNSTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      OnKeyDown = cxGridBankPDNSTableKeyDown
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
      OnCellDblClick = cxGridBankPDNSTableCellDblClick
      OnCustomDrawCell = cxGridBankPDNSTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridBankPDNSTableSuma
        end>
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
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridBankPDNS_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.IncSearch = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 32
      end
      object cxGridBankPDNSTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSTableCREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 13
        Width = 80
      end
      object cxGridBankPDNS_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridBankPDNS_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBankPDNSTableCtName: TcxGridDBColumn
        Caption = 'Incasat de la'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 32
        Options.Grouping = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 128
      end
      object cxGridBankPDNSTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBankPDNSTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBankPDNSTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBankPDNSTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBankPDNS_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBankPDNSTableParentDocID: TcxGridDBColumn
        Caption = 'cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBankPDNSTableFlgACNT: TcxGridDBColumn
        Caption = 'Contab'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridBankPDNSTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 13
        Options.Grouping = False
        Width = 64
      end
      object cxGridBankPDNS_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBankPDNS_DTSC_NAME: TcxGridDBColumn
        Caption = 'Analitica 1'
        DataBinding.FieldName = 'DTSC_NAME'
        MinWidth = 26
        Width = 45
      end
      object cxGridBankPDNS_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica 2'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 13
      end
    end
    object cxGridBankPDNSLevel1: TcxGridLevel
      GridView = cxGridBankPDNSTable
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridBankPDNS
    PopupMenus = <
      item
        GridView = cxGridBankPDNSTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 80
    Top = 152
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 144
    Top = 80
    PixelsPerInch = 96
    object bbProvesti: TdxBarButton
      Caption = 'Valideaza transactia'
      Category = 0
      Hint = 'Valideaza transactia'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
      OnClick = bbProvestiClick
    end
    object bbCancelProvodca: TdxBarButton
      Caption = 'Anuleaza validarea'
      Category = 0
      Hint = 'Anuleaza validarea'
      Visible = ivAlways
      OnClick = bbCancelProvodcaClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGotoParentDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Ramburs incasat'
      Category = 0
      Hint = 'Ramburs incasat'
      Visible = ivAlways
      ShortCut = 32849
      OnClick = dxBarButton1Click
    end
    object bbDistribuireRamburs: TdxBarButton
      Caption = 'Distribuirea rambursului...'
      Category = 0
      Hint = 'Distribuirea rambursului'
      Visible = ivAlways
      ShortCut = 32836
      OnClick = bbDistribuireRambursClick
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbProvesti'
      end
      item
        Visible = True
        ItemName = 'bbCancelProvodca'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbDistribuireRamburs'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
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
    Left = 168
    Top = 160
    PixelsPerInch = 96
  end
end
