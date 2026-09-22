object frmWebPopularCategoriesDlg: TfrmWebPopularCategoriesDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Categorii populare pe site'
  ClientHeight = 620
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 17
  object lblInfo: TLabel
    Left = 16
    Top = 12
    Width = 868
    Height = 34
    AutoSize = False
    Caption =
      'Categoriile afisate pe prima pagina a site-ului, in ordinea de ' +
      'mai jos. Mutati cu Sus / Jos (sau Ctrl+sageti), Del scoate cate' +
      'goria. Site-ul tine lista in cache pina la 24 de ore.'
    WordWrap = True
  end
  object lblDiscount: TLabel
    Left = 760
    Top = 232
    Width = 124
    Height = 17
    AutoSize = False
    Caption = 'Reducere afisata, %'
  end
  object lvCategories: TListView
    Left = 16
    Top = 56
    Width = 730
    Height = 400
    Columns = <
      item
        Alignment = taCenter
        Caption = 'Nr'
        Width = 40
      end
      item
        Caption = 'Categorie (RO)'
        Width = 210
      end
      item
        Caption = 'Categorie (RU)'
        Width = 200
      end
      item
        Caption = 'Categoria parinte'
        Width = 170
      end
      item
        Alignment = taCenter
        Caption = 'Reducere'
        Width = 65
      end
      item
        Alignment = taRightJustify
        Caption = 'ID'
        Width = 0
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnKeyDown = lvCategoriesKeyDown
    OnSelectItem = lvCategoriesSelectItem
  end
  object btnUp: TButton
    Left = 760
    Top = 56
    Width = 124
    Height = 36
    Caption = 'Sus'
    TabOrder = 1
    OnClick = btnUpClick
  end
  object btnDown: TButton
    Left = 760
    Top = 100
    Width = 124
    Height = 36
    Caption = 'Jos'
    TabOrder = 2
    OnClick = btnDownClick
  end
  object btnRemove: TButton
    Left = 760
    Top = 160
    Width = 124
    Height = 36
    Caption = 'Scoate din lista'
    TabOrder = 3
    OnClick = btnRemoveClick
  end
  object edDiscount: TEdit
    Left = 760
    Top = 254
    Width = 124
    Height = 25
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 4
    OnKeyDown = edDiscountKeyDown
  end
  object btnApplyDiscount: TButton
    Left = 760
    Top = 286
    Width = 124
    Height = 30
    Caption = 'Aplica reducerea'
    TabOrder = 5
    OnClick = btnApplyDiscountClick
  end
  object gbAdd: TGroupBox
    Left = 16
    Top = 468
    Width = 868
    Height = 90
    Caption = ' Adauga o categorie '
    TabOrder = 6
    object edSearch: TEdit
      Left = 14
      Top = 24
      Width = 300
      Height = 25
      TabOrder = 0
      TextHint = 'denumirea categoriei (RO sau RU)'
      OnKeyDown = edSearchKeyDown
    end
    object btnSearch: TButton
      Left = 322
      Top = 23
      Width = 100
      Height = 27
      Caption = 'Cauta'
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object cmbFound: TComboBox
      Left = 14
      Top = 56
      Width = 716
      Height = 25
      Style = csDropDownList
      DropDownCount = 20
      TabOrder = 2
      OnChange = cmbFoundChange
    end
    object btnAdd: TButton
      Left = 744
      Top = 55
      Width = 110
      Height = 27
      Caption = 'Adauga'
      Enabled = False
      TabOrder = 3
      OnClick = btnAddClick
    end
  end
  object btnOK: TButton
    Left = 16
    Top = 572
    Width = 200
    Height = 36
    Caption = 'Salveaza'
    ModalResult = 1
    TabOrder = 7
  end
  object btnCancel: TButton
    Left = 684
    Top = 572
    Width = 200
    Height = 36
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 8
  end
end
