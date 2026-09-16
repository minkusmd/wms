object frmSupplierPickupConfirmDlg: TfrmSupplierPickupConfirmDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ridicare marfa de la furnizor'
  ClientHeight = 420
  ClientWidth = 560
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
    Width = 560
    Height = 64
    Title = 'Ridicare marfa de la furnizor'
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
    Width = 560
    Height = 356
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbGoodsCaption: TLabel
      Left = 16
      Top = 12
      Width = 40
      Height = 15
      Caption = 'Produs'
    end
    object lbGoods: TLabel
      Left = 150
      Top = 12
      Width = 394
      Height = 15
      AutoSize = False
      Caption = '-'
      EllipsisPosition = epEndEllipsis
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbStockSupplierCaption: TLabel
      Left = 16
      Top = 40
      Width = 105
      Height = 15
      Caption = 'Furnizorul cu stoc'
    end
    object beStockSupplier: TcxButtonEdit
      Left = 150
      Top = 36
      Hint = 'Alege alt furnizor la care este stocul'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = beStockSupplierPropertiesButtonClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Width = 394
    end
    object lbOrderSupplier: TLabel
      Left = 16
      Top = 68
      Width = 81
      Height = 15
      Caption = 'Comandam prin'
    end
    object beOrderSupplier: TcxButtonEdit
      Left = 150
      Top = 64
      Hint = 'Furnizorul intermediar prin care se plaseaza comanda'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end
        item
          Caption = 'Direct'
          Hint = 'Comanda directa la furnizorul cu stoc'
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = beOrderSupplierPropertiesButtonClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Width = 394
    end
    object lbRuleInfo: TLabel
      Left = 150
      Top = 92
      Width = 394
      Height = 15
      AutoSize = False
      Caption = ''
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object rgPickupFrom: TcxRadioGroup
      Left = 150
      Top = 114
      Caption = 'Soferul ridica marfa de la'
      Properties.Items = <
        item
          Caption = 'Furnizorul cu stoc'
        end
        item
          Caption = 'Furnizorul intermediar (prin care comandam)'
        end>
      ItemIndex = 0
      TabOrder = 2
      Height = 70
      Width = 394
    end
    object lbQty: TLabel
      Left = 16
      Top = 202
      Width = 53
      Height = 15
      Caption = 'Cantitate'
    end
    object seQty: TcxSpinEdit
      Left = 150
      Top = 198
      Properties.MaxValue = 1.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 3
      Value = 1
      Width = 90
    end
    object lbQtyInfo: TLabel
      Left = 250
      Top = 202
      Width = 294
      Height = 15
      AutoSize = False
      Caption = ''
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbPlanDate: TLabel
      Left = 16
      Top = 236
      Width = 93
      Height = 15
      Caption = 'Data ridicarii'
    end
    object dePlanDate: TcxDateEdit
      Left = 150
      Top = 232
      TabOrder = 4
      Width = 130
    end
    object lbNote: TLabel
      Left = 16
      Top = 270
      Width = 25
      Height = 15
      Caption = 'Nota'
    end
    object edNote: TcxTextEdit
      Left = 150
      Top = 266
      Properties.MaxLength = 512
      TabOrder = 5
      Width = 394
    end
    object lbState: TLabel
      Left = 150
      Top = 300
      Width = 394
      Height = 15
      AutoSize = False
      Caption = ''
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object btnOk: TcxButton
    Left = 356
    Top = 380
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 454
    Top = 380
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
