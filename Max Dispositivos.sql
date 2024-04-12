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