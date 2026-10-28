object frmGoodsTypeFolderSuggestDlg: TfrmGoodsTypeFolderSuggestDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Folder pentru tipul de produs'
  ClientHeight = 521
  ClientWidth = 763
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
    Width = 763
    Height = 64
    Title = 'Folder propus'
    Text = 'Folderele in care se afla produsele acestui tip'
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
    ImageIndex = 21
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 70
    Width = 747
    Height = 395
    TabOrder = 0
    object tvFolders: TcxGridDBTableView
      OnKeyDown = tvFoldersKeyDown
      OnCellDblClick = tvFoldersCellDblClick
      DataController.DataSource = IBCDataSourceFolders
      OptionsBehavior.IncSearch = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object tvFoldersGOODSID: TcxGridDBColumn
        Caption = 'Cod folder'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
      object tvFoldersTITLE: TcxGridDBColumn
        Caption = 'Denumire folder'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 540
      end
      object tvFoldersGOODS_COUNT: TcxGridDBColumn
        Caption = 'Nr. produse'
        DataBinding.FieldName = 'GOODS_COUNT'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvFolders
    end
  end
  object btnSelect: TcxButton
    Left = 474
    Top = 480
    Width = 90
    Height = 29
    Caption = 'Alege'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnOtherFolder: TcxButton
    Left = 8
    Top = 480
    Width = 129
    Height = 29
    Caption = 'Alt folder...'
    ModalResult = 4
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 570
    Top = 480
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryFolders: TIBCQuery
    SQL.Strings = (
      'select f.goodsid, f.title, count(*) goods_count'
      'from ts_goods g'
      'join ts_goods f on f.goodsid = g.parentid and f.flg_folder = 1'
      'where g.webgoodstype_id = :goodstypeid'
      '  and coalesce(g.flg_folder, 0) = 0'
      'group by f.goodsid, f.title'
      'order by 3 desc, 2')
    ReadOnly = True
    Left = 40
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'goodstypeid'
        Value = nil
      end>
  end
  object IBCDataSourceFolders: TIBCDataSource
    DataSet = IBCQueryFolders
    Left = 40
    Top = 104
  end
end
