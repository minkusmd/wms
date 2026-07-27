object frmCustomerContractFileEditorDlg: TfrmCustomerContractFileEditorDlg
  Left = 0
  Top = 0
  ActiveControl = beFile
  BorderStyle = bsDialog
  Caption = 'Ata'#537'a'#539'i un fieiser la contract'
  ClientHeight = 300
  ClientWidth = 523
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 523
    Height = 64
    Title = 'Ata'#537'a'#539'i un fieiser la contract'
    Text = 'Alegeti un fisier'
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
    ImageIndex = 10
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 507
    Height = 173
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 28
      Width = 27
      Height = 15
      Caption = 'Fisier'
    end
    object Label2: TLabel
      Left = 20
      Top = 89
      Width = 76
      Height = 15
      Caption = 'Descriere fisier'
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 106
      DataBinding.DataField = 'TITLE'
      TabOrder = 1
      Width = 461
    end
    object beFile: TcxButtonEdit
      Left = 20
      Top = 45
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beFilePropertiesButtonClick
      TabOrder = 0
      Width = 461
    end
  end
  object btnOk: TButton
    Left = 304
    Top = 256
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 400
    Top = 256
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
