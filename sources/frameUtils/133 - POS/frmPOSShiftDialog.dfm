object frmPOSShiftDlg: TfrmPOSShiftDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Tura'
  ClientHeight = 520
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 19
  object lblTitle: TLabel
    Left = 20
    Top = 16
    Width = 520
    Height = 28
    AutoSize = False
    Caption = 'Tura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInfo: TLabel
    Left = 20
    Top = 54
    Width = 520
    Height = 196
    AutoSize = False
    WordWrap = True
  end
  object lblSuma: TLabel
    Left = 20
    Top = 258
    Width = 520
    Height = 20
    AutoSize = False
    Caption = 'Suma, lei'
  end
  object lblReason: TLabel
    Left = 20
    Top = 340
    Width = 520
    Height = 20
    AutoSize = False
    Caption = 'Motiv'
  end
  object lblFiscal: TLabel
    Left = 260
    Top = 292
    Width = 280
    Height = 24
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edSuma: TEdit
    Left = 20
    Top = 282
    Width = 220
    Height = 44
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnChange = edSumaChange
  end
  object edReason: TEdit
    Left = 20
    Top = 364
    Width = 520
    Height = 27
    MaxLength = 256
    TabOrder = 1
  end
  object btnXReport: TButton
    Left = 20
    Top = 408
    Width = 170
    Height = 40
    Caption = 'Raport X'
    TabOrder = 2
    OnClick = btnXReportClick
  end
  object btnDrawer: TButton
    Left = 200
    Top = 408
    Width = 170
    Height = 40
    Caption = 'Deschide sertarul'
    TabOrder = 3
    OnClick = btnDrawerClick
  end
  object btnOK: TButton
    Left = 20
    Top = 462
    Width = 350
    Height = 46
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 380
    Top = 462
    Width = 160
    Height = 46
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
  end
end
