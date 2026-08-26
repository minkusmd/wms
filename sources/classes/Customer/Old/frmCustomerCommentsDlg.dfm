object frmCustomerCommentsDialog: TfrmCustomerCommentsDialog
  Left = 0
  Top = 0
  ActiveControl = mmCOMMENTS
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1087#1086' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1091
  ClientHeight = 358
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    517
    358)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 517
    Height = 64
    Title = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1087#1086' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1091
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
    ImageIndex = 2
  end
  object btnOk: TButton
    Left = 308
    Top = 315
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 412
    Top = 315
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 501
    Height = 229
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 64
      Width = 155
      Height = 15
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1087#1086' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1091
    end
    object Label2: TLabel
      Left = 12
      Top = 20
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object mmCOMMENTS: TcxDBMemo
      AlignWithMargins = True
      Left = 12
      Top = 84
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceComments
      Properties.ScrollBars = ssVertical
      TabOrder = 1
      Height = 127
      Width = 470
    end
    object edDISPLAYNAME: TcxDBTextEdit
      Left = 80
      Top = 17
      TabStop = False
      DataBinding.DataField = 'DISPLAYNAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 402
    end
  end
  object IBCQueryComments: TIBCQuery
    UpdatingTable = 'TS_CUST_COMMENTS'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_COMMENTS'
      '  (CUSTOMERID, COMMENTS)'
      'VALUES'
      '  (:CUSTOMERID, :COMMENTS)')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_COMMENTS'
      'SET'
      '  COMMENTS = :COMMENTS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CUSTOMERID, '
      ' COMMENTS '
      'FROM '
      ' TS_CUST_COMMENTS'
      'WHERE'
      ' CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_COMMENTS'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' COMMENTS'
      'FROM'
      ' TS_CUST_COMMENTS')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 244
    Top = 156
  end
  object IBCDataSourceComments: TIBCDataSource
    DataSet = IBCQueryComments
    Left = 116
    Top = 156
  end
end
