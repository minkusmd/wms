unit geScale;

interface
uses Forms, Controls, vcl.Graphics;

procedure geAutoScale(MForm: TForm);

implementation
type
  TFooClass = class(TControl); { необходимо выяснить защищенность }

  { свойства Font }

procedure geAutoScale(MForm: TForm);
const

  cScreenWidth: integer = 800;
  cScreenHeight: integer = 600;
  cPixelsPerInch: integer = 96;
  cFontHeight: integer = -11; {В режиме проектирование значение из Font.Height}

var

  i: integer;

begin

  {
  ВАЖНО!! : Установите в Инспекторе Объектов свойство Scaled TForm в FALSE.

  Следующая программа масштабирует форму так, чтобы она выглядела одинаково
  внезависимости от размера экрана и пикселей на дюйм. Расположенный ниже
  участок кода проверяет, отличается ли размер экрана во время выполнения
  от размера во время проектирования. Если да, Scaled устанавливается в True
  и компоненты снова масштабируются так, чтобы они выводились в той же
  позиции экрана, что и во время проектирования.
  }
  if (Screen.width  > cScreenWidth) or (Screen.PixelsPerInch <>
    cPixelsPerInch) then
  begin
    MForm.scaled := TRUE;
    MForm.height := MForm.height * screen.Height div cScreenHeight;
    MForm.width := MForm.width * screen.width div cScreenWidth;
    MForm.ScaleBy(screen.width, cScreenWidth);

  end;

  {
  Этот код проверяет, отличается ли размер шрифта во времы выполнения от
  размера во время проектирования. Если во время выполнения pixelsperinch
  формы отличается от pixelsperinch во время проектирования, шрифты снова
  масштабируются так, чтобы форма не отличалась от той, которая была во
  время разработки. Масштабирование производится исходя из коэффициента,
  получаемого путем деления значения font.height во время проектирования
  на font.height во время выполнения. Font.size в этом случае работать не
  будет, так как это может дать результат больший, чем текущие размеры
  компонентов, при этом текст может оказаться за границами области компонента.
  Например, форма создана при размерах экрана 800x600 с установленными
  маленькими шрифтами, имеющими размер font.size = 8. Когда вы запускаете
  в системе с 800x600 и большими шрифтами, font.size также будет равен 8,
  но текст будет бОльшим чем при работе в системе с маленькими шрифтами.
  Данное масштабирование позволяет иметь один и тот же размер шрифтов
  при различных установках системы.
  }

  if (Screen.PixelsPerInch <> cPixelsPerInch) then
  begin

    for i := MForm.ControlCount - 1 downto 0 do
      TFooClass(MForm.Controls[i]).Font.Height :=
        (MForm.Font.Height div cFontHeight) *
        TFooClass(MForm.Controls[i]).Font.Height;

  end;

end;

end.
