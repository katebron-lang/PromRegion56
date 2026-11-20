-- Применить к УЖЕ существующей базе, без восстановления полного дампа.
-- psql -v ON_ERROR_STOP=1 "$DATABASE_URL" -f database/migrate_city_cards_existing_db.sql
-- Повторное выполнение допустимо: обновляем только пустые поля основных метрик.
BEGIN;

-- Требуется схема industrial_city_db.sql, штатные PK и sequence defaults.
INSERT INTO public.data_sources(name,url,source_type,publication_date,access_date,description)
SELECT s.name,s.url,s.source_type,s.publication_date,s.access_date,s.description
FROM (VALUES
  (Отчёты муниципального образования город Новотроицк, 2021–2025,'https://base.garant.ru/408025329/1b93c134b90c6071b4dc3f495464b753/','Муниципальная статистика',NULL,'2026-11-20','Годовые приложения к отчётам МО; оценки помечены отдельно.'),
  (Социально-экономические показатели МО Город Орск, 2021–2025,NULL,'Муниципальная статистика',NULL,'2026-11-20','Отчёты администрации города за 2021–2025 годы, предоставленные для проекта.'),
  (Социально-экономическое развитие МО город Оренбург, 2021–2025,'https://base.garant.ru/415031522/5633a92d35b966c2ba2f1e859e7bdd69/','Муниципальная статистика',NULL,'2026-11-20','Отчёты и приложения 2022–2025; часть значений 2021 не подтверждена.')
) AS s(name,url,source_type,publication_date,access_date,description)
WHERE NOT EXISTS (SELECT 1 FROM public.data_sources d WHERE d.name=s.name);

-- Заполняем только ранее пустые реквизиты: не заменяем сведения оператора БД.
UPDATE public.cities SET
 district=COALESCE(NULLIF(district,''),x.district),
 territory_type=COALESCE(NULLIF(territory_type,''),'город'),
 oktmo=COALESCE(NULLIF(oktmo,''),x.oktmo),
 administrative_center=COALESCE(NULLIF(administrative_center,''),x.city_name)
FROM (VALUES
 (1,'Новотроицк','городской округ город Новотроицк','53720000001'),
 (2,'Орск','городской округ город Орск','53723000001'),
 (3,'Оренбург','городской округ город Оренбург','53701000001')
) AS x(id,city_name,district,oktmo)
WHERE public.cities.id=x.id AND public.cities.name=x.city_name;

-- Каждая строка соответствует году и муниципальному образованию.
WITH raw(city_id,year,population,average_salary,unemployment_rate,investments,industrial_output,employed_population,enterprises_count,industrial_enterprises_count,source_id) AS (
VALUES
(1,2021,87590,46646.4,0.9,7868560000,187065210000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2022,79950,52295.1,0.6,5523070000,192049570000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2023,79400,62431.9,0.41,14619330000,208983130000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2024,78871,74255.2,0.3,18227780000,194799010000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2025,NULL,NULL,0.4,16317320000,146472650000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(2,2021,228682,38843.8,0.8,6478800000,44036500000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2022,227131,44638.3,0.5,15024200000,62551700000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2023,190980,55719.1,0.4,21964800000,82743200000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2024,190318,74163.3,0.4,36290870000,105935100000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2025,188136,89874.9,0.4,43802400000,134764700000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(3,2021,NULL,48900,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2022,556373,55000,0.75,90200000000,361900000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2023,552831,61800,0.44,108300000000,388700000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2024,550344,69100,0.33,111400000000,420400000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2025,549947,78300,0.4,124400000000,355400000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1))
)
UPDATE public.territory_metrics t SET
 population=COALESCE(t.population,r.population),
 average_salary=COALESCE(t.average_salary,r.average_salary),
 unemployment_rate=COALESCE(t.unemployment_rate,r.unemployment_rate),
 investments=COALESCE(t.investments,r.investments),
 industrial_output=COALESCE(t.industrial_output,r.industrial_output),
 source_id=COALESCE(t.source_id,r.source_id)
FROM raw r WHERE t.city_id=r.city_id AND t.year=r.year;

WITH raw(city_id,year,population,average_salary,unemployment_rate,investments,industrial_output,employed_population,enterprises_count,industrial_enterprises_count,source_id) AS (
VALUES
(1,2021,87590,46646.4,0.9,7868560000,187065210000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2022,79950,52295.1,0.6,5523070000,192049570000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2023,79400,62431.9,0.41,14619330000,208983130000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2024,78871,74255.2,0.3,18227780000,194799010000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(1,2025,NULL,NULL,0.4,16317320000,146472650000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1)),
(2,2021,228682,38843.8,0.8,6478800000,44036500000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2022,227131,44638.3,0.5,15024200000,62551700000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2023,190980,55719.1,0.4,21964800000,82743200000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2024,190318,74163.3,0.4,36290870000,105935100000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(2,2025,188136,89874.9,0.4,43802400000,134764700000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1)),
(3,2021,NULL,48900,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2022,556373,55000,0.75,90200000000,361900000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2023,552831,61800,0.44,108300000000,388700000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2024,550344,69100,0.33,111400000000,420400000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1)),
(3,2025,549947,78300,0.4,124400000000,355400000000,NULL,NULL,NULL,(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1))
)
INSERT INTO public.territory_metrics(city_id,year,population,average_salary,unemployment_rate,investments,industrial_output,employed_population,enterprises_count,industrial_enterprises_count,source_id)
SELECT r.* FROM raw r
WHERE NOT EXISTS (SELECT 1 FROM public.territory_metrics t WHERE t.city_id=r.city_id AND t.year=r.year);

CREATE TABLE IF NOT EXISTS public.city_annual_indicators (
 city_id integer NOT NULL REFERENCES public.cities(id),
 year integer NOT NULL CHECK (year BETWEEN 2000 AND 2100),
 metric_code text NOT NULL,
 numeric_value numeric(20,4),
 unit text NOT NULL,
 source_metric_name text NOT NULL,
 verification_status text NOT NULL CHECK (verification_status IN ('reported','municipal_estimate','unavailable')),
 source_id integer REFERENCES public.data_sources(id),
 as_of_date date,
 coverage_note text NOT NULL DEFAULT '',
 PRIMARY KEY (city_id,year,metric_code)
);
-- Существующие значения подробной таблицы не изменяем; только добавляем отсутствующие.
INSERT INTO public.city_annual_indicators(city_id,year,metric_code,numeric_value,unit,source_metric_name,verification_status,source_id,as_of_date,coverage_note)
VALUES
(1,2021,'industrial_production_index',147.29,'%','Индекс промышленного производства, % к тому же периоду предыдущего года','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'industrial_production_index',114.6,'%','Индекс промышленного производства, % к тому же периоду предыдущего года','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'industrial_production_index',111.95,'%','Индекс промышленного производства, % к тому же периоду предыдущего года','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'industrial_production_index',89.03,'%','Индекс промышленного производства, % к тому же периоду предыдущего года','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'industrial_production_index',73.29,'%','Индекс промышленного производства, % к тому же периоду предыдущего года','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'industrial_shipments',187065.21,'млн руб.','Отгрузка собственных товаров, работ и услуг в действующих ценах, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'industrial_shipments',192049.57,'млн руб.','Отгрузка собственных товаров, работ и услуг в действующих ценах, млн ₽','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'industrial_shipments',208983.13,'млн руб.','Отгрузка собственных товаров, работ и услуг в действующих ценах, млн ₽','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'industrial_shipments',194799.01,'млн руб.','Отгрузка собственных товаров, работ и услуг в действующих ценах, млн ₽','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'industrial_shipments',146472.65,'млн руб.','Отгрузка собственных товаров, работ и услуг в действующих ценах, млн ₽','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'manufacturing_shipments',170257.41,'млн руб.','Отгрузка обрабатывающих производств, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'manufacturing_shipments',175068.15,'млн руб.','Отгрузка обрабатывающих производств, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'manufacturing_shipments',196108.08,'млн руб.','Отгрузка обрабатывающих производств, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'manufacturing_shipments',188612.23,'млн руб.','Отгрузка обрабатывающих производств, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'manufacturing_shipments',140557.83,'млн руб.','Отгрузка обрабатывающих производств, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'investments',7868.56,'млн руб.','Инвестиции в основной капитал из всех источников, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'investments',5523.07,'млн руб.','Инвестиции в основной капитал из всех источников, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'investments',14619.33,'млн руб.','Инвестиции в основной капитал из всех источников, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'investments',18227.78,'млн руб.','Инвестиции в основной капитал из всех источников, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'investments',16317.32,'млн руб.','Инвестиции в основной капитал из всех источников, млн ₽','municipal_estimate',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'housing_completed',3.02,'тыс. кв. м','Ввод жилых домов, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'housing_completed',7.378,'тыс. кв. м','Ввод жилых домов, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'housing_completed',6.657,'тыс. кв. м','Ввод жилых домов, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'housing_completed',8.073,'тыс. кв. м','Ввод жилых домов, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'housing_completed',10.635,'тыс. кв. м','Ввод жилых домов, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'retail_turnover',6205.38,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'retail_turnover',6989.64,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'retail_turnover',8302.36,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'retail_turnover',10010.24,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'retail_turnover',11047,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'average_salary',46646.4,'руб.','Среднемесячная зарплата в крупных и средних организациях, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'average_salary',52295.1,'руб.','Среднемесячная зарплата в крупных и средних организациях, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'average_salary',62431.9,'руб.','Среднемесячная зарплата в крупных и средних организациях, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'average_salary',74255.2,'руб.','Среднемесячная зарплата в крупных и средних организациях, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'average_salary',NULL,'руб.','Среднемесячная зарплата в крупных и средних организациях, ₽','unavailable',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'registered_unemployment',0.9,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'registered_unemployment',0.6,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'registered_unemployment',0.41,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'registered_unemployment',0.3,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'registered_unemployment',0.4,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2021,'population',87.59,'тыс. чел.','Население муниципального образования, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2022,'population',79.95,'тыс. чел.','Население муниципального образования, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2023,'population',79.4,'тыс. чел.','Население муниципального образования, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2024,'population',78.871,'тыс. чел.','Население муниципального образования, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(1,2025,'population',78.871,'тыс. чел.','Население муниципального образования, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Отчёты муниципального образования город Новотроицк, 2021–2025' ORDER BY id LIMIT 1),'2025-01-01','В 2025-м отчёте указан снимок на 01.01.2025; в основной годовой таблице 2025 население не повторяется как новая оценка.'),
(2,2021,'industrial_shipments',44036.5,'млн руб.','Отгрузка товаров собственного производства, работ и услуг, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'industrial_shipments',62551.7,'млн руб.','Отгрузка товаров собственного производства, работ и услуг, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'industrial_shipments',82743.2,'млн руб.','Отгрузка товаров собственного производства, работ и услуг, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'industrial_shipments',105935.1,'млн руб.','Отгрузка товаров собственного производства, работ и услуг, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'industrial_shipments',134764.7,'млн руб.','Отгрузка товаров собственного производства, работ и услуг, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'manufacturing_shipments',27093.8,'млн руб.','В том числе обрабатывающие производства, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'manufacturing_shipments',44413.8,'млн руб.','В том числе обрабатывающие производства, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'manufacturing_shipments',58998.4,'млн руб.','В том числе обрабатывающие производства, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'manufacturing_shipments',81283.5,'млн руб.','В том числе обрабатывающие производства, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'manufacturing_shipments',107814.8,'млн руб.','В том числе обрабатывающие производства, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'investments',6478.8,'млн руб.','Инвестиции в основной капитал, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'investments',15024.2,'млн руб.','Инвестиции в основной капитал, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'investments',21964.8,'млн руб.','Инвестиции в основной капитал, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'investments',36290.87,'млн руб.','Инвестиции в основной капитал, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'investments',43802.4,'млн руб.','Инвестиции в основной капитал, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'retail_turnover',40902.7,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'retail_turnover',47240.7,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'retail_turnover',22944.7,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,'Охват розницы отличается от 2021–2022 годов; динамику напрямую не сопоставлять.'),
(2,2024,'retail_turnover',28325.1,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,'Охват розницы отличается от 2021–2022 годов; динамику напрямую не сопоставлять.'),
(2,2025,'retail_turnover',30799.5,'млн руб.','Оборот розничной торговли, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,'Охват розницы отличается от 2021–2022 годов; динамику напрямую не сопоставлять.'),
(2,2021,'municipal_budget_revenue',5203.6,'млн руб.','Доходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'municipal_budget_revenue',7070.6,'млн руб.','Доходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'municipal_budget_revenue',6625.5,'млн руб.','Доходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'municipal_budget_revenue',10286.5,'млн руб.','Доходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'municipal_budget_revenue',9131.7,'млн руб.','Доходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'municipal_budget_expenses',5130.3,'млн руб.','Расходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'municipal_budget_expenses',6748,'млн руб.','Расходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'municipal_budget_expenses',6503.4,'млн руб.','Расходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'municipal_budget_expenses',9917.4,'млн руб.','Расходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'municipal_budget_expenses',9556.7,'млн руб.','Расходы бюджета муниципального образования, млн ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'average_salary',38843.8,'руб.','Среднемесячная зарплата, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'average_salary',44638.3,'руб.','Среднемесячная зарплата, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'average_salary',55719.1,'руб.','Среднемесячная зарплата, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'average_salary',74163.3,'руб.','Среднемесячная зарплата, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'average_salary',89874.9,'руб.','Среднемесячная зарплата, ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'registered_unemployment',0.8,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'registered_unemployment',0.5,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'registered_unemployment',0.4,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'registered_unemployment',0.4,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'registered_unemployment',0.4,'%','Уровень регистрируемой безработицы, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2021,'population',228.682,'тыс. чел.','Население муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),'2021-01-01',''),
(2,2022,'population',227.131,'тыс. чел.','Население муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),'2022-01-01',''),
(2,2023,'population',190.98,'тыс. чел.','Население муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),'2023-01-01','Изменение связано в том числе с пересмотром базы после переписи; не интерпретировать как одномоментную естественную убыль.'),
(2,2024,'population',190.318,'тыс. чел.','Население муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),'2024-01-01',''),
(2,2025,'population',188.136,'тыс. чел.','Население муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),'2025-01-01',''),
(2,2021,'sme_count',6580,'ед.','Субъекты малого и среднего предпринимательства, ед.','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2022,'sme_count',6537,'ед.','Субъекты малого и среднего предпринимательства, ед.','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2023,'sme_count',6766,'ед.','Субъекты малого и среднего предпринимательства, ед.','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2024,'sme_count',6988,'ед.','Субъекты малого и среднего предпринимательства, ед.','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(2,2025,'sme_count',7259,'ед.','Субъекты малого и среднего предпринимательства, ед.','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономические показатели МО Город Орск, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'industrial_shipments',NULL,'млрд руб.','Отгрузка промышленной продукции, работ и услуг, млрд ₽','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'industrial_shipments',361.9,'млрд руб.','Отгрузка промышленной продукции, работ и услуг, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'industrial_shipments',388.7,'млрд руб.','Отгрузка промышленной продукции, работ и услуг, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'industrial_shipments',420.4,'млрд руб.','Отгрузка промышленной продукции, работ и услуг, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'industrial_shipments',355.4,'млрд руб.','Отгрузка промышленной продукции, работ и услуг, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'industrial_production_index',NULL,'%','Индекс промышленного производства, % к предыдущему году','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'industrial_production_index',97.7,'%','Индекс промышленного производства, % к предыдущему году','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'industrial_production_index',102.5,'%','Индекс промышленного производства, % к предыдущему году','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'industrial_production_index',99.8,'%','Индекс промышленного производства, % к предыдущему году','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'industrial_production_index',96,'%','Индекс промышленного производства, % к предыдущему году','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'investments',NULL,'млрд руб.','Инвестиции в основной капитал по полному кругу организаций, млрд ₽','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'investments',90.2,'млрд руб.','Инвестиции в основной капитал по полному кругу организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'investments',108.3,'млрд руб.','Инвестиции в основной капитал по полному кругу организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'investments',111.4,'млрд руб.','Инвестиции в основной капитал по полному кругу организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'investments',124.4,'млрд руб.','Инвестиции в основной капитал по полному кругу организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'housing_completed',518.3,'тыс. кв. м','Ввод жилья, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2022,'housing_completed',415.1,'тыс. кв. м','Ввод жилья, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'housing_completed',451.5,'тыс. кв. м','Ввод жилья, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'housing_completed',478.4,'тыс. кв. м','Ввод жилья, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'housing_completed',436.8,'тыс. кв. м','Ввод жилья, тыс. м²','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'retail_turnover',242.4,'млрд руб.','Оборот розничной торговли, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2022,'retail_turnover',261.1,'млрд руб.','Оборот розничной торговли, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'retail_turnover',285.9,'млрд руб.','Оборот розничной торговли, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'retail_turnover',326.9,'млрд руб.','Оборот розничной торговли, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'retail_turnover',388.7,'млрд руб.','Оборот розничной торговли, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'average_salary',48.9,'тыс. руб.','Среднемесячная начисленная зарплата, тыс. ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2022,'average_salary',55,'тыс. руб.','Среднемесячная начисленная зарплата, тыс. ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'average_salary',61.8,'тыс. руб.','Среднемесячная начисленная зарплата, тыс. ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'average_salary',69.1,'тыс. руб.','Среднемесячная начисленная зарплата, тыс. ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'average_salary',78.3,'тыс. руб.','Среднемесячная начисленная зарплата, тыс. ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'registered_unemployment',NULL,'%','Зарегистрированная безработица на конец года, %','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'registered_unemployment',0.75,'%','Зарегистрированная безработица на конец года, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'registered_unemployment',0.44,'%','Зарегистрированная безработица на конец года, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'registered_unemployment',0.33,'%','Зарегистрированная безработица на конец года, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'registered_unemployment',0.4,'%','Зарегистрированная безработица на конец года, %','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2021,'population',NULL,'тыс. чел.','Численность населения муниципального образования на 1 января, тыс. человек','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'population',556.373,'тыс. чел.','Численность населения муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),'2022-01-01',''),
(3,2023,'population',552.831,'тыс. чел.','Численность населения муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),'2023-01-01',''),
(3,2024,'population',550.344,'тыс. чел.','Численность населения муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),'2024-01-01',''),
(3,2025,'population',549.947,'тыс. чел.','Численность населения муниципального образования на 1 января, тыс. человек','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),'2025-01-01',''),
(3,2021,'profitable_organizations_profit',NULL,'млрд руб.','Прибыль прибыльных организаций, млрд ₽','unavailable',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'Подтверждённое сопоставимое муниципальное значение не найдено.'),
(3,2022,'profitable_organizations_profit',119.2,'млрд руб.','Прибыль прибыльных организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2023,'profitable_organizations_profit',91.7,'млрд руб.','Прибыль прибыльных организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2024,'profitable_organizations_profit',99.6,'млрд руб.','Прибыль прибыльных организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,''),
(3,2025,'profitable_organizations_profit',80.4,'млрд руб.','Прибыль прибыльных организаций, млрд ₽','reported',(SELECT id FROM public.data_sources WHERE name='Социально-экономическое развитие МО город Оренбург, 2021–2025' ORDER BY id LIMIT 1),NULL,'')
ON CONFLICT(city_id,year,metric_code) DO NOTHING;
COMMIT;

-- Контрольные запросы
SELECT c.name, count(DISTINCT t.year) AS main_years
FROM public.cities c LEFT JOIN public.territory_metrics t ON t.city_id=c.id AND t.year BETWEEN 2021 AND 2025
WHERE c.id IN (1,2,3) GROUP BY c.id,c.name ORDER BY c.id;
SELECT c.name, count(i.metric_code) AS detailed_indicators,
 count(*) FILTER(WHERE i.numeric_value IS NULL) AS unavailable
FROM public.cities c LEFT JOIN public.city_annual_indicators i ON i.city_id=c.id AND i.year BETWEEN 2021 AND 2025
WHERE c.id IN (1,2,3) GROUP BY c.id,c.name ORDER BY c.id;
