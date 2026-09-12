object frmIndeplinirePlanVinzariDialog: TfrmIndeplinirePlanVinzariDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Plan vinzari'
  ClientHeight = 676
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label4: TLabel
    Left = 112
    Top = 32
    Width = 18
    Height = 15
    Caption = '120'
  end
  object Label5: TLabel
    Left = 112
    Top = 13
    Width = 25
    Height = 15
    Caption = 'Cant'
  end
  object Label11: TLabel
    Left = 115
    Top = 13
    Width = 25
    Height = 15
    Caption = 'Cant'
  end
  object Label12: TLabel
    Left = 132
    Top = 40
    Width = 21
    Height = 13
    Alignment = taRightJustify
    Caption = '120'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 160
    Top = 256
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 3
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 169
    Width = 421
    Height = 456
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
    object Label1: TLabel
      Left = 16
      Top = 37
      Width = 75
      Height = 15
      Caption = 'Vinzari inchise'
    end
    object lbClosedDealsCount: TLabel
      Left = 130
      Top = 37
      Width = 7
      Height = 15
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 112
      Top = 5
      Width = 25
      Height = 15
      Caption = 'Cant'
    end
    object Label6: TLabel
      Left = 203
      Top = 5
      Width = 30
      Height = 15
      Caption = 'Suma'
    end
    object lbClosedDealsAmount: TLabel
      Left = 167
      Top = 37
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 55
      Width = 83
      Height = 15
      Caption = 'Vinzari deschise'
    end
    object lbOpenDocsCount: TLabel
      Left = 130
      Top = 55
      Width = 7
      Height = 15
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbOpenedDealsAmount: TLabel
      Left = 167
      Top = 55
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 315
      Top = 5
      Width = 67
      Height = 15
      Caption = 'Cecul mediu'
    end
    object lbAvgClosedDealsChecks: TLabel
      Left = 353
      Top = 37
      Width = 7
      Height = 15
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbAvgOpenedChecks: TLabel
      Left = 353
      Top = 55
      Width = 7
      Height = 15
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 16
      Top = 91
      Width = 120
      Height = 15
      Caption = 'Planul de vinzari (plan)'
    end
    object lbSellsPlanAmount: TLabel
      Left = 167
      Top = 91
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 16
      Top = 172
      Width = 68
      Height = 15
      Caption = 'Calculat Brut'
    end
    object lbProfitBrut: TLabel
      Left = 102
      Top = 172
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 154
      Width = 41
      Height = 15
      Caption = 'K (plan)'
    end
    object lbKPlan: TLabel
      Left = 102
      Top = 154
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 237
      Top = 172
      Width = 65
      Height = 15
      Caption = 'Calculat Net'
    end
    object lbProfitNet: TLabel
      Left = 323
      Top = 172
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 16
      Top = 113
      Width = 124
      Height = 15
      Caption = 'Tranzactii inchise (plan)'
    end
    object lbPlanTransactioinQty: TLabel
      Left = 167
      Top = 112
      Width = 78
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 16
      Top = 131
      Width = 385
      Height = 17
      Position = 55
      TabOrder = 0
    end
    object cxGrid1: TcxGrid
      Left = 16
      Top = 200
      Width = 385
      Height = 241
      TabOrder = 1
      object cxGrid1DBChartView1: TcxGridDBChartView
        Categories.DataBinding.FieldName = 'USER_NAME'
        DataController.DataSource = IBCDataSourceVenit
        DataController.KeyFieldNames = 'USER_NAME'
        DiagramColumn.Active = True
        DiagramColumn.Legend.Position = cppNone
        Title.Position = cppNone
        object cxGrid1DBChartView1Series1: TcxGridDBChartSeries
          DataBinding.FieldName = 'TOTAL_VINZARI'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBChartView1
      end
    end
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 437
    Height = 64
    Title = 'Planul de vinzari'
    Text = 'Indeplinirea planului de vinzari de catre vinzatori'
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
    ImageIndex = 2
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 421
    Height = 89
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 15
      Width = 47
      Height = 15
      Caption = 'Operator'
    end
    object Label7: TLabel
      Left = 16
      Top = 55
      Width = 46
      Height = 15
      Caption = 'Perioada'
    end
    object cxLookupComboBox1: TcxLookupComboBox
      Left = 69
      Top = 17
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'FULL_NAME'
        end>
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 0
      Width = 332
    end
    object deStart: TcxDateEdit
      Left = 68
      Top = 48
      TabOrder = 2
      Width = 93
    end
    object deEnd: TcxDateEdit
      Left = 180
      Top = 48
      TabOrder = 3
      Width = 93
    end
    object Button3: TButton
      Left = 296
      Top = 46
      Width = 104
      Height = 25
      Caption = 'Actualizeaza'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Button2: TButton
    Left = 320
    Top = 636
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 4
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select userid, FULL_NAME '
      '  from vw_ts_users '
      ' where FLG_ACTIVE=1 and '
      '       usertype_id = 7001'
      'order by full_name')
    Left = 216
    Top = 120
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 128
    Top = 120
  end
  object IBCQueryVenit: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select z.* from RP_SALES_AND_PROFIT_1(:data1, :data2) z'
      
        'join ts_users u on u.userid = z.userid and u.usertype_id=7001 an' +
        'd u.userid <> 9'
      'order by z.total_vinzari')
    Left = 288
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end>
  end
  object IBCDataSourceVenit: TIBCDataSource
    DataSet = IBCQueryVenit
    Left = 192
    Top = 392
  end
end
