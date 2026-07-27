object frmKitTemplateGoodsEditorDlg: TfrmKitTemplateGoodsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = beGoods
  BorderStyle = bsDialog
  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1074' '#1096#1072#1073#1083#1086#1085#1077
  ClientHeight = 292
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    645
    292)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 645
    Height = 64
    Title = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1074' '#1096#1072#1073#1083#1086#1085#1077
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 629
    Height = 166
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
      Left = 20
      Top = 20
      Width = 83
      Height = 15
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 20
      Top = 84
      Width = 65
      Height = 15
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object beGoods: TcxButtonEdit
      Left = 20
      Top = 37
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGoodsPropertiesButtonClick
      TabOrder = 0
      Text = 'beGoods'
      Width = 581
    end
    object ceQTY: TcxDBCalcEdit
      Left = 20
      Top = 101
      DataBinding.DataField = 'QTY'
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Width = 121
    end
    object cbFLG_ACTIVE: TcxDBCheckBox
      Left = 176
      Top = 101
      Caption = #1040#1082#1090#1080#1074#1085#1072#1103' '#1087#1086#1079#1080#1094#1080#1103
      DataBinding.DataField = 'FLG_ACTIVE'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
  end
  object btnOk: TButton
    Left = 428
    Top = 249
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 532
    Top = 249
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
