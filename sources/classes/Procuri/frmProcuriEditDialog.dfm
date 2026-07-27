object frmProcuriEditDlg: TfrmProcuriEditDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1100
  ClientHeight = 280
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    442
    280)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 442
    Height = 64
    Title = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1100
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
    Width = 426
    Height = 148
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
      Left = 12
      Top = 22
      Width = 111
      Height = 15
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1074#1077#1088#1077#1085#1086#1089#1090#1080
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 51
      Width = 98
      Height = 15
      Caption = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 109
      Width = 94
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076' '#1076#1077#1081#1089#1090#1074#1080#1103
    end
    object cxLabel4: TLabel
      Left = 263
      Top = 109
      Width = 13
      Height = 15
      Caption = #1076#1086
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 81
      Width = 58
      Height = 15
      Caption = #1054#1090' '#1092#1080#1088#1084#1099
    end
    object edPROCURA_NO: TcxDBMaskEdit
      Left = 133
      Top = 19
      DataBinding.DataField = 'PROCURA_NO'
      Properties.CharCase = ecUpperCase
      Properties.MaskKind = emkRegExprEx
      Properties.MaxLength = 0
      TabOrder = 0
      Width = 121
    end
    object edDELEGAT: TcxDBTextEdit
      Left = 133
      Top = 48
      DataBinding.DataField = 'DELEGAT'
      Properties.CharCase = ecUpperCase
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Width = 271
    end
    object deDATA_START: TcxDBDateEdit
      Left = 133
      Top = 106
      DataBinding.DataField = 'DATA_START'
      TabOrder = 3
      Width = 121
    end
    object deDATA_END: TcxDBDateEdit
      Left = 283
      Top = 106
      DataBinding.DataField = 'DATA_END'
      TabOrder = 4
      Width = 121
    end
    object beCUSTOMER: TcxButtonEdit
      Left = 133
      Top = 77
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1092#1080#1088#1084#1091' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCUSTOMERPropertiesButtonClick
      TabOrder = 2
      Width = 271
    end
  end
  object btnOk: TcxButton
    Left = 222
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 330
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
