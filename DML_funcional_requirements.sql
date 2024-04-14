################
#
# Grande parte do código que fazer estes requerimentos funcionar está na pasta "DML_procedures_functions_triggers"
#
################

################
# RF1
################

insert into cliente (NIF, nome, Numero_Telefone, Tipo, Morada, Email)
values(12121212, 'Jorge', 92313177, 'Empresa', 'Avenida do 19', 'trabalhopara20@gmail.com');

select * from cliente where NIF = 12121212;

update cliente
set Morada = 'Avenida do 20'
where NIF = 12121212;

select * from cliente where NIF = 12121212;

delete from cliente where NIF = 12121212;

################
# RF2
################

call update_valor_dispositivo(1, 19);
call update_valor_dispositivo(2, 12.00);
call update_valor_dispositivo(3, 5);

################
# RF3
################

call insert_automacao(1, '>', 20, 2,'Desligar');
call insert_automacao(1, '<', 17, 2,'Desligar');

call update_valor_dispositivo(1, 21);

select * from acao;

call update_valor_dispositivo(1, 16);

select * from acao;

call update_valor_dispositivo(1, 19);

select * from acao;

################
# RF4
################

SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF
WHERe i.Tipo = 'Apartamento';

################
# RF5
################

SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email, c.Tipo_Servico FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF 
Join Contratos c
ON c.ID_Instalacao = i.ID_Instalacao
WHERe Tipo_Servico = 'Lowcost';

################
# RF6
################

SELECT d.Tipo ,d.Referencia, d.Modelo, d.Estado, d.Valor_Lido, d.Data_Instalacao from dispositivos d
Join Instalacao i
ON i.ID_Instalacao = d.ID_Instalacao
WHERE d.Data_Instalacao > '2024-01-25' and d.Data_Instalacao < '2024-01-29'
Group by d.Data_Instalacao 
order BY Data_Instalacao  DESC;

SELECT d.Tipo ,d.Referencia, d.Modelo, d.Estado, d.Valor_Lido, d.Data_Instalacao from dispositivos d
Join Instalacao i
ON i.ID_Instalacao = d.ID_Instalacao
WHERE d.Data_Instalacao > '2024-01-25' and d.Data_Instalacao < '2024-05-25'
Group by d.Data_Instalacao 
order BY Data_Instalacao  DESC;

################
# RF7
################

SELECT avg(f.Custo_Fatura), cl.Nome from Contratos c
Join Instalacao i
ON i.ID_Instalacao = c.ID_Instalacao
JOIN Cliente cl
ON cl.NIF = i.NIF_Cliente
Join fatura f
ON f.ID_Contrato = c.ID_Contrato
WHERE f.Estado_Fatura = 'Paga' and cl.Nome = 'Raúl'
Group by custo 
order BY custo DESC;

################
# RF8
################

select i.ID_Instalacao, i.NIF_Cliente, i.Morada, i.Numero_Dispositivos, i.Tipo from instalacao i
join dispositivos d
on i.ID_Instalacao = d.ID_Instalacao
join automacao a
on a.Referencia_Dispositivo_Cond = d.Referencia
where a.Data_Implementacao > '2024-01-25' and d.Data_Implementacao < '2024-01-29';

select i.ID_Instalacao, i.NIF_Cliente, i.Morada, i.Numero_Dispositivos, i.Tipo from instalacao i
join dispositivos d
on i.ID_Instalacao = d.ID_Instalacao
join automacao a
on a.Referencia_Dispositivo_Cond = d.Referencia
where a.Data_Implementacao > '2024-01-25' and d.Data_Implementacao < '2024-06-29';

################
# RF9
################


################
# RF10
################

# todos os dispositivos que um cliente tem em todas as suas instalacoes
select d.referencia, d.tipo, d.modelo, d.Data_Instalacao from cliente c
JOIN Instalacao i
ON c.NIF = i.NIF_Cliente
JOIN Dispositivos d
ON i.ID_Instalacao = d.ID_Instalacao
where c.NIF = 12345;

################
# RF11
################

# Media do numero de dispositivos presente nas instalacoes
SELECT avg(Numero_Dispositivos) from instalacao;

################
# RF12
################

# Número de automacoes numa dada instalacao
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