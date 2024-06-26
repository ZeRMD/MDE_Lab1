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
Create procedure insert_contrato(IN ID_Instalacao int(11),IN Tipo_Servico varchar(45), IN Custo decimal(10,2), IN Duracao int(11))
Begin
	
	insert into contratos (ID_Instalacao, Tipo_Servico, Data_Inicio, Custo_Mensal, Duracao)
	values(ID_Instalacao, Tipo_Servico, now(), Custo, Duracao);

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
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A instalação já tem o número máximo de dispositivos para o tipo de serviço';
    else
    insert into dispositivos (Referencia, ID_Instalacao, Tipo, Modelo, Data_Instalacao, Estado)
	values(Referencia,ID_Instalacao , Tipo, Modelo, now(), Estado);
    
    call incrementar_numero_dispositivos(ID_Instalacao, 1);
    
    end if;
end; $$$
Delimiter ;

DELIMITER $$$
Create procedure delete_dispositivo(IN INReferencia int(11))
Begin

    delete from dispositivos
    where Referencia = INReferencia;
    
    call incrementar_numero_dispositivos((select ID_instalacao from dispositivos where Referencia = INReferencia), 0);
    
end; $$$
Delimiter ;

###################
#Inserir Faturas
###################

DELIMITER $$$
Create procedure insert_fatura(IN INID_Contrato int(11))
Begin
    declare custo decimal(10,2);
    
    select Custo_Mensal into custo from contratos where ID_Contrato = INID_Contrato;
    
    insert into fatura (ID_Contrato, Data_Emissao, Custo_Fatura, Estado_Fatura)
	values(INID_Contrato, now(), custo, 'Por Pagar');
    
end; $$$
Delimiter ;

DELIMITER $$$
create procedure faturas_automaticas ()
Begin
	
    declare nao_ha_mais_contratos integer default 0;
    Declare INID_Contrato int(11);
    
	declare Contrato_Atual cursor for 
	select ID_Contrato from contratos;
	
	declare continue handler for not found set nao_ha_mais_contratos = 1;
    
	open Contrato_Atual;
    
	Loop_Pelos_Contratos: loop
		fetch Contrato_Atual into INID_Contrato;
		
        if nao_ha_mais_contratos = 1 then
			leave Loop_Pelos_Contratos;
		end if;
        
        call insert_fatura(INID_Contrato);

    end loop Loop_Pelos_Contratos;    
	
    close Contrato_Atual;
end; $$$
Delimiter ;

# a cada segundo dia do mes fazer as faturas 
CREATE EVENT faturas_mensais
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2024-05-02'
DO call faturas_automaticas();

###################
#Inserir Automacao
###################

DELIMITER $$$
Create procedure insert_automacao(IN Dispositivo_Cond int(11), IN INRelacao varchar(45), IN Referencia decimal(10,2), IN Dispositivo_Acao int(11), IN INAcao varchar(45))
Begin
    
    if ((select ID_Instalacao from dispositivos where Referencia = Dispositivo_Cond) != (select ID_Instalacao from dispositivos where Referencia = Dispositivo_Acao)) then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ambos os dispositivos têm de estar na mesma Instalação';
    else
		insert into automacao (Referencia_Dispositivo_Cond, Referencia_Dispositivo_Acao, Relacao, Valor_Referencia, Acao, Data_Implementacao)
		values(Dispositivo_Cond, Dispositivo_Acao, INRelacao, Referencia, INAcao, now());
	end if;
end; $$$
Delimiter ;

###################
#Automacao ao update dispositivos
###################

create or replace view ver_automacao as
select Referencia_Dispositivo_Cond, Referencia_Dispositivo_Acao, Relacao, Valor_Referencia, Acao from automacao;

DELIMITER $$$
CREATE FUNCTION Numero_Automacao_Com_Disp (Dispositivo_Cond int(11))
RETURNS INT
BEGIN
	declare Numero_De_Automacoes_com_Disp int;
    
    select count(Referencia_Dispositivo_Cond) into Numero_De_Automacoes_com_Disp from automacao
    where Referencia_Dispositivo_Cond = Dispositivo_Cond;
    
    return Numero_De_Automacoes_com_Disp;
    
END;$$$
DELIMITER ;

DELIMITER $$$
Create procedure trata_update_disp_automacao(IN Valor_Leitura_Novo decimal(10,2), IN Ref_Disp_Acao INT(11), IN Relacao VARCHAR(45), IN Valor_Ref decimal(10,2), IN INAcao VARCHAR(45))
Begin
	if Relacao = '<' then  
		if (Valor_Leitura_Novo < Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	elseif Relacao = '<=' then
		if (Valor_Leitura_Novo <= Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	elseif Relacao = '=' then
		if (Valor_Leitura_Novo = Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	elseif Relacao = '!=' then
		if (Valor_Leitura_Novo != Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	elseif Relacao = '>' then
		if (Valor_Leitura_Novo > Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	elseif Relacao = '>=' then
		if (Valor_Leitura_Novo >= Valor_Ref) then
				
				insert into acao(Referencia, Acao, Data_Acao) 
                values(Ref_Disp_Acao, INAcao, now());
            
		end if;
	end if;
end; $$$
Delimiter ;

DELIMITER $$$
create trigger update_Dispositivos
before update on dispositivos for each row
Begin
	
    declare nao_ha_mais_Automacoes integer default 0;
    
    DECLARE Ref_Disp_Cond INT(11);
    DECLARE Ref_Disp_Acao INT(11);
	DECLARE Relacao VARCHAR(45);
    DECLARE Valor_Ref decimal(10,2);
	DECLARE Acao VARCHAR(45);
    
    DECLARE Valor_Leitura_Novo decimal(10,2);
    
	declare Automacao_Atual cursor for 
	select * from ver_automacao where Referencia_Dispositivo_Cond = new.Referencia;
	
	declare continue handler for not found set nao_ha_mais_Automacoes = 1;
	
    set Valor_Leitura_Novo = new.Valor_Leitura;
    set new.Data_Ultima_Leitura = now();
    
    open Automacao_Atual;
    
	Loop_Pelas_Automacoes: loop
		fetch Automacao_Atual into Ref_Disp_Cond, Ref_Disp_Acao, Relacao, Valor_Ref, Acao;
		
        if nao_ha_mais_Automacoes = 1 then
			leave Loop_Pelas_Automacoes;
		end if;
        
        call trata_update_disp_automacao(Valor_Leitura_Novo, Ref_Disp_Acao, Relacao, Valor_Ref, Acao);

    end loop Loop_Pelas_Automacoes;    
	
    close Automacao_Atual;
    
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

####################
#Introducao de dados
####################

insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Lowcost' , 2);
insert into servico (Tipo_Servico, Numero_Max_Dispositivos) values( 'Normal' , 4);
insert into servico (Tipo_Servico) values( 'Professional' );

