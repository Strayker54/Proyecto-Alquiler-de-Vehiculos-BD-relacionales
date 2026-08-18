#  Modelo Entidad-Relación: Plataforma de Alquiler de Vehículos

---

## 1. Diagrama de la Base de Datos

A continuación se presenta el diagrama conceptual estructurado bajo la notación clásica de Peter Chen[cite: 4, 6]:

![Modelo Entidad-Relación - Alquiler de Vehículos](./Entidad%20Proyecto%20Carros.jpeg)

---

## 2. Notación y Estructura Técnica

| Elemento | Forma / Notación | Descripción y Aplicación en el Modelo |
| :--- | :--- | :--- |
| **Entidad Fuerte** | Rectángulo simple | Representa los conceptos principales del negocio (`Cliente`, `Vehiculo`, `Reserva`, etc.)[cite: 4, 6]. |
| **Relación** | Rombo | Describe las acciones de negocio entre entidades (`Realiza`, `Asigna`, etc.)[cite: 4, 6]. |
| **Atributo Simple** | Óvalo | Propiedad básica individual de una entidad o relación[cite: 4, 6]. |
| **Atributo Clave** | Óvalo con texto <u>subrayado</u> | Identificador único irrepetible (Clave Primaria / PK)[cite: 1, 4]. |
| **Atributo Compuesto** | Óvalo ramificado ("encapsulado") | Atributo divisible (`Contacto` $\rightarrow$ `Telefono`, `Correo`)[cite: 5]. |
| **Atributo Derivado** | Óvalo con borde punteado | Valor calculado (`Costo total` en `Contrato`)[cite: 4, 5]. |

---

## 3. Desglose de Entidades y Atributos

### 1. `Cliente` (Rectángulo)
* <u>`Id_cliente`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Nombre` → Óvalo simple[cite: 4].
* `Apellido` → Óvalo simple[cite: 4].
* `Documento` → Óvalo simple[cite: 4].
* `Tipo de usuario` → Óvalo simple *(Ocasional, Empresarial, Administrador)*[cite: 4].
* `Contacto` → **Atributo Compuesto ("Encapsulado"):** Óvalo del cual se desprenden `Telefono` y `Correo`[cite: 5].

### 2. `Membresia` (Rectángulo)
* <u>`Id_membresia`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Tipo` → Óvalo simple[cite: 4].
* `Beneficios` → Óvalo simple[cite: 4].
* `Descuento Asociado` → Óvalo simple[cite: 4].

### 3. `Vehiculo` (Rectángulo)
* <u>`Id vehiculo`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Marca` → Óvalo simple[cite: 4].
* `Modelo` → Óvalo simple[cite: 4].
* `Año` → Óvalo simple[cite: 4].
* `Tipo` → Óvalo simple[cite: 4].
* `Capacidad` → Óvalo simple[cite: 4].
* `Tarifa Base` → Óvalo simple[cite: 4].

### 4. `Sucursal` (Rectángulo)
* <u>`Id sucursal`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Ciudad` → Óvalo simple[cite: 4].
* `Direccion` → Óvalo simple[cite: 4].

### 5. `Reserva` (Rectángulo)
* <u>`Id_reserva`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Fecha Inicio` → Óvalo simple[cite: 4].
* `Fecha fin` → Óvalo simple[cite: 4].
* `Estado` → Óvalo simple *(Pendiente, Confirmado, Cancelado)*[cite: 4].

### 6. `Contrato` (Rectángulo)
* <u>`Id_contrato`</u> → Clave Primaria (Óvalo con texto <u>subrayado</u>)[cite: 1, 4].
* `Fecha firma` → Óvalo simple[cite: 4].
* `Condiciones` → Óvalo simple[cite: 4].
* `Costo total` → **Atributo Derivado:** Óvalo con borde punteado *(calculado según días de alquiler, tarifa base y descuento aplicado)*[cite: 4, 5].

---

## 4. Relaciones y Cardinalidades

* **`<Tiene>` (entre `Membresia` y `Cliente`):**
  * **Cardinalidad 1 : N** (Un plan de membresía puede pertenecer a varios clientes; un cliente se suscribe a una sola membresía activa)[cite: 4, 6].
* **`<Pertenece>` (entre `Vehiculo` y `Sucursal`):**
  * **Cardinalidad N : 1** (Un vehículo está asignado físicamente a una sucursal; una sucursal administra múltiples vehículos)[cite: 4, 6].
* **`<Realiza>` (entre `Cliente` y `Reserva`):**
  * **Cardinalidad 1 : N** (Un cliente puede generar varias reservas; cada reserva le pertenece a un solo cliente)[cite: 4, 6].
* **`<Asigna>` (entre `Reserva` y `Vehiculo`):**
  * **Cardinalidad N : 1** (Una reserva asigna un único vehículo; un vehículo puede tener múltiples reservas en distintas fechas)[cite: 4, 6].
* **`<Formaliza>` (entre `Contrato` y `Reserva`):**
  * **Cardinalidad 1 : 1** (Una reserva confirmada formaliza un contrato único de alquiler)[cite: 4, 6].

---

## 💻 5. Código DDL

```mermaid
erDiagram
    MEMBRESIA ||--o{ CLIENTE : TIENE
    SUCURSAL ||--o{ VEHICULO : PERTENECE
    CLIENTE ||--o{ RESERVA : REALIZA
    VEHICULO ||--o{ RESERVA : ASIGNA
    RESERVA ||--|| CONTRATO : FORMALIZA

    CLIENTE {
        string Id_cliente PK "Clave Primaria Subrayada"
        string Nombre
        string Apellido
        string Documento
        string Tipo_de_usuario
        string Contacto "Atributo Compuesto (Telefono, Correo)"
    }

    MEMBRESIA {
        string Id_membresia PK "Clave Primaria Subrayada"
        string Tipo
        string Beneficios
        float Descuento_Asociado
    }

    VEHICULO {
        string Id_vehiculo PK "Clave Primaria Subrayada"
        string Marca
        string Modelo
        int Anio
        string Tipo
        int Capacidad
        float Tarifa_Base
    }

    SUCURSAL {
        string Id_sucursal PK "Clave Primaria Subrayada"
        string Ciudad
        string Direccion
    }

    RESERVA {
        string Id_reserva PK "Clave Primaria Subrayada"
        string Fecha_Inicio
        string Fecha_fin
        string Estado
    }

    CONTRATO {
        string Id_contrato PK "Clave Primaria Subrayada"
        string Fecha_firma
        string Condiciones
        float Costo_total "Atributo Derivado"
    }
```