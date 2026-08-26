object frmDistributieRambursEditorDlg: TfrmDistributieRambursEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Distribuirea rambursului'
  ClientHeight = 345
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    556
    345)
  TextHeight = 15
  object cxButton1: TcxButton
    Left = 329
    Top = 308
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 433
    Top = 308
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
    Top = 8
    Width = 537
    Height = 276
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 112
      Width = 68
      Height = 15
      Caption = 'Doc referinta'
      Transparent = True
    end
    object lbContractTitle: TLabel
      Left = 8
      Top = 41
      Width = 46
      Height = 15
      Caption = 'Contract'
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 16
      Caption = 'Cumparator'
      TabOrder = 1
    end
    object cxLabel5: TcxLabel
      Left = 8
      Top = 230
      Caption = 'Comision'
      TabOrder = 3
    end
    object cxLabel4: TcxLabel
      Left = 8
      Top = 205
      Caption = 'Pret livrare'
      TabOrder = 6
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 182
      Caption = 'Suma'
      TabOrder = 8
    end
    object ceComision: TcxDBCalcEdit
      Left = 107
      Top = 235
      DataBinding.DataField = 'COMISION'
      TabOrder = 12
      Width = 121
    end
    object cePretLivrare: TcxDBCalcEdit
      Left = 107
      Top = 208
      DataBinding.DataField = 'pret_livrare'
      TabOrder = 9
      Width = 121
    end
    object ceRamburs: TcxDBCalcEdit
      Left = 107
      Top = 181
      DataBinding.DataField = 'RAMBURS'
      TabOrder = 7
      Width = 121
    end
    object beCustomer: TcxButtonEdit
      Left = 107
      Top = 15
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ClickKey = 115
      Properties.OnButtonClick = beCustomerPropertiesButtonClick
      TabOrder = 0
      Text = 'beCustomer'
      Width = 414
    end
    object beContract: TcxButtonEdit
      Left = 107
      Top = 42
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beContractPropertiesButtonClick
      TabOrder = 2
      Width = 414
    end
    object lbContractInfo: TcxLabel
      Left = 107
      Top = 72
      AutoSize = False
      Caption = 'lbContractInfo'
      Style.TextStyle = [fsBold]
      TabOrder = 10
      Visible = False
      Height = 28
      Width = 414
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 136
      Caption = 'AWB:'
      TabOrder = 11
    end
    object beAWB: TcxDBButtonEdit
      Left = 107
      Top = 135
      DataBinding.DataField = 'AWB'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ClickKey = 115
      Properties.OnButtonClick = beAWBPropertiesButtonClick
      TabOrder = 5
      Width = 414
    end
    object beRefererDoc: TcxDBButtonEdit
      Left = 107
      Top = 106
      DataBinding.DataField = 'REFERER_DOCID'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beRefererDocPropertiesButtonClick
      TabOrder = 4
      Width = 123
    end
  end
end
