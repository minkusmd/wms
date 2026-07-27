object fCustomerStampDlg: TfCustomerStampDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1051#1086#1075#1086#1090#1080#1087' '#1080' '#1055#1077#1095#1072#1090#1100' '#1092#1080#1088#1084#1099
  ClientHeight = 491
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    645
    491)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 645
    Height = 64
    Title = #1051#1086#1075#1086#1090#1080#1087' '#1080' '#1055#1077#1095#1072#1090#1100' '#1092#1080#1088#1084#1099
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1083#1086#1075#1086#1090#1080#1087' '#1080' '#1087#1077#1095#1072#1090#1100' '#1092#1080#1088#1084#1099
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 70
    Width = 625
    Height = 373
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 369
    ClientRectLeft = 4
    ClientRectRight = 621
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = #1051#1086#1075#1086#1090#1080#1087' '#1080' '#1087#1088#1080#1093#1086#1076
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 16
        Top = 16
        Width = 46
        Height = 15
        Caption = #1051#1086#1075#1086#1090#1080#1087
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 280
        Top = 12
        Width = 39
        Height = 15
        Caption = #1055#1077#1095#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbLogoSize: TLabel
        Left = 206
        Top = 12
        Width = 43
        Height = 15
        Alignment = taRightJustify
        Caption = #1056#1072#1079#1084#1077#1088':'
      end
      object lbStamSize: TLabel
        Left = 387
        Top = 12
        Width = 43
        Height = 15
        Alignment = taRightJustify
        Caption = #1056#1072#1079#1084#1077#1088':'
      end
      object Label1: TLabel
        Left = 451
        Top = 12
        Width = 48
        Height = 15
        Caption = #1055#1086#1076#1087#1080#1089#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbSignatureSize: TLabel
        Left = 558
        Top = 12
        Width = 43
        Height = 15
        Alignment = taRightJustify
        Caption = #1056#1072#1079#1084#1077#1088':'
      end
      object imageLOGO: TcxDBImage
        Left = 16
        Top = 33
        DataBinding.DataField = 'LOGO'
        DataBinding.DataSource = IBCDataSourceStamp
        Properties.ClearKey = 16430
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxPNGImage'
        Properties.ImmediatePost = True
        Properties.ShowFocusRect = False
        Properties.OnAssignPicture = imageLOGOPropertiesAssignPicture
        TabOrder = 0
        ZoomingOptions.ShowZoomTrackBar = True
        Height = 112
        Width = 233
      end
      object imageSTAMP_IMAGE: TcxDBImage
        Left = 280
        Top = 33
        DataBinding.DataField = 'STAMP_IMAGE'
        DataBinding.DataSource = IBCDataSourceStamp
        Properties.ClearKey = 16430
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxPNGImage'
        Properties.ImmediatePost = True
        Properties.ShowFocusRect = False
        Properties.OnAssignPicture = imgStampPropertiesAssignPicture
        TabOrder = 1
        Height = 112
        Width = 150
      end
      object Panel1: TPanel
        Left = 16
        Top = 160
        Width = 585
        Height = 170
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 3
        object Label3: TLabel
          Left = 0
          Top = 1
          Width = 76
          Height = 30
          Caption = #1055#1086#1076#1087#1080#1089#1100' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label4: TLabel
          Left = 168
          Top = 4
          Width = 104
          Height = 30
          Caption = #1055#1086#1076#1087#1080#1089#1100' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object cxDBImage1: TcxDBImage
          Left = 0
          Top = 37
          DataBinding.DataField = 'CEO_SIGN'
          DataBinding.DataSource = IBCDataSourceStamp
          Properties.ClearKey = 16430
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.ShowFocusRect = False
          Properties.OnAssignPicture = imgStampPropertiesAssignPicture
          TabOrder = 0
          Height = 125
          Width = 150
        end
        object cxDBImage2: TcxDBImage
          Left = 168
          Top = 40
          DataBinding.DataField = 'ACCOUNTANT_SIGN'
          DataBinding.DataSource = IBCDataSourceStamp
          Properties.ClearKey = 16430
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.ShowFocusRect = False
          Properties.OnAssignPicture = imgStampPropertiesAssignPicture
          TabOrder = 1
          Height = 125
          Width = 150
        end
      end
      object ImageSignature: TcxDBImage
        Left = 451
        Top = 33
        DataBinding.DataField = 'SIGNATURE'
        DataBinding.DataSource = IBCDataSourceStamp
        Properties.ClearKey = 16430
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxPNGImage'
        Properties.ImmediatePost = True
        Properties.ShowFocusRect = False
        Properties.OnAssignPicture = cxDBImage1PropertiesAssignPicture
        TabOrder = 2
        Height = 112
        Width = 150
      end
    end
  end
  object btnOk: TcxButton
    Left = 229
    Top = 454
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 333
    Top = 454
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryStamp: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_STAMP'
      
        '  (CUSTOMERID, STAMP_IMAGE, LOGO, SIGNATURE, CEO_SIGN, ACCOUNTAN' +
        'T_SIGN)'
      'VALUES'
      
        '  (:CUSTOMERID, :STAMP_IMAGE, :LOGO, :SIGNATURE, :CEO_SIGN, :ACC' +
        'OUNTANT_SIGN)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_STAMP'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_STAMP'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, STAMP_IMAGE = :STAMP_IMAGE, LOGO = :' +
        'LOGO, SIGNATURE = :SIGNATURE, CEO_SIGN = :CEO_SIGN, ACCOUNTANT_S' +
        'IGN = :ACCOUNTANT_SIGN'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, STAMP_IMAGE, LOGO, SIGNATURE, CEO_SIGN, ACCOU' +
        'NTANT_SIGN FROM TS_CUST_STAMP'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_STAMP'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_CUST_STAMP'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' TS_CUST_STAMP')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 148
    Top = 204
  end
  object IBCDataSourceStamp: TIBCDataSource
    DataSet = IBCQueryStamp
    Left = 148
    Top = 144
  end
end
