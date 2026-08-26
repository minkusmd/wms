inherited frame100CerereDePlata: Tframe100CerereDePlata
  Width = 797
  Height = 424
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 797
  ExplicitHeight = 424
  object cxGridBankBPPL: TcxGrid
    Left = 0
    Top = 0
    Width = 797
    Height = 424
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridBankBPPLDBTable: TcxGridDBTableView
      PopupMenu = pmPopupMenuDoc
      OnKeyDown = cxGridBankBPPLDBTableKeyDown
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
      OnCellDblClick = cxGridBankBPPLDBTableCellDblClick
      OnCustomDrawCell = cxGridBankBPPLDBTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridBankBPPLDBTableSuma
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridBankBPPLDBTableDocID
        end
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridBankBPPLDBTableSuma
        end
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridBankBPPLDBTableVAT
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
      Styles.Footer = dmAdditions.cxStyle_GridHeader
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridBankBPPL_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 32
      end
      object cxGridBankBPPLDBTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBankBPPL_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        OnGetDisplayText = cxGridBankBPPL_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 64
      end
      object cxGridBankBPPL_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridBankBPPL_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 41
        Width = 64
      end
      object cxGridBankBPPLDBTableCtName: TcxGridDBColumn
        Caption = 'Beneficiar'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 13
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 128
      end
      object cxGridBankBPPLDBTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 77
        Options.HorzSizing = False
        Width = 77
      end
      object cxGridBankBPPLDBTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridBankBPPLDBTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridBankBPPLDBTableRate: TcxGridDBColumn
        Caption = 'Rata doc'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridBankBPPL_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Options.HorzSizing = False
        Width = 38
      end
      object cxGridBankBPPLDBTableParentDocID: TcxGridDBColumn
        Caption = 'Cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Width = 45
      end
      object cxGridBankBPPL_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 23
        Options.HorzSizing = False
        Width = 23
      end
      object cxGridBankBPPLDBTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 13
        Width = 64
      end
      object cxGridBankBPPL_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBankBPPL_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBankBPPL_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 13
        Width = 64
      end
      object cxGridBankBPPL_FLG_CHILD: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_CHILD'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
    end
    object cxGridBankBPPLLevel1: TcxGridLevel
      GridView = cxGridBankBPPLDBTable
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
    Left = 64
    Top = 68
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
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = dxBarButton1Click
    end
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = cxGridBankBPPL
    PopupMenus = <
      item
        GridView = cxGridBankBPPLDBTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDoc
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 12
    Top = 148
  end
  object pmPopupMenuDoc: TdxBarPopupMenu
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
        ItemName = 'bbCustomerDebts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    OnPopup = pmPopupMenuDocPopup
    Left = 124
    Top = 156
    PixelsPerInch = 96
  end
end
