object frm52ZamenaTovaraSelectSNDlg: Tfrm52ZamenaTovaraSelectSNDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridAvSN
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1085#1086#1084#1077#1088#1072
  ClientHeight = 628
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    402
    628)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 402
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1085#1086#1084#1077#1088#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072
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
    ImageIndex = 17
  end
  object pnGoods: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 386
    Height = 497
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 20
      Top = 19
      Width = 83
      Height = 15
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Transparent = True
    end
    object Label3: TLabel
      Left = 20
      Top = 98
      Width = 164
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
    end
    object Label1: TLabel
      Left = 20
      Top = 444
      Width = 86
      Height = 15
      Caption = #1041#1099#1089#1090#1088#1099#1081' '#1087#1086#1080#1089#1082
    end
    object cxGridAvSN: TcxGrid
      AlignWithMargins = True
      Left = 20
      Top = 117
      Width = 337
      Height = 321
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      TabOrder = 0
      object cxGridAvSNTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridAvSNTableCellDblClick
        OnSelectionChanged = cxGridAvSNTableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridAvSNTable_SN
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridAvSNTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.IncSearch = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridAvSNTable_SN: TcxGridColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          FooterAlignmentHorz = taRightJustify
          SortIndex = 0
          SortOrder = soAscending
        end
        object cxGridAvSNTable_COUNTRYID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
        end
        object cxGridAvSNTable_VENDORID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
        end
      end
      object cxGridAvSNLevel: TcxGridLevel
        GridView = cxGridAvSNTable
      end
    end
    object edQuickSearchAv: TEdit
      Left = 112
      Top = 441
      Width = 245
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = edQuickSearchAvChange
    end
    object mmInfo: TcxMemo
      Left = 20
      Top = 36
      TabStop = False
      Lines.Strings = (
        'mmInfo')
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      TabOrder = 2
      Height = 49
      Width = 337
    end
  end
  object btnOk: TButton
    Left = 187
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 291
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
