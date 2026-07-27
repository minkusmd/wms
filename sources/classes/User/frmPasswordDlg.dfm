object frmPasswordDialog: TfrmPasswordDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 280
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 340
    Height = 64
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
    ImageIndex = 6
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 324
    Height = 144
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbStrongPassword: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 117
      Width = 296
      Height = 15
      Margins.Left = 16
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Introduceri parola veche'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 157
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 128
    end
    object pnNewPass: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 47
      Width = 320
      Height = 23
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object lbNewPass: TLabel
        Left = 16
        Top = 1
        Width = 63
        Height = 15
        Caption = 'Parola noua'
        Transparent = True
      end
      object edNewPass: TEdit
        Left = 115
        Top = 0
        Width = 190
        Height = 23
        PasswordChar = '*'
        TabOrder = 0
      end
    end
    object pnPassConfirm: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 82
      Width = 320
      Height = 23
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 0
      Margins.Bottom = 12
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 2
      object lbPassConfirm: TLabel
        Left = 16
        Top = 1
        Width = 60
        Height = 15
        Caption = 'Confirmare'
        Transparent = True
      end
      object edPassConfirm: TEdit
        Left = 115
        Top = 0
        Width = 190
        Height = 23
        PasswordChar = '*'
        TabOrder = 0
      end
    end
    object pnPass: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 12
      Width = 320
      Height = 23
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object lbPass: TLabel
        Left = 16
        Top = 1
        Width = 76
        Height = 15
        Caption = 'Parola curenta'
        Transparent = True
      end
      object edPass: TEdit
        Left = 115
        Top = 0
        Width = 190
        Height = 23
        PasswordChar = '*'
        TabOrder = 0
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 224
    Width = 340
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      340
      56)
    object btnOk: TcxButton
      Left = 129
      Top = 11
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 230
      Top = 11
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
