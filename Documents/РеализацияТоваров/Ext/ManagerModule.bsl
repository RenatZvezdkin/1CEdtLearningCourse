﻿
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Документы.РеализацияТоваров.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваров.Дата,
	|	РеализацияТоваров.Клиент,
	|	РеализацияТоваров.Номер,
	|	РеализацияТоваров.Ответственный,
	|	РеализацияТоваров.Склад,
	|	РеализацияТоваров.Товары.(
	|		Товар,
	|		Цена,
	|		Количество,
	|		Итого
	|	)
	|ИЗ
	|	Документ.РеализацияТоваров КАК РеализацияТоваров
	|ГДЕ
	|	РеализацияТоваров.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТоварыШапка = Макет.ПолучитьОбласть("ТоварыШапка");
	ОбластьТовары = Макет.ПолучитьОбласть("Товары");
	Подвал = Макет.ПолучитьОбласть("Подвал");

	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьТоварыШапка);
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
			ТабДок.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());
		КонецЦикла;

		Подвал.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Подвал);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
