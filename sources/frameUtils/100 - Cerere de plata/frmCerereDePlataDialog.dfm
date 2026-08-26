object frmCerereDePlataDlg: TfrmCerereDePlataDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cerere de plata'
  ClientHeight = 464
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 67
    Width = 329
    Height = 362
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TcxLabel
      Left = 8
      Top = 24
      Caption = 'Data planificata a platii'
    end
    object dePaymentDate: TcxDateEdit
      Left = 8
      Top = 49
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      TabOrder = 1
      Width = 121
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 134
      Caption = 'Suma'
    end
    object ceSuma: TcxCalcEdit
      Left = 8
      Top = 159
      EditValue = 0.000000000000000000
      TabOrder = 5
      Width = 89
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 78
      Caption = 'Destinatar'
    end
    object beCustomer: TcxButtonEdit
      Left = 8
      Top = 103
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beCustomerPropertiesButtonClick
      TabOrder = 3
      Width = 314
    end
    object meComment: TcxMemo
      Left = 8
      Top = 208
      TabOrder = 7
      Height = 140
      Width = 311
    end
    object cxLabel4: TcxLabel
      Left = 8
      Top = 188
      Caption = 'Mentiuni'
    end
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 335
    Height = 64
    Title = 'Cerere de plata'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 92
  end
  object Panel2: TPanel
    Left = 0
    Top = 423
    Width = 335
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 291
    object cxButton1: TcxButton
      Left = 138
      Top = 12
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 234
      Top = 12
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
