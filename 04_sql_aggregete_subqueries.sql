-- Aggregation function 
/*
	COUNT() - обчислює кількість записів (працює з символьними та числовими типами)
	SUM()   - обчислює суму всіх значень (працює з числовими типами)
	AVG()   - обчислює середнє значення (працює з числовими типами)
	MIN()   - обчислює мінімальне значення (працює з символьними та числовими типами)
	MAX()   - обчислює максимальне значення (працює з символьними та числовими типами)
*/

use Academy_PD_322

select* from Students
select* from Teachers

insert into Students
values('Ivan','Bondar',null, '2002-02-02',10.8,120,15,5)

-- COUNT
select COUNT(Id) as 'Student Count'
from Students

-- при роботі з конкретною колонкою, NULL - значення ігнорується
select COUNT(Email) as 'Student Count'
from Students

select Count(Id) as 'Good Students'
from Students
where AverageMark >= 10

select Max(AverageMark) as 'Result'
from Students

select Min(AverageMark) as 'Result'
from Students

select SUM(Lesson) as 'Sum all lessons'
from Students

select AVG(Lesson) as 'AVG all lessons'
from Students


select AVG(AverageMark) as 'AverageMark all Students'
from Students

--ROUND(n) -> вказує скільки знаків після коми 
--FLOOR() -округлить до нижньої межі
--CEILING() - округлить до верхньої межі

select ROUND(AVG(AverageMark),2) as 'AverageMark all Students'
from Students

select FLOOR(AVG(AverageMark)) as 'AverageMark all Students'
from Students

select CEILING(AVG(AverageMark)) as 'AverageMark all Students'
from Students

select COUNT(s.Id) as 'Count of Students', SUM(s.Fails) as 'Sum of Fails', AVG(s.AverageMark) as 'Average Mark by group'
from Students as s join Groups as g on s.GroupId = g.Id
where g.Name = 'Violet'

select* from Groups

select g.Name, COUNT(s.Id)
from Students as s join Groups as g on s.GroupId = g.Id
-- при використанні group by, агрегаційні функції виконуються для кожної групи окремо
group by g.Name

-- group by - групування елементів по певному критерію

select g.Name as 'Name group', COUNT(s.Id) as 'Number of Students',ROUND(AVG(AverageMark),2) as 'Average mark by group'
from Students as s join Groups as g on s.GroupId = g.Id
group by g.Name

select AverageMark, COUNT(Id) as NUMBERS
from Students
where AverageMark >= 7
group by AverageMark
having COUNT(Id)>= 1
order by NUMBERS desc

--having - фільтрує вже згруповані елементи

select g.Name, AVG(s.AverageMark) as 'Group Average mark',
				Sum(s.AverageMark) as 'Group total mark',
				COUNT(s.Id) as 'Students Count'
from Groups as g join Students as s on g.Id = s.GroupId
group by g.Name
having AVG(s.AverageMark) > 5
order by COUNT(s.Id)


/*
Subquery Operators
- [NOT]EXISTS - повертає true, якзо запит повернув хоча б один запис
- [> < >= <= <> =] ANY / SOME - повертає true якщо хоча б один запис відповідає умові
- [> < >= <= <> =] ALL - повертає true якщо всі записи відповідають умові

*/

select MAX(AverageMark) from Students

-- показати виклдачів, які мають хоча б одну групу
select *
from Teachers as t
where EXISTS (select * from TeachersGroups as tg
				where tg.TeacherId = t.Id) 

insert into Teachers
values('Ivan','Bondar','2007-04-12',null)

select* from Teachers
select * from Groups
select * from TeachersGroups
select * from Students
select Name
from Groups
where EXISTS (select Id from Students where AverageMark > 11 and GroupId = Groups.Id)


-- показати викладачів які мають хоча б одного студента з іменем
select Name, Phone
from Teachers
where exists(
			select s.Id 
			from Students as s join Groups as g on s.GroupId = g.Id
			join TeachersGroups as tg on tg.GroupId = g.Id
			where tg.TeacherId = Teachers.Id and s.Name = 'Ivan'
)

-- показати групи в яких хоча б одни студент старше 20-ти
select Name
from Groups
where exists(
	select Id
	from Students as s
	where s.GroupId = Groups.Id and DATEDIFF(YEAR,s.Birthday,GETDATE()) >= 20
)

-- показати студентів в яких імя співпадає з іменем викладача
select Name, Birthday, Email, AverageMark
from Students
where Name = SOME(
	select Name from Teachers
)

-- показати студентів в яких дата народження більша за дату прийняття на роботу будь-якого викладача
select Name, Birthday, Email, AverageMark
from Students
where Birthday > Any(
	select HireDate from Teachers
)

-- показати студентів з імям яке має хоча б одни студент іншої групи
select Name, Email
from Students
where Name = ANY(
	select Name
	from Students as s
	where s.GroupId <> Students.GroupId
)
select * from Groups
-- показати всіх студентів в яких оцінка більша за оцінки всіх студентів групи Crimson
select s.Name, s.Email, s.AverageMark
from Students as s join Groups as g on s.GroupId = g.Id
where AverageMark > ALL (
	select AverageMark
	from Groups as g join Students as s on s.GroupId = g.Id
	where g.Name = 'Fuscia' and s.AverageMark is not null
)
