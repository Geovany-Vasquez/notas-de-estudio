-- Consultas básicas SQL
-- Selecciona los primeros 100 registros de la tabla personas
-- LIMIT controla cuántas filas devuelve la consulta
SELECT id, nombre, apellido, dpi, fecha_nacimiento
FROM personas
LIMIT 100;

-- Busca personas cuyo DPI comience con "1234"
-- y cuya fecha de creación esté dentro del rango establecido
SELECT id, nombre, apellido, dpi, fecha_creacion
FROM personas
WHERE dpi LIKE '1234%' 
AND fecha_creacion BETWEEN '2023-01-01' AND '2023-12-31';

-- Selecciona a una persona exacta usando su ID
-- WHERE se usa para filtrar resultados
SELECT id, nombre, apellido, telefono, direccion, dpi
FROM personas
WHERE id = 15;

-- Selecciona la persona cuyo DPI coincida exactamente
SELECT id, nombre, apellido, telefono, direccion
FROM personas
WHERE dpi = '1234567890101';

-- Selecciona personas que sí tengan número de teléfono
-- IS NOT NULL evita valores vacíos o ausentes
SELECT id, nombre, telefono
FROM personas
WHERE telefono IS NOT NULL;

-- Ordena por fecha de creación y obtiene solo los primeros 50
SELECT id, nombre, apellido, fecha_creacion
FROM personas
ORDER BY fecha_creacion DESC
LIMIT 50;

-- Insertar una persona nueva en la tabla
INSERT INTO personas (nombre, apellido, dpi, telefono, fecha_nacimiento)
VALUES ('Juan', 'Pérez', '1234567890101', '5555-8888', '1995-08-15');

-- Actualiza los datos de una persona según su ID
UPDATE personas
SET telefono = '4000-1122',
    direccion = 'Zona 10, Guatemala'
WHERE id = 15;

-- Elimina a la persona con el ID 20
DELETE FROM personas
WHERE id = 20;

-- Combina varios filtros: apellido, DPI parcial y campo no nulo
SELECT id, nombre, apellido, dpi, telefono
FROM personas
WHERE apellido = 'González'
  AND dpi LIKE '1975%'
  AND telefono IS NOT NULL;

