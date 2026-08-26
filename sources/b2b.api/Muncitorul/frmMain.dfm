object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 503
  ClientWidth = 1117
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnDestroy = FormDestroy
  TextHeight = 15
  object Button1: TButton
    Left = 24
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MemoJson: TMemo
    Left = 128
    Top = 32
    Width = 981
    Height = 201
    Lines.Strings = (
      'MemoJson')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 248
    Width = 320
    Height = 120
    DataSource = DsProducts
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 374
    Width = 320
    Height = 120
    DataSource = DsImages
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DBGrid3: TDBGrid
    Left = 326
    Top = 248
    Width = 787
    Height = 247
    DataSource = DsFeatures
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DsProducts: TDataSource
    Left = 168
    Top = 272
  end
  object DsImages: TDataSource
    Left = 256
    Top = 272
  end
  object DsFeatures: TDataSource
    Left = 352
    Top = 272
  end
end
