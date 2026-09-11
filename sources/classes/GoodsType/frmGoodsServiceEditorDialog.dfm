object frmGoodsServiceEditorDlg: TfrmGoodsServiceEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Serviciu adiacent'
  ClientHeight = 440
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    520
    440)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 520
    Height = 64
    Title = 'Serviciu adiacent'
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
    Width = 504
    Height = 320
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object lbService: TLabel
      Left = 16
      Top = 12
      Width = 144
      Height = 15
      Caption = 'Serviciul (din nomenclator)'
    end
    object lbStdPrice: TLabel
      Left = 16
      Top = 56
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbPrice: TLabel
      Left = 16
      Top = 84
      Width = 64
      Height = 15
      Caption = 'Pret propriu'
    end
    object lbCurrency: TLabel
      Left = 150
      Top = 84
      Width = 32
      Height = 15
      Caption = 'Valuta'
    end
    object lbPercent: TLabel
      Left = 266
      Top = 84
      Width = 136
      Height = 15
      Caption = '+ % din pretul produsului'
    end
    object lbHint: TLabel
      Left = 16
      Top = 130
      Width = 465
      Height = 32
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lbOrderNo: TLabel
      Left = 16
      Top = 248
      Width = 36
      Height = 15
      Caption = 'Ordine'
    end
    object lbNote: TLabel
      Left = 110
      Top = 248
      Width = 65
      Height = 15
      Caption = 'Nota interna'
    end
    object beService: TcxButtonEdit
      Left = 16
      Top = 29
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = beServicePropertiesButtonClick
      TabOrder = 0
      Width = 465
    end
    object edPrice: TcxTextEdit
      Left = 16
      Top = 101
      TabOrder = 1
      Width = 120
    end
    object cbCurrency: TcxComboBox
      Left = 150
      Top = 101
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 2
      Width = 100
    end
    object edPercent: TcxTextEdit
      Left = 266
      Top = 101
      TabOrder = 3
      Width = 80
    end
    object chkDefault: TcxCheckBox
      Left = 14
      Top = 170
      Caption = 'Bifat implicit (propus clientului)'
      TabOrder = 4
      Transparent = True
    end
    object chkRequired: TcxCheckBox
      Left = 14
      Top = 193
      Caption = 'Obligatoriu (nu poate fi scos din comanda)'
      TabOrder = 5
      Transparent = True
    end
    object chkDisabled: TcxCheckBox
      Left = 14
      Top = 216
      Caption = 'Ascuns pentru acest produs (anuleaza regula tipului)'
      TabOrder = 6
      Transparent = True
    end
    object edOrderNo: TcxSpinEdit
      Left = 16
      Top = 265
      TabOrder = 7
      Width = 80
    end
    object edNote: TcxTextEdit
      Left = 110
      Top = 265
      Properties.MaxLength = 256
      TabOrder = 8
      Width = 371
    end
  end
  object btnOk: TcxButton
    Left = 318
    Top = 400
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 414
    Top = 400
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
