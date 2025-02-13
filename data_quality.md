# 1.3. Качество данных

## Оцените, насколько качественные данные хранятся в источнике.
Опишите, как вы проверяли исходные данные и какие выводы сделали.

Проверка качества данных
- Определение дублей;
- Поиск пропущенных значений
- Проверка на некорректные типы данных;
- Проверка на неверные форматы записей.

Типы данных корректны, форматы записей верны.
Не хватает внешних ключей и ссылок, например: 
orders.user_id -> users.id,  
orders.status -> orderstatuses.id

## Укажите, какие инструменты обеспечивают качество данных в источнике.
Ответ запишите в формате таблицы со следующими столбцами:
- `Наименование таблицы` - наименование таблицы, объект которой рассматриваете.
- `Объект` - Здесь укажите название объекта в таблице, на который применён инструмент. Например, здесь стоит перечислить поля таблицы, индексы и т.д.
- `Инструмент` - тип инструмента: первичный ключ, ограничение или что-то ещё.
- `Для чего используется` - здесь в свободной форме опишите, что инструмент делает.


Используются ограничения (constraints) типа Check в различных таблицах
| production.orderitems | orderitems_check | Check  | (((discount >= (0)::numeric) AND (discount <= price))) |
| production.orderitems | orderitems_price_check | Check  | ((price >= (0)::numeric))

Используются первичные и внешние ключи для обеспечения уникальность записей и зависимостей
| production.orders | order_id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о заказах |
| production.orderstatuslog | order_id int4 NOT NULL foreign KEY | Внешний ключ  | Обеспечивает уникальность записей о заказах, в таблице orderstatuslog не появится заказ с order_id , которого нет в orders |
