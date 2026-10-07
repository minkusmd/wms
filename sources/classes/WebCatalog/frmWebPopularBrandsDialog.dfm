object frmWebPopularBrandsDlg: TfrmWebPopularBrandsDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Branduri populare pe site'
  ClientHeight = 674
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
  object lblSite: TLabel
    Left = 16
    Top = 16
    Width = 30
    Height = 17
    Caption = 'Site:'
  end
  object cmbSite: TComboBox
    Left = 56
    Top = 12
    Width = 320
    Height = 25
    Hint = 'Lista e separata pentru fiecare site (TWEB_SITE)'
    Style = csDropDownList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnChange = cmbSiteChange
  end
  object lblInfo: TLabel
    Left = 16
    Top = 44
    Width = 868
    Height = 40
    AutoSize = False
    Caption =
      'Brandurile din blocul de dupa slider, in ordinea de mai jos. Pe s' +
      'ite apar primele 12 cu logo si produse; daca sint mai putine, re' +
      'stul se completeaza automat. Sus / Jos (Ctrl+sageti) muta, Del s' +
      'coate. Site-ul reciteste lista in cel mult o ora.'
    WordWrap = True
  end
  object lvBrands: TListView
    Left = 16
    Top = 90
    Width = 590
    Height = 420
    Columns = <
      item
        Alignment = taCenter
        Caption = 'Nr'
        Width = 40
      end
      item
        Caption = 'Brand'
        Width = 190
      end
      item
        Alignment = taCenter
        Caption = 'Logo'
        Width = 60
      end
      item
        Alignment = taRightJustify
        Caption = 'Produse pe site'
        Width = 105
      end
      item
        Caption = 'Pe site'
        Width = 165
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
    OnKeyDown = lvBrandsKeyDown
    OnSelectItem = lvBrandsSelectItem
  end
  object btnUp: TButton
    Left = 620
    Top = 90
    Width = 125
    Height = 34
    Caption = 'Sus'
    TabOrder = 1
    OnClick = btnUpClick
  end
  object btnDown: TButton
    Left = 759
    Top = 90
    Width = 125
    Height = 34
    Caption = 'Jos'
    TabOrder = 2
    OnClick = btnDownClick
  end
  object btnRemove: TButton
    Left = 620
    Top = 132
    Width = 264
    Height = 34
    Caption = 'Scoate din lista'
    TabOrder = 3
    OnClick = btnRemoveClick
  end
  object pnlLogo: TPanel
    Left = 620
    Top = 184
    Width = 264
    Height = 150
    BevelOuter = bvLowered
    Color = clWhite
    Padding.Left = 12
    Padding.Top = 12
    Padding.Right = 12
    Padding.Bottom = 12
    ParentBackground = False
    TabOrder = 4
    object imgLogo: TImage
      Left = 13
      Top = 13
      Width = 238
      Height = 124
      Align = alClient
      Center = True
      Proportional = True
      Stretch = True
    end
  end
  object lblLogoState: TLabel
    Left = 620
    Top = 340
    Width = 264
    Height = 72
    AutoSize = False
    WordWrap = True
  end
  object btnLoadLogo: TButton
    Left = 620
    Top = 418
    Width = 264
    Height = 34
    Hint = 'PNG sau JPG, ideal PNG cu fundal transparent; se scrie in TS_BRANDS_IMAGE la Salveaza'
    Caption = 'Incarca logo...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnLoadLogoClick
  end
  object gbAdd: TGroupBox
    Left = 16
    Top = 522
    Width = 868
    Height = 90
    Caption = ' Adauga un brand '
    TabOrder = 6
    object edSearch: TEdit
      Left = 14
      Top = 24
      Width = 300
      Height = 25
      TabOrder = 0
      TextHint = 'denumirea brandului'
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
    Top = 626
    Width = 200
    Height = 36
    Caption = 'Salveaza'
    ModalResult = 1
    TabOrder = 7
  end
  object btnCancel: TButton
    Left = 684
    Top = 626
    Width = 200
    Height = 36
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 8
  end
end
