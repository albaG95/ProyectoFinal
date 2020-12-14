-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-12-2020 a las 18:15:51
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_agarrido_final`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserPorEmail` (IN `email` VARCHAR(50))  BEGIN

	select 
			id, nombre, email, password, estado, rolId
	FROM 
			usuarios 
	where  email = email  ;
	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualiZar_cliente` (IN `p_id` INT, IN `p_nombre` VARCHAR(100), IN `p_apelido` VARCHAR(150), IN `p_email` VARCHAR(100), IN `p_celular` VARCHAR(100), IN `p_direccion` VARCHAR(500), IN `p_cedula` VARCHAR(500))  BEGIN
DECLARE code VARCHAR(5) DEFAULT '00000';
DECLARE resultado VARCHAR(100);


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1
			code=RETURNED_SQLSTATE;
        ROLLBACK;   
    END; 
    START TRANSACTION;
       UPDATE clientes SET Nombre=p_nombre,Apellido=p_apelido, Email=p_email,Celular=p_celular,Direccion=p_direccion,Cedula=p_cedula WHERE Id=p_id;
	   set resultado = 1;
    COMMIT WORK;
	
IF code <>'00000' then
	set resultado = code;
END IF;

SELECT resultado;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Actualizar_Inventario` (IN `p_nombre` VARCHAR(100), IN `p_codigo` VARCHAR(100), IN `p_precio` DOUBLE, IN `p_existencia` INT, IN `p_vendidos` INT)  BEGIN
DECLARE counter  INT unsigned DEFAULT 0;  
    DECLARE CODE VARCHAR
        (5) DEFAULT '00000'; DECLARE resultado VARCHAR(100); DECLARE CONTINUE
    HANDLER FOR SQLEXCEPTION
BEGIN
        GET DIAGNOSTICS CONDITION 1 CODE = RETURNED_SQLSTATE;
    ROLLBACK
        ;
    END;
START TRANSACTION;

	SELECT count(*) 
    INTO counter
    FROM inventario
    WHERE CodigoProducto = p_codigo;
	
	 IF counter > 0 THEN
        UPDATE productos a
				INNER JOIN inventario b ON a.Codigo = b.CodigoProducto
				SET a.Nombre = p_nombre,
				    a.Precio_Unitario=p_precio,
				    b.Existencia=p_existencia,
				    b.Vendidos=p_vendidos
				WHERE a.Codigo= p_codigo;
	ELSE
	    INSERT INTO `inventario`(`CodigoProducto`, `Existencia`, `Vendidos`, `Total`) values(p_codigo,p_existencia,p_vendidos,0 );
				UPDATE productos a
				SET a.Nombre = p_nombre,
				    a.Precio_Unitario=p_precio
					WHERE a.Codigo= p_codigo;
    END IF;

SET
    resultado = 1;
COMMIT WORK
    ; IF CODE <> '00000' THEN
SET
    resultado = CODE;
END IF;
SELECT
    resultado; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_cliente` (IN `p_nombre` VARCHAR(100), IN `p_apelido` VARCHAR(150), IN `p_email` VARCHAR(100), IN `p_celular` VARCHAR(100), IN `p_direccion` VARCHAR(500), IN `p_cedula` VARCHAR(500))  BEGIN
DECLARE code VARCHAR(5) DEFAULT '00000';
DECLARE resultado VARCHAR(100);


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1
			code=RETURNED_SQLSTATE;
        ROLLBACK;   
    END; 
    START TRANSACTION;
       INSERT INTO clientes(Nombre, Apellido, Email, Celular,Direccion,Cedula) 
	   VALUES (p_nombre,p_apelido,p_email,p_celular,p_direccion, p_cedula);
	   set resultado = 1;
    COMMIT WORK;
	
IF code <>'00000' then
	set resultado = code;
END IF;

SELECT resultado;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_producto` (IN `p_nombre` VARCHAR(100), IN `p_codigo` VARCHAR(100), IN `p_precio` DOUBLE)  BEGIN
    DECLARE CODE VARCHAR
        (5) DEFAULT '00000'; DECLARE resultado VARCHAR(100); DECLARE CONTINUE
    HANDLER FOR SQLEXCEPTION
BEGIN
        GET DIAGNOSTICS CONDITION 1 CODE = RETURNED_SQLSTATE;
    ROLLBACK
        ;
    END;
START TRANSACTION
    ;
INSERT INTO productos(codigo, nombre, Precio_Unitario)
VALUES(p_codigo, p_nombre, p_precio);
SET
    resultado = 1;
COMMIT WORK
    ; IF CODE <> '00000' THEN
SET
    resultado = CODE;
END IF;
SELECT
    resultado; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_usuarios` (IN `p_nombre` VARCHAR(100), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(150), IN `p_rol` VARCHAR(10))  BEGIN
DECLARE code VARCHAR(5) DEFAULT '00000';
DECLARE resultado VARCHAR(100);


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1
			code=RETURNED_SQLSTATE;
        ROLLBACK;   
    END; 
    START TRANSACTION;
       INSERT INTO usuarios(nombre, email, password, fecha_creacion, rolId, estado) 
	   VALUES (p_nombre,p_email,Md5(p_password),NOW(),p_rol, 'A' );
	   set resultado = 1;
    COMMIT WORK;
	
IF code <>'00000' then
	set resultado = code;
END IF;

SELECT resultado;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios` (IN `estatus` VARCHAR(2))  BEGIN

	select 
			id, nombre, email, DATE_FORMAT( fecha_creacion , '%d-%m-%Y %r' ) as fecha , 
			(case estado  when 'A' then 'Activo' when 'I' then 'Inactivo' end) as estados
	FROM 
			usuarios
	where  estado = estatus;
	

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Celular` varchar(20) NOT NULL,
  `Direccion` varchar(500) NOT NULL,
  `Cedula` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id`, `Nombre`, `Apellido`, `Email`, `Celular`, `Direccion`, `Cedula`) VALUES
(1, 'MANUEL', 'NAVARRO', 'GG@JJ.VO', '77773-454', 'ATLAPA PLAZA', '77773-454'),
(3, 'merendina de vainilla 44', 'GARRIDO4', 'pinzon1814@yahoo.es', '7-709-20184', 'LAS VILLAS, PARK VILLAGE,CALLE 1A, CASA A-1-64', '7-709-20184'),
(4, 'merendina de vainilla', 'GARRIDO', 'marina1881@gmail.com', '61501642', 'LAS VILLAS, PARK VILLAGE,CALLE 1A, CASA A-1-6', '7-709-2020'),
(5, 'MARIA', 'SAMANIEGO', 'MARI@GMAIL.COM', '35464', 'PANAMA', '45677'),
(6, 'ESTEFANI ', 'PERALTA', 'PERALTA18@GMAIL.COM', '34567', 'LAS CUMBRES', '3457678');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `CodigoProducto` varchar(10) NOT NULL,
  `Existencia` int(11) NOT NULL,
  `Vendidos` int(11) NOT NULL,
  `Total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`CodigoProducto`, `Existencia`, `Vendidos`, `Total`) VALUES
('3456', 3, 0, 3),
('4531ZegX', 99, 1, 98),
('P0001', 1000, 100, 900),
('P0002', 2, 0, 2),
('ti9x0mb3', 100, 2, 98);

--
-- Disparadores `inventario`
--
DELIMITER $$
CREATE TRIGGER `inventario_insert` BEFORE INSERT ON `inventario` FOR EACH ROW BEGIN
       SET NEW.Total = NEW.Existencia - NEW.Vendidos;
     END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inventario_update` BEFORE UPDATE ON `inventario` FOR EACH ROW BEGIN
       SET NEW.Total = NEW.Existencia - NEW.Vendidos;
     END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `Codigo` varchar(10) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Precio_Unitario` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`Codigo`, `Nombre`, `Precio_Unitario`) VALUES
('3456', 'MANGO', 2.67),
('3456233', 'Jamon', 1.3),
('4531ZegX', 'merendina de vainilla', 1.5),
('566787', 'MANZANA', 6),
('P0001', 'platanos', 0.5),
('P0002', 'Sombrilla de colores', 3.4),
('ti9x0mb3', 'pacita', 1.3),
('WR43436FG', 'PERA', 33);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `Descripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `Descripcion`) VALUES
(1, 'administrador'),
(2, ' cajera'),
(3, ' inventario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `rolId` int(11) NOT NULL,
  `estado` varchar(2) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Id`, `nombre`, `email`, `password`, `fecha_creacion`, `rolId`, `estado`) VALUES
(2, 'Alba Garrido', 'alba.garrido188@gmail.com', '202cb962ac59075b964b07152d234b70', '2020-12-08 22:43:35', 1, 'A'),
(3, 'Alba Garrido', 'alba.garrido18@gmail.com', '202cb962ac59075b964b07152d234b70', '2020-12-08 22:44:21', 1, 'A'),
(6, 'Angel99..', 'marina18@gmail.com', '202cb962ac59075b964b07152d234b70', '2020-12-09 03:01:36', 3, 'A'),
(34, 'ALBA PINzon', 'pinzon1814@yahoo.es', '202cb962ac59075b964b07152d234b70', '2020-12-12 12:53:42', 1, 'A'),
(35, 'Ange', 'marina1881@gmail.com', '202cb962ac59075b964b07152d234b70', '2020-12-12 13:06:36', 3, 'A'),
(36, 'ANIKET ', 'MARSUS@GMAIL.COM', 'd81f9c1be2e08964bf9f24b15f0e4900', '2020-12-13 19:25:31', 3, 'A'),
(37, 'MARIO', 'MARIO@GMAIL.COM', '99c5e07b4d5de9d18c350cdf64c5aa3d', '2020-12-13 20:01:23', 2, 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`CodigoProducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`Codigo`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Id`,`email`) USING BTREE,
  ADD KEY `FK_USERS_ROL` (`rolId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`CodigoProducto`) REFERENCES `productos` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FK_USERS_ROL` FOREIGN KEY (`rolId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
