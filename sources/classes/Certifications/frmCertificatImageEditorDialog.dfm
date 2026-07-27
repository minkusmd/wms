object frmCertificatImageEditorDlg: TfrmCertificatImageEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Imginea certificatului'
  ClientHeight = 573
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    986
    573)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 986
    Height = 64
    Title = 'Imaginea certificatului'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 970
    Height = 437
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 12
      Width = 43
      Height = 15
      Caption = 'Imagine'
    end
    object ScrollBox1: TScrollBox
      Left = 16
      Top = 29
      Width = 929
      Height = 365
      HorzScrollBar.Margin = 8
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Margin = 8
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 0
      object cxDBImage: TcxDBImage
        Left = 0
        Top = 0
        AutoSize = True
        DataBinding.DataField = 'IMAGE'
        DataBinding.DataSource = IBCDataSourceImage
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.ImmediatePost = True
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        TabOrder = 0
        Height = 345
        Width = 361
      end
    end
  end
  object btnOk: TcxButton
    Left = 773
    Top = 528
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 877
    Top = 528
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'IMAGEID'
    KeyGenerator = 'SQ_TS_CERTIFICAT_IMAGES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_CERTIFICAT_IMAGES'
      '  (CERTIFICATID, IMAGEID, IMAGE, IMAGE_THUMB)'
      'VALUES'
      '  (:CERTIFICATID, :IMAGEID, :IMAGE, :IMAGE_THUMB)')
    SQLUpdate.Strings = (
      'UPDATE TS_CERTIFICAT_IMAGES'
      'SET'
      '  IMAGE = :IMAGE, IMAGE_THUMB = :IMAGE_THUMB'
      'WHERE'
      '  IMAGEID = :Old_IMAGEID AND CERTIFICATID = :Old_CERTIFICATID')
    SQLRefresh.Strings = (
      
        'SELECT CERTIFICATID, IMAGEID, IMAGE, IMAGE_THUMB FROM TS_CERTIFI' +
        'CAT_IMAGES'
      'WHERE'
      '  IMAGEID = :IMAGEID AND CERTIFICATID = :CERTIFICATID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CERTIFICAT_IMAGES'
      'WHERE'
      'IMAGEID = :Old_IMAGEID AND CERTIFICATID = :Old_CERTIFICATID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT '
      ' CERTIFICATID, IMAGEID, IMAGE, IMAGE_THUMB '
      'FROM '
      ' TS_CERTIFICAT_IMAGES'
      'WHERE '
      ' CERTIFICATID = :certID and IMAGEID = :imgID')
    AutoCommit = False
    Left = 140
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'certID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'imgID'
        Value = nil
      end>
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 140
    Top = 152
  end
end
