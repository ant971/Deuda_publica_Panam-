/*
en este proyecto, estaremos realizando los siguientes pasos:
1- buscar duplicados (y eliminarlos en caso de existir)
2- eliminar registros con espacios de mas
3- eliminar filas vacias
4- consultas y un poco de analisis a la propia tabla
*/

-- store procedure
DELIMITER // 
create procedure limpieza()
begin 
	select * from deuda_publica;
end //
DELIMITER ;

select * from deuda_publica limit 10; -- solo los primero 10 registros
-- hora de limpiar

CALL limpieza();
-- buscando duplicados
SELECT 
    COUNT(*) AS duplicados
FROM
    (SELECT 
        ID_deuda, COUNT(*) AS duplicados
    FROM
        deuda_publica
    GROUP BY ID_deuda
    HAVING COUNT(*) > 1) AS subquery;
    
-- quitando los espacios extra
-- primero revisamos si esos espacios existen
select Sector, trim(Sector)  as Sector from deuda_publica
where length(Sector) - length(trim(Sector)) >0;

-- quitando los espacios del sector (esta es la unica columna con registros mal espaciados
UPDATE deuda_publica 
SET 
    Sector = TRIM(Sector)
WHERE
    LENGTH(Sector) - LENGTH(TRIM(Sector)) > 0;

-- eliminando la columna prima (todos su datos son irrelevantes pues tienen el mismo valor = 0
alter table deuda_publica drop column Prima;

-- buscando filas vacias
select * from deuda_publica where Año = " ";
-- borrando esas filas vacias
delete from deuda_publica where Año = " "; 

-- consultas basicas para los saldos
select Saldo, Catalogo from deuda_publica where Mes = "Enero" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Febrero" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Marzo" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Abril" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Mayo" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Junio" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Julio" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Agosto" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Septiembre" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Octubre" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Noviembre" group by Saldo asc;
select Saldo, Catalogo from deuda_publica where Mes = "Diciembre" group by Saldo asc;

-- saldo mas alto clasificado por sector y mes del año 2023
select Mes, Sector, max(Saldo) from deuda_publica group by Mes;

-- mostrando los desembolsos a cada catalogo por mes
select Mes, Desembolsos, Catalogo from deuda_publica group by  Mes, Catalogo;
