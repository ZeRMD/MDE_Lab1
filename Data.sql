####################
#Introducao de dados
####################

insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Lowcost' , 2);
insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Normal' , 4);
insert into servico (Tipo_Servico) values( 'Professional' );

call insert_Client('Raúl', 12345, 932444111, 'Empresa', 'Aqui', 'ra@gmail.com');
call insert_Client('Nando', 54321, 932444121, 'Empresa', 'Aquilo', 'na@gmail.com');
call insert_Client('Bento', 13245, 932444131, 'Individuo', 'Aquilho', 'be@gmail.com');

call insert_instalacao('12345','Onde eu moro', 'Apartamento');
call insert_instalacao('12345','Onde ele moro', 'Apartamento');
call insert_instalacao('54321','Onde ela mora', 'Loja');

call insert_instalacao('13245', 'Av Java', 'Loja');

call insert_contrato(1,'Lowcost', 1000, 4);
call insert_contrato(2,'Professional', 2000, 5);
call insert_contrato(3,'Lowcost', 3000, 6);

call insert_contrato(4, 'Professional', 150, 1);

call insert_dispositivo(1, 1, 'Termometro', 'dobomedomelhor', false);
call insert_dispositivo(2, 1, 'Aquecedor', 'dobomedomelhor', false);

call insert_dispositivo(3, 3, 'Sensor de movimento', 'dobomedomelhor', false);

call insert_dispositivo(10, 4, 'Aquecedor', '16DC5E', false);
call insert_dispositivo(11, 4, 'Frigorifico', '16A631', false);
call insert_dispositivo(12, 4, 'Passadeira', '6F3275', false);
call insert_dispositivo(13, 4, 'Termometro', 'MQ9', false);
call insert_dispositivo(14, 4, 'Gas', 'DS18B20', false);

call insert_fatura(1);
call insert_fatura(2);
call insert_fatura(3);

call pagar_fatura(1);
call pagar_fatura(2);