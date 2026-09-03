
## 1. Conceptos relevantes del Alquiler de vehículos

Para el desarrollo de una plataforma de gestión de alquiler de vehículos basada en una base de datos relacional, es fundamental comprender los siguientes conceptos:

### Plataforma de alquiler de vehículos
Es un sistema que permite administrar el proceso de reserva, alquiler y devolución de vehículos. Centraliza la información de clientes, vehículos, pagos y contratos.

### Base de datos relacional
Es un modelo de almacenamiento de información organizado en tablas relacionadas mediante claves primarias y foráneas. Permite mantener la integridad, consistencia y disponibilidad de los datos.

### Reserva
Proceso mediante el cual un cliente solicita un vehículo para un período determinado. La reserva debe validar la disponibilidad del vehículo y registrar las fechas de inicio y finalización.

### Vehículos
Representan el recurso principal de la plataforma. Cada vehículo posee características como marca, modelo, año, tipo, capacidad, ciudad donde se encuentra, estado y tarifa de alquiler.

### Clientes y tipos de usuarios
La plataforma contempla diferentes tipos de usuarios, entre ellos:

*- Clientes ocasionales.*

*- Clientes con membresía.*

*- Clientes empresariales.*

*- Administradores del sistema.*

Cada tipo de usuario puede tener diferentes permisos, beneficios y tarifas.

### Membresías
Son planes que ofrecen beneficios adicionales a los clientes, como descuentos, prioridad en reservas, acceso a categorías especiales de vehículos o tarifas preferenciales.

### Tarifas y precios
Corresponden al costo del alquiler de un vehículo. Estas tarifas pueden variar según:

*- Tipo de vehículo.*

*- Ciudad.*

*- Duración del alquiler.*

*- Temporada.*

*- Tipo de membresía del cliente.*

### Disponibilidad
Indica si un vehículo puede ser reservado en un período específico. Depende del estado del vehículo y de las reservas previamente registradas.

### Sucursales o ciudades
La plataforma opera en diferentes ciudades del país, por lo que cada vehículo debe estar asociado a una ubicación desde donde puede ser reservado o devuelto.

### Contrato de alquiler
Documento que formaliza el alquiler entre la empresa y el cliente, especificando condiciones, fechas, costos, responsabilidades y estado del vehículo.

### Integridad de los datos
Principio fundamental de las bases de datos relacionales que garantiza que la información almacenada sea correcta, consistente y libre de duplicidades mediante restricciones y relaciones entre tablas.

