object frmDocumentDeleteDlg: TfrmDocumentDeleteDlg
  Left = 0
  Top = 0
  ActiveControl = mmReason
  BorderStyle = bsDialog
  Caption = 'Sterge document'
  ClientHeight = 242
  ClientWidth = 423
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
    Width = 423
    Height = 189
    ImageAlignment = iaLeft
    Title = 'Sterge document'
    Text = 'Doriti sa stergeti documentul '#8470'999?'
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
    ImageIndex = 31
    object Label1: TLabel
      Left = 84
      Top = 72
      Width = 72
      Height = 15
      Caption = 'Indicati cauza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object mmReason: TcxMemo
      Left = 84
      Top = 91
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Height = 66
      Width = 305
    end
  end
  object btnYes: TButton
    Left = 208
    Top = 200
    Width = 90
    Height = 29
    Caption = 'Da'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnNo: TButton
    Left = 312
    Top = 200
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Nu'
    ModalResult = 2
    TabOrder = 2
  end
end
