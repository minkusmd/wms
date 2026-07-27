object frmMergeGoodsTypesDlg: TfrmMergeGoodsTypesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Uneste 2 tipuri de produse'
  ClientHeight = 159
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 19
    Width = 53
    Height = 15
    Caption = 'Cod vechi'
  end
  object Label2: TLabel
    Left = 136
    Top = 19
    Width = 46
    Height = 15
    Caption = 'Cod nou'
  end
  object cxButton1: TcxButton
    Left = 22
    Top = 109
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 126
    Top = 109
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object edOldGoodsType: TcxButtonEdit
    Left = 8
    Top = 40
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.MaskKind = emkRegExpr
    Properties.EditMask = '\d+'
    Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
    TabOrder = 0
    Text = '0'
    Width = 90
  end
  object edNewGoodsType: TcxButtonEdit
    Left = 136
    Top = 40
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.MaskKind = emkRegExpr
    Properties.EditMask = '\d+'
    Properties.OnButtonClick = cxButtonEdit2PropertiesButtonClick
    TabOrder = 1
    Text = '0'
    Width = 90
  end
  object IBCQuery1: TIBCQuery
    Connection = dmDB.IBCConnection
    Left = 112
    Top = 80
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 177
    Top = 67
  end
end
