## Information Architecture

Las decisiones de arquitectura de información de WoodRoute están orientadas a dos
experiencias distintas con objetivos complementarios: la landing page, enfocada en
convertir visitantes en usuarios, y la aplicación web, enfocada en que carpinteros
gestionen su taller con la menor fricción posible. En ambos casos, el principio rector
es que el usuario encuentre lo que necesita sin esfuerzo y sin necesidad de instrucción.

### Organization Systems

El contenido de WoodRoute se organiza según el contexto de uso de cada superficie.

**Landing Page — organización secuencial y jerárquica**

La landing page sigue una organización **secuencial** (step-by-step): el visitante
recorre una narrativa de problema → solución → beneficios → prueba social → acción.
Cada sección responde a una pregunta implícita del visitante antes de que la formule.
El orden no es arbitrario: primero se valida el dolor (el caos del taller), luego se
presenta la solución, luego se justifica la confianza. Esta progresión reduce la
resistencia a la conversión.

Dentro de cada sección, la organización es **jerárquica**: el mensaje principal ocupa
el nivel tipográfico más alto, los detalles de soporte están en niveles inferiores y las
acciones secundarias nunca compiten visualmente con el CTA primario.

**Aplicación web — organización por tópicos y por audiencia**

La aplicación organiza el contenido **por tópicos funcionales** que mapean directamente
al flujo de trabajo del carpintero:

| Módulo | Tópico | Audiencia |
|---|---|---|
| Pedidos | Gestión del ciclo de vida de un pedido | Carpintero |
| Inventario | Control de materiales y stock | Carpintero |
| Planificación | Viabilidad, tiempos y capacidad | Carpintero |
| Seguimiento | Estado de producción en tiempo real | Cliente final |

La organización **por audiencia** se aplica en el acceso: el carpintero entra con
credenciales propias y tiene acceso completo al sistema; el cliente accede mediante
un enlace compartido y ve únicamente la vista de seguimiento de su pedido, sin
necesidad de registro.

Dentro de los listados (pedidos, materiales), el contenido se organiza de forma
**cronológica inversa** por defecto: los elementos más recientes aparecen primero,
reflejando el flujo natural de trabajo donde el carpintero atiende los pedidos activos
antes que los históricos.

### Labeling Systems

Las etiquetas de WoodRoute siguen el principio de mínima carga cognitiva: una palabra
cuando es suficiente, dos cuando es necesario para evitar ambigüedad. Se usa el
vocabulario del carpintero, no el vocabulario técnico del software.

**Navegación principal de la aplicación:**

| Etiqueta | Concepto que representa |
|---|---|
| Pedidos | Listado y gestión de órdenes de fabricación |
| Inventario | Stock de materiales disponibles |
| Planificación | Asistente de viabilidad y estimación de tiempos |
| Clientes | Directorio de clientes y sus pedidos asociados |
| Configuración | Datos del taller, usuarios y preferencias |

**Estados de un pedido:**

| Etiqueta | Significado |
|---|---|
| Pendiente | Pedido recibido, aún no iniciado |
| En producción | Fabricación en curso |
| En revisión | Control de calidad antes de entrega |
| Listo | Pedido terminado, pendiente de entrega o retiro |
| Entregado | Proceso completado |

**Inventario:**

| Etiqueta | Significado |
|---|---|
| Disponible | Material con stock suficiente |
| Stock bajo | Material cerca del mínimo definido |
| Sin stock | Material agotado, bloquea nuevos pedidos |

**Landing page (secciones visibles en navegación):**

| Etiqueta | Contenido |
|---|---|
| Inicio | Hero y propuesta de valor |
| Funciones | Features del producto |
| Cómo funciona | Flujo paso a paso |
| Precios | Planes y comparativa |
| Preguntas frecuentes | FAQ |

### SEO Tags and Meta Tags

**Landing Page**

```html
<title>WoodRoute — Gestión de pedidos y taller para carpinteros</title>
<meta name="description"
  content="WoodRoute organiza tu taller de carpintería: gestiona pedidos,
  controla materiales y ofrece seguimiento en tiempo real a tus clientes.
  Empieza gratis." />
<meta name="keywords"
  content="gestión de taller, software para carpinteros, control de pedidos
  carpintería, inventario madera, seguimiento de pedidos, SaaS carpintería" />
<meta name="author" content="WoodRoute" />
<meta property="og:title" content="WoodRoute — Gestión de taller para carpinteros" />
<meta property="og:description"
  content="Organiza tus pedidos, controla tu inventario y mantén a tus clientes
  informados en tiempo real. Sin complicaciones." />
<meta property="og:type" content="website" />
```

**Aplicación web (página de login / acceso)**

```html
<title>Ingresar — WoodRoute</title>
<meta name="description"
  content="Accede a tu cuenta de WoodRoute para gestionar tu taller de carpintería." />
<meta name="robots" content="noindex, nofollow" />
<meta name="author" content="WoodRoute" />
```

**Vista de seguimiento pública (compartida con clientes)**

```html
<title>Seguimiento de pedido — WoodRoute</title>
<meta name="description"
  content="Consulta el estado de fabricación de tu mueble en tiempo real." />
<meta name="robots" content="noindex, nofollow" />
```

Las páginas internas de la aplicación (pedidos, inventario, planificación) usan
`noindex, nofollow` ya que son contenido privado detrás de autenticación. Solo la
landing page está indexada para motores de búsqueda.

### Searching Systems

WoodRoute ofrece búsqueda y filtrado en los módulos donde el volumen de información
puede desorientar al usuario. El sistema no expone un buscador global: cada módulo
tiene su propio mecanismo de búsqueda contextual.

**Módulo de Pedidos**

El usuario puede buscar por nombre de cliente, número de pedido o descripción del
mueble. Los resultados se muestran en tiempo real (búsqueda reactiva sin necesidad
de enviar el formulario). Los filtros disponibles son:

| Filtro | Opciones |
|---|---|
| Estado | Pendiente / En producción / En revisión / Listo / Entregado |
| Fecha de creación | Rango de fechas |
| Cliente | Selección desde directorio |

Los resultados muestran: nombre del cliente, descripción del mueble, estado actual
(con etiqueta de color) y fecha estimada de entrega.

**Módulo de Inventario**

El usuario puede buscar materiales por nombre o tipo. Los filtros disponibles son:

| Filtro | Opciones |
|---|---|
| Estado de stock | Disponible / Stock bajo / Sin stock |
| Tipo de material | Madera / Herrajes / Acabados / Otros |

Los resultados muestran: nombre del material, unidad de medida, cantidad disponible
y estado de stock (con etiqueta de color). Los materiales con stock bajo aparecen
destacados al inicio del listado sin necesidad de filtrar, como alerta proactiva.

**Módulo de Clientes**

Búsqueda por nombre o contacto. Sin filtros adicionales dado el volumen acotado
esperado en talleres pequeños. Los resultados muestran nombre, contacto y cantidad
de pedidos activos.

**Vista de seguimiento pública**

No requiere búsqueda: el cliente accede mediante un enlace único que lleva directamente
al estado de su pedido. No hay navegación ni descubrimiento de contenido en esta vista.

### Navigation Systems

**Landing Page**

La navegación de la landing sigue un modelo de **scroll lineal con anclas**: el menú
superior fija las secciones principales y permite saltar directamente a cualquier punto.
En mobile, el menú colapsa en un panel lateral (hamburguesa). El CTA principal
("Empieza gratis") está fijo en el navbar para que esté siempre accesible sin importar
la posición del scroll.

El flujo de navegación esperado es:

```
Navbar → Hero → Funciones → Cómo funciona → Precios → FAQ → CTA final
```

Los usuarios que llegan con intención directa (ej. desde un anuncio) aterrizan en el
hero y pueden ir directo al CTA. Los usuarios exploratorios recorren las secciones de
forma descendente. Ambos flujos convergen en el mismo punto de conversión.

**Aplicación web**

La aplicación usa una **navegación lateral persistente** (sidebar) en desktop y una
**barra inferior** en mobile, siguiendo convenciones establecidas de aplicaciones de
gestión que el usuario ya conoce.

El sidebar muestra los cinco módulos principales con íconos y etiquetas. El módulo
activo se indica con el color primario. Las acciones de creación (nuevo pedido, nuevo
material) están disponibles desde un botón prominente dentro de cada módulo, no
desde la navegación global.

La jerarquía de navegación es de dos niveles máximo:

```
Nivel 1 (sidebar): Pedidos / Inventario / Planificación / Clientes / Configuración
Nivel 2 (dentro del módulo): Listado → Detalle / Formulario de creación o edición
```

No existe un nivel 3. Si una acción requeriría un tercer nivel, se implementa como
modal o panel lateral (drawer) sobre el nivel 2 actual, manteniendo el contexto del
usuario visible.

**Vista de seguimiento pública**

Es una experiencia de una sola página sin navegación. El cliente ve el estado actual
del pedido, el historial de estados anteriores y los datos del mueble. No hay menú,
no hay links a otras secciones, no hay posibilidad de confundirse. El único punto de
salida opcional es un link al sitio de WoodRoute para que el cliente conozca el producto.

