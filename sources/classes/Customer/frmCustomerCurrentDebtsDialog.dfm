object frmCustomerCurrentDebtsDlg: TfrmCustomerCurrentDebtsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Registrul clientului'
  ClientHeight = 501
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 800
    Height = 64
    Title = 'Datorii curente'
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
    ImageIndex = 4
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 784
    Height = 381
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 377
    ClientRectLeft = 4
    ClientRectRight = 780
    ClientRectTop = 4
    object tbsGeneral: TcxTabSheet
      Caption = #1054#1073#1097#1080#1077
      ImageIndex = 0
      object Shape1: TShape
        Left = 499
        Top = 336
        Width = 33
        Height = 15
        Brush.Color = clRed
        Pen.Color = clGray
      end
      object Shape2: TShape
        Left = 651
        Top = 336
        Width = 33
        Height = 17
        Brush.Color = clBlue
        Pen.Color = clGray
      end
      object Label3: TLabel
        Left = 538
        Top = 336
        Width = 99
        Height = 15
        Caption = 'Noua ne datoreaza'
      end
      object Label4: TLabel
        Left = 690
        Top = 336
        Width = 67
        Height = 15
        Caption = 'Noi datoram'
      end
      object edDISPLAYNAME: TEdit
        Left = 116
        Top = 20
        Width = 645
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 1
      end
      object edCUSTOMERID: TEdit
        Left = 16
        Top = 20
        Width = 94
        Height = 23
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object cxPageControl1: TcxPageControl
        Left = 16
        Top = 64
        Width = 745
        Height = 281
        TabOrder = 2
        Properties.ActivePage = tbsContract
        Properties.CustomButtons.Buttons = <>
        Properties.TabPosition = tpBottom
        ClientRectBottom = 255
        ClientRectLeft = 4
        ClientRectRight = 741
        ClientRectTop = 4
        object tbsContract: TcxTabSheet
          Caption = 'Contracte'
          ImageIndex = 0
          object cxGridFirms: TcxGrid
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 734
            Height = 201
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            TabOrder = 0
            object cxGridFirmsTable: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCustomDrawCell = cxGridFirmsTableCustomDrawCell
              DataController.DataSource = IBCDataSourceFirms
              DataController.KeyFieldNames = 'BRAND_NAME;CONTRACTID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '0.00'
                  Kind = skSum
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridFirms_SUMA_CASH
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridFirms_SUMA_TRANSFER
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridFirmsTableColumn1: TcxGridDBColumn
                DataBinding.FieldName = 'ORGID'
                DataBinding.IsNullValueType = True
              end
              object cxGridFirms_BRAND_NAME: TcxGridDBColumn
                Caption = 'Intreprinderea'
                DataBinding.FieldName = 'BRAND_NAME'
                DataBinding.IsNullValueType = True
                Width = 152
              end
              object cxGridFirmsCONTRACT: TcxGridDBColumn
                Caption = 'Contract'
                DataBinding.FieldName = 'CONTRACT'
                DataBinding.IsNullValueType = True
                Width = 299
              end
              object cxGridFirms_SUMA_CASH: TcxGridDBColumn
                Caption = #1059#1087#1088
                DataBinding.FieldName = 'SUMA_CASH'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                OnCustomDrawCell = cxGridFirms_SUMA_CASHCustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Width = 85
              end
              object cxGridFirms_SUMA_TRANSFER: TcxGridDBColumn
                Caption = #1041#1091#1093
                DataBinding.FieldName = 'SUMA_TRANSFER'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                OnCustomDrawCell = cxGridFirms_SUMA_TRANSFERCustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 85
                Options.HorzSizing = False
                Width = 85
              end
              object cxGridFirms_SUMA_TRANSFER_USD: TcxGridDBColumn
                Caption = #1041#1077#1079#1085#1072#1083'.$'
                DataBinding.FieldName = 'SUMA_TRANSFER$'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                Visible = False
                HeaderAlignmentHorz = taCenter
                MinWidth = 90
                Options.HorzSizing = False
                VisibleForCustomization = False
                Width = 90
              end
              object cxGridFirmsTable_DATA_END: TcxGridDBColumn
                DataBinding.FieldName = 'DATA_END'
                DataBinding.IsNullValueType = True
                Visible = False
                OnCustomDrawCell = cxGridFirmsTable_DATA_ENDCustomDrawCell
                VisibleForCustomization = False
              end
              object cxGridFirms_CONTRACTID: TcxGridDBColumn
                DataBinding.FieldName = 'CONTRACTID'
                DataBinding.IsNullValueType = True
                Visible = False
              end
            end
            object cxGridLevelFirms: TcxGridLevel
              GridView = cxGridFirmsTable
            end
          end
          object btnHistoryContract: TcxButton
            Left = 392
            Top = 219
            Width = 157
            Height = 29
            Caption = 'Detalii operationale...'
            TabOrder = 1
            OnClick = btnHistoryContractClick
          end
          object Button1: TcxButton
            Left = 555
            Top = 219
            Width = 166
            Height = 29
            Action = actAccountingDebts
            TabOrder = 2
          end
        end
        object tbsCashTransfer: TcxTabSheet
          Caption = 'Numerar / Transfer'
          Enabled = False
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxGrid1: TcxGrid
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 734
            Height = 201
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            TabOrder = 0
            object cxGridDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = IBCDataSourceCashTransfer
              DataController.KeyFieldNames = 'BRAND_NAME;CONTRACTID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridDBColumn6
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridDBColumn3
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridDBColumn4
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridDBColumn1: TcxGridDBColumn
                Caption = 'Intreprinderea'
                DataBinding.FieldName = 'BRAND_NAME'
                DataBinding.IsNullValueType = True
                Width = 152
              end
              object cxGridDBColumn3: TcxGridDBColumn
                Caption = 'Numerar'
                DataBinding.FieldName = 'SUMA_CASH'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Width = 70
              end
              object cxGridDBColumn4: TcxGridDBColumn
                Caption = 'Transfer'
                DataBinding.FieldName = 'SUMA_TRANSFER'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                OnCustomDrawCell = cxGridFirms_SUMA_TRANSFERCustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 90
                Options.HorzSizing = False
                Width = 90
              end
              object cxGridDBColumn5: TcxGridDBColumn
                Caption = #1041#1077#1079#1085#1072#1083'.$'
                DataBinding.FieldName = 'SUMA_TRANSFER$'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                Visible = False
                HeaderAlignmentHorz = taCenter
                MinWidth = 90
                Options.HorzSizing = False
                VisibleForCustomization = False
                Width = 90
              end
              object cxGridDBColumn6: TcxGridDBColumn
                Caption = 'Total'
                DataBinding.FieldName = 'TOTAL$'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                OnCustomDrawCell = cxGridFirms_TOTALCustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.HorzSizing = False
                Styles.Content = dmAdditions.cxStyle_Bold
                Width = 100
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView1
            end
          end
          object btnHistoryCash: TcxButton
            Left = 468
            Top = 219
            Width = 121
            Height = 29
            Caption = 'Detalii numerar >>'
            TabOrder = 1
            OnClick = btnHistoryCashClick
          end
          object btnHistoryTransfer: TcxButton
            Left = 595
            Top = 219
            Width = 122
            Height = 29
            Caption = 'Detalii transfer >>'
            TabOrder = 2
            OnClick = btnHistoryTransferClick
          end
        end
      end
    end
    object tbsNoAccess: TcxTabSheet
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label6: TLabel
        Left = 16
        Top = 20
        Width = 251
        Height = 15
        Caption = #1044#1072#1085#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1079#1072#1082#1088#1099#1090#1072' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072'!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object btnClose: TcxButton
    Left = 679
    Top = 464
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryFirms: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from sp_datorii_curente_v2(:customerid)')
    Left = 112
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
        Value = nil
      end>
  end
  object IBCDataSourceFirms: TIBCDataSource
    DataSet = IBCQueryFirms
    Left = 184
    Top = 188
  end
  object IBCQueryCashTransfer: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select BRAND_NAME, sum(SUMA_CASH) SUMA_CASH, sum(SUMA_TRANSFER) ' +
        'SUMA_TRANSFER'
      'from SP_DATORII_CURENTE_v2(:CUSTOMERID)'
      'group by BRAND_NAME  ')
    Left = 432
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
        Value = nil
      end>
  end
  object IBCDataSourceCashTransfer: TIBCDataSource
    DataSet = IBCQueryCashTransfer
    Left = 424
    Top = 188
  end
  object ActionList1: TActionList
    Left = 624
    Top = 192
    object actAccountingDebts: TAction
      Caption = 'Detalii contabile'
      ShortCut = 16471
      OnExecute = actAccountingDebtsExecute
    end
  end
end
