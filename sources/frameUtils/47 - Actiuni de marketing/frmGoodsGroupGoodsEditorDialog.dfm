object frmGoodsGroupGoodsEditorDlg: TfrmGoodsGroupGoodsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mapa cu produse'
  ClientHeight = 342
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    464
    342)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 464
    Height = 64
    Title = 'Produs, Mapa cu produse'
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
    ImageIndex = 22
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 448
    Height = 217
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
      Left = 16
      Top = 20
      Width = 91
      Height = 15
      Caption = 'Produs sau Mapa'
    end
    object lbExistsError: TLabel
      Left = 16
      Top = 69
      Width = 182
      Height = 15
      Caption = 'Elementul selectat deja este in lista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object rgFLG_EXCLUDE: TcxDBRadioGroup
      Left = 16
      Top = 112
      Caption = #1050#1072#1090#1077#1075#1086#1088#1103
      DataBinding.DataField = 'FLG_EXCLUDE'
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Inclusiv'
          Value = 0
        end
        item
          Caption = 'Exclusiv'
          Value = 1
        end>
      TabOrder = 1
      Height = 57
      Width = 405
    end
    object beGOODSID: TcxButtonEdit
      Left = 16
      Top = 37
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGOODSIDPropertiesButtonClick
      TabOrder = 0
      Width = 405
    end
  end
  object btnCancel: TButton
    Left = 354
    Top = 300
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 250
    Top = 300
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
