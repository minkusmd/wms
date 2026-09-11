object frmGoodsTypeEditorDlg: TfrmGoodsTypeEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Tip produse'
  ClientHeight = 635
  ClientWidth = 1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1077
    635)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1077
    Height = 64
    Title = 'Tip produse'
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
    ImageIndex = 11
    ExplicitWidth = 522
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1061
    Height = 515
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
    ExplicitWidth = 506
    ExplicitHeight = 215
    DesignSize = (
      1057
      511)
    object ScrollBox1: TScrollBox
      Left = 12
      Top = 11
      Width = 1034
      Height = 487
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      TabOrder = 0
      object Label1: TLabel
        Left = 470
        Top = 10
        Width = 52
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      end
      object Label3: TLabel
        Left = 16
        Top = 12
        Width = 58
        Height = 15
        Caption = 'Denumirea'
      end
      object Label8: TLabel
        Left = 16
        Top = 58
        Width = 34
        Height = 15
        Caption = #1055#1072#1087#1082#1072
      end
      object edTITLE_RUS: TcxDBTextEdit
        Left = 470
        Top = 27
        DataBinding.DataField = 'TITLE_RUS'
        ParentFont = False
        TabOrder = 1
        Width = 448
      end
      object edTITLE: TcxDBTextEdit
        Left = 16
        Top = 27
        DataBinding.DataField = 'TITLE'
        ParentFont = False
        TabOrder = 0
        Width = 448
      end
      object beGoodsFolder: TcxButtonEdit
        Left = 16
        Top = 79
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = beGoodsFolderPropertiesButtonClick
        TabOrder = 2
        Text = 'beGoodsFolder'
        Width = 448
      end
      object chkFeed: TcxDBCheckBox
        Left = 939
        Top = 27
        Caption = 'Export in Feed'
        DataBinding.DataField = 'FLG_FEED'
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Style.TransparentBorder = False
        TabOrder = 3
      end
      object Panel1: TPanel
        Left = 16
        Top = 108
        Width = 1001
        Height = 365
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 4
      end
    end
  end
  object btnOk: TcxButton
    Left = 858
    Top = 598
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 303
    ExplicitTop = 298
  end
  object btnCancel: TcxButton
    Left = 966
    Top = 598
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 411
    ExplicitTop = 298
  end
  object btnAttributes: TcxButton
    Left = 8
    Top = 598
    Width = 200
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Filtre si sablon'
    TabOrder = 4
    OnClick = btnAttributesClick
    ExplicitTop = 298
  end
  object btnServices: TcxButton
    Left = 216
    Top = 598
    Width = 160
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Servicii adiacente'
    TabOrder = 5
    OnClick = btnServicesClick
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_TYPE_IMAGE'
      '  (GOODSTYPEID, IMAGE, MENU_IMAGE)'
      'VALUES'
      '  (:GOODSTYPEID, :IMAGE, :MENU_IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_TYPE_IMAGE'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_TYPE_IMAGE'
      'SET'
      
        '  GOODSTYPEID = :GOODSTYPEID, IMAGE = :IMAGE, MENU_IMAGE = :MENU' +
        '_IMAGE'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLRefresh.Strings = (
      'SELECT GOODSTYPEID, IMAGE, MENU_IMAGE FROM TS_GOODS_TYPE_IMAGE'
      'WHERE'
      '  GOODSTYPEID = :GOODSTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_TYPE_IMAGE'
      'WHERE'
      'GOODSTYPEID = :Old_GOODSTYPEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_GOODS_TYPE_IMAGE'
      ''
      ') q')
    SQL.Strings = (
      
        'select * from ts_goods_type_image where goodstypeid = :goodstype' +
        'id')
    AutoCommit = False
    Left = 272
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodstypeid'
        Value = nil
      end>
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 272
    Top = 8
  end
end
