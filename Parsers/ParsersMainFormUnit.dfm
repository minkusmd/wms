object frmParsersMain: TfrmParsersMain
  Left = 0
  Top = 0
  Caption = 'WMS Parsers - preturi de pe site-urile furnizorilor'
  ClientHeight = 640
  ClientWidth = 980
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 760
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 17
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 190
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblParsers: TLabel
      Left = 16
      Top = 12
      Width = 46
      Height = 17
      Caption = 'Parsere'
    end
    object lblServer: TLabel
      Left = 660
      Top = 12
      Width = 86
      Height = 17
      Caption = 'Server Firebird'
    end
    object lblUser: TLabel
      Left = 660
      Top = 68
      Width = 137
      Height = 17
      Caption = 'Utilizator WMS (UserID)'
    end
    object lblStatus: TLabel
      Left = 16
      Top = 162
      Width = 948
      Height = 17
      AutoSize = False
    end
    object clbParsers: TCheckListBox
      Left = 16
      Top = 34
      Width = 380
      Height = 118
      ItemHeight = 17
      TabOrder = 0
    end
    object rgMode: TRadioGroup
      Left = 412
      Top = 28
      Width = 232
      Height = 124
      Caption = ' Scriere in baza '
      ItemIndex = 0
      Items.Strings = (
        'UPDATE direct pe PRICE3'
        'Reevaluare noua (doc. 1414)')
      TabOrder = 1
    end
    object edServer: TEdit
      Left = 660
      Top = 34
      Width = 200
      Height = 25
      TabOrder = 2
    end
    object edUser: TEdit
      Left = 660
      Top = 90
      Width = 100
      Height = 25
      NumbersOnly = True
      TabOrder = 3
    end
    object btnRun: TButton
      Left = 660
      Top = 124
      Width = 150
      Height = 30
      Caption = 'Ruleaza'
      Default = True
      TabOrder = 4
      OnClick = btnRunClick
    end
    object btnStop: TButton
      Left = 818
      Top = 124
      Width = 100
      Height = 30
      Caption = 'Stop'
      Enabled = False
      TabOrder = 5
      OnClick = btnStopClick
    end
  end
  object mmLog: TMemo
    AlignWithMargins = True
    Left = 12
    Top = 193
    Width = 956
    Height = 435
    Margins.Left = 12
    Margins.Right = 12
    Margins.Bottom = 12
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
end
