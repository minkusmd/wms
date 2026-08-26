unit SamsoniteParserUnit;

interface

uses
  BaseWebParserUnit, System.SysUtils;

type
  TSamsoniteParser = class(TBaseWebParser)
  public
    procedure ParsePage(const PageContent: string); override;
  end;

implementation

{ TSamsoniteParser }

procedure TSamsoniteParser.ParsePage(const PageContent: string);
begin
  // Здесь код для парсинга страницы
  // Например, извлечение изображения с товаром
  // Использование регулярных выражений или манипуляция с DOM
  // Для примера, ищем ссылку на изображение

  // Это просто пример - код нужно адаптировать под реальный HTML
  // Пример может включать регулярные выражения или манипуляции с DOM
  // Как это делается в исходном коде с использованием `HTMLDocument`

  // Вставьте ваш код парсинга страницы здесь
  // Например, извлечь ссылку на изображение
  if Pos('product-tile__image', PageContent) > 0 then
  begin
    // Найдена ссылка на изображение, сохраняем его
    SaveImageToPNG('https://samsonite.md/some-image.jpg', 'product_image.png');
  end;
end;

end.

