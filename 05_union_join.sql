
-- union - об'єднує декілька запитів в одну результуючу таблицю, при цьому видаляючи дублікати
-- union all - об'єднує декілька запитів в одну результуючу таблицю, при цьому дублікати не видаляючи 
-- показати кількість студентів та їх середній бал
select 'Count Students' ,COUNT(Id) from Students
union
select 'Avg Students', AVG(AverageMark) from Students

-- показати імена студентів та викладачів
select Name from Students
union all
select Name from Teachers

--показати студентів та викладачів, які починаються на букву 'A'
select Name from Students
where Name like 'A%'
-- order by Name desc -- error
union
select Name from Teachers
where Name like 'T%'
order by Name desc


-- Join operator - використовується для отримання звязаних записів з різних таблиць
select* from Students
select* from Teachers
select* from Groups

select* from TeachersGroups

insert into Students
values('Alex','Smit', null, '2004-11-13',10.9,200,15,null),
('Petro','Polichuk', null, '2003-01-23',11.2,200,35,null)

insert into Groups
values ('Yellow'),('Purple')

select s.Name, s.Email, s.AverageMark, g.Name
from Students as s, Groups as g
where s.GroupId = g.Id

-- [INNER] JOIN - повертати всі записи таблиці А, які звязані з записами таблиці В
-- показати всіх студентів та їх групи
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s INNER JOIN Groups as g on s.GroupId = g.Id

-- LEFT JOIN - повертає всі записи таблиці А, які звязані або не мають звязку з таблице В
-- показати всіх студентів та їх групи, а також тих, які не мають групи
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s LEFT JOIN Groups as g on s.GroupId = g.Id

-- показати всіх викладачів та к-ть їхніх груп, а також тих в кого немає груп
select t.Name, COUNT(g.Id) as 'Count Groups'
from Teachers as t LEFT JOIN TeachersGroups as tg on t.Id = tg.TeacherId
				   LEFT JOIN Groups as g on tg.GroupId = g.Id	
group by t.Name, t.Id

-- LEFt JOIN with NULL FOREIGN KEY - повертає лише записи таблиці А, які не звязані з жодним записом таблиці В
-- показати лише студентів які немають групу
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s LEFT JOIN Groups as g on s.GroupId = g.Id
where s.GroupId is null

-- RIGHT JOIN -  повертає всі записи таблиці В, які звязані або не мають звязка з таблицею А
-- показати всіх студентів та їх групи, а також групи, які не мають жодного студента
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s RIGHT JOIN Groups as g on s.GroupId = g.Id

-- RIGHT JOIN with NULL FOREIGN KEY - повертає лише записи таблиці B, які не звязані з жодним записом таблиці A
-- показати лише групи які не мають студентів
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s RIGHT JOIN Groups as g on s.GroupId = g.Id
where s.GroupId is null

-- FULL [OUTER] JOIN - повертає записи таблиці А та В, які звязані або не мають звязку між собою
-- показати всіх студентів , які мають групу або не мають її, а також показати групи, які мають або не мають жодного студента
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s FULL OUTER JOIN Groups as g on s.GroupId = g.Id

-- FULL [OUTER] JOIN with NULL FOREIGN KEY - повертає лише записи таблиці А та В, які не мають звязку між собою
-- показати студентів, які не мають груп і групи, які не мають студентів
select s.Name, s.Email, s.AverageMark, g.Name as [Group]
from Students as s FULL OUTER JOIN Groups as g on s.GroupId = g.Id
where s.GroupId is null