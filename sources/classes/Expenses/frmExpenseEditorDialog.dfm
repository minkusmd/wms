object frmExpenseEditorDlg: TfrmExpenseEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1088#1072#1089#1093#1086#1076
  ClientHeight = 558
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    447
    558)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 447
    Height = 64
    Title = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1088#1072#1089#1093#1086#1076
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 431
    Height = 430
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
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 54
      Height = 15
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090
    end
    object Label3: TLabel
      Left = 24
      Top = 76
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object Label4: TLabel
      Left = 24
      Top = 128
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label5: TLabel
      Left = 24
      Top = 248
      Width = 109
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1088#1072#1089#1093#1086#1076#1086#1074
    end
    object Label6: TLabel
      Left = 24
      Top = 352
      Width = 64
      Height = 15
      Caption = #1057#1091#1084#1084#1072', '#1083#1077#1081
    end
    object Label1: TLabel
      Left = 24
      Top = 192
      Width = 59
      Height = 15
      Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
    end
    object beDocID: TcxButtonEdit
      Left = 24
      Top = 41
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beDocIDPropertiesButtonClick
      TabOrder = 0
      Width = 369
    end
    object beDT: TcxButtonEdit
      Left = 24
      Top = 93
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beDTPropertiesButtonClick
      TabOrder = 1
      Width = 369
    end
    object beCT: TcxButtonEdit
      Left = 24
      Top = 145
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCTPropertiesButtonClick
      TabOrder = 2
      Width = 369
    end
    object mmDETAILS: TcxDBMemo
      Left = 24
      Top = 265
      DataBinding.DataField = 'DETAILS'
      Properties.ScrollBars = ssVertical
      TabOrder = 4
      Height = 64
      Width = 369
    end
    object edSUMA: TcxDBTextEdit
      Left = 24
      Top = 369
      DataBinding.DataField = 'SUMA'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Width = 133
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 24
      Top = 209
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DataBinding.DataField = 'ANALITICAID'
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'ANALITICAID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 180
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          Width = 180
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceExpAnalytics
      ShowHint = True
      TabOrder = 3
      Width = 369
    end
  end
  object btnOk: TButton
    Left = 229
    Top = 513
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 334
    Top = 513
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryExpAnalytics: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' ANALITICAID, '
      ' TITLE,'
      ' PARENT_TITLE'
      'FROM '
      ' SP_GET_ANALYTICS_FOR_EXPENSES'
      'ORDER BY PARENT_TITLE,TITLE')
    Left = 240
    Top = 56
  end
  object IBCDataSourceExpAnalytics: TIBCDataSource
    DataSet = IBCQueryExpAnalytics
    Left = 240
    Top = 8
  end
end
