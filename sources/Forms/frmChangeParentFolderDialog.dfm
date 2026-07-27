object frmChangeParentFolderDlg: TfrmChangeParentFolderDlg
  Left = 0
  Top = 0
  ActiveControl = cxTree
  BorderIcons = [biSystemMenu]
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1077#1076#1082#1072
  ClientHeight = 720
  ClientWidth = 485
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 485
    Height = 64
    Title = 'Modifica mapa parinte'
    Text = 'Selectati o alta mapa parinte'
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
    ImageIndex = 7
  end
  object cxTree: TcxTreeList
    AlignWithMargins = True
    Left = 8
    Top = 219
    Width = 469
    Height = 448
    Margins.Left = 8
    Margins.Top = 1
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    Bands = <
      item
      end>
    Filter.Options = [fcoCaseInsensitive]
    Filter.Active = True
    FindPanel.ApplyInputDelay = 500
    FindPanel.Behavior = fcbFilter
    FindPanel.DisplayMode = fpdmAlways
    FindPanel.FocusContentOnApplyFilter = True
    FindPanel.UseExtendedSyntax = True
    Images = dmAdditions.cxImageList_SWN
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.IncSearch = True
    OptionsBehavior.Sorting = False
    OptionsCustomizing.ColumnHorzSizing = False
    OptionsCustomizing.ColumnMoving = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.InvertSelect = False
    OptionsView.ScrollBars = ssVertical
    OptionsView.ColumnAutoWidth = True
    OptionsView.GridLineColor = 13750737
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.OnGetContentStyle = cxTreeStylesGetContentStyle
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    TabOrder = 2
    OnDeletion = cxTreeDeletion
    OnExpanding = cxTreeExpanding
    OnSelectionChanged = cxTreeSelectionChanged
    object trTree_TITLE: TcxTreeListColumn
      Caption.Text = 'Mapa'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object trTree_GOODSID: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taRightJustify
      Caption.AlignHorz = taCenter
      Caption.Text = 'Cod'
      Options.Sizing = False
      Width = 64
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object pnInfo: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 469
    Height = 145
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      465
      141)
    object cxLabel1: TLabel
      Left = 12
      Top = 44
      Width = 91
      Height = 15
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1088#1077#1076#1086#1082
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 15
      Width = 120
      Height = 15
      Caption = #1054#1073#1100#1077#1082#1090' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 76
      Width = 89
      Height = 15
      Caption = 'Istoricul mapelor'
      Transparent = True
    end
    object SpeedButton1: TSpeedButton
      Left = 411
      Top = 70
      Width = 23
      Height = 25
      Caption = '&>'
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 12
      Top = 112
      Width = 108
      Height = 15
      Caption = 'Codul mapei parinte'
    end
    object edParentTitle: TEdit
      Left = 196
      Top = 41
      Width = 238
      Height = 23
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 6205183
      ReadOnly = True
      TabOrder = 3
    end
    object edObjTitle: TEdit
      Left = 196
      Top = 12
      Width = 238
      Height = 23
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 1
    end
    object edObjID: TEdit
      Left = 142
      Top = 12
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
    end
    object edParentID: TEdit
      Left = 142
      Top = 41
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      Color = 6205183
      ReadOnly = True
      TabOrder = 2
    end
    object cmbHistoryFolders: TcxComboBox
      Left = 142
      Top = 70
      TabOrder = 4
      Width = 263
    end
    object nbParentID: TNumberBox
      Left = 144
      Top = 112
      Width = 81
      Height = 23
      TabOrder = 5
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 679
    Width = 485
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      485
      41)
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 374
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      AlignWithMargins = True
      Left = 268
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 72
    Top = 228
  end
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    Options.BooleanDomainFields = True
    Left = 72
    Top = 276
  end
  object IBCQueryTemp: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    AutoCommit = False
    Options.BooleanDomainFields = True
    Left = 72
    Top = 336
  end
end
