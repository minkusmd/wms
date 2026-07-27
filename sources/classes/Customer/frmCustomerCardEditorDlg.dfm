object frmCustomerCardEditorDialog: TfrmCustomerCardEditorDialog
  Left = 0
  Top = 0
  ActiveControl = edSN
  BorderStyle = bsDialog
  Caption = 'Card de discount'
  ClientHeight = 313
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    484
    313)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 484
    Height = 64
    Title = 'Card de discount'
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
    ImageIndex = 3
  end
  object pnCard: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 468
    Height = 177
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
    object cxLabel3: TLabel
      Left = 12
      Top = 12
      Width = 93
      Height = 15
      Caption = 'Numarul cardului'
    end
    object Label1: TLabel
      Left = 12
      Top = 112
      Width = 69
      Height = 15
      Caption = 'Valida pina la'
    end
    object Label2: TLabel
      Left = 12
      Top = 63
      Width = 78
      Height = 15
      Caption = 'Grila de preturi'
    end
    object sbValid3Months: TSpeedButton
      Tag = 3
      Left = 191
      Top = 129
      Width = 41
      Height = 23
      Caption = '3 luni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbValidForeverClick
    end
    object sbValid1Year: TSpeedButton
      Tag = 12
      Left = 238
      Top = 129
      Width = 41
      Height = 23
      Caption = '1 an'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbValidForeverClick
    end
    object sbValidForever: TSpeedButton
      Tag = 36
      Left = 285
      Top = 129
      Width = 47
      Height = 23
      Caption = '3 ani'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbValidForeverClick
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 265
      Top = 29
      Caption = 'Cartele activa'
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
    end
    object edSN: TcxDBTextEdit
      Left = 12
      Top = 29
      DataBinding.DataField = 'SN'
      Properties.CharCase = ecUpperCase
      Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
      TabOrder = 0
      Width = 221
    end
    object deVALID_UNTIL_DATE: TcxDBDateEdit
      Left = 12
      Top = 130
      DataBinding.DataField = 'VALID_UNTIL_DATE'
      TabOrder = 3
      Width = 173
    end
    object cmbPRICE_COLUMN: TcxDBComboBox
      Left = 12
      Top = 80
      DataBinding.DataField = 'PRICE_COLUMN'
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5')
      TabOrder = 2
      Width = 92
    end
  end
  object btnCancel: TcxButton
    Left = 373
    Top = 269
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 269
    Top = 269
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object IBCQueryCheckSN: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    DOCID,'
      '    DTDEP,'
      '    CTDEP,'
      '    GOODSCOMPLECT_ID,'
      '    GOODSID,'
      '    SN'
      'FROM TDB_SN'
      'WHERE'
      
        'EXISTS(SELECT GOODSID FROM TS_GOODS WHERE TS_GOODS.GOODSID=TDB_S' +
        'N.GOODSID AND TS_GOODS.GOODS_TYPE_ID=4205) /* Discount card */'
      'AND'
      '/* DocID must be "Prihod Tovara" and closed */'
      
        'EXISTS(SELECT DOCID FROM TDB_DOCS WHERE TDB_DOCS.DOCID=TDB_SN.DO' +
        'CID AND GET_FLG_VALUE(TDB_DOCS.FLAGS,10)=1 AND TDB_DOCS.DOCTYPEI' +
        'D=106)'
      'AND'
      'NOT EXISTS ('
      '            SELECT SN'
      '            FROM TS_CUST_DISCOUNT'
      '            WHERE (TS_CUST_DISCOUNT.SN=TDB_SN.SN)'
      '           )'
      ' AND (SN=:SN)')
    Left = 184
    Top = 36
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SN'
        Value = nil
      end>
  end
end
