object frmMoneyTransferToUserDlg: TfrmMoneyTransferToUserDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Transfer mijloace banesti catre alt utilizator'
  ClientHeight = 505
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    517
    505)
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 501
    Height = 429
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
    TabOrder = 0
    ExplicitWidth = 503
    ExplicitHeight = 434
    object cxLabel1: TLabel
      Left = 144
      Top = 180
      Width = 32
      Height = 15
      Caption = 'Valuta'
    end
    object cxLabel2: TLabel
      Left = 32
      Top = 181
      Width = 30
      Height = 15
      Caption = 'Suma'
    end
    object Label4: TLabel
      Left = 501
      Top = 10
      Width = 107
      Height = 15
      Caption = 'Calculator bancnote'
    end
    object sbOpenCalc: TSpeedButton
      Left = 320
      Top = 192
      Width = 161
      Height = 29
      Caption = 'Calculator bancnote >>'
      OnClick = sbOpenCalcClick
    end
    object Label5: TLabel
      Left = 37
      Top = 339
      Width = 63
      Height = 15
      Caption = 'Comentariu'
    end
    object Label7: TLabel
      Left = 37
      Top = 284
      Width = 79
      Height = 15
      Caption = 'Transmis prin...'
    end
    object Label8: TLabel
      Left = 144
      Top = 237
      Width = 237
      Height = 15
      Caption = 'Documentul in baza caruita se transfera banii'
    end
    inline frameMoneyCounter: TframeMoneyCounter
      Left = 501
      Top = 36
      Width = 300
      Height = 246
      Constraints.MaxHeight = 246
      Constraints.MaxWidth = 300
      Constraints.MinHeight = 246
      Constraints.MinWidth = 300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 501
      ExplicitTop = 36
      inherited cxGridBanknotes: TcxGrid
        ExplicitLeft = 8
        ExplicitTop = -32
        inherited cxGridBanknotesTable: TcxGridTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0'
              Kind = skSum
              Column = frameMoneyCounter.cxGridBanknotesTableCol3
            end
            item
              Format = '0'
              Kind = skSum
              Column = frameMoneyCounter.cxGridBanknotesTableCol2
            end>
          inherited cxGridBanknotesTableCol3: TcxGridColumn
            Caption = 'Suma'
          end
        end
      end
    end
    object cmbCURRENCY: TcxLookupComboBox
      Left = 144
      Top = 198
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      EditValue = -1
      TabOrder = 4
      Width = 81
    end
    object edSuma: TEdit
      Left = 32
      Top = 198
      Width = 97
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Text = '0'
    end
    object cbFLG_ACNT: TCheckBox
      Left = 35
      Top = 232
      Width = 84
      Height = 17
      Caption = 'Banca'
      TabOrder = 5
    end
    object mmComments: TcxMemo
      Left = 32
      Top = 360
      Properties.VisibleLineCount = 3
      TabOrder = 10
      Width = 449
    end
    object cxButton1: TcxButton
      Left = 688
      Top = 293
      Width = 113
      Height = 29
      Caption = 'Tipar'
      TabOrder = 8
      OnClick = cxButton1Click
    end
    object cxGroupBox1: TcxGroupBox
      Left = 16
      Top = 10
      Caption = 'Expeditor'
      TabOrder = 0
      Height = 68
      Width = 474
      object Label1: TLabel
        Left = 16
        Top = 20
        Width = 47
        Height = 15
        Caption = 'Utilizator'
      end
      object Label2: TLabel
        Left = 224
        Top = 15
        Width = 73
        Height = 15
        Caption = 'Subdiviziunea'
      end
      object edUserName: TcxTextEdit
        Left = 16
        Top = 36
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 193
      end
      object edFirmaName: TcxTextEdit
        Left = 224
        Top = 36
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 1
        Width = 241
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 16
      Top = 89
      Caption = 'Destinatar'
      TabOrder = 2
      Height = 80
      Width = 474
      object Label6: TLabel
        Left = 16
        Top = 24
        Width = 47
        Height = 15
        Caption = 'Utilizator'
      end
      object Label3: TLabel
        Left = 224
        Top = 24
        Width = 73
        Height = 15
        Caption = 'Subdiviziunea'
      end
      object cmbUserName: TcxLookupComboBox
        Left = 16
        Top = 45
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'USERID'
        Properties.ListColumns = <
          item
            FieldName = 'USER_FULLNAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceUsers
        Properties.OnEditValueChanged = cmbUserNamePropertiesEditValueChanged
        EditValue = -1
        TabOrder = 0
        Width = 193
      end
      object clbFirme: TcxLookupComboBox
        Left = 224
        Top = 45
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'CUSTOMERID'
        Properties.ListColumns = <
          item
            FieldName = 'DISPLAYNAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceFirme
        EditValue = -1
        TabOrder = 1
        Width = 241
      end
    end
    object cbLivrare: TcxCheckBox
      Left = 33
      Top = 247
      Caption = 'Livrare'
      Properties.OnEditValueChanged = cbLivrarePropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
    end
    object beTRANSFERAT_PRIN: TcxButtonEdit
      Left = 32
      Top = 303
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
        end
        item
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000002C744558745469746C6500437573746F6D6572733B437573746F6D65
            7273566965773B56696577437573746F6D6572733B383D6F98000000A5494441
            54785EADD33D0AC2401040E1B9807A0F2B4969ED01ACE24D3C8968AB8588E428
            E2092CEC167F10EC8C2932BE626CC2BAD9C5141F0C0C3C98624455FFD26D60BE
            5B7DF5B184C3030BF420880A6CA10DEB9440E509BC52024F4FE09E12283C817D
            4A206B9C51218B0E981CCECC20B1811C179B074670C5B42D30C21B0A416D046A
            BB612850408DFC9837A1C02D22E0428133B4C5291498E088D2132871C0B8D36F
            FC0041849FE867A38B1F0000000049454E44AE426082}
          Kind = bkGlyph
        end
        item
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000012744558745469746C650044726976696E673B4361723BB6E3D4C500
            00005C49444154785EDDD3310E00210844512EC8A5F6547B3BB43001F28909B1
            3116530D3C6914333BCA85807EBFCE5895D52500CB1C64B7017CB90022928178
            269681F82C8046004878BD06D90B805E1C70A41102E717E4B20E81073ED30073
            329CB7B98D48A40000000049454E44AE426082}
          Kind = bkGlyph
        end
        item
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C0000001B744558745469746C65005472616E7369743B4175746F
            3B4361723B4275733BC9635F1F0000020B49444154785E75903D6B544114869F
            BBBB6C4C844854928898900862214431DA088236368285A585652C2C2DC45FA0
            A80822585949C0DEC24E116C228AA2F881444C8C9104F34594BD9B3BE7431C86
            61A378E17066E6CEFBCC79DF0650BC7B70FE644F77F36ABDC638FFF9BC63216A
            2F7FB6AACB07CFDD7FDC006A4D64B26FEFF181AD83C3E0FE8FB453EDC0AF85D9
            C3F2F6C924B03B02D6E6E607F61C29B974FD05AF3F1321EE069E44189ECEC646
            0A6E4EF4B23233DF0FD41A00A11DB0728DA5561FC78E0EA6CB1E41967B84F0F5
            CB3CDA5EA12A37008A988104C535D0552F08A1C22DBD98CB308B9D7A43310948
            3032408361224C7F7A45BB1CA16B4B37CD66937ABD115F0E55C546BBA42C5B7C
            FF3683CB4E540C803481E15AB1BAB488864051902CA4D8487B9CF5D5655C7AD1
            A0D9022A8A850A910A09154440549111D10A88044C2A4474B3050F217A530964
            599A82BC07D180853F659B4334AD38345AE3C342A0003C8D5D904D0005E32335
            5CAABF42148BAFDFB9B02B8F0A9EA728B205077A7009A87A0E110D16A93B4EDD
            0660E9D1C54DC17982F69FBE0BC08F871398745830315C04006C195749622075
            B0FCDF54D04E80AAE11A787EEB6C140C8F6E27A5004E064DDD3843010C8DF661
            9A01D8CCEC2AF7AE3D83E43DDD4F613AE40C2327AF016D00ED2B53CBBDFB0E9C
            583733A6DF3FDD0FD45215A93C79D0C1A1B18FEECEE2DC9B6D40FB37BCA39308
            EE3C64330000000049454E44AE426082}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCT_NAMEPropertiesButtonClick
      TabOrder = 9
      Width = 447
    end
    object teForDocument: TcxTextEdit
      Left = 144
      Top = 255
      TabOrder = 7
      Width = 81
    end
  end
  object btnCancel: TcxButton
    Left = 396
    Top = 461
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
    ExplicitLeft = 398
    ExplicitTop = 466
  end
  object btnOk: TcxButton
    Left = 288
    Top = 461
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOkClick
    ExplicitLeft = 290
    ExplicitTop = 466
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM'
      ' GET_USERS_BY_USER2(:ShowCurrentUser)'
      'ORDER BY'
      ' USER_FULLNAME')
    Left = 352
    Top = 53
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShowCurrentUser'
        Value = nil
      end>
  end
  object IBCDataSourceUsers: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryUsers
    Left = 352
    Top = 5
  end
  object IBCQueryFirme: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_FIRMS_BY_USER(:USERID)'
      'ORDER BY'
      ' DISPLAYNAME')
    Left = 468
    Top = 57
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourceFirme: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryFirme
    Left = 468
    Top = 9
  end
  object dxComponentPrinter1: TdxComponentPrinter
    CurrentLink = dxComponentPrinter1Link1
    Version = 0
    Left = 344
    Top = 120
    PixelsPerInch = 96
    object dxComponentPrinter1Link1: TdxGridReportLink
      Active = True
      Component = frameMoneyCounter.cxGridBanknotes
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageHeader.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageHeader.LeftTitle.Strings = (
        '')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 45555.292664212960000000
      TimeFormat = 0
      OptionsOnEveryPage.FilterBar = False
      OptionsView.FilterBar = False
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
end
