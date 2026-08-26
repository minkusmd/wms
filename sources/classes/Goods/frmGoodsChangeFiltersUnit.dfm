object frmGoodsChangeFilters: TfrmGoodsChangeFilters
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adauga filtru pentru produsele selectate'
  ClientHeight = 171
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 122
    Width = 519
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object btnOK: TButton
      Left = 864
      Top = 16
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 968
      Top = 16
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object cxButton1: TcxButton
      Left = 256
      Top = 16
      Width = 146
      Height = 29
      Caption = 'Adauga/Modifica'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = cxButton1Click
    end
    object btnCancel: TcxButton
      Left = 408
      Top = 16
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 3
    end
    object btnDeleteFilter: TcxButton
      Left = 3
      Top = 16
      Width = 146
      Height = 29
      Caption = 'Sterge'
      Default = True
      ModalResult = 1
      TabOrder = 4
      OnClick = btnDeleteFilterClick
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 513
    Height = 116
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 27
      Height = 15
      Caption = 'Filtru'
    end
    object Label4: TLabel
      Left = 16
      Top = 45
      Width = 38
      Height = 15
      Caption = 'Valoare'
    end
    object Label7: TLabel
      Left = 16
      Top = 74
      Width = 20
      Height = 15
      Caption = 'Ord'
    end
    object edFilterID: TNumberBox
      Left = 72
      Top = 13
      Width = 57
      Height = 23
      TabOrder = 0
      OnExit = edFilterIDExit
    end
    object beFilters: TcxButtonEdit
      Left = 144
      Top = 13
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 1
      OnClick = beFiltersClick
      Width = 353
    end
    object edFilterParamID: TNumberBox
      Left = 72
      Top = 42
      Width = 57
      Height = 23
      TabOrder = 2
      OnExit = edFilterParamIDExit
    end
    object beParamValue: TcxButtonEdit
      Left = 144
      Top = 42
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 3
      OnClick = beFiltersClick
      Width = 353
    end
    object edOrd: TNumberBox
      Left = 72
      Top = 71
      Width = 57
      Height = 23
      TabOrder = 4
    end
  end
  object dxMemData1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 368
    Top = 96
    object dxMemData1FILTERID: TIntegerField
      FieldName = 'FILTERID'
    end
    object dxMemData1FILTER_NAME: TStringField
      FieldName = 'FILTER_NAME'
      Size = 150
    end
    object dxMemData1PARAMID: TIntegerField
      FieldName = 'PARAMID'
    end
    object dxMemData1PARAM_VALUE: TStringField
      FieldName = 'PARAM_VALUE'
      Size = 60
    end
  end
  object DataSourceFilters: TDataSource
    DataSet = dxMemData1
    Left = 368
    Top = 32
  end
end
