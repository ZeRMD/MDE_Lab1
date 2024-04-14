select i.ID_Instalacao, i.NIF_Cliente, i.Morada, i.Numero_Dispositivos, i.Tipo from instalacao i
join dispositivos d
on i.ID_Instalacao = d.ID_Instalacao
join automacao a
on a.Referencia_Dispositivo_Cond = d.Referencia
where a.Data_Implementacao > 'inicio do intervalo' and d.Data_Implementacao < 'fim do intervalo';

select i.ID_Instalacao, i.NIF_Cliente, i.Morada, i.Numero_Dispositivos, i.Tipo from instalacao i
join dispositivos d
on i.ID_Instalacao = d.ID_Instalacao
join automacao a
on a.Referencia_Dispositivo_Cond = d.Referencia
where a.Data_Implementacao > '2024-01-25' and d.Data_Implementacao < '2024-01-29'