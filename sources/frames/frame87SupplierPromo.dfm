inherited frame87SupplierPromo: Tframe87SupplierPromo
  Width = 1170
  Height = 805
  object cxGridPromoTickets: TcxGrid
    Left = 0
    Top = 39
    Width = 1170
    Height = 766
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    ExplicitWidth = 451
    ExplicitHeight = 266
    object cxGridPromoTicketsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
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
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridPromoTicketsTableCustomDrawCell
      OnFocusedRecordChanged = cxGridPromoTicketsTableFocusedRecordChanged
      DataController.KeyFieldNames = 'ACTIUNE_ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridPromoTicketsTableTICKETID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'TICKETID'
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object cxGridPromoTicketsTableTITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 586
      end
      object cxGridPromoTicketsTableDATA1: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA1'
        HeaderAlignmentHorz = taCenter
        Width = 188
      end
      object cxGridPromoTicketsTableDATA2: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA2'
        HeaderAlignmentHorz = taCenter
        Width = 179
      end
    end
    object cxGridPromoTicketsLevel: TcxGridLevel
      GridView = cxGridPromoTicketsTable
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1170
    Height = 39
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Color = clGray
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 451
  end
end
