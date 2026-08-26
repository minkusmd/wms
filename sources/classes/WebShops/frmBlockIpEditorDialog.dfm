object frmBlockIpEditorDlg: TfrmBlockIpEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Blocare IP'
  ClientHeight = 340
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 440
    Height = 64
    Title = 'Blocare IP'
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
    Left = 0
    Top = 64
    Width = 440
    Height = 235
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbIp: TLabel
      Left = 16
      Top = 14
      Width = 47
      Height = 15
      Caption = 'Adresa IP'
    end
    object lbReason: TLabel
      Left = 16
      Top = 46
      Width = 30
      Height = 15
      Caption = 'Motiv'
    end
    object lbNote: TLabel
      Left = 16
      Top = 78
      Width = 25
      Height = 15
      Caption = 'Nota'
    end
    object lbMinutes: TLabel
      Left = 236
      Top = 145
      Width = 84
      Height = 15
      Caption = 'Durata (minute)'
    end
    object lbUntil: TLabel
      Left = 236
      Top = 190
      Width = 76
      Height = 15
      Caption = 'Expira la data'
    end
    object edIp: TcxTextEdit
      Left = 120
      Top = 11
      Properties.CharCase = ecLowerCase
      TabOrder = 0
      Width = 300
    end
    object edReason: TcxTextEdit
      Left = 120
      Top = 43
      Properties.MaxLength = 256
      TabOrder = 1
      Width = 300
    end
    object edNote: TcxTextEdit
      Left = 120
      Top = 75
      Properties.MaxLength = 512
      TabOrder = 2
      Width = 300
    end
    object chkWhitelist: TcxCheckBox
      Left = 118
      Top = 103
      Caption = 'Lista alba (acest IP nu se blocheaza niciodata)'
      Properties.OnChange = chkWhitelistPropertiesChange
      TabOrder = 3
      Width = 302
    end
    object rgDuration: TcxRadioGroup
      Left = 16
      Top = 128
      Caption = 'Durata blocarii'
      Properties.Items = <
        item
          Caption = 'Permanent'
        end
        item
          Caption = 'Limitat (minute)'
        end
        item
          Caption = 'Pana la data'
        end>
      Properties.OnChange = rgDurationPropertiesChange
      ItemIndex = 0
      TabOrder = 4
      Height = 100
      Width = 210
    end
    object seMinutes: TcxSpinEdit
      Left = 236
      Top = 162
      Properties.MaxValue = 525600.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 5
      Value = 15
      Width = 100
    end
    object deUntil: TcxDateEdit
      Left = 236
      Top = 207
      TabOrder = 6
      Width = 130
    end
  end
  object btnOk: TcxButton
    Left = 246
    Top = 301
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 342
    Top = 301
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
