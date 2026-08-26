object frmSellInvoiceProductsToCompanyDlg: TfrmSellInvoiceProductsToCompanyDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Vinde toata marfa din factura in alta companie'
  ClientHeight = 223
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 181
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cbVinzare: TcxCheckBox
      Left = 24
      Top = 88
      Caption = 'Creaza document vanzare'
      State = cbsChecked
      Style.TransparentBorder = False
      TabOrder = 0
    end
    object ceMargin: TcxCalcEdit
      Left = 480
      Top = 40
      EditValue = 3.000000000000000000
      TabOrder = 1
      Width = 57
    end
    object cxLabel1: TcxLabel
      Left = 480
      Top = 16
      Caption = 'Adaos comercial'
      TabOrder = 2
    end
    object cxLookupComboBox1: TcxLookupComboBox
      Left = 24
      Top = 40
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = dsCompanies
      TabOrder = 3
      Width = 433
    end
    object cbFacturaVinzare: TcxCheckBox
      Left = 24
      Top = 120
      Caption = 'Creaza document Factura Fiscala Vanzare'
      State = cbsChecked
      Style.TransparentBorder = False
      TabOrder = 4
    end
    object cbIntrare: TcxCheckBox
      Left = 360
      Top = 88
      Caption = 'Creaza document Intrare Marfa'
      State = cbsChecked
      Style.TransparentBorder = False
      TabOrder = 5
    end
    object cbFacturaIntrare: TcxCheckBox
      Left = 360
      Top = 120
      Caption = 'Creaza document Factura Fiscala Intrare'
      State = cbsChecked
      Style.TransparentBorder = False
      TabOrder = 6
    end
    object cxLabel2: TcxLabel
      Left = 24
      Top = 16
      Caption = 'Alege compania care cumpara'
      TabOrder = 7
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 187
    Width = 624
    TabOrder = 1
  end
  object dsCompanies: TIBCDataSource
    DataSet = qCompanies
    Left = 312
    Top = 16
  end
  object qCompanies: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from GET_FIRMS_BY_USER2')
    Left = 312
    Top = 80
  end
end
