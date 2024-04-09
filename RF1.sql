
insert into servico (Tipo_Servico, Numero_Max_Dispositivos)
values( 'Lowcost' , 2);

insert into servico (Tipo_Servico, Numero_Max_Dispositivos)
values( 'Normal' , 4);

insert into servico (Tipo_Servico, Numero_Max_Dispositivos)
values( 'Professional' , 0);

#select * from servico;

insert into cliente (NIF, nome, Numero_Telefone, Tipo, Morada, Email)
values(123456, 'Raúl', 92313123, 'Empresa', 'Aqui', 'aqwieao@gmail.com');

insert into cliente (NIF, nome, Numero_Telefone, Tipo, Morada, Email)
values(654321, 'Gouveia', 12312423, 'Plebeu', 'Sintra', 'magano@gmail.com');

#select * from cliente;

insert into instalacao (ID_Instalacao, NIF_Cliente, Morada, Tipo)
values (1, 123456, 'la', 'Apartamento');

insert into instalacao (ID_Instalacao, NIF_Cliente, Morada, Tipo)
values (2, 123456, 'aqui', 'Apartamento');

insert into instalacao (ID_Instalacao, NIF_Cliente, Morada, Tipo)
values (3, 123456, 'acola', 'Apartamento');

select * from instalacao;

insert into instalacao (ID_Instalacao, NIF_Cliente, Morada, Tipo)
values (4, 654321, 'baza', 'Apartamento');

select * from instalacao;

insert into contratos (ID_Contrato, ID_Instalacao, Tipo_Servico, Data_Inicio, Duracao, Custo)
values (1, 2, 'Lowcost', '2024-01-24', 5, 10000);

insert into contratos (ID_Contrato, ID_Instalacao, Tipo_Servico, Data_Inicio, Duracao, Custo)
values (2, 1, 'Lowcost', '2024-01-24', 5, 10000);

select * from contratos;

insert into dispositivos (Referencia, ID_Instalacao, Tipo, Modelo, Data_Instalacao, Estado, Valor_Lido)
values (12345, 1, 'termómetro', 'Ferrari' , '2024-01-27', true , 10);

insert into dispositivos (Referencia, ID_Instalacao, Tipo, Modelo, Estado, Valor_Lido)
values (123456, 2, 'termómetro', 'Ferrari', '2024-01-27', true , 10);

select * from dispositivos;

insert into fatura (Numero_Fatura, ID_contrato, Data_Emissao)
values (12345, 1, '2024-01-25');

update fatura
set Estado_Fatura= 'Paga'
where Numero_Fatura = 12345;