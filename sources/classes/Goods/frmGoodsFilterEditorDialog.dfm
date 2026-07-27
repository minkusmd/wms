object frmGoodsFilterEditor: TfrmGoodsFilterEditor
  Left = 0
  Top = 0
  ActiveControl = edFILTERNAME
  BorderStyle = bsDialog
  Caption = 'Proprietatile produselor pentru web'
  ClientHeight = 305
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    582
    305)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 582
    Height = 64
    Title = 'Proprietatile produselor'
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
    ImageIndex = 5
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 566
    Height = 175
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
      Top = 52
      Width = 58
      Height = 15
      Caption = 'Denumirea'
    end
    object Label2: TLabel
      Left = 12
      Top = 81
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 12
      Top = 23
      Width = 22
      Height = 15
      Caption = 'Cod'
    end
    object edFILTERNAME_RUS: TcxDBTextEdit
      Left = 76
      Top = 78
      DataBinding.DataField = 'FILTERNAME_RUS'
      TabOrder = 2
      Width = 470
    end
    object edFILTERNAME: TcxDBTextEdit
      Left = 76
      Top = 49
      DataBinding.DataField = 'FILTERNAME'
      TabOrder = 1
      Width = 470
    end
    object edFILTERID: TcxDBTextEdit
      Left = 76
      Top = 20
      TabStop = False
      DataBinding.DataField = 'FILTERID'
      TabOrder = 0
      Width = 101
    end
    object chkFLG_ORDINARY_FILTER: TcxDBCheckBox
      Left = 76
      Top = 136
      Caption = 'Proprietatea fara valori definite'
      DataBinding.DataField = 'FLG_ORDINARY_FILTER'
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueGrayed = 'False'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 4
    end
    object chkFlg_Is_Filter: TcxDBCheckBox
      Left = 76
      Top = 111
      Caption = 'Proprietatea serveste drept filtru'
      DataBinding.DataField = 'FLG_IS_FILTER'
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueGrayed = 'False'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 3
    end
  end
  object btnOk: TcxButton
    Left = 370
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 474
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
