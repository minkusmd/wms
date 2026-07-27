object frmWebUrlsEditorDialog: TfrmWebUrlsEditorDialog
  Left = 0
  Top = 0
  Caption = 'Editor Seo URL'
  ClientHeight = 386
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    678
    386)
  PixelsPerInch = 96
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 678
    Height = 64
    Title = 'Editare URL'
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
    ImageIndex = 30
    ExplicitLeft = 344
    ExplicitTop = 248
    ExplicitWidth = 0
  end
  object Button1: TButton
    Left = 454
    Top = 349
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 559
    Top = 349
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 657
    Height = 259
    BevelOuter = bvLowered
    Color = clWindow
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 21
      Height = 13
      Caption = 'Cod'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 69
      Width = 55
      Height = 13
      Caption = 'Denumire'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 117
      Width = 46
      Height = 13
      Caption = 'Seo URL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 163
      Width = 22
      Height = 13
      Caption = 'URL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 16
      Top = 40
      DataBinding.DataField = 'URL_ID'
      TabOrder = 0
      Width = 121
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 16
      Top = 88
      DataBinding.DataField = 'TITLE'
      TabOrder = 1
      Width = 625
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 16
      Top = 136
      DataBinding.DataField = 'HUMAN_URL'
      TabOrder = 2
      Width = 625
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 16
      Top = 216
      Caption = 'URL activ'
      DataBinding.DataField = 'FLG_ACTIVE'
      TabOrder = 3
    end
    object cxDBTextEdit4: TcxDBTextEdit
      Left = 16
      Top = 179
      DataBinding.DataField = 'URL'
      TabOrder = 4
      Width = 625
    end
  end
end
