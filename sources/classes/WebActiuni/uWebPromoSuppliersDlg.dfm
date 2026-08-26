object frmWebPromoSuppliersDlg: TfrmWebPromoSuppliersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Genstiune furnizori promotie'
  ClientHeight = 302
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGridPromoSuppliers: TcxGrid
    Left = 0
    Top = 28
    Width = 486
    Height = 225
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 264
    ExplicitWidth = 476
    object cxGridPromoSuppliersDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourcePromoSuppliers
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridPromoSuppliersDBTableView1_SupplierID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'SUPPLIERID'
      end
      object cxGridPromoSuppliersDBTableView1_SupplierName: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'SUPPLIER_NAME'
        Width = 405
      end
    end
    object cxGridPromoSuppliersLevel1: TcxGridLevel
      GridView = cxGridPromoSuppliersDBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 152
    Top = 268
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 240
    Top = 268
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryPromoSuppliers: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PROMOS_SUPPLIERS'
      '  (PROMOACTIONID, PROMOACTION_TITLE, SUPPLIERID, SUPPLIER_NAME)'
      'VALUES'
      
        '  (:PROMOACTIONID, :PROMOACTION_TITLE, :SUPPLIERID, :SUPPLIER_NA' +
        'ME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_PROMOS_SUPPLIERS'
      'WHERE'
      
        '  PROMOACTIONID = :Old_PROMOACTIONID AND SUPPLIERID = :Old_SUPPL' +
        'IERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PROMOS_SUPPLIERS'
      'SET'
      
        '  PROMOACTIONID = :PROMOACTIONID, PROMOACTION_TITLE = :PROMOACTI' +
        'ON_TITLE, SUPPLIERID = :SUPPLIERID, SUPPLIER_NAME = :SUPPLIER_NA' +
        'ME'
      'WHERE'
      
        '  PROMOACTIONID = :Old_PROMOACTIONID AND SUPPLIERID = :Old_SUPPL' +
        'IERID')
    SQLRefresh.Strings = (
      
        'SELECT PROMOACTIONID, PROMOACTION_TITLE, SUPPLIERID, SUPPLIER_NA' +
        'ME FROM VW_TWEB_PROMOS_SUPPLIERS'
      'WHERE'
      '  PROMOACTIONID = :PROMOACTIONID AND SUPPLIERID = :SUPPLIERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PROMOS_SUPPLIERS'
      'WHERE'
      
        'PROMOACTIONID = :Old_PROMOACTIONID AND SUPPLIERID = :Old_SUPPLIE' +
        'RID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_PROMOS_SUPPLIERS'
      ''
      ') q')
    SQL.Strings = (
      'select * from VW_TWEB_PROMOS_SUPPLIERS'
      'order by supplier_name')
    MasterFields = 'PROMOACTIONID'
    DetailFields = 'PROMOACTIONID'
    Left = 200
    Top = 152
  end
  object IBCDataSourcePromoSuppliers: TIBCDataSource
    DataSet = IBCQueryPromoSuppliers
    Left = 80
    Top = 144
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 176
    Top = 48
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 628
      FloatTop = 159
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddSupplier'
        end
        item
          Visible = True
          ItemName = 'bbDeleteSupplier'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbAddSupplier: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      OnClick = bbAddSupplierClick
    end
    object bbDeleteSupplier: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      OnClick = bbDeleteSupplierClick
    end
  end
end
