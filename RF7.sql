SELECT avg(f.Custo_Fatura), cl.Nome from Contratos c
Join Instalacao i
ON i.ID_Instalacao = c.ID_Instalacao
JOIN Cliente cl
ON cl.NIF = i.NIF_Cliente
Join fatura f
ON f.ID_Contrato = c.ID_Contrato
WHERE f.Estado_Fatura = 'Paga' and cl.Nome = 'Nome do cliente'
Group by custo 
order BY custo DESC;

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