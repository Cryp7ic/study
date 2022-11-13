select * from Andmed

--- 1.


--- 2.
alter table Andmed
alter column Nimi nvarchar(25);
alter table Andmed
alter column Linn nvarchar(25);
alter table Andmed
alter column Aadress nvarchar(30);
alter table Andmed
alter column Telefon nvarchar(12);
alter table Andmed
alter column Sugu nvarchar(1);

--- 3.
update Andmed
set Linn = 'Pärnu'
where Linn = 'Prnu';

--- 4.
select Nimi from Andmed where Nimi like '%k%';

--- 5. 
select Nimi from Andmed where Nimi is NULL;

--- 6. 
select * from Andmed where Linn = 'Pärnu' and Sugu = 'm';

--- 7. 
select * from Andmed where Aadress is NULL;

--- 8.
select Telefon from Andmed where Telefon is NULL;

--- 9.
select * from Andmed where Palk like '0%';

--- 10. 
select * from Andmed where Palk is NULL or Palk like '0%';

--- 11. 
select * from Andmed where Linn like '%-%';

--- 12.
select * from Andmed where S_nniaeg between '1982.01.01' and '1992.01.01';

--- 13.
select * from Andmed where S_nniaeg < '1900.12.31';

--- 14.
select * from Andmed where S_nniaeg > '2005.01.01';

--- 15. 
select SUM(Palk) from Andmed;

--- 16. 

select Linn, SUM(Palk) as TotalSalary from Andmed group by Linn;

