inherited frame133POS: Tframe133POS
  Width = 1280
  Height = 720
  Font.Height = -15
  ExplicitWidth = 1280
  ExplicitHeight = 720
  PixelsPerInch = 120
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object lblTerminal: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 3
      Width = 150
      Height = 38
      Margins.Left = 12
      Align = alLeft
      Caption = 'Casa neconfigurata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lblShift: TLabel
      AlignWithMargins = True
      Left = 1180
      Top = 3
      Width = 88
      Height = 38
      Margins.Right = 12
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Tura inchisa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
  end
  object pnlRight: TPanel
    Left = 900
    Top = 44
    Width = 380
    Height = 676
    Align = alRight
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object lblTotalCaption: TLabel
      Left = 16
      Top = 12
      Width = 348
      Height = 24
      AutoSize = False
      Caption = 'TOTAL, lei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 16
      Top = 38
      Width = 348
      Height = 70
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -56
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDiscount: TLabel
      Left = 16
      Top = 112
      Width = 348
      Height = 24
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLines: TLabel
      Left = 16
      Top = 140
      Width = 348
      Height = 24
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pozitii: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnQtyMinus: TButton
      Left = 16
      Top = 184
      Width = 110
      Height = 64
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnQtyMinusClick
    end
    object btnQty: TButton
      Left = 135
      Top = 184
      Width = 110
      Height = 64
      Caption = 'Cant. F4'
      TabOrder = 1
      TabStop = False
      OnClick = btnQtyClick
    end
    object btnQtyPlus: TButton
      Left = 254
      Top = 184
      Width = 110
      Height = 64
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnQtyPlusClick
    end
    object btnDiscount: TButton
      Left = 16
      Top = 258
      Width = 170
      Height = 64
      Caption = 'Reducere F5'
      TabOrder = 3
      TabStop = False
      OnClick = btnDiscountClick
    end
    object btnDeleteLine: TButton
      Left = 194
      Top = 258
      Width = 170
      Height = 64
      Caption = 'Sterge linia Del'
      TabOrder = 4
      TabStop = False
      OnClick = btnDeleteLineClick
    end
    object btnClear: TButton
      Left = 16
      Top = 332
      Width = 348
      Height = 56
      Caption = 'Goleste bonul'
      TabOrder = 5
      TabStop = False
      OnClick = btnClearClick
    end
    object btnPay: TButton
      Left = 16
      Top = 410
      Width = 348
      Height = 96
      Caption = 'Incaseaza F9'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      TabStop = False
      OnClick = btnPayClick
    end
    object btnShift: TButton
      Left = 16
      Top = 530
      Width = 348
      Height = 56
      Caption = 'Deschide tura F10'
      TabOrder = 7
      TabStop = False
      OnClick = btnShiftClick
    end
    object btnCashIn: TButton
      Left = 16
      Top = 596
      Width = 170
      Height = 56
      Caption = 'Intrare numerar'
      TabOrder = 8
      TabStop = False
      OnClick = btnCashInClick
    end
    object btnCashOut: TButton
      Left = 194
      Top = 596
      Width = 170
      Height = 56
      Caption = 'Iesire numerar'
      TabOrder = 9
      TabStop = False
      OnClick = btnCashOutClick
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 44
    Width = 900
    Height = 676
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlSearch: TPanel
      Left = 0
      Top = 0
      Width = 900
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object edSearch: TEdit
        AlignWithMargins = True
        Left = 12
        Top = 10
        Width = 736
        Height = 44
        Margins.Left = 12
        Margins.Top = 10
        Margins.Right = 8
        Margins.Bottom = 10
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TextHint = 'Cod de bare, cod sau denumire'
        OnKeyDown = edSearchKeyDown
      end
      object btnSearch: TButton
        AlignWithMargins = True
        Left = 756
        Top = 10
        Width = 132
        Height = 44
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 12
        Margins.Bottom = 10
        Align = alRight
        Caption = 'Cauta'
        TabOrder = 1
        TabStop = False
        OnClick = btnSearchClick
      end
    end
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 67
      Width = 876
      Height = 24
      Margins.Left = 12
      Margins.Right = 12
      Align = alTop
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object pnlResults: TPanel
      Left = 0
      Top = 94
      Width = 900
      Height = 260
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object lblResults: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 3
        Width = 876
        Height = 20
        Margins.Left = 12
        Margins.Right = 12
        Align = alTop
        AutoSize = False
        Caption = 'Potriviri'
      end
      object lvResults: TListView
        AlignWithMargins = True
        Left = 12
        Top = 29
        Width = 876
        Height = 225
        Margins.Left = 12
        Margins.Right = 12
        Margins.Bottom = 6
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Denumire'
          end
          item
            Caption = 'Cod'
            Width = 160
          end
          item
            Alignment = taRightJustify
            Caption = 'Pret'
            Width = 120
          end
          item
            Alignment = taRightJustify
            Caption = 'Stoc'
            Width = 80
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Tahoma'
        Font.Style = []
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = lvResultsDblClick
        OnKeyDown = lvResultsKeyDown
      end
    end
    object gridCart: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 357
      Width = 876
      Height = 307
      Margins.Left = 12
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object gridCartView: TcxGridTableView
        OnKeyDown = gridCartViewKeyDown
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Bon gol - scanati un produs'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.DataRowHeight = 44
        OptionsView.GroupByBox = False
        object colNo: TcxGridColumn
          Caption = 'Nr'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object colTitle: TcxGridColumn
          Caption = 'Denumire'
          Width = 380
        end
        object colSerial: TcxGridColumn
          Caption = 'Serie'
          Width = 130
        end
        object colQty: TcxGridColumn
          Caption = 'Cant'
          DataBinding.ValueType = 'Float'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object colPrice: TcxGridColumn
          Caption = 'Pret'
          DataBinding.ValueType = 'Currency'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          Width = 110
        end
        object colDiscount: TcxGridColumn
          Caption = '-%'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object colSuma: TcxGridColumn
          Caption = 'Suma'
          DataBinding.ValueType = 'Currency'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          Width = 130
        end
      end
      object gridCartLevel: TcxGridLevel
        GridView = gridCartView
      end
    end
  end
end
