object frmSupplierGroupsEditorDlg: TfrmSupplierGroupsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmSupplierGroupsEditorDlg'
  ClientHeight = 288
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 396
    Height = 64
    Title = 'Grupe de furnizori'
    Text = 'Gestionarea grupelor de furnizori'
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
  object pnButtons: TPanel
    Left = 0
    Top = 235
    Width = 396
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnSelect: TButton
      AlignWithMargins = True
      Left = 184
      Top = 12
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnClose: TButton
      Left = 282
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 67
    Width = 390
    Height = 165
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      Left = 12
      Top = 13
      Width = 22
      Height = 15
      Caption = 'Cod'
    end
    object Label3: TLabel
      Left = 12
      Top = 60
      Width = 58
      Height = 15
      Caption = 'Denumirea'
    end
    object edCod: TcxDBTextEdit
      Left = 12
      Top = 31
      DataBinding.DataField = 'SGID'
      ParentFont = False
      TabOrder = 0
      Width = 58
    end
    object edTitle: TcxDBTextEdit
      Left = 12
      Top = 78
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      TabOrder = 1
      Width = 364
    end
    object cbCostInPrice: TcxDBCheckBox
      Left = 12
      Top = 115
      Caption = 'Pricelist cu cost'
      DataBinding.DataField = 'FLG_COST_IN_PRICE'
      ParentFont = False
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 2
    end
    object cbDefSupplier: TcxDBCheckBox
      Left = 174
      Top = 116
      Caption = 'Furnizor implicit'
      DataBinding.DataField = 'FLG_DEFAULT_SUPPLIER'
      ParentFont = False
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 3
    end
  end
end
