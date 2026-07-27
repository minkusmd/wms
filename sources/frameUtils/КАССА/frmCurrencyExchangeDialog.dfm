object frmCurrencyExchangeDlg: TfrmCurrencyExchangeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1073#1084#1077#1085' '#1074#1072#1083#1102#1090#1099
  ClientHeight = 417
  ClientWidth = 499
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
  DesignSize = (
    499
    417)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 499
    Height = 64
    Title = #1054#1073#1084#1077#1085' '#1074#1072#1083#1102#1090#1099
    Text = #1042#1085#1091#1090#1088#1077#1085#1085#1080#1081' '#1086#1073#1084#1077#1085' '#1074#1072#1083#1102#1090#1099
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
    ImageIndex = 4
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 483
    Height = 286
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
    object cxLabel1: TLabel
      Left = 16
      Top = 75
      Width = 103
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1074#1072#1083#1102#1090#1072
    end
    object cxLabel2: TLabel
      Left = 324
      Top = 76
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label2: TLabel
      Left = 228
      Top = 20
      Width = 58
      Height = 15
      Caption = #1048#1079' '#1092#1080#1088#1084#1099
    end
    object Label3: TLabel
      Left = 228
      Top = 76
      Width = 26
      Height = 15
      Caption = #1050#1091#1088#1089
    end
    object Label4: TLabel
      Left = 16
      Top = 131
      Width = 104
      Height = 15
      Caption = #1060#1080#1085#1072#1083#1100#1085#1072#1103' '#1074#1072#1083#1102#1090#1072
    end
    object Label5: TLabel
      Left = 324
      Top = 132
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label6: TLabel
      Left = 228
      Top = 132
      Width = 26
      Height = 15
      Caption = #1050#1091#1088#1089
    end
    object lbInitCurrName: TLabel
      Left = 405
      Top = 96
      Width = 53
      Height = 15
      AutoSize = False
      Caption = 'lbInitCurrName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbEndCurrName: TLabel
      Left = 405
      Top = 152
      Width = 53
      Height = 15
      AutoSize = False
      Caption = 'lbEndCurrName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 16
      Top = 192
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object edUserName: TcxTextEdit
      Left = 16
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 193
    end
    object edFirmaName: TcxTextEdit
      Left = 228
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 230
    end
    object cmbInitCurrency: TcxLookupComboBox
      Left = 16
      Top = 92
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.OnEditValueChanged = cmbInitCurrencyPropertiesEditValueChanged
      EditValue = 0
      TabOrder = 2
      Width = 193
    end
    object cmbEndCurrency: TcxLookupComboBox
      Left = 16
      Top = 148
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.OnEditValueChanged = cmbEndCurrencyPropertiesEditValueChanged
      EditValue = 0
      TabOrder = 5
      Width = 193
    end
    object edInitRate: TcxCurrencyEdit
      Left = 228
      Top = 93
      EditValue = 1.000000000000000000
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = '#,####0.0000'
      Properties.Nullable = False
      Properties.OnEditValueChanged = edInitRatePropertiesEditValueChanged
      Properties.OnValidate = edInitRatePropertiesValidate
      TabOrder = 3
      Width = 78
    end
    object edEndRate: TcxCurrencyEdit
      Left = 228
      Top = 149
      EditValue = 1.000000000000000000
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = '#,####0.0000'
      Properties.Nullable = False
      Properties.OnEditValueChanged = edEndRatePropertiesEditValueChanged
      Properties.OnValidate = edEndRatePropertiesValidate
      TabOrder = 6
      Width = 78
    end
    object edInitSuma: TcxCurrencyEdit
      Left = 324
      Top = 93
      EditValue = 0c
      Properties.DisplayFormat = '#,##0.00'
      Properties.Nullable = False
      Properties.OnEditValueChanged = edInitRatePropertiesEditValueChanged
      Properties.OnValidate = edInitSumaPropertiesValidate
      Style.TextStyle = [fsBold]
      TabOrder = 4
      Width = 78
    end
    object edEndSuma: TcxCurrencyEdit
      Left = 325
      Top = 149
      EditValue = 0c
      Properties.DisplayFormat = '#,##0.00'
      Properties.Nullable = False
      Properties.OnEditValueChanged = edEndRatePropertiesEditValueChanged
      Properties.OnValidate = edEndSumaPropertiesValidate
      Style.TextStyle = [fsBold]
      TabOrder = 7
      Width = 78
    end
    object mmComments: TcxMemo
      Left = 16
      Top = 209
      Properties.VisibleLineCount = 3
      TabOrder = 8
      Width = 442
    end
  end
  object btnCancel: TcxButton
    Left = 389
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 289
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
