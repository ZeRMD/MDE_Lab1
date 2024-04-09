DELIMITER $$$
Create procedure ver_numero_max_dispositivos( IN ID_Instalacao int(11))
Begin
	
    if exists (select ID_Instalacao from instalacao) then
		select s.Numero_Max_Dispositivos from instalacao i
		Join contratos c
		ON i.ID_Instalacao = c.ID_Instalacao
		Join servico s
		On s.Tipo_Servico = c.Tipo_Servico
		where i.ID_Instalacao = ID_Instalacao;
        end if;
        
END; $$$
DELIMITER ;

DELIMITER $$$
Create procedure teste()
Begin
	
    if (call ver_numero_max_dispositivos (1) < 2) then
		
        end if;
        
END; $$$
DELIMITER ;

drop procedure ver_numero_max_dispositivos;

call ver_numero_max_dispositivos (1);

DELIMITER $$$
Create procedure insert_Client(IN Nome varchar(20), IN NIF int(11), IN Numero_De_Telefone int(11), IN Tipo varchar(45), IN Morada varchar(45), IN Email varchar(45))
Begin

	insert into cliente (NIF, nome, Numero_Telefone, Tipo, Morada, Email)
	values(Nome, NIF, Numero_De_Telefone, Tipo, Morada, Email);

END; $$$
DELIMITER ;

DELIMITER $$$
Create procedure insert_instalacao(IN NIF_Cliente int(11),IN Morada varchar(45), IN Tipo varchar(45))
Begin
    
	insert into instalacao (NIF_Cliente, Morada, Tipo)
	values(NIF_Cliente, Morada, Tipo);
	
	select i.ID_Instalacao from instalacao i
    where i.Morada = Morada;
    
END; $$$
DELIMITER ;

drop procedure insert_instalacao;

call insert_instalacao(123456, 'bazaza', 'Apartamento');

select * from instalacao;

DELIMITER $$$
Create procedure insert_contrato(IN ID_Instalacao int(11),IN Tipo_Servico varchar(45), IN Custo int(11), IN Duracao int(11))
Begin
	
	insert into contratos (ID_Instalacao, Tipo_Servico, Data_Inicio, Custo, Duracao)
	values(ID_Instalacao,Tipo_Servico,now(), Duracao, Custo);

	select c.ID_Contrato from contratos c
    where c.ID_Instalacao = ID_Instalacao;

END; $$$
DELIMITER ;