object frm53RPPFileEditorDlg: Tfrm53RPPFileEditorDlg
  Left = 0
  Top = 0
  ActiveControl = beFile
  BorderStyle = bsDialog
  Caption = #1060#1072#1081#1083'-'#1076#1086#1082#1091#1084#1077#1085#1090
  ClientHeight = 233
  ClientWidth = 564
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
    Width = 564
    Height = 64
    Title = #1060#1072#1081#1083'-'#1076#1086#1082#1091#1084#1077#1085#1090
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 548
    Height = 105
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
      Top = 16
      Width = 29
      Height = 15
      Caption = #1060#1072#1081#1083
    end
    object beFile: TcxButtonEdit
      Left = 16
      Top = 33
      Properties.Buttons = <
        item
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          Default = True
          Kind = bkText
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beFilePropertiesButtonClick
      TabOrder = 0
      Width = 505
    end
  end
  object btnOk: TButton
    Left = 352
    Top = 188
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 456
    Top = 188
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
