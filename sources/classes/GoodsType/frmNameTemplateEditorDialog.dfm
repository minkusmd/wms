object frmNameTemplateEditorDlg: TfrmNameTemplateEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Template denumire'
  ClientHeight = 420
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    560
    420)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 560
    Height = 64
    Title = 'Template denumire'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 544
    Height = 298
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 43
      Height = 15
      Caption = 'Context'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 62
      Height = 15
      Caption = 'Template RO'
    end
    object Label3: TLabel
      Left = 16
      Top = 176
      Width = 62
      Height = 15
      Caption = 'Template RU'
    end
    object icbCONTEXT: TcxDBImageComboBox
      Left = 16
      Top = 29
      DataBinding.DataField = 'CONTEXT'
      Properties.Items = <
        item
          Description = 'Catalog / web'
          Value = 1
        end
        item
          Description = 'Factura'
          Value = 2
        end
        item
          Description = 'Eticheta / raft'
          Value = 3
        end>
      TabOrder = 0
      Width = 220
    end
    object mmTEMPLATE_RO: TcxDBMemo
      Left = 16
      Top = 77
      DataBinding.DataField = 'TEMPLATE_RO'
      Properties.MaxLength = 4096
      TabOrder = 1
      Height = 90
      Width = 505
    end
    object mmTEMPLATE_RU: TcxDBMemo
      Left = 16
      Top = 193
      DataBinding.DataField = 'TEMPLATE_RU'
      Properties.MaxLength = 4096
      TabOrder = 2
      Height = 90
      Width = 505
    end
  end
  object btnOk: TcxButton
    Left = 346
    Top = 379
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 442
    Top = 379
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
