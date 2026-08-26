object frmChangeGoodsSupplier: TfrmChangeGoodsSupplier
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Schimba furnizorul de produse'
  ClientHeight = 160
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object beOldCustomer: TcxButtonEdit
    Left = 104
    Top = 24
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
    TabOrder = 0
    Width = 346
  end
  object beNewCustomer: TcxButtonEdit
    Left = 104
    Top = 64
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = beNewCustomerPropertiesButtonClick
    TabOrder = 2
    Width = 346
  end
  object cxLabel1: TcxLabel
    Left = 9
    Top = 25
    Caption = 'Furnizor curent'
  end
  object cxLabel2: TcxLabel
    Left = 9
    Top = 65
    Caption = 'Furnizor nou'
  end
  object cxButton1: TcxButton
    Left = 152
    Top = 123
    Width = 90
    Height = 29
    Caption = ' Modifica'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = cxButton1Click
  end
  object cxButton2: TcxButton
    Left = 256
    Top = 123
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
  end
  object IBCTrLocal: TIBCTransaction
    Left = 224
    Top = 88
  end
end
