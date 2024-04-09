create trigger novo_dispositivo
before insert
on dispositivos for each row
	set New.Data_Instalacao = NOW();

create trigger novo_dispositivo
before insert
on dispositivos for each row

Begin

	

End;