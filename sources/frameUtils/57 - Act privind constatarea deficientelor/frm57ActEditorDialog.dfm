object frm57ActEditorDlg: Tfrm57ActEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1082#1090
  ClientHeight = 786
  ClientWidth = 639
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
    Width = 639
    Height = 64
    Title = #1040#1082#1090
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
    ExplicitWidth = 564
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 623
    Height = 649
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
    ExplicitWidth = 1191
    DesignSize = (
      619
      645)
    object cxLabel5: TcxLabel
      Left = 8
      Top = 20
      Caption = #8470' '#1072#1082#1090#1072
    end
    object teActNo: TcxDBTextEdit
      Left = 72
      Top = 20
      DataBinding.DataField = 'ACTNO'
      TabOrder = 1
      Width = 121
    end
    object cxLabel6: TcxLabel
      Left = 208
      Top = 20
      Caption = #1050#1086#1076' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    end
    object teIncidentID: TcxDBTextEdit
      Left = 299
      Top = 20
      DataBinding.DataField = 'INCIDENTID'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 62
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 56
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1076#1080#1072#1075#1085#1086#1089#1090#1080#1082#1080
    end
    object cxDBMemo1: TcxDBMemo
      Left = 8
      Top = 84
      DataBinding.DataField = 'DEFICIENTA'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 5
      Height = 133
      Width = 600
    end
    object cxLabel4: TcxLabel
      Left = 8
      Top = 223
      Caption = #1056#1077#1079#1086#1083#1102#1094#1080#1103
    end
    object cxDBMemo2: TcxDBMemo
      Left = 8
      Top = 248
      DataBinding.DataField = 'REZOLUTIA'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 7
      Height = 113
      Width = 600
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 375
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    end
    object cxDBMemo3: TcxDBMemo
      Left = 8
      Top = 400
      DataBinding.DataField = 'NOTA'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 9
      Height = 121
      Width = 600
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 527
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
    end
    object cxDBMemo4: TcxDBMemo
      Left = 8
      Top = 552
      DataBinding.DataField = 'Date_aditionale'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 11
      Height = 81
      Width = 600
    end
  end
  object btnOk: TButton
    Left = 424
    Top = 748
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 528
    Top = 748
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
