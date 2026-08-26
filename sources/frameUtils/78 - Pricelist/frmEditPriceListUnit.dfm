object frmEditPriceListDialog: TfrmEditPriceListDialog
  Left = 0
  Top = 0
  Caption = 'frmEditPriceListDialog'
  ClientHeight = 838
  ClientWidth = 1316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dxSpreadSheet1: TdxSpreadSheet
    Left = 0
    Top = 0
    Width = 1316
    Height = 470
    Align = alClient
    Data = {
      B002000044585353763242461000000042465320000000000000000001000101
      010100000000000001004246532000000000424653200100000001000000200B
      00000007000000430061006C0069006200720069000000000000002000000020
      0000000020000000000020000000000020000000000020000007000000470045
      004E004500520041004C00000000000002000000000000000001424653200100
      0000424653201700000054006400780053007000720065006100640053006800
      6500650074005400610062006C00650056006900650077000600000053006800
      650065007400310001FFFFFFFFFFFFFFFF640000000200000002000000020000
      0055000000140000000200000002000000000200000002000000000000010000
      0000000101000042465320550000000000000042465320000000004246532014
      0000000000000042465320000000000000000000000000010000000000000000
      0000000000000000000000424653200000000002020000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000064000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000200020200020000000000000000000000000000000000020000000000
      0000000000000000000000000000000000000000000000000000000000000202
      00000000000000004246532000000000000000000C00000053002E004D006900
      6E00630068006500760069006300690000000000000000000C00000053002E00
      4D0069006E0063006800650076006900630069000000000000000000ED2EB359
      D0D1E540E73DBB59D0D1E5400000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 478
    Width = 1316
    Height = 314
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object teCode: TcxTextEdit
      Left = 16
      Top = 144
      TabOrder = 0
      Text = 'cxTextEdit1'
      Width = 642
    end
    object teCodeRu: TcxTextEdit
      Left = 664
      Top = 144
      TabOrder = 1
      Text = 'cxTextEdit1'
      Width = 617
    end
    object lcbGoodsType: TcxLookupComboBox
      Left = 16
      Top = 99
      Properties.ListColumns = <>
      TabOrder = 2
      Width = 473
    end
    object lcbVendor: TcxLookupComboBox
      Left = 512
      Top = 99
      Properties.ListColumns = <>
      TabOrder = 3
      Width = 321
    end
    object teBaseParams: TcxTextEdit
      Left = 16
      Top = 192
      TabOrder = 4
      Text = 'cxTextEdit1'
      Width = 642
    end
    object teBaseParamsRu: TcxTextEdit
      Left = 664
      Top = 192
      TabOrder = 5
      Text = 'cxTextEdit1'
      Width = 617
    end
    object teDetails: TcxTextEdit
      Left = 16
      Top = 246
      TabOrder = 6
      Text = 'cxTextEdit1'
      Width = 1265
    end
    object meTitle: TcxMemo
      Left = 16
      Top = 16
      Lines.Strings = (
        'meTitle')
      TabOrder = 7
      Height = 61
      Width = 1265
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 83
      Caption = 'Tip produs'
    end
    object lasdf: TcxLabel
      Left = 512
      Top = 83
      Caption = 'Producator'
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 128
      Caption = 'Producator'
    end
    object cxLabel4: TcxLabel
      Left = 664
      Top = 128
      Caption = 'Producator'
    end
    object cxLabel5: TcxLabel
      Left = 664
      Top = 173
      Caption = 'Producator'
    end
    object cxLabel6: TcxLabel
      Left = 16
      Top = 173
      Caption = 'Producator'
    end
    object cxLabel7: TcxLabel
      Left = 16
      Top = 221
      Caption = 'Tip produs'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 792
    Width = 1316
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxButton1: TcxButton
      Left = 576
      Top = 8
      Width = 90
      Height = 29
      Caption = 'OK'
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 690
      Top = 8
      Width = 90
      Height = 29
      Caption = 'Renunta'
      TabOrder = 1
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 470
    Width = 1316
    Height = 8
    AlignSplitter = salBottom
  end
end
