DELIMITER $$$
Create procedure insert_Automacao(IN ID_Instalacao varchar(20), IN Data datetime, IN acao varchar(45), IN nome_Trigger varchar(45))
Begin
	

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

DELIMITER $$$
Create procedure insert_contrato(IN ID_Instalacao int(11),IN Tipo_Servico varchar(45), IN Custo int(11), IN Duracao int(11))
Begin
	
	insert into contratos (ID_Instalacao, Tipo_Servico, Data_Inicio, Custo, Duracao)
	values(ID_Instalacao,Tipo_Servico,now(), Duracao, Custo);

	select c.ID_Contrato from contratos c
    where c.ID_Instalacao = ID_Instalacao;

END; $$$
DELIMITER ;

DELIMITER $$$
Create procedure insert_dispositivo(IN ID_Instalacao int(11),IN Tipo_Servico varchar(45), IN Custo int(11), IN Duracao int(11))
Begin
	
	insert into contratos (ID_Instalacao, Tipo_Servico, Data_Inicio, Custo, Duracao)
	values(ID_Instalacao,Tipo_Servico,now(), Duracao, Custo);

	select c.ID_Contrato from contratos c
    where c.ID_Instalacao = ID_Instalacao;

END; $$$
DELIMITER ;

DELIMITER $$$

