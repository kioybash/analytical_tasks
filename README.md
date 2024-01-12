# My Analytical Tasks Portfolio
📌 **В практической части этого проекта мы будем анализировать наш сервис и рассчитывать несколько важных показателей, характеризующих его работу.** 

📌**Будем писать SQL-запросы и визуализировать их результат с помощью графиков в _Redash_.**

📌**В конце проекта из всех построенных графиков будут собраны дашборды.**

------------

 ## 🔵 Схема, структура и наполнение таблиц базы данных нашего сервиса
**Типы данных:** В таблицах могут храниться разные типы данных: целые и дробные числа, текст, даты, массивы из чисел. 

**🔷Структура и наполнение таблиц:** 

**🔸user_actions** — действия пользователей с заказами.

| Столбец  | Тип данных  | Описание                                                                                          |
|----------|-------------|---------------------------------------------------------------------------------------------------|
| user_id  | INT         | id пользователя                                                                                   |
| order_id | INT         | id заказа                                                                                         |
| action   | VARCHAR(50) | действие пользователя с заказом; 'create_order' — создание заказа, 'cancel_order' — отмена заказа |
| time     | TIMESTAMP   | время совершения действия                                                                         |



**🔸courier_actions** — действия курьеров с заказами.

| Столбец    | 	Тип данных | 	Описание                                                                                        |
|------------|-------------|--------------------------------------------------------------------------------------------------|
| courier_id | 	INT	id     | курьера                                                                                          |
| order_id   | INT	        | id заказа                                                                                        |
| action     | VARCHAR(50) | 	действие курьера с заказом; 'accept_order' — принятие заказа, 'deliver_order' — доставка заказа |
| time	      | TIMESTAMP   | 	время совершения действия                                                                       |

**🔸orders** — информация о заказах.

| Столбец	      | Тип данных | 	Описание                  |
|---------------|------------|----------------------------|
| order_id	     | INT	       | id заказа                  | 
| reation_time	 | TIMESTAMP	 | время создания заказа      |
| product_ids	  | integer[]	 | список id товаров в заказе |

**🔸users** — информация о пользователях.

| Столбец	     | Тип данных   | 	Описание                                 |
|--------------|--------------|-------------------------------------------|
| user_id 	    | INT 	        | id пользователя                           |
| birth_date 	 | DATE	        | дата рождения                             |
| sex 	        | VARCHAR(50)	 | пол; 'male' — мужской, 'female' — женский |

**🔸couriers** — информация о курьерах.

| Столбец	   | Тип данных	  | Описание                                   |
|------------|--------------|--------------------------------------------|
| courier_id | 	INT         | 	id курьера                                |
| birth_date | 	DATE        | 	дата рождения                             |
| sex        | 	VARCHAR(50) | 	пол; 'male' — мужской, 'female' — женский |

**🔸products** — информация о товарах, которые доставляет сервис.

| Столбец	   | Тип данных    | 	Описание       |
|------------|---------------|-----------------|
| product_id | 	INT          | 	id продукта    |
| name       | 	VARCHAR(50)	 | название товара |
| price      | 	FLOAT(4)     | 	цена товара    |

**🔷Схема базы данных:** 

![img.png](img.png)

**🔷Данные:**

Данные для наполнения БД использовал с учебной платформы Karpov.Courses.

------------

## 🔵Построение дашбордов

**Задача 1:** 

Для начала проанализируем, насколько быстро растёт аудитория нашего сервиса, и посмотрим на динамику числа пользователей и курьеров.

**Пояснение:** Для каждого дня, представленного в таблицах _**user_actions**_ и _**courier_actions**_, рассчитаем следующие показатели:

* Число новых пользователей.
* Число новых курьеров.
* Общее число пользователей на текущий день.
* Общее число курьеров на текущий день.

Колонки с показателями назовём соответственно **new_users, new_couriers, total_users, total_couriers**. Колонку с датами назовите **date**. Проследим за тем, чтобы показатели были выражены целыми числами. Результат отсортируем по возрастанию даты.

Поля в результирующей таблице: **date, new_users, new_couriers, total_users, total_couriers**

**Результат:** 

Новыми будем считать тех пользователей и курьеров, которые в данный день совершили своё первое действие в нашем сервисе. Общее число пользователей/курьеров на текущий день — это результат сложения числа новых пользователей/курьеров в текущий день со значениями аналогичного показателя всех предыдущих дней.

Итоговый [**SQL-запрос**](https://github.com/kioybash/analytical_tasks/blob/main/SQL_queries/Task_1.sql "**SQL-запрос**").

**Получившийся графики:**

Динамика новых пользователей и курьеров:

![Динамика долей платящих пользователей и активных курьеров.png](image_chart%2F%C4%E8%ED%E0%EC%E8%EA%E0%20%E4%EE%EB%E5%E9%20%EF%EB%E0%F2%FF%F9%E8%F5%20%EF%EE%EB%FC%E7%EE%E2%E0%F2%E5%EB%E5%E9%20%E8%20%E0%EA%F2%E8%E2%ED%FB%F5%20%EA%F3%F0%FC%E5%F0%EE%E2.png)


------------

## 🔵Построение дашбордов

**Задача 2:** 



**Результат:** 

**Пояснение:** 

------------

## 🔵Построение дашбордов

**Задача:** 

**Результат:** 

**Пояснение:** 
