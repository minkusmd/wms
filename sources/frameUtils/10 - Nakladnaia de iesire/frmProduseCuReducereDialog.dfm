object frmProduseCuReducereDlg: TfrmProduseCuReducereDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Reduceri'
  ClientHeight = 432
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    545
    432)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 545
    Height = 64
    Title = 'Coduri de reducere'
    Text = 'Managementul codurilor de reducere'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clBlue
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object btnYes: TButton
    Left = 260
    Top = 384
    Width = 164
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Aplica codul de reducere'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 438
    Top = 384
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object Notebook: TNotebook
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 529
    Height = 297
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 3
    object TPage
      Left = 0
      Top = 0
      Caption = 'Default'
      object pnClient: TPanel
        Left = 0
        Top = 0
        Width = 529
        Height = 297
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 20
          Width = 21
          Height = 15
          Caption = 'Cod'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 20
          Top = 41
          Width = 255
          Height = 15
          Caption = 'Introduceri codul de reducere din SMS-ul primit.'
        end
        object Label3: TLabel
          Left = 20
          Top = 80
          Width = 44
          Height = 15
          Caption = 'Validare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edCODE: TcxTextEdit
          Left = 284
          Top = 36
          ParentFont = False
          Properties.CharCase = ecUpperCase
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          TabOrder = 0
          Text = 'XXX-XXX-XXX'
          Width = 129
        end
        object btnCheckCode: TButton
          Left = 419
          Top = 36
          Width = 85
          Height = 28
          Caption = 'Verifica'
          Default = True
          TabOrder = 1
          OnClick = btnCheckCodeClick
        end
        object mmInfo: TcxMemo
          Left = 20
          Top = 97
          ParentFont = False
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Height = 168
          Width = 484
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Finish'
      object pnFinish: TPanel
        Left = 0
        Top = 0
        Width = 529
        Height = 297
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        ShowCaption = False
        TabOrder = 0
        object Label5: TLabel
          Left = 20
          Top = 24
          Width = 143
          Height = 17
          Caption = #1044#1072#1083#1100#1085#1077#1081#1096#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 20
          Top = 45
          Width = 420
          Height = 34
          Caption = 
            '1. '#1062#1077#1085#1072' '#1074#1089#1077#1093' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1088#1072#1089#1093#1086#1076#1072' '#1073#1091#1076#1077#1090' '#1080#1079#1084#1077#1085#1077#1085#1072' '#1087#1086' '#1087#1077#1088#1074#1086#1081' '#1082#1086#1083#1086#1085#1082#1080 +
            ';'#13'2. '#1041#1091#1076#1077#1090' '#1076#1086#1073#1072#1074#1083#1077#1085' '#1085#1086#1074#1099#1081' '#1090#1086#1074#1072#1088' '#1089' '#1088#1072#1079#1084#1077#1088#1086#1084' '#1089#1082#1080#1076#1082#1080'.'
        end
        object Label7: TLabel
          Left = 20
          Top = 123
          Width = 95
          Height = 20
          Caption = #1047#1072#1087#1088#1077#1097#1072#1077#1090#1089#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 20
          Top = 149
          Width = 177
          Height = 51
          Caption = 
            '1. '#1048#1079#1084#1077#1085#1103#1090#1100' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072';'#13'2. '#1048#1079#1084#1077#1085#1103#1090#1100' '#1089#1086#1089#1090#1072#1074' '#1088#1072#1089#1089#1093#1086#1076#1072'.'#13'3. '#1042#1089#1103#1082#1072#1103' ' +
            #1089#1072#1084#1086#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1100'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
end
