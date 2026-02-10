/*Obtener el listado de clientes mostrando su identificador, nombre y apellido, junto con el saldo total que poseen considerando todas sus cuentas.*/
SELECT
  c.client_id,
  c.first_name,
  c.last_name,
  SUM(a.balance) AS total_balance
FROM Clients c
JOIN Accounts a
  ON c.client_id = a.client_id
GROUP BY
  c.client_id,
  c.first_name,
  c.last_name;

/*Listar todos los clientes y la cantidad de cuentas que tiene cada uno, incluyendo aquellos clientes que no poseen ninguna cuenta.*/
SELECT
  c.client_id,
  c.first_name,
  COUNT(a.account_id) AS total_accounts
FROM Clients c
LEFT JOIN Accounts a
  ON c.client_id = a.client_id
GROUP BY
  c.client_id,
  c.first_name;

/*Mostrar todas las cuentas existentes junto con el nombre y apellido del cliente al que pertenecen.*/
SELECT
  a.account_id,
  c.first_name,
  c.last_name,
  a.account_type,
  a.balance
FROM Accounts a
JOIN Clients c
  ON a.client_id = c.client_id;

/*Obtener los clientes cuyo saldo total, sumando todas sus cuentas, sea mayor a 10,000.*/
SELECT
  c.client_id,
  c.first_name,
  c.last_name,
  SUM(a.balance) AS total_balance
FROM Clients c
JOIN Accounts a
  ON c.client_id = a.client_id
GROUP BY
  c.client_id,
  c.first_name,
  c.last_name
HAVING SUM(a.balance) > 10000;

/*Calcular el monto total retirado por cada cliente durante el año 2025*/
SELECT
  c.client_id,
  c.first_name,
  c.last_name,
  SUM(t.amount) AS total_withdrawn
FROM Clients c
JOIN Accounts a
  ON c.client_id = a.client_id
JOIN Transactions t
  ON a.account_id = t.account_id
WHERE t.transaction_type = 'withdrawal'
  AND t.transaction_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY
  c.client_id,
  c.first_name,
  c.last_name;

/*Listar los clientes que hayan realizado más de 20 transacciones en total*/
SELECT
  c.client_id,
  c.first_name,
  c.last_name,
  COUNT(t.transaction_id) AS total_transactions
FROM Clients c
JOIN Accounts a
  ON c.client_id = a.client_id
JOIN Transactions t
  ON a.account_id = t.account_id
GROUP BY
  c.client_id,
  c.first_name,
  c.last_name
HAVING COUNT(t.transaction_id) > 20;

/*Obtener el total de transacciones realizadas por cada tipo de cuenta (checking, savings, credit)*/

SELECT
  a.account_type,
  COUNT(t.transaction_id) AS total_transactions
FROM Accounts a
JOIN Transactions t
  ON a.account_id = t.account_id
GROUP BY
  a.account_type;

/*Listar las transacciones realizadas en los últimos 90 días, mostrando el identificador de la cuenta, el tipo de transacción y el monto*/

SELECT
  t.account_id,
  t.transaction_type,
  t.amount
FROM Transactions t
WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '90 DAY';

