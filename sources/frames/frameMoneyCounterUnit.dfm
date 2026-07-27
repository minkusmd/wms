object frameMoneyCounter: TframeMoneyCounter
  Left = 0
  Top = 0
  Width = 300
  Height = 246
  Constraints.MaxHeight = 246
  Constraints.MaxWidth = 300
  Constraints.MinHeight = 246
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object cxGridBanknotes: TcxGrid
    Left = 0
    Top = 0
    Width = 300
    Height = 246
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 0
    object cxGridBanknotesTable: TcxGridTableView
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
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0'
          Kind = skSum
          Column = cxGridBanknotesTableCol3
        end
        item
          Format = '0'
          Kind = skSum
          Column = cxGridBanknotesTableCol2
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.Data = {
        260100000F00000044617461436F6E74726F6C6C657231030000001300000054
        6378496E746567657256616C75655479706513000000546378496E7465676572
        56616C75655479706513000000546378496E746567657256616C756554797065
        09000000445855464D540000E803000000000000000000000000445855464D54
        0000F401000000000000000000000000445855464D540000C800000000000000
        000000000000445855464D540000640000000000000000000000000044585546
        4D5400003200000000000000000000000000445855464D540000140000000000
        0000000000000000445855464D5400000A000000000000000000000000004458
        55464D5400000500000000000000000000000000445855464D54000001000000
        00000000000000000000}
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssNone
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridBanknotesTableCol1: TcxGridColumn
        Caption = 'Bancnote'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBanknotesTableCol2: TcxGridColumn
        Caption = 'Cantitate'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.IncrementalSearch = False
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.UseLeftAlignmentOnEditing = False
        Properties.OnValidate = cxGridBanknotesTableCol2PropertiesValidate
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 110
        Options.HorzSizing = False
        Styles.Footer = dmAdditions.cxStyle_Bold
        Width = 110
      end
      object cxGridBanknotesTableCol3: TcxGridColumn
        Caption = 'Total'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
      end
    end
    object cxGridBanknotesLevel: TcxGridLevel
      GridView = cxGridBanknotesTable
    end
  end
end
