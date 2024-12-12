-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2024 a las 02:32:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_pharmago`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_atencion_pedido` (IN `pId_pedido_farmacia` INT, IN `pEstado` INT)   BEGIN
   DECLARE record_count INT;

    SELECT COUNT(*) INTO record_count
    FROM pedido_farmacia
    WHERE id_pedido_farmacia = pId_pedido_farmacia;

    IF record_count > 0 THEN
        IF pEstado = 2 THEN
            UPDATE pedido_farmacia
            SET fecha_despacho2_en_curso = NOW()
            WHERE id_pedido_farmacia = pId_pedido_farmacia;
        ELSEIF pEstado = 3 THEN
            UPDATE pedido_farmacia
            SET fecha_despacho3_entregado = NOW()
            WHERE id_pedido_farmacia = pId_pedido_farmacia;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El id_pedido_farmacia no existe.';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detalle_pedido` (`pId_pedido_farmacia` INT, `pId_prod` INT, `pCantidad` INT, `pPrecio_unitario` DECIMAL(10,2))   BEGIN
	INSERT INTO detalle_pedido(id_pedido_farmacia,id_prod,cantidad,precio_unitario,importe) 
    VALUES(pId_pedido_farmacia,pId_prod,pCantidad,pPrecio_unitario , (pCantidad * pPrecio_unitario));
    
    UPDATE producto SET stock = stock - pCantidad
    WHERE id_prod = pId_prod;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categ` int(11) NOT NULL,
  `nombre_categ` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categ`, `nombre_categ`) VALUES
(3, 'Bebé y embarazo'),
(5, 'Botiquín'),
(1, 'Cosmética y Belleza'),
(7, 'Medicamentos'),
(2, 'Rutinas'),
(6, 'Salud'),
(4, 'Salud Femenina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `nro_documento` varchar(20) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombres`, `apellidos`, `nro_documento`, `fecha_nac`, `telefono`, `correo`, `password`) VALUES
(1, 'Juan', 'Caceres', '70546273', '2000-10-18', '965423223', 'juan.caceres@gmail.com', '123456'),
(2, 'Mariano', 'Fernandez', '41236523', '1995-10-04', '965412366', 'mariano.fernandez@gmail.com', '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `id_pedido_farmacia` int(11) DEFAULT NULL,
  `id_prod` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `importe` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id_detalle_pedido`, `id_pedido_farmacia`, `id_prod`, `cantidad`, `precio_unitario`, `importe`) VALUES
(7, 10, 3, 1, 13.30, 13.30),
(8, 11, 9, 2, 34.00, 68.00),
(9, 11, 11, 5, 56.00, 280.00),
(10, 12, 1, 1, 7.60, 7.60),
(11, 13, 2, 1, 14.25, 14.25),
(12, 14, 1, 1, 7.60, 7.60),
(13, 15, 12, 2, 17.60, 35.20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `farmacia`
--

CREATE TABLE `farmacia` (
  `id_farmacia` int(11) NOT NULL,
  `nombre_farmacia` varchar(200) DEFAULT NULL,
  `logo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `farmacia`
--

INSERT INTO `farmacia` (`id_farmacia`, `nombre_farmacia`, `logo`) VALUES
(1, 'InkaFarma', 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/7f51bc62599133.5a95954235dde.jpg'),
(2, 'Boticas Peruanas', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnKRjCIGpzhfbDfvjMS3sskjLBDrdj74dqZw&s'),
(3, 'MiFarma', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ9FR1vB7lhmRlbToOZotFgvecGcqWKyL0bg&s'),
(4, 'Farmacia Universal', 'https://acciontrabajo.pe/biz_pic/6my49gqj'),
(5, 'Boticas y Salud', 'https://plazanorte.pe/wp-content/uploads/2024/03/WEB-LOGO.jpg'),
(6, 'Farmacias del Pueblo', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR73pYD7FcN976GRxXbVBMIN-o6FhTX4C-m4A&s'),
(7, 'Farmacia San José', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdHdGApvyTROQ99dpUdayy1NizPhyUmz-W4w&s'),
(8, 'Farmacia La Salud', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjk2R5En3S2dtHV7yiIOuL2-HrA5oqZdKb2A&s');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT current_timestamp(),
  `monto_total` decimal(10,2) DEFAULT NULL,
  `direccion_envio` text DEFAULT NULL,
  `referencia_envio` text DEFAULT NULL,
  `detalle_adicional` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `id_cliente`, `fecha_pedido`, `monto_total`, `direccion_envio`, `referencia_envio`, `detalle_adicional`) VALUES
(10, 1, '2024-10-28 12:08:33', 361.30, NULL, NULL, NULL),
(11, 1, '2024-10-28 19:36:26', 7.60, NULL, NULL, NULL),
(12, 1, '2024-10-28 19:47:49', 14.25, NULL, NULL, NULL),
(13, 1, '2024-10-28 20:00:46', 42.80, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_farmacia`
--

CREATE TABLE `pedido_farmacia` (
  `id_pedido_farmacia` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_farmacia` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `fecha_despacho1_aceptado` datetime DEFAULT NULL,
  `fecha_despacho2_en_curso` datetime DEFAULT NULL,
  `fecha_despacho3_entregado` datetime DEFAULT NULL,
  `codigo_transacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_farmacia`
--

INSERT INTO `pedido_farmacia` (`id_pedido_farmacia`, `id_pedido`, `id_farmacia`, `total`, `fecha_despacho1_aceptado`, `fecha_despacho2_en_curso`, `fecha_despacho3_entregado`, `codigo_transacion`) VALUES
(10, 10, 1, 13.30, '2024-10-28 12:08:33', '2024-10-28 19:01:58', '2024-10-28 19:04:23', 'PAYID-M4QDHPQ0533211AWA8791241'),
(11, 10, 4, 348.00, '2024-10-28 12:08:33', NULL, NULL, 'PAYID-M4QDHFA053172826188710655'),
(12, 11, 1, 7.60, '2024-10-28 19:36:26', NULL, NULL, 'PAYID-M5QDHPQ053372836A48879140'),
(13, 12, 1, 14.25, '2024-10-28 19:47:49', NULL, NULL, 'PAYID-M4QXHPQ053342833W8874110'),
(14, 13, 1, 7.60, '2024-10-28 20:00:46', NULL, NULL, 'PAYID-M4QDHPQ053372836W8879310'),
(15, 13, 8, 35.20, '2024-10-28 20:00:46', NULL, NULL, 'PAYID-M4QDHPQ053372836W8879310');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_prod` int(11) NOT NULL,
  `id_categ` int(11) DEFAULT NULL,
  `id_farmacia` int(11) DEFAULT NULL,
  `nombre_prod` varchar(200) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(8,2) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `porc_desc` decimal(8,2) DEFAULT NULL,
  `imagen` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_prod`, `id_categ`, `id_farmacia`, `nombre_prod`, `stock`, `precio`, `descripcion`, `porc_desc`, `imagen`, `fecha_creacion`) VALUES
(1, 3, 1, 'BABYZERO Toallitas Humedas Bebé Salustar 80 uds', 98, 8.00, '<p>Las toallitas h&uacute;medas para beb&eacute; SALUSTAR, son c&oacute;modas y &uacute;tiles en cualquier momento del d&iacute;a. F&oacute;rmula enriquecida con extracto de cal&eacute;ndula y camomila, con Aloe Vera, urea y prote&iacute;na de leche. Testado dermatol&oacute;gicamente.</p>\r\n\r\n<p>Las toallitas SALUSTAR ofrecen una completa y delicada acci&oacute;n limpiadora de la piel, sin alterar el pH fisiol&oacute;gico y natural de la piel del beb&eacute;.</p>\r\n', 5.00, 'https://www.farmaciauniversal24h.com/16258-large_default/toallitas-humedas-bebe-salustar-80-u.jpg', '2024-10-27 14:24:51'),
(2, 1, 1, 'ACOFAR Test de Embarazo 1 ud', 109, 15.00, '<p>Precisi&oacute;n superior al 99%. R&aacute;pido, sencillo y fiable.&nbsp;Con anticuerpos monoclonales anti-hCG.</p>\r\n\r\n<h2>Modo de empleo de&nbsp;ACOFAR Test de Embarazo 1 ud</h2>\r\n\r\n<p>Sacar el test de su embalaje cuando est&eacute; lista para iniciarlo y retirar el tap&oacute;n. Mantener la punta absorbente directamente bajo el flujo de orina durante al menos 10 segundos (La orina no debe sobrepasar la marca y no se deben mojar las ventanas de los resultados). Si lo prefiere, puede recoger su orina en un recipiente limpio y seco (de pl&aacute;stico o cristal) e introducir la mitad de la zona absorbente en la orina durante al menos 3 segundos. Colocar de nuevo el tap&oacute;n del test y mantenerlo en posici&oacute;n horizontal. Cuando la muestra de orina pasa a las ventanas de resultados y aparece la l&iacute;nea p&uacute;rpura en la ventana de control, significa que la prueba se ha realizado correctamente. Esperar 3 minutos para proceder a la lectura del resultado. (Un resultado positivo puede aparecer en un minuto, sin embargo para confirmar resultados negativos es necesario esperar 3 minutos para completar el tiempo de reacci&oacute;n). No realizar la lectura del resultado despu&eacute;s de 5 minutos.</p>\r\n\r\n<h2>Precauciones de uso de&nbsp;ACOFAR Test de Embarazo 1 ud</h2>\r\n\r\n<p>El test es s&oacute;lo para uso externo. No ingerir. Mantener fuera del alcance y de la vista de los ni&ntilde;os. No utilizar despu&eacute;s de la fecha de caducidad. No reutilizar. El test s&oacute;lo puede ser utilizado una vez. No utilizar si el sobre no est&aacute; bien sellado.</p>\r\n\r\n<h2>Composici&oacute;n de&nbsp;ACOFAR Test de Embarazo 1 ud</h2>\r\n\r\n<p>Un test de embarazo con anticuerpos monoclonales anti-hCG (hormona del embarazo).</p>\r\n', 5.00, 'https://www.farmaciauniversal24h.com/24695-large_default/acofar-test-de-embarazo-1-ud.jpg', '2024-10-27 14:57:46'),
(3, 1, 1, 'SUAVINEX Cuchara Infantil 2 uds', 119, 14.00, '<p>Son cucharas infantiles, con forma ergon&oacute;mica, que resultan de gran ayuda durante la etapa de paso de la alimentaci&oacute;n con biber&oacute;n al plato.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 5.00, 'https://www.farmaciauniversal24h.com/20749-large_default/suavinex-cubierto-cuchara-infantil.jpg', '2024-10-27 14:58:20'),
(4, 1, 1, 'BETER Esponja Natural Marina Pequeña', 42, 16.00, '<p>La esponja marina BETER natural es extremadamente suave. Est&aacute; indicada para el ba&ntilde;o del beb&eacute; y para las pieles delicadas, especialmente despu&eacute;s de estar sometidas al sol o la depilaci&oacute;n.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 5.00, 'https://www.farmaciauniversal24h.com/18301-large_default/beter-esponja-natural-marina-marina-t-peq.jpg', '2024-10-27 14:59:49'),
(6, 1, 1, 'MUSTELA Babygel Baño de Espuma con Aguacate Bio 200 ml', 60, 18.00, '<p>Es un gel de ba&ntilde;o que limpia delicadamente la piel del beb&eacute;, suaviza la piel gracias a los extractos naturales de aciano y previene el resecamiento cut&aacute;neo.</p>\r\n\r\n<p>Gracias a su espuma suave y ligera el ba&ntilde;o se convierte en un momento de diversi&oacute;n y despertar.</p>\r\n\r\n<h3><strong>&iquest;Qu&eacute; beneficios tiene Mustela Babygel?</strong></h3>\r\n\r\n<p>El ba&ntilde;o de espuma Babygel limpia suavemente el cuerpo y el cabello del beb&eacute;. Su espuma, su color y olor &uacute;nico contribuyen al desarrollo sensorial y al bienestar del beb&eacute;.</p>\r\n\r\n<p>Su magia se basa en nuestro ingrediente activo clave el Perseose de aguacate (obtenido de aguacates Bio) especialmente seleccionado por sus propiedades: refuerza la barrera cut&aacute;nea y protege el capital celular de la piel de los beb&eacute;s.</p>\r\n\r\n<p>Su f&oacute;rmula es biodegradable y vegana. El envase es reciclable y desde 2010 hemos reducido el pl&aacute;stico un 12% en el formato de 750 ml.</p>\r\n\r\n<p>Sin ingredientes de origen animal.</p>\r\n\r\n<h3><strong>&iquest;C&oacute;mo se usa Mustela Babygel?</strong></h3>\r\n\r\n<p>Nuestro ba&ntilde;o de espuma Babygel est&aacute; especialmente dise&ntilde;ado para el cuerpo y el cabello de los beb&eacute;s.</p>\r\n\r\n<p>1. Dosifica un poco de Babygel en tu mano y haz espuma. Tambi&eacute;n lo puedes a&ntilde;adir al agua dpara obtener un ba&ntilde;o de espuma.</p>\r\n\r\n<p>2. Limpia suavemente el cuerpo y el cabello de tu beb&eacute;. &iexcl;es hora de un poco de diversi&oacute;n con la espuma!</p>\r\n\r\n<p>3. Aclara cuidadosamente.</p>\r\n\r\n<p>4. Seca a tu beb&eacute; suavemente prestando especial atenci&oacute;n a la zona del pa&ntilde;al y a los pliegues cut&aacute;neos.</p>\r\n\r\n<h3><strong>Ingredientes de Mustela Babygel</strong></h3>\r\n\r\n<p>Nuestro aguacate Bio, obtenido a trav&eacute;s de cadenas de suministro responsables, y procedente de la econom&iacute;a circular zero waste &iexcl;sin desperdicios!.</p>\r\n\r\n<p><strong>En esta f&oacute;rmula se combina con:</strong></p>\r\n\r\n<p>Extracto natural de flor de ma&iacute;z para suavizar la piel.</p>\r\n\r\n<p>Oligoelementos marinos que ayudan a mantener el equilibrio h&iacute;drico de la piel.</p>\r\n\r\n<p>Glicerina de origen vegetal, para hidratarla y protegerla contra la evaporaci&oacute;n del agua.</p>\r\n\r\n<p>Perseose de aguacate, que protege la barrera cut&aacute;nea, hidrata y preserva el capital celular de la piel.</p>\r\n\r\n<p>Oxeoline de Alc&aacute;cea, con propiedades para aliviar la piel.</p>\r\n\r\n<p>Ol&eacute;odestilado de Girasol, que aporta los l&iacute;pidos indispensables para la construcci&oacute;n de la barrera cut&aacute;nea para favorecer su reparaci&oacute;n.</p>\r\n\r\n<p>&Oacute;xido de zinc con propiedades protectoras y antienzim&aacute;ticas.</p>\r\n\r\n<p>91% de ingredientes de origen natural.</p>\r\n\r\n<p>El 9% restante son ingredientes para garantizar una textura agradable y una buena protecci&oacute;n a largo plazo de la f&oacute;rmula.</p>\r\n\r\n<p>AQUA/WATER/EAU, SODIUM MYRETH SULFATE, GLYCERIN, COCAMIDOPROPYL BETAINE, PEG-7 GLYCERYL COCOATE, COCO-GLUCOSIDE, PEG-150 DISTEARATE, PARFUM (FRAGRANCE), PROPYLENE GLYCOL, GLYCERYL CAPRYLATE, MARIS SAL /SEA SALT/SEL MARIN, CITRIC ACID, CENTAUREA CYANUS FLOWER EXTRACT, POTASSIUM SORBATE, PERSEA GRATISSIMA (AVOCADO) FRUIT EXTRACT, CI 42090 (BLUE 1).</p>\r\n', 10.00, 'https://www.farmaciauniversal24h.com/1664-large_default/trofolastin-reductor-de-cicatriz-e-carreras-5-x.jpg', '2024-10-27 15:01:20'),
(7, 1, 1, 'WELEDA Aceite Corporal de Caléndula Bebé 200 ml', 60, 40.00, '<h3>Comprar Online Weleda Aceite Corporal de Cal&eacute;ndula Beb&eacute;</h3>\r\n\r\n<p>Es un aceite corporal para beb&eacute;s. Ideal para la hidrataci&oacute;n despu&eacute;s del ba&ntilde;o y/o para mimarlos con un masaje relajante.</p>\r\n\r\n<h2>&iquest;Para qu&eacute; est&aacute; indicado Weleda Aceite Corporal de Cal&eacute;ndula Beb&eacute;?</h2>\r\n\r\n<p>Indicado para el cuidado diario y el masaje del beb&eacute;.</p>\r\n\r\n<p>Perfecto para usarlo despu&eacute;s del ba&ntilde;o, ya que previene el desecamiento cut&aacute;neo y mantiene la piel suave.</p>\r\n\r\n<p>En el momento del masaje, este aceite envuelve al beb&eacute; en una suave capa que ayuda a mantener la temperatura corporal y favorece las funciones naturales de la epidermis.</p>\r\n\r\n<p>Contiene Aceite de almendra, extractos de flores de cal&eacute;ndula y de manzanilla, aceites esenciales naturales.</p>\r\n\r\n<h2>Ingredientes de Weleda Aceite Corporal de Cal&eacute;ndula Beb&eacute;</h2>\r\n\r\n<p>Esta planta de la familia del girasol, es originaria del centro, este y sur de Europa.</p>\r\n\r\n<p>Tiene unas caracter&iacute;sticas flores amarillas o naranjas brillantes, ricas en carotenos, flavonoides y aceites esenciales.</p>\r\n\r\n<p>Posee propiedades curativas y antiinflamatorias.</p>\r\n\r\n<p>Muy apreciada para el tratamiento de pieles sensibles o irritadas.</p>\r\n\r\n<p>Origen: 100% vegetal, procedente de cultivo biodin&aacute;mico.</p>\r\n\r\n<h2>&iquest;C&oacute;mo se usa Weleda Aceite Corporal de Cal&eacute;ndula Beb&eacute;?</h2>\r\n\r\n<p>1. Aplicar despu&eacute;s del ba&ntilde;o una peque&ntilde;a cantidad de aceite sobre la piel ligeramente h&uacute;meda.</p>\r\n\r\n<p>2. Masajear suavemente hasta su completa absorci&oacute;n.</p>\r\n', 10.00, 'https://www.farmaciauniversal24h.com/19995-large_default/weleda-baby-calendula-aceite-corporal-200-ml.jpg', '2024-10-27 15:03:31'),
(8, 1, 2, 'LETI AT4 Crema Pañal Pasta al Agua 75 g', 53, 20.00, '<p>Es una barrera multiprotectora facial para el cuidado diario de la piel at&oacute;pica.</p>\r\n\r\n<h3>&iquest;Para qu&eacute; est&aacute; indicado Leti At4 Crema Pa&ntilde;al Pasta al Agua?</h3>\r\n\r\n<p>Est&aacute; indicado&nbsp;para la zona del pa&ntilde;al de beb&eacute;s y ni&ntilde;os con pieles at&oacute;picas, secas y sensibles.</p>\r\n\r\n<h3>&iquest;Cu&aacute;les son los beneficios de&nbsp;Leti At4 Crema Pa&ntilde;al Pasta al Agua?</h3>\r\n\r\n<p>&middot; Multiprotecci&oacute;n frente a agentes irritantes.</p>\r\n\r\n<p>&middot; Acci&oacute;n antienzim&aacute;tica.</p>\r\n\r\n<p>&middot; Promueve las defensas naturales de la piel.</p>\r\n\r\n<p>&middot; Disminuye el riesgo de sobreinfecci&oacute;n.</p>\r\n\r\n<h3>&iquest;C&oacute;mo se aplica Leti At4 Crema Pa&ntilde;al Pasta al Agua?</h3>\r\n\r\n<p>Farmacia Universal recomienda&nbsp;aplicarlo uniformemente sobre la piel limpia y seca, en cada cambio de pa&ntilde;al.</p>\r\n\r\n<p>No aplicar sobre lesiones exudativas.</p>\r\n\r\n<h3><strong>Ingredientes de Leti At4 Crema Pa&ntilde;al Pasta al Agua</strong></h3>\r\n\r\n<p>Aqua (Water), C12-15 Alkyl Benzoate, Dibutyl Adipate, Caprylic/Capric Triglyceride, Homosalate, Butyl Methoxydibenzoylmethane, Hydrogenated castor oil, Polyglyceryl-2 Dipolyhydroxystearate, Propanediol, Cetyl Dimethicone, Stearyl Dimethicone, Titanum Dioxide (nano), Diethylamino Hydroxybenzoyl Hexyl Benzoate, Polyglyceryl-3 Diisostearate, Butyrospermum parkii (Shea butter) Seedcake Extract, Alpha-Glucan Oligosaccharide, Hexapeptide-42, Allantoin, Tocopheryl Acetate, Methylpropanediol, Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine, Polysilicone-15, Ethylhexylglycerin, Butylene Glycol, Dimethicone, Ethylhexyl Triazone, Diethylhexyl Butamido Triazone, Magnesium Sulfate, Silica, Hydroxyacetophenone, Sodium Benzoate, Caprylhydroxamic Acid.</p>\r\n', 10.00, 'https://www.farmaciauniversal24h.com/19995-large_default/weleda-baby-calendula-aceite-corporal-200-ml.jpg', '2024-10-27 15:04:36'),
(9, 1, 4, 'LETI AT4 Leche Corporal 500 ml', 58, 40.00, '<p>Es una loci&oacute;n emoliente reparadora para el cuidado diario de la piel at&oacute;pica.</p>\r\n\r\n<h3>&iquest;Para qu&eacute; est&aacute; indicado Leti At4 Leche Corporal?</h3>\r\n\r\n<p>Est&aacute; indicado para toda la familia con pieles at&oacute;picas, secas y sensibles.</p>\r\n\r\n<p>Ideal para zonas corporales extensas.</p>\r\n\r\n<h3>&iquest;Qu&eacute; beneficios tiene Leti At4 Leche Corporal?</h3>\r\n\r\n<p>&middot; Repara la barrera cut&aacute;nea.</p>\r\n\r\n<p>&middot; Alivia el picor y calma la irritaci&oacute;n.</p>\r\n\r\n<p>&middot; Disminuye el riesgo de sobreinfecci&oacute;n.</p>\r\n\r\n<p>&middot; Refuerza la flora sapr&oacute;fita.</p>\r\n\r\n<h3>&iquest;C&oacute;mo se aplica Leti At4 Leche Corporal?</h3>\r\n\r\n<p>Farmacia Universal recomienda aplicarlo de forma uniforme por todo el cuerpo realizando un suave masaje hasta su completa absorci&oacute;n.</p>\r\n\r\n<p>Aplicar dos veces al d&iacute;a y preferiblemente despu&eacute;s del ba&ntilde;o.</p>\r\n\r\n<h3>Ingredientes de Leti At4 Leche Corporal&nbsp;</h3>\r\n\r\n<p>Aqua (Water), Cetyl Alcohol, Glycerin, Isopropyl Palmitate, C12-15 Alkyl Benzoate, Steareth-21, Steareth-2, Paraffinum liquidum (Mineral Oil), Propylene Glycol Dicaprylate/Dicaprate, Metylpropanediol, Oxidized Corn Oil, Alpha-Glucan Oligosaccharide, Hydrolyzed Linseed Extract, Laureth-9, Tocopherol, Ascorbyl Palmitate, Glyceryl Stearate, Sphingolipids, Phospholipids, Sodium Ascorbyl Phosphate, Lecithin, Tocopheryl Acetate, Glyceryl Oleate, Sodium Acrylate/Sodium Acryloyldimethyl Taurate Copolymer, Carbomer, Caprylyl/Capryl Glucoside, Sorbitan Oleate, Polyisobutene, Dimethicone, Triethanolamine, Caprylyl Glycol, Parfum (Fragrance), p-Anisic Acid, Ethylhexylglycerin, Tetrasodium Glutamate Diacetate, Phenylpropanol, Potassium Sorbate, Sodium Hydroxide, Phenoxyethanol, Citric Acid.</p>\r\n', 15.00, 'https://www.farmaciauniversal24h.com/20695-large_default/leti-at-4-leche-corporal-500-ml.jpg', '2024-10-27 15:05:32'),
(11, 1, 4, 'TROFOLASTIN Antiestrías 250 ml', 94, 70.00, '<p>Es una crema regenerante, cicatrizante y reparadora. Potenciadora de la elasticidad. Previene y reduce la formaci&oacute;n de estr&iacute;as.</p>\r\n\r\n<p>Reduce las estr&iacute;as hasta un 89%. Eficacia clinicamente demostrada.</p>\r\n\r\n<h3>&iquest;Para qui&eacute;n est&aacute; indicado Trofolastin Antiestr&iacute;as?</h3>\r\n\r\n<p>Previene y educe la formaci&oacute;n de estr&iacute;as en:</p>\r\n\r\n<p>- Embarazo.</p>\r\n\r\n<p>- Adolescentes.</p>\r\n\r\n<p>- P&eacute;rdidas de peso. Las personas sometidas a r&eacute;gimen, que var&iacute;an su volume.</p>\r\n\r\n<p>- Deportistas.</p>\r\n\r\n<p>- Cualquier tipo de problema tr&oacute;fico cut&aacute;neo.</p>\r\n\r\n<h3>&iquest;C&oacute;mo se aplica Trofolastin Antiestr&iacute;as?</h3>\r\n\r\n<p>Se aplica dos veces al d&iacute;a sobre la zona a tratar con un ligero masaje hasta su total absorci&oacute;n.</p>\r\n\r\n<h3>&iquest;Qu&eacute; son las estr&iacute;as?</h3>\r\n\r\n<p>Las estr&iacute;as son lesiones cut&aacute;neas lineales que se agrupan en bandas paralelas.</p>\r\n\r\n<p>Las fibras de col&aacute;geno y elastina se rompen debido al estiramiento de la piel y tambi&eacute;n a factores endocrinos.</p>\r\n\r\n<h3>&iquest;C&oacute;mo act&uacute;a Trofolastin Antiestr&iacute;as?</h3>\r\n\r\n<p>Es un estimulante d&eacute;rmico, que act&uacute;a manteniendo la piel en las condiciones, en las que pueda resistir la agresi&oacute;n bioqu&iacute;mica y el estiramiento f&iacute;sico, que tiene lugar en el embarazo u otras circunstancias para prevenir el que aparezcan las estr&iacute;as.</p>\r\n\r\n<h3>&iquest;Qu&eacute; contiene Trofolastin Antiestr&iacute;as?</h3>\r\n\r\n<p>La composici&oacute;n de la Antiestr&iacute;as Trofolastin es: Aceite de Triticum vulgare, hidrolizado de elastina, hidrolizado de col&aacute;geno, Contiene triterpenos de centella Asi&aacute;tica, en extracto de Centella asi&aacute;tica y otros ingredientes cosm&eacute;ticos.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 20.00, 'https://www.farmaciauniversal24h.com/1112-large_default/trofolastin-antiestrias-250-ml.jpg', '2024-10-27 15:07:16'),
(12, 1, 8, 'BETER Set Bebé Peine y Cepillo', 148, 22.00, '<p>Especialmente dise&ntilde;ado para cuidar y mimar el cabello de los m&aacute;s peque&ntilde;os de la casa. Cepillo fabricado con fibras extra suaves y peine con puntas redondeadas que protegen el delicado cuero cabelludo del beb&eacute;. Mangos largos para mayor manejabilidad y confort</p>\r\n\r\n<p>&nbsp;</p>\r\n', 20.00, 'https://www.farmaciauniversal24h.com/18324-large_default/beter-set-bebe-peine-y-cepillo.jpg', '2024-10-27 15:08:42'),
(13, 6, 7, 'BETER Set Bebé Peine y Cepillo', 150, 22.00, '<p>Es una f&oacute;rmula exclusiva que contiene una forma de vitamina C, Ester C, mejorada, patentada y no &aacute;cida que facilita la absorci&oacute;n de vitamina C en el organismo.&nbsp;</p>\r\n\r\n<h3>&iquest;Qu&eacute; beneficios tiene Solgar Ester-C Plus Vitamina C C&aacute;psulas Vegetales?</h3>\r\n\r\n<p>Reduce el cansancio y la fatiga, y favorece la buena salud de la piel, huesos y dientes. Asimismo, refuerza el sistema inmunitario y tiene una acci&oacute;n antioxidante.</p>\r\n\r\n<h3>&iquest;C&oacute;mo tomar Solgar Ester-C Plus Vitamina C C&aacute;psulas Vegetales?</h3>\r\n\r\n<p>Se recomienda tomar 1 c&aacute;psula al d&iacute;a preferentemente con las comidas o seg&uacute;n indicaci&oacute;n de un especialista.</p>\r\n\r\n<h3>Composici&oacute;n de Solgar Ester-C Plus Vitamina C C&aacute;psulas Vegetales</h3>\r\n\r\n<p>Vitamina C (calcio L-ascorbato, Ester C), Bioflavonoides c&iacute;tricos complex, Extracto en polvo de fruto de Acerola (Malpighia glabra) (4:1), Escaramujo (Rosa canina) en polvo, Rutina. Antiaglomerantes: estearato magn&eacute;sico vegetal, di&oacute;xido de silicio; C&aacute;psula vegetal: hidroxipropilmetilcelulosa.</p>\r\n', 20.00, 'https://www.farmaciauniversal24h.com/22180-large_default/solgar-ester-c-plus-500-mg-50-vegetable-caps.jpg', '2024-10-27 15:09:42');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categ`),
  ADD UNIQUE KEY `nombre_categ` (`nombre_categ`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido_farmacia` (`id_pedido_farmacia`),
  ADD KEY `id_prod` (`id_prod`);

--
-- Indices de la tabla `farmacia`
--
ALTER TABLE `farmacia`
  ADD PRIMARY KEY (`id_farmacia`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `pedido_farmacia`
--
ALTER TABLE `pedido_farmacia`
  ADD PRIMARY KEY (`id_pedido_farmacia`),
  ADD KEY `id_farmacia` (`id_farmacia`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_prod`),
  ADD KEY `id_categ` (`id_categ`),
  ADD KEY `id_farmacia` (`id_farmacia`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categ` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `farmacia`
--
ALTER TABLE `farmacia`
  MODIFY `id_farmacia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `pedido_farmacia`
--
ALTER TABLE `pedido_farmacia`
  MODIFY `id_pedido_farmacia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_prod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido_farmacia`) REFERENCES `pedido_farmacia` (`id_pedido_farmacia`),
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `pedido_farmacia`
--
ALTER TABLE `pedido_farmacia`
  ADD CONSTRAINT `pedido_farmacia_ibfk_1` FOREIGN KEY (`id_farmacia`) REFERENCES `farmacia` (`id_farmacia`),
  ADD CONSTRAINT `pedido_farmacia_ibfk_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categ`) REFERENCES `categoria` (`id_categ`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_farmacia`) REFERENCES `farmacia` (`id_farmacia`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
