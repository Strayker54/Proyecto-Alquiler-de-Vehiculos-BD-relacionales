# Plataforma de Gestión de Alquiler de Vehículos

<p align="center">
  <img src="portada.jpg" alt="Plataforma de Gestión de Alquiler de Vehículos" width="800">
</p>

## Integrantes
- Angie Nicole Boada Mogollón — 2243672
- Andrés Santiago Marín Forero  — 2243556
- Anthoni Lexandre Hernández Diaz - 2191198
- Laura Valentina Ortiz Villamizar — 2243553

---

## 📌 Descripción del Proyecto

**Objetivo General (Instrucción inicial):**
> *Desarrollar una base de datos relacional para una plataforma de reserva y alquiler de diferentes tipos de vehículos, presentes en varias ciudades del país. La plataforma cuenta con diferentes tipos de usuarios, desde ocasionales hasta empresariales, y también precios y membresías para los diferentes vehículos.*

Este repositorio contiene el desarrollo completo de la base de datos relacional orientada a la gestión operativa de esta plataforma, abarcando desde el análisis conceptual hasta la implementación final en SQL, carga de datos y consultas.

---

## 📂 Estructura del Proyecto (Contenido de la Presentación)

La documentación, diagramas y código se han estructurado siguiendo las fases de desarrollo y presentación del proyecto final:

### 1. Análisis de la Situación
Resolución de problemáticas críticas del sector mediante la automatización y centralización de datos, garantizando el control de disponibilidad en tiempo real (para evitar sobre-reservas), la gestión logística del mantenimiento de la flota y la administración segmentada de clientes (ocasionales y empresariales) junto con sus pólizas y membresías.
- 📄 [Contexto del problema](./Modelo%20E-R/01-Contexto-del-Problema.md)
- 📄 [Tendencias actuales](./Modelo%20E-R/02-Tendencias-Actuales.md)
- 📄 [Herramientas y sistemas similares](./Modelo%20E-R/03-Herramientas-y-Sistemas-Similares.md)

### 2. Modelo Entidad - Relación (Conceptual)
Formulación del problema mediante el Modelo Entidad-Relación (E-R) extendido. Se identificaron y modelaron entidades fuertes, débiles, agregaciones complejas (flujo de alquiler) y jerarquías de especialización exclusivas.
- 📄 [Especificación y justificación del Modelo E-R Extendido](./Modelo%20E-R/04-Modelo-ER-Extendido.md)
- 📓 **[Notebook Fase 1: Análisis y Modelado Conceptual](./Modelo%20E-R/Proyecto_Alquiler_de_Vehiculos_BD_relacionales.ipynb)**
- 🖼️ *Diagramas:* [Primer Modelo Base](./Modelo%20E-R/Primer_Modelo_E-R.jpeg) | [Modelo Extendido Final](./Modelo%20E-R/Modelo_E-R_extendido.jpg)

### 3. Modelo Relacional y su Normalización
Transformación algorítmica del modelo conceptual a un Modelo Relacional y su estructuración hasta la **Tercera Forma Normal (3FN)**. Esto garantizó la atomicidad de los atributos, eliminó dependencias transitivas/parciales y aseguró la integridad referencial.
- 📓 **[Notebook Fase 2: Diccionario de Datos e Informe de Normalización](./Modelo%20Relacional/Proyecto_Alquiler_2da_entrega_modelo_relacional.ipynb)**
- 🖼️ *Diagramas Lógicos:* [Esquema Inicial (Sin Normalizar)](./Modelo%20Relacional/Modelo%20Relacional%20sin%20Normalizar.png) | [Esquema Relacional Estructurado en 3FN](./Modelo%20Relacional/Modelo%20Relacional%20Normalizado.png)

### 4. Base de Datos construida en SQL (Esquema)
Script DDL (Data Definition Language) con la creación de las tablas, restricciones (`PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `UNIQUE`), tipos de datos definitivos y relaciones establecidas en el esquema 3FN.
- 💾 *[Enlace al script SQL / Notebook de creación de esquema]* *(Nota: Agrega aquí el enlace a tu archivo .sql o sección del notebook)*

### 5. Carga de Datos al Modelo
Script DML (Data Manipulation Language) que incluye la inserción (poblado) de datos de prueba para verificar la integridad de la base de datos. Se garantizan al menos **5 registros por tabla**, abarcando diferentes ciudades, tipos de vehículos, usuarios (ocasionales/empresariales), precios y membresías.
- 💾 *[Enlace al script SQL / Notebook de inserts]* *(Nota: Agrega aquí el enlace a tu archivo .sql)*

### 6. Consultas sobre la Base de Datos
Conjunto de 10 consultas SQL complejas orientadas a resolver preguntas de negocio pertinentes con la plataforma de alquiler (uso de `JOIN`s, subconsultas, agrupaciones y funciones de agregación).
- 📓 *[Enlace al Notebook de Presentación con las consultas ejecutadas]* *(Nota: Agrega aquí el enlace al notebook final)*
