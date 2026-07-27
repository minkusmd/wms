object frmSearchDocumentByIdDlg: TfrmSearchDocumentByIdDlg
  Left = 0
  Top = 0
  ActiveControl = edDocID
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1087#1086' '#1082#1086#1076#1091
  ClientHeight = 519
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    663
    519)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 663
    Height = 64
    Title = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1087#1086' '#1082#1086#1076#1091
    Text = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1087#1086' '#1082#1086#1076#1091' '#1080' '#1087#1077#1088#1077#1093#1086#1076' '#1082' '#1085#1080#1084#1091
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
    ImageIndex = 9
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 647
    Height = 393
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnClient'
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 28
      Width = 81
      Height = 15
      Caption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object btnSearch: TButton
      Left = 215
      Top = 22
      Width = 75
      Height = 29
      Caption = #1048#1089#1082#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnSearchClick
    end
    object edDocID: TEdit
      Left = 107
      Top = 25
      Width = 102
      Height = 23
      TabOrder = 1
      OnChange = edDocIDChange
      OnEnter = edDocIDEnter
    end
    object btnSearchParent: TButton
      Left = 296
      Top = 22
      Width = 109
      Height = 29
      Caption = #1053#1072#1081#1090#1080' '#1088#1086#1076#1080#1090#1077#1083#1103
      TabOrder = 2
      OnClick = btnSearchParentClick
    end
    object tabControlDocs: TcxTabControl
      Left = 20
      Top = 80
      Width = 601
      Height = 293
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      Properties.CloseButtonMode = cbmEveryTab
      Properties.CustomButtons.Buttons = <
        item
          HeaderImageIndex = 35
          Hint = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
          OnClick = tabControlDocsTcxTabControlPropertiesTcxPCCustomButtonsButtons0Click
        end>
      Properties.CustomButtons.HeaderImages = dmAdditions.cxImageList_SWN
      Properties.ShowButtonHints = True
      Properties.TabIndex = 0
      Properties.Tabs.Strings = (
        '53245')
      OnChange = tabControlDocsChange
      ClientRectBottom = 289
      ClientRectLeft = 4
      ClientRectRight = 597
      ClientRectTop = 31
      object cxDBVerticalGrid: TcxDBVerticalGrid
        Left = 8
        Top = 33
        Width = 429
        Height = 248
        OptionsView.ScrollBars = ssNone
        OptionsView.CategoryExplorerStyle = True
        OptionsView.RowHeaderWidth = 140
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.BandSizing = False
        OptionsBehavior.HeaderSizing = False
        OptionsBehavior.AllowChangeRecord = False
        OptionsData.Editing = False
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
        TabOrder = 0
        DataController.DataSource = IBCDataSourceDOCS
        Version = 1
        object rowDOCTYPE_NAME: TcxDBEditorRow
          Properties.Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Properties.DataBinding.FieldName = 'DOCTYPE_NAME'
          Styles.Content = dmAdditions.cxStyle_Bold
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object rowDOCID: TcxDBEditorRow
          Properties.Caption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Properties.EditPropertiesClassName = 'TcxLabelProperties'
          Properties.EditProperties.Alignment.Horz = taLeftJustify
          Properties.DataBinding.FieldName = 'DOCID'
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object rowPARENTDOCID: TcxDBEditorRow
          Properties.Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1088#1086#1076#1080#1090#1077#1083#1100
          Properties.EditPropertiesClassName = 'TcxLabelProperties'
          Properties.EditProperties.Alignment.Horz = taLeftJustify
          Properties.DataBinding.FieldName = 'PARENTDOCID'
          Properties.Options.ShowEditButtons = eisbAlways
          ID = 3
          ParentID = -1
          Index = 2
          Version = 1
        end
        object rowDATA: TcxDBEditorRow
          Properties.Caption = #1044#1072#1090#1072
          Properties.DataBinding.FieldName = 'DATA'
          ID = 4
          ParentID = -1
          Index = 3
          Version = 1
        end
        object rowDT_NAME: TcxDBEditorRow
          Properties.Caption = #1060#1080#1088#1084#1072
          Properties.DataBinding.FieldName = 'DT_NAME'
          ID = 5
          ParentID = -1
          Index = 4
          Version = 1
        end
        object rowCT_NAME: TcxDBEditorRow
          Properties.Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          Properties.DataBinding.FieldName = 'CT_NAME'
          ID = 6
          ParentID = -1
          Index = 5
          Version = 1
        end
        object rowCURRENCY_NAME: TcxDBEditorRow
          Properties.Caption = #1042#1072#1083#1102#1090#1072
          Properties.DataBinding.FieldName = 'CURRENCY_NAME'
          ID = 7
          ParentID = -1
          Index = 6
          Version = 1
        end
        object rowSUMA: TcxDBEditorRow
          Properties.Caption = #1057#1091#1084#1084#1072
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.Alignment.Horz = taLeftJustify
          Properties.EditProperties.DisplayFormat = '0.00'
          Properties.DataBinding.FieldName = 'SUMA'
          ID = 8
          ParentID = -1
          Index = 7
          Version = 1
        end
        object rowRATE: TcxDBEditorRow
          Properties.Caption = #1050#1091#1088#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Properties.EditPropertiesClassName = 'TcxLabelProperties'
          Properties.EditProperties.Alignment.Horz = taLeftJustify
          Properties.DataBinding.FieldName = 'RATE'
          ID = 9
          ParentID = -1
          Index = 8
          Version = 1
        end
        object rowRATEUSD: TcxDBEditorRow
          Properties.Caption = #1050#1091#1088#1089' USD'
          Properties.EditPropertiesClassName = 'TcxLabelProperties'
          Properties.EditProperties.Alignment.Horz = taLeftJustify
          Properties.DataBinding.FieldName = 'RATEUSD'
          ID = 10
          ParentID = -1
          Index = 9
          Version = 1
        end
        object rowCREATED_BY_NAME: TcxDBEditorRow
          Properties.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Properties.DataBinding.FieldName = 'CREATED_BY_NAME'
          ID = 11
          ParentID = -1
          Index = 10
          Version = 1
        end
      end
      object cxDBVerticalGridFlags: TcxDBVerticalGrid
        Left = 436
        Top = 33
        Width = 153
        Height = 248
        OptionsView.ScrollBars = ssNone
        OptionsView.RowHeaderWidth = 111
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.BandSizing = False
        OptionsBehavior.HeaderSizing = False
        OptionsBehavior.AllowChangeRecord = False
        OptionsData.Editing = False
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
        TabOrder = 1
        DataController.DataSource = IBCDataSourceDOCS
        Version = 1
        object cxDBVerticalGridFlagsDBEditorRow1: TcxDBEditorRow
          Properties.Caption = #1055#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Properties.Hint = 'FLG_ACNT'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_ACNT'
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow2: TcxDBEditorRow
          Properties.Caption = #1047#1072#1082#1088#1099#1090
          Properties.Hint = 'FLG_CLOSED'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_CLOSED'
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow3: TcxDBEditorRow
          Properties.Caption = #1059#1076#1072#1083#1077#1085
          Properties.Hint = 'FLG_DEL'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_DEL'
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow4: TcxDBEditorRow
          Properties.Hint = 'FLG_GOODS_ARRIVAL'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_GOODS_ARRIVAL'
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow5: TcxDBEditorRow
          Properties.Caption = #1056#1072#1089#1093#1086#1076
          Properties.Hint = 'FLG_INVOICE'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_INVOICE'
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow6: TcxDBEditorRow
          Properties.Caption = #1054#1087#1083#1072#1095#1077#1085
          Properties.Hint = 'FLG_PAID'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_PAID'
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow7: TcxDBEditorRow
          Properties.Caption = #1047#1072#1096#1080#1097#1077#1085
          Properties.Hint = 'FLG_PROTECTED'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_PROTECTED'
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow8: TcxDBEditorRow
          Properties.Caption = #1043#1086#1090#1086#1074
          Properties.Hint = 'FLG_READY'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_READY'
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow9: TcxDBEditorRow
          Properties.Caption = #1055#1088#1080#1085#1103#1090
          Properties.Hint = 'FLG_RECEIVE'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_RECEIVE'
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow10: TcxDBEditorRow
          Properties.Caption = #1054#1090#1087#1088#1072#1074#1083#1077#1085
          Properties.Hint = 'FLG_SEND'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_SEND'
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow11: TcxDBEditorRow
          Properties.Caption = #1054#1090#1075#1088#1091#1078#1077#1085
          Properties.Hint = 'FLG_SHIP'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_SHIP'
          ID = 10
          ParentID = -1
          Index = 10
          Version = 1
        end
        object cxDBVerticalGridFlagsDBEditorRow12: TcxDBEditorRow
          Properties.Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085
          Properties.Hint = 'FLG_EXPORTED'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ValueChecked = 1
          Properties.EditProperties.ValueUnchecked = 0
          Properties.DataBinding.FieldName = 'FLG_EXPORTED'
          ID = 11
          ParentID = -1
          Index = 11
          Version = 1
        end
      end
    end
  end
  object btnGotoDoc: TButton
    Left = 404
    Top = 476
    Width = 134
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 553
    Top = 476
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDOCS: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_DOCS'
      'WHERE DOCID=:DOCID')
    Left = 284
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDOCS: TIBCDataSource
    DataSet = IBCQueryDOCS
    Left = 284
    Top = 268
  end
end
