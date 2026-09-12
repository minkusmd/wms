object frmPTNInvoiceDlg: TfrmPTNInvoiceDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Facturi'
  ClientHeight = 315
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    490
    315)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 490
    Height = 64
    Title = 'Factura de intrare'
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
    ImageIndex = 20
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 474
    Height = 189
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
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 126
      Height = 15
      Caption = 'Seria si Numarul facturii'
    end
    object Label2: TLabel
      Left = 20
      Top = 68
      Width = 24
      Height = 15
      Caption = 'Data'
    end
    object Label3: TLabel
      Left = 20
      Top = 116
      Width = 46
      Height = 15
      Caption = 'Redirijari'
    end
    object edFACTURANO: TcxDBTextEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'FACTURANO'
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 185
    end
    object deDATA_ELIBERARII: TcxDBDateEdit
      Left = 20
      Top = 87
      DataBinding.DataField = 'DATA_ELIBERARII'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 185
    end
    object cbRedirijari: TcxDBComboBox
      Left = 20
      Top = 137
      DataBinding.DataField = 'REDIRIJARI'
      Properties.Items.Strings = (
        ''
        '<Non Livrare>')
      TabOrder = 2
      Width = 185
    end
  end
  object btnOk: TButton
    Left = 271
    Top = 272
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 379
    Top = 272
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
