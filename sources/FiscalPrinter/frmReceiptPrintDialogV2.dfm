object frmReceiptPrintV2Dlg: TfrmReceiptPrintV2Dlg
  Left = 0
  Top = 0
  ActiveControl = cxPageControl
  BorderStyle = bsDialog
  Caption = 'Bonuri fiscale'
  ClientHeight = 449
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 650
    Height = 64
    Title = 'Tiparul bonului fiscal'
    Text = 'Tiparul bonului fiscal'
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
    ImageIndex = 26
  end
  object cxPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 634
    Height = 325
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsReceipt
    Align = alTop
    TabOrder = 1
    object tbsInfo: TTabSheet
      Caption = 'Imprimanta fiscala'
      ImageIndex = 2
      object lbPrinterInfo: TLabel
        AlignWithMargins = True
        Left = 145
        Top = 16
        Width = 3
        Height = 15
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
      end
      object lbInfo1: TLabel
        Left = 16
        Top = 44
        Width = 97
        Height = 15
        Caption = 'identificator fiscal:'
      end
      object lbIDEN: TLabel
        Left = 145
        Top = 44
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbInfo2: TLabel
        Left = 16
        Top = 72
        Width = 128
        Height = 15
        Caption = 'numar de la inspectorat:'
      end
      object lbVAT: TLabel
        Left = 145
        Top = 72
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 101
        Height = 15
        Caption = 'Imprimanta fiscala:'
      end
      object Label10: TLabel
        Left = 16
        Top = 102
        Width = 73
        Height = 15
        Caption = 'Data si timpul'
      end
      object lbFP_DateTime: TLabel
        Left = 145
        Top = 102
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbFPDateTimeWarning: TLabel
        Left = 16
        Top = 128
        Width = 577
        Height = 37
        AutoSize = False
        Caption = 
          'Atentie ! Timpul la MCC difera de timpul la PC. Intrati in meniu' +
          'l functiilor de service pentru a corecta data si timpul. '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lbInvalidTVAGroup: TLabel
        Left = 16
        Top = 177
        Width = 359
        Height = 30
        Caption = 
          'Atentie! Valoare incorecta pentru grupa fiscala A. Corectati ime' +
          'diat!!!'#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object tbsGoods: TTabSheet
      Caption = 'Lista produse'
      object lbPriceZeroWarning: TLabel
        Left = 12
        Top = 250
        Width = 375
        Height = 30
        Caption = 
          'Eroare!!! Unul din produse are pretul = 0! Tiparul cecului nu es' +
          'te posibil!'#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object cxGrid: TcxGrid
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 602
        Height = 217
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 12
        Align = alTop
        TabOrder = 0
        object cxGridTable: TcxGridTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              Column = cxGridTable_SUMA
            end>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridTable_NO: TcxGridColumn
            Caption = #8470
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridTable_GOODSID: TcxGridColumn
            Caption = 'Cod'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridTable_TITLE: TcxGridColumn
            Caption = 'Denumire'
          end
          object cxGridTable_QTY: TcxGridColumn
            Caption = 'Cant'
            DataBinding.ValueType = 'Float'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_Bold
            Width = 50
          end
          object cxGridTable_RPICE: TcxGridColumn
            Caption = 'Pret'
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '#,##0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridTable_SUMA: TcxGridColumn
            Caption = 'Suma'
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '#,##0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_Bold
            Width = 80
          end
          object cxGridTable_SumaTVA: TcxGridColumn
            Caption = 'TVA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 42
            Options.HorzSizing = False
            Width = 42
          end
          object cxGridTable_TVA: TcxGridColumn
            Caption = 'TVA, %'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
      object btnNextToReceipt: TcxButton
        Left = 527
        Top = 244
        Width = 90
        Height = 29
        Caption = 'Inainte >>'
        Default = True
        TabOrder = 1
        OnClick = btnNextToReceiptClick
      end
    end
    object tbsPrihodSceot: TTabSheet
      Caption = 'Documente'
      ImageIndex = 6
      object Label8: TLabel
        Left = 3
        Top = 157
        Width = 71
        Height = 15
        Caption = 'Factra fiscala'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 3
        Top = 21
        Width = 146
        Height = 15
        Caption = 'Intrare mijloace financiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lcbFacturaSelect: TcxLookupComboBox
        Left = 176
        Top = 208
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'DOCID'
        Properties.ListColumns = <
          item
            Caption = 'Denumire'
            Width = 300
            FieldName = 'FULL_TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceFactura
        EditValue = -1
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 413
      end
      object Panel2: TPanel
        Left = 20
        Top = 178
        Width = 146
        Height = 68
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 4
        object rbCreateSF: TRadioButton
          Left = 0
          Top = 7
          Width = 141
          Height = 17
          Caption = 'Factura fiscala noua'
          TabOrder = 0
          OnClick = rbUseExistingSFClick
        end
        object rbUseExistingSF: TRadioButton
          Left = 0
          Top = 38
          Width = 142
          Height = 17
          Caption = 'Factura fiscala existenta'
          TabOrder = 1
          OnClick = rbUseExistingSFClick
        end
      end
      object cbDocsChecked: TCheckBox
        Left = 372
        Top = 260
        Width = 133
        Height = 17
        Caption = 'Totul este corect!'
        TabOrder = 6
        OnEnter = cbDocsCheckedEnter
      end
      object rbCreateПКО: TRadioButton
        Left = 20
        Top = 42
        Width = 337
        Height = 17
        Caption = 'Nou! Ordin de incasare prin numerar'
        Enabled = False
        TabOrder = 0
        OnClick = rbCreateПКОClick
      end
      object rbUseExistingDocument: TRadioButton
        Left = 20
        Top = 92
        Width = 150
        Height = 17
        Caption = 'Document existent'
        TabOrder = 3
        OnClick = rbCreateПКОClick
      end
      object lcbExistingDocumentSelector: TcxLookupComboBox
        Left = 176
        Top = 92
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.DropDownWidth = 600
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'DOCID'
        Properties.ListColumns = <
          item
            Caption = 'Client'
            Width = 200
            FieldName = 'FULL_TITLE'
          end
          item
            Caption = 'Tip document'
            Fixed = True
            HeaderAlignment = taCenter
            Width = 150
            FieldName = 'DOCTYPE_CODE'
          end>
        Properties.ListSource = IBCDataSourcePKO
        EditValue = -1
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Width = 413
      end
      object rbCreateПДНС: TRadioButton
        Left = 20
        Top = 65
        Width = 461
        Height = 21
        Caption = 
          'Nou! Ordin de incasare bancar (Carduri bancare Visa, MasterCard,' +
          ' AMExpress)'
        TabOrder = 1
        OnClick = rbCreateПКОClick
      end
      object btnCheckDocs: TcxButton
        Left = 499
        Top = 252
        Width = 90
        Height = 29
        Caption = 'Inainte >>'
        Default = True
        TabOrder = 7
        OnClick = btnCheckDocsClick
      end
      object RadioButton1: TRadioButton
        Left = 20
        Top = 126
        Width = 337
        Height = 17
        Caption = 'Nou! Ordin de incasare prin numerar prin MIA'
        Enabled = False
        TabOrder = 8
        OnClick = rbCreateПКОClick
      end
    end
    object tbsReceipt: TTabSheet
      Caption = 'Cec fiscal'
      ImageIndex = 1
      object Label9: TLabel
        Left = 240
        Top = 120
        Width = 72
        Height = 15
        Caption = 'Suma partiala'
      end
      object Label12: TLabel
        Left = 16
        Top = 16
        Width = 49
        Height = 15
        Caption = 'Tip client'
      end
      object Label13: TLabel
        Left = 16
        Top = 70
        Width = 96
        Height = 15
        Caption = 'Modul de achitare'
      end
      object Label2: TLabel
        Left = 240
        Top = 16
        Width = 38
        Height = 15
        Caption = 'Tip cec'
      end
      object lbMaxSuma: TLabel
        Left = 16
        Top = 172
        Width = 548
        Height = 30
        Caption = 
          'Pentru documentul dat a fost eliberat cec in suma de %f lei. Sum' +
          'a restanta pentru achizitie este de %f lei'#13#10
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbCustomerVAT: TLabel
        Left = 512
        Top = 79
        Width = 82
        Height = 15
        Caption = 'lbCustomerVAT'
      end
      object Label6: TLabel
        Left = 240
        Top = 72
        Width = 147
        Height = 15
        Caption = 'Denumire pentru cec partial'
      end
      object cmbFR_PersoanaType: TComboBox
        Left = 16
        Top = 32
        Width = 156
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = 'Peroana fizica'
        Items.Strings = (
          'Peroana fizica'
          'Persoana juridica')
      end
      object cmbFR_PaymentType: TComboBox
        Left = 16
        Top = 88
        Width = 156
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Items.Strings = (
          'Numerar'
          'Card Bancar'
          'Credit'
          'MIA QR')
      end
      object cmbCekType: TComboBox
        Left = 240
        Top = 37
        Width = 156
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'Cec pe toata suma comparaturii'
        OnClick = cmbCekTypeClick
        Items.Strings = (
          'Cec pe toata suma comparaturii'
          'Cec cu achitare partiala')
      end
      object edPaySuma: TEdit
        Left = 240
        Top = 136
        Width = 156
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object btnPrintReceipt: TcxButton
        Left = 492
        Top = 32
        Width = 118
        Height = 41
        Caption = 'Tipar cec'
        Default = True
        TabOrder = 1
        OnClick = btnPrintReceiptClick
      end
      object cmbHalfReceipeText: TcxComboBox
        Left = 236
        Top = 92
        Properties.Items.Strings = (
          'Avans'
          'Servicii')
        TabOrder = 5
        Width = 160
      end
    end
    object tbsReceiptSummary: TTabSheet
      Caption = 'Cecuri eliberate'
      ImageIndex = 4
      object lbReceiptSummaryInfo: TLabel
        Left = 12
        Top = 16
        Width = 593
        Height = 25
        AutoSize = False
        Caption = 
          'Tiparul ceculul e finisat! Inminati cecul clientului si multumit' +
          'ii pentru cumparatura!'#13#10#13#10
        Color = 11598333
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 12
        Top = 67
        Width = 121
        Height = 15
        Caption = 'Lista cecurilor eliberate'
      end
      object cxGridReceipts: TcxGrid
        Left = 12
        Top = 84
        Width = 602
        Height = 137
        TabOrder = 0
        object cxGridTableViewR: TcxGridTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Column = cxGridTableViewR_Col3
            end>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.OnGetContentStyle = cxGridTableViewRStylesGetContentStyle
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridTableViewR_Col0: TcxGridColumn
            Caption = 'Cec'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = '####0000'
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridTableViewR_Col1: TcxGridColumn
            Caption = 'Data si timpul'
            DataBinding.ValueType = 'DateTime'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            OnGetDisplayText = cxGridTableViewR_Col1GetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 110
            Options.HorzSizing = False
            Width = 110
          end
          object cxGridTableViewR_Col2: TcxGridColumn
            Caption = 'Tipul achitarii'
          end
          object cxGridTableViewR_Col3: TcxGridColumn
            Caption = 'Suma'
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '#,##0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_Bold
            Width = 80
          end
          object cxGridTableViewR_Col4: TcxGridColumn
            DataBinding.ValueType = 'Boolean'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTableViewR_Col5: TcxGridColumn
            Caption = 'Eliberat de...'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 90
            Options.HorzSizing = False
            Width = 90
          end
        end
        object cxGridLevelR: TcxGridLevel
          GridView = cxGridTableViewR
        end
      end
      object btnOpenTill: TcxButton
        Left = 496
        Top = 235
        Width = 118
        Height = 36
        Caption = 'Caseta de bani'
        Default = True
        TabOrder = 1
        OnClick = btnOpenTillClick
      end
    end
    object tbsError: TTabSheet
      Caption = 'Erori ale printerului fiscal'
      ImageIndex = 3
      object Label11: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 16
        Width = 610
        Height = 60
        Margins.Left = 8
        Margins.Top = 16
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alTop
        Caption = 
          'Daca a parvenit o eroare in timpul tiparului cecului si cecul nu' +
          ' s-a tiparit cu succes , incercati sa anultat ultima operatie. D' +
          'aca Renuntaa cecului a fost cu success, atunci primul cec va fi ' +
          'nevalid. Pentru verificarea factului anularii , verificati cecul' +
          ', pe el trebuie sa fie inregistrarea "BON ANULAT"!'#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 608
      end
      object mmErrors: TMemo
        Left = 8
        Top = 97
        Width = 477
        Height = 108
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WantReturns = False
      end
      object btnAbortReceipt: TcxButton
        Left = 496
        Top = 97
        Width = 118
        Height = 32
        Caption = 'Anuleaza ultimul cec'
        TabOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnAbortReceiptClick
      end
    end
    object tbsPrintProgress: TTabSheet
      Caption = 'Tipar'
      ImageIndex = 5
      object Label1: TLabel
        Left = 28
        Top = 36
        Width = 194
        Height = 16
        Caption = 'Se tipareste bonul fiscal (cec)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 28
        Top = 76
        Width = 565
        Height = 57
        AutoSize = False
        Caption = 
          'Asteptati pina cind bonul fiscal se fa tipari. In timpul tiparul' +
          'ui este interzis deconectarea imprimantei, deschiderea imprimant' +
          'ei, sau efectuarea altor actiuni, ca ar putea opri/anula tiparul' +
          '.'#13#10#13#10
        WordWrap = True
      end
    end
  end
  object btnClose: TcxButton
    Left = 539
    Top = 412
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryPKO: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT first 5'
      ' DOCID, DATA,'
      
        ' DOCID ||'#39' | '#39'|| LPAD( EXTRACT( YEAR FROM DATA ), 4, '#39'0'#39' ) ||'#39'.'#39 +
        '||'
      '          LPAD( EXTRACT( MONTH FROM DATA ), 2, '#39'0'#39' ) ||'#39'.'#39'||'
      '          LPAD( EXTRACT( DAY FROM DATA ), 2, '#39'0'#39' ) || '#39' '#39' ||'
      '          LPAD( EXTRACT( HOUR FROM DATA), 2, '#39'0'#39' ) ||'#39':'#39'||'
      
        '          LPAD( EXTRACT( MINUTE FROM DATA ), 2, '#39'0'#39' )|| '#39' - ('#39' |' +
        '|'
      
        '          ROUND(SUMA) || '#39' MDL)'#39' || IIF(FLG_ACNT=1,'#39' prin MCC.'#39',' +
        #39#39')  FULL_TITLE,'
      ' IIF(DOCTYPEID=116,'#39'OIC'#39','#39'OIB'#39') DOCTYPE_CODE'
      'FROM VW_TDB_DOCS '
      'WHERE (DOCTYPEID=116 OR DOCTYPEID=120) '
      '  AND (DT=:DT) '
      '  AND (CT=:CT) '
      '  AND ((current_date - 240) <= DATA) '
      '--  AND (DTSC <> 5114) '
      'ORDER BY DATA DESC')
    Left = 24
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCDataSourcePKO: TIBCDataSource
    DataSet = IBCQueryPKO
    Left = 24
    Top = 292
  end
  object IBCQueryFactura: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' DOCID,'
      
        ' DOCID ||'#39' | '#39'||LPAD( EXTRACT( YEAR FROM DATA ), 4, '#39'0'#39' ) ||'#39'.'#39'|' +
        '|'
      '          LPAD( EXTRACT( MONTH FROM DATA ), 2, '#39'0'#39' ) ||'#39'.'#39'||'
      '          LPAD( EXTRACT( DAY FROM DATA ), 2, '#39'0'#39' ) || '#39' '#39' ||'
      '          LPAD( EXTRACT( HOUR FROM DATA), 2, '#39'0'#39' ) ||'#39':'#39'||'
      
        '          LPAD( EXTRACT( MINUTE FROM DATA ), 2, '#39'0'#39' )|| '#39' - )'#39' |' +
        '|'
      
        '          ROUND(SUMA) || '#39' MDL)'#39' || IIF(FLG_ACNT=1,'#39' prin FF.'#39','#39 +
        #39')  FULL_TITLE'
      'FROM VW_TDB_DOCS '
      'WHERE (DOCTYPEID=112) AND (DT=:DT) AND (CT=:CT) AND (SUMA=:SUMA)'
      'ORDER BY DATA DESC')
    Left = 132
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUMA'
        Value = nil
      end>
  end
  object IBCDataSourceFactura: TIBCDataSource
    DataSet = IBCQueryFactura
    Left = 132
    Top = 300
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 356
    Top = 332
  end
  object IBCQueryStatutIncasare: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TS_DOCTYPES_STATES'
      'where doctypeid = 116 ')
    Left = 488
    Top = 352
  end
  object IBCDataSourceStatutIncasare: TIBCDataSource
    DataSet = IBCQueryStatutIncasare
    Left = 488
    Top = 296
  end
end
