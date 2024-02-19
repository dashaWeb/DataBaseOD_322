/*
Загальний шаблон запиту
	select що саме
	from звідки
	додаткові параметри запиту (фільтрація, сортування)
*/

select * from Students -- показати всі колонки таблиці

select Name from Students -- показати колонки лише Name таблиці

select Name,Surname,AverageMark
from Students

-- AS - псевдонім для колонки, таблиці і т.д
select Name + ' ' + Surname as 'Full Name', AverageMark * 100 as 'Mark', Birthday as 'Date'
from Students

/*select Name + ' ' + Surname + ' ' + AverageMArk as 'Full Name'
from Students -- error */


--Cast, Convert - функції перетворення типів
select 'Student ' + Name + ' has ' + CAST(AverageMark as varchar) as 'Full info'
from students

select 'Student ' + Name + ' has ' + Convert(nvarchar(50),AverageMark) as 'Full info'
from students

-- Top(count) - читає певну кількість рядків
select top 10 Name + ' ' + Surname as 'Full Name'
from Students

--percent - читати відносну кількість рядків
select top 50 percent Name + ' ' + Surname as 'Full Name'
from Students

-- distinct - фільтрує дублікати
select distinct IsDeptor
from Students


-- Показати декілька таблиць
create table Subject
(
Id int primary key identity,
Name nvarchar(50) not null 
)
select * from Subject

insert into Subject
values('History'),
('English'),
('Math')

select s.Name as 'Name Student', st.Name as 'Name Subject'
from Students as st, Subject as s

/*
	Функції для отримання значення дати
	Day(date) - повертає день з дати
	Month(date) - повертає місяць з дати
	Year(date) - повертає рік з дати
*/

select * from Students
where MONTH(Birthday) between 3 and 5 -->= 3 and MONTH(Birthday) < 6

select * from Students
where MONTH(Birthday) in (12,3,6,9)--MONTH(Birthday) = 12 or MONTH(Birthday) = 3 or MONTH(Birthday) = 9 or MONTH(Birthday) = 6

select* from Students
where YEAR(Birthday) = 2006 and MONTH(Birthday) = 3 and Day(Birthday) > 15


-- Like (pettern)
/*
	% - будь-яка кількість символів
	_ - один символ
	[] - будь-який символ наявний в дужках
	[^] - будь-який символ НЕ наявний в дужках
*/

-- студенти імя яких починається і закінчується на а
select * from Students
where Name Like 'A%a' or Name Like 'D%'

-- студенти номер телефону яких закінчується на 66
select * from Students
where Phone Like '%66'

-- студенти прізвище яких має передостанню букву а
select * from Students
where Surname Like '%a_'

--
select * from Students
where Name Like '[aeiuo]%'

select * from Students
where Name Like '[a-d]%'
order by Name desc

select * from Students
where Name Like '[aeiou]%[^aeiou]'

select * from Students
where Name COLLATE Latin1_General_BIN like '[A-D]%'

select * from Students
where Name like '[a-d]%'
order by Name desc