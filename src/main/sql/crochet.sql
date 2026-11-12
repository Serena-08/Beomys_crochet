-- =====================================================
-- Beomys Crochet - Script de base de datos (MySQL 8.4)
-- Crea la base, las tablas con sus claves foráneas y datos de prueba.
-- =====================================================
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS crochet
    CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE crochet;

-- Se borran en orden inverso a las dependencias
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS productos_por_pedido, pedidos, productos, categorias, usuarios, roles;
SET FOREIGN_KEY_CHECKS = 1;

-- Tablas
-- -----------------------------------------------------
CREATE TABLE roles (
    idRol  INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    PRIMARY KEY (idRol),
    UNIQUE KEY uq_roles_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE categorias (
    idCategoria INT NOT NULL AUTO_INCREMENT,
    categoria   VARCHAR(145) NOT NULL,
    PRIMARY KEY (idCategoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- clave admite hash BCrypt (60 caracteres); idRol: 1 = ADMIN, 2 = CLIENTE
CREATE TABLE usuarios (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    nombre    VARCHAR(145) NOT NULL,
    apellido  VARCHAR(145) NULL,
    correo    VARCHAR(145) NULL,
    clave     VARCHAR(100) NOT NULL,
    idRol     INT NOT NULL DEFAULT 2,
    PRIMARY KEY (idUsuario),
    UNIQUE KEY uq_usuarios_nombre (nombre),
    UNIQUE KEY uq_usuarios_correo (correo),
    CONSTRAINT fk_usuarios_roles
        FOREIGN KEY (idRol) REFERENCES roles (idRol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- urlML es obligatoria (NOT NULL): siempre lleva un valor, aunque sea texto vacío.
-- Si se borra una categoría, sus productos quedan sin categoría.
CREATE TABLE productos (
    idProducto  INT NOT NULL AUTO_INCREMENT,
    nombre      VARCHAR(255) NOT NULL,
    precio      DECIMAL(10,2) NOT NULL DEFAULT 0,
    descripcion VARCHAR(255) NOT NULL,
    urlImagen   VARCHAR(255) NOT NULL,
    urlML       VARCHAR(255) NOT NULL DEFAULT '',
    idCategoria INT NULL,
    PRIMARY KEY (idProducto),
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (idCategoria) REFERENCES categorias (idCategoria)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pedidos (
    idPedido    INT NOT NULL AUTO_INCREMENT,
    estado      VARCHAR(45) NOT NULL,
    fechaPedido DATE NOT NULL,
    idUsuario   INT NOT NULL,
    PRIMARY KEY (idPedido),
    CONSTRAINT fk_pedidos_usuarios
        FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla intermedia: los ítems de cada pedido (se borran junto con el pedido)
CREATE TABLE productos_por_pedido (
    idPedido       INT NOT NULL,
    idProducto     INT NOT NULL,
    cantidad       INT NOT NULL DEFAULT 1,
    precioUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idPedido, idProducto),
    CONSTRAINT fk_ppp_pedidos
        FOREIGN KEY (idPedido) REFERENCES pedidos (idPedido) ON DELETE CASCADE,
    CONSTRAINT fk_ppp_productos
        FOREIGN KEY (idProducto) REFERENCES productos (idProducto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Datos de prueba
-- -----------------------------------------------------
INSERT INTO roles (idRol, nombre) VALUES
    (1, 'ADMIN'),
    (2, 'CLIENTE');

INSERT INTO categorias (idCategoria, categoria) VALUES
    (1, 'Llaveros'),
    (2, 'Amigurumis'),
    (3, 'Accesorios'),
    (4, 'Fundas'),
    (5, 'Para bebés'),
    (7, 'Flores');

-- Las claves se guardan con hash BCrypt. Usuarios de prueba: admin / admin y cliente / cliente
INSERT INTO usuarios (idUsuario, nombre, apellido, correo, clave, idRol) VALUES
    (1, 'admin',   'Administrador', 'admin@beomys.com',   '$2a$10$2zVZGVZAo49PUk8NdyQP2.wE15zjJU8j1FaZn5vFDIuazXJqS4/qe', 1),
    (2, 'cliente', 'Demo',          'cliente@beomys.com', '$2a$10$ehPCejq7tKzP7GOItB966.jTEpPZkPFym7Ajkoyjuhg.0zerFFEEG', 2);

INSERT INTO productos (nombre, precio, descripcion, urlImagen, urlML, idCategoria) VALUES
    ('Ranas', 3000.00, 'Pequeñas ranas tejidas a crochet, ideales para compartir, llevar en la mochila o regalar.', 'https://drive.google.com/thumbnail?id=1ltdpg0HYkX9IpT8-CBqeXS1itAEDXXlK&sz=w1000', '', 1),
    ('Pulpitos', 1500.00, 'Pulpitos reversibles o de apego tejidos en hilo de algodón hipoalergénico.', 'https://drive.google.com/thumbnail?id=1g3HJFIEXF-cuZbtKyZIHn4_xpjEnZuPB&sz=w1000', '', 1),
    ('Llama Argentina', 4000.00, 'Tradicional llama argentina amigurumi, tejida a mano con detalles autóctonos.', 'https://drive.google.com/thumbnail?id=1H6raLSF-DW8wbelLipkLfjyN4FPyBjQt&sz=w1000', '', 1),
    ('Mate y Termo', 2500.00, 'Set matero de juguete tejido a crochet. Incluye termo y mate con bombilla.', 'https://drive.google.com/thumbnail?id=1gKAJYuNiXOvesV_UptCiWQa1twi5Awpx&sz=w1000', '', 1),
    ('Placton', 4500.00, 'Amigurumi del villano Plankton (Bob Esponja), tejido a mano con todo detalle.', 'https://drive.google.com/thumbnail?id=1iGQGmktkkwxpn7ZTSGL921oxJIAcr52_&sz=w1000', '', 3),
    ('Mariposas', 1400.00, 'Delicadas mariposas tejidas, perfectas para usar como souvenirs, apliques o decoración.', 'https://drive.google.com/thumbnail?id=13kGGzdyQNyqfrwSMVM4mVpzH6T_FMpdR&sz=w1000', '', 1),
    ('Llavero Hongo Sombrero', 1700.00, 'Llavero en forma de honguito con sombrero ancho, tejido en hilo de algodón.', 'https://drive.google.com/thumbnail?id=18vcUFurkBo3uobMQdIR42KhTvGN-ozHl&sz=w1000', '', 1),
    ('Funda Notook Mimikiu', 15000.00, 'Funda para notebook tejida a crochet con el adorable y espeluznante diseño de Mimikyu.', 'https://drive.google.com/thumbnail?id=12eTPhi3_nUVpfbDoLk5TzTWkIk9BTdq5&sz=w1000', '', 4),
    ('Pelotas Match', 4500.00, 'Pelotas estilo match tejidas a mano. Suaves, seguras y súper decorativas.', 'https://drive.google.com/thumbnail?id=1nYiiGSGZ7qeO2vXaFvlInsgSqGCWtRLj&sz=w1000', '', 1),
    ('Vacas Fresas', 3500.00, 'Tiernas vaquitas versión frutilla/fresa tejidas a crochet, súper abrazables.', 'https://drive.google.com/thumbnail?id=1gc52SG39vTve-JidEpm-0DaKysz6Uz7J&sz=w1000', '', 1),
    ('Cereza', 2500.00, 'Par de cerezas tejidas a crochet, un detalle kawaii ideal como llavero o adorno.', 'https://drive.google.com/thumbnail?id=12n81xijVIMrD3g17RKQ8beKiElPEXxOu&sz=w1000', '', 1),
    ('Frutillas', 2500.00, 'Frutillitas amigurumi tejidas a mano, ideales para decorar, jugar o regalar.', 'https://drive.google.com/thumbnail?id=10A37Gg6fzkPB4XAM4BXl_TkRlk__Q_DQ&sz=w1000', '', 1),
    ('Yoongi Cat Mandarina', 4000.00, 'Gatito inspirado en Suga (BTS) con su icónica mandarina, infaltable para fans.', 'https://drive.google.com/thumbnail?id=17IIZxV4HklqM9oQagsdCsfDqeHhL9n39&sz=w1000', '', 1),
    ('Triset Peces', 2000.00, 'Set de tres simpáticos peces tejidos a crochet en diferentes colores vibrantes.', 'https://drive.google.com/thumbnail?id=121DujbhuT2bWC-qEeQybiSsd6oR7uJFY&sz=w1000', '', 1),
    ('Demogorgon', 5500.00, 'Amigurumi de Demogorgon (Stranger Things), una versión aterradoramente tierna.', 'https://drive.google.com/thumbnail?id=1n5K4G6_l797p992S8apguWZFEC-oUbdJ&sz=w1000', '', 1),
    ('Sonajero Bebe', 8000.00, 'Sonajero tejido a mano en hilo de algodón hipoalergénico, seguro y estimulante para bebés.', 'https://drive.google.com/thumbnail?id=1pdermALyKMAfJehZjSeY3iQLd8Ez_aPr&sz=w1000', '', 5),
    ('Rollos de Canela', 3000.00, 'Dulces rollos de canela tejidos amigurumi, ¡tan adorables que parecen de verdad!', 'https://drive.google.com/thumbnail?id=1-lNFCELkS8QiNKcmk3UHtueT6UzlmS6o&sz=w1000', '', 1),
    ('Pelota Voley', 3500.00, 'Pelota de vóley tejida a crochet, suave, colorida y perfecta para los fanáticos del deporte.', 'https://drive.google.com/thumbnail?id=1JvVAFBsVVrIOGyDMP_beUd1b4R20bwel&sz=w1000', '', 1),
    ('Gato Ninja', 5500.00, 'Sigiloso y tierno gatito en traje de ninja amigurumi, listo para la acción.', 'https://drive.google.com/thumbnail?id=1qciUBh4sX871_Us5Hn4VsMfA582q3wv6&sz=w1000', '', 2),
    ('Llavero Jake el perro', 3500.00, 'Llavero de Jake el perro (Hora de Aventura), tejido a mano para llevar a todos lados.', 'https://drive.google.com/thumbnail?id=1WSw_B6WjaXLqc_ZcTVughOL5440bGkYq&sz=w1000', '', 1),
    ('Pareja Chimuelo', 6000.00, 'Set de Chimuelo y Furia Luminosa tejidos a crochet. El regalo ideal para compartir en pareja.', 'https://drive.google.com/thumbnail?id=1bgjc0EG0Wg-0cAr10YAy4CgRWOXLoefG&sz=w1000', '', 1),
    ('Osos', 1700.00, 'Clásicos ositos amigurumi. Muy suaves, simpáticos y perfectos para abrazar.', 'https://drive.google.com/thumbnail?id=1Ir8MuaslyD8mN1Eou9BoT7GaNtKa713f&sz=w1000', '', 1),
    ('Crochet Pochita', 3000.00, 'Amigurumi de Pochita (Chainsaw Man). El demonio motosierra más tierno tejido a mano.', 'https://drive.google.com/thumbnail?id=1t99N2A0x0kzyJldjB03y-c7Tebzox9vG&sz=w1000', '', 1),
    ('Ricky Pepino', 5000.00, '¡Soy Pickle Rick! Clásico pepino Rick de Rick y Morty tejido a crochet.', 'https://drive.google.com/thumbnail?id=15KscWlT2dPMxq2oNGtNpRlhL-kA5urOO&sz=w1000', '', 1),
    ('Coraline', 11000.00, 'Muñeca de Coraline amigurumi, detallada con su clásico piloto amarillo y pelo azul.', 'https://drive.google.com/thumbnail?id=15nteFcs3I-01oQ7uSA9rQkOFoW0DTbmr&sz=w1000', '', 4),
    ('Goku y Milk', 7500.00, 'Set de Goku y Milk tejidos a crochet. El adorno o regalo de bodas perfecto para fans del anime.', 'https://drive.google.com/thumbnail?id=1sSfbkZkoSmP56qJnOO8X0kjtf0wmJsrK&sz=w1000', '', 1),
    ('Army Bomb', 4000.00, 'Lightstick Army Bomb de BTS versión amigurumi. Un detalle tierno para cualquier ARMY.', 'https://drive.google.com/thumbnail?id=1pXTRT0Ih6T_qyfnX5EmBvW7fghBD6gfF&sz=w1000', '', 1),
    ('Pareja Gatitos Aliens', 5000.00, 'Muñecos de pareja de Gatos Aliens tejidos a crochet, para recordar momentos especiales.', 'https://drive.google.com/thumbnail?id=1iSTAUdJBgHScDah-F20_nT6N5AMxA_36&sz=w1000', '', 1),
    ('Regalo para graduación', 4000.00, 'Muñeco amigurumi con birrete y diploma. El recuerdo ideal para celebrar un egreso.', 'https://drive.google.com/thumbnail?id=1huCICDsz7peypTK07nO6aOXDmyJoLl6-&sz=w1000', '', 1);

INSERT INTO pedidos (idPedido, estado, fechaPedido, idUsuario) VALUES
    (1, 'Entregado', '2026-10-20', 2),
    (2, 'Pendiente', '2026-11-03', 2);

INSERT INTO productos_por_pedido (idPedido, idProducto, cantidad, precioUnitario) VALUES
    (1, (SELECT idProducto FROM productos WHERE nombre = 'Ranas'),    2, 2500.00),
    (1, (SELECT idProducto FROM productos WHERE nombre = 'Pulpitos'), 1, 2000.00),
    (2, (SELECT idProducto FROM productos WHERE nombre = 'Ranas'),    1, 2500.00);