object frmDescriptionTemplateGTEditorDlg: TfrmDescriptionTemplateGTEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1096#1072#1073#1083#1086#1085#1072' '#1082' '#1090#1080#1087#1091' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 480
  ClientWidth = 711
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    711
    480)
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 695
    Height = 353
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 16
      Width = 143
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1077' '#1090#1080#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
    end
    object Label2: TLabel
      Left = 316
      Top = 16
      Width = 139
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1090#1080#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
    end
    object sbAddToSelected: TSpeedButton
      Left = 283
      Top = 56
      Width = 27
      Height = 27
      Caption = '<'
      OnClick = sbAddToSelectedClick
    end
    object sbAddToAvailable: TSpeedButton
      Left = 283
      Top = 89
      Width = 27
      Height = 27
      Caption = '>'
      OnClick = sbAddToAvailableClick
    end
    object cxGridS: TcxGrid
      Left = 20
      Top = 33
      Width = 257
      Height = 292
      TabOrder = 0
      object cxGridSTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridATableFocusedRecordChanged
        OnSelectionChanged = cxGridSTableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1074#1099#1073#1088#1072#1085#1085#1099#1093'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSTable_GOODSTYPEID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridSTable_TITLE_RUS: TcxGridColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          SortIndex = 0
          SortOrder = soAscending
        end
        object cxGridSTable_TITLE_ROM: TcxGridColumn
          Caption = 'Denumirea'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridSLevel: TcxGridLevel
        GridView = cxGridSTable
      end
    end
    object cxGridA: TcxGrid
      Left = 316
      Top = 33
      Width = 357
      Height = 292
      TabOrder = 1
      object cxGridATable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridATableFocusedRecordChanged
        OnSelectionChanged = cxGridATableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1076#1086#1089#1090#1091#1087#1085#1099#1093'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridATable_GOODSTYPEID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridATable_TITLE_RUS: TcxGridColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          SortIndex = 0
          SortOrder = soAscending
        end
        object cxGridATable_TITLE_ROM: TcxGridColumn
          Caption = 'Denumirea'
        end
      end
      object cxGridALevel: TcxGridLevel
        GridView = cxGridATable
      end
    end
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 711
    Height = 64
    Title = #1055#1088#1080#1074#1103#1079#1082#1072' '#1096#1072#1073#1083#1086#1085#1072' '#1082' '#1090#1080#1087#1091' '#1090#1086#1074#1072#1088#1086#1074
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1082#1072#1082#1080#1077' '#1090#1080#1087#1099' '#1090#1086#1074#1072#1088#1086#1074' '#1084#1086#1075#1091#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1081' '#1096#1072#1073#1083#1086#1085
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
    ImageIndex = 10
  end
  object btnOk: TButton
    Left = 503
    Top = 436
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 599
    Top = 436
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
