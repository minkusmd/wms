object frmWebPromoBrickLinkEditorDlg: TfrmWebPromoBrickLinkEditorDlg
  Left = 0
  Top = 0
  ActiveControl = beURL
  BorderStyle = bsDialog
  Caption = #1057#1089#1099#1083#1082#1072' '#1074' '#1088#1077#1082#1083#1072#1084#1085#1086#1084' '#1073#1083#1086#1082#1077
  ClientHeight = 246
  ClientWidth = 642
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
    Width = 642
    Height = 64
    Title = #1057#1089#1099#1083#1082#1072' '#1074' '#1088#1077#1082#1083#1072#1084#1085#1086#1084' '#1073#1083#1086#1082#1077
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 626
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
      Left = 20
      Top = 20
      Width = 42
      Height = 15
      Caption = #1057#1089#1099#1083#1082#1072
    end
    object lbGoodsInfo: TLabel
      Left = 20
      Top = 74
      Width = 65
      Height = 15
      Caption = 'lbGoodsInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object beURL: TcxButtonEdit
      Left = 20
      Top = 37
      Properties.Buttons = <
        item
          Caption = #1048#1079' '#1082#1086#1076#1072' '#1090#1086#1074#1072#1088#1072
          Default = True
          Kind = bkText
        end>
      Properties.OnButtonClick = beURLPropertiesButtonClick
      TabOrder = 0
      Width = 585
    end
  end
  object btnOk: TButton
    Left = 428
    Top = 204
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 532
    Top = 204
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
