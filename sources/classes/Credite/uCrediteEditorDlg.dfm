object frmCrediteEditorDlg: TfrmCrediteEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Modificarea conditiilor de creditare'
  ClientHeight = 328
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object cxButton1: TcxButton
    Left = 223
    Top = 291
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 327
    Top = 291
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 425
    Height = 277
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 16
      Top = 15
      Caption = 'Denumirea'
    end
    object cxLabel2: TcxLabel
      Left = 16
      Top = 80
      Caption = 'Sumele acordate'
    end
    object teTitle: TcxDBTextEdit
      Left = 144
      Top = 14
      TabOrder = 0
      Width = 265
    end
    object ceSumaMin: TcxDBCalcEdit
      Left = 144
      Top = 79
      TabOrder = 2
      Width = 81
    end
    object ceSumaMax: TcxDBCalcEdit
      Left = 231
      Top = 79
      TabOrder = 3
      Width = 74
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 120
      Caption = 'Durata creditului (luni)'
    end
    object ceLuniMin: TcxDBCalcEdit
      Left = 144
      Top = 119
      TabOrder = 5
      Width = 81
    end
    object ceLuniMax: TcxDBCalcEdit
      Left = 231
      Top = 119
      TabOrder = 6
      Width = 74
    end
    object cxLabel4: TcxLabel
      Left = 16
      Top = 160
      Caption = 'Dobinda'
    end
    object ceDobinda: TcxDBCalcEdit
      Left = 144
      Top = 159
      TabOrder = 8
      Width = 81
    end
    object cxLabel5: TcxLabel
      Left = 249
      Top = 160
      Caption = 'Comision lunar'
    end
    object ceComision: TcxDBCalcEdit
      Left = 328
      Top = 159
      TabOrder = 9
      Width = 81
    end
    object cxLabel6: TcxLabel
      Left = 16
      Top = 200
      Caption = 'Procentul primei rate'
    end
    object cePrimaRata: TcxDBCalcEdit
      Left = 144
      Top = 199
      TabOrder = 12
      Width = 81
    end
    object cxLabel7: TcxLabel
      Left = 16
      Top = 240
      Caption = 'Client'
    end
    object beCustomerName: TcxButtonEdit
      Left = 144
      Top = 239
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ClickKey = 115
      Properties.OnButtonClick = beCustomerNamePropertiesButtonClick
      TabOrder = 14
      Text = 'beCustomerName'
      Width = 265
    end
  end
  object cbActive: TcxDBCheckBox
    Left = 150
    Top = 51
    Caption = 'Activ'
    Properties.DisplayChecked = '1'
    Properties.DisplayUnchecked = '0'
    Properties.ValueChecked = '1'
    Properties.ValueUnchecked = '0'
    TabOrder = 1
  end
end
