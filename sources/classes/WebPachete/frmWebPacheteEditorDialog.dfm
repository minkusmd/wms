object frmWebPacheteEditorDlg: TfrmWebPacheteEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLU
  BorderStyle = bsDialog
  Caption = 'Pachet de produse'
  ClientHeight = 526
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    474
    526)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 474
    Height = 64
    Title = 'Pachet de produse'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 458
    Height = 401
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
      Left = 23
      Top = 19
      Width = 58
      Height = 15
      Caption = 'Denumirea'
    end
    object Label2: TLabel
      Left = 20
      Top = 76
      Width = 54
      Height = 15
      Caption = 'Descrierea'
    end
    object Label3: TLabel
      Left = 20
      Top = 195
      Width = 37
      Height = 15
      Caption = 'Produs'
    end
    object Label4: TLabel
      Left = 20
      Top = 267
      Width = 50
      Height = 15
      Caption = 'Data start'
    end
    object Label5: TLabel
      Left = 160
      Top = 267
      Width = 55
      Height = 15
      Caption = 'Data sfirsit'
    end
    object mmDESCRIERE: TcxDBMemo
      Left = 20
      Top = 93
      DataBinding.DataField = 'DESCRIERE'
      Properties.ScrollBars = ssVertical
      TabOrder = 1
      Height = 89
      Width = 417
    end
    object edTITLU: TcxDBTextEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'TITLU'
      TabOrder = 0
      Width = 417
    end
    object beGOODSID: TcxButtonEdit
      Left = 20
      Top = 213
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGOODSIDPropertiesButtonClick
      TabOrder = 2
      Text = 'beGOODSID'
      Width = 417
    end
    object deDATA_INCHEPUT: TcxDBDateEdit
      Left = 20
      Top = 285
      DataBinding.DataField = 'DATA_INCHEPUT'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 3
      Width = 121
    end
    object deDATA_SFIRSIT: TcxDBDateEdit
      Left = 160
      Top = 285
      DataBinding.DataField = 'DATA_SFIRSIT'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 4
      Width = 121
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 20
      Top = 332
      Caption = 'Pachet activ'
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 5
    end
  end
  object btnOk: TButton
    Left = 268
    Top = 484
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 364
    Top = 484
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
