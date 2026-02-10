/*beetween Obtener el total de depósitos realizados entre el 1 de julio de 2025 y el 30 de septiembre de 2025, mostrando el DPI del cliente y el monto total depositado.*/

SELECT
  c.dpi,
  SUM(m.monto) AS total_depositado
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
WHERE m.tipo_movimiento = 'DEPOSITO'
  AND m.fecha_movimiento BETWEEN '2025-07-01' AND '2025-09-30'
GROUP BY
  c.dpi;

/* El banco necesita identificar clientes con actividad reciente continua.
Liste los clientes que hayan realizado al menos un movimiento en cada uno de los últimos 3 meses, incluyendo su DPI, nombres y apellidos */

SELECT
  c.dpi,
  c.nombres,
  c.apellidos
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
WHERE m.fecha_movimiento >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 MONTH'
GROUP BY
  c.dpi,
  c.nombres,
  c.apellidos
HAVING
  COUNT(DISTINCT DATE_TRUNC('month', m.fecha_movimiento)) = 3;

/* Clientes con saldo > Q250,000 y al menos un retiro en últimos 30 días */
SELECT
  c.dpi,
  c.nombres,
  c.apellidos,
  SUM(cu.saldo_actual) AS saldo_total
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
WHERE m.tipo_movimiento = 'RETIRO'
  AND m.fecha_movimiento >= CURRENT_DATE - INTERVAL '30 DAY'
GROUP BY
  c.dpi,
  c.nombres,
  c.apellidos
HAVING SUM(cu.saldo_actual) > 250000;

/* Total depositado por departamento en 2025 */
SELECT
  c.departamento,
  SUM(m.monto) AS total_depositado
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
WHERE m.tipo_movimiento = 'DEPOSITO'
  AND m.fecha_movimiento BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY c.departamento;

/* Últimas 3 transacciones por cuenta (auditoría) */
SELECT
  cuenta_id,
  movimiento_id,
  fecha_movimiento,
  tipo_movimiento,
  monto
FROM (
  SELECT
    cuenta_id,
    movimiento_id,
    fecha_movimiento,
    tipo_movimiento,
    monto,
    ROW_NUMBER() OVER (
      PARTITION BY cuenta_id
      ORDER BY fecha_movimiento DESC
    ) AS rn
  FROM MOVIMIENTOS
) t
WHERE rn <= 3;

/*Cuentas donde retiros > depósitos (riesgo/fraude)*/

SELECT
  cuenta_id,
  SUM(CASE
        WHEN tipo_movimiento = 'DEPOSITO' THEN monto
        ELSE 0
      END) AS total_depositos,
  SUM(CASE
        WHEN tipo_movimiento = 'RETIRO' THEN monto
        ELSE 0
      END) AS total_retiros
FROM MOVIMIENTOS
GROUP BY cuenta_id
HAVING
  SUM(CASE
        WHEN tipo_movimiento = 'RETIRO' THEN monto
        ELSE 0
      END) >
  SUM(CASE
        WHEN tipo_movimiento = 'DEPOSITO' THEN monto
        ELSE 0
      END);

/*Clientes sin movimientos en el último año (INACTIVOS)*/

SELECT DISTINCT
  c.dpi,
  c.nombres,
  c.apellidos
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
LEFT JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
  AND m.fecha_movimiento >= CURRENT_DATE - INTERVAL '1 YEAR'
WHERE m.movimiento_id IS NULL;

/*Clientes con más de 25 movimientos en los últimos 6 meses*/
SELECT
  c.dpi,
  c.nombres,
  c.apellidos,
  COUNT(m.movimiento_id) AS total_movimientos
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
JOIN MOVIMIENTOS m
  ON cu.cuenta_id = m.cuenta_id
WHERE m.fecha_movimiento >= CURRENT_DATE - INTERVAL '6 MONTH'
GROUP BY
  c.dpi,
  c.nombres,
  c.apellidos
HAVING COUNT(m.movimiento_id) > 25;

/*Cantidad de cuentas por cliente (incluyendo sin cuentas)*/
SELECT
  c.dpi,
  c.nombres,
  c.apellidos,
  COUNT(cu.cuenta_id) AS total_cuentas
FROM CLIENTES c
LEFT JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
GROUP BY
  c.dpi,
  c.nombres,
  c.apellidos;

/*Clientes con saldo total (solo cuentas activas)*/
SELECT
  c.dpi,
  c.nombres,
  c.apellidos,
  SUM(cu.saldo_actual) AS saldo_total
FROM CLIENTES c
JOIN CUENTAS cu
  ON c.cliente_id = cu.cliente_id
WHERE cu.estado = 'ACTIVA'
GROUP BY
  c.dpi,
  c.nombres,
  c.apellidos;
