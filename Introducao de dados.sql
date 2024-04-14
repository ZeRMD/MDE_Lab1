####################
#Introducao de dados
####################

call insert_Client('Raúl', 12345, 932444111, 'Empresa', 'Aqui', 'oquetuqueresseieu@gmail.com');
call insert_Client('Gouveia', 54321, 932444111, 'Empresa', 'Aquilo', 'oquetuqueressabiaeu@gmail.com');
call insert_Client('Bento', 13245, 932444111, 'Empresa', 'Aquilho', 'oquetuqueressoubeeu@gmail.com');

insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Lowcost' , 2);
insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Normal' , 4);
insert into servico (Tipo_Servico) values( 'Professional' );

call insert_instalacao('12345','Onde eu moro', 'Apartamento');
call insert_instalacao('12345','Onde ele moro', 'Apartamento');
call insert_instalacao('54321','Onde ela mora', 'Loja');

call insert_contrato(1,'Lowcost', 1000, 4);
call insert_contrato(2,'Professional', 2000, 5);
call insert_contrato(3,'Lowcost', 3000, 6);

call insert_dispositivo(1, 1, 'Termometro', '25bemgusti',false);
call insert_dispositivo(2, 1, 'Aquecedor', '25bemgusti',false);

call insert_automacao(1, 2, '>' ,20,'Desligar');
call insert_automacao(1, 2, '<' ,18,'Ligar');

update dispositivos
set Valor_Leitura = 19.00
where Referencia = 1;

call insert_fatura(1);

update fatura
set Estado_Fatura= 'Paga'
where Numero_Fatura = 2;

select * from fatura;