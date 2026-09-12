object frmRealizareaSelectSNDlg: TfrmRealizareaSelectSNDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridAvSN
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1085#1086#1084#1077#1088#1072
  ClientHeight = 628
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    804
    628)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 804
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1085#1086#1084#1077#1088#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072
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
    Width = 788
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
      Left = 12
      Top = 19
      Width = 83
      Height = 15
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 581
      Top = 19
      Width = 127
      Height = 15
      Caption = #1058#1088#1077#1073#1091#1077#1084#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Transparent = True
    end
    object Label3: TLabel
      Left = 12
      Top = 54
      Width = 164
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
    end
    object Label4: TLabel
      Left = 378
      Top = 54
      Width = 168
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1077' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
    end
    object sbAddSerials: TSpeedButton
      Left = 323
      Top = 70
      Width = 36
      Height = 29
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddSerialsClick
    end
    object sbRemoveSerials: TSpeedButton
      Left = 323
      Top = 105
      Width = 36
      Height = 29
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemoveSerialsClick
    end
    object sbAddAllSerials: TSpeedButton
      Left = 323
      Top = 157
      Width = 36
      Height = 29
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddAllSerialsClick
    end
    object sbRemoveAllSerials: TSpeedButton
      Left = 323
      Top = 192
      Width = 36
      Height = 29
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemoveAllSerialsClick
    end
    object lbInfo: TLabel
      Left = 12
      Top = 461
      Width = 749
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Color = 28895
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 12
      Top = 416
      Width = 86
      Height = 15
      Caption = #1041#1099#1089#1090#1088#1099#1081' '#1087#1086#1080#1089#1082
    end
    object Label2: TLabel
      Left = 378
      Top = 419
      Width = 86
      Height = 15
      Caption = #1041#1099#1089#1090#1088#1099#1081' '#1087#1086#1080#1089#1082
    end
    object edGOODS_NAME: TcxDBTextEdit
      Left = 156
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODS_TITLE'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 397
    end
    object edQTY: TcxDBTextEdit
      Left = 715
      Top = 16
      TabStop = False
      DataBinding.DataField = 'QTY'
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Width = 46
    end
    object cxGridAvSN: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 70
      Width = 290
      Height = 340
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      TabOrder = 3
      object cxGridAvSNTable: TcxGridTableView
        OnKeyDown = cxGridAvSNTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
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
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
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
      end
      object cxGridAvSNLevel: TcxGridLevel
        GridView = cxGridAvSNTable
      end
    end
    object cxGridSelSN: TcxGrid
      AlignWithMargins = True
      Left = 378
      Top = 73
      Width = 383
      Height = 340
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      TabOrder = 4
      object cxGridSelSNTable: TcxGridTableView
        OnKeyDown = cxGridSelSNTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridSelSNTableCellDblClick
        OnSelectionChanged = cxGridAvSNTableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridSelSNTable_SN
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
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSelSNTable_IMG: TcxGridColumn
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
        object cxGridSelSNTable_SN: TcxGridColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          FooterAlignmentHorz = taRightJustify
          SortIndex = 0
          SortOrder = soAscending
        end
        object cxGridSelSN_USER_NAME: TcxGridColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
      end
      object cxGridSelSNLevel: TcxGridLevel
        GridView = cxGridSelSNTable
      end
    end
    object edGOODSID: TcxDBTextEdit
      Left = 101
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 52
    end
    object edQuickSearchAv: TEdit
      Left = 104
      Top = 413
      Width = 198
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 5
      OnChange = edQuickSearchAvChange
    end
    object edQuickSearchSel: TEdit
      Left = 470
      Top = 416
      Width = 291
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 6
      OnChange = edQuickSearchSelChange
    end
  end
  object btnOk: TButton
    Left = 589
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 693
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
