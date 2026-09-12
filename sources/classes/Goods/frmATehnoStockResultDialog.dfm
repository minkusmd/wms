object frmATehnoStockResultDlg: TfrmATehnoStockResultDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Stoc atehno.md'
  ClientHeight = 372
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Pitch = fpFixed
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object lbCodeCaption: TLabel
    Left = 16
    Top = 16
    Width = 24
    Height = 15
    Caption = 'Cod:'
  end
  object lbCode: TLabel
    Left = 110
    Top = 16
    Width = 43
    Height = 15
    Caption = 'lbCode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTitleCaption: TLabel
    Left = 16
    Top = 44
    Width = 56
    Height = 15
    Caption = 'Denumire:'
  end
  object lbTitle: TLabel
    Left = 16
    Top = 62
    Width = 408
    Height = 40
    AutoSize = False
    Caption = 'lbTitle'
    WordWrap = True
  end
  object lbStatusCaption: TLabel
    Left = 16
    Top = 110
    Width = 33
    Height = 15
    Caption = 'Stare:'
  end
  object lbStatus: TLabel
    Left = 110
    Top = 110
    Width = 40
    Height = 15
    Caption = 'lbStatus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLocationsCaption: TLabel
    Left = 16
    Top = 138
    Width = 168
    Height = 15
    Caption = 'Disponibil pentru ridicare din:'
  end
  object lbLink: TLabel
    Left = 16
    Top = 310
    Width = 259
    Height = 15
    Cursor = crHandPoint
    Caption = 'Deschide pagina produsului in browser'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Pitch = fpFixed
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lbLinkClick
  end
  object lbLocations: TListBox
    Left = 16
    Top = 158
    Width = 408
    Height = 140
    ItemHeight = 15
    TabOrder = 0
  end
  object pnButtons: TPanel
    Left = 0
    Top = 336
    Width = 440
    Height = 36
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TcxButton
      Left = 344
      Top = 4
      Width = 80
      Height = 27
      Cancel = True
      Caption = 'Inchide'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
end
