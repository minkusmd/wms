   Изменен алгоритм кнопки "Расположить элементы в узлах сетки" (см. frxDesgn.pas)
   пригодится при выравнивании отчета после импорта

{******************************************}
{                                          }
{             FastReport v4.0              }
{                Designer                  }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

procedure TfrxDesignerForm.ToolButtonClick(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
  wasModified: Boolean;
  gx, gy, x1, x2, y1, y2: Extended;
  TheFont: TFont;

  procedure EditFont;
  begin
    with TFontDialog.Create(Application) do
    begin
      Font := TfrxComponent(FSelectedObjects[0]).Font;
      Options := Options + [fdForceFontExist];
      if Execute then
      begin
        TheFont := TFont.Create;
        TheFont.Assign(Font);
      end;
      Free;
    end;
  end;

  procedure SetFontStyle(c: TfrxComponent; fStyle: TFontStyle; Include: Boolean);
  begin
    with c.Font do
      if Include then
        Style := Style + [fStyle] else
        Style := Style - [fStyle];
  end;

  procedure SetFrameType(c: TfrxComponent; fType: TfrxFrameType; Include: Boolean);
  var
    f: TfrxFrame;
  begin
    if c is TfrxView then
      f := TfrxView(c).Frame
    else if c is TfrxReportPage then
      f := TfrxReportPage(c).Frame else
      Exit;

     with f do
      if Include then
        Typ := Typ + [fType] else
        Typ := Typ - [fType];
  end;

  procedure SetDMPFontStyle(c: TfrxComponent; fStyle: TfrxDMPFontStyle;
    Include: Boolean);
  var
    Style: TfrxDMPFontStyles;
  begin
    Style := [];
    if c is TfrxDMPMemoView then
      Style := TfrxDMPMemoView(c).FontStyle;
    if c is TfrxDMPLineView then
      Style := TfrxDMPLineView(c).FontStyle;
    if c is TfrxDMPPage then
      Style := TfrxDMPPage(c).FontStyle;
    if not Include then
      Style := Style + [fStyle] else
      Style := Style - [fStyle];
    if c is TfrxDMPMemoView then
      TfrxDMPMemoView(c).FontStyle := Style;
    if c is TfrxDMPLineView then
      TfrxDMPLineView(c).FontStyle := Style;
    if c is TfrxDMPPage then
      TfrxDMPPage(c).FontStyle := Style;
  end;

begin
  if FUpdatingControls then Exit;

  TheFont := nil;
  wasModified := False;
  if TComponent(Sender).Tag = 43 then
    EditFont;

  for i := 0 to FSelectedObjects.Count - 1 do
  begin
    c := FSelectedObjects[i];
    if rfDontModify in c.Restrictions then continue;

    case TComponent(Sender).Tag of

      0:  c.Font.Name := FontNameCB.Text;

      1:  c.Font.Size := StrToInt(FontSizeCB.Text);

      2:  SetFontStyle(c, fsBold, BoldB.Down);

      3:  SetFontStyle(c, fsItalic, ItalicB.Down);

      4:  SetFontStyle(c, fsUnderline, UnderlineB.Down);

      5:  c.Font.Color := FColor;

      6:;

      7..10:
          if c is TfrxCustomMemoView then
            with TfrxCustomMemoView(c) do
              if TextAlignLeftB.Down then
                HAlign := haLeft
              else if TextAlignCenterB.Down then
                HAlign := haCenter
              else if TextAlignRightB.Down then
                HAlign := haRight
              else
                HAlign := haBlock;

      11..13:
          if c is TfrxCustomMemoView then
            with TfrxCustomMemoView(c) do
              if TextAlignTopB.Down then
                VAlign := vaTop
              else if TextAlignMiddleB.Down then
                VAlign := vaCenter
              else
                VAlign := vaBottom;

      20: SetFrameType(c, ftTop, FrameTopB.Down);

      21: SetFrameType(c, ftBottom, FrameBottomB.Down);

      22: SetFrameType(c, ftLeft, FrameLeftB.Down);

      23: SetFrameType(c, ftRight, FrameRightB.Down);

      24: begin
            SetFrameType(c, ftTop, True);
            SetFrameType(c, ftBottom, True);
            SetFrameType(c, ftLeft, True);
            SetFrameType(c, ftRight, True);
          end;

      25: begin
            SetFrameType(c, ftTop, False);
            SetFrameType(c, ftBottom, False);
            SetFrameType(c, ftLeft, False);
            SetFrameType(c, ftRight, False);
          end;

      26: if c is TfrxView then
            TfrxView(c).Color := FColor
          else if c is TfrxReportPage then
            TfrxReportPage(c).Color := FColor
          else if c is TfrxDialogPage then
          begin
            TfrxDialogPage(c).Color := FColor;
            FWorkspace.Color := FColor;
          end
          else if c is TfrxDialogControl then
            TfrxDialogControl(c).Color := FColor;

      27: if c is TfrxView then
            TfrxView(c).Frame.Color := FColor
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Color := FColor;

      28: if c is TfrxView then
            TfrxView(c).Frame.Style := FLineStyle
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Style := FLineStyle;

      29: if c is TfrxView then
            TfrxView(c).Frame.Width := frxStrToFloat(FrameWidthCB.Text)
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.Width := frxStrToFloat(FrameWidthCB.Text);

      30: if c is TfrxCustomMemoView then
            TfrxCustomMemoView(c).Rotation := TMenuItem(Sender).HelpContext;

      31:
        begin
          gx := FWorkspace.GridX;
          gy := FWorkspace.GridY;

          x1 := c.left;
          x2 := c.left + c.width;
          y1 := c.top;
          y2 := c.top + c.height;

          x1 := Round(x1 / gx) * gx;
          x2 := Round(x2 / gx) * gx;
          y1 := Round(y1 / gy) * gy;
          y2 := Round(y2 / gy) * gy;

          c.left := x1;
          c.top := y1;
          c.Width := x2 - x1;
          c.Height := y2 - y1;

          if c.Width <= 0 then
            c.Width := gx;
          if c.Height <= 0 then
            c.Height := gy;
        end;

      32: if c is TfrxView then
            TfrxView(c).Frame.DropShadow := ShadowB.Down
          else if c is TfrxReportPage then
            TfrxReportPage(c).Frame.DropShadow := ShadowB.Down;

      33: if c is TfrxCustomMemoView then
            if StyleCB.ItemIndex = 0 then
              TfrxCustomMemoView(c).Style := '' else
              TfrxCustomMemoView(c).Style := StyleCB.Text;

      34: SetDMPFontStyle(c, fsxBold, BoldMI.Checked);

      35: SetDMPFontStyle(c, fsxItalic, ItalicMI.Checked);

      36: SetDMPFontStyle(c, fsxUnderline, UnderlineMI.Checked);

      37: SetDMPFontStyle(c, fsxSuperScript, SuperScriptMI.Checked);

      38: SetDMPFontStyle(c, fsxSubScript, SubScriptMI.Checked);

      39: SetDMPFontStyle(c, fsxCondensed, CondensedMI.Checked);

      40: SetDMPFontStyle(c, fsxWide, WideMI.Checked);

      41: SetDMPFontStyle(c, fsx12cpi, N12cpiMI.Checked);

      42: SetDMPFontStyle(c, fsx15cpi, N15cpiMI.Checked);

      43: if TheFont <> nil then
            c.Font := TheFont;
    end;

    if TComponent(Sender).Tag in [0..5, 20..29, 32] then
      if c is TfrxCustomMemoView then
      begin
        TfrxCustomMemoView(c).Style := '';
        StyleCB.Text := StyleCB.Items[0];
      end;

    if c is TfrxCustomMemoView then
      FSampleFormat.SetAsSample(TfrxCustomMemoView(c));
    wasModified := True;
  end;

  if TheFont <> nil then
    TheFont.Free;

  ScrollBox.SetFocus;
  if wasModified then
  begin
    FModifiedBy := Self;
    Modified := True;

    if TComponent(Sender).Tag in [24, 25, 34..43] then
      UpdateControls;
  end;
end;
