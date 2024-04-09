/*
table creation
*/

create table student(

	st_number integer,
    st_name varchar(127),
    address varchar(255),
	postal_code varchar(10),
    city varchar(64),
    st_email varchar(64)
);

-- see table structure
describe student;

/* 2 - insert some students in the student table */

insert into student (st_number, st_name, city)
values (254908349, 'Gouveia', 'Lisboa');

insert into student (st_number, st_name, city)
values (1780151, 'Nando', 'Funchal');

insert into student (st_number, st_name, city)
values (63533, 'Tiago', 'Lisboa');

insert into student (st_number, st_name, city)
values (8001, 'Tiago', 'Lisboa');

/*3 - Ver o que lá meti */

select * from student;

select st_number, city
from student;

/*4 - Update Data */

update student
set postal_code= '1000', address= 'Rua aqui da esquina', st_email= 'oralilolo@gmail.com'
where st_number = '8001';

/*5 - delete student 8001 da tabela  */

delete from student where st_number = '8001';

/*6 - inserir um student sem nome */

insert into student(st_name, city) values ('Antonio','Da esquina');

/*7 - colocar um constraint para impedir que um aluno se registe sem colocar numero*/

alter table student add constraint st_number_null_ctrl check (st_number is not null);

/*8 - enserir um estudante com o mesmo numero que outro*/

insert into student (st_number, st_name, city)
values (63533, 'Dani', 'Badajos');

insert into student (st_number, st_name, city)
values (63532, 'Dani', 'Badajos');

alter table student add constraint st_number_unique unique(st_number);

insert into student (st_number, st_name, city)
values (63533, 'Dani', 'Badajei');

delete from student where st_number = 63532;

insert into student (st_number, st_name, city)
values (63532, 'DaniEL', 'aqui');

insert into student (st_number, st_name, city)
values (63532, 'joca', 'aqui');

/*
aqui foi brincadeixon
*/

create table student (
	st_number integer not null,
    unit_name varchar (100) not null,
    grade integer,
    dpt_id integer
);

alter table student add constraint grade_between_0_20 check(grade between 0 and 20);

create table departamento (
	dpt_id integer not null,
    dpt_name varchar (100) not null
);

alter table departamento add constraint pkey primary key(dpt_id);

alter table student add constraint fkey foreign key(dpt_id) references departamento(dpt_id);

insert into departamento (dpt_id, dpt_name)
values (10, 'DEEC');

insert into departamento (dpt_id, dpt_name)
values (2, 'DEI');

insert into departamento (dpt_id, dpt_name)
values (9, 'DEM');

insert into student (st_number, unit_name, grade, dpt_id)
values(63226, 'Manel', 10, 2);

insert into student (st_number, unit_name, grade, dpt_id)
values(62940, 'Lourenço', 2, 10);

insert into student (st_number, unit_name, grade, dpt_id)
values(63282, 'Raúl', 19, 10);

insert into student (st_number, unit_name, grade, dpt_id)
values(63777, 'Cris', 10, 2);

select * from student;
select * from departamento;

select unit_name, grade, dpt_name from student, departamento
where departamento.dpt_id = student.dpt_id;

select unit_name, dpt_name from student, departamento
where student.dpt_id = 10 and grade > 9 and departamento.dpt_id = student.dpt_id;

/*Ter o cuidado de colocar condicoes de ambas as dbs*/

select unit_name, dpt_name from student, departamento
where student.dpt_id = 10 and grade > 9;
