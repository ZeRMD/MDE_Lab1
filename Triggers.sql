Delimiter $$$
create trigger novo_valor_termometro
after update
on dispositivos for each row

Begin
    declare hoje datetime;
    
    set hoje = now();
    
    
    
end; $$$
Delimiter ;

Delimiter $$$
create trigger insert_dispositivo
before insert
on dispositivos for each row

Begin
    
    if (Posso_Add_dispositivo(new.ID_Instalacao) = 0) then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A instalação já tem o número máximo de dispositivos para o tipo de servico';
    end if;
    set New.Data_Instalacao = NOW();
    
end; $$$
Delimiter ;