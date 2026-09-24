object frmMuncitorulProgressDlg: TfrmMuncitorulProgressDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmMuncitorulProgressDlg'
  ClientHeight = 123
  ClientWidth = 523
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 100
    Height = 15
    Caption = '1. Get product json'
  end
  object Label2: TLabel
    Left = 32
    Top = 37
    Width = 65
    Height = 15
    Caption = '2. Parse json'
  end
  object Label3: TLabel
    Left = 32
    Top = 58
    Width = 109
    Height = 15
    Caption = '3. Import to PriceList'
  end
  object lbTime: TLabel
    Left = 253
    Top = 16
    Width = 37
    Height = 15
    Caption = 'lbTime'
  end
  object dxActivityIndicator1: TdxActivityIndicator
    Left = 42
    Top = 79
    Width = 473
    Height = 26
    PropertiesClassName = 'TdxActivityIndicatorHorizontalDotsProperties'
  end
  object DsFeatures: TDataSource
    Left = 264
    Top = 63
  end
  object DsImages: TDataSource
    Left = 192
    Top = 63
  end
  object DsProducts: TDataSource
    Left = 104
    Top = 63
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 327
    Top = 65535
  end
  object FDTrUpdate: TFDTransaction
    Options.Isolation = xiReadCommitted
    Connection = FDConnection1
    Left = 452
    Top = 63
  end
  object FDTrSelect: TFDTransaction
    Options.Isolation = xiReadCommitted
    Connection = FDConnection1
    Left = 360
    Top = 63
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=sw'
      'User_Name=SYSDBA'
      'Password=uigres321'
      'Server=192.168.106.254'
      'Port=3050'
      'CharacterSet=utf8'
      'DriverID=FB'
      'BooleanFormat=Native'
      'Protocol=TCPIP')
    LoginPrompt = False
    Transaction = FDTrSelect
    UpdateTransaction = FDTrUpdate
    Left = 416
  end
end
