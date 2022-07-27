use proyecto;

-- Del número de cantones que existe por provincia determinar si existe mayor número de comerciales, considerando la población por provincia
SELECT DISTINCT(p.nombre_provincia) "NOMBRE PROVINCIA", p.num_cantones "NÚMERO CANTONES", count(t.nombre_esta) "NÚMERO LOCALES",p.poblacion "POBLACIÓN"
FROM esta_provin e INNER JOIN establecimiento t ON e.establecimiento_idestablecimiento = t.idestablecimiento
				   INNER JOIN provincia p ON e.Provincia_idProvincia = p.idProvincia
GROUP BY p.nombre_provincia
ORDER BY "NÚMERO CANTONES"
LIMIT 5;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Determinar los comerciales que tienen su propio sitio web, analizar si son los que tienen mayor numero de estimación de clientes.
SELECT p.nombre_provincia "PROVINCIA", count(e.paginaWeb)"TOTAL DE LOCALES CON PÁGINAWEB", e.estimacion "ESTIMACIÓN USUARIOS"
FROM esta_provin v INNER JOIN establecimiento e ON v.establecimiento_idestablecimiento = e.idestablecimiento
				   INNER JOIN provincia p ON v.Provincia_idProvincia = p.idProvincia
WHERE e.paginaWeb like '%.com%'
GROUP BY p.nombre_provincia
ORDER BY p.nombre_provincia
LIMIT 5;

-- -----------------------------------------------------------------------------------------------------------------------------
--  Determinar el porcentaje de cada provincia donde los comerciales atienden las 24 horas.
SELECT p.nombre_provincia "NOMBRE PROVINCIA", e.nombre_esta "TOTAL DE LOCALES POR PROVINCIA", c.horario "HORARIO", e.clasificacion "CLASIFICACIÓN"
FROM establecimiento e INNER JOIN esta_provin s ON e.idestablecimiento = s.establecimiento_idestablecimiento
					   INNER JOIN provincia p ON s.Provincia_idProvincia = p.idProvincia
                       INNER JOIN categoria c ON e.idestablecimiento = c.establecimiento_idestablecimiento
WHERE c.horario like ('24%')
GROUP BY e.clasificacion
ORDER BY p.nombre_provincia;

-- -------------------------------------------------------------------------------------------------------------------------
-- De la suma de clientes que tiene cada local de la provincia determinar las provincias que el total de clientes es mayor a la media de la estimacion 
SELECT  p.nombre_provincia "PROVINCIA", SUM(e.estimacion) "TOTAL CLIENTES", count(e.nombre_esta) "TOTAL ESTABLECIMINETOS"
FROM establecimiento e INNER JOIN esta_provin n ON e.idestablecimiento = n.establecimiento_idestablecimiento
					   INNER JOIN provincia p ON  p.idProvincia = n.Provincia_idProvincia
WHERE e.estimacion > ( SELECT AVG(e.estimacion) 
					   FROM establecimiento e) 
GROUP BY p.nombre_provincia
ORDER BY "TOTAL CLIENTES"
LIMIT 5;

-- -------------------------------------------------------------------------------------------------------------------------------
-- Proyección de la provincia con más número de personas en 1 año
SELECT p.nombre_provincia "NOMBRE PROVINCIA", e.estimacion "ESTIMACION DE CLIENTES MENSUALMENTE", e.estimacion*12 "ESTIMACION EN UN AÑO"
FROM establecimiento e INNER JOIN esta_provin s ON e.idestablecimiento = s.establecimiento_idestablecimiento
					   INNER JOIN provincia p ON p.idProvincia = s.Provincia_idProvincia
GROUP BY p.nombre_provincia
ORDER BY  "ESTIMACION DE CLIENTES MENSUALMENTE" ASC
LIMIT 5;


