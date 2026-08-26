object Form12: TForm12
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Form12'
  ClientHeight = 656
  ClientWidth = 1444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 168
  TextHeight = 30
  object edtSKU: TEdit
    Left = 56
    Top = 98
    Width = 212
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 0
    Text = 'BHR6766GL'
  end
  object Button1: TButton
    Left = 278
    Top = 95
    Width = 131
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object memoResults: TMemo
    Left = 56
    Top = 168
    Width = 353
    Height = 156
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 2
  end
end
