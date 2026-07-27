object frmSalePlansCopyDlg: TfrmSalePlansCopyDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridS
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 487
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 422
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
    Text = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1086#1076#1085#1086#1075#1086' '#1084#1077#1089#1103#1094#1072' '#1074' '#1076#1088#1091#1075#1086#1081
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 406
    Height = 357
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 12
      Width = 57
      Height = 15
      Caption = #1048#1079' '#1084#1077#1089#1103#1094#1072
    end
    object Label2: TLabel
      Left = 212
      Top = 12
      Width = 83
      Height = 15
      Caption = #1042' '#1085#1086#1074#1099#1081' '#1084#1077#1089#1103#1094
    end
    object cxGridS: TcxGrid
      Left = 20
      Top = 29
      Width = 165
      Height = 308
      TabOrder = 0
      object cxGridSTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        OptionsView.Header = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridS_MONTHSTR: TcxGridColumn
          Caption = #1052#1077#1089#1103#1094
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
        object cxGridS_YEAR: TcxGridColumn
          Caption = #1043#1086#1076
          DataBinding.ValueType = 'Integer'
          Visible = False
          GroupIndex = 0
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soDescending
          Width = 30
        end
        object cxGridS_DATE: TcxGridColumn
          DataBinding.ValueType = 'DateTime'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridSLevel: TcxGridLevel
        GridView = cxGridSTable
      end
    end
    object cxGridT: TcxGrid
      Left = 212
      Top = 29
      Width = 165
      Height = 308
      TabOrder = 1
      object cxGridTTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        OptionsView.Header = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridT_MONTHSTR: TcxGridColumn
          Caption = #1052#1077#1089#1103#1094
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
        object cxGridT_YEAR: TcxGridColumn
          Caption = #1043#1086#1076
          DataBinding.ValueType = 'Integer'
          Visible = False
          GroupIndex = 0
          HeaderAlignmentHorz = taCenter
          Width = 30
        end
        object cxGridT_DATE: TcxGridColumn
          DataBinding.ValueType = 'DateTime'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridTLevel: TcxGridLevel
        GridView = cxGridTTable
      end
    end
  end
  object btnOk: TcxButton
    Left = 208
    Top = 440
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 313
    Top = 440
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
