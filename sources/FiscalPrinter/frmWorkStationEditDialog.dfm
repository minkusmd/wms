object frmWorkStationEditDlg: TfrmWorkStationEditDlg
  Left = 0
  Top = 0
  ActiveControl = cbFLG_ENABLED
  BorderStyle = bsDialog
  Caption = 'Statie de lucru'
  ClientHeight = 383
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    384
    383)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 384
    Height = 64
    Title = 'Statie de lucru'
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
    ImageIndex = 26
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 368
    Height = 250
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
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 60
      Width = 90
      Height = 15
      Caption = 'Nume calculator'
    end
    object Label2: TLabel
      Left = 20
      Top = 108
      Width = 48
      Height = 15
      Caption = 'Descriere'
    end
    object Label3: TLabel
      Left = 20
      Top = 192
      Width = 67
      Height = 15
      Caption = 'Subdiviziune'
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 20
      Top = 20
      Caption = 'Statie activa'
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
    object edCOMPUTER_NAME: TcxDBTextEdit
      Left = 20
      Top = 77
      DataBinding.DataField = 'COMPUTER_NAME'
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 210
    end
    object btnUseThisComputer: TButton
      Left = 238
      Top = 76
      Width = 103
      Height = 25
      Caption = 'Acest calculator'
      TabOrder = 2
      OnClick = btnUseThisComputerClick
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 20
      Top = 125
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 3
      Width = 321
    end
    object lcbFIRMA_ID: TcxDBLookupComboBox
      Left = 20
      Top = 209
      DataBinding.DataField = 'FIRMA_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceFirms
      TabOrder = 4
      Width = 321
    end
  end
  object btnOk: TButton
    Left = 169
    Top = 340
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 273
    Top = 340
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
