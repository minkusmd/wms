object frmWebCatalogImageDlg: TfrmWebCatalogImageDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Imagine pentru web catalog'
  ClientHeight = 294
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Label19: TLabel
    Left = 16
    Top = 70
    Width = 102
    Height = 15
    Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
    Caption = #1055#1083#1080#1090#1082#1072' (272'#1093'268)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 459
    Height = 64
    Title = 'Imagine pentru web catalog'
    Text = ''
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
    ExplicitWidth = 409
  end
  object btnOk: TButton
    Left = 252
    Top = 260
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 352
    Top = 260
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object btnDelete: TButton
    Left = 24
    Top = 260
    Width = 133
    Height = 29
    Caption = 'Sterge imaginea'
    ImageIndex = 35
    ImageMargins.Left = 4
    Images = dmAdditions.cxImageList_SWN
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object imgBIG_IMAGE: TcxDBImage
    Left = 11
    Top = 95
    DataBinding.DataField = 'BIG_IMAGE'
    DataBinding.DataSource = IBCDataSourceImage
    Properties.Caption = #1087#1083#1080#1090#1082#1072' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
    Properties.GraphicClassName = 'TdxPNGImage'
    TabOrder = 4
    Height = 150
    Width = 207
  end
  object imgIMAGE: TcxDBImage
    Left = 312
    Top = 94
    DataBinding.DataField = 'IMAGE'
    DataBinding.DataSource = IBCDataSourceImage
    Properties.GraphicClassName = 'TdxPNGImage'
    Properties.ImmediatePost = True
    Properties.ShowFocusRect = False
    Style.BorderStyle = ebsNone
    Style.Color = clWindow
    TabOrder = 5
    Height = 99
    Width = 121
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_IMAGE'
      '  (CATALOGID, IMAGE, BIG_IMAGE)'
      'VALUES'
      '  (:CATALOGID, :IMAGE, :BIG_IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_IMAGE'
      'SET'
      '  CATALOGID = :CATALOGID, IMAGE = :IMAGE, BIG_IMAGE = :BIG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      'SELECT CATALOGID, IMAGE, BIG_IMAGE FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT CATALOGID, IMAGE, BIG_IMAGE FROM TWEB_CATALOG_IMAGE')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 160
    Top = 122
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 280
    Top = 122
  end
end
