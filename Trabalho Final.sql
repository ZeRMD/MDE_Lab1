###################
#Inserir clientes
###################

DELIMITER $$$
Create procedure insert_Client(IN Nome varchar(20), IN NIF int(11), IN Numero_De_Telefone int(11), IN Tipo varchar(45), IN Morada varchar(45), IN Email varchar(45))
Begin

	insert into cliente (NIF, nome, Numero_Telefone, Tipo, Morada, Email)
	values(NIF, Nome, Numero_De_Telefone, Tipo, Morada, Email);

END; $$$
DELIMITER ;

###################
#Inserir Instalações
###################

DELIMITER $$$
Create procedure insert_instalacao(IN NIF_Cliente int(11),IN Morada varchar(45), IN Tipo varchar(45))
Begin
    
	insert into instalacao (NIF_Cliente, Morada, Tipo)
	values(NIF_Cliente, Morada, Tipo);
	
	select i.ID_Instalacao from instalacao i
    where i.Morada = Morada;
    
END; $$$
DELIMITER ;

###################
#Inserir contrato
###################

DELIMITER $$$
Create procedure insert_contrato(IN ID_Instalacao int(11),IN Tipo_Servico varchar(45), IN Custo int(11), IN Duracao int(11))
Begin
	
	insert into contratos (ID_Instalacao, Tipo_Servico, Data_Inicio, Custo, Duracao)
	values(ID_Instalacao,Tipo_Servico,now(), Duracao, Custo);

	select c.ID_Contrato from contratos c
    where c.ID_Instalacao = ID_Instalacao;

END; $$$
DELIMITER ;

###################
#Inserir dispositivos
###################

create or replace view Instalacao_dispositivos_dispositivos_max AS
select i.ID_Instalacao, Numero_Dispositivos, Numero_MAX_Dispositivos From instalacao i
Join contratos c
ON i.ID_Instalacao = c.ID_Instalacao
JOIN servico s
ON c.Tipo_Servico = s.Tipo_Servico;

DELIMITER $$$
CREATE FUNCTION Posso_Add_dispositivo (ID_Insta int(11))
RETURNS INT
BEGIN
	declare numero_dispositivos_max_da_instalacao int;
	declare numero_dispositivos_da_instalacao int;

	SELECT Numero_Dispositivos into numero_dispositivos_da_instalacao FROM Instalacao_dispositivos_dispositivos_max WHERE ID_Instalacao = ID_Insta;
    SELECT Numero_MAX_Dispositivos into numero_dispositivos_max_da_instalacao FROM Instalacao_dispositivos_dispositivos_max WHERE ID_Instalacao = ID_Insta; 

	if numero_dispositivos_max_da_instalacao = null then 
		return 1;
	end if;
    
    IF numero_dispositivos_da_instalacao = numero_dispositivos_max_da_instalacao THEN
		return 0;
    else 
		return 1;
    END IF;
    
END;$$$
DELIMITER ;

Delimiter $$$
Create procedure incrementar_numero_dispositivos(IN ID_Instalaca int(11), IN incrementar_decrementar tinyint)
Begin
	declare numero_dispositivos_da_instalacao int;
    
    SELECT Numero_Dispositivos into numero_dispositivos_da_instalacao FROM Instalacao_dispositivos_dispositivos_max WHERE ID_Instalacao = ID_Instalaca;
    
    if incrementar_decrementar = 1 then    
		update instalacao
		set Numero_Dispositivos = numero_dispositivos_da_instalacao + 1
		where ID_Instalacao = ID_Instalaca;
    else
		update instalacao
		set Numero_Dispositivos = numero_dispositivos_da_instalacao - 1
		where ID_Instalacao = ID_Instalaca;
	end if;
END; $$$
DELIMITER ;

DELIMITER $$$
Create procedure insert_dispositivo(IN Referencia int(11), IN ID_Instalacao int(11), IN Tipo varchar(45), IN Modelo varchar(45), IN Estado tinyint(4))
Begin
    
    if (Posso_Add_dispositivo(ID_Instalacao) = 0) then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A instalação já tem o número máximo de dispositivos para o tipo de servico';
    end if;
    
    insert into dispositivos (Referencia, ID_Instalacao, Tipo, Modelo, Data_Instalacao, Estado)
	values(Referencia,ID_Instalacao , Tipo, Modelo, now(), Estado);
    
    call incrementar_numero_dispositivos(ID_Instalacao, 1);
    
end; $$$
Delimiter ;

###################
#Inserir Automacao
###################

DELIMITER $$$
Create procedure insert_automacao(IN Dispositivo_Cond int(11), IN Dispositivo_Acao int(11), IN INRelacao varchar(45), IN Referencia int(11), IN INAcao varchar(45))
Begin
    declare ID int;
    
    insert into automacao (Referencia_Dispositivo_Cond, Referencia_Dispositivo_Acao, Relacao, Valor_Referencia, Acao, Data)
    values(Dispositivo_Cond, Dispositivo_Acao, INRelacao, Referencia, INAcao, now());
    
	select ID Encontrar_ID_Automacao;
    
    #Fazer o trigger dinamico
	#Primeiro switch com as relacoes
    #Dentro dos switch ter as outras merdas todas
    #Fazer o nome do bixo relacionado ao id
    #Great Sucess
    
end; $$$
Delimiter ;

DELIMITER $$$
CREATE FUNCTION Encontrar_ID_Automacao (Dispositivo_Cond int(11), Dispositivo_Acao int(11), INRelacao varchar(45), Referencia int(11), INAcao varchar(45))
RETURNS INT
BEGIN
	declare ID int;
    
    select ID_Automacao into ID from automacao
    where Referencia_Dispositivo_Cond = Dispositivo_Cond and Referencia_Dispositivo_Acao = Dispositivo_Acao and Relacao = INRelacao and Valor_Referencia = Referencia and Acao = INAcao;
    
    return ID;
    
END;$$$
DELIMITER ;
