object frmParentTreeChangerDlg: TfrmParentTreeChangerDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1077#1076#1082#1072
  ClientHeight = 461
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    513
    461)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 513
    Height = 64
    Title = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1077#1076#1082#1072
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
    ImageIndex = 7
  end
  object btnOk: TcxButton
    Left = 299
    Top = 416
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 403
    Top = 416
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object dxDBTreeView1: TdxDBTreeView
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 497
    Height = 329
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ShowNodeHint = True
    AutoExpand = True
    KeyField = 'GOODSID'
    ListField = 'TITLE'
    ParentField = 'FLG_FOLDER'
    RootValue = Null
    SeparatedSt = ' - '
    RaiseOnError = True
    Indent = 21
    Align = alTop
    ParentColor = False
    Options = [trDBConfirmDelete, trCheckHasChildren]
    SelectedIndex = -1
    TabOrder = 3
    Images = dmAdditions.cxImageList_SWN
  end
end
