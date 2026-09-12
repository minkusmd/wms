object frmMoneyAcceptDlg: TfrmMoneyAcceptDlg
  Left = 0
  Top = 0
  ActiveControl = ceSUMA_CT
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080
  ClientHeight = 535
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    646
    535)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 646
    Height = 64
    Title = #1055#1088#1080#1085#1103#1090#1100' '#1076#1077#1085#1100#1075#1080
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 630
    Height = 404
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
      Top = 16
      Width = 92
      Height = 15
      Caption = #1054#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 58
      Height = 15
      Caption = #1048#1079' '#1092#1080#1088#1084#1099
    end
    object Label4: TLabel
      Left = 16
      Top = 116
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label5: TLabel
      Left = 16
      Top = 232
      Width = 10
      Height = 15
      Caption = #1071','
    end
    object Label6: TLabel
      Left = 16
      Top = 280
      Width = 58
      Height = 15
      Caption = #1048#1079' '#1092#1080#1088#1084#1099
    end
    object Label7: TLabel
      Left = 16
      Top = 332
      Width = 82
      Height = 15
      Caption = #1055#1088#1080#1085#1103#1083' '#1089#1091#1084#1084#1091
    end
    object Label3: TLabel
      Left = 136
      Top = 116
      Width = 41
      Height = 15
      Caption = #1042#1072#1083#1102#1090#1072
    end
    object Label8: TLabel
      Left = 134
      Top = 332
      Width = 50
      Height = 15
      Caption = #1042' '#1074#1072#1083#1102#1090#1077
    end
    object Label9: TLabel
      Left = 302
      Top = 16
      Width = 140
      Height = 15
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
    end
    object edUSER_DT_NAME: TcxDBTextEdit
      Left = 16
      Top = 33
      TabStop = False
      DataBinding.DataField = 'USER_DT_NAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 253
    end
    object edDT_NAME: TcxDBTextEdit
      Left = 16
      Top = 80
      TabStop = False
      DataBinding.DataField = 'DT_NAME'
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 253
    end
    object cbFLG_ACNT_DT: TcxDBCheckBox
      Left = 16
      Top = 168
      TabStop = False
      Caption = #1041#1072#1085#1082
      DataBinding.DataField = 'FLG_ACNT_DT'
      Properties.Alignment = taLeftJustify
      Properties.ReadOnly = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
    end
    object ceSUMA_DT: TcxDBCurrencyEdit
      Left = 16
      Top = 132
      TabStop = False
      DataBinding.DataField = 'SUMA_DT'
      Properties.DisplayFormat = '#,##0.00'
      Properties.ReadOnly = True
      TabOrder = 4
      Width = 109
    end
    object edUSER_CT_NAME: TcxDBTextEdit
      Left = 16
      Top = 248
      TabStop = False
      DataBinding.DataField = 'USER_CT_NAME'
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 7
      Width = 253
    end
    object edCT_NAME: TcxDBTextEdit
      Left = 16
      Top = 296
      TabStop = False
      DataBinding.DataField = 'CT_NAME'
      Properties.ReadOnly = True
      TabOrder = 8
      Width = 253
    end
    object ceSUMA_CT: TcxCurrencyEdit
      Left = 16
      Top = 348
      EditValue = 0c
      Properties.DisplayFormat = '#,##0.00'
      Style.TextStyle = [fsBold]
      TabOrder = 9
      Width = 105
    end
    object edCURRENCY_CT_NAME: TcxDBTextEdit
      Left = 134
      Top = 348
      TabStop = False
      DataBinding.DataField = 'CURRENCY_CT_NAME'
      Properties.ReadOnly = True
      TabOrder = 10
      Width = 135
    end
    object edCURRENCY_DT_NAME: TcxDBTextEdit
      Left = 136
      Top = 132
      TabStop = False
      DataBinding.DataField = 'CURRENCY_DT_NAME'
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 133
    end
    inline frameMoneyCounter: TframeMoneyCounter
      Left = 302
      Top = 125
      Width = 300
      Height = 246
      Constraints.MaxHeight = 246
      Constraints.MaxWidth = 300
      Constraints.MinHeight = 246
      Constraints.MinWidth = 300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ExplicitLeft = 302
      ExplicitTop = 125
      inherited cxGridBanknotes: TcxGrid
        inherited cxGridBanknotesTable: TcxGridTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0'
              Kind = skSum
              Column = frameMoneyCounter.cxGridBanknotesTableCol3
            end
            item
              Format = '0'
              Kind = skSum
              Column = frameMoneyCounter.cxGridBanknotesTableCol2
            end>
        end
      end
    end
    object mmCOMMENT: TcxDBMemo
      Left = 302
      Top = 33
      TabStop = False
      DataBinding.DataField = 'COMMENT'
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      TabOrder = 1
      Height = 70
      Width = 300
    end
  end
  object btnOk: TcxButton
    Left = 434
    Top = 491
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 534
    Top = 491
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
