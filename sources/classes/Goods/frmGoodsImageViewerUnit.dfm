object frmGoodsImageViewer: TfrmGoodsImageViewer
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Image preview'
  ClientHeight = 248
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBImage1: TcxDBImage
    Left = 0
    Top = 0
    Align = alClient
    DataBinding.DataField = 'IMAGE'
    DataBinding.DataSource = IBCDataSourceGoodsImage
    Properties.FitMode = ifmProportionalStretch
    Properties.GraphicClassName = 'TdxSmartImage'
    Properties.ReadOnly = True
    TabOrder = 0
    Height = 248
    Width = 282
  end
  object IBCQueryGoodsImage: TIBCQuery
    KeyFields = 'GOODSID;GOODS_IMAGE_ID'
    SQL.Strings = (
      'select * from ts_goods_image')
    Left = 144
    Top = 104
  end
  object IBCDataSourceGoodsImage: TIBCDataSource
    DataSet = IBCQueryGoodsImage
    Left = 72
    Top = 104
  end
end
