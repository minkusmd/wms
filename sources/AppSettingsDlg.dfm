object frmAppSettingsDialog: TfrmAppSettingsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 431
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 522
    Height = 64
    Title = #1053#1072#1089#1090#1088#1086#1081#1082#1080
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
  end
  object btnOk: TcxButton
    Left = 320
    Top = 384
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 424
    Top = 384
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 506
    Height = 301
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsSipClient
    Align = alTop
    TabOrder = 1
    object tbsGeneral: TTabSheet
      Caption = 'General'
      object cbStartWithWindows: TCheckBox
        Left = 12
        Top = 24
        Width = 197
        Height = 17
        Caption = 'Lansare concomitent cu Windows'
        TabOrder = 0
      end
      object cbSaveLastLogin: TCheckBox
        Left = 12
        Top = 56
        Width = 229
        Height = 17
        Caption = 'Memoreaza ultimul utilizator'
        TabOrder = 1
      end
    end
    object tbsView: TTabSheet
      Caption = 'Vedere'
      ImageIndex = 1
      object Label4: TLabel
        Left = 12
        Top = 20
        Width = 97
        Height = 15
        Caption = 'Marimea font-ului'
      end
      object sbResetFormPos: TSpeedButton
        Left = 211
        Top = 46
        Width = 93
        Height = 23
        Caption = 'Reseteaza'
        OnClick = sbResetFormPosClick
      end
      object sbResetGridColumns: TSpeedButton
        Left = 211
        Top = 75
        Width = 93
        Height = 23
        Caption = 'Reseteaza'
        OnClick = sbResetGridColumnsClick
      end
      object Label2: TLabel
        Left = 411
        Top = 17
        Width = 5
        Height = 15
        Caption = '*'
      end
      object Label5: TLabel
        Left = 307
        Top = 50
        Width = 5
        Height = 15
        Caption = '*'
      end
      object Label6: TLabel
        Left = 307
        Top = 79
        Width = 5
        Height = 15
        Caption = '*'
      end
      object Label1: TLabel
        Left = 214
        Top = 197
        Width = 184
        Height = 15
        Caption = '* - Este nevoie de restartat aplicatia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 12
        Top = 137
        Width = 137
        Height = 15
        Caption = 'Confirmarea operatiunilor'
      end
      object sbResetConfirmations: TSpeedButton
        Left = 211
        Top = 133
        Width = 93
        Height = 23
        Caption = 'Reseteaza'
        OnClick = sbResetConfirmationsClick
      end
      object cbSaveFormPos: TCheckBox
        Left = 12
        Top = 50
        Width = 181
        Height = 17
        Caption = 'Salveaza pozitia ferestrelor'
        TabOrder = 1
      end
      object cbSaveGridColumns: TCheckBox
        Left = 12
        Top = 79
        Width = 181
        Height = 17
        Caption = 'Salveaza structura Grid-urilor'
        TabOrder = 2
      end
      object cmbFontSize: TComboBox
        Left = 211
        Top = 17
        Width = 198
        Height = 23
        Style = csDropDownList
        TabOrder = 0
      end
      object cbSaveMultiMonitorPos: TCheckBox
        Left = 12
        Top = 168
        Width = 185
        Height = 17
        Caption = 'Memoreaza monitorul de lucru'
        TabOrder = 3
      end
      object cxButton1: TcxButton
        Left = 208
        Top = 224
        Width = 193
        Height = 25
        Caption = 'Initializeaza toate setarile'
        TabOrder = 4
        OnClick = cxButton1Click
      end
    end
    object tbsUserInfo: TTabSheet
      Caption = 'Date despre utilizator'
      ImageIndex = 2
      object Label7: TLabel
        Left = 12
        Top = 20
        Width = 47
        Height = 15
        Caption = 'Utilizator'
      end
      object Label8: TLabel
        Left = 320
        Top = 20
        Width = 33
        Height = 15
        Caption = 'Parola'
      end
      object sbChangeUserPass: TSpeedButton
        Left = 368
        Top = 17
        Width = 113
        Height = 23
        Caption = 'Schimba parola'
        OnClick = sbChangeUserPassClick
      end
      object Label11: TLabel
        Left = 12
        Top = 49
        Width = 39
        Height = 15
        Caption = 'Telefon'
      end
      object Label12: TLabel
        Left = 12
        Top = 78
        Width = 34
        Height = 15
        Caption = 'E-Mail'
      end
      object Label13: TLabel
        Left = 12
        Top = 107
        Width = 65
        Height = 15
        Caption = 'Data nasterii'
      end
      object Label3: TLabel
        Left = 12
        Top = 136
        Width = 36
        Height = 15
        Caption = 'Adresa'
      end
      object edUserName: TEdit
        Left = 112
        Top = 17
        Width = 157
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 0
        Text = 'edUserName'
      end
      object edUserPhone: TEdit
        Left = 112
        Top = 46
        Width = 157
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 1
        Text = 'edUserName'
      end
      object edUserEmail: TEdit
        Left = 112
        Top = 75
        Width = 157
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 2
        Text = 'edUserName'
      end
      object edUserBirthDate: TEdit
        Left = 112
        Top = 104
        Width = 157
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 3
        Text = 'edUserName'
      end
      object edUserAddress: TEdit
        Left = 112
        Top = 133
        Width = 369
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 4
        Text = 'edUserName'
      end
    end
    object tbsSounds: TTabSheet
      Caption = 'Alerte'
      ImageIndex = 3
      object Label9: TLabel
        Left = 12
        Top = 20
        Width = 38
        Height = 15
        Caption = 'Vinzare'
      end
      object sbPlay_Rashod: TSpeedButton
        Left = 424
        Top = 17
        Width = 23
        Height = 23
        Glyph.Data = {
          1A020000424D1A020000000000001A0100002800000010000000100000000100
          08000000000000010000120B0000120B0000390000003900000000000000FFFF
          FF00FF00FF006B3C3C006F3F3F00CF8C8C00ECA6A6009A777700B38E8E009074
          7400947A7A00DAB5B500766262005043430085707000564B4B006A6767009C99
          9900F5F5F500CCCCCC00C9C9C900C7C7C700C3C3C300BFBFBF00B6B6B600B1B1
          B100AEAEAE00ADADAD00ABABAB00A5A5A5009F9F9F009B9B9B00969696009595
          95008A8A8A0086868600838383007E7E7E007878780072727200717171006C6C
          6C0069696900606060005C5C5C005454540052525200515151004E4E4E004D4D
          4D004A4A4A0046464600454545003F3F3F003A3A3A0039393900353535000202
          0202020202020606050202020202020202020202020202020605060202020202
          0202020202060605020605060202020202020202020202060502060502020202
          02022D2D2D2B02020605020605020202022D1E1C1A162D020206050206020202
          2D261C15141A172D02020602060202022D100D0D11131B232B0206020602020C
          2F0D0E072C1815182D0202020202040A34282226092D151B2D0202020202030B
          3624151F272D191D2D0202020202041232300115272A20212D02020202020308
          143731292D2925232B02020202020204040F37332E2C2B2D0202020202020202
          02022B3835312C0202020202020202020202020202020202020202020202}
        OnClick = sbPlay_RashodClick
      end
      object Label14: TLabel
        Left = 12
        Top = 49
        Width = 56
        Height = 15
        Caption = 'Asamblare'
      end
      object sbPlay_Sborka: TSpeedButton
        Left = 424
        Top = 46
        Width = 23
        Height = 23
        Glyph.Data = {
          1A020000424D1A020000000000001A0100002800000010000000100000000100
          08000000000000010000120B0000120B0000390000003900000000000000FFFF
          FF00FF00FF006B3C3C006F3F3F00CF8C8C00ECA6A6009A777700B38E8E009074
          7400947A7A00DAB5B500766262005043430085707000564B4B006A6767009C99
          9900F5F5F500CCCCCC00C9C9C900C7C7C700C3C3C300BFBFBF00B6B6B600B1B1
          B100AEAEAE00ADADAD00ABABAB00A5A5A5009F9F9F009B9B9B00969696009595
          95008A8A8A0086868600838383007E7E7E007878780072727200717171006C6C
          6C0069696900606060005C5C5C005454540052525200515151004E4E4E004D4D
          4D004A4A4A0046464600454545003F3F3F003A3A3A0039393900353535000202
          0202020202020606050202020202020202020202020202020605060202020202
          0202020202060605020605060202020202020202020202060502060502020202
          02022D2D2D2B02020605020605020202022D1E1C1A162D020206050206020202
          2D261C15141A172D02020602060202022D100D0D11131B232B0206020602020C
          2F0D0E072C1815182D0202020202040A34282226092D151B2D0202020202030B
          3624151F272D191D2D0202020202041232300115272A20212D02020202020308
          143731292D2925232B02020202020204040F37332E2C2B2D0202020202020202
          02022B3835312C0202020202020202020202020202020202020202020202}
        OnClick = sbPlay_SborkaClick
      end
      object Label15: TLabel
        Left = 12
        Top = 78
        Width = 55
        Height = 15
        Caption = 'Web order'
      end
      object sbPlay_WebZakaz: TSpeedButton
        Left = 424
        Top = 75
        Width = 23
        Height = 23
        Glyph.Data = {
          1A020000424D1A020000000000001A0100002800000010000000100000000100
          08000000000000010000120B0000120B0000390000003900000000000000FFFF
          FF00FF00FF006B3C3C006F3F3F00CF8C8C00ECA6A6009A777700B38E8E009074
          7400947A7A00DAB5B500766262005043430085707000564B4B006A6767009C99
          9900F5F5F500CCCCCC00C9C9C900C7C7C700C3C3C300BFBFBF00B6B6B600B1B1
          B100AEAEAE00ADADAD00ABABAB00A5A5A5009F9F9F009B9B9B00969696009595
          95008A8A8A0086868600838383007E7E7E007878780072727200717171006C6C
          6C0069696900606060005C5C5C005454540052525200515151004E4E4E004D4D
          4D004A4A4A0046464600454545003F3F3F003A3A3A0039393900353535000202
          0202020202020606050202020202020202020202020202020605060202020202
          0202020202060605020605060202020202020202020202060502060502020202
          02022D2D2D2B02020605020605020202022D1E1C1A162D020206050206020202
          2D261C15141A172D02020602060202022D100D0D11131B232B0206020602020C
          2F0D0E072C1815182D0202020202040A34282226092D151B2D0202020202030B
          3624151F272D191D2D0202020202041232300115272A20212D02020202020308
          143731292D2925232B02020202020204040F37332E2C2B2D0202020202020202
          02022B3835312C0202020202020202020202020202020202020202020202}
        OnClick = sbPlay_WebZakazClick
      end
      object cmbSounds_Rashod: TComboBox
        Left = 211
        Top = 17
        Width = 198
        Height = 23
        Style = csDropDownList
        TabOrder = 0
      end
      object cmbSounds_NareadSborka: TComboBox
        Left = 211
        Top = 46
        Width = 198
        Height = 23
        Style = csDropDownList
        TabOrder = 1
      end
      object cmbSounds_WebZakaz: TComboBox
        Left = 211
        Top = 75
        Width = 198
        Height = 23
        Style = csDropDownList
        TabOrder = 2
      end
    end
    object tbsSipClient: TTabSheet
      Caption = 'Setari telefonie'
      ImageIndex = 4
      OnExit = tbsSipClientExit
      OnShow = tbsSipClientShow
      object Label16: TLabel
        Left = 16
        Top = 24
        Width = 87
        Height = 13
        Caption = 'Setari de sunet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Image1: TImage
        Left = 16
        Top = 48
        Width = 17
        Height = 17
        Picture.Data = {
          07544269746D617036050000424D360500000000000036040000280000001000
          0000100000000100080000000000000100000000000000000000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFF085B5B5B5B08FFFFFFFFFFFFFFFFFFFFFF5BFFFF5BFFFFFFFF
          FFFFFFFFFFFFFF085BFFFF5B08FFFFFFFFFFFFFFFFFF085BF65B5BF65B08FFFF
          FFFFFFFFFF085BF65BF6F65BF65B08FFFFFFFFFFFF5BF65BF6FFFFF65BF65BFF
          FFFFFFFFFF5BF65B5BF7F75B5BF65BFFFFFFFFFFFF5BF65BF6FFFFF65BF65BFF
          FFFFFFFFFF5BF75B5BF7F75B5BF75BFFFFFFFFFFFFFFFF5BF6FFFFF65BFFFFFF
          FFFFFFFFFFFFFF5B5BF7F75B5BFFFFFFFFFFFFFFFFFFFF5BF6FFFFF65BFFFFFF
          FFFFFFFFFFFFFF5BF7F7F7F75BFFFFFFFFFFFFFFFFFFFF5BF6FFFFF65BFFFFFF
          FFFFFFFFFFFFFF5BF6F6F6F65BFFFFFFFFFFFFFFFFFFFF085B5B5B5B08FFFFFF
          FFFF}
        Transparent = True
      end
      object Image2: TImage
        Left = 16
        Top = 80
        Width = 17
        Height = 17
        Picture.Data = {
          07544269746D617036050000424D360500000000000036040000280000001000
          0000100000000100080000000000000100000000000000000000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF5B5BFFFFFFFFFFFFFFFFFFFFFFFFF65B075BFFFF
          FFFFFFFFFFFFFFFFFFF65B07FF5BFFFFFFFFFFFFFFFFFFF6FF5B07FFFF5BFFFF
          FFFFFFFFFFFFFFFF5B07FFFFFF5BFFFFFFFFFFFF5B5B5B5B07FFFFFFFF5BFFFF
          FFFFFFFF5B07FF5B07FFFFFFFF5BFFFFFFFFFFFF5B07FF5B07FFFFFFFF5BFFFF
          FFFFFFFF5B07FF5B07FFFFFFFF5BFFFFFFFFFFFF5B07FF5B07FFFFFFFF5BFFFF
          FFFFFFFF5B5B5B5B07FFFFFFFF5BFFFFFFFFFFFFFFFFFFF65B07FFFFFF5BFFFF
          FFFFFFFFFFFFFFFFFF5B07FFFF5BFFFFFFFFFFFFFFFFFFFFFFFF5B07FF5BFFFF
          FFFFFFFFFFFFFFFFFFFFFF5B075BFFFFFFFFFFFFFFFFFFFFFFFFFFFF5B5BFFFF
          FFFF}
        Transparent = True
      end
      object Label17: TLabel
        Left = 16
        Top = 120
        Width = 79
        Height = 13
        Caption = 'Setari sonerie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Image3: TImage
        Left = 16
        Top = 144
        Width = 17
        Height = 17
        Picture.Data = {
          07544269746D617036050000424D360500000000000036040000280000001000
          0000100000000100080000000000000100000000000000000000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF5B5BFFFFFFFFFFFFFFFFFFFFFFFFF65B075BFFFF
          FFFFFFFFFFFFFFFFFFF65B07FF5BFFFFFFFFFFFFFFFFFFF6FF5B07FFFF5BFFFF
          FFFFFFFFFFFFFFFF5B07FFFFFF5BFFFFFFFFFFFF5B5B5B5B07FFFFFFFF5BFFFF
          FFFFFFFF5B07FF5B07FFFFFFFF5BFFFFFFFFFFFF5B07FF5B07FFFFFFFF5BFFFF
          FFFFFFFF5B07FF5B07FFFFFFFF5BFFFFFFFFFFFF5B07FF5B07FFFFFFFF5BFFFF
          FFFFFFFF5B5B5B5B07FFFFFFFF5BFFFFFFFFFFFFFFFFFFF65B07FFFFFF5BFFFF
          FFFFFFFFFFFFFFFFFF5B07FFFF5BFFFFFFFFFFFFFFFFFFFFFFFF5B07FF5BFFFF
          FFFFFFFFFFFFFFFFFFFFFF5B075BFFFFFFFFFFFFFFFFFFFFFFFFFFFF5B5BFFFF
          FFFF}
        Transparent = True
      end
      object Label18: TLabel
        Left = 257
        Top = 16
        Width = 144
        Height = 13
        Cursor = crHandPoint
        Caption = 'Seteaza valorile din sistema...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label18Click
      end
      object waveInDevice: TComboBox
        Left = 48
        Top = 43
        Width = 353
        Height = 23
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        Text = 'waveInDevice'
      end
      object waveOutDevice: TComboBox
        Left = 48
        Top = 76
        Width = 353
        Height = 23
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        Text = 'waveOutDevice'
      end
      object waveRingDevice: TComboBox
        Left = 48
        Top = 144
        Width = 353
        Height = 23
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        Text = 'waveRingDevice'
      end
    end
    object tsCulori: TTabSheet
      Caption = 'Culori'
      ImageIndex = 5
      object cxPageControl1: TcxPageControl
        Left = 3
        Top = 3
        Width = 492
        Height = 265
        TabOrder = 0
        Properties.ActivePage = cxTabSheet2
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 261
        ClientRectLeft = 4
        ClientRectRight = 488
        ClientRectTop = 26
        object cxTabSheet2: TcxTabSheet
          Caption = 'Sunete'
          ImageIndex = 1
          object cbITSales_Background: TColorBox
            Left = 248
            Top = 16
            Width = 105
            Height = 22
            Selected = clPurple
            TabOrder = 0
          end
          object cbITSales_Foreground: TColorBox
            Left = 368
            Top = 16
            Width = 105
            Height = 22
            Selected = clWhite
            TabOrder = 1
          end
          object cxLabel1: TcxLabel
            Left = 3
            Top = 17
            Caption = 'Sunele pentru Vinzari IT'
            TabOrder = 2
            Transparent = True
          end
          object cxLabel2: TcxLabel
            Left = 3
            Top = 45
            Caption = 'Sunele pentru Vinzari Mobila'
            TabOrder = 5
            Transparent = True
          end
          object cbFurnitureSales_Background: TColorBox
            Left = 248
            Top = 44
            Width = 105
            Height = 22
            Selected = clFuchsia
            TabOrder = 3
          end
          object cbFurnitureSales_Foreground: TColorBox
            Left = 368
            Top = 44
            Width = 105
            Height = 22
            Selected = clWhite
            TabOrder = 4
          end
          object cxLabel3: TcxLabel
            Left = 3
            Top = 73
            Caption = 'Sunele pentru Service'
            TabOrder = 8
            Transparent = True
          end
          object cbService_Background: TColorBox
            Left = 248
            Top = 72
            Width = 105
            Height = 22
            Selected = clYellow
            TabOrder = 6
          end
          object cbService_Foreground: TColorBox
            Left = 368
            Top = 72
            Width = 105
            Height = 22
            TabOrder = 7
          end
          object cxLabel4: TcxLabel
            Left = 3
            Top = 101
            Caption = 'Sunele pentru Contabilitate'
            TabOrder = 11
            Transparent = True
          end
          object cbAccounting_Background: TColorBox
            Left = 248
            Top = 100
            Width = 105
            Height = 22
            Selected = clRed
            TabOrder = 9
          end
          object cbAccounting_Foreground: TColorBox
            Left = 368
            Top = 100
            Width = 105
            Height = 22
            Selected = clWhite
            TabOrder = 10
          end
          object cxLabel5: TcxLabel
            Left = 3
            Top = 129
            Caption = 'Sunele pentru Achizitii'
            TabOrder = 14
            Transparent = True
          end
          object cbPurchaise_Background: TColorBox
            Left = 248
            Top = 128
            Width = 105
            Height = 22
            Selected = clTeal
            TabOrder = 12
          end
          object cbPurchaise_Foreground: TColorBox
            Left = 368
            Top = 128
            Width = 105
            Height = 22
            Selected = clWhite
            TabOrder = 13
          end
        end
      end
    end
  end
end
