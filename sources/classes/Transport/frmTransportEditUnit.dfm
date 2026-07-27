object frmTransportEditDlg: TfrmTransportEditDlg
  Left = 0
  Top = 0
  Caption = 'frmTransportEditDlg'
  ClientHeight = 331
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBTextEdit1: TcxDBTextEdit
    Left = 17
    Top = 31
    TabOrder = 1
    Width = 290
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 8
    Caption = 'Denumire'
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 58
    Caption = 'Model'
  end
  object cxDBTextEdit2: TcxDBTextEdit
    Left = 17
    Top = 81
    TabOrder = 3
    Width = 129
  end
  object cxLabel3: TcxLabel
    Left = 8
    Top = 108
    Caption = 'Numar de inregistrare'
  end
  object cxDBTextEdit3: TcxDBTextEdit
    Left = 17
    Top = 131
    TabOrder = 5
    Width = 73
  end
  object cxDBTextEdit5: TcxDBTextEdit
    Left = 17
    Top = 181
    Properties.IncrementalSearch = False
    TabOrder = 7
    Width = 73
  end
  object cxLabel5: TcxLabel
    Left = 8
    Top = 158
    Caption = 'Consum'
  end
  object cxLabel6: TcxLabel
    Left = 8
    Top = 208
    Caption = 'Sofer'
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 298
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 10
  end
  object cxButton2: TcxButton
    Left = 168
    Top = 298
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 11
  end
  object cxButtonEdit1: TcxButtonEdit
    Left = 17
    Top = 231
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 9
    Text = 'cxButtonEdit1'
    Width = 290
  end
end
