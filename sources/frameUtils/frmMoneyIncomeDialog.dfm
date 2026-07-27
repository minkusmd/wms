object frmMoneyIncomeDlg: TfrmMoneyIncomeDlg
  Left = 0
  Top = 0
  ActiveControl = ceSUMA
  BorderStyle = bsDialog
  ClientHeight = 406
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 595
    Height = 64
    Text = 'Creare...'
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
    ImageIndex = 28
    ExplicitWidth = 600
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 579
    Height = 281
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Padding.Top = 16
    Padding.Right = 16
    Padding.Bottom = 16
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 75
    ExplicitWidth = 584
    ExplicitHeight = 287
    object cxLabel1: TLabel
      Left = 127
      Top = 3
      Width = 35
      Height = 15
      Caption = 'Valuta '
    end
    object cxLabel2: TLabel
      Left = 16
      Top = 7
      Width = 30
      Height = 15
      Caption = 'Suma'
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 354
      Width = 43
      Height = 15
      Caption = #1055#1088#1080#1085#1103#1083
    end
    object cxLabel4: TLabel
      Left = 16
      Top = 383
      Width = 44
      Height = 15
      Caption = #1042#1077#1088#1085#1091#1090#1100
    end
    object Label1: TLabel
      Left = 16
      Top = 330
      Width = 140
      Height = 15
      Caption = #1044#1083#1103' '#1074#1099#1089#1095#1080#1090#1099#1074#1072#1085#1080#1103' '#1089#1076#1072#1095#1080
    end
    object Label3: TLabel
      Left = 195
      Top = 3
      Width = 23
      Height = 15
      Caption = 'Rata'
    end
    object ceSUMA: TcxCalcEdit
      Left = 16
      Top = 21
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '#,##0.00'
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 89
    end
    object ceRATE: TcxCalcEdit
      Left = 195
      Top = 21
      TabStop = False
      EditValue = 0.000000000000000000
      TabOrder = 3
      Width = 60
    end
    inline frameMoneyCounter: TframeMoneyCounter
      Left = 266
      Top = 16
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
      TabOrder = 0
      ExplicitLeft = 266
      ExplicitTop = 16
      inherited cxGridBanknotes: TcxGrid
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
        end
      end
    end
    object cmbCURRENCY: TcxLookupComboBox
      Left = 119
      Top = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.OnEditValueChanged = cmbCURRENCYPropertiesEditValueChanged
      EditValue = 0
      TabOrder = 2
      Width = 58
    end
    object ceSUMA_Received: TcxCalcEdit
      Left = 73
      Top = 351
      EditValue = 0.000000000000000000
      Properties.DisplayFormat = '#,##0.00'
      TabOrder = 6
      Width = 120
    end
    object edSUMA_Back: TcxCurrencyEdit
      Left = 73
      Top = 380
      TabStop = False
      EditValue = 0c
      Properties.Alignment.Horz = taLeftJustify
      Properties.DisplayFormat = '#,##0.00'
      Properties.ReadOnly = True
      Style.TextColor = clMaroon
      TabOrder = 7
      Width = 120
    end
    object pnIncasareDetail: TPanel
      Left = 3
      Top = 142
      Width = 252
      Height = 123
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 5
      object lbToUser: TLabel
        Left = 10
        Top = 71
        Width = 47
        Height = 15
        Caption = 'Operator'
      end
      object Label4: TLabel
        Left = 116
        Top = -17
        Width = 90
        Height = 15
        Caption = 'Datorie / Creanta'
      end
      object lcbUsers: TcxLookupComboBox
        Left = 10
        Top = 89
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'USERID'
        Properties.ListColumns = <
          item
            FieldName = 'FULL_NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceUsers
        TabOrder = 1
        Width = 242
      end
      object rgModIncasare: TcxRadioGroup
        Left = 10
        Top = 1
        Caption = 'Modul de incasare'
        Properties.Items = <
          item
            Caption = 'Fizic'
          end
          item
            Caption = 'Livrare'
          end>
        ItemIndex = 0
        TabOrder = 0
        Height = 65
        Width = 242
      end
    end
    object Panel1: TPanel
      Left = 3
      Top = 59
      Width = 243
      Height = 78
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 4
      object lbDatorii: TLabel
        Left = 75
        Top = 3
        Width = 90
        Height = 15
        Caption = 'Datorie / Creanta'
      end
      object lbGestiune: TLabel
        Left = 18
        Top = 21
        Width = 46
        Height = 15
        Caption = 'Gestiune'
      end
      object lbContabilitate: TLabel
        Left = 152
        Top = 21
        Width = 68
        Height = 15
        Caption = 'Contabilitate'
      end
      object ceDatoriiContabile: TcxCalcEdit
        Left = 154
        Top = 39
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        TabOrder = 1
        Width = 89
      end
      object ceDatoriiGestiune: TcxCalcEdit
        Left = 21
        Top = 39
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        TabOrder = 0
        Width = 89
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 361
    Width = 595
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 364
    object btnCancel: TcxButton
      Left = 145
      Top = 10
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 37
      Top = 10
      Width = 90
      Height = 29
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      
        'select * from vw_ts_users where flg_active = 1 and flg_work_with' +
        '_money = 1')
    Left = 360
    Top = 216
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 360
    Top = 160
  end
end
