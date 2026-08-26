object frmRelatedProductsEditor: TfrmRelatedProductsEditor
  Left = 0
  Top = 0
  Caption = 'Produse inrudite'
  ClientHeight = 209
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 462
    Height = 64
    Title = 'Produse inrudite'
    Text = 'Gestionarea produselor inrudite'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ExplicitLeft = 320
    ExplicitTop = 208
    ExplicitWidth = 0
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 67
    Width = 456
    Height = 98
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 618
    ExplicitHeight = 330
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 37
      Height = 15
      Caption = 'Produs'
    end
    object beGoods: TcxButtonEdit
      Left = 51
      Top = 16
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 0
      Width = 390
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 168
    Width = 462
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 400
    ExplicitWidth = 624
    object cxButton1: TcxButton
      AlignWithMargins = True
      Left = 136
      Top = 11
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 240
      Top = 11
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
