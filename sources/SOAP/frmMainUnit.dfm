object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ultra Rest API'
  ClientHeight = 166
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 13
  object lbTimer: TLabel
    Left = 8
    Top = 110
    Width = 22
    Height = 13
    Caption = '0:00'
  end
  object Label2: TLabel
    Left = 8
    Top = 13
    Width = 36
    Height = 13
    Caption = #1057#1077#1088#1074#1080#1089
  end
  object Button1: TButton
    Left = 343
    Top = 29
    Width = 163
    Height = 25
    Caption = 'Start'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object edUUID: TEdit
    Left = 8
    Top = 83
    Width = 498
    Height = 21
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 29
    Width = 313
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'NOMENCLATURE'
    Items.Strings = (
      'NOMENCLATURE'
      'PROPERTIES'
      'NOMENCLATURETYPELIST'
      'BRAND'
      'PARENTLIST'
      'PRICELIST'
      'BALANCE'
      'RATES')
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 147
    Width = 557
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 149
    ExplicitWidth = 514
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 60
    Width = 498
    Height = 17
    TabOrder = 4
  end
  object HTTPRIO1: THTTPRIO
    WSDLLocation = 'https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl'
    Service = 'b2b'
    Port = 'b2bSoap'
    HTTPWebNode.UserName = 'SimionI'
    HTTPWebNode.Password = 'yYw3nv'
    HTTPWebNode.UseDefaultCredentials = False
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 440
    Top = 80
  end
  object MainMenu1: TMainMenu
    Left = 440
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object File2: TMenuItem
        Caption = 'Exit'
        ShortCut = 32856
        OnClick = File2Click
      end
    end
  end
  object IBCSQLNomenclature: TIBCSQL
    SQL.Strings = (
      
        'insert into TAPI_ULTRA_NOMENCLATURE (UUID, PARENT, CODE, NAME, N' +
        'OMENCLATURETYPE,'
      
        '                                     MAINIMAGE, ARTICLE, BRAND, ' +
        'FULLNAME,'
      '                                     ISACTIVE, WARRANTY)'
      
        'values (:UUID, :PARENT, :CODE, :NAME, :NOMENCLATURETYPE, :MAINIM' +
        'AGE, :ARTICLE,'
      '        :BRAND, :FULLNAME, :ISACTIVE, :WARRANTY)')
    Left = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'PARENT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CODE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'NAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'NOMENCLATURETYPE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'MAINIMAGE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ARTICLE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'BRAND'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FULLNAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ISACTIVE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'WARRANTY'
        Value = nil
      end>
  end
  object IBCConnection1: TIBCConnection
    Database = 'sw'
    Options.Charset = 'UTF8'
    Options.UseUnicode = True
    ClientLibrary = 'fbclient.dll'
    Port = '3050'
    SSLOptions.Enabled = False
    Username = 'SYSDBA'
    Server = '192.168.106.254'
    LoginPrompt = False
    Left = 296
    Top = 24
    EncryptedPassword = '8AFF96FF98FF8DFF9AFF8CFFCCFFCDFFCEFF'
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = IBCConnection1
    Left = 224
    Top = 104
  end
  object IBCTrSelect: TIBCTransaction
    DefaultConnection = IBCConnection1
    Left = 384
    Top = 104
  end
  object IBCSQL1: TIBCSQL
    Connection = IBCConnection1
    Transaction = IBCTrUpdate
    Left = 216
  end
  object IBCSQLImages: TIBCSQL
    Connection = IBCConnection1
    SQL.Strings = (
      
        'insert into TAPI_ULTRA_IMAGES (GOODS_UUID, UUID, PATHGLOBAL, NAM' +
        'E)'
      'values (:GOODS_UUID, :UUID, :PATHGLOBAL, :NAME)')
    Left = 120
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'GOODS_UUID'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'PATHGLOBAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'NAME'
        Value = nil
      end>
  end
  object IBCSQLDsc: TIBCSQL
    Connection = IBCConnection1
    SQL.Strings = (
      'insert into TAPI_ULTRA_DSC (UUID, DESCRIPTION)'
      'values (:UUID, :DESCRIPTION)')
    Left = 112
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION'
        Value = nil
      end>
  end
end
