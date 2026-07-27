object frm75GoodsDialog: Tfrm75GoodsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alerta produs'
  ClientHeight = 326
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object cxLabel1: TcxLabel
    Left = 14
    Top = 72
    Caption = 'Client'
  end
  object beCustomer: TcxButtonEdit
    Left = 154
    Top = 70
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000019A49444154789C7D533D4FC240187EEE7A47CB47825AABA082892118
          135757FF81A30989A3FF4217FC053A38F80B7430318E4E262E9AB8BB68E2200B
          30409014B0949E5790D2A3C8935CEFDE37EFF3DCF35EEF08248EEF2F843FB79D
          1EC44040FC50780EC140CE7D9B43B804DD46025933859BD31241089AFF2996F6
          CBB4BA8C8D8489EF3A8125D660B909ECE60AD8B25650DC34B1534823B394C4C2
          F641F9EDE9F66C2CC0C68B542703BB03ECE5D7D1717B787CADC0303E915E5C95
          457168DC1B8E6AB31D3630111806461F957A0BC59C19E45ACD1AB20BF9202654
          2802344C1E16306F38C7920E5C47A9956444A0A47C32D3077063361C3B064DAE
          C364C2BD8840D0024F8E1CD090034919E5F42851714038023295BB747BEEA4C0
          F89FACB43026FBB08DC6CC62C2A2B989C01F99B249DFD4504F9C303556047CF0
          743F586B7AB80D11118B08F8E4814DA1253DC52AE5536D4CDD03F522A5E71FD8
          2C0402C1AE6C1C472DDBF2EFF80F6AA640A55B03F738744D87C146BE5FDE3F00
          9721F1D585DBD360C54DF91A8F08E6E1EAF9419CDC5D8BC3F3CBD9A736855F39
          2F7C3DAE78C2930000000049454E44AE426082}
        Kind = bkGlyph
      end>
    Properties.OnButtonClick = beCustomerPropertiesButtonClick
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 1
    Text = 'beCustomer'
    Width = 293
  end
  object cxDBCheckBox1: TcxDBCheckBox
    Left = 22
    Top = 136
    Caption = 'SMS'
    DataBinding.DataField = 'FLG_ALERT_SMS'
    DataBinding.DataSource = IBCDataSource1
    Properties.ValueChecked = '1'
    Properties.ValueUnchecked = '0'
    TabOrder = 3
  end
  object cxDBTextEdit1: TcxDBTextEdit
    Left = 154
    Top = 136
    DataBinding.DataField = 'GSM_NUMBER'
    DataBinding.DataSource = IBCDataSource1
    TabOrder = 4
    Width = 109
  end
  object cxDBCheckBox2: TcxDBCheckBox
    Left = 22
    Top = 165
    Caption = 'E-Mail'
    DataBinding.DataField = 'FLG_ALERT_MAIL'
    DataBinding.DataSource = IBCDataSource1
    Properties.ValueChecked = '1'
    Properties.ValueUnchecked = '0'
    TabOrder = 6
  end
  object cxDBTextEdit2: TcxDBTextEdit
    Left = 154
    Top = 165
    DataBinding.DataField = 'EMAIL'
    DataBinding.DataSource = IBCDataSource1
    TabOrder = 7
    Width = 293
  end
  object cxLabel4: TcxLabel
    Left = 14
    Top = 208
    Caption = 'Produs'
  end
  object beGoods: TcxButtonEdit
    Left = 154
    Top = 207
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC400000EC401952B0E1B000000F149444154388D
          63FCFFFF3F03258005C6B8B33E449C8181A19381812102598180B83A8388552B
          D3BFFB4B986E9D5DC78C2CA711D2F19BE5EDA966E60F2FAF6733303034323030
          08C06599981954ECD21818049D19BE5E99C8F0F8C6410654CDDD0C37D694B2B2
          082B5B1CFFF6E985E9CFCF2F1918181818D879C519644DC31918F8EDA04A6F60
          D13C91E1C69A7C0606060606C6FFFFFFFF46F60A51E0C566861B47E643C2E0C6
          9A200CCD1A21EBE0EC1B6B8230E4609A1948B6190B18AE06A0071CFD5D40B466
          66A6E394BA209B6C035859D9A62AFBAF38CFC2C2CC34EBCFDF7F69A468D6B04F
          7DF5F6DEC91A060606060012CE49EBA86B9E9D0000000049454E44AE426082}
        Kind = bkGlyph
      end>
    Properties.OnButtonClick = beGoodsPropertiesButtonClick
    TabOrder = 8
    Text = 'cxButtonEdit1'
    Width = 293
  end
  object cxButton1: TcxButton
    Left = 125
    Top = 289
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 10
  end
  object cxButton2: TcxButton
    Left = 237
    Top = 289
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 1
    TabOrder = 12
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 462
    Height = 64
    Title = 'Alerta produs'
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
    ExplicitWidth = 454
  end
  object cxDBTextEdit3: TcxDBTextEdit
    Left = 154
    Top = 99
    DataBinding.DataField = 'Free_NAME'
    DataBinding.DataSource = IBCDataSource1
    TabOrder = 2
    Width = 293
  end
  object cxLabel5: TcxLabel
    Left = 14
    Top = 97
    Caption = 'Persoana necunoscuta'
  end
  object IBCDataSource1: TIBCDataSource
    Left = 344
    Top = 120
  end
end
