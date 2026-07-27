object GoodsAnalizerDlg: TGoodsAnalizerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1085#1072#1083#1080#1079' '#1058#1086#1074#1072#1088#1072
  ClientHeight = 454
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    774
    454)
  PixelsPerInch = 96
  TextHeight = 15
  object btnOk: TButton
    Left = 570
    Top = 410
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 666
    Top = 410
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 8
    Width = 761
    Height = 385
    TabOrder = 0
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    Properties.Rotate = True
    Properties.TabPosition = tpLeft
    ClientRectBottom = 381
    ClientRectLeft = 103
    ClientRectRight = 757
    ClientRectTop = 4
    object cxTabSheet1: TcxTabSheet
      Caption = #1052#1080#1082#1088#1086' '#1089#1087#1088#1072#1074#1082#1072
      ImageIndex = 0
      OnShow = cxTabSheet1Show
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 209
        Height = 81
        Caption = #1054#1073#1097#1080#1081' '#1087#1088#1080#1093#1086#1076' '#1079#1072' '#1087#1077#1088#1080#1086#1076
        TabOrder = 0
        object cxLabel1: TcxLabel
          Left = 16
          Top = 24
          Caption = #1082#1086#1083'-'#1074#1086
          Transparent = True
        end
        object lbQtyIN: TcxLabel
          Left = 72
          Top = 24
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 121
          AnchorX = 193
        end
        object cxLabel3: TcxLabel
          Left = 16
          Top = 49
          Caption = #1089#1091#1084#1084#1072
          Transparent = True
        end
        object lbSumaIN: TcxLabel
          Left = 72
          Top = 49
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 121
          AnchorX = 193
        end
      end
      object GroupBox2: TGroupBox
        Left = 239
        Top = 16
        Width = 209
        Height = 137
        Caption = #1054#1073#1097#1080#1081' '#1087#1088#1080#1093#1086#1076' '#1079#1072' '#1087#1077#1088#1080#1086#1076
        TabOrder = 1
        object cxLabel5: TcxLabel
          Left = 16
          Top = 24
          Caption = #1082#1086#1083'-'#1074#1086
          Transparent = True
        end
        object lbQTY_OUT: TcxLabel
          Left = 88
          Top = 24
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 110
          AnchorX = 198
        end
        object cxLabel7: TcxLabel
          Left = 16
          Top = 49
          Caption = #1089#1091#1084#1084#1072' '#1074' '#1055#1062
          Transparent = True
        end
        object lbSumPriceIN: TcxLabel
          Left = 88
          Top = 49
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 110
          AnchorX = 198
        end
        object cxLabel9: TcxLabel
          Left = 16
          Top = 74
          Caption = #1089#1091#1084#1084#1072' '#1074' '#1056#1062
          Transparent = True
        end
        object lbSumPriceOUT: TcxLabel
          Left = 88
          Top = 74
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 110
          AnchorX = 198
        end
        object cxLabel11: TcxLabel
          Left = 16
          Top = 106
          Caption = #1044#1086#1093#1086#1076
          Transparent = True
        end
        object lbRevenue: TcxLabel
          Left = 88
          Top = 106
          AutoSize = False
          Caption = '0,00'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 19
          Width = 110
          AnchorX = 198
        end
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'cxTabSheet2'
      ImageIndex = 1
    end
  end
end
