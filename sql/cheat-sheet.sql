--- loome uue andmebaasi
create database TITpe20

--- DB kustutamine
drop database TITpe20

--- db valimine
use TITpe20

-- loome tabeli
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwomen', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)

select * from Person

--- võõrvõtme loomine kahe tabeli vahel
alter table Person add constraint Person_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- ei luba panna Genderit väärtusega, mida ei ole Gender tabelis olemas.
insert into Person values (7, 'Ironman', 'i@iron.com', NULL)

--- kui andmete sisestamisel ei ole sisestatud väärtust Gender-i alla, siis 
--- automaatselt sisestab seal väärtuse 3
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Gender values (3, 'Unknown')

select * from Person

insert into Person (Id, Name, Email)
values (8, 'Ironman', 'i@iron.com')

--- piirangu maga võtmine
alter table Person
drop constraint DF_Persons_GenderId

--- lisame uue veeru juurde
alter table Person
add Age nvarchar(10)

--- vanuseline piirnagu, et ei saa suuremat nr sisestada
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 171)

--- kuidas saame olemasolevaid andmeid uuendada
update Person
set Age = 170
where Id = 8

-- lisame uue veeru
alter table Person
add City nvarchar(50)

--- 2 tund SQL 

select * from Person
select * from Gender

-- otsin konkreetset linna veerust city
select * from Person where City = 'Gotham'
-- välsitab kõik, kes elavad Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- kõik, kes on 20, 24 ja 35 aastased
select * from Person where Age = 20 or Age = 24 or Age = 35
select * from Person where Age in (20, 24, 35)
-- kõik, kes on 20 kuni 25 a vanad
select * from Person where Age between 20 and 25
-- kõik linnad, mis algavad G-tähega ja käskluseks on %-märk
select * from Person where City like 'G%'
-- ükstapuha, kus asub antud juhul märk @
select * from Person where Email like '%@%'
-- otsib, kus teine märk on @
select * from Person where Email like '_@_.com'
-- otsib kõike ridu, kus ei ole kuvatud @ märki
select * from Person where Email not like '%@%'
-- otsib nimesid, kus esimene märk algab S, B ja A-ga
select * from Person where Name like '[SBA]%'
-- otsib nimesid, kus esimene märk ei ole S, B ja A
select * from Person where Name like '[^SBA]%'
-- otsime linna järgi ja täpsustame vanuse
select * from Person 
where (City = 'Gotham' or City = 'Atlantis') and Age < 36
-- paneb tähestikulisse järjestusse
select * from Person order by Name
-- selekteerib vastupidises järjestuses
select * from Person order by Name desc
-- võtame kolm ülemist rida
select top 3 * from Person
-- võtab nime ja vanuse järgi kaks ülemist rida
select top 2 Age, Name from Person
--- võtame pooled nimekirjas olnutest
select top 50 percent * from Person
-- hakkab vanemast pihta ja langevas järjekorras
select * from Person order by Age desc
-- hakkab kõige vanemast ja näitab ainult esimest
select top 1 * from Person order by Age desc

--- saan välja toodud veergudes olevaid andmeid
select distinct Name, City from Person

create table Employee
(
Id int not null primary key,
Name nvarchar(50) not null,
Gender nvarchar(50) not null,
Salary int null,
City nvarchar(50)
)

-- andmete sisestamine tabelisse
insert into Employee (Id, Name, Gender, Salary, City)
values (1, 'Tom', 'Male', 4000, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (2, 'Pam', 'Female', 3000, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (3, 'John', 'Male', 3500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (4, 'Sam', 'Male', 4500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (5, 'Todd', 'Male', 2800, 'Sydney')
insert into Employee (Id, Name, Gender, Salary, City)
values (6, 'Ben', 'Male', 7000, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (7, 'Sara', 'Female', 4800, 'Sydney')
insert into Employee (Id, Name, Gender, Salary, City)
values (8, 'Valarie', 'Female', 5500, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (9, 'James', 'Male', 6500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (10, 'Russell', 'Male', 8800, 'London')


-- 2 tund 

create table Department
(
	Id int primary key,
	DepartmentName nvarchar(20),
	Location nvarchar(20),
	DepartmentHead nvarchar(20)
)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Department', 'Sydney', 'Cindrella')

select * from Employee
select * from Department

alter table Employee
add  DepartmentId nvarchar(20)

select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id


select SUM(Salary) from Employee  --- arvutab kõikide palgad kokku
--- kui Salary veerg on nvarchar, siis kasutab cast-i
select SUM(CAST(Salary as int)) from Employee
--- min palga saaja ja kui kasutan max, siis kõige suurema palga saaja
select MIN(Salary) from Employee
--- ühe kuu palgafond linnade lõikes
select City, SUM(Salary) as TotalSalary from Employee group by City

select City, Gender, SUM(Salary) as TotalSalary from Employee
group by City, Gender  --- toome soolise erisuse mängu

select City, Gender, SUM(Salary) as TotalSalary from Employee
group by City, Gender
order by City -- order by-ga paneme linnad tähestikulisse järjestusse

select Gender, City, SUM(Salary) as TotalSalary from Employee
group by City, Gender
order by City  --peale selecti toome välja järjestuse päringu tulemuses

select COUNT(*) from Employee --loeb ära, mitu inimest on nimekirjas, 
--- * asemele võib panna ak muid veergude nimesid
select * from Employee

--- mitu töötajat on soo ja linna kaupa
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
group by Gender, City

-- kuvab ainult kõik mehed linnade kaupa
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
where Gender = 'Male'
group by Gender, City

--- kasutame having tingimust otsimisel
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
group by Gender, City
having Gender = 'Female'


select * from Employee where SUM(Salary) > 4000
-- annab veateate ja soovib having kasutamist

--- 
select Gender, City, SUM(Salary) as TotalSalary, COUNT(Id) as [Total Employee(s)]
from Employee group by Gender, City
having SUM(Salary) < 4000

--- loome tabeli, milles hakatakse automaatselt nummerdama Id-d
cReaTe table Test1
(
Id int identity(1, 1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1

--- kustutame veeru City Employee tabelist
alter table Employee
drop column City


-- inner join
-- kuvab neid, kellel oon DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employee
inner join Department
on Employee.DepartmentId = Department.Id

--- 3 tund SQL

select * from Person
-- otsib kõik New Yorki elanikud ülesse
select * from Person where City = 'New York'
-- ei soovi New Yorki elanikke näha
select * from Person where City <> 'New York'
select * from Person where City != 'New York'

--- konkreetse vanusega inimesed
select * from Person where Age = 20 or Age = 24 or Age = 40
--- nagu eelmine päring, aga lühemalt
select * from Person where Age in (20, 24, 40)
--- mingis vanusevahemikus olevad inimesed
select * from Person where Age between 20 and 25
--- kõik linnad, mis algavad G-tähega
select * from Person where City like 'G%'
---kui kasutame kaks korda %-märki, siis otsib igalt pool @-märki (selle märgi asemele 
--- võib panna igasuguseid märke)
select * from Person where Email like '%@%' 
-- kõik emailid, kus ei asu @-märki
select * from Person where Email not like '%@%'
-- alakriipsudega määratleme ära @-märgi asetuse soovitud otsingus
select * from Person where Email like '_@_.com'
--- otsib nimesid, kus esimene märk algab S, C ja I-ga.
select * from Person where Name like '[SCI]%'
-- soovime otsida, kus esimene täht ei ole nimes S, C, I
select * from Person where Name like '[^SCI]%'  
-- linn peab olema New York või Gotham ja vanust alla 30 aasta
select * from Person where (City = 'New York' or City = 'Gotham') and Age < 30
--- nime järgi selekteerime
select * from Person order by Name


---- JOIN-d
select * from Department
select * from Employee

-- inner join, näitab ainult neid ridasid, mille on olemas kattuvus osakonna lõikes
select Name, Gender, Salary, DepartmentName
from Employee
inner join Department
on Employee.DepartmentId = Department.Id

--left join, kui soovime kõiki andmeid näha
select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id

-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
-- right outer join
select Name, Gender, Salary, DepartmentName
from Employee
right outer join Department
on Employee.DepartmentId = Department.Id

select * from Department
select * from Employee

--- outer join
--- kuidas saada kõikide tabelite andmed ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employee
full outer join Department
on Employee.DepartmentId = Department.Id

--- cross join võtab kaks allpool olevat tabelit kokku ja korrutab need omavahel läbi
--- igas osakonnas oleva töötajaga
select Name, Gender, Salary, DepartmentName
from Employee
cross join Department

--- keerulisemad JOIN-d
-- kaks isikut, kelle ei ole väärtust osakondades
select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null

select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id
where Department.Id is null

--- right join
select Name, Gender, Salary, DepartmentName
from Employee
right join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null

--- full join
-- otsib ülesse mõlemas tabelis NULL väärtustega olevad read
select Name, Gender, Salary, DepartmentName
from Employee
full join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null
or Department.Id is null

--- self join
select * from Employee

--- tabeli nime muutmine
-- esimene string on vana tabeli nimi ja järgmine string uus nimetus
sp_rename 'Department1', 'Department'

--
alter table Employee
add ManagerId int 

-- self join on tabeli sees oleva info kokku panemine
select E.Name as Employee, M.Name as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--inner join
select E.Name as Employee, M.Name as Manager
from Employee E
inner join Employee M
on E.ManagerId = M.Id

--- cross join
select E.Name as Employee, M.Name as Manager
from Employee E
cross join Employee M

--
select ISNULL('Asd', 'No Manager') as Manager

--- saab ka teistmoodi teha
select coalesce(NULL, 'No Manager') as Manager


--- neile kellele ei ole ülemust määratud, siis paneb neile No Manager teksti
select E.Name as Employee, ISNULL(M.Name, 'No Manager') as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--- 4 tund SQL

--- teeme päringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--- lisame kaks veergu juurde
alter table Employee
add MiddleName nvarchar(30)
alter table Employee
add LastName nvarchar(30)

update Employee set MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employee set MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employee set MiddleName = NULL, LastName = NULL
where Id = 3
update Employee set MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employee set MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employee set MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employee set MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employee set MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employee set MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employee set MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employee
-- igast reast võtab esimese täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName,  MiddleName, LastName) as Name
from Employee


--- loome kaks tabelit
create table IndianCustomers
(
Id int identity(1, 1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1, 1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers values('Raj', 'R@R.com')
insert into IndianCustomers values('Sam', 'S@S.com')

insert into UKCustomers values('Ben', 'B@B.com')
insert into UKCustomers values('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--- kasutame union all, mis näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employee
end

-- kolm erinevat viisi sp esile kutsuda
spGetEmployees
exec spGetEmployees
execute spGetEmployees

-- tegime sp, kus on kaks parameetrit
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employee
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--- kui allpool olevat käsklust käima panna, siis nõuab Gender parameetrit
spGetEmployeesByGenderAndDepartment
-- õige variant
spGetEmployeesByGenderAndDepartment 'Male', 1
-- sp parameetrite järjekorrast saab mööda minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'
-- kuidas vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja võti peale panna, et keegi teine ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employee
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- ei näe enam sp sisu, kui encryption on peale pandud
sp_helptext spGetEmployeesByGenderAndDepartment

select * from Employee

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = COUNT(Id) from Employee where Gender = @Gender
end

--- if ja else loogika, kus näitab ära, töötajate arvu ja vastava teksti,
--- mis asub stringi sees
declare @TotalCount int
exec spGetEmployeeCountByGender 'Male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

-- näitab ära, et mitu rida vastab nõutele
declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out,
@Gender = 'Male'
print @TotalCount

--- 5 tund SQL

-- sp sisu vaatamine, näitab parameetreid ja üldist infot
sp_help spGetEmployeeCountByGender
-- tabeli sisu vaatmine
sp_help Employee
-- saame teada, millest see sp sõltub
sp_depends spGetEmployeeCountByGender
-- vaatame tabli sõltuvust
sp_depends Employee

-- 
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Name = Id, @Name = FirstName from Employee
end

select * from Employee
execute spGetNameById 1, 'Tom'

--- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employee
end

--- saame teada, et mitu rida andmeid on tabelis
declare @TotalEmployees int
exec spTotalCount2 @TotalEmployees output
select @TotalEmployees


---- mis id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin 
	select @FirstName = FirstName from Employee where Id = @Id
end
-- nüüd kasutame üleval olevat sp-d
-- outputi kasutamine
declare @FirstName nvarchar(50)
execute spGetNameById1 4, @FirstName output
print 'Name of the employee = ' + @FirstName

--- out kasutamine
declare @FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName out
print 'Name = ' + @FirstName

-- kasutame return muutujat
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employee where Id = @Id)
end
--- kutsume välja läbi id, mis on int
--- aga FirstName on nvarchar(string) ja seda ei saa muuta int-ks
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

--- SP eelised
-- 1. täideviimise plaani säilitamine ja taaskasutus
-- SP on kompileeritav ja nende täideviimine on säilitatud ja taaskasutatav
-- 2. vähendab võrguliiklust
-- peate saatma ainult käskluse EXECUTE SP_SPNimi
-- 3. Parem koodi taaskasutus ja hooldamine.
-- Sama SP-d saab kasutada igas aplikatsioonis.
-- 4. Parem turvalisus
-- DB kasutajale saab anda ligipääsu SP-le ja hoida ära otsest 
-- SELECT käsklust tabelile
-- 5. Hoiab ära SQL Injection rünnakud

--- sisseehitatud string funktsioonid
-- konverteerib ASCII tähe väärtuse numbriks
select ascii('a')
-- kuvab A-tähte
select CHAR(65)

-- prindime kogu tähestiku välja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

--- eemaldame sulgude sees vasakult poolt tühjad kohad
select ltrim('                               Hello')
--- tühikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employee

--- eemaldame sulgude sees paremalt poolt tühjad kohad
select RTRIM('         Hello                 ')

--- keerame kooloni sees olevad andmed vastupidiseks
--- vastavalt upper ja lower-ga saan muuta märkide suurust
--- reverse funktsioon pöörab kõik ümber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, LOWER(LastName) as asdasd,
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employee

--- soovime teada saada, et mitu tähte on sõnal ja loeb tühikud sisse
select FirstName, LEN(FirstName) as [Total Characters] from Employee
--- kuidas teha niimoodi, et tühikuid ei loeks sisse
select FirstName, LEN(ltrim(FirstName)) as [Total Characters] from Employee

----left, right ja substring
--- vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)
--- paremalt poolt kolm tähte
select RIGHT('ABCDEF', 4)
--- kuvab @-tähemärgi asetust
select CHARINDEX('@', 'sara@aaa.com')
--- esimene nr peale komakohta näitab, et mitmendast alustab 
--- ja mitu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 5, 2)

--- peale @-märki näitab tähemärke meile soovitud ulatuses
--- numbriga reguleerin pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1,
len('pam@bbb.com') - CHARINDEX('@', 'pam@bbb.com'))

--- sisestame uue veeru tabelisse Employee
alter table Employee
add Email nvarchar(20)

select * from Employee

update Employee set Email = 'Tom@aaa.com' where Id = 1
update Employee set Email = 'Pam@bbb.com' where Id = 2
update Employee set Email = 'John@aaa.com' where Id = 3
update Employee set Email = 'Sam@bbb.com' where Id = 4
update Employee set Email = 'Todd@bbb.com' where Id = 5
update Employee set Email = 'Ben@ccc.com' where Id = 6
update Employee set Email = 'Sara@ccc.com' where Id = 7
update Employee set Email = 'Valarie@aaa.com' where Id = 8
update Employee set Email = 'James@bbb.com' where Id = 9
update Employee set Email = 'Russel@bbb.com' where Id = 10


---tahame teada saada domeenimesid emailis
select SUBSTRING (Email, CHARINDEX('@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Employee

--- harjutus 23
--- 6 tund SQL

--- kolm korda näitab stringis olevat väärtust
select REPLICATE('asd', 3)

--- tühiku sisestamine kahe stringi vahele
select SPACE(5)

--- tühikute arv kahe sõna vahel
select FirstName + SPACE(25) + LastName as FullName
from Employee

---PATINDEX
-- sama, mis CHARINDEX, aga dünaamilisem ja saab kasutada wildcardi
select Email, patindex('%@aaa.com', Email) as FirstOccurence
from Employee
where PATINDEX('%@aaa.com', Email) > 0 -- leiab kõik selle domeeni esindajad  
--- ja alates mitmendast märgist algab @ 

--- kõik .com-d asendatakse .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEmail
from Employee

--- soovin asendada peale esimest märki kolm tähte viie tärniga
select FirstName, LastName, Email,
STUFF(Email, 2, 3, '*****') as StuffedEmail
from Employee


---
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

select GETDATE(), 'Getdate()'

insert into DateTime
values (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())

select * from DateTime

update DateTime set c_datetimeoffset = '2022-05-26 08:56:45.7733333 +10:00'
where c_datetimeoffset = '2022-05-26 08:56:45.7733333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja päring
select SYSDATETIME(), 'SYSDATETIME' --- veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --- täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --- UTC aeg

select ISDATE('asd') -- tagastab 0 kuna string ei ole datetime
select ISDATE(GETDATE()) -- tagastab 1 kuna on kp
select ISDATE('2022-05-26 08:56:45.7733333') -- tagastab 0 kuna max kolm komakohta võib olla
select ISDATE('2022-05-26 08:56:45.773') -- tagastab 1
select DAY(GETDATE()) --- annab tänase päeva nr
select DAY('05/23/2022')  -- annab stringis oleva kp nr
select year(GETDATE()) --- annab tänase aasta nr
select year('05/23/2022')
select month(GETDATE()) --- annab kuu nr
select month('07/23/2022')

select DATENAME(DAY, '2022-05-26 08:56:45.773') --annab stringis oleva päeva nr
select DATENAME(WEEKDAY, '2022-05-26 08:56:45.773') -- ananb stringis oleva päeva sõnana
select DATENAME(MONTH, '2022-05-26 08:56:45.773')-- ananb stringis oleva kuu sõnana

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (1, 'Sam', '1980-12-30 00:00:00.000')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (2, 'Pam', '1982-09-01 12:02:36.260')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (3, 'John', '1985-08-22 12:03:30.370')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (4, 'Sara', '1979-11-29 12:59:30.670')

select * from EmployeesWithDates

--- kuidas võtta ühest veerust andmed ja selle abil luua uued veerud
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day],
	MONTH(DateOfBirth) as MonthNumber,
	DATENAME(MONTH, DateOfBirth) as [MonthName],
	YEAR(DateOfBirth) as [Year]
from EmployeesWithDates

select DATEPART(WEEKDAY, '2022-05-26 08:56:45.773') -- kuvab 5 kuna USA nädal algab pühapäevaga
select DATEPART(month, '2022-05-26 08:56:45.773') -- näitab kuu nr
select DATEADD(DAY, 20, '2022-05-26 08:56:45.773') -- liidab stringis olevale kp 20 päeva juurde
select DATEADD(DAY, -20, '2022-05-26 08:56:45.773') -- lahutab stringis olevale kp 20 päeva juurde
select DATEDIFF(month, '11/30/2022', '01/30/2023')-- kuvab kahe stringi kuudevahelist aega nr-na
select DATEDIFF(YEAR, '11/30/2022', '01/30/2029')-- kuvab aastatevahelist aega

--- vanuse arvutamise funktsioon
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - case when (month(@DOB)
		> MONTH(GETDATE())) or (MONTH(@DOB) = MONTH(GETDATE()) and DAY(@DOB) >
		DAY(getdate())) then 1 else 0 end
		select @tempdate = DATEADD(year, @Years, @tempdate)

		select @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - case when DAY(@DOB) >
		DAY(GETDATE()) then 1 else 0 end
		select @tempdate = DATEADD(MONTH, @months, @tempdate)

		select @days = DATEDIFF(DAY, @tempdate, GETDATE())

	declare @Age nvarchar(50)
		set @Age = CAST(@years as nvarchar(4)) + ' Years ' + CAST(@months as nvarchar(2)) +
		' Months ' + CAST(@days as nvarchar(2)) + ' Days old '
	return @Age
end

--- 7 SQL tund
--- harjutus 27

select dbo.fnComputeAge('01/10/1990')

select CAST(GETDATE() as date) -- näitab tänast kp
select CONVERT (date, GETDATE())

select Id, Name, Name + ' - ' cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates

select Id, Name, DateOfBirth,
CONVERT(nvarchar, DateOfBirth, 121) as ConvertedDOB
from EmployeesWithDates

select * from Employee

--- matemaatilised funktsioonid
select ABS(-101.5) -- ABS on absoluutne nr ja tulemuseks saame nr miinuseta.
select CEILING(15.2) -- tagastab 16, kuvab järgmise suurema täisarvu
select CEILING(-15.2) -- annab 15, kuna on suurem, kui -15.2 
select FLOOR(15.2) -- annab vastuseks 15, kuna arvestab allapoole
select FLOOR(-15.2) -- annab vastuseks 16, kuna arvestab allapoole
select power(2, 4) -- 2 astmes 4, matemaatiline funktsioon
-- ja teine korrutaja 
select sqrt (81) -- ruutjuur

select RAND(1) -- annab alati ühe ja sama nr. kui tahad iga kord uur nr, siis
--- ära pane sulgudesse nr-t
select RAND()

select floor(RAND() * 100) -- 1 kuni 100-ni täisnumbrid 

--- 10 suvalist nr-t
declare @Counter int
set @Counter = 1
while (@Counter <= 10)
begin
	print floor(rand() * 1000) 
	set @Counter = @Counter + 1
end

select ROUND(850.556,2) -- ümardab viimase nr järgi tuhandikuks
select ROUND(850.556,2,1) -- ümardab viimase nr järgi tuhandikuks allapoole
select ROUND(850.556, 1) -- ümardab kõige esimese nr peale komakoha järel
select ROUND(850.556, 1, 1) -- ümardab allapoole, kõige esimese nr peale koma 
select ROUND(850.556, -2) -- kaks esimest nr ümardab suuremaks
select ROUND(850.556, -1) -- näitab ainult täisarvu

create function dbo.CalculateAge
declare @Age int
set @Age = DATEDIFF(year, @DOB, GETDATE()) - 
	case
		when(month(@DOB) > MONTH(GETDATE())) or 
			(MONTH(@DOB) > MONTH(GETDATE()) and 
			DAY(@DOB) > DAY(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

select Id, Name, dbo.CalculateAge(DateOfBirth) as Age
from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 40

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (5, 'Todd', '1978-11-29 12:59:30.670')

alter table EmployeesWithDates
add Gender nvarchar(10)

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- kõik naistöötajad
select * from fn_EmployeesByGender('Female')
where Name = 'Pam'
