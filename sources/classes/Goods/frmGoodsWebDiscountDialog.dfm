object frmGoodsWebDiscountDlg: TfrmGoodsWebDiscountDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestiune discount produse'
  ClientHeight = 339
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    277
    339)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 277
    Height = 64
    Title = 'Reduceri la produse'
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
    ImageIndex = 10
    ExplicitLeft = -8
    ExplicitTop = -3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 261
    Height = 215
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
      Left = 10
      Top = 24
      Width = 65
      Height = 15
      Caption = 'Reducere, %'
    end
    object Label3: TLabel
      Left = 20
      Top = 69
      Width = 46
      Height = 15
      Caption = 'Perioada'
    end
    object Label2: TLabel
      Left = 35
      Top = 90
      Width = 40
      Height = 15
      Caption = 'inceput'
    end
    object Label4: TLabel
      Left = 35
      Top = 119
      Width = 28
      Height = 15
      Caption = 'sfirsit'
    end
    object sbPopupMenu: TSpeedButton
      Left = 158
      Top = 61
      Width = 76
      Height = 21
      Caption = 'Perioade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Layout = blGlyphRight
      ParentFont = False
      OnClick = sbPopupMenuClick
    end
    object lbMulti: TLabel
      Left = 20
      Top = 160
      Width = 153
      Height = 30
      Caption = 'Valorile vor fi aplicate pentru produsele selectate!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object cmbVALUE_INT: TcxComboBox
      Left = 81
      Top = 21
      Properties.ImmediatePost = True
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 0
      Width = 153
    end
    object deSTART_DATE: TcxDateEdit
      Left = 81
      Top = 87
      EditValue = 0d
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 153
    end
    object deEND_DATE: TcxDateEdit
      Left = 81
      Top = 116
      EditValue = 0d
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 2
      Width = 153
    end
  end
  object btnOk: TButton
    Left = 59
    Top = 298
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 164
    Top = 298
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object pmPeriods: TPopupMenu
    Left = 160
    Top = 20
    object N71: TMenuItem
      Tag = 7
      Caption = '7 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N141: TMenuItem
      Tag = 14
      Caption = '14 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N301: TMenuItem
      Tag = 30
      Caption = '30 '#1076#1085#1077#1081
      OnClick = N301Click
    end
  end
end
