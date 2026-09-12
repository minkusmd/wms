object frmBPPLComissionDlg: TfrmBPPLComissionDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1072#1089#1095#1077#1090' '#1082#1086#1084#1080#1089#1089#1080#1086#1085#1072' '#1073#1072#1085#1082#1086#1074#1089#1082#1086#1075#1086' '#1087#1083#1072#1090#1077#1078#1072
  ClientHeight = 247
  ClientWidth = 421
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
    Width = 421
    Height = 64
    Title = 'Calculul comisionului  transferului bancar'
    Text = 'Indicati procentul'
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
    Width = 405
    Height = 121
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 108
      Height = 15
      Caption = 'Suma documentului'
    end
    object Label2: TLabel
      Left = 268
      Top = 24
      Width = 25
      Height = 15
      Caption = 'MDL'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 67
      Height = 15
      Caption = 'Comision, %'
    end
    object Label4: TLabel
      Left = 357
      Top = 64
      Width = 25
      Height = 15
      Caption = 'MDL'
    end
    object Label5: TLabel
      Left = 248
      Top = 64
      Width = 8
      Height = 15
      Caption = '='
    end
    object edSUMA: TcxDBCurrencyEdit
      Left = 141
      Top = 21
      TabStop = False
      DataBinding.DataField = 'SUMA'
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 121
    end
    object cePercent: TcxCalcEdit
      Left = 141
      Top = 61
      EditValue = 0.000000000000000000
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = cePercentPropertiesEditValueChanged
      TabOrder = 1
      Width = 101
    end
    object edCalcSuma: TcxTextEdit
      Left = 262
      Top = 61
      TabStop = False
      TabOrder = 2
      Text = 'edCalcSuma'
      Width = 89
    end
  end
  object btnOk: TButton
    Left = 204
    Top = 204
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 308
    Top = 204
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
