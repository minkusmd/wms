object frmGoodsImagePreview: TfrmGoodsImagePreview
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1082#1072#1088#1090#1080#1085#1082#1080
  ClientHeight = 465
  ClientWidth = 758
  Color = clBtnFace
  Constraints.MinHeight = 240
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnPaint = FormPaint
  DesignSize = (
    758
    465)
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 758
    Height = 64
    Title = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076' '#1090#1086#1074#1072#1088#1072
    Text = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1086#1083#1085#1086#1088#1072#1079#1084#1077#1088#1085#1086#1081' '#1082#1072#1088#1090#1080#1085#1082#1080'. '#1056#1072#1079#1084#1077#1088' %dx%d. '#1054#1073#1100#1077#1084' %d KB.'
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
  end
  object cxImage1: TcxImage
    Left = 8
    Top = 72
    Anchors = [akLeft, akTop, akRight, akBottom]
    Properties.GraphicClassName = 'TdxSmartImage'
    TabOrder = 1
    Height = 385
    Width = 745
  end
end
