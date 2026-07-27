object frmCustomerPhonesEditorDialog: TfrmCustomerPhonesEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Comunicarea cu clientii'
  ClientHeight = 341
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 484
    Height = 64
    Title = 'Moduri de comunicare cu clientii'
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
    ImageIndex = 3
  end
  object cxButton1: TcxButton
    Left = 134
    Top = 300
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 230
    Top = 300
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 468
    Height = 198
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
    object cxLabel1: TcxLabel
      Left = 8
      Top = 24
      Caption = 'Tip numar telefon'
      TabOrder = 1
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 56
      Caption = 'Numar telefon'
      TabOrder = 2
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 87
      Caption = 'Note'
      TabOrder = 5
    end
    object beCustomerComunicationType: TcxButtonEdit
      Left = 111
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beCustomerComunicationTypePropertiesButtonClick
      TabOrder = 0
      Text = 'beCustomerComunicationType'
      Width = 345
    end
    object meNotes: TcxDBMemo
      Left = 111
      Top = 86
      DataBinding.DataField = 'COMMENT'
      TabOrder = 4
      Height = 42
      Width = 345
    end
    object tePhoneNumber: TcxDBMaskEdit
      Left = 115
      Top = 57
      DataBinding.DataField = 'PHONENUMBER'
      Properties.EditMask = '!\(999\)000-000;0;_'
      TabOrder = 3
      Width = 121
    end
    object cbFLG_SMS: TcxDBCheckBox
      Left = 104
      Top = 134
      Caption = 'Notificare prin SMS la acest numar'
      DataBinding.DataField = 'FLG_SMS'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      TabOrder = 6
    end
  end
end
