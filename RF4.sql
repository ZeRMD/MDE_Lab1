SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF
WHERe i.Tipo = 'Tipo de Instalacao';

SELECT cl.NIF, cl.Nome, cl.Numero_Telefone, cl.Tipo, cl.Morada, cl.Email FROM cliente cl
Join Instalacao i
ON i.NIF_Cliente = cl.NIF
WHERe i.Tipo = 'Apartamento';

