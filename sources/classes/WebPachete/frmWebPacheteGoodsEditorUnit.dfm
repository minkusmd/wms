object frmWebPacheteGoodsEditorDlg: TfrmWebPacheteGoodsEditorDlg
  Left = 0
  Top = 0
  Caption = 'frmWebPacheteGoodsEditorDlg'
  ClientHeight = 193
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object beGoods: TcxButtonEdit
    Left = 24
    Top = 39
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = beGoodsPropertiesButtonClick
    TabOrder = 1
    Text = 'beGoods'
    Width = 579
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 14
    Caption = 'Produs'
  end
  object cePrice: TcxDBCalcEdit
    Left = 24
    Top = 93
    DataBinding.DataField = 'PRICE'
    TabOrder = 4
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 24
    Top = 68
    Caption = 'Pret in complect'
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 157
    Width = 624
    TabOrder = 6
    ExplicitLeft = 228
    ExplicitTop = 98
    ExplicitWidth = 185
  end
  object cxLabel3: TcxLabel
    Left = 172
    Top = 68
    Caption = 'Reducere'
  end
  object ceReducere: TcxDBCalcEdit
    Left = 172
    Top = 93
    DataBinding.DataField = 'DISCOUNT'
    TabOrder = 5
    Width = 121
  end
end
