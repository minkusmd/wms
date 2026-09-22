object frmPOSPaymentDlg: TfrmPOSPaymentDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Incasare'
  ClientHeight = 600
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 19
  object lblTotalCaption: TLabel
    Left = 20
    Top = 16
    Width = 190
    Height = 20
    AutoSize = False
    Caption = 'TOTAL, lei'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTotal: TLabel
    Left = 20
    Top = 38
    Width = 190
    Height = 44
    AutoSize = False
    Caption = '0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRemainingCaption: TLabel
    Left = 225
    Top = 16
    Width = 190
    Height = 20
    AutoSize = False
    Caption = 'De incasat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblRemaining: TLabel
    Left = 225
    Top = 38
    Width = 190
    Height = 44
    AutoSize = False
    Caption = '0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblChangeCaption: TLabel
    Left = 430
    Top = 16
    Width = 190
    Height = 20
    AutoSize = False
    Caption = 'Rest pentru client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblChange: TLabel
    Left = 430
    Top = 38
    Width = 190
    Height = 44
    AutoSize = False
    Caption = '0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSuma: TLabel
    Left = 20
    Top = 100
    Width = 300
    Height = 20
    AutoSize = False
    Caption = 'Suma (gol = tot restul de plata)'
  end
  object lblRef: TLabel
    Left = 340
    Top = 100
    Width = 280
    Height = 20
    AutoSize = False
    Caption = 'Referinta card / QR (optional)'
  end
  object edSuma: TEdit
    Left = 20
    Top = 124
    Width = 300
    Height = 44
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edSumaKeyDown
  end
  object edRef: TEdit
    Left = 340
    Top = 132
    Width = 280
    Height = 27
    MaxLength = 128
    TabOrder = 1
  end
  object btnCash: TButton
    Left = 20
    Top = 184
    Width = 190
    Height = 72
    Caption = 'Numerar  F1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnCashClick
  end
  object btnCard: TButton
    Left = 225
    Top = 184
    Width = 190
    Height = 72
    Caption = 'Card  F2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnCardClick
  end
  object btnQR: TButton
    Left = 430
    Top = 184
    Width = 190
    Height = 72
    Caption = 'QR MIA  F3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnQRClick
  end
  object lvPayments: TListView
    Left = 20
    Top = 274
    Width = 600
    Height = 200
    Columns = <
      item
        Caption = 'Plata'
        Width = 150
      end
      item
        Alignment = taRightJustify
        Caption = 'Acopera'
        Width = 130
      end
      item
        Alignment = taRightJustify
        Caption = 'Primit'
        Width = 130
      end
      item
        Caption = 'Referinta'
        Width = 170
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 5
    TabStop = False
    ViewStyle = vsReport
  end
  object btnRemove: TButton
    Left = 20
    Top = 484
    Width = 190
    Height = 40
    Caption = 'Sterge plata'
    TabOrder = 6
    TabStop = False
    OnClick = btnRemoveClick
  end
  object btnOK: TButton
    Left = 20
    Top = 538
    Width = 395
    Height = 50
    Caption = 'Tipareste bonul'
    Default = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 7
  end
  object btnCancel: TButton
    Left = 430
    Top = 538
    Width = 190
    Height = 50
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 8
  end
end
