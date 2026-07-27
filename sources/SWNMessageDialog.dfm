object SWNMessageDialog: TSWNMessageDialog
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  ClientHeight = 218
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 373
    Height = 165
    Align = alTop
    AutoSize = True
    BevelEdges = [beBottom]
    BevelOuter = bvNone
    Color = clWindow
    UseDockManager = False
    Padding.Bottom = 16
    ParentBackground = False
    TabOrder = 0
    object imgMainIcon: TImage
      Left = 16
      Top = 11
      Width = 32
      Height = 32
    end
    object lbTitle: TLabel
      AlignWithMargins = True
      Left = 64
      Top = 0
      Width = 301
      Height = 50
      Margins.Left = 64
      Margins.Top = 0
      Margins.Right = 8
      Align = alTop
      AutoSize = False
      Caption = 'Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10040064
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
      Layout = tlCenter
      WordWrap = True
      ExplicitTop = 3
    end
    object lbInfo: TLabel
      AlignWithMargins = True
      Left = 64
      Top = 54
      Width = 301
      Height = 15
      Margins.Left = 64
      Margins.Top = 4
      Margins.Right = 8
      Align = alTop
      AutoSize = False
      Caption = 'Text'
      ShowAccelChar = False
      WordWrap = True
      OnDblClick = lbInfoDblClick
      ExplicitLeft = 48
    end
    object lbFooterText: TLabel
      AlignWithMargins = True
      Left = 64
      Top = 134
      Width = 301
      Height = 15
      Margins.Left = 64
      Margins.Top = 24
      Margins.Right = 8
      Align = alTop
      AutoSize = False
      Caption = 'Footer text'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
      WordWrap = True
      ExplicitLeft = 56
      ExplicitTop = 172
    end
    object imgFooterIcon: TImage
      Left = 40
      Top = 133
      Width = 16
      Height = 16
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
        0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000206348524D00007A26000080840000FA000000
        80E8000075300000EA6000003A98000017709CBA513C0000027249444154384F
        9D925D4893511CC6CFBBE560DE18D54CE764E95402C1AB3244BC9244BA2A9984
        98413719EE9D64D9FA6225198AB3744E4D4DA7845A4A2AB8528B340C0BD22424
        44412B9308578339A99C5FEDE97F960B3FD64D077EFFF39EE73CCFFFBC5F0CC0
        3F319E6072632613FCEDF9F02B725EB72715FCB497CC3A260CA3ED858A43FE3C
        1CBFA2CD147C1CF337807923E02A8263E4E454952804F9F36E132C392CF0CBE0
        E171CCE9E17E9781D5892CE0532EFACDAA0B5BBD9C6DC2B33285011F32E199C9
        C3E2B729ACCCB602931970F6A738EE9E95A8B7FA372D1ACE4935AE81442726D3
        80E93C9268389F032329441ADE5854F7B86F239B162355210D789B0A8C5260FC
        0C4934ECBDC08B24602815EEAE836B2DF90109DCEBE3EF458B4196E07E1CB78C
        9789C0401C30AC2599C6E74EE05134D07380E6784CDE0E1D30E73029CF70BC85
        04D9FB9AB0213C8925E37EC016010C1EE17160A60D680B05DA35C08328FCB246
        C266909FE2398EB7745F09CCC2C318A08BE8E444C3D31183C59E6358EDA05FA0
        751FD04C4D9B686E50C35EA4F8E8FBACAC5A14767FAD544EF1EEB84FA7709A55
        58EB4E867BC18EE5B15AA03ED81B445D3850AD02CA9418CC9717781BF45D948B
        DE4DEB3A8D44BD926E371E981B065E5D072AF70055614005E965F438A521705D
        DBE528CF164258EF79F9655452D73BEBD410B5FC24325A2858A12028CC83A6BD
        4031AD6F2AB07069E7F7F2D34224ABD609B1D3C6A0B1E552A567C9A4C262A99A
        8820344414DCC492892889C24A7104560BC3F1E3AAC2FD3437E056493693B10A
        1D13CC3AA6B1EA25471B4569BA559468AD3A41DBE843DC8844DBA4DF915E274A
        92CB75ECCF4BE4E5FF01FB0D02C7AC67ED5281650000000049454E44AE426082}
    end
    object cbVerification: TCheckBox
      AlignWithMargins = True
      Left = 64
      Top = 93
      Width = 301
      Height = 17
      Margins.Left = 64
      Margins.Top = 24
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Verification'
      TabOrder = 0
      WordWrap = True
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 165
    Width = 373
    Height = 53
    Align = alTop
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Padding.Right = 4
    TabOrder = 1
    object btnOk: TcxButton
      AlignWithMargins = True
      Left = 120
      Top = 12
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 8
      Margins.Bottom = 14
      Align = alRight
      Cancel = True
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnYes: TcxButton
      AlignWithMargins = True
      Left = 203
      Top = 12
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 8
      Margins.Bottom = 14
      Align = alRight
      Caption = 'DA'
      Default = True
      ModalResult = 6
      TabOrder = 1
    end
    object btnNo: TcxButton
      AlignWithMargins = True
      Left = 286
      Top = 12
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 8
      Margins.Bottom = 14
      Align = alRight
      Cancel = True
      Caption = 'NU'
      ModalResult = 7
      TabOrder = 2
    end
  end
end
