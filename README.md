<p align="center">
  <img src="portada.jpg" alt="Plataforma de Gestión de Alquiler de Vehículos" width="800">
</p>

# Plataforma de Gestión de Alquiler de Vehículos

## Integrantes

- Angie Nicole Boada Mogollón — 2243672
- Andrés Santiago Marín Forero — 2243556
- Anthoni Lexandre Hernández Díaz - 2191198
- Laura Valentina Ortiz Villamizar — 2243553

## Descripción del Proyecto

Este proyecto corresponde al desarrollo integral de una base de datos relacional para la operación, control logístico y administración comercial de una empresa de alquiler de vehículos con cobertura nacional en Colombia.

El sistema resuelve las problemáticas operativas identificadas en el sector: evita la sobrerreserva (*overbooking*) y las fallas de disponibilidad mediante la agregación del alquiler efectivo, administra de forma independiente las especificaciones técnicas de flotas heterogéneas (automóviles particulares, vans de carga, vehículos eléctricos y gama premium), controla las órdenes de mantenimiento y repuestos en talleres, y gestiona clientes tanto ocasionales como corporativos junto con sus membresías, contratos y pólizas de seguro.

## Metodología y Evolución del Modelo

El desarrollo del proyecto se estructuró en tres fases técnicas consecutivas:

1. **Modelado Conceptual (Modelo E-R Extendido):**
   Analizamos los requisitos del negocio e identificamos entidades fuertes, especializaciones totales y disjuntas para `CLIENTE` (ocasional y empresarial) y `VEHICULO` (automóvil, van de carga, eléctrico y premium), la dependencia de talleres respecto a las sucursales, y la agregación ternaria `AlquilerEfectivo` conectando Cliente, Vehículo y Reserva. Sobre esta agregación se formaliza el `CONTRATO` y sus amparos con `POLIZA_SEGURO`. Además, se incluyó la relación reflexiva `RECOMIENDA` para modelar programas de referidos.

2. **Diseño Lógico y Proceso de Normalización (Hasta 3FN):**
   Realizamos la transformación algorítmica al esquema relacional adoptando decisiones clave: uso del `VIN` como clave primaria inmutable para vehículos en lugar de placas, creación de la clave subrogada `IdAlquiler` para desacoplar transacciones, e independización de talleres para admitir aliados externos.
   Posteriormente, aplicamos la teoría de normalización:
   - **1FN:** Eliminamos atributos compuestos dividiendo `Direccion_Compuesta` en `Ciudad`, `Barrio` y `Calle`, y extrajimos el atributo multivaluado `Telefonos` a la tabla dependiente `CLIENTE_TELEFONO`.
   - **2FN:** Verificamos que en las relaciones con claves primarias compuestas (`CONTRATA` y `CLIENTE_TELEFONO`) no existan dependencias funcionales parciales.
   - **3FN:** Eliminamos dependencias transitivas aislando datos de talleres en la tabla `TALLER`, especializando la flota en tablas hijas para suprimir campos nulos, y desacoplando contratos de especificaciones técnicas vehiculares mediante la agregación `ALQUILER_EFECTIVO`. El esquema resultante cuenta con 19 tablas en 3FN.

3. **Implementación Física y Validación SQL (SQLite):**
   Construimos la base de datos relacional en SQLite activando la integridad referencial (`PRAGMA foreign_keys = ON;`). Poblamos el modelo con datos realistas ambientados en Bucaramanga, Bogotá, Medellín, Cali y Barranquilla, garantizando al menos 5 registros por tabla y respetando la jerarquía de herencia (12 clientes y 20 vehículos en las tablas padre). Finalmente, implementamos 10 consultas SQL analíticas con JOINs, agrupaciones, subconsultas y funciones agregadas para responder a requerimientos estratégicos del negocio.

## Estructura y Navegación del Repositorio

El repositorio se organiza en tres directorios de trabajo correspondientes a las etapas del proyecto:

### 1. [Modelo E-R](./Modelo%20E-R)
Contiene la documentación inicial, el análisis del problema, el estado del arte y los diagramas conceptuales:
- [Contexto del Problema y Justificación](./Modelo%20E-R/01-Contexto-del-Problema.md)
- [Tendencias Actuales del Sector](./Modelo%20E-R/02-Tendencias-Actuales.md)
- [Herramientas Similares y Análisis Comparativo](./Modelo%20E-R/03-Herramientas-y-Sistemas-Similares.md)
- [Especificación del Modelo E-R Extendido](./Modelo%20E-R/04-Modelo-ER-Extendido.md)
- [Notebook Fase 1: Análisis y Modelado Conceptual](./Modelo%20E-R/Proyecto_Alquiler_de_Vehiculos_BD_relacionales.ipynb)
- [Diagrama Conceptual: Primer Modelo Base](./Modelo%20E-R/Primer_Modelo_E-R.jpeg)
- [Diagrama Conceptual: Modelo Extendido Final](./Modelo%20E-R/Modelo_E-R_extendido.jpg)

### 2. [Modelo Relacional](./Modelo%20Relacional)
Contiene la transformación lógica, los diccionarios de datos y la justificación técnica de las tres primeras formas normales:
- [Notebook Fase 2: Diccionario de Datos e Informe de Normalización (1FN, 2FN, 3FN)](./Modelo%20Relacional/Proyecto_Alquiler_2da_entrega_modelo_relacional.ipynb)
- [Diagrama Lógico: Esquema Inicial sin Normalizar](./Modelo%20Relacional%20Sin%20Normalizar%20final.png)
- [Diagrama Lógico: Esquema Normalizado en 3FN](./Modelo%20Relacional/Modelo%20Relacional%20Normalizado.png)

### 3. [Proyecto Final](./Proyecto%20Final)
Consolida la entrega final definitiva del curso para la sustentación:
- [Notebook de Sustentación Final: Puntos 1 al 6 Consolidados](./Proyecto%20Final/Proyecto_Final_Alquiler_Vehiculos.ipynb)
- [Base de Datos SQLite: archivo físico](./Proyecto%20Final/alquiler_vehiculos.db)
- [Script SQL Completo: DDL, DML y 10 Consultas](./Proyecto%20Final/esquema_y_consultas.sql)
