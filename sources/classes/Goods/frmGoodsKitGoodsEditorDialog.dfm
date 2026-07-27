object frmGoodsKitGoodsEditorDlg: TfrmGoodsKitGoodsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse in complectatie'
  ClientHeight = 353
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
    353)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 645
    Height = 64
    Title = 'Complectatia'
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
    Height = 227
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
      Width = 37
      Height = 15
      Caption = 'Produs'
    end
    object Label2: TLabel
      Left = 20
      Top = 84
      Width = 48
      Height = 15
      Caption = 'Cantitate'
    end
    object beGoods: TcxButtonEdit
      Left = 20
      Top = 41
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
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Width = 83
    end
    object cbFLG_ACTIVE: TcxDBCheckBox
      Left = 20
      Top = 138
      Caption = 'Pozitie activa'
      DataBinding.DataField = 'FLG_ACTIVE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object cbFLG_MODIFY_QTY: TcxDBCheckBox
      Left = 20
      Top = 167
      Caption = 'Modifica cantitatea pe web'
      DataBinding.DataField = 'FLG_MODIFY_QTY'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
  end
  object btnOk: TButton
    Left = 434
    Top = 310
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 538
    Top = 310
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
