object frmGoodsServicePricesDlg: TfrmGoodsServicePricesDlg
  Left = 0
  Top = 0
  Caption = 'Preturi pe produse'
  ClientHeight = 620
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 900
    Height = 64
    Title = 'Preturi pe produse'
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
  end
  object pnTop: TPanel
    Left = 0
    Top = 64
    Width = 900
    Height = 104
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbService: TLabel
      Left = 8
      Top = 12
      Width = 43
      Height = 15
      Caption = 'Serviciul'
    end
    object lbTypeRule: TLabel
      Left = 8
      Top = 40
      Width = 880
      Height = 18
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbFill: TLabel
      Left = 8
      Top = 73
      Width = 170
      Height = 15
      Caption = 'Pret pentru randurile vizibile, MDL'
    end
    object beService: TcxButtonEdit
      Left = 72
      Top = 8
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = beServicePropertiesButtonClick
      TabOrder = 0
      Width = 500
    end
    object edFillPrice: TcxTextEdit
      Left = 200
      Top = 69
      TabOrder = 1
      Width = 90
    end
    object btnFill: TcxButton
      Left = 296
      Top = 67
      Width = 180
      Height = 27
      Caption = 'Aplica la randurile vizibile'
      TabOrder = 2
      OnClick = btnFillClick
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 168
    Width = 900
    Height = 404
    Align = alClient
    TabOrder = 1
    object cxGridTable: TcxGridTableView
      FilterRow.Visible = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colGoodsID: TcxGridColumn
        Caption = 'Cod'
        DataBinding.ValueType = 'Integer'
        Options.Editing = False
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object colTitle: TcxGridColumn
        Caption = 'Produs'
        Options.Editing = False
        Width = 420
      end
      object colGoodsPrice: TcxGridColumn
        Caption = 'Pret produs'
        DataBinding.ValueType = 'Float'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
      object colActive: TcxGridColumn
        Caption = 'Are serviciul'
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object colPrice: TcxGridColumn
        Caption = 'Pret serviciu, MDL'
        DataBinding.ValueType = 'Float'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object colPercent: TcxGridColumn
        Caption = '+ %'
        DataBinding.ValueType = 'Float'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object colHasRule: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
        Visible = False
        VisibleForCustomization = False
      end
      object colOrigActive: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
        Visible = False
        VisibleForCustomization = False
      end
      object colOrigPrice: TcxGridColumn
        DataBinding.ValueType = 'Float'
        Visible = False
        VisibleForCustomization = False
      end
      object colOrigPercent: TcxGridColumn
        DataBinding.ValueType = 'Float'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 572
    Width = 900
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      900
      48)
    object lbCount: TLabel
      Left = 8
      Top = 16
      Width = 3
      Height = 15
    end
    object btnOk: TcxButton
      Left = 698
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 794
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
