select cl.Nome, c.ID_Contrato, i.ID_Instalacao from cliente cl
Join instalacao i
ON cl.NIF = i.NIF_Cliente
Join contratos c
ON i.ID_Instalacao = c.ID_Instalacao
