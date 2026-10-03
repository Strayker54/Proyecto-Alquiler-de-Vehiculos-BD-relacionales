# Plataforma de Gestión de Alquiler de Vehículos

<p align="center">
  <img src="portada.jpg" alt="Plataforma de Gestión de Alquiler de Vehículos" width="800">
</p>

## Integrantes

- Angie Nicole Boada Mogollón — 2243672
- Andrés Santiago Marín Forero  — 2243556
- Anthoni Lexandre Hernández Diaz - 2191198
- Laura Valentina Ortiz Villamizar — 2243553

## Descripción del Proyecto

Este repositorio contiene el desarrollo de una base de datos relacional orientada a la gestión operativa de una plataforma nacional de reserva y alquiler de vehículos. El sistema está diseñado para resolver problemáticas críticas del sector mediante la automatización y centralización de datos, garantizando el control de disponibilidad en tiempo real para evitar la sobre-reserva, la gestión logística del mantenimiento de la flota y la administración segmentada de clientes (ocasionales y empresariales) junto con sus pólizas y membresías.

## Diseño

1. **Diseño Conceptual:** Formulación del problema mediante el Modelo Entidad-Relación (E-R) extendido. Se identificaron y modelaron entidades fuertes, entidades débiles, agregaciones complejas (flujo de alquiler) y jerarquías de especialización exclusivas.
2. **Diseño Lógico y Normalización:** Transformación algorítmica del modelo conceptual a un Modelo Relacional. Posteriormente, el diseño fue cambiado en base a la Teoría de la Normalización, estructurando el modelo hasta la **Tercera Forma Normal (3FN)**. Este proceso garantizó la atomicidad de los atributos, elimino las dependencias transitivas y parciales, y obtuvo integridad referencial sin pérdida de información.

## Arquitectura del Repositorio

La documentación, los diccionarios de datos y los diagramas arquitectónicos se encuentran distribuidos en los siguientes directorios estructurales:

### 📁 1. [Modelo E-R](./Modelo%20E-R)
Agrupa la especificación de requisitos, el estado del arte y los esquemas semánticos de la primera fase del proyecto.
* 📄 [Contexto del problema](./Modelo%20E-R/01-Contexto-del-Problema.md)
* 📄 [Tendencias actuales](./Modelo%20E-R/02-Tendencias-Actuales.md)
* 📄 [Herramientas y sistemas similares](./Modelo%20E-R/03-Herramientas-y-Sistemas-Similares.md)
* 📄 [Especificación y justificación del Modelo E-R Extendido](./Modelo%20E-R/04-Modelo-ER-Extendido.md)
* 📓 **[Notebook Fase 1: Análisis y Modelado Conceptual](./Modelo%20E-R/Proyecto_Alquiler_de_Vehiculos_BD_relacionales.ipynb)**
* 🖼️ *Diagramas:* [Primer Modelo Base](./Modelo%20E-R/Primer_Modelo_E-R.jpeg) | [Modelo Extendido Final](./Modelo%20E-R/Modelo_E-R_extendido.jpg)

### 📁 2. [Modelo Relacional](./Modelo%20Relacional) (Normalización)
Contiene la arquitectura lógica, la especificación de dominios (diccionario de datos) y la justificación técnica de las formas normales.
* 📓 **[Notebook Fase 2: Diccionario de Datos e Informe de Normalización (1FN, 2FN, 3FN)](./Modelo%20Relacional/Proyecto_Alquiler_2da_entrega_modelo_relacional.ipynb)**
* 🖼️ *Diagramas Lógicos:* [Esquema Inicial (Sin Normalizar)](./Modelo%20Relacional/Modelo%20Relacional%20sin%20Normalizar.png) | [Esquema Relacional Estructurado en 3FN](./Modelo%20Relacional/Modelo%20Relacional%20Normalizado.png)