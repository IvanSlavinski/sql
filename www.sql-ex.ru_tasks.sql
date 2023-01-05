-- 1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
select model, speed, hd 
  from PC 
 where price < 500;

-- 2. Найдите производителей принтеров. Вывести: maker
select distinct maker 
  from product 
 where type = 'printer';

-- 3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
select model, ram, screen 
  from laptop 
 where price > 1000;

-- 4. Найдите все записи таблицы Printer для цветных принтеров
select * 
  from printer 
 where color = 'y';

-- 5.Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
select model, speed, hd 
  from PC 
 where price < 600 
   and cd in ('12x','24x');

-- 6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
select DISTINCT product.maker, laptop.speed 
  from product 
       inner join laptop 
       on product.model = laptop.model 
          and laptop.hd >= 10;


/* 7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).*/
select pc.model, pc.price 
  from PC
       join Product
       on Product.model = PC.model
 where Product.maker=  'B'
 union
select laptop.model, laptop.price 
  from Laptop
       join Product
       on Product.model = Laptop.model
 where Product.maker = 'B'
 union
select printer.model, printer.price 
  from Printer
       join Product
       on Product.model = Printer.model
 where Product.maker = 'B';

/* 8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.*/
select maker 
  from Product
 where type in ('PC', 'Laptop')
except
select maker from Product
 where type = 'Laptop';

 /* 9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker.*/
select distinct maker 
  from Product
       join PC
       on Product.model = PC.model
 where speed >= 450;

/* 10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price.*/
select model, price 
  from Printer
 where price = (select max(price) 
                from Printer);

/* 11. Найдите среднюю скорость ПК. */
select avg(speed) 
  from PC;

/* 12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол. */
select avg(speed)
  from Laptop
 where price > 1000;

/* 13. Найдите среднюю скорость ПК, выпущенных производителем A.*/
select avg(speed)
  from PC
       join Product
       on PC.model = Product.model
 where maker = 'A';

 /* 14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.*/
select Ships.class, Ships.name, Classes.country
  from Ships
       join Classes
       on Ships.class = Classes.class
 where Classes.numGuns >= 10;

 /* 15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD. */
select hd
  from PC
 group by hd
having count(hd) >= 2;

/* 16. Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.*/
select distinct p1.model, p2.model, p1.speed, p1.ram
  from PC p1, PC p2
 where p1.speed = p2.speed
   and p1.ram = p2.ram
   and p1.model > p2.model

/* 17. Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК. Вывести: type, model, speed.*/
select distinct Product.type, Laptop.model, Laptop.speed 
  from Product
       join Laptop
       on Product.model = Laptop.model
 where speed < all (select speed from PC);

/* 18. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price.*/
select distinct maker, price
  from Product
       join Printer
       on Product.model = Printer.model
 where color = 'y'
   and price = (select min(price) 
                from Printer
                where color = 'y')

/* 19. Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.*/
select distinct maker, avg(screen)
  from Product
       join Laptop
       on Product.model = Laptop.model
 group by maker;

 /* 20. Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.*/
 select distinct maker, count(model) as count_model
   from Product
  where type = 'PC'
  group by maker
 having count(model) >= 3

/* 21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC. Вывести: maker, максимальная цена.*/
 select maker, max(price) as max_price
   from PC
        join Product
        on Product.model = PC.model
  group by maker;

/* 22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена. */
select speed, avg(price) as avg_price
  from PC
 where speed > 600
 group by speed;

/* 23. Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker.*/
select distinct maker
  from Product
       join PC
       on Product.model = PC.model
 where PC.speed >= 750
intersect
select distinct maker
  from Product
       join Laptop
       on Product.model = Laptop.model
 where Laptop.speed >= 750;

/* 24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.*/
with Models as (
  select model, price
    from PC
  union
  select model, price
    from Laptop
  union
  select model, price
    from Printer)
select model
  from Models
 where price = (select max(price) from Models)


/* 25. Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker.*/

select distinct maker
  from product
 where model in (select model
                   from pc
                  where ram = (select min(ram)
                                 from pc)
                                  and speed = (select max(speed)
                                                 from pc
                                                where ram = (select min(ram)
                                                               from pc
                                                            )
                                              )
                )
                and
                maker in (select maker
                            from product
                           where type = 'printer'
                          );

/* 26. Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.*/
select avg(price)
  from (
        select code, price, pc.model, hd, ram
          from PC
         where model in (select model
                           from Product
                          where maker = 'A'
                        )
        union
        select code, price, Laptop.model, hd, ram
          from Laptop
         where model in (select model
                           from Product
                          where maker = 'A'
                        )
        ) a;

/* 27. Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.*/
select maker, avg(PC.hd) as Avg_hd
  from Product
       join PC
       on Product.model = PC.model
 where maker in (select distinct maker 
                 from Product 
                 where type = 'Printer')
 group by maker;

/* 28. Используя таблицу Product, определить количество производителей, выпускающих по одной модели.*/
select count(maker)
  from Product
 where maker in (select maker 
                 from Product
                 group by maker
                 having count(model) = 1);

/* 29. В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.*/
select I.point, I.date, inc, out
  from Income_o I
       left join Outcome_o O
       on I.point = O.point and I.date = O.date
 union
select O.point, O.date, inc, out
  from Income_o I
       right join Outcome_o O
       on I.point = O.point and I.date = O.date;

/* 30. В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).*/

with i as (
  select point, date, sum(inc) as inc
  from Income
  group by point, date
          ), o as (
  select point, date, sum(out) as out
  from Outcome
  group by point, date
                  )
select i.point, i.date, o.out Outcome, i.inc Income
  from i 
       left join o 
       on i.point = o.point 
       and i.date = o.date
 union
select o.point, o.date, o.out Outcome, i.inc Income
  from i 
       right join o 
       on i.point = o.point and i.date = o.date;

/* 31. Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.*/
select class, country
  from Classes
where bore >= 16

/* 32. Одной из характеристик корабля является половина куба калибра его главных орудий (mw). С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны, у которой есть корабли в базе данных.*/
select country, cast(avg((power(bore,3)/2)) as numeric(6,2)) as weight
  from (select country, classes.class, bore, name 
          from classes 
               left join ships 
               on classes.class=ships.class
         union all
        select distinct country, class, bore, ship 
          from classes t1 
               left join outcomes t2 
               on t1.class=t2.ship
         where ship=class 
           and ship not in (select name from ships) 
        ) a
 where name IS NOT NULL 
 group by country
