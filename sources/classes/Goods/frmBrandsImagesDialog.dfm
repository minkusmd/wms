object frmBrandsImagesDlg: TfrmBrandsImagesDlg
  Left = 0
  Top = 0
  ActiveControl = cxDBImage1
  BorderStyle = bsDialog
  Caption = 'Brand Logo'
  ClientHeight = 385
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 403
    Height = 64
    Title = 'Logo brand'
    Text = 'Alegeti o imagine pentru brandul selectat'
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
    ImageIndex = 9
  end
  object btnOK: TcxButton
    Left = 198
    Top = 348
    Width = 91
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 295
    Top = 348
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 385
    Height = 260
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxDBImage1: TcxDBImage
      Left = 8
      Top = 8
      DataBinding.DataField = 'IMAGE'
      DataBinding.DataSource = IBCDataSourceBrandsImage
      Properties.ClearKey = 16430
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 0
      Height = 217
      Width = 369
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 231
      Caption = ',PNG Transparent, (180x180)'
    end
  end
  object IBCDataSourceBrandsImage: TIBCDataSource
    DataSet = IBCQueryBrandsImage
    Left = 32
    Top = 112
  end
  object IBCQueryBrandsImage: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select *'
      'from TS_BRANDS_IMAGE'
      'where BRANDID = :SYSSID   ')
    AfterInsert = IBCQueryBrandsImageAfterInsert
    Left = 152
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SYSSID'
        Value = nil
      end>
  end
end
