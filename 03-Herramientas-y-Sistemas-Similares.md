
## 3. Consulta de Herramientas Similares y Análisis Comparativo

Se analizaron dos de los sistemas más representativos del mercado para la gestión integral de flotas y alquileres (*HQ Rental Software* y *Rent Centric*), comparando sus funcionalidades clave contra la propuesta de diseño de nuestro sistema.

| Funcionalidad / Módulo | HQ Rental Software | Rent Centric | Propuesta de Modelo Relacional (Nuestro Sistema) |
| :--- | :--- | :--- | :--- |
| **Gestión de Reservas y Alquileres** | Motor en línea con sincronización de canales de venta (*Expedia*, *Turo*). | Autoservicio $24/7$ para reservas y pagos digitales. | Soportado mediante la **Agregación `AlquilerEfectivo`** entre `CLIENTE`, `VEHICULO` y `RESERVA`. |
| **Control de Flotas Especializadas** | Seguimiento por fotografías, inspecciones y estados de entrega. | Soporte multivehículo (autos, motos, vehículos de suscripción). | Jerarquía de especialización disjunta: `AUTOMOVIL`, `VANCARGA` y `VEHICULO_ELECTRICO`. |
| **Mantenimiento y Talleres** | Control de mantenimientos preventivos y correctivos. | Operaciones de oficina (*back office*) y control de inventario. | Relación de entidad débil entre `SUCURSAL` y `TALLER_INTERNO` ($1:N$). |
| **Gestión de Clientes y Fidelización** | Perfiles de usuario con historial de facturación. | Comercialización de servicios adicionales y marketing. | Modelado de clientes empresariales/ocasionales y relación reflexiva `RECOMIENDA`. |
| **Formalización Contractual** | Generación de contratos digitales con firma electrónica. | Administración de contratos y coberturas de seguros. | Entidad `CONTRATO` formalizada desde la agregación y vinculada $N:M$ a `POLIZA_SEGURO`. |

### Análisis Breve
Mientras que *HQ Rental* y *Rent Centric* ofrecen soluciones integrales enfocadas en la interfaz comercial e integración con pasarelas de pago, nuestro modelo relacional prioriza la **integridad referencial**, la eliminación de redundancias mediante la **tercera forma normal (3FN)** y una estructura robusta para validar la disponibilidad en tiempo real mediante agregación.
