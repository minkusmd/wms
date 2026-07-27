object frmScetFacturaNomerDlg: TfrmScetFacturaNomerDlg
  Left = 0
  Top = 0
  ActiveControl = edInvoiceNO
  BorderStyle = bsDialog
  Caption = 'Numar factura fiscala'
  ClientHeight = 239
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 344
    Height = 64
    Title = 'Numar facturii fiscale'
    Text = 'Indicati numarul facturii fiscale'
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 328
    Height = 113
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
      Top = 28
      Width = 87
      Height = 15
      Caption = 'Numarul facturii'
    end
    object Label2: TLabel
      Left = 16
      Top = 67
      Width = 100
      Height = 15
      Caption = 'sau alegeti din lista'
    end
    object edInvoiceNO: TEdit
      Left = 138
      Top = 24
      Width = 121
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object lcbFacturaNo: TcxDBLookupComboBox
      Left = 138
      Top = 65
      DataBinding.DataField = 'FACTURANO'
      Properties.KeyFieldNames = 'DSE_VALUES'
      Properties.ListColumns = <
        item
          Caption = 'Valoare'
          FieldName = 'DSE_VALUES'
        end>
      Properties.ListSource = IBCDataSourceDSE
      TabOrder = 1
      Width = 166
    end
  end
  object btnOk: TcxButton
    Left = 142
    Top = 196
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 246
    Top = 196
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDSE: TIBCQuery
    SQL.Strings = (
      'select * from get_dse_values(:dt) order by 1')
    Left = 284
    Top = 92
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt'
        Value = nil
      end>
  end
  object IBCDataSourceDSE: TIBCDataSource
    DataSet = IBCQueryDSE
    Left = 287
    Top = 43
  end
end
