object frmBanknoteCounterDlg: TfrmBanknoteCounterDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridBanknotes
  BorderStyle = bsDialog
  Caption = 'Numarator de banknote'
  ClientHeight = 362
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    384
    362)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 384
    Height = 64
    Title = 'Numarator de banknote'
    Text = 'Calculul sumei de bani in functie de banknote'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object cxGridBanknotes: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 368
    Height = 228
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
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
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssNone
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridBanknotesTableCol1: TcxGridColumn
        Caption = 'Nominal'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridBanknotesTableCol2: TcxGridColumn
        Caption = 'Cantitate'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d+'
        Properties.OnValidate = cxGridBanknotesTableCol2PropertiesValidate
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Styles.Footer = dmAdditions.cxStyle_Bold
        Width = 100
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
        Styles.Content = dmAdditions.cxStyle_MoneyCounter_Total
        Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
      end
    end
    object cxGridBanknotesLevel: TcxGridLevel
      GridView = cxGridBanknotesTable
    end
  end
  object btnOk: TcxButton
    Left = 170
    Top = 317
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 270
    Top = 317
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
