object frmPrepareMailingContentDlg: TfrmPrepareMailingContentDlg
  Left = 0
  Top = 0
  ActiveControl = btnStart
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1088#1072#1089#1089#1099#1083#1082#1080
  ClientHeight = 612
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    670
    612)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 670
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1088#1072#1089#1089#1099#1083#1082#1080
    Text = #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1082#1086#1085#1090#1077#1085#1090#1072' '#1076#1083#1103' '#1088#1072#1089#1089#1099#1083#1082#1080
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
    ImageIndex = 10
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 90
    Width = 650
    Height = 448
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      646
      444)
    object Label1: TLabel
      Left = 25
      Top = 20
      Width = 111
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1091#1090#1100' '#1082' Web-'#1089#1077#1088#1074#1077#1088#1091
    end
    object Label2: TLabel
      Left = 25
      Top = 78
      Width = 143
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1072#1087#1082#1072' '#1082#1086#1085#1090#1077#1085#1090#1072' '#1088#1072#1089#1089#1099#1083#1086#1082
    end
    object edServerPath: TEdit
      Left = 25
      Top = 41
      Width = 591
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 0
      Text = '\\192.168.106.250\WEB Sites\Fantastic'
    end
    object btnStart: TButton
      Left = 25
      Top = 135
      Width = 113
      Height = 36
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1080#1090#1100
      Default = True
      TabOrder = 1
      OnClick = btnStartClick
    end
    object mmLog: TMemo
      Left = 25
      Top = 183
      Width = 591
      Height = 211
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akBottom]
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object edFolderPath: TEdit
      Left = 25
      Top = 101
      Width = 591
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 3
      Text = 'promo'
    end
  end
  object btnOk: TButton
    Left = 399
    Top = 563
    Width = 113
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 534
    Top = 563
    Width = 113
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
