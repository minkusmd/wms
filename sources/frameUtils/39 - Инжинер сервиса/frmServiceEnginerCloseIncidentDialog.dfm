object frmServiceEnginerCloseIncidentDlg: TfrmServiceEnginerCloseIncidentDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
  ClientHeight = 393
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    397
    393)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 397
    Height = 64
    Title = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1089#1090#1072#1090#1091#1089' '#1079#1072#1074#1077#1088#1096#1072#1077#1084#1086#1075#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
    ImageIndex = 24
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 381
    Height = 266
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
      Left = 12
      Top = 16
      Width = 239
      Height = 15
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1090#1072#1090#1091#1089' '#1079#1072#1074#1077#1088#1096#1072#1077#1084#1086#1075#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1072':'
    end
    object cxGrid: TcxGrid
      Left = 12
      Top = 33
      Width = 352
      Height = 180
      TabOrder = 0
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDS_FinalSyss
        DataController.KeyFieldNames = 'SYSSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.Indicator = True
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_TITLE: TcxGridDBColumn
          DataBinding.FieldName = 'TITLE'
        end
        object cxGridTable_SYSSID: TcxGridDBColumn
          DataBinding.FieldName = 'SYSSID'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object cbCreateReturn: TCheckBox
      Left = 12
      Top = 228
      Width = 209
      Height = 17
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1074#1086#1079#1074#1088#1072#1090' '#1090#1086#1074#1072#1088#1072' '#1082#1083#1080#1077#1085#1090#1091'?'
      TabOrder = 1
    end
  end
  object btnOk: TButton
    Left = 184
    Top = 349
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 284
    Top = 349
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDS_FinalSyss: TIBCDataSource
    AutoEdit = False
    DataSet = ibcFinalSyss
    Left = 100
    Top = 128
  end
  object ibcFinalSyss: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select SYSSID, TITLE '
      'from ts_syss '
      'where (parentid=21) and (value_int=1)')
    ReadOnly = True
    Constraints = <>
    Left = 188
    Top = 128
  end
end
