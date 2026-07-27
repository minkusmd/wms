object frmCustomerCreditEditorDialog: TfrmCustomerCreditEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1088#1077#1076#1080#1090
  ClientHeight = 423
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    409
    423)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 409
    Height = 64
    Title = #1050#1088#1077#1076#1080#1090
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
    ImageIndex = 2
  end
  object pnCard: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 393
    Height = 293
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
    object cxLabel2: TLabel
      Left = 16
      Top = 20
      Width = 170
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072' '#1082#1088#1077#1076#1080#1090#1086#1074#1072#1085#1080#1103
    end
    object cxLabel1: TLabel
      Left = 16
      Top = 98
      Width = 147
      Height = 15
      Caption = #1057#1091#1084#1084#1072' '#1085#1072#1083#1080#1095#1085#1086#1075#1086' '#1082#1088#1077#1076#1080#1090#1072
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 49
      Width = 162
      Height = 15
      Caption = #1050#1086#1085#1077#1094' '#1087#1077#1088#1080#1086#1076#1072' '#1082#1088#1077#1076#1080#1090#1086#1074#1072#1085#1080#1103
    end
    object cxLabel4: TLabel
      Left = 16
      Top = 189
      Width = 68
      Height = 15
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
    end
    object Label1: TLabel
      Left = 16
      Top = 127
      Width = 165
      Height = 15
      Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079#1085#1072#1083#1080#1095#1085#1086#1075#1086' '#1082#1088#1077#1076#1080#1090#1072
    end
    object Label2: TLabel
      Left = 347
      Top = 127
      Width = 21
      Height = 15
      Caption = #1051#1077#1080
    end
    object Label3: TLabel
      Left = 347
      Top = 98
      Width = 22
      Height = 15
      Caption = 'USD'
    end
    object deStartDate: TcxDBDateEdit
      Left = 200
      Top = 17
      DataBinding.DataField = 'DATA'
      Properties.DateButtons = [btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
      Width = 174
    end
    object deEndDate: TcxDBDateEdit
      Left = 200
      Top = 46
      DataBinding.DataField = 'DATE_END'
      Properties.DateButtons = [btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 174
    end
    object mmComents: TcxDBMemo
      Left = 16
      Top = 206
      DataBinding.DataField = 'DESCRIPTION'
      TabOrder = 4
      Height = 67
      Width = 358
    end
    object ceSUMA_CASH: TcxDBCalcEdit
      Left = 200
      Top = 95
      DataBinding.DataField = 'SUMA_CASH'
      Properties.DisplayFormat = '#,##0.00'
      TabOrder = 2
      Width = 145
    end
    object ceSUMA_TRANSFER: TcxDBCalcEdit
      Left = 200
      Top = 124
      DataBinding.DataField = 'SUMA_TRANSFER'
      Properties.DisplayFormat = '#,##0.00'
      TabOrder = 3
      Width = 145
    end
  end
  object btnCancel: TcxButton
    Left = 305
    Top = 379
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 201
    Top = 379
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
