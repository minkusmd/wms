object frmSelectGoodsDlg: TfrmSelectGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege un produs'
  ClientHeight = 122
  ClientWidth = 652
  Color = clBtnFace
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 636
    Height = 66
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object beGoods: TcxButtonEdit
      Left = 79
      Top = 31
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
      TabOrder = 3
      Text = 'beGoods'
      Width = 542
    end
    object teGoodsID: TcxTextEdit
      Left = 16
      Top = 31
      Enabled = False
      Properties.ReadOnly = False
      TabOrder = 0
      Text = 'teGoodsID'
      Width = 57
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 6
      Caption = 'Cod'
    end
    object cxLabel2: TcxLabel
      Left = 79
      Top = 6
      Caption = 'Alege produs'
    end
  end
  object cxButton1: TcxButton
    Left = 445
    Top = 88
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 541
    Top = 88
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
