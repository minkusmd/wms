object frmCustomerEMailEditorDialog: TfrmCustomerEMailEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clienti, EMail-uri'
  ClientHeight = 232
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    472
    232)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 472
    Height = 64
    Title = 'Gestiune clienti - EMail-uri'
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
    Left = 265
    Top = 195
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 162
  end
  object cxButton2: TcxButton
    Left = 361
    Top = 195
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 162
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 456
    Height = 98
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
    ExplicitHeight = 65
    object cxLabel1: TcxLabel
      Left = 4
      Top = 15
      Caption = 'Email'
    end
    object teEMail: TcxDBMaskEdit
      Left = 111
      Top = 14
      DataBinding.DataField = 'EMAIL'
      TabOrder = 0
      Width = 330
    end
    object cbUnsubscribed: TcxDBCheckBox
      Left = 111
      Top = 43
      Caption = 'Unsubscribed'
      DataBinding.DataField = 'UNSUBSCRIBED'
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      TabOrder = 2
    end
  end
end
