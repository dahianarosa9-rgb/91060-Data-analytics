# RetailPro | Análisis y optimización de datos de ventas

## 1. Descripción del proyecto

**RetailPro** es un proyecto de análisis y optimización de datos comerciales cuyo objetivo es transformar datos transaccionales en información útil para la toma de decisiones de negocio.

A través de SQL Server se realiza la consulta, integración y transformación de datos provenientes de distintas tablas relacionales. Posteriormente, mediante Power BI, se busca desarrollar visualizaciones e indicadores que permitan analizar el desempeño comercial e identificar oportunidades de mejora.

El proyecto integra dos etapas principales:

- **Análisis y preparación de datos:** utilización de SQL para consultar, relacionar y estructurar la información.
- **Visualización y análisis de negocio:** utilización de Power BI para construir indicadores y reportes que faciliten la interpretación de los resultados.

## 2. Objetivos

- Integrar información de ventas, clientes, productos y categorías.
- Desarrollar consultas SQL para el análisis de datos comerciales.
- Optimizar consultas y evaluar oportunidades de mejora en el rendimiento.
- Construir vistas que faciliten la explotación de los datos.
- Analizar indicadores clave de desempeño (KPIs).
- Identificar tendencias y oportunidades comerciales.
- Desarrollar visualizaciones interactivas en Power BI.

## 3. Herramientas utilizadas

| Herramienta | Aplicación |
|---|---|
| **SQL Server** | Gestión de la base de datos, consultas, integración y transformación de datos. |
| **Power BI** | Análisis, visualización de indicadores y desarrollo de dashboards interactivos. |

## 4. Estructura del repositorio

El repositorio se organiza para separar los scripts SQL, los archivos de visualización y la documentación del proyecto.

```text
RetailPro/
│
├── README.md
│
├── SQL/
│   ├── ventas_tech_db.sql
│   ├── m4_consultas_negocio.sql
│   ├── m5_consultas_joins.sql
│   
│
├── PowerBI/
│   └── Pipeline_ETL_Rosa_Dahiana.pbix
 └── Rosa_Dahiana_Checkpoint2.pbix

```

### Descripción de las carpetas

- **SQL/**: contiene los scripts necesarios para crear y poblar la base de datos, así como las consultas de análisis y las vistas utilizadas en el proyecto.
- **PowerBI/**: contiene el archivo `.pbix` con los informes y visualizaciones desarrollados.
- **Documentacion/**: contiene documentación complementaria sobre el desarrollo, las consultas y los resultados obtenidos.
- **README.md**: documento principal con la descripción del proyecto y las instrucciones de ejecución.

*Nota: la estructura y los nombres de archivos presentados son orientativos y deben ajustarse a la organización definitiva del repositorio.*

## 5. Modelo de datos

La base de datos de RetailPro utiliza un modelo relacional compuesto por cuatro tablas principales:

| Tabla | Descripción |
|---|---|
| `ventas` | Contiene los registros de ventas, fechas, cantidades y precios unitarios. |
| `clientes` | Almacena la información de los clientes. |
| `productos` | Contiene los productos comercializados y su categoría asociada. |
| `categorias` | Almacena las categorías de productos. |

### Relaciones entre tablas

- `ventas.id_cliente` → `clientes.id_cliente`
- `ventas.id_producto` → `productos.id_producto`
- `productos.id_categoria` → `categorias.id_categoria`

Estas relaciones permiten integrar la información transaccional con los atributos de clientes y productos para realizar análisis comerciales.

## 6. Guía de instalación y ejecución

### 6.1. Requisitos previos

Para ejecutar el proyecto se necesita:

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS).
- Git instalado en el equipo.
- Power BI Desktop (para visualizar los informes).

### 6.2. Clonar el repositorio

Abrir una terminal (CMD, PowerShell o Git Bash) y ejecutar:

```bash
git clone https://github.com/USUARIO/RetailPro.git
```

Reemplazar `USUARIO` por el nombre de usuario o la organización correspondiente en GitHub.

Ingresar al directorio del proyecto:

```bash
cd RetailPro
```

### 6.3. Conectarse a SQL Server

1. Abrir SQL Server Management Studio.
2. Conectarse a la instancia de SQL Server correspondiente.
3. Verificar que la conexión se haya establecido correctamente.
4. Abrir los archivos SQL desde la carpeta `SQL/`.

### 6.4. Ejecutar los scripts SQL

Los scripts deben ejecutarse respetando el siguiente orden:

| Orden | Archivo | Descripción |
|---|---|---|
| 1 | `ventas_tech_db.sql` | Crea la base de datos RetailPro. |
| 2 | `m4_consultas_negocio.sql` | Crea las tablas y define las relaciones. |
| 3 | `m5_consultas_joins.sql` | Ejecuta consultas para analizar el comportamiento de las ventas. |
**Importante:** ejecutar cada script individualmente y verificar que finalice correctamente antes de continuar con el siguiente.

### 6.5. Validar la carga de datos

Una vez finalizada la ejecución, se recomienda verificar que las tablas contengan registros.

Ejemplo de consulta de validación:

```sql
USE RetailPro;
GO

SELECT COUNT(*) AS total_ventas
FROM dbo.ventas;

SELECT COUNT(*) AS total_clientes
FROM dbo.clientes;

SELECT COUNT(*) AS total_productos
FROM dbo.productos;

SELECT COUNT(*) AS total_categorias
FROM dbo.categorias;
```

### 6.6. Conectar Power BI con SQL Server

Para visualizar los resultados del análisis:

1. Abrir Power BI Desktop.
2. Seleccionar **Inicio → Obtener datos → SQL Server**.
3. Ingresar el nombre del servidor y la base de datos `ventas_tech_db`.
4. Seleccionar el modo de conectividad: Importar o DirectQuery, según las necesidades del análisis.
5. Seleccionar las tablas o vistas analíticas que se utilizarán.
6. Verificar las relaciones entre las tablas.
7. Desarrollar las visualizaciones y los indicadores correspondientes.

Una vez finalizado el desarrollo, guardar el archivo de Power BI en la carpeta `PowerBI/`.

## 7. Indicadores clave de desempeño (KPIs)

Para analizar el comportamiento de las ventas y evaluar el desempeño comercial de RetailPro, se desarrollaron las siguientes medidas en Power BI:

| KPI | Descripción |
|---|---|
| **Total Ventas** | Representa el importe total de las ventas realizadas en el período seleccionado. |
| **Ventas LY (Last Year)** | Permite conocer el total de ventas correspondiente al período comparable del año anterior. |
| **Ventas YTD (Year to Date)** | Calcula las ventas acumuladas desde el inicio del año hasta la fecha correspondiente al análisis. |
| **Ventas Online** | Representa el importe de las ventas realizadas a través del canal online. |
| **% Crecimiento Anual** | Mide la variación porcentual de las ventas respecto al período comparable del año anterior, permitiendo evaluar el crecimiento o decrecimiento del negocio. |

### Objetivo del análisis

Estos indicadores permiten realizar un seguimiento del desempeño comercial desde distintas perspectivas:

- **Desempeño general:** seguimiento de la facturación total.
- **Análisis temporal:** comparación de las ventas con períodos anteriores.
- **Evolución del negocio:** evaluación del crecimiento anual y de las ventas acumuladas en el año.
- **Análisis por canal:** seguimiento específico de las ventas online.

En conjunto, estas medidas permiten monitorear la evolución del negocio, identificar cambios en el comportamiento de las ventas y facilitar la toma de decisiones comerciales.

El análisis de estos indicadores permite identificar patrones de consumo, evaluar el desempeño de los productos y detectar oportunidades de mejora en la gestión comercial.

## 8. Resultados esperados

A partir de la integración y el análisis de los datos, se busca:

- Obtener una visión consolidada del desempeño comercial.
- Identificar los productos con mayor contribución a la facturación.
- Detectar diferencias entre volumen de unidades vendidas e ingresos generados.
- Analizar el comportamiento mensual de las ventas.
- Facilitar la identificación de oportunidades comerciales.
- Transformar los datos en información relevante para la toma de decisiones.

## 9. Autoría y propósito

**Proyecto:** RetailPro – Análisis y optimización de datos de ventas.

**Herramientas:** Microsoft SQL Server y Power BI.

**Objetivo:** desarrollar un flujo de trabajo de análisis de datos y Business Intelligence que permita transformar información transaccional en conocimiento útil para la gestión comercial.

---

*Proyecto desarrollado con fines educativos y de aplicación práctica de herramientas de análisis de datos y Business Intelligence.*
