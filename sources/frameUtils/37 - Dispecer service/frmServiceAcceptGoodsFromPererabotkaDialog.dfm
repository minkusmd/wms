object frmServiceAcceptGoodsFromPererabotkaDlg: TfrmServiceAcceptGoodsFromPererabotkaDlg
  Left = 0
  Top = 0
  ActiveControl = lcbEXEC_PERSONAL_GROUP_ID
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1085#1103#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1086#1095#1077#1088#1077#1076#1100' '#1085#1072' '#1088#1077#1084#1086#1085#1090
  ClientHeight = 540
  ClientWidth = 524
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
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 524
    Height = 64
    Title = #1055#1088#1080#1085#1103#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1086#1095#1077#1088#1077#1076#1100' '#1085#1072' '#1088#1077#1084#1086#1085#1090
    Text = 
      #1055#1088#1086#1074#1077#1088#1090#1077' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1080' '#1076#1072#1085#1085#1099#1093' '#1080' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1091' '#1080#1085#1078#1080#1085#1077#1088#1086 +
      #1074
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 508
    Height = 413
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 193
      Height = 15
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1077' ('#1090#1086#1074#1072#1088#1077')'
    end
    object Label2: TLabel
      Left = 16
      Top = 364
      Width = 304
      Height = 15
      Caption = #1042#1099' '#1093#1086#1090#1080#1090#1077' '#1087#1088#1080#1085#1103#1090#1100' '#1076#1072#1085#1085#1099#1081' '#1090#1086#1074#1072#1088' '#1074' '#1086#1095#1077#1088#1077#1076#1100' '#1085#1072' '#1088#1077#1084#1086#1085#1090'?'
    end
    object Label3: TLabel
      Left = 16
      Top = 291
      Width = 110
      Height = 15
      Caption = #1043#1088#1091#1087#1087#1072' '#1080#1085#1078#1080#1085#1077#1088#1086#1074'*'
    end
    object cxDBVerticalGrid: TcxDBVerticalGrid
      Left = 16
      Top = 36
      Width = 465
      Height = 237
      OptionsView.CellAutoHeight = True
      OptionsView.ScrollBars = ssVertical
      OptionsView.RowHeaderWidth = 136
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
      TabOrder = 0
      Version = 1
      object cxDBVerticalGridDBEditorRow1: TcxDBEditorRow
        Properties.Caption = #1050#1086#1076' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
        Properties.EditPropertiesClassName = 'TcxLabelProperties'
        Properties.EditProperties.Alignment.Horz = taLeftJustify
        Properties.DataBinding.FieldName = 'INCIDENTID'
        Styles.Content = dmAdditions.cxStyle_BoldYellowBack
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow2: TcxDBEditorRow
        Properties.Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        Properties.DataBinding.FieldName = 'DOC_CUSTOMER'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow3: TcxDBEditorRow
        Properties.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Properties.DataBinding.FieldName = 'GOODS_TITLE'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow4: TcxDBEditorRow
        Properties.Caption = #1052#1086#1076#1077#1083#1100
        Properties.DataBinding.FieldName = 'GOODS_MODEL'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow5: TcxDBEditorRow
        Properties.Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
        Properties.DataBinding.FieldName = 'GOODS_SN'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow7: TcxDBEditorRow
        Properties.Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
        Properties.DataBinding.FieldName = 'ASPECT_VISUAL_DSC'
        Styles.Content = dmAdditions.cxStyle_Italic
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow6: TcxDBEditorRow
        Properties.Caption = #1044#1077#1092#1077#1082#1090#1099
        Properties.DataBinding.FieldName = 'DEFECTE_DSC'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow9: TcxDBEditorRow
        Properties.Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103
        Properties.DataBinding.FieldName = 'GARNITURA_LIST'
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxDBVerticalGridDBEditorRow8: TcxDBEditorRow
        Properties.Caption = #1055#1088#1080#1077#1084#1097#1080#1082
        Properties.DataBinding.FieldName = 'CREATED_FULL_NAME'
        Styles.Content = dmAdditions.cxStyle_TextGray
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
    end
    object lcbEXEC_PERSONAL_GROUP_ID: TcxLookupComboBox
      Left = 16
      Top = 308
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'GROUPID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceGroups
      EditValue = -1
      TabOrder = 1
      Width = 303
    end
  end
  object btnOk: TButton
    Left = 312
    Top = 496
    Width = 90
    Height = 29
    Caption = #1044#1072
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 416
    Top = 496
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1053#1077#1090
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryGroups: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SElECT'
      'GROUPID, NAME'
      'FROM VW_TS_USER_GROUPS'
      'WHERE FLG_SERVICE_ENGINER=1'
      'ORDER BY NAME')
    Left = 248
    Top = 336
  end
  object IBCDataSourceGroups: TIBCDataSource
    DataSet = IBCQueryGroups
    Left = 248
    Top = 288
  end
end
