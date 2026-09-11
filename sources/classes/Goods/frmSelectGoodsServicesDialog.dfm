object frmSelectGoodsServicesDlg: TfrmSelectGoodsServicesDlg
  Left = 0
  Top = 0
  Caption = 'Servicii adiacente'
  ClientHeight = 420
  ClientWidth = 640
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
    Width = 640
    Height = 64
    Title = 'Servicii adiacente'
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
  object lbInfo: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 70
    Width = 624
    Height = 15
    Margins.Left = 8
    Margins.Top = 6
    Margins.Right = 8
    Margins.Bottom = 6
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 91
    Width = 640
    Height = 281
    Align = alClient
    TabOrder = 0
    object cxGridTable: TcxGridTableView
      OnEditing = cxGridTableEditing
      OptionsBehavior.ImmediateEditor = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colSelected: TcxGridColumn
        Caption = 'Adauga'
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object colTitle: TcxGridColumn
        Caption = 'Serviciu'
        Options.Editing = False
        Width = 440
      end
      object colPrice: TcxGridColumn
        Caption = 'Pret'
        DataBinding.ValueType = 'Float'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object colServiceID: TcxGridColumn
        DataBinding.ValueType = 'Integer'
        Visible = False
        VisibleForCustomization = False
      end
      object colUMID: TcxGridColumn
        DataBinding.ValueType = 'Integer'
        Visible = False
        VisibleForCustomization = False
      end
      object colRequired: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
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
    Top = 372
    Width = 640
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      640
      48)
    object btnOk: TcxButton
      Left = 338
      Top = 9
      Width = 180
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Adauga serviciile bifate'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 524
      Top = 9
      Width = 100
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Fara servicii'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
