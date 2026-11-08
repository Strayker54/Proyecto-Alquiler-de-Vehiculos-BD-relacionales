PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS SUCURSAL (
    IdSucursal INTEGER PRIMARY KEY,
    Ciudad VARCHAR(50) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS TALLER (
    CodTaller INTEGER PRIMARY KEY,
    NIT_Taller INTEGER,
    NombreTaller VARCHAR(100) NOT NULL,
    TipoTaller VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS MEMBRESIA (
    NombreUnico VARCHAR(50) PRIMARY KEY,
    CostoMensual DECIMAL(10,2) NOT NULL,
    Beneficios TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS CLIENTE (
    NIT INTEGER PRIMARY KEY,
    CUC VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    Barrio VARCHAR(50) NOT NULL,
    Calle VARCHAR(100) NOT NULL,
    Recomendador_NIT INTEGER,
    FOREIGN KEY (Recomendador_NIT) REFERENCES CLIENTE(NIT)
);

CREATE TABLE IF NOT EXISTS CLIENTE_TELEFONO (
    NIT INTEGER NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (NIT, Telefono),
    FOREIGN KEY (NIT) REFERENCES CLIENTE(NIT) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CLIENTE_OCASIONAL (
    NIT INTEGER PRIMARY KEY,
    TarjetaCredito VARCHAR(20) NOT NULL,
    LicenciaConduccion VARCHAR(20) NOT NULL,
    FOREIGN KEY (NIT) REFERENCES CLIENTE(NIT) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CLIENTE_EMPRESARIAL (
    NIT INTEGER PRIMARY KEY,
    RazonSocial VARCHAR(150) NOT NULL,
    DescuentoCorporativo DECIMAL(5,2) NOT NULL,
    ContactoEjecutivo VARCHAR(100) NOT NULL,
    FOREIGN KEY (NIT) REFERENCES CLIENTE(NIT) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CONTRATA (
    NIT INTEGER NOT NULL,
    NombreUnico VARCHAR(50) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    PRIMARY KEY (NIT, NombreUnico),
    FOREIGN KEY (NIT) REFERENCES CLIENTE(NIT),
    FOREIGN KEY (NombreUnico) REFERENCES MEMBRESIA(NombreUnico)
);

CREATE TABLE IF NOT EXISTS VEHICULO (
    VIN VARCHAR(17) PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Año INTEGER NOT NULL,
    KilometrajeActual INTEGER NOT NULL,
    TarifaDiariaBase DECIMAL(10,2) NOT NULL,
    NumPasajeros INTEGER NOT NULL,
    TipoTransmision VARCHAR(20) NOT NULL,
    TipoTraccion VARCHAR(10) NOT NULL,
    TipoCombustible VARCHAR(20) NOT NULL,
    IdSucursal INTEGER NOT NULL,
    FOREIGN KEY (IdSucursal) REFERENCES SUCURSAL(IdSucursal)
);

CREATE TABLE IF NOT EXISTS AUTOMOVIL (
    VIN VARCHAR(17) PRIMARY KEY,
    TipoCarroceria VARCHAR(30) NOT NULL,
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS VAN_CARGA (
    VIN VARCHAR(17) PRIMARY KEY,
    CapacidadCargaKg DECIMAL(8,2) NOT NULL,
    VolumenUtilM3 DECIMAL(6,2) NOT NULL,
    TipoLicencia VARCHAR(5) NOT NULL,
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS VEHICULO_ELECTRICO (
    VIN VARCHAR(17) PRIMARY KEY,
    AutonomiaKm INTEGER NOT NULL,
    TiempoCargaHoras DECIMAL(4,2) NOT NULL,
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS VEHICULO_PREMIUM (
    VIN VARCHAR(17) PRIMARY KEY,
    Torque VARCHAR(30) NOT NULL,
    Aceleracion VARCHAR(30) NOT NULL,
    DetallesLujo TEXT NOT NULL,
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS RESERVA (
    CodReserva INTEGER PRIMARY KEY,
    NIT_Cliente INTEGER NOT NULL,
    VIN_Solicitado VARCHAR(17),
    FechaCreacion DATE NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (NIT_Cliente) REFERENCES CLIENTE(NIT),
    FOREIGN KEY (VIN_Solicitado) REFERENCES VEHICULO(VIN)
);

CREATE TABLE IF NOT EXISTS ALQUILER_EFECTIVO (
    IdAlquiler INTEGER PRIMARY KEY AUTOINCREMENT,
    NIT INTEGER NOT NULL,
    CodReserva INTEGER NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    FechaHoraSalida DATETIME NOT NULL,
    NivelCombSalida VARCHAR(20) NOT NULL,
    KmSalida INTEGER NOT NULL,
    FechaHoraLlegada DATETIME,
    NivelCombLlegada VARCHAR(20),
    KmLlegada INTEGER,
    NotasEstado TEXT,
    FOREIGN KEY (NIT) REFERENCES CLIENTE(NIT),
    FOREIGN KEY (CodReserva) REFERENCES RESERVA(CodReserva),
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN)
);

CREATE TABLE IF NOT EXISTS CONTRATO (
    NumContrato INTEGER PRIMARY KEY,
    IdAlquiler INTEGER NOT NULL,
    FechaFirma DATE NOT NULL,
    Condiciones TEXT NOT NULL,
    CostoTotalReal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (IdAlquiler) REFERENCES ALQUILER_EFECTIVO(IdAlquiler)
);

CREATE TABLE IF NOT EXISTS POLIZA_SEGURO (
    CodPoliza INTEGER PRIMARY KEY,
    NumContrato INTEGER NOT NULL,
    Aseguradora VARCHAR(100) NOT NULL,
    TipoCobertura VARCHAR(50) NOT NULL,
    CostoDiario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (NumContrato) REFERENCES CONTRATO(NumContrato)
);

CREATE TABLE IF NOT EXISTS MANTENIMIENTO (
    IdMantenimiento INTEGER PRIMARY KEY,
    VIN VARCHAR(17) NOT NULL,
    CodTaller INTEGER NOT NULL,
    FechaIngreso DATE NOT NULL,
    CostoTotalMant DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (VIN) REFERENCES VEHICULO(VIN),
    FOREIGN KEY (CodTaller) REFERENCES TALLER(CodTaller)
);

CREATE TABLE IF NOT EXISTS DETALLE_MANTENIMIENTO (
    IdDetalle INTEGER PRIMARY KEY,
    IdMantenimiento INTEGER NOT NULL,
    RepuestoOServicio VARCHAR(100) NOT NULL,
    Cantidad INTEGER NOT NULL,
    CostoUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdMantenimiento) REFERENCES MANTENIMIENTO(IdMantenimiento)
);

INSERT OR IGNORE INTO SUCURSAL (IdSucursal, Ciudad, Direccion) VALUES
(1, 'Bucaramanga', 'Carrera 27 # 45-12, Barrio Cabecera'),
(2, 'Bogota', 'Avenida El Dorado # 103-09, Fontibon'),
(3, 'Medellin', 'Carrera 43A # 1-50, El Poblado'),
(4, 'Cali', 'Avenida 6N # 28N-40, Chipichape'),
(5, 'Barranquilla', 'Calle 76 # 54-11, Barrio Prado');

INSERT OR IGNORE INTO TALLER (CodTaller, NIT_Taller, NombreTaller, TipoTaller, Ciudad, Direccion) VALUES
(101, 900123456, 'Taller Central de Mantenimiento UIS', 'Interno', 'Bucaramanga', 'Zona Industrial Chimita Bodega 4'),
(102, 900234567, 'Serviteca Los Andes Capital', 'Aliado Externo', 'Bogota', 'Calle 134 # 45-20'),
(103, 900345678, 'Centro Automotriz del Valle', 'Concesionario', 'Cali', 'Calle 10 # 32-15'),
(104, 900456789, 'Taller Especializado Antioquia Motors', 'Interno', 'Medellin', 'Autopista Sur # 65-10'),
(105, 900567890, 'Mecanica y Diagnostico Caribe', 'Aliado Externo', 'Barranquilla', 'Via 40 # 73-290');

INSERT OR IGNORE INTO MEMBRESIA (NombreUnico, CostoMensual, Beneficios) VALUES
('Estandar', 0.00, 'Sin costo mensual. Tarifas de lista regulares y acumulacion basica de puntos.'),
('Bronce', 49000.00, '5% de descuento en alquileres de fin de semana y atencion prioritaria en mostrador.'),
('Plata', 99000.00, '10% de descuento en cualquier categoria, conductor adicional sin costo.'),
('Oro Corporativo', 189000.00, '15% de descuento general, kilometraje ilimitado y entrega a domicilio.'),
('Platinum VIP', 299000.00, '20% de descuento, cobertura total de seguro basica incluida y acceso prioritario a flota premium.');

INSERT OR IGNORE INTO CLIENTE (NIT, CUC, Nombre, Ciudad, Barrio, Calle, Recomendador_NIT) VALUES
(1098765432, 'CUC-BGA-001', 'Carlos Mendoza', 'Bucaramanga', 'Cabecera', 'Calle 48 # 33-10', NULL),
(1098765433, 'CUC-BGA-002', 'Valentina Gomez', 'Bucaramanga', 'San Francisco', 'Carrera 22 # 18-45', 1098765432),
(1014234567, 'CUC-BOG-003', 'Felipe Morales', 'Bogota', 'Chapinero', 'Calle 67 # 9-20', NULL),
(1014234568, 'CUC-BOG-004', 'Camila Rodriguez', 'Bogota', 'Usaquen', 'Carrera 7 # 120-15', 1014234567),
(1037654321, 'CUC-MED-005', 'Mateo Restrepo', 'Medellin', 'Laureles', 'Circular 4 # 71-10', NULL),
(1037654322, 'CUC-MED-006', 'Sofia Jaramillo', 'Medellin', 'Belen', 'Calle 30 # 76-40', 1037654321),
(900888101, 'CUC-EMP-001', 'Logistica Santander S.A.S.', 'Bucaramanga', 'Centro', 'Calle 36 # 15-24', NULL),
(900888102, 'CUC-EMP-002', 'Constructora Andina del Oriente', 'Bogota', 'Chico', 'Carrera 11 # 94-02', NULL),
(900888103, 'CUC-EMP-003', 'Distribuciones Paisas Ltda.', 'Medellin', 'Guayabal', 'Carrera 52 # 14-80', NULL),
(900888104, 'CUC-EMP-004', 'Ingenieria y Montajes de Occidente', 'Cali', 'San Fernando', 'Carrera 34 # 4B-19', NULL),
(900888105, 'CUC-EMP-005', 'Agroindustrias del Caribe S.A.', 'Barranquilla', 'El Golf', 'Calle 82 # 57-33', NULL),
(900888106, 'CUC-EMP-006', 'Soluciones Tecnologicas Globales', 'Bogota', 'Salitre', 'Avenida Esperanza # 68-50', 900888102);

INSERT OR IGNORE INTO CLIENTE_TELEFONO (NIT, Telefono) VALUES
(1098765432, '3157894512'),
(1098765432, '6076345678'),
(1098765433, '3189012345'),
(1014234567, '3001234567'),
(1014234567, '6017890123'),
(1014234568, '3114567890'),
(1037654321, '3206549870'),
(1037654322, '3169876543'),
(900888101, '6076891122'),
(900888101, '3174561122'),
(900888102, '6013456789'),
(900888103, '6042345678'),
(900888104, '6028901234'),
(900888105, '6053678901');

INSERT OR IGNORE INTO CLIENTE_OCASIONAL (NIT, TarjetaCredito, LicenciaConduccion) VALUES
(1098765432, '4532XXXXXXXX1234', '1098765432-BGA'),
(1098765433, '4916XXXXXXXX5678', '1098765433-BGA'),
(1014234567, '5424XXXXXXXX9012', '1014234567-BOG'),
(1014234568, '3782XXXXXXXX3456', '1014234568-BOG'),
(1037654321, '4026XXXXXXXX7890', '1037654321-MED'),
(1037654322, '5520XXXXXXXX2345', '1037654322-MED');

INSERT OR IGNORE INTO CLIENTE_EMPRESARIAL (NIT, RazonSocial, DescuentoCorporativo, ContactoEjecutivo) VALUES
(900888101, 'Logistica Santander S.A.S.', 15.00, 'Hernando Suarez - Gerente de Operaciones'),
(900888102, 'Constructora Andina del Oriente', 18.00, 'Martha Patricia Gomez - Directora Administrativa'),
(900888103, 'Distribuciones Paisas Ltda.', 12.50, 'Alejandro Restrepo - Jefe de Compras'),
(900888104, 'Ingenieria y Montajes de Occidente', 14.00, 'Beatriz Elena Castrillon - Coordinadora Logistica'),
(900888105, 'Agroindustrias del Caribe S.A.', 20.00, 'Jorge Mario Dangond - Gerente General'),
(900888106, 'Soluciones Tecnologicas Globales', 10.00, 'Paola Andrea Rincon - Lider de Talento Humano');

INSERT OR IGNORE INTO CONTRATA (NIT, NombreUnico, FechaInicio, FechaFin) VALUES
(900888101, 'Oro Corporativo', '2026-01-01', '2026-12-31'),
(900888102, 'Platinum VIP', '2026-02-01', '2027-01-31'),
(900888103, 'Oro Corporativo', '2026-03-01', '2027-02-28'),
(900888105, 'Platinum VIP', '2026-01-15', '2027-01-14'),
(1098765432, 'Plata', '2026-05-01', '2026-11-01'),
(1014234567, 'Bronce', '2026-06-01', '2026-12-01');

INSERT OR IGNORE INTO VEHICULO (VIN, Placa, Marca, Modelo, Año, KilometrajeActual, TarifaDiariaBase, NumPasajeros, TipoTransmision, TipoTraccion, TipoCombustible, IdSucursal) VALUES
('1FA6P8CF5H5000001', 'BGA101', 'Renault', 'Logan Zen', 2023, 24500, 130000.00, 5, 'Manual', '4x2', 'Gasolina', 1),
('1FA6P8CF5H5000002', 'BOG202', 'Chevrolet', 'Onix Sedan', 2024, 18200, 145000.00, 5, 'Automatica', '4x2', 'Gasolina', 2),
('1FA6P8CF5H5000003', 'MED303', 'Toyota', 'Corolla XEI', 2023, 31000, 190000.00, 5, 'Automatica', '4x2', 'Hibrido', 3),
('1FA6P8CF5H5000004', 'CAL404', 'Mazda', '3 Grand Touring', 2024, 12800, 195000.00, 5, 'Automatica', '4x2', 'Gasolina', 4),
('1FA6P8CF5H5000005', 'BAQ505', 'Volkswagen', 'Jetta Comfortline', 2023, 27400, 180000.00, 5, 'Automatica', '4x2', 'Gasolina', 5),
('2FA6P8CF5H5000006', 'BGA106', 'Renault', 'Master Carga', 2022, 58000, 260000.00, 3, 'Manual', '4x2', 'Diesel', 1),
('2FA6P8CF5H5000007', 'BOG207', 'Chevrolet', 'N400 Max', 2024, 15300, 175000.00, 2, 'Manual', '4x2', 'Gasolina', 2),
('2FA6P8CF5H5000008', 'MED308', 'Peugeot', 'Expert Furgon', 2023, 39400, 240000.00, 3, 'Manual', '4x2', 'Diesel', 3),
('2FA6P8CF5H5000009', 'CAL409', 'Ford', 'Transit Custom', 2023, 44100, 280000.00, 3, 'Manual', '4x2', 'Diesel', 4),
('2FA6P8CF5H5000010', 'BAQ510', 'Hyundai', 'H100 Panel', 2022, 62000, 210000.00, 3, 'Manual', '4x2', 'Diesel', 5),
('3FA6P8CF5H5000011', 'BGA111', 'BYD', 'Yuan Plus EV', 2024, 8500, 230000.00, 5, 'Automatica', '4x2', 'Electrico', 1),
('3FA6P8CF5H5000012', 'BOG212', 'BMW', 'iX3 M Sport', 2024, 11200, 390000.00, 5, 'Automatica', '4x2', 'Electrico', 2),
('3FA6P8CF5H5000013', 'MED313', 'Volvo', 'XC40 Recharge', 2024, 9400, 370000.00, 5, 'Automatica', 'AWD', 'Electrico', 3),
('3FA6P8CF5H5000014', 'CAL414', 'BYD', 'Dolphin Mini EV', 2024, 6200, 160000.00, 4, 'Automatica', '4x2', 'Electrico', 4),
('3FA6P8CF5H5000015', 'BAQ515', 'Kia', 'EV6 GT-Line', 2024, 7800, 380000.00, 5, 'Automatica', 'AWD', 'Electrico', 5),
('4FA6P8CF5H5000016', 'BGA116', 'Mercedes-Benz', 'C200 Exclusive', 2024, 14000, 340000.00, 5, 'Automatica', '4x2', 'Gasolina', 1),
('4FA6P8CF5H5000017', 'BOG217', 'Audi', 'A6 S-Line', 2024, 16500, 420000.00, 5, 'Automatica', 'AWD', 'Gasolina', 2),
('4FA6P8CF5H5000018', 'MED318', 'BMW', 'Serie 4 Gran Coupe', 2024, 13200, 410000.00, 5, 'Automatica', '4x2', 'Gasolina', 3),
('4FA6P8CF5H5000019', 'CAL419', 'Porsche', 'Macan Turbo', 2023, 21000, 550000.00, 5, 'Automatica', 'AWD', 'Gasolina', 4),
('4FA6P8CF5H5000020', 'BAQ520', 'Land Rover', 'Defender 110', 2024, 18900, 520000.00, 7, 'Automatica', '4x4', 'Diesel', 5);

INSERT OR IGNORE INTO AUTOMOVIL (VIN, TipoCarroceria) VALUES
('1FA6P8CF5H5000001', 'Sedan'),
('1FA6P8CF5H5000002', 'Sedan'),
('1FA6P8CF5H5000003', 'Sedan'),
('1FA6P8CF5H5000004', 'Hatchback'),
('1FA6P8CF5H5000005', 'Sedan');

INSERT OR IGNORE INTO VAN_CARGA (VIN, CapacidadCargaKg, VolumenUtilM3, TipoLicencia) VALUES
('2FA6P8CF5H5000006', 1650.00, 11.50, 'C2'),
('2FA6P8CF5H5000007', 750.00, 4.30, 'C1'),
('2FA6P8CF5H5000008', 1400.00, 6.60, 'C1'),
('2FA6P8CF5H5000009', 1800.00, 9.80, 'C2'),
('2FA6P8CF5H5000010', 1250.00, 5.20, 'C1');

INSERT OR IGNORE INTO VEHICULO_ELECTRICO (VIN, AutonomiaKm, TiempoCargaHoras) VALUES
('3FA6P8CF5H5000011', 480, 1.20),
('3FA6P8CF5H5000012', 460, 0.80),
('3FA6P8CF5H5000013', 418, 0.75),
('3FA6P8CF5H5000014', 300, 1.50),
('3FA6P8CF5H5000015', 506, 0.30);

INSERT OR IGNORE INTO VEHICULO_PREMIUM (VIN, Torque, Aceleracion, DetallesLujo) VALUES
('4FA6P8CF5H5000016', '300 Nm', '7.3 s', 'Silleteria en cuero Nappa, sonido Burmester surround, iluminacion ambiental de 64 colores'),
('4FA6P8CF5H5000017', '370 Nm', '6.0 s', 'Techo panoramico corredizo, suspension adaptativa neumatica, cockpit digital dual'),
('4FA6P8CF5H5000018', '400 Nm', '5.8 s', 'Paquete exterior M Sport, asientos deportivos calefactables, head-up display con realidad aumentada'),
('4FA6P8CF5H5000019', '550 Nm', '4.3 s', 'Frenos carboceramicos PCCB, escape deportivo regulable, tapiceria en Alcantara premium'),
('4FA6P8CF5H5000020', '650 Nm', '6.5 s', 'Suspension neumatica off-road regulable, camaras 3D 360 grados de entorno, sistema Meridian audio');

INSERT OR IGNORE INTO RESERVA (CodReserva, NIT_Cliente, VIN_Solicitado, FechaCreacion, FechaInicio, FechaFin, Estado) VALUES
(5001, 1098765432, '1FA6P8CF5H5000001', '2026-08-01', '2026-08-05', '2026-08-08', 'Completada'),
(5002, 1014234567, '1FA6P8CF5H5000002', '2026-08-10', '2026-08-12', '2026-08-15', 'Completada'),
(5003, 900888101, '2FA6P8CF5H5000006', '2026-08-15', '2026-08-18', '2026-08-25', 'Completada'),
(5004, 900888102, '3FA6P8CF5H5000012', '2026-08-20', '2026-08-22', '2026-08-26', 'Completada'),
(5005, 1037654321, '4FA6P8CF5H5000018', '2026-09-01', '2026-09-03', '2026-09-06', 'Completada'),
(5006, 900888105, '4FA6P8CF5H5000020', '2026-09-05', '2026-09-08', '2026-09-14', 'Completada'),
(5007, 1098765433, '3FA6P8CF5H5000011', '2026-10-01', '2026-10-10', '2026-10-13', 'Confirmada'),
(5008, 900888104, '2FA6P8CF5H5000009', '2026-10-05', '2026-10-15', '2026-10-22', 'Confirmada');

INSERT OR IGNORE INTO ALQUILER_EFECTIVO (IdAlquiler, NIT, CodReserva, VIN, FechaHoraSalida, NivelCombSalida, KmSalida, FechaHoraLlegada, NivelCombLlegada, KmLlegada, NotasEstado) VALUES
(1, 1098765432, 5001, '1FA6P8CF5H5000001', '2026-08-05 08:30:00', 'Lleno', 24100, '2026-08-08 17:00:00', 'Lleno', 24500, 'Entrega y devolucion sin novedades esteticas.'),
(2, 1014234567, 5002, '1FA6P8CF5H5000002', '2026-08-12 09:15:00', 'Lleno', 17850, '2026-08-15 18:30:00', 'Lleno', 18200, 'Vehiculo devuelto limpio con odometro dentro del rango esperado.'),
(3, 900888101, 5003, '2FA6P8CF5H5000006', '2026-08-18 07:00:00', 'Lleno', 56800, '2026-08-25 16:45:00', 'Lleno', 58000, 'Operacion logistica intermunicipal Santander-Cesar completada.'),
(4, 900888102, 5004, '3FA6P8CF5H5000012', '2026-08-22 10:00:00', '100%', 10800, '2026-08-26 14:20:00', '90%', 11200, 'Ruta corporativa ejecutiva Bogota-Chia. Bateria devuelta al 90%.'),
(5, 1037654321, 5005, '4FA6P8CF5H5000018', '2026-09-03 14:00:00', 'Lleno', 12900, '2026-09-06 19:00:00', 'Lleno', 13200, 'Alquiler fin de semana evento en Llanogrande.'),
(6, 900888105, 5006, '4FA6P8CF5H5000020', '2026-09-08 08:00:00', 'Lleno', 17950, '2026-09-14 18:00:00', 'Lleno', 18900, 'Recorrido corporativo costa atlantica Barranquilla-Santa Marta-Cartagena.');

INSERT OR IGNORE INTO CONTRATO (NumContrato, IdAlquiler, FechaFirma, Condiciones, CostoTotalReal) VALUES
(7001, 1, '2026-08-05', 'Alquiler individual por 3 dias con tarifa regular y entrega en sede Cabecera.', 390000.00),
(7002, 2, '2026-08-12', 'Alquiler individual por 3 dias en sede El Dorado con seguro incluido.', 435000.00),
(7003, 3, '2026-08-18', 'Alquiler corporativo por 7 dias para Logistica Santander con descuento corporativo del 15%.', 1547000.00),
(7004, 4, '2026-08-22', 'Alquiler corporativo electrico por 4 dias con descuento del 18% para Constructora Andina.', 1279200.00),
(7005, 5, '2026-09-03', 'Alquiler gama premium individual por 3 dias sede El Poblado con descuento membresia Plata.', 1107000.00),
(7006, 6, '2026-09-08', 'Alquiler corporativo SUV premium por 6 dias con descuento corporativo del 20% para Agroindustrias del Caribe.', 2496000.00);

INSERT OR IGNORE INTO POLIZA_SEGURO (CodPoliza, NumContrato, Aseguradora, TipoCobertura, CostoDiario) VALUES
(8001, 7001, 'Seguros Bolivar', 'Todo Riesgo con Franquicia', 28000.00),
(8002, 7002, 'Suramericana de Seguros', 'Todo Riesgo sin Franquicia', 35000.00),
(8003, 7003, 'Allianz Seguros Colombia', 'Flota Comercial y Carga', 45000.00),
(8004, 7004, 'Mapfre Seguros', 'Todo Riesgo Vehiculos Electricos', 42000.00),
(8005, 7005, 'Seguros del Estado', 'Todo Riesgo Alta Gama', 55000.00),
(8006, 7006, 'Suramericana de Seguros', 'Todo Riesgo Alta Gama y Responsabilidad Extracontractual', 65000.00);

INSERT OR IGNORE INTO MANTENIMIENTO (IdMantenimiento, VIN, CodTaller, FechaIngreso, CostoTotalMant) VALUES
(9001, '1FA6P8CF5H5000001', 101, '2026-07-15', 380000.00),
(9002, '2FA6P8CF5H5000006', 101, '2026-07-28', 920000.00),
(9003, '1FA6P8CF5H5000002', 102, '2026-08-01', 450000.00),
(9004, '3FA6P8CF5H5000012', 102, '2026-08-10', 580000.00),
(9005, '4FA6P8CF5H5000018', 104, '2026-08-25', 1250000.00),
(9006, '2FA6P8CF5H5000010', 105, '2026-09-02', 840000.00);

INSERT OR IGNORE INTO DETALLE_MANTENIMIENTO (IdDetalle, IdMantenimiento, RepuestoOServicio, Cantidad, CostoUnitario, Subtotal) VALUES
(90011, 9001, 'Cambio de Aceite Sintetico 5W-30 y Filtro', 1, 220000.00, 220000.00),
(90012, 9001, 'Alineacion y Balanceo Computarizado', 1, 160000.00, 160000.00),
(90021, 9002, 'Kit Pastillas de Freno Delanteras Servicio Pesado', 1, 480000.00, 480000.00),
(90022, 9002, 'Cambio Filtro de Combustible Diesel y Filtro de Aire', 2, 220000.00, 440000.00),
(90031, 9003, 'Cambio de Aceite Sintetico y Filtro', 1, 250000.00, 250000.00),
(90032, 9003, 'Rotacion e Inflado con Nitrogeno de 4 Neumaticos', 1, 200000.00, 200000.00),
(90041, 9004, 'Diagnostico y Calibracion Computarizada de Celdas de Bateria EV', 1, 380000.00, 380000.00),
(90042, 9004, 'Filtro de Polen y Cabina HEPA', 1, 200000.00, 200000.00),
(90051, 9005, 'Pastillas de Freno Ceramicas Ventiladas Eje Delantero', 1, 850000.00, 850000.00),
(90052, 9005, 'Mano de Obra Especializada y Purga Liquido DOT 5.1', 1, 400000.00, 400000.00),
(90061, 9006, 'Cambio de Amortiguadores Traseros Reforzados', 2, 320000.00, 640000.00),
(90062, 9006, 'Engrase General de Suspension y Terminales', 1, 200000.00, 200000.00);

SELECT 
    s.IdSucursal,
    s.Ciudad,
    COUNT(c.NumContrato) AS TotalAlquileres,
    ROUND(SUM(c.CostoTotalReal), 2) AS IngresosTotales,
    ROUND(AVG(c.CostoTotalReal), 2) AS TicketPromedio
FROM SUCURSAL s
JOIN VEHICULO v ON s.IdSucursal = v.IdSucursal
JOIN ALQUILER_EFECTIVO ae ON v.VIN = ae.VIN
JOIN CONTRATO c ON ae.IdAlquiler = c.IdAlquiler
GROUP BY s.IdSucursal, s.Ciudad
ORDER BY IngresosTotales DESC;

SELECT 
    v.VIN,
    v.Placa,
    v.Marca,
    v.Modelo,
    t.NombreTaller,
    m.FechaIngreso,
    COUNT(dm.IdDetalle) AS TotalItemsAtendidos,
    ROUND(SUM(dm.Subtotal), 2) AS CostoTotalReparaciones
FROM VEHICULO v
JOIN MANTENIMIENTO m ON v.VIN = m.VIN
JOIN TALLER t ON m.CodTaller = t.CodTaller
JOIN DETALLE_MANTENIMIENTO dm ON m.IdMantenimiento = dm.IdMantenimiento
GROUP BY v.VIN, v.Placa, v.Marca, v.Modelo, t.NombreTaller, m.FechaIngreso
ORDER BY CostoTotalReparaciones DESC;

SELECT 
    ce.NIT,
    ce.RazonSocial,
    ce.DescuentoCorporativo AS PorcentajeDescuento,
    m.NombreUnico AS PlanMembresia,
    m.CostoMensual,
    co.FechaInicio AS VigenciaDesde,
    co.FechaFin AS VigenciaHasta
FROM CLIENTE_EMPRESARIAL ce
JOIN CONTRATA co ON ce.NIT = co.NIT
JOIN MEMBRESIA m ON co.NombreUnico = m.NombreUnico
WHERE DATE('now') BETWEEN co.FechaInicio AND co.FechaFin
   OR co.FechaFin >= '2026-11-01'
ORDER BY ce.DescuentoCorporativo DESC;

SELECT 
    v.VIN,
    v.Placa,
    v.Marca,
    v.Modelo,
    ve.AutonomiaKm,
    ve.TiempoCargaHoras,
    s.Ciudad AS CiudadSede,
    v.TarifaDiariaBase
FROM VEHICULO v
JOIN VEHICULO_ELECTRICO ve ON v.VIN = ve.VIN
JOIN SUCURSAL s ON v.IdSucursal = s.IdSucursal
ORDER BY ve.AutonomiaKm DESC;

SELECT 
    ae.IdAlquiler,
    cl.Nombre AS Cliente,
    v.Placa,
    v.Marca || ' ' || v.Modelo AS Vehiculo,
    ae.KmSalida,
    ae.KmLlegada,
    (ae.KmLlegada - ae.KmSalida) AS KmRecorridos,
    ae.FechaHoraSalida,
    ae.FechaHoraLlegada
FROM ALQUILER_EFECTIVO ae
JOIN CLIENTE cl ON ae.NIT = cl.NIT
JOIN VEHICULO v ON ae.VIN = v.VIN
WHERE ae.KmLlegada IS NOT NULL
ORDER BY KmRecorridos DESC;

SELECT 
    v.VIN,
    v.Placa,
    v.Marca,
    v.Modelo,
    v.TipoCombustible,
    COUNT(ae.IdAlquiler) AS TotalVecesAlquilado,
    COALESCE(SUM(c.CostoTotalReal), 0) AS TotalFacturadoVehiculo
FROM VEHICULO v
LEFT JOIN ALQUILER_EFECTIVO ae ON v.VIN = ae.VIN
LEFT JOIN CONTRATO c ON ae.IdAlquiler = c.IdAlquiler
GROUP BY v.VIN, v.Placa, v.Marca, v.Modelo, v.TipoCombustible
ORDER BY TotalVecesAlquilado DESC, TotalFacturadoVehiculo DESC;

SELECT 
    p.NIT AS NIT_Recomendador,
    p.Nombre AS NombreRecomendador,
    COUNT(h.NIT) AS TotalClientesReferidos,
    GROUP_CONCAT(h.Nombre, ', ') AS ClientesRecomendados
FROM CLIENTE p
JOIN CLIENTE h ON p.NIT = h.Recomendador_NIT
GROUP BY p.NIT, p.Nombre
ORDER BY TotalClientesReferidos DESC;

SELECT 
    ps.Aseguradora,
    ps.TipoCobertura,
    COUNT(ps.CodPoliza) AS CantidadPolizas,
    ROUND(AVG(ps.CostoDiario), 2) AS CostoDiarioPromedio,
    ROUND(SUM(c.CostoTotalReal), 2) AS TotalFacturadoAsociado
FROM POLIZA_SEGURO ps
JOIN CONTRATO c ON ps.NumContrato = c.NumContrato
GROUP BY ps.Aseguradora, ps.TipoCobertura
ORDER BY CantidadPolizas DESC, CostoDiarioPromedio DESC;

SELECT 
    v.VIN,
    v.Placa,
    v.Marca,
    v.Modelo,
    s.Ciudad AS CiudadSede,
    ROUND(SUM(m.CostoTotalMant), 2) AS GastoMantenimiento
FROM VEHICULO v
JOIN SUCURSAL s ON v.IdSucursal = s.IdSucursal
JOIN MANTENIMIENTO m ON v.VIN = m.VIN
GROUP BY v.VIN, v.Placa, v.Marca, v.Modelo, s.Ciudad
HAVING SUM(m.CostoTotalMant) > (
    SELECT AVG(CostoTotalMant) FROM MANTENIMIENTO
)
ORDER BY GastoMantenimiento DESC;

SELECT 
    r.Estado AS EstadoReserva,
    COUNT(r.CodReserva) AS CantidadReservas,
    COUNT(ae.IdAlquiler) AS AlquileresMaterializados,
    ROUND(COUNT(ae.IdAlquiler) * 100.0 / COUNT(r.CodReserva), 2) AS PorcentajeEfectividad
FROM RESERVA r
LEFT JOIN ALQUILER_EFECTIVO ae ON r.CodReserva = ae.CodReserva
GROUP BY r.Estado
ORDER BY CantidadReservas DESC;
