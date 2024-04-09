#
# ver_tudo mostra para cada Pessoa todos os seus Contratos e Instalações
#
create or replace view ver_tudo as
select cl.Nome, c.ID_Contrato, i.ID_Instalacao from cliente cl
Join instalacao i
ON cl.NIF = i.NIF_Cliente
Join contratos c
ON i.ID_Instalacao = c.ID_Instalacao;

select * from ver_tudo;

#
# 
create or replace view ver_tudo as
select * from ver_tudo;

#
# ver_faturas mostra para cada Pessoa todas as suas Faturas
#
create or replace view ver_faturas as
select f.Numero_Fatura, cl.Nome, f.Estado_Fatura ,c.ID_Contrato, i.ID_Instalacao, c.custo from cliente cl
Join instalacao i
ON cl.NIF = i.NIF_Cliente
Join contratos c
ON i.ID_Instalacao = c.ID_Instalacao
Join fatura f
ON f.ID_Contrato = c.ID_Contrato
Group by custo 
order BY custo DESC;

select * from ver_faturas;