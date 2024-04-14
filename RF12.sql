DELIMITER $$$
CREATE FUNCTION Numero_Automacao_Instalacao (INID_Instalacao int(11))
RETURNS INT
BEGIN
	declare contagem int;
    
    select count(Referencia_Dispositivo_Cond) into Contagem from automacao a
    join dispositivos d
    where a.Referencia_Dispositivo_Cond = d.Referencia and d.ID_Instalacao = INID_Instalacao;
    
    return contagem;
    
END;$$$
DELIMITER ;

select Numero_Automacao_Instalacao(1);