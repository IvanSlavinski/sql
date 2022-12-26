--1. Вывести имена всех игроков, которые не имеют достижений
SELECT nickname
  FROM player
       LEFT JOIN achievement
       ON player.id = achievement.player_id
 WHERE player_id is NULL;

--2. Вывести имена всех игроков, у которых сумма очков больше 800 и их очки. В запросе желательно использовать having
SELECT nickname, SUM(amount) as total_score_amount
  FROM player
       JOIN achievement
       ON player.id = achievement.player_id
       JOIN score
       ON achievement.id = score.achievement_id
 GROUP BY nickname
HAVING SUM(amount) > 800;

--3. Получить информацию о игроке, набравшим самое большое количество очков
SELECT nickname, MAX(total_amount) as max_amount
  FROM (
        SELECT nickname, SUM(amount) as total_amount
          FROM player
               JOIN achievement
               ON player.id = achievement.player_id
               JOIN score
               ON achievement.id = score.achievement_id
         GROUP BY nickname
        );

--4. Подсчитать для каждой гильдии сумму всех очков всех ее игроков. Вывести название гильдии и кол-во очков по убыванию, начиная от самого наибольшего к наименьшему
SELECT name, SUM(amount) as total_amount
  FROM (
        SELECT guild.name, nickname, amount
          FROM guild
               JOIN player
               ON guild.id = player.guild_id
               JOIN achievement
               ON player.id = achievement.player_id
               JOIN score
               ON achievement.id = score.achievement_id
        )
 GROUP BY name
 ORDER BY total_amount DESC;

--5. Вывести имя игрока и его гильдию, фамилия которого начинается с “B” и больше одной буквы
SELECT nickname, name
  FROM guild
       JOIN player
       ON guild.id = player.guild_id
 WHERE nickname LIKE '%B_';

--6. Создать в таблице гильдия новую команду
INSERT INTO guild (id, name) values (9, 'New Team99');

--7. Создать в таблице player не менее 2-х игроков, которые должны входить в созданную вами гильдию
INSERT INTO player (id, nickname, date_of_start_game, guild_id) 
VALUES (20, 'Elliot Alderson', '2022-02-01', 9),
       (21, 'Stanley Jobson', '2022-03-01', 9),
       (22, 'Richard Hendrics', '2022-04-01', 9),
       (23, 'Edward Snowden', '2022-05-01', 9),
       (24, 'Kevin Mitnick', '2022-06-01', 9);

--8. Вывести всех игроков, кто вступил в гильдию, вместе с именем этой гильдии используя оператор join
SELECT nickname, name
  FROM guild
       JOIN player
       ON guild.id = player.guild_id;

--9. Добавить к имени каждого игрока название гильдии одним запросом. Уточнение: В результате запроса должно измениться имя игрока в таблице player
UPDATE player
   SET nickname = concat_name
  FROM (
        SELECT player.id, COALESCE(nickname || ' ' || name, nickname) as concat_name
          FROM player
               LEFT JOIN guild
               ON player.guild_id = guild.id
        ) AS temp_table
 WHERE temp_table.id = player.id;

--10. Вывести в алфавитном порядке названия всех уникальных достижений, которые были у игроков
SELECT DISTINCT description
  FROM score
       JOIN achievement
       ON score.achievement_id = achievement.id
       JOIN player
       ON achievement.player_id = player.id
 WHERE description IS NOT NULL 
   AND description != ""
 ORDER BY description ASC;