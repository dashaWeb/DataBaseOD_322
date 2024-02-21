create database Academy_PD_322

use Academy_PD_322

create table Groups
(
	Id int primary key identity,
	Name nvarchar(50) not null unique,
)
select * from Groups
--insert into Groups (Name) values ('Turquoise');
--insert into Groups (Name) values ('Indigo');
--insert into Groups (Name) values ('Violet');
--insert into Groups (Name) values ('Crimson');
--insert into Groups (Name) values ('Fuscia');
-- Типи зв'язків
	-- One to one
	-- One to Many
	-- Many to many

----- Students -----
-- Foreign key (column) references table(column) - встановлює зовнішній ключ для звязку з таблицею 

create table Students
(
	Id int PRIMARY KEY IDENTITY,
	[Name] nvarchar(50) not null check(Name <> ''),
	Surname nvarchar(50) not null check(Surname <> ''),
	Email nvarchar(50) null,
	Birthday date not null,
	AverageMark float not null check(AverageMark between 1 and 12),
	Lesson int not null default(0) check(Lesson > 0),
	Fails int not null default(0) check(Fails > 0),
	Visiting as Lesson - Fails,
	-- вказуємо звязок з групою в студента, студент має одну групу - група має багатьох студентів
	GroupId int null references Groups(Id), -- Id в Groups має бути primary key
	--foreign key (GroupId) references Groups(Id),
	check(Fails <= Lesson),
)
--при встановленні звязку на запис таблиці він повинен існувати, інакше не дозволить

-- отримуємо певних студентів разом з інформацією про його групу
select st.Name, st.AverageMark, g.Name , st.GroupId, g.Id
from Students as st, Groups as g
where GroupId = g.Id and AverageMark >= 7
order by AverageMark desc -- впорядковуємо по колонці AverageMark у зворотньому порядку

select top 3 st.Name, st.AverageMark, g.Name as 'Group Name'
from Students as st, Groups as g
where GroupId = g.Id and g.Name = 'Crimson'
order by AverageMark desc

select* from Students
order by AverageMark desc
------ Teachers ------
create table Teachers
(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Surname nvarchar(50) not null,
	HireDate date  default(getdate()),
	Phone char(20)
)

select* from Teachers
select* from Groups

-- проміжна таблиця для реалізації зв'язку Many to Many

create table TeachersGroups
(
	TeacherId int references Teachers(Id),
	GroupId int references Groups(Id),
	primary key(TeacherId, GroupId)
)

-- встановлюємо звязок між Teachers та Groups
--insert into TeachersGroups (TeacherId, GroupId) values (1, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (3, 1);
--insert into TeachersGroups (TeacherId, GroupId) values (3, 3);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 5);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 1);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 2);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (2, 2);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 5);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (4, 5);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 1);
--insert into TeachersGroups (TeacherId, GroupId) values (2, 5);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 3);
--insert into TeachersGroups (TeacherId, GroupId) values (1, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (3, 1);
--insert into TeachersGroups (TeacherId, GroupId) values (4, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (2, 3);
--insert into TeachersGroups (TeacherId, GroupId) values (3, 5);
--insert into TeachersGroups (TeacherId, GroupId) values (5, 2);
--insert into TeachersGroups (TeacherId, GroupId) values (4, 4);
--insert into TeachersGroups (TeacherId, GroupId) values (4, 5);


select* from TeachersGroups

select t.Name, t.Phone, g.Name as 'Group Name'
from Teachers as t, Groups as g, TeachersGroups as tg
where tg.TeacherId = t.Id and tg.GroupId = g.Id

select s.Name, t.Id, t.Name
from Students as s, Groups as g, Teachers as t, TeachersGroups as tg
where s.GroupId = tg.GroupId and t.Id = tg.TeacherId and g.Id = tg.GroupId and s.Name = 'Bren'

select t.Name as 'Teacher', s.Name as 'Students' , g.Name as 'Group'
from Students as s, Groups as g, Teachers as t, TeachersGroups as tg
where s.GroupId = tg.GroupId and t.Id = tg.TeacherId and g.Id = tg.GroupId and t.Name = 'Tana'
order by g.Name


-- ті ж самі запити, але використовуючи JOIN

-- отримуємо певних студентів разом з інформацією про його групу
select st.Name, st.AverageMark, g.Name , st.GroupId, g.Id
from Students as st join Groups as g on st.GroupId = g.Id
where  AverageMark >= 7
order by AverageMark desc -- впорядковуємо по колонці AverageMark у зворотньому порядку

-- отримуємо ТОП-3 студентів певної групи з найкращою успішністю
select top 3 st.Name, st.AverageMark, g.Name as 'Group Name'
from Students as st join Groups as g on st.GroupId = g.Id
where g.Name = 'Crimson'
order by AverageMark desc

-- отримуємо всіх викладачів та групи в яких вони викладають

select t.Name, t.Phone, g.Name
from Teachers as t join TeachersGroups as tg on t.Id = tg.TeacherId
				join Groups as g on tg.GroupId = g.Id

-- отримуємо всіх викладачів певного студента
select s.Name, s.Surname, s.Email, g.Name as 'Group', t.Name as 'Teacher'
from Students as s join Groups as g on s.GroupId = g.Id
					join TeachersGroups as tg on tg.GroupId = g.Id
					join Teachers as t on t.Id = tg.TeacherId
where s.Name = 'Lory'
