object frmDispatchDlg: TfrmDispatchDlg
  Left = 0
  Top = 0
  Caption = 'Dispecerat: achizitii si livrari'
  ClientHeight = 720
  ClientWidth = 1280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1280
    Height = 64
    Title = 'Dispecerat: achizitii si livrari'
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
    Width = 1280
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbDay: TLabel
      Left = 8
      Top = 14
      Width = 60
      Height = 15
      Caption = 'Ziua:'
    end
    object deDate: TcxDateEdit
      Left = 44
      Top = 10
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.OnChange = deDatePropertiesChange
      TabOrder = 0
      Width = 110
    end
    object btnPrevDay: TcxButton
      Left = 158
      Top = 8
      Width = 30
      Height = 31
      Caption = '<'
      TabOrder = 0
      OnClick = btnPrevDayClick
    end
    object btnNextDay: TcxButton
      Left = 192
      Top = 8
      Width = 30
      Height = 31
      Caption = '>'
      TabOrder = 0
      OnClick = btnNextDayClick
    end
    object lbPlanState: TLabel
      Left = 236
      Top = 14
      Width = 60
      Height = 15
      AutoSize = False
      Width = 470
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Caption = 'Plan'
    end
    object btnPublish: TcxButton
      Left = 712
      Top = 6
      Width = 150
      Height = 31
      Caption = 'Publica planul'
      TabOrder = 0
      OnClick = btnPublishClick
    end
    object btnRefresh: TcxButton
      Left = 868
      Top = 6
      Width = 110
      Height = 31
      Caption = 'Actualizeaza'
      TabOrder = 0
      OnClick = btnRefreshClick
    end
    object btnCouriers: TcxButton
      Left = 984
      Top = 6
      Width = 100
      Height = 31
      Caption = 'Curieri...'
      TabOrder = 0
      OnClick = btnCouriersClick
    end
    object btnZones: TcxButton
      Left = 1090
      Top = 6
      Width = 90
      Height = 31
      Caption = 'Zone...'
      TabOrder = 0
      OnClick = btnZonesClick
    end
  end
  object pnAssign: TPanel
    Left = 0
    Top = 108
    Width = 1280
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbCourier: TLabel
      Left = 8
      Top = 12
      Width = 60
      Height = 15
      Caption = 'Curierul:'
    end
    object lcbCourier: TcxLookupComboBox
      Left = 70
      Top = 8
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListSource = dsCouriers
      TabOrder = 0
      Width = 260
    end
    object lbZone: TLabel
      Left = 344
      Top = 12
      Width = 60
      Height = 15
      Caption = 'Zona livrarii:'
    end
    object lcbZone: TcxLookupComboBox
      Left = 426
      Top = 8
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'ZONEID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListSource = dsZones
      TabOrder = 0
      Width = 200
    end
    object lbAssignHint: TLabel
      Left = 640
      Top = 12
      Width = 60
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Caption = 'Butoanele de jos lucreaza pe randurile selectate (Ctrl / Shift pentru mai multe).'
    end
  end
  object pcMain: TcxPageControl
    Left = 0
    Top = 148
    Width = 1280
    Height = 526
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tsPickups
    Properties.CustomButtons.Buttons = <>
    object tsPickups: TcxTabSheet
      Caption = 'Achizitii'
      ImageIndex = 0
      object cxGridPickups: TcxGrid
        Left = 0
        Top = 0
        Width = 400
        Height = 400
        Align = alClient
        TabOrder = 0
        object gvPickups: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsPickups
          DataController.KeyFieldNames = 'PICKUPID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = True
          OptionsView.Indicator = True
          object gvPickupsPICKUPID: TcxGridDBColumn
            Caption = 'Nr.'
            DataBinding.FieldName = 'PICKUPID'
            Visible = False
            Width = 45
          end
          object gvPickupsCOURIER_NAME: TcxGridDBColumn
            Caption = 'Curier'
            DataBinding.FieldName = 'COURIER_NAME'
            Width = 140
          end
          object gvPickupsSTOP_ORDERNO: TcxGridDBColumn
            Caption = 'Oprirea'
            DataBinding.FieldName = 'STOP_ORDERNO'
            Width = 50
          end
          object gvPickupsPICKUP_SUPPLIER_NAME: TcxGridDBColumn
            Caption = 'Ridicare de la'
            DataBinding.FieldName = 'PICKUP_SUPPLIER_NAME'
            Width = 150
          end
          object gvPickupsZONE_NAME: TcxGridDBColumn
            Caption = 'Zona'
            DataBinding.FieldName = 'ZONE_NAME'
            Width = 80
          end
          object gvPickupsGOODS_TITLE: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_TITLE'
            Width = 230
          end
          object gvPickupsGOODS_CODE: TcxGridDBColumn
            Caption = 'Cod furnizor'
            DataBinding.FieldName = 'GOODS_CODE'
            Width = 80
          end
          object gvPickupsQTY: TcxGridDBColumn
            Caption = 'Cant.'
            DataBinding.FieldName = 'QTY'
            Width = 40
          end
          object gvPickupsORDER_SUPPLIER_NAME: TcxGridDBColumn
            Caption = 'Comandat prin'
            DataBinding.FieldName = 'ORDER_SUPPLIER_NAME'
            Width = 120
          end
          object gvPickupsDOCID: TcxGridDBColumn
            Caption = 'Comanda'
            DataBinding.FieldName = 'DOCID'
            Width = 60
          end
          object gvPickupsCLIENT_NAME: TcxGridDBColumn
            Caption = 'Client'
            DataBinding.FieldName = 'CLIENT_NAME'
            Width = 130
          end
          object gvPickupsPLAN_DATE: TcxGridDBColumn
            Caption = 'Data ceruta'
            DataBinding.FieldName = 'PLAN_DATE'
            Width = 75
          end
          object gvPickupsSTATE_NAME: TcxGridDBColumn
            Caption = 'Stare'
            DataBinding.FieldName = 'STATE_NAME'
            Width = 70
          end
          object gvPickupsPICKUP_DOC_STATE: TcxGridDBColumn
            Caption = 'Preluare'
            DataBinding.FieldName = 'PICKUP_DOC_STATE'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Items = <
              item
                Description = 'In preluare (blocata)'
                ImageIndex = -1
                Value = 1
              end
              item
                Description = 'Incarcat'
                ImageIndex = -1
                Value = 2
              end>
            Width = 90
          end
          object gvPickupsNOTE: TcxGridDBColumn
            Caption = 'Nota'
            DataBinding.FieldName = 'NOTE'
            Width = 120
          end
        end
        object glPickups: TcxGridLevel
          GridView = gvPickups
        end
      end
      object pnPickupsActions: TPanel
        Left = 0
        Top = 400
        Width = 1272
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnPickupAssign: TcxButton
          Left = 8
          Top = 7
          Width = 180
          Height = 31
          Caption = 'Atribuie curierului ales'
          TabOrder = 0
          OnClick = btnPickupAssignClick
        end
        object btnPickupUnassign: TcxButton
          Left = 194
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Scoate din traseu'
          TabOrder = 0
          OnClick = btnPickupUnassignClick
        end
      end
    end
    object tsReturns: TcxTabSheet
      Caption = 'Retururi'
      ImageIndex = 1
      object cxGridReturns: TcxGrid
        Left = 0
        Top = 0
        Width = 400
        Height = 400
        Align = alClient
        TabOrder = 0
        object gvReturns: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsReturns
          DataController.KeyFieldNames = 'DOCID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object gvReturnsDOCID: TcxGridDBColumn
            Caption = 'Document'
            DataBinding.FieldName = 'DOCID'
            Width = 70
          end
          object gvReturnsCOURIER_NAME: TcxGridDBColumn
            Caption = 'Curier'
            DataBinding.FieldName = 'COURIER_NAME'
            Width = 160
          end
          object gvReturnsDISPATCH_DATE: TcxGridDBColumn
            Caption = 'Ziua'
            DataBinding.FieldName = 'DISPATCH_DATE'
            Width = 75
          end
          object gvReturnsDOC_DATA: TcxGridDBColumn
            Caption = 'Data documentului'
            DataBinding.FieldName = 'DOC_DATA'
            Width = 110
          end
          object gvReturnsSUPPLIER_NAME: TcxGridDBColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'SUPPLIER_NAME'
            Width = 220
          end
          object gvReturnsSUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            Width = 80
          end
        end
        object glReturns: TcxGridLevel
          GridView = gvReturns
        end
      end
      object pnReturnsActions: TPanel
        Left = 0
        Top = 400
        Width = 1272
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnReturnAssign: TcxButton
          Left = 8
          Top = 7
          Width = 180
          Height = 31
          Caption = 'Atribuie curierului ales'
          TabOrder = 0
          OnClick = btnReturnAssignClick
        end
        object btnReturnUnassign: TcxButton
          Left = 194
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Scoate din traseu'
          TabOrder = 0
          OnClick = btnReturnUnassignClick
        end
      end
    end
    object tsDeliveries: TcxTabSheet
      Caption = 'Livrari'
      ImageIndex = 2
      object cxGridDeliveries: TcxGrid
        Left = 0
        Top = 0
        Width = 400
        Height = 400
        Align = alClient
        TabOrder = 0
        object gvDeliveries: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsDeliveries
          DataController.KeyFieldNames = 'DOCID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = True
          OptionsView.Indicator = True
          object gvDeliveriesDOCID: TcxGridDBColumn
            Caption = 'Document'
            DataBinding.FieldName = 'DOCID'
            Width = 65
          end
          object gvDeliveriesCOURIER_NAME: TcxGridDBColumn
            Caption = 'Curier'
            DataBinding.FieldName = 'COURIER_NAME'
            Width = 140
          end
          object gvDeliveriesSTOP_ORDERNO: TcxGridDBColumn
            Caption = 'Oprirea'
            DataBinding.FieldName = 'STOP_ORDERNO'
            Width = 50
          end
          object gvDeliveriesZONE_NAME: TcxGridDBColumn
            Caption = 'Zona'
            DataBinding.FieldName = 'ZONE_NAME'
            Width = 90
          end
          object gvDeliveriesCLIENT_NAME: TcxGridDBColumn
            Caption = 'Client'
            DataBinding.FieldName = 'CLIENT_NAME'
            Width = 160
          end
          object gvDeliveriesDELIVERY_ADDRESS: TcxGridDBColumn
            Caption = 'Adresa'
            DataBinding.FieldName = 'DELIVERY_ADDRESS'
            Width = 260
          end
          object gvDeliveriesPHONE_NUMBER: TcxGridDBColumn
            Caption = 'Telefon'
            DataBinding.FieldName = 'PHONE_NUMBER'
            Width = 95
          end
          object gvDeliveriesDELIVERY_DATE: TcxGridDBColumn
            Caption = 'Data ceruta'
            DataBinding.FieldName = 'DELIVERY_DATE'
            Width = 75
          end
          object gvDeliveriesDELIVERY_TIME: TcxGridDBColumn
            Caption = 'Interval'
            DataBinding.FieldName = 'DELIVERY_TIME'
            Width = 80
          end
          object gvDeliveriesDISPATCH_STATE_NAME: TcxGridDBColumn
            Caption = 'Stare'
            DataBinding.FieldName = 'DISPATCH_STATE_NAME'
            Width = 90
          end
          object gvDeliveriesSUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            Width = 75
          end
        end
        object glDeliveries: TcxGridLevel
          GridView = gvDeliveries
        end
      end
      object pnDeliveriesActions: TPanel
        Left = 0
        Top = 400
        Width = 1272
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnDeliveryAssign: TcxButton
          Left = 8
          Top = 7
          Width = 180
          Height = 31
          Caption = 'Atribuie curierului ales'
          TabOrder = 0
          OnClick = btnDeliveryAssignClick
        end
        object btnDeliveryZoneOnly: TcxButton
          Left = 194
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Doar zona si ziua'
          TabOrder = 0
          OnClick = btnDeliveryZoneOnlyClick
        end
        object btnDeliveryUnassign: TcxButton
          Left = 340
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Scoate din traseu'
          TabOrder = 0
          OnClick = btnDeliveryUnassignClick
        end
      end
    end
    object tsRoutes: TcxTabSheet
      Caption = 'Trasee'
      ImageIndex = 3
      object cxGridRoutes: TcxGrid
        Left = 0
        Top = 0
        Width = 460
        Height = 400
        Align = alLeft
        TabOrder = 0
        object gvRoutes: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsRoutes
          DataController.KeyFieldNames = 'ROUTEID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object gvRoutesCOURIER_NAME: TcxGridDBColumn
            Caption = 'Curier'
            DataBinding.FieldName = 'COURIER_NAME'
            Width = 160
          end
          object gvRoutesN_STOPS: TcxGridDBColumn
            Caption = 'Opriri'
            DataBinding.FieldName = 'N_STOPS'
            Width = 45
          end
          object gvRoutesN_DONE: TcxGridDBColumn
            Caption = 'Gata'
            DataBinding.FieldName = 'N_DONE'
            Width = 40
          end
          object gvRoutesN_PROBLEMS: TcxGridDBColumn
            Caption = 'Probleme'
            DataBinding.FieldName = 'N_PROBLEMS'
            Width = 55
          end
          object gvRoutesSTATE_NAME: TcxGridDBColumn
            Caption = 'Stare'
            DataBinding.FieldName = 'STATE_NAME'
            Width = 90
          end
          object gvRoutesHAS_WEB_ACCOUNT: TcxGridDBColumn
            Caption = 'Aplicatie'
            DataBinding.FieldName = 'HAS_WEB_ACCOUNT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = 0
            Width = 55
          end
        end
        object glRoutes: TcxGridLevel
          GridView = gvRoutes
        end
      end
      object splRoutes: TSplitter
        Left = 460
        Top = 0
        Width = 5
        Height = 400
      end
      object cxGridStops: TcxGrid
        Left = 465
        Top = 0
        Width = 807
        Height = 400
        Align = alClient
        TabOrder = 0
        object gvStops: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsStops
          DataController.KeyFieldNames = 'STOPID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object gvStopsSTOPID: TcxGridDBColumn
            DataBinding.FieldName = 'STOPID'
            Visible = False
            Width = 40
          end
          object gvStopsORDERNO: TcxGridDBColumn
            Caption = 'Ordine'
            DataBinding.FieldName = 'ORDERNO'
            Width = 45
          end
          object gvStopsKIND_NAME: TcxGridDBColumn
            Caption = 'Tip'
            DataBinding.FieldName = 'KIND_NAME'
            Width = 65
          end
          object gvStopsTITLE: TcxGridDBColumn
            Caption = 'Oprirea'
            DataBinding.FieldName = 'TITLE'
            Width = 170
          end
          object gvStopsADDRESS: TcxGridDBColumn
            Caption = 'Adresa'
            DataBinding.FieldName = 'ADDRESS'
            Width = 200
          end
          object gvStopsZONE_NAME: TcxGridDBColumn
            Caption = 'Zona'
            DataBinding.FieldName = 'ZONE_NAME'
            Width = 80
          end
          object gvStopsPLAN_TIME: TcxGridDBColumn
            Caption = 'Ora'
            DataBinding.FieldName = 'PLAN_TIME'
            Width = 70
          end
          object gvStopsN_PICKUP: TcxGridDBColumn
            Caption = 'Ridicari'
            DataBinding.FieldName = 'N_PICKUP'
            Width = 50
          end
          object gvStopsN_RETURN: TcxGridDBColumn
            Caption = 'Retur'
            DataBinding.FieldName = 'N_RETURN'
            Width = 40
          end
          object gvStopsN_DELIVERY: TcxGridDBColumn
            Caption = 'Livrari'
            DataBinding.FieldName = 'N_DELIVERY'
            Width = 45
          end
          object gvStopsN_LOAD: TcxGridDBColumn
            Caption = 'Incarcare'
            DataBinding.FieldName = 'N_LOAD'
            Width = 55
          end
          object gvStopsSTATE_NAME: TcxGridDBColumn
            Caption = 'Stare'
            DataBinding.FieldName = 'STATE_NAME'
            Width = 80
          end
          object gvStopsARRIVED_AT: TcxGridDBColumn
            Caption = 'Sosit'
            DataBinding.FieldName = 'ARRIVED_AT'
            Visible = False
            Width = 70
          end
          object gvStopsDONE_AT: TcxGridDBColumn
            Caption = 'Terminat'
            DataBinding.FieldName = 'DONE_AT'
            Visible = False
            Width = 70
          end
        end
        object glStops: TcxGridLevel
          GridView = gvStops
        end
      end
      object pnRoutesActions: TPanel
        Left = 0
        Top = 400
        Width = 1272
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnStopUp: TcxButton
          Left = 8
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Oprirea mai sus'
          TabOrder = 0
          OnClick = btnStopUpClick
        end
        object btnStopDown: TcxButton
          Left = 154
          Top = 7
          Width = 140
          Height = 31
          Caption = 'Oprirea mai jos'
          TabOrder = 0
          OnClick = btnStopDownClick
        end
      end
    end
    object tsProblems: TcxTabSheet
      Caption = 'Probleme'
      ImageIndex = 4
      object cxGridProblems: TcxGrid
        Left = 0
        Top = 0
        Width = 400
        Height = 400
        Align = alClient
        TabOrder = 0
        object gvProblems: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsProblems
          DataController.KeyFieldNames = ''
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object gvProblemsNIVEL: TcxGridDBColumn
            Caption = 'Nivel'
            DataBinding.FieldName = 'NIVEL'
            Width = 60
          end
          object gvProblemsO_COURIER_NAME: TcxGridDBColumn
            Caption = 'Curier'
            DataBinding.FieldName = 'O_COURIER_NAME'
            Width = 160
          end
          object gvProblemsO_PROBLEM: TcxGridDBColumn
            Caption = 'Problema'
            DataBinding.FieldName = 'O_PROBLEM'
            Width = 500
          end
          object gvProblemsO_DOCID: TcxGridDBColumn
            Caption = 'Document'
            DataBinding.FieldName = 'O_DOCID'
            Width = 70
          end
        end
        object glProblems: TcxGridLevel
          GridView = gvProblems
        end
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 674
    Width = 1280
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      1280
      46)
    object btnClose: TcxButton
      Left = 1162
      Top = 8
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      ModalResult = 2
      Caption = 'Inchide'
      TabOrder = 0
    end
  end
  object qPickups: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_DISPATCH_PICKUPS'
      'WHERE FIRMAID = :FIRMAID'
      '  AND (DISPATCH_DATE = :DATA'
      '       OR (TASKID IS NULL AND STATEID IN (0, 1) AND (PLAN_DATE IS NULL OR PLAN_DATE <= :DATA)))'
      'ORDER BY COURIER_NAME NULLS FIRST, STOP_ORDERNO, PICKUP_SUPPLIER_NAME, PICKUPID')
    ReadOnly = True
    Left = 48
    Top = 260
  end
  object dsPickups: TIBCDataSource
    DataSet = qPickups
    Left = 128
    Top = 260
  end
  object qReturns: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_DISPATCH_RETURNS'
      'WHERE FIRMAID = :FIRMAID AND (DISPATCH_DATE = :DATA OR TASKID IS NULL)'
      'ORDER BY COURIER_NAME NULLS FIRST, SUPPLIER_NAME, DOCID')
    ReadOnly = True
    Left = 48
    Top = 316
  end
  object dsReturns: TIBCDataSource
    DataSet = qReturns
    Left = 128
    Top = 316
  end
  object qDeliveries: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_DISPATCH_DELIVERIES'
      'WHERE FIRMAID = :FIRMAID'
      '  AND (PLAN_DATE = :DATA'
      '       OR (COALESCE(DISPATCH_STATEID, 0) = 0'
      '           AND COALESCE(PLAN_DATE, DELIVERY_DATE) <= :DATA'
      '           AND COALESCE(PLAN_DATE, DELIVERY_DATE) >= DATEADD(-14 DAY TO CAST(:DATA AS DATE))))'
      'ORDER BY COURIER_NAME NULLS FIRST, STOP_ORDERNO, ZONE_NAME, DOCID')
    ReadOnly = True
    Left = 48
    Top = 372
  end
  object dsDeliveries: TIBCDataSource
    DataSet = qDeliveries
    Left = 128
    Top = 372
  end
  object qRoutes: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_DISPATCH_ROUTES'
      'WHERE PLANID = :PLANID'
      'ORDER BY COURIER_NAME')
    ReadOnly = True
    Left = 48
    Top = 428
  end
  object dsRoutes: TIBCDataSource
    DataSet = qRoutes
    Left = 128
    Top = 428
  end
  object qStops: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_DISPATCH_STOPS'
      'WHERE ROUTEID = :ROUTEID'
      'ORDER BY ORDERNO, STOPID')
    MasterFields = 'ROUTEID'
    DetailFields = 'ROUTEID'
    MasterSource = dsRoutes
    ReadOnly = True
    Left = 48
    Top = 484
  end
  object dsStops: TIBCDataSource
    DataSet = qStops
    Left = 128
    Top = 484
  end
  object qProblems: TIBCQuery
    SQL.Strings = (
      'SELECT IIF(O_LEVEL = 1, ''Eroare'', ''Atentie'') AS NIVEL, O_COURIER_NAME, O_PROBLEM, O_DOCID'
      'FROM SP_DISPATCH_PLAN_PROBLEMS(:PLANID)')
    ReadOnly = True
    Left = 48
    Top = 540
  end
  object dsProblems: TIBCDataSource
    DataSet = qProblems
    Left = 128
    Top = 540
  end
  object qCouriers: TIBCQuery
    SQL.Strings = (
      'SELECT CUSTOMERID, NAME FROM VW_TS_COURIER'
      'WHERE FLG_ACTIVE = 1'
      'ORDER BY NAME')
    ReadOnly = True
    Left = 232
    Top = 260
  end
  object dsCouriers: TIBCDataSource
    DataSet = qCouriers
    Left = 312
    Top = 260
  end
  object qZones: TIBCQuery
    SQL.Strings = (
      'SELECT ZONEID, NAME FROM TS_LOGISTIC_ZONE'
      'WHERE FLG_ACTIVE = 1'
      'ORDER BY ORDERNO, NAME')
    ReadOnly = True
    Left = 232
    Top = 316
  end
  object dsZones: TIBCDataSource
    DataSet = qZones
    Left = 312
    Top = 316
  end
end
