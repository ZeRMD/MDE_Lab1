SELECT d.Tipo ,d.Referencia, d.Modelo, d.Estado, d.Valor_Lido, d.Data_Instalacao from dispositivos d
Join Instalacao i
ON i.ID_Instalacao = d.ID_Instalacao
WHERE d.Data_Instalacao > 'inicio do intervalo' and d.Data_Instalacao < 'fim do intervalo'
Group by d.Data_Instalacao 
order BY Data_Instalacao  DESC;

SELECT d.Tipo ,d.Referencia, d.Modelo, d.Estado, d.Valor_Lido, d.Data_Instalacao from dispositivos d
Join Instalacao i
ON i.ID_Instalacao = d.ID_Instalacao
WHERE d.Data_Instalacao > '2024-01-25' and d.Data_Instalacao < '2024-01-29'
Group by d.Data_Instalacao 
order BY Data_Instalacao  DESC;