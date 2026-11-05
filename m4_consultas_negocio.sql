-- Pre-entrega: Consultas SQL de negocio
--- Extrayendo métricas clave con SQL

USE Ventas_Tech_DB;

--- Consulta 1 — Resumen ejecutivo mensual
SELECT YEAR(fecha_venta)   AS anio,
       MONTH(fecha_venta)  AS mes,
       COUNT(*)            AS pedidos,
       SUM(cantidad * precio_unitario) AS facturacion,
       AVG(cantidad * precio_unitario) AS ticket_promedio
FROM   ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;
--- Consulta 2 — Ranking de productos 
SELECT TOP 5 id_producto,
       SUM(cantidad)                   AS unidades,
       SUM(cantidad * precio_unitario) AS facturacion
FROM   ventas
WHERE  fecha_venta >= '2024-01-01'
GROUP BY id_producto
ORDER BY facturacion DESC;
GO

--- Consulta 3 — Clientes recurrentes
SELECT id_cliente,
       COUNT(*)      AS pedidos,
       SUM(cantidad * precio_unitario) AS total_gastado
FROM   ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY pedidos DESC;

---Consulta 4 — Productos por encima/por debajo del promedio 

--- subconsulta
SELECT AVG(total_mes) AS promedio_mensual
FROM  (SELECT SUM(cantidad * precio_unitario) AS total_mes
       FROM   ventas
       GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)) t;

-- consulta
SELECT YEAR(fecha_venta)   AS anio,
       MONTH(fecha_venta)  AS mes,
       SUM(cantidad * precio_unitario) AS facturacion,
       CASE WHEN SUM(cantidad * precio_unitario) >
                 (SELECT AVG(total_mes)
                  FROM  (SELECT SUM(cantidad * precio_unitario) AS total_mes
                         FROM   ventas
                         GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)) t)
            THEN 'Por encima'
            ELSE 'Por debajo'
       END                 AS comparativa
FROM   ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;


--- Bloque de cierre 
SELECT * FROM productos;    
---- El producto mas vendido en el mes de marzo fueron los mouses inalambricos. Los mismos fueron los que menos facturaron siendo una decima parte de la facturacion de laptos y un 5.6% de la facturacion total.
---- El ticket promedio representa 1,8 parte del costo de las laptops y el promedio de pedidos 5% del stock total vendido en marzo. 
---- Los clientes que compraron mas de una vez, unicamente compraron 2 veces en el mes de marzo.


