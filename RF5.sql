SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email, c.Tipo_Servico FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF 
Join Contratos c
ON c.ID_Instalacao = i.ID_Instalacao
WHERe Tipo_Servico = 'Tipo de Servico';

SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email, c.Tipo_Servico FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF 
Join Contratos c
ON c.ID_Instalacao = i.ID_Instalacao
WHERe Tipo_Servico = 'Lowcost';