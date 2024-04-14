# todos os dispositivos que um cliente tem em todas as suas instalacoes
select d.referencia, d.tipo, d.modelo, d.Data_Instalacao from cliente c
JOIN Instalacao i
ON c.NIF = i.NIF_Cliente
JOIN dispositivos d
ON i.ID_Instalacao = d.ID_Instalacao
where c.NIF = 'Nif Do Cliente';

select d.referencia, d.tipo, d.modelo, d.Data_Instalacao from cliente c
JOIN Instalacao i
ON c.NIF = i.NIF_Cliente
JOIN Dispositivos d
ON i.ID_Instalacao = d.ID_Instalacao
where c.NIF = 12345;