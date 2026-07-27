object frmWebBigBannerEditorDlg: TfrmWebBigBannerEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' '
  ClientHeight = 597
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    595
    597)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 595
    Height = 64
    Title = #1041#1086#1083#1100#1096#1086#1081' '#1073#1072#1085#1085#1077#1088' '#1085#1072' '#1075#1083#1072#1074#1085#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1077
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 579
    Height = 472
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
      Left = 20
      Top = 24
      Width = 101
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1073#1072#1085#1085#1077#1088#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 82
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076' '#1087#1086#1082#1072#1079#1072
    end
    object Label3: TLabel
      Left = 20
      Top = 82
      Width = 87
      Height = 15
      Caption = #1040#1076#1088#1077#1089' '#1087#1077#1088#1077#1093#1086#1076#1072
    end
    object SpeedButton1: TSpeedButton
      Left = 480
      Top = 104
      Width = 75
      Height = 21
      Caption = #1085#1086#1074#1086#1089#1090#1100'...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton2: TSpeedButton
      Left = 399
      Top = 104
      Width = 75
      Height = 21
      Caption = #1090#1086#1074#1072#1088#1099'...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 429
      Width = 170
      Height = 15
      Caption = #1060#1086#1088#1084#1072#1090': PNG, '#1088#1072#1079#1084#1077#1088': 525x180.'
    end
    object Label5: TLabel
      Left = 20
      Top = 152
      Width = 104
      Height = 15
      Caption = #1040#1076#1088#1077#1089' '#1074#1077#1073'-'#1089#1077#1088#1074#1080#1089#1072
    end
    object edTITLE: TcxDBTextEdit
      Left = 127
      Top = 21
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 428
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 127
      Top = 50
      DataBinding.DataField = 'START_DATE'
      TabOrder = 1
      Width = 174
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 307
      Top = 50
      DataBinding.DataField = 'END_DATE'
      TabOrder = 2
      Width = 174
    end
    object edNAV_URL: TcxDBTextEdit
      Left = 127
      Top = 79
      DataBinding.DataField = 'NAV_URL'
      TabOrder = 3
      Width = 428
    end
    object pcPageControlImages: TcxPageControl
      Left = 20
      Top = 215
      Width = 535
      Height = 212
      TabOrder = 4
      Properties.ActivePage = tbsBackImage
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 208
      ClientRectLeft = 4
      ClientRectRight = 531
      ClientRectTop = 26
      object tbsBackImage: TcxTabSheet
        Caption = #1050#1072#1088#1090#1080#1085#1082#1072' '#1092#1086#1085#1072
        ImageIndex = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imgIMAGE_BG: TcxImage
          Left = 0
          Top = 0
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.OnChange = imgIMAGE_BGPropertiesChange
          TabOrder = 0
          Height = 180
          Width = 525
        end
      end
      object tbsImageRO: TcxTabSheet
        Caption = #1050#1072#1088#1090#1080#1085#1082#1072' RO'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imgIMAGE_BG_RO: TcxImage
          Left = 0
          Top = 0
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          TabOrder = 1
          Height = 180
          Width = 525
        end
        object imgIMAGE_RO: TcxImage
          Left = 0
          Top = 0
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.OnChange = imgIMAGE_ROPropertiesChange
          TabOrder = 0
          Transparent = True
          Height = 180
          Width = 525
        end
      end
      object tbsImageRU: TcxTabSheet
        Caption = #1050#1072#1088#1090#1080#1085#1082#1072' RU'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imgIMAGE_BG_RU: TcxImage
          Left = 0
          Top = 0
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          TabOrder = 1
          Height = 180
          Width = 525
        end
        object imgIMAGE_RU: TcxImage
          Left = 0
          Top = 0
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.OnChange = imgIMAGE_RUPropertiesChange
          TabOrder = 0
          Transparent = True
          Height = 180
          Width = 525
        end
      end
    end
    object cbFLG_IMAGES_URL: TcxDBCheckBox
      Left = 20
      Top = 120
      Caption = #1050#1072#1088#1090#1080#1085#1082#1072' RO '#1080' RU '#1080#1079' '#1074#1077#1073'-'#1089#1077#1088#1074#1080#1089#1072
      DataBinding.DataField = 'FLG_IMAGES_URL'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnChange = cbFLG_IMAGES_URLPropertiesChange
      TabOrder = 5
    end
    object edIMAGES_URL: TcxDBTextEdit
      Left = 127
      Top = 149
      DataBinding.DataField = 'IMAGES_URL'
      TabOrder = 6
      Width = 428
    end
  end
  object btnOk: TButton
    Left = 380
    Top = 555
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 484
    Top = 555
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
