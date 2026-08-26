object frmGoodsPriceListDlg: TfrmGoodsPriceListDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Proprietati produse din PriceList'
  ClientHeight = 291
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 255
    Width = 445
    TabOrder = 1
    ExplicitLeft = 228
    ExplicitTop = 222
    ExplicitWidth = 185
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 445
    Height = 255
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 1
    object beParent: TcxButtonEdit
      Left = 23
      Top = 41
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 1
      Width = 394
    end
    object beBrand: TcxButtonEdit
      Left = 23
      Top = 90
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 3
      Text = 'cxButtonEdit1'
      Width = 394
    end
    object beGoodsCategory: TcxButtonEdit
      Left = 23
      Top = 137
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 5
      Text = 'cxButtonEdit1'
      Width = 394
    end
    object cxLabel1: TcxLabel
      Left = 23
      Top = 24
      Caption = 'Mapa produsului'
    end
    object cxLabel2: TcxLabel
      Left = 23
      Top = 70
      Caption = 'Producator / Brand'
    end
    object cxLabel3: TcxLabel
      Left = 23
      Top = 119
      Caption = 'Categoria produsului'
    end
    object cxLabel4: TcxLabel
      Left = 23
      Top = 166
      Caption = 'TVA, %'
    end
    object ceVAT: TcxCalcEdit
      Left = 23
      Top = 191
      EditValue = 0.000000000000000000
      TabOrder = 7
      Width = 57
    end
  end
end
