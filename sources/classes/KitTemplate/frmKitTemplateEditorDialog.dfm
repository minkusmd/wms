object frmKitTemplateEditorDlg: TfrmKitTemplateEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1064#1072#1073#1083#1086#1085' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
  ClientHeight = 293
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    482
    293)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 482
    Height = 64
    Title = #1064#1072#1073#1083#1086#1085' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
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
  end
  object pnKit: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 466
    Height = 161
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
      Top = 18
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 47
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      Transparent = True
    end
    object edTITLE: TcxDBTextEdit
      Left = 77
      Top = 15
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      TabOrder = 0
      Width = 366
    end
    object edDESCRIPTION: TcxDBMemo
      Left = 77
      Top = 44
      DataBinding.DataField = 'DESCRIPTION'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 1
      Width = 366
    end
    object cbFLG_PUBLIC: TcxDBCheckBox
      Left = 12
      Top = 112
      Caption = #1064#1072#1073#1083#1086#1085' '#1076#1083#1103' '#1086#1073#1097#1077#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103
      DataBinding.DataField = 'FLG_PUBLIC'
      ParentFont = False
      Properties.Alignment = taRightJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
  end
  object btnOk: TcxButton
    Left = 268
    Top = 249
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 372
    Top = 249
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
