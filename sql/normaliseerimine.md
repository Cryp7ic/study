## Normaliseerimine (normalization)
Normaliseerimine on andmebaasi kujundamise tehnika, mis vähendab andmete liiasust ja kõrvaldab soovimatud omadused, nagu sisestamise, värskendamise ja kustutamise anomaaliad. Normaliseerimisreeglid jagavad suuremad tabelid väiksemateks tabeliteks ja lingivad need seoste abil. SQL-i normaliseerimise eesmärk on kõrvaldada üleliigsed (korduvad) andmed ja tagada andmete loogiline salvestamine.

Database normal forms in SQL:
- 1NF (First Normal Form)
- 2NF (Second Normal Form)
- 3NF (Third Normal Form)
- BCNF (Boyce-Codd Normal Form)
- 4NF (Fourth Normal Form)
- 5NF (Fifth Normal Form)
- 6NF (Sixth Normal Form)

### 1NF (First Normal Form) rules
- Each table cell should contain a single value
- Each record needs to be unique

### 2NF (Second Normal Form) rules
- Rule 1- Be in 1NF
- Rule 2- Single Column Primary Key that does not functionally dependant on any    subset of candidate ket relation.

### 3NF (Third Normal Form) rules
- Rule 1- Be in 2NF
- Rule 2- Has no transitive functional dependencies

### BCNF (Boyce-Codd Normal Form)
Even when a database is in 3rd Normal form, still there would be anomalies resulted if it has more than one Candidate key.

Sometimes BCNF is also referred as 3.5 Normal Form.

### 4NF (Fourth Normal Form) rules
If no database table instance contains two or more, independent and multivated data describing the relevant entity, then it is in 4th Normal Form.

### 5NF (Fifth Normal Form) rules
A able is in 5th Normal Form only if it is in 4NF and it cannot be decomposed into any number of smaller tables without loss of data. 

### 6NF (Sixth Normal Form) proposed
6th Nomral Form is not standarized, yet however, it is being discussed by database experts for some time. Hopefully, we would have a clear & standardized definition for 6th Normal Form in the near future...



Source:
https://www.guru99.com/database-normalization.html

