
-- Створили БД
create database UNIVERSITY_PV321
/**/ --
-- робимо активною БД
use UNIVERSITY_PV321

-- видаляє БД
drop database UNIVERSITYPV


/*
column parametrs 
- NULL(default) NOT NULL -> дозволяє/забороняє колонці мати значення NULL
- UNIQUE -> гарантує, що в колонці не буде дублікатів
- PRIMARY KEY -> первинний ключ, який включає обмеження NOT NULL та UNIQUE
- IDENTITY(seed, increment) - встановлює автоінкремент, seed - початкове значення, increment - значення збільшення
- CHECK(condition) -> гарантує, що всі значення в колонці будуть відповідати логічній умові
- DEFAULT(value) -> встановлює значення за замовчуванням для колонки, коли значення не вказано
- AS - значення в колонці будуть розраховуватися
*/

/*
logic operators : >, <, >=, <=, <>(!=), !>, !<
-- logic і && --> AND
-- logic або || --> OR
*/
create table Students
(
-- name type constrain1 constrain2
Id int PRIMARY KEY IDENTITY,
[Name] nvarchar(50) not null check(Name <> ''),
Surname nvarchar(50) not null check(Surname <> ''),
Phone char(15) null,
Birthday date not null,
AverageMark float not null check(AverageMark between 1 and 12), --check(AverageMark >= 1 AND AverageMark <= 12)
IsDeptor bit not null default(0),
Lesson int not null default(0) check(Lesson > 0),
Fails int not null default(0) check(Fails > 0),
Visiting as Lesson - Fails,

check(Fails <= Lesson)
-- check level table
)

select * from Students

select Name, Surname, AverageMark from Students



-- string text = ""

insert into Students
values('Ivanka','Petruk','38095-547-85-96', '2004-3-25',10.5,default,120,4),
('Olga','Lusyk',null,'2005-12-12',8,1,120,100)

-- зміна існуючої колонки
alter table Students
	alter column Phone char(25) 

	-- додавання колонки до існуючої таблиці
alter table Students
	add DegreeDate date not null default(GETDATE())

--update - оновлення існуючих даних в таблиці

update Students
set Name = 'Ivan'
where Id = 2

--delete - видалення даних з таблиці
delete from Students
where Visiting < 100
-- перейменування існуючої колонки
execute sp_rename 'Students.Phone', 'PhoneNumber', 'COLUMN'

