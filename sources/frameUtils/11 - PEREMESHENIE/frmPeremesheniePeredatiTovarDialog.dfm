object frmPeremesheniePeredatiTovarDlg: TfrmPeremesheniePeredatiTovarDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Transfer de marfa'
  ClientHeight = 404
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    726
    404)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 726
    Height = 64
    Title = 'Transfer de marfa'
    Text = 'Indicati numarul de cutii transmise'
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
    ImageIndex = 21
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 710
    Height = 276
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
    object cxLabel1: TLabel
      Left = 12
      Top = 107
      Width = 168
      Height = 15
      Caption = 'Numarul de cutii la transportare'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 161
      Width = 48
      Height = 15
      Caption = 'Mentiuni'
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 12
      Top = 19
      Width = 50
      Height = 15
      Caption = 'Expeditor'
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 48
      Width = 53
      Height = 15
      Caption = 'Destinatar'
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 12
      Top = 88
      Width = 680
      Height = 4
      Shape = bsTopLine
    end
    object edDT_NAME: TcxDBTextEdit
      Left = 93
      Top = 16
      TabStop = False
      DataBinding.DataField = 'DT_NAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 300
    end
    object edCT_NAME: TcxDBTextEdit
      Left = 93
      Top = 45
      TabStop = False
      DataBinding.DataField = 'CT_NAME'
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 300
    end
    object edDTDEP_NAME: TcxDBTextEdit
      Left = 411
      Top = 16
      TabStop = False
      DataBinding.DataField = 'DTDEP_NAME'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 281
    end
    object edCTDEP_NAME: TcxDBTextEdit
      Left = 411
      Top = 45
      TabStop = False
      DataBinding.DataField = 'CTDEP_NAME'
      Properties.ReadOnly = True
      TabOrder = 3
      Width = 281
    end
    object cxDBMaskEdit1: TcxDBMaskEdit
      Left = 12
      Top = 124
      TabStop = False
      DataBinding.DataField = 'BOX_COUNT'
      DataBinding.DataSource = IBCDataSourceDocAddons
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 4
      Width = 121
    end
    object cxDBMemo1: TcxDBMemo
      Left = 12
      Top = 179
      TabStop = False
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocAddons
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 5
      OnClick = cxDBMemo1Click
      Width = 680
    end
  end
  object btnOk: TcxButton
    Left = 512
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 612
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDocAddons: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_ADDONS'
      '  (DOCID, BOX_COUNT, COMMENTS)'
      'VALUES'
      '  (:DOCID, :BOX_COUNT, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_ADDONS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_ADDONS'
      'SET'
      '  DOCID = :DOCID, BOX_COUNT = :BOX_COUNT, COMMENTS = :COMMENTS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT '
      ' DOCID, BOX_COUNT, COMMENTS '
      'FROM '
      ' TDB_DOCS_ADDONS'
      'WHERE'
      ' DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_ADDONS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT '
      ' DOCID,'
      ' BOX_COUNT,'
      ' COMMENTS'
      'FROM'
      ' TDB_DOCS_ADDONS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    Left = 364
    Top = 240
  end
  object IBCDataSourceDocAddons: TIBCDataSource
    DataSet = IBCQueryDocAddons
    Left = 364
    Top = 192
  end
end
