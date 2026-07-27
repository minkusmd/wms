object frmGoodsFilterParamEditor: TfrmGoodsFilterParamEditor
  Left = 0
  Top = 0
  ActiveControl = edPARAM_VALUE
  BorderStyle = bsDialog
  Caption = 'Parametri filtrelor'
  ClientHeight = 249
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 615
    Height = 64
    Title = 'Valorile si denumirea parametrilor de filtrare'
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
    Width = 599
    Height = 105
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
      Left = 13
      Top = 29
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object Label1: TLabel
      Left = 12
      Top = 55
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1103
    end
    object edPARAM_VALUE: TcxDBTextEdit
      Left = 71
      Top = 26
      DataBinding.DataField = 'PARAM_VALUE'
      TabOrder = 0
      OnExit = edPARAM_VALUEExit
      OnKeyDown = edPARAM_VALUEKeyDown
      Width = 506
    end
    object edPARAM_VALUE_RUS: TcxDBTextEdit
      Left = 71
      Top = 55
      DataBinding.DataField = 'PARAM_VALUE_RUS'
      TabOrder = 1
      Width = 506
    end
  end
  object btnOk: TcxButton
    Left = 393
    Top = 196
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 497
    Top = 196
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 230
    Width = 615
    Height = 19
    Panels = <
      item
        Width = 350
      end>
  end
end
