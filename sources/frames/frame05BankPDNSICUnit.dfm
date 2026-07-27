inherited frame05BankPDNSIC: Tframe05BankPDNSIC
  Width = 982
  Height = 404
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 982
  ExplicitHeight = 404
  object cxGridBankPDNSIC: TcxGrid
    Left = 0
    Top = 0
    Width = 982
    Height = 404
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridBankPDNSICDBTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      OnKeyDown = cxGridBankPDNSICDBTableKeyDown
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
      OnCellDblClick = cxGridBankPDNSICDBTableCellDblClick
      OnCustomDrawCell = cxGridBankPDNSICDBTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridBankPDNSICDBTableSuma
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
      object cxGridBankPDNSICDB_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 32
      end
      object cxGridBankPDNSICDBTableDOCID: TcxGridDBColumn
        Caption = 'DocID'
        DataBinding.FieldName = 'DOCID'
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBankPDNSIC_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridBankPDNSIC_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBankPDNSICDBTableCtName: TcxGridDBColumn
        Caption = 'Incasat de la'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 13
        Options.Grouping = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 418
      end
      object cxGridBankPDNSICDBTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridBankPDNSICDBTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSICDBTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSICDBTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSIC_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSICDBTableParentDocID: TcxGridDBColumn
        Caption = 'Cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBankPDNSICDBTableFlgACNT: TcxGridDBColumn
        Caption = 'cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridBankPDNSIC_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 204
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 204
      end
    end
    object cxGridBankPDNSICLevel1: TcxGridLevel
      GridView = cxGridBankPDNSICDBTable
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 508
    Top = 136
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
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbPDC: TdxBarButton
      Caption = 'Ordin de incasare'
      Category = 0
      Hint = 'Ordin de incasare'
      Visible = ivAlways
      OnClick = bbPDCClick
    end
    object bbGoToParentDocID: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGoToParentDocIDClick
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridBankPDNSIC
    PopupMenus = <
      item
        GridView = cxGridBankPDNSICDBTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 432
    Top = 216
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
        BeginGroup = True
        Visible = True
        ItemName = 'bbPDC'
      end
      item
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoToParentDocID'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenu1Popup
    Left = 536
    Top = 224
    PixelsPerInch = 96
  end
end
