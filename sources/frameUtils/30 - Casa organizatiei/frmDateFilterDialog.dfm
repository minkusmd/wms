object frmDateFilterDlg: TfrmDateFilterDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 310
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 473
    Height = 64
    Title = #1060#1080#1083#1100#1090#1088
    Text = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1087#1086' '#1080#1085#1090#1077#1088#1074#1072#1083#1091' '#1076#1072#1090
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
    ImageIndex = 5
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 457
    Height = 181
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Padding.Top = 16
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 292
      Top = 117
      Width = 97
      Height = 15
      Caption = #1075#1086#1090#1086#1074#1099#1077' '#1087#1077#1088#1080#1086#1076#1099
      Transparent = True
    end
    object deDateStart: TcxDateEdit
      Left = 104
      Top = 105
      Properties.ClearKey = 16430
      Properties.DateButtons = [btnNow, btnToday]
      Properties.ImmediatePost = True
      Properties.InputKind = ikRegExpr
      Properties.PostPopupValueOnTab = True
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 11
      Width = 174
    end
    object deDateEnd: TcxDateEdit
      Left = 103
      Top = 134
      Properties.ClearKey = 16430
      Properties.PostPopupValueOnTab = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 13
      Width = 175
    end
    object cmbQuickDate: TcxComboBox
      Left = 292
      Top = 134
      TabStop = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.OnEditValueChanged = cmbQuickDatePropertiesEditValueChanged
      TabOrder = 14
      Width = 137
    end
    object rbQuarter: TcxRadioButton
      Left = 20
      Top = 21
      Width = 78
      Height = 18
      Caption = #1050#1074#1072#1088#1090#1072#1083
      TabOrder = 3
      OnClick = rbQuarterClick
    end
    object rbMonth: TcxRadioButton
      Left = 20
      Top = 50
      Width = 78
      Height = 18
      Caption = #1052#1077#1089#1103#1094
      TabOrder = 7
      OnClick = rbQuarterClick
    end
    object rbDay: TcxRadioButton
      Left = 20
      Top = 79
      Width = 78
      Height = 18
      Caption = #1044#1077#1085#1100
      TabOrder = 10
      OnClick = rbQuarterClick
    end
    object rbDateRange: TcxRadioButton
      Left = 20
      Top = 108
      Width = 78
      Height = 18
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
      TabOrder = 12
      OnClick = rbQuarterClick
    end
    object cbQuarterYearStart: TcxCheckBox
      Left = 292
      Top = 18
      Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1075#1086#1076#1072
      TabOrder = 2
    end
    object cbMonthQuarterStart: TcxCheckBox
      Left = 292
      Top = 47
      Caption = #1057' '#1085#1072#1095#1072#1083#1086' '#1082#1074#1072#1088#1090#1072#1083#1072
      TabOrder = 6
    end
    object cbDayMonthStart: TcxCheckBox
      Left = 292
      Top = 76
      Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1084#1077#1089#1103#1094#1072
      TabOrder = 9
    end
    object cmbQuarter: TcxComboBox
      Left = 104
      Top = 18
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'I '#1050#1074#1072#1088#1090#1072#1083
        'II  '#1050#1074#1072#1088#1090#1072#1083
        'III  '#1050#1074#1072#1088#1090#1072#1083
        'IV  '#1050#1074#1072#1088#1090#1072#1083)
      TabOrder = 0
      Text = 'I '#1050#1074#1072#1088#1090#1072#1083
      Width = 113
    end
    object cmbMonth: TcxComboBox
      Left = 104
      Top = 47
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
      TabOrder = 4
      Text = #1071#1085#1074#1072#1088#1100
      Width = 113
    end
    object seQuarterYear: TcxSpinEdit
      Left = 223
      Top = 18
      Properties.Alignment.Horz = taCenter
      Properties.CanEdit = False
      Properties.ImmediatePost = True
      Properties.LargeIncrement = 1.000000000000000000
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzLeftRight
      TabOrder = 1
      Value = 2009
      Width = 55
    end
    object seMonthYear: TcxSpinEdit
      Left = 223
      Top = 47
      Properties.Alignment.Horz = taCenter
      Properties.CanEdit = False
      Properties.ImmediatePost = True
      Properties.LargeIncrement = 1.000000000000000000
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzLeftRight
      TabOrder = 5
      Value = 2009
      Width = 55
    end
    object deDateByDay: TcxDateEdit
      Left = 104
      Top = 76
      Properties.ClearKey = 16430
      Properties.DateButtons = [btnNow, btnToday]
      Properties.ImmediatePost = True
      Properties.InputKind = ikRegExpr
      Properties.PostPopupValueOnTab = True
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 8
      Width = 174
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 261
    Width = 473
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnCancel: TcxButton
      Left = 361
      Top = 6
      Width = 90
      Height = 29
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 257
      Top = 6
      Width = 90
      Height = 29
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
end
