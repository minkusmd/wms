object frmChatGroupSetupDlg: TfrmChatGroupSetupDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1063#1072#1090' '#1075#1088#1091#1087#1087#1072
  ClientHeight = 586
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    550
    586)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 550
    Height = 64
    Title = #1063#1072#1090' '#1075#1088#1091#1087#1087#1072
    Text = ''
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
    ImageIndex = 27
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 534
    Height = 461
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
      Left = 16
      Top = 60
      Width = 128
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1074' '#1075#1088#1091#1087#1087#1077
    end
    object Label2: TLabel
      Left = 284
      Top = 60
      Width = 140
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    end
    object Label3: TLabel
      Left = 16
      Top = 300
      Width = 96
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    end
    object sbAddToSelected: TSpeedButton
      Left = 239
      Top = 92
      Width = 39
      Height = 39
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbAddToSelectedClick
    end
    object sbRemoveFromSelected: TSpeedButton
      Left = 239
      Top = 137
      Width = 39
      Height = 39
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbRemoveFromSelectedClick
    end
    object Label4: TLabel
      Left = 16
      Top = 360
      Width = 99
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    end
    object cxGridS: TcxGrid
      Left = 16
      Top = 78
      Width = 217
      Height = 200
      TabOrder = 1
      object cxGridSTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCanSelectRecord = cxGridSTableCanSelectRecord
        OnCellDblClick = cxGridSTableCellClick
        OnSelectionChanged = cxGridATableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.OnGetContentStyle = cxGridSTableStylesGetContentStyle
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSTable_ID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridSTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DefaultImageIndex = 10
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridSTable_NAME: TcxGridColumn
          SortIndex = 0
          SortOrder = soAscending
        end
      end
      object cxGridSLevel: TcxGridLevel
        GridView = cxGridSTable
      end
    end
    object cxGridA: TcxGrid
      Left = 284
      Top = 78
      Width = 217
      Height = 200
      TabOrder = 2
      object cxGridATable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridATableCellClick
        OnSelectionChanged = cxGridATableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridATable_ID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridATable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DefaultImageIndex = 10
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridATable_NAME: TcxGridColumn
          SortIndex = 0
          SortOrder = soAscending
        end
      end
      object cxGridALevel: TcxGridLevel
        GridView = cxGridATable
      end
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 317
      DataBinding.DataField = 'TITLE'
      TabOrder = 3
      Width = 485
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 16
      Top = 377
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 4
      Width = 485
    end
    object cbFLG_PRIVATE: TcxDBCheckBox
      Left = 16
      Top = 16
      Caption = #1055#1088#1080#1074#1072#1090#1085#1072#1103' '#1075#1088#1091#1087#1087#1072
      DataBinding.DataField = 'FLG_PRIVATE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
  end
  object btnOk: TButton
    Left = 335
    Top = 544
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 439
    Top = 544
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
