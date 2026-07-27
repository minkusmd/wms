object frmWebMailingSenderProcessWin: TfrmWebMailingSenderProcessWin
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 201
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Padding.Left = 8
  Padding.Top = 8
  Padding.Right = 8
  Padding.Bottom = 8
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 448
    Height = 185
    Align = alClient
    Shape = bsFrame
    ExplicitLeft = 0
    ExplicitTop = 11
  end
  object pbProgressBar: TProgressBar
    Left = 24
    Top = 32
    Width = 309
    Height = 29
    TabOrder = 0
  end
  object btnStop: TButton
    Left = 348
    Top = 32
    Width = 90
    Height = 29
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object mmLog: TMemo
    Left = 24
    Top = 76
    Width = 414
    Height = 101
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
