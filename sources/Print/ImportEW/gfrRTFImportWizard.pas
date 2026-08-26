//******************************************************************************
//                                                      (c) корпорация Галактика
//                                                       http://www.galaktika.by
// Галактика 8.10 - Отчетность FastReport 3
// Модуль импорта из RTF DOC
//******************************************************************************

{
  Для разбора RTF файлов используется библиотека RichView 1.9.24  http://www.trichview.com
}

unit gfrRTFImportWizard;

interface

uses
  Windows
  , Forms
  , Graphics
  , Dialogs
  , StdCtrls
  , Controls
  , ComCtrls
  , Classes
  , Buttons
  , strUtils
  , sysUtils
  , frxClass
  , frxDsgnIntf
  , frxDesgn
  , RVOfficeCnv
  , RVStyle
  , RVScroll
  , RichView
  , RvTable
  , CRvData
  , RVItem
  , CRVFData
  , RVMarker
  ;

type
  TRTFImportForm = class(TForm)
    RVStyle1 : TRVStyle;
    StBar : TStatusBar;
    OpenDialog : TOpenDialog;
    RVC : TRVOfficeConverter;
    RichView1 : TRichView;
    GroupBox1: TGroupBox;
    CheckBoxNoFcom: TCheckBox;
    ButtonImp: TButton;
    CheckBoxNoPicture: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ButtonImpClick(Sender: TObject);
    procedure RVCConverting(Sender: TObject; Percent: Integer);
    procedure RVOnProgress(Sender       : TCustomRichView;
                           Operation    : TRVLongOperation;
                           Stage        : TRVProgressStage;
                           PercentDone  : Byte);
  private
    procedure Import;
    function  OpenRtfFile : boolean;
    procedure DropFcom;
    function  importOneTable( curFormattedData : TCustomRVFormattedData;
                              curItemInfo      : TCustomRVItemInfo;
                              curPage          : TfrxReportPage;
                              curDrawNo        : integer;
                              needCorrection   : boolean;
                              corrLeft         : extended;
                              corrTop          : extended) : integer;
  public
    FDesigner : TfrxCustomDesigner;
    FReport   : TfrxReport;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

  TfrxRTFImportWizard = class(TfrxCustomWizard) class
    function GetDescription: String; override;
    function Execute: Boolean; override;
  end;

threadvar RTFImportForm: TRTFImportForm;

implementation

uses DLines;

threadvar bmp: Graphics.TBitmap;
    maxWidth, maxHeight : Extended;
    curTopCorrection    : Extended;

const RTFWizardCaption = 'Импорт формы отчета из RTF';

const ScaleKoef = 1;

{$R *.dfm}
{$R *.res}

{ TfrxRTFImportWizard }

function TfrxRTFImportWizard.Execute: Boolean;
begin
  { запрещаем любые отрисовки в дизайнере }
  Designer.Lock;

  RTFImportForm := TRTFImportForm.Create(Report);
  try
    RTFImportForm.FDesigner := Designer;
    RTFImportForm.FReport := Report;

    RTFImportForm.ShowModal;
  finally
    RTFImportForm.Free;

    Designer.ReloadPages(Report.PagesCount - 1);
    result := true;
  end;
end;

class function TfrxRTFImportWizard.GetDescription: String;
begin
  result := RTFWizardCaption;
end;

{ TRTFImportForm }

procedure TRTFImportForm.FormShow(Sender: TObject);
begin
  Caption := RTFWizardCaption;
end;

constructor TRTFImportForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRTFImportForm.Destroy;
begin
  inherited Destroy;
end;
// =============================================================================
procedure TRTFImportForm.ButtonImpClick(Sender: TObject);
begin
  try
    RichView1.Width := 720; // 720 - точек примерно соответвует ширине листа A4 в FR.

    if OpenRtfFile then
      Import;
  except
  end;

  ModalResult := mrOk;
end; // ButtonImpClick

function TRTFImportForm.OpenRtfFile : boolean;
var
  r : boolean;
begin
  result := false;

  if Assigned(frxDesignerComp) then
    OpenDialog.InitialDir := frxDesignerComp.OpenDir;

  OpenDialog.Filter := 'Документ RTF|*.rtf|' + rvc.GetImportFilter;

  if not OpenDialog.Execute then
    exit;

  try
    RichView1.Clear;

    if OpenDialog.FilterIndex=1 then
      r := RichView1.LoadRTF(OpenDialog.FileName)
    else
      r:= RVC.ImportRV(OpenDialog.FileName, RichView1, OpenDialog.FilterIndex-2);

    if not r then
      Application.MessageBox('Ошибка открытия файла', 'Error', 0);

    RichView1.Format;

    //laalaa
    //FillItemsList;
    result := true;
  except
    Application.MessageBox('Ошибка открытия файла', 'Error', 0);
  end;
end; // OpenRtfFile

procedure SetMaxMemoBounds(memo : TfrxMemoView);
begin
  if maxHeight < (memo.Top + memo.Height) then
    maxHeight := memo.Top + memo.Height;
  if maxWidth < (memo.Left + memo.Width) then
    maxWidth := memo.Left + memo.Width;
end; // SetMaxMemoBounds

type TSkipBlock = record
       SkipBegin : integer;
       SkipEnd   : integer;
       PageBreak : boolean;
end;

procedure TRTFImportForm.DropFcom;
var
  CurItem, ItemCount      : integer;
  Item                    : TCustomRVItemInfo;
  ParaBegin, ParaEnd      : integer;
  ParaText                : wideString;
  SkipBlock, ManyForms    : boolean;
  SkipBegin, SkipEnd      : integer;
  Skips                   : array of TSkipBlock;

  procedure isSkipped;
  begin
    if Length(ParaText) > 0 then
    begin
      if SkipBlock then
      begin
        if (Pos('.ENDFIELDS', ParaText) = 1)
        or (Pos('.ENDVAR',    ParaText) = 1)
        or (Pos('#END',       ParaText) = 1)
        or (Pos('END.',       ParaText) = 1)
        or (Pos('*/',         ParaText) = 1) then
        begin
          SkipBlock := false;
          SkipEnd   := ParaEnd;

          SetLength(Skips, Length(Skips) + 1);
          Skips[high(Skips)].SkipBegin := SkipBegin;
          Skips[high(Skips)].SkipEnd   := SkipEnd;
          Skips[high(Skips)].PageBreak := false;
        end;
      end
      else
      begin
        if (Pos('.FIELDS',  ParaText) = 1)
        or (Pos('.BEGIN',   ParaText) = 1)
        or (Pos('.VAR',     ParaText) = 1)
        or (Pos('#DOC',     ParaText) = 1)
        or (Pos('#IFDEF',   ParaText) = 1)
        or (Pos('#IFNDEF',  ParaText) = 1)
        or (Pos('/*',       ParaText) = 1) then
        begin
          SkipBlock := true;
          SkipBegin := ParaBegin;
          SkipEnd   := ParaEnd;
        end
        else
        if (Pos('.FORM', ParaText) = 1)
        or (Pos('.LINKFORM', ParaText) = 1) then
        begin
          SkipBegin := ParaBegin;
          SkipEnd   := ParaEnd;

          SetLength(Skips, Length(Skips)+1);
          Skips[high(Skips)].SkipBegin := SkipBegin;
          Skips[high(Skips)].SkipEnd   := SkipEnd;

          // если в файле несколько форм разбить их на разные страницы
          Skips[high(Skips)].PageBreak := ManyForms;
          ManyForms := true;
        end
        else
        if (ParaText[1] = '.')
        or (ParaText[1] = '!')
        or (ParaText[1] = '//')
        or (Pos('#INCLUDE', ParaText) = 1) then
        begin
          SkipBegin := ParaBegin;
          SkipEnd   := ParaEnd;

          SetLength(Skips, Length(Skips)+1);
          Skips[high(Skips)].SkipBegin := SkipBegin;
          Skips[high(Skips)].SkipEnd   := SkipEnd;
          Skips[high(Skips)].PageBreak := false;
        end;
      end;
    end;
  end;

  procedure isSkippedInTable(Item : TcustomRVItemInfo);
  var i, j, k           : integer;
      table             : TRVTableItemInfo;
      cell              : TRVTableCellData;
      TableSkips        : array of TSkipBlock;
      curFormattedData  : TCustomRVFormattedData;
      Wtxt              : WideString;
      begSkip, endSkip  : integer;
      SkippedBlock      : boolean;
  begin
    begSkip :=0;
    SkippedBlock := false;
    SetLength(TableSkips, 0);
    table := TRVTableItemInfo(Item);

    for j := 0 to table.RowCount - 1 do
    begin
    Wtxt := '';
    cell := table.Cells[j, 0];

    if cell <> nil then
    begin
      curFormattedData := TCustomRVFormattedData(cell.GetRVData);
      for k := 0 to curFormattedData.ItemCount-1 do
        if (curFormattedData.GetItem(k) <> nil) and (curFormattedData.GetItem(k) is TRVTextItemInfo) then
          WTxt := Wtxt + curFormattedData.GetItemTextW(k);

        Wtxt := trim(WideUpperCase(wTxt));

        if (Length(WTxt) > 0) then
        begin
          if SkippedBlock then
          begin
            if (Pos('.ENDFIELDS', WTxt) = 1)
            or (Pos('.ENDVAR',    WTxt) = 1)
            or (Pos('#END',       WTxt) = 1)
            or (Pos('END.',       WTxt) = 1)
            or (Pos('*/',         WTxt) = 1) then
            begin
              SkippedBlock := false;
              endSkip   := j;

              SetLength(TableSkips, Length(TableSkips) + 1);
              TableSkips[high(TableSkips)].SkipBegin := begSkip;
              TableSkips[high(TableSkips)].SkipEnd   := endSkip;
              TableSkips[high(TableSkips)].PageBreak := false;
            end;
          end
          else
          begin
            if (Pos('.FIELDS',  WTxt) = 1)
            or (Pos('.BEGIN',   WTxt) = 1)
            or (Pos('.VAR',     WTxt) = 1)
            or (Pos('#DOC',     WTxt) = 1)
            or (Pos('/*',       WTxt) = 1) then
            begin
              SkippedBlock := true;
              begSkip := j;
            end
            else
            if (Pos('.FORM', WTxt) = 1)
            or (Pos('.LINKFORM', WTxt) = 1) then
            begin
              begSkip := j;
              endSkip := j;

              SetLength(TableSkips, Length(TableSkips)+1);
              TableSkips[high(Skips)].SkipBegin := begSkip;
              TableSkips[high(Skips)].SkipEnd   := endSkip;

              // если в файле несколько форм разбить их на разные страницы
              TableSkips[high(TableSkips)].PageBreak := ManyForms;
              ManyForms := true;
            end
            else
            if (WTxt[1] = '.')
            or (WTxt[1] = '!')
            or (WTxt[1] = '//')
            or (Pos('#INCLUDE', WTxt) = 1) then
            begin
              begSkip   := j;
              endSkip   := j;

              SetLength(TableSkips, Length(TableSkips)+1);
              TableSkips[high(TableSkips)].SkipBegin := begSkip;
              TableSkips[high(TableSkips)].SkipEnd   := endSkip;
              TableSkips[high(TableSkips)].PageBreak := false;
            end;
          end;
        end;
      end;
    end;

  if length(TableSkips) > 0 then
    for i := high(TableSkips) downto low(TableSkips) do
      table.DeleteRows(TableSkips[i].SkipBegin, TableSkips[i].SkipEnd - TableSkips[i].SkipBegin + 1, false);
  end;

  procedure processSkips(Skips : array of TSkipBlock);
  var i : integer;
  begin
  for i := high(Skips) downto low(Skips) do
  begin
    // добавить разбивку на страницы после удаляемого элемента
    if (Skips[i].PageBreak) and ((Skips[i].SkipEnd + 1) < RichView1.RVData.Items.Count) then
      RichView1.RVData.GetItem(Skips[i].SkipEnd + 1).PageBreakBefore := true;

    RichView1.DeleteItems(Skips[i].SkipBegin, Skips[i].SkipEnd - Skips[i].SkipBegin + 1);
  end;
  end;

begin
  CurItem   := 0;
  ItemCount := RichView1.RVData.Items.Count;

  SkipBlock := false;
  ManyForms := false;

  SetLength(Skips, 0);

  while CurItem < ItemCount do
  begin
    Item := RichView1.RVData.GetItem(CurItem);

    if RichView1.RVData.IsParaStart(CurItem) and (Item is TRVTextItemInfo) then
    begin
      // определить границы и текст прараграфа
      ParaBegin := CurItem;
      ParaEnd   := CurItem;
      ParaText  := RichView1.RVData.GetItemTextW(CurItem);
      inc(CurItem);

      while (CurItem < ItemCount) and (not RichView1.RVData.IsParaStart(CurItem)) do
      begin
        ParaEnd  := CurItem;
        ParaText := ParaText + RichView1.RVData.GetItemTextW(CurItem);
        inc(CurItem);
      end;

      ParaText := trim(WideUpperCase(ParaText));
      isSkipped;
    end
    else if Item is TRVTableItemInfo then
    begin
      isSkippedInTable(Item);
      inc(CurItem);
    end
    else
    begin
      inc(CurItem);
    end;
  end;

  processSkips(Skips);
  SetLength(Skips, 0);
  RichView1.Format;
end; // DropFCOMInTable

  // импорт таблиц
function TRTFImportForm.importOneTable(curFormattedData    : TCustomRVFormattedData;
                                       curItemInfo         : TCustomRVItemInfo;
                                       curPage             : TfrxReportPage;
                                       curDrawNo           : integer;
                                       needCorrection      : boolean;
                                       corrLeft            : extended;
                                       corrTop             : extended) : integer;
  var
    table                               : TRVTableItemInfo;
    j, k, l, rowCnt, colCnt             : integer;
    curCell                             : TRVTableCellData;
    curCellFormattedData                : TCustomRVFormattedData;
    Wtxt                                : WideString;
    FirstNotEmptyItemIsFound            : boolean;
    InCellItemStyleNo, curCellItemIdx   : integer;
    memo                                : TfrxMemoView;
    curGraphInfo                        : TRVGraphicItemInfo;
    pict                                : TfrxPictureView;

  begin
    result := 0;
    table := TRVTableItemInfo(curItemInfo);

    rowCnt := table.RowCount;
    colCnt := table.ColCount;

    for j := 0 to rowCnt-1 do
      for k := 0 to colCnt-1 do
        if table.Cells[j,k] <> nil then
        begin
          curCell := table.Cells[j,k];

          memo := TfrxMemoView.Create(curPage);
          memo.CreateUniqueName;

          // расчет текста и шрифта
          Wtxt := '';
          FirstNotEmptyItemIsFound := false;

          curCellFormattedData := TCustomRVFormattedData(curCell.GetRVData);

          for curCellItemIdx:=0 to curCellFormattedData.ItemCount-1 do
            if (curCellFormattedData.GetItem(curCellItemIdx) <> nil) then
              if (curCellFormattedData.GetItem(curCellItemIdx) is TRVTextItemInfo) then
              begin
                if (curCellItemIdx > 0) and curCellFormattedData.IsParaStart(curCellItemIdx) then
                  Wtxt := Wtxt + widestring(#13#10);

                Wtxt := Wtxt + curCellFormattedData.GetItemTextW(curCellItemIdx);

                if not FirstNotEmptyItemIsFound then
                  if Trim(curCellFormattedData.GetItemTextW(curCellItemIdx))<>'' then
                  begin
                    FirstNotEmptyItemIsFound := true;

                    InCellItemStyleNo := curCellFormattedData.GetItem(curCellItemIdx).StyleNo;

                    memo.Font.Name  := RVStyle1.TextStyles[InCellItemStyleNo].FontName;
                    memo.Font.Color := RVStyle1.TextStyles[InCellItemStyleNo].Color;
                    memo.Font.Size  := RVStyle1.TextStyles[InCellItemStyleNo].Size;
                    memo.Font.Style := RVStyle1.TextStyles[InCellItemStyleNo].Style;

                    // горизонтальное выравнивание
                    case RVStyle1.ParaStyles[curCellFormattedData.GetItem(curCellItemIdx).ParaNo].Alignment of
                      rvaLeft     : memo.HAlign := haLeft;
                      rvaRight    : memo.HAlign := haRight;
                      rvaCenter   : memo.HAlign := haCenter;
                      rvaJustify  : memo.HAlign := haBlock;
                    end;
                  end;
              end
              else if (curCellFormattedData.GetItem(curCellItemIdx) is TRVTableItemInfo) then
                importOneTable(curFormattedData, curCellFormattedData.GetItem(curCellItemIdx), curPage, curDrawNo, true,
                               corrLeft+curCell.Left+curCellFormattedData.DrawItems[curCellFormattedData.FindDrawItemByItem(curCellItemIdx)].Left+2,
                               corrTop+curCell.Top+curCellFormattedData.DrawItems[curCellFormattedData.FindDrawItemByItem(curCellItemIdx)].Top+2)
              else if ((curCellFormattedData.GetItem(curCellItemIdx) is TRVGraphicItemInfo) and
                       (not CheckBoxNoPicture.Checked)) then
              begin
              // импорт картинки
                curGraphInfo := TRVGraphicItemInfo(curCellFormattedData.GetItem(curCellItemIdx));
                pict := TfrxPictureView.Create(curPage);
                pict.CreateUniqueName;

                if not needCorrection then
                begin
                  pict.Left   := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Left + curCell.Left)+1;
                  pict.Top    := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Top + curCell.Top - curTopCorrection) + 1;
                  pict.Width  := ScaleKoef * curCell.Width;
                  pict.Height := ScaleKoef * curCell.Height;
                end
                else
                begin
                  pict.Left   := ScaleKoef * (corrLeft + curFormattedData.DrawItems[curDrawNo].Left + curCell.Left) + 1;
                  pict.Top    := ScaleKoef * (corrTop + curFormattedData.DrawItems[curDrawNo].Top + curCell.Top - curTopCorrection) + 1;
                  pict.Width  := ScaleKoef * curCell.Width - 1;
                  pict.Height := ScaleKoef * curCell.Height - 1;
                end;

                pict.Picture.Graphic := curGraphInfo.AsImage;
              end;
          memo.Memo.Text := Wtxt;

          if not needCorrection then
          begin
            memo.Left   := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Left + curCell.Left);
            memo.Top    := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Top + curCell.Top - curTopCorrection);
            memo.Width  := ScaleKoef * (curCell.Width + 1);
            memo.Height := ScaleKoef * (curCell.Height + 1);
          end
          else
          begin
            memo.Left   := ScaleKoef * (corrLeft + curFormattedData.DrawItems[curDrawNo].Left + curCell.Left);
            memo.Top    := ScaleKoef * (corrTop + curFormattedData.DrawItems[curDrawNo].Top + curCell.Top - curTopCorrection);
            memo.Width  := ScaleKoef * (curCell.Width + 1);
            memo.Height := ScaleKoef * (curCell.Height + 1);
          end;
          SetMaxMemoBounds(memo);

          // вертикальное выравнивание
          case curCell.VAlign of
            rvcTop    : memo.VAlign := vaTop;
            rvcMiddle : memo.VAlign := vaCenter;
            rvcBottom : memo.VAlign := vaBottom;
          end;

          if curCell.VisibleBorders.Top then
            memo.Frame.Typ := memo.Frame.Typ + [ftTop];
          if curCell.VisibleBorders.Bottom then
            memo.Frame.Typ := memo.Frame.Typ + [ftBottom];
          if curCell.VisibleBorders.Left then
            memo.Frame.Typ := memo.Frame.Typ + [ftLeft];
          if curCell.VisibleBorders.Right then
            memo.Frame.Typ := memo.Frame.Typ + [ftRight];

          memo.Color := curCell.Color;
          memo.Frame.Color := curCell.BorderColor;

          if (memo.Text = '') and (memo.Frame.Typ = []) then
            memo.Free;
        end;

    inc(result);
  end; // importOneTable

procedure TRTFImportForm.Import;
var
  curFormattedData    : TCustomRVFormattedData;
  curDrawNo           : integer;
  curDrawCount        : integer;
  curItemNo           : integer;
  curItemInfo         : TCustomRVItemInfo;

  memo                : TfrxMemoView;
  curPage             : TfrxReportPage;

  ProgressBar         : TProgressBar;

  procedure CreateNewPage;
  begin
    if (curPage = nil) and (FReport.Pages[FReport.PagesCount-1] is TfrxReportPage)
    and (FReport.Pages[FReport.PagesCount-1].Objects.Count = 0) then
      curPage := TfrxReportPage(FReport.Pages[FReport.PagesCount-1])
    else
    begin
      curPage := TfrxReportPage.Create(FReport);
      curPage.CreateUniqueName;
      curPage.SetDefaults;
    end;

    maxWidth := 0;
    maxHeight := 0;
  end;

  procedure EnlargeCurPage;
  begin
    if (CurPage.PaperHeight - CurPage.LeftMargin - CurPage.RightMargin) * fr01cm < maxHeight then
      CurPage.PaperHeight := CurPage.LeftMargin + CurPage.RightMargin + (maxHeight + 10) / fr01cm;

    if (CurPage.PaperWidth - CurPage.TopMargin - CurPage.BottomMargin) * fr01cm < maxWidth then
      CurPage.PaperWidth := CurPage.TopMargin + CurPage.BottomMargin + (maxWidth + 10) / fr01cm;
  end;

  procedure NextDrawNo;
  begin
    Application.ProcessMessages;
    inc(curDrawNo);
    ProgressBar.Position := curDrawNo;
  end;

  // имопорт одного парграфа
  procedure importOneParagraph;
  var
    curTextItemInfo : TRVTextItemInfo;
    wtxt            : WideString;
    x1,x2,y1,y2     : extended;
  begin
    // текст параграфа будет склеиватся из Item-ов параграфа
    wtxt := curFormattedData.GetItemTextW(CurItemNo);

    if trim(wtxt) <> '' then
    begin
      // параграф уже не пустой - будем импортить
      memo := TfrxMemoView.Create(curPage);
      memo.CreateUniqueName;

      curTextItemInfo := TRVTextItemInfo(curItemInfo); // первый Item из первого DrawItem-а

      memo.Font.Name  :=  RVStyle1.TextStyles[curTextItemInfo.StyleNo].FontName;  // из первого Item-а
      memo.Font.Color :=  RVStyle1.TextStyles[curTextItemInfo.StyleNo].Color;     // из первого Item-а
      memo.Font.Size  :=  RVStyle1.TextStyles[curTextItemInfo.StyleNo].Size;      // из первого Item-а
      memo.Font.Style :=  RVStyle1.TextStyles[curTextItemInfo.StyleNo].Style;     // из первого Item-а

      memo.Color := RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Background.Color; // из первого Item-а

      case RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Alignment of               // из первого Item-а
        rvaLeft     : memo.HAlign := haLeft;
        rvaRight    : memo.HAlign := haRight;
        rvaCenter   : memo.HAlign := haCenter;
        rvaJustify  : memo.HAlign := haBlock;
      end;

      //memo.Frame.Typ := [];
      //if RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Border.VisibleBorders.Top then         // из первого Item-а
      //  memo.Frame.Typ := memo.Frame.Typ + [ftTop];
      //if RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Border.VisibleBorders.Bottom then      // из первого Item-а
      //  memo.Frame.Typ := memo.Frame.Typ + [ftBottom];
      //if RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Border.VisibleBorders.Left then        // из первого Item-а
      //  memo.Frame.Typ := memo.Frame.Typ + [ftLeft];
      //if RVStyle1.ParaStyles[curTextItemInfo.ParaNo].Border.VisibleBorders.Right then       // из первого Item-а
      //  memo.Frame.Typ := memo.Frame.Typ + [ftRight];

      // координаты из первого DrawItem-а
      x1 := curFormattedData.DrawItems[curDrawNo].Left;
      x2 := curFormattedData.DrawItems[curDrawNo].Left + curFormattedData.DrawItems[curDrawNo].Width;
      y1 := curFormattedData.DrawItems[curDrawNo].Top;
      y2 := curFormattedData.DrawItems[curDrawNo].Top + curFormattedData.DrawItems[curDrawNo].Height;

      NextDrawNo;

      // координаты из других DrawItem-ов текущего Item-а
      while curDrawNo < curDrawCount do
      begin
        if curItemNo <> curFormattedData.DrawItems[curDrawNo].ItemNo then
          break;

        if curFormattedData.DrawItems[curDrawNo].Left < x1 then
          x1 := curFormattedData.DrawItems[curDrawNo].Left;

        if x2 < curFormattedData.DrawItems[curDrawNo].Left + curFormattedData.DrawItems[curDrawNo].Width then
          x2 := curFormattedData.DrawItems[curDrawNo].Left + curFormattedData.DrawItems[curDrawNo].Width;

        if curFormattedData.DrawItems[curDrawNo].Top < y1 then
          y1 := curFormattedData.DrawItems[curDrawNo].Top;

        if y2 < curFormattedData.DrawItems[curDrawNo].Top + curFormattedData.DrawItems[curDrawNo].Height then
          y2 := curFormattedData.DrawItems[curDrawNo].Top + curFormattedData.DrawItems[curDrawNo].Height;

        NextDrawNo;
      end;

      // текст и координаты из оставшихся DrawItem-ов и Item-ов до нового абзаца
      while curDrawNo < curDrawCount do
      begin
        // признак конца параграфа
        if curFormattedData.IsParaStart(curFormattedData.DrawItems[curDrawNo].ItemNo) then
          break;

        curItemInfo := curFormattedData.GetItem(curFormattedData.DrawItems[curDrawNo].ItemNo);

        // не текст тоже считаем признаком конца параграфа
        if not ( (curItemInfo is TRVTextItemInfo) or (curItemInfo is TRVTabItemInfo) )  then
          break;

        // подклеиваем текст из очередного Item-а параграфа
        if curItemNo <> curFormattedData.DrawItems[curDrawNo].ItemNo then
        begin
          curItemNo := curFormattedData.DrawItems[curDrawNo].ItemNo;
          wtxt := wtxt + curFormattedData.GetItemTextW(curItemNo);

          // to do здесь можно сделть расстановку НТМЛ тегов
        end;

        // расширяем координаты ячейки
        if curFormattedData.DrawItems[curDrawNo].Left < x1 then
          x1 := curFormattedData.DrawItems[curDrawNo].Left;

        if x2 < curFormattedData.DrawItems[curDrawNo].Left + curFormattedData.DrawItems[curDrawNo].Width then
          x2 := curFormattedData.DrawItems[curDrawNo].Left + curFormattedData.DrawItems[curDrawNo].Width;

        if curFormattedData.DrawItems[curDrawNo].Top < y1 then
          y1 := curFormattedData.DrawItems[curDrawNo].Top;

        if y2 < curFormattedData.DrawItems[curDrawNo].Top + curFormattedData.DrawItems[curDrawNo].Height then
          y2 := curFormattedData.DrawItems[curDrawNo].Top + curFormattedData.DrawItems[curDrawNo].Height;

        NextDrawNo;
      end;

      memo.Memo.Text := wtxt;

      memo.Left   := ScaleKoef * (x1);
      memo.Top    := ScaleKoef * (y1 - curTopCorrection);
      memo.Width  := ScaleKoef * (x2-x1);
      memo.Height := ScaleKoef * (y2-y1);

      SetMaxMemoBounds(memo);
    end
    else
      NextDrawNo; // пустые параграфы просто сразу пропускаем
  end;

  procedure importOneGraphic;
  var
    curGaphInfo : TRVGraphicItemInfo;
    pict        : TfrxPictureView;

  begin
    if not CheckBoxNoPicture.Checked then
    begin
      curGaphInfo := TRVGraphicItemInfo(curItemInfo);

      pict := TfrxPictureView.Create(curPage);

      pict.Left   := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Left);
      pict.Top    := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Top-curTopCorrection);
      pict.Width  := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Width);
      pict.Height := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Height);

      if maxHeight < (pict.Top + pict.Height) then
        maxHeight := pict.Top + pict.Height;

      if maxWidth < (pict.Left + pict.Width) then
        maxWidth := pict.Left + pict.Width;

      pict.Picture.Graphic := curGaphInfo.AsImage;
    end;

    NextDrawNo;
  end;

  procedure importOneMarker;
  var
    curMarkItemInfo : TRVMarkerItemInfo;
  begin
    memo := TfrxMemoView.Create(curPage);
    memo.CreateUniqueName;

    curMarkItemInfo := TRVMarkerItemInfo(curItemInfo);

    memo.Memo.Text := curMarkItemInfo.DisplayString;

    memo.Left   := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Left);
    memo.Top    := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Top-curTopCorrection);
    memo.Width  := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Width);
    memo.Height := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Height);

    SetMaxMemoBounds(memo);

    NextDrawNo;
  end;

begin
  //вычеркивание FCOM
  if CheckBoxNoFcom.Checked then
    DropFcom;

  curTopCorrection := 0;
  curPage := nil;
  CreateNewPage;

  RichView1.Format;

  curFormattedData := TCustomRVFormattedData(RichView1.RVData.GetRVData);

  curDrawCount := curFormattedData.DrawItems.Count;
  curDrawNo    := 0;

  ProgressBar := TProgressBar.Create(StBar);
  ProgressBar.Parent := StBar;
  ProgressBar.SetBounds(0, 2, StBar.Panels[0].Width, StBar.Height-2);
  ProgressBar.Min := 0;
  ProgressBar.Max := curDrawCount;
  ProgressBar.Position := curDrawNo;

  while curDrawNo < curDrawCount do
  begin
    curItemNo   := curFormattedData.DrawItems[curDrawNo].ItemNo;
    curItemInfo := curFormattedData.GetItem(curItemNo);

    if curItemInfo.PageBreakBefore then
    begin
      EnlargeCurPage;
      curTopCorrection := curFormattedData.DrawItems[curDrawNo].Top;
      CreateNewPage;
    end;

    if curItemInfo is TRVTextItemInfo then
      // имопорт одного парграфа
      importOneParagraph
    else if curItemInfo is TRVTableItemInfo then                          // TRVTableItemInfo
      // импорт одной таблицы
      curDrawNo := curDrawNo + importOneTable(curFormattedData, curItemInfo, curPage, curDrawNo, false, 0,0)
    else if curItemInfo is TRVMarkerItemInfo then
      // импорт маркеров
      importOneMarker
    else if curItemInfo is TRVGraphicItemInfo then
      // импорт картинки
      importOneGraphic
    else if curItemInfo is TRVTabItemInfo then
      // табуляцию просто пропускаем
      NextDrawNo
    else if RichView1.Visible then
    begin
      // отладочный режим импорта других элементов только если RichView видимый
      memo := TfrxMemoView.Create(curPage);
      memo.CreateUniqueName;

      memo.Memo.Text := IntToStr(curDrawNo) + ' ' + IntToStr(curItemNo) + ' ' + curItemInfo.ClassName;

      memo.Left      := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Left);
      memo.Top       := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Top-curTopCorrection);
      memo.Width     := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Width + 1);
      memo.Height    := ScaleKoef * (curFormattedData.DrawItems[curDrawNo].Height + 1);

      memo.Frame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
      memo.Color     := clYellow;

      if memo.Width < 100 then memo.Width := 100;
      if memo.Height < 20 then memo.Height := 20;

      SetMaxMemoBounds(memo);
      NextDrawNo;
    end;
  end;

  EnlargeCurPage;

  ProgressBar.Free;
end;

{procedure TRTFImportForm.FillItemsList;
var
  s                   : string;
  curDrawNo           : integer;
  curItemNo           : integer;
  curItemInfo         : TCustomRVItemInfo;
  curFormattedData    : TCustomRVFormattedData;
begin
//laalaa

  ListBox1.Clear;
  ListBox1.Items.BeginUpdate;
  curFormattedData := TCustomRVFormattedData(RichView1.RVData.GetRVData);
  for curDrawNo := 0 to curFormattedData.DrawItems.Count-1 do
  begin
    curItemNo := curFormattedData.DrawItems[curDrawNo].ItemNo;
    curItemInfo := curFormattedData.GetItem(curItemNo);
    s := IntToStr(curDrawNo) + ' ';
    s := s + IntToStr(curItemNo) + ' ';
    s := s + curItemInfo.ClassName + ' ';
    if curFormattedData.IsParaStart(curItemNo) then
      s := s + '===';
    s := s + curFormattedData.GetItemTextW(curItemNo);
    ListBox1.AddItem(s, nil);
  end;
  ListBox1.Items.EndUpdate;
end; }

//==============================================================================
procedure TRTFImportForm.RVCConverting(Sender: TObject; Percent: Integer);
begin
  Application.ProcessMessages;
end;

procedure TRTFImportForm.RVOnProgress(Sender: TCustomRichView;
  Operation: TRVLongOperation; Stage: TRVProgressStage; PercentDone: Byte);
begin
  Application.ProcessMessages;
end;

initialization
  Bmp := TBitmap.Create;
  Bmp.LoadFromResourceName(hInstance, 'FR3_WORD_BMP');
  frxWizards.Register(TfrxRTFImportWizard, Bmp, true);

finalization
  frxWizards.Unregister(TfrxRTFImportWizard);
  Bmp.Free;

end.
