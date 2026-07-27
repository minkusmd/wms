object frmDocTypesRegionEditorDlg: TfrmDocTypesRegionEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Regiune'
  ClientHeight = 378
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    521
    378)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 521
    Height = 64
    Title = 'Regiune'
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
    ImageIndex = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 505
    Height = 252
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
    object cxLabel1: TLabel
      Left = 16
      Top = 12
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object cxLabel2: TLabel
      Left = 256
      Top = 12
      Width = 54
      Height = 15
      Caption = 'Vizibilitate'
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 72
      Width = 23
      Height = 15
      Caption = 'Icon'
    end
    object cxLabel4: TLabel
      Left = 16
      Top = 137
      Width = 80
      Height = 15
      Caption = 'Cod document'
    end
    object Label1: TLabel
      Left = 16
      Top = 166
      Width = 42
      Height = 15
      Caption = 'Ordinea'
    end
    object clbStructure: TcxCheckListBox
      Left = 256
      Top = 29
      Width = 230
      Height = 199
      IntegralHeight = True
      Items = <>
      TabOrder = 1
      OnCheckStatesToEditValue = clbStructureCheckStatesToEditValue
      OnEditValueToCheckStates = clbStructureEditValueToCheckStates
    end
    object edTITLE: TcxTextEdit
      Left = 16
      Top = 29
      TabOrder = 0
      Text = #1053#1086#1074#1072#1103' '#1086#1073#1083#1072#1089#1090#1100
      Width = 209
    end
    object icbImageIndex: TcxImageComboBox
      Left = 16
      Top = 89
      EditValue = 0
      Properties.Images = dmAdditions.cxImageList_MainTabs
      Properties.Items = <>
      TabOrder = 2
      Width = 90
    end
    object edDocTypeID: TcxTextEdit
      Left = 107
      Top = 134
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 3
      Width = 118
    end
    object cbAccessVisible: TcxCheckBox
      Left = 16
      Top = 200
      Caption = 'Arata in copacul cu drepturi'
      Properties.Alignment = taLeftJustify
      TabOrder = 5
    end
    object teOrderNo: TcxTextEdit
      Left = 107
      Top = 163
      TabStop = False
      Properties.ReadOnly = False
      TabOrder = 4
      Width = 118
    end
  end
  object btnCancel: TcxButton
    Left = 412
    Top = 335
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 308
    Top = 335
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
