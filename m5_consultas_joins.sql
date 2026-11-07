------------- M5 — Pre-entrega: Consultas con JOINs para el proyecto ----------------------
--- Cruzando tablas para enriquecer el análisis.---
--Se carga la base utilizada en el m4.
USE Ventas_Tech_DB;

---- CONSULTA 1: VISTA BASE DEL PROYECTO (INNER JOIN)
--- PROPOSITO DEL EJERCICIO : reunir los datos necesarios para analizar ventas. La variable Categoria permite agrupar y ciudad_cliente filtrar el reporte.
-- AS v = ventas; c = clientes; p = productos; cat = categorias.
SELECT v.id_venta,
       v.fecha_venta,
       c.id_cliente,
       c.nombre AS nombre_cliente,
       c.ciudad AS ciudad_cliente,
       p.id_producto,
       p.nombre_producto,
       cat.nombre_categoria AS categoria,
       v.cantidad,
       v.precio_unitario,
       v.cantidad * v.precio_unitario AS total_venta
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
-- HALLAZGO: Las ventas 34 ventas del primer semestre de 2024 tuvieron un total de venta de 17028 unidades monetarias, con 5 clientes y 6 productos


----- CONSULTA 2: CLIENTES SIN VENTAS (LEFT JOIN)
---- PROPOSITO DEL EJERCICIO: detectar clientes sin primera compra para acciones de CRM, utilizando NULL  y la PK de ventas. 


SELECT c.id_cliente,
       c.nombre AS nombre_cliente,
       c.email,
       c.fecha_registro
FROM dbo.clientes AS c
LEFT JOIN dbo.ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.fecha_registro, c.id_cliente;
-- HALLAZGO: PK de ventas indica que no hubo coincidencia. Aparecen 0 de los 5 clientes: todos tienen al menos una compra.

----- CONSULTA 3: PRODUCTOS SIN VENTAS (LEFT JOIN)
--- PROPOSITO DEL EJERCICIO: identificar articulos sin movimiento de la tabla de producto. LEFT JOIN con categorias conserva un producto sin categoria coincidente

SELECT p.id_producto,
       p.nombre_producto,
       cat.nombre_categoria AS categoria,
       p.precio
FROM dbo.productos AS p
LEFT JOIN dbo.ventas AS v ON p.id_producto = v.id_producto
LEFT JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL
ORDER BY p.id_producto;
-- HALLAZGO: Aparecen 0 de los 6 productos, lo que indica que todo el catalogo registro ventas en el periodo de estudio.


---- CONSULTA 4: CONSOLIDADO POR ORIGEN (UNION ALL)
--- PROPOSITO DEL EJERCICIO:  se busca comparar la facturacion del primer semestre de 2024 divido en dos trimestres. 
-- Se crea canal; los alias (AS) no representan canales comerciales reales; cada venta del semestre se cuenta una vez

SELECT canal,
       COUNT(*) AS cantidad_pedidos,
       SUM(total) AS total_canal
FROM (
    SELECT fecha_venta,
           cantidad * precio_unitario AS total,
           N'Primer trimestre 2024' AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '20240101' AND fecha_venta < '20240401'
 
    UNION ALL
 
    SELECT fecha_venta,
           cantidad * precio_unitario AS total,
           N'Segundo trimestre 2024' AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '20240401' AND fecha_venta < '20240701'
) AS consolidado
GROUP BY canal
ORDER BY canal;

--HALLAZGO: El segundo trimestre supera al primero en cantidad facturada, siendo 8798 frente a 8230 unidades monetarias. 
