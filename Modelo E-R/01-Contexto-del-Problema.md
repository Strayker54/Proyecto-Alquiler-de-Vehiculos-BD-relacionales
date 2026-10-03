
## 1. Contexto del Problema y Justificación

### Descripción del Escenario Operativo
La empresa de alquiler de vehículos se enfrenta a un escenario de crecimiento operativo acelerado que sobrepasa sus capacidades de gestión manuales o semi-automatizadas. Actualmente, el flujo operativo depende de procesos descentralizados, lo que genera inconsistencias críticas en el manejo de la información transaccional y de la flota.

### Problemáticas Principales Identificadas

* **Inconsistencia en Reservas y Disponibilidad:** Falta de validación en tiempo real que causa sobre-reservas (*overbooking*) o la asignación de vehículos no disponibles (por estar en mantenimiento preventivo o en tránsito entre sucursales).
* **Descontrol en la Flota Diversificada:** Incapacidad de gestionar eficientemente las especificaciones únicas de cada segmento de vehículo (ej. tiempos e infraestructura de carga para vehículos eléctricos, límites de tonelaje para vans de carga y especificaciones técnicas para automóviles particulares).
* **Gestión Deficiente de Clientes y Beneficios:** Dificultad para segmentar adecuadamente el comportamiento de clientes ocasionales frente a empresariales, impidiendo aplicar reglas de negocio para descuentos corporativos o programas de referidos (`RECOMIENDA`).
* **Falta de Trazabilidad Contractual y Mantenimiento:** Pérdida de seguimiento a los contratos activos, seguros vinculados y registros operativos de los talleres internos de cada sucursal.

### Objetivo del Proyecto
Diseñar e implementar un sistema de base de datos relacional modelado en tercera forma normal (3FN) y soportado por un diagrama E-R extendido. Este sistema centralizará la gestión de flotas, controlará la disponibilidad en tiempo real mediante la integración de la agregación `AlquilerEfectivo` y garantizará la integridad referencial en el ciclo de vida del alquiler.
