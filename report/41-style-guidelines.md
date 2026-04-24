# Product Design

## Style Guidelines

### General Style Guidelines

#### Branding

La identidad visual de WoodRoute refleja los valores del producto: calidez, precisión y confianza.
Cada decisión de diseño está enraizada en el mundo del carpintero: la textura de la madera, la
calidez del material natural y la claridad de un proceso bien organizado.

El branding abarca la identidad completa de la marca: el logo, el sistema de colores, la tipografía,
el tono de comunicación y los principios que guían cómo el producto se ve, se siente y habla.
No es solo el logo, es la suma de todas las decisiones que hacen que WoodRoute sea reconocible
y coherente en cualquier punto de contacto con el usuario.

El logo combina un símbolo que evoca la veta de la madera con la idea de rutas o caminos,
representando el flujo de trabajo del taller. El wordmark utiliza la fuente de display del sistema
tipográfico en peso ExtraBold para transmitir solidez y presencia.

![Logo de WoodRoute](assets/logo-woodroute.png)

Los tres principios que guían todas las decisiones de diseño son:

**Calidez con contraste** — Los fondos y superficies usan tonos cálidos que evocan la madera
natural (beige, crema, marrón claro). El color primario de acción (`#FD4319`, naranja-rojo) rompe
intencionalmente esa calidez para señalizar con claridad qué debe hacer el usuario a continuación.
La tensión entre el fondo cálido y el CTA energético crea jerarquía visual sin necesidad de texto
adicional.

**Claridad funcional** — Los artesanos trabajan con las manos, no con pantallas. La interfaz elimina
el ruido visual y prioriza la información que importa: el estado del pedido, el inventario disponible,
la viabilidad del mueble.

**Confianza ganada** — WoodRoute no impone: acompaña. El diseño respeta el saber del carpintero.
No reemplaza su criterio, lo amplifica con datos.

#### Tono de comunicación

WoodRoute habla de carpintero a carpintero. No usa lenguaje corporativo ni tecnicismos innecesarios.
El tono está posicionado en cuatro dimensiones que definen la personalidad de la marca:

| Dimensión | Posición | Descripción |
|---|---|---|
| Divertido / Serio | 65% Serio | El producto resuelve problemas reales de negocio. El tono es directo y profesional, sin exceso de formalidad. |
| Formal / Casual | 60% Casual | Habla al carpintero como a un igual, sin jerarquía corporativa. Directo y accesible. |
| Respetuoso / Irreverente | 80% Respetuoso | Respeto profundo por el oficio. El carpintero es el experto; WoodRoute es su asistente. |
| Entusiasta / Sereno | 55% Sereno | Confianza tranquila. Los resultados hablan por sí solos, sin signos de exclamación vacíos. |

Las reglas de lenguaje derivadas de este posicionamiento son:

- Español neutro sin regionalismos ni voseo
- Imperativo universal: "Registra", "Selecciona", "Confirma"
- Mensajes de error directos y accionables: "Selecciona un material para continuar"
- Placeholders descriptivos: "¿Cuántos tablones necesitas?"
- Botones en infinitivo o imperativo neutro: "Crear pedido", "Ver inventario"
- Evitar exclamaciones vacías: "¡Genial!", "¡Listo!", "¡Perfecto!"

#### Sistema de colores

La paleta de WoodRoute combina dos decisiones visuales complementarias: fondos cálidos que
evocan la madera natural, y un color primario de acción fuerte y directo. Esta tensión entre
la calidez del fondo y la energía del primario crea jerarquía visual inmediata: el usuario sabe
exactamente dónde hacer clic.

Los tokens semánticos son el nivel de abstracción que conecta la paleta con los componentes.
La interfaz nunca referencia valores de color crudos: siempre usa tokens.

![Paleta de colores de WoodRoute](assets/style-color-palette.png)

**Colores de marca:**

| Token | Hex | Uso |
|---|---|---|
| `--color-background` | `#FAF7F2` | Fondo de la página |
| `--color-foreground` | `#1A1715` | Texto principal |
| `--color-primary` | `#FD4319` | Acciones principales, CTAs |
| `--color-primary-hover` | `#E23415` | Estado hover del primario |
| `--color-primary-foreground` | `#FFFFFF` | Texto sobre color primario |
| `--color-brand-light` | `#F0E4D8` | Fondos de marca con énfasis |
| `--color-brand-subtle` | `#F8F2EC` | Fondos de marca sutiles |

**Colores de UI:**

| Token | Hex | Uso |
|---|---|---|
| `--color-card` | `#FFFFFF` | Fondo de cards y paneles |
| `--color-card-foreground` | `#1A1715` | Texto sobre cards |
| `--color-secondary` | `#F0E8DF` | Acciones secundarias |
| `--color-secondary-foreground` | `#443218` | Texto sobre secundario |
| `--color-muted` | `#EAE2D6` | Fondos neutrales |
| `--color-muted-foreground` | `#63523A` | Texto de soporte, placeholders |
| `--color-accent` | `#E6DDD1` | Destacados sutiles |
| `--color-accent-foreground` | `#443218` | Texto sobre accent |
| `--color-border` | `#D6C5B3` | Bordes y separadores |
| `--color-ring` | `#FD4319` | Outline de focus |

**Colores de estado:**

| Token | Hex | Uso |
|---|---|---|
| `--color-destructive` | `#C0392B` | Errores, acciones irreversibles |
| `--color-destructive-foreground` | `#FFFFFF` | Texto sobre destructive |

#### Tipografía

El sistema tipográfico usa dos fuentes complementarias:

**Plus Jakarta Sans** es la fuente de display para títulos y encabezados. Geométrica y moderna, con
personalidad definida sin perder legibilidad. Transmite innovación y solidez. Se aplica en todos los
elementos de heading (h1–h6) con `font-weight` semibold o superior.

**Inter** es la fuente de cuerpo para texto corrido, UI y datos. Optimizada para lectura en pantalla
a cualquier tamaño. Neutral y funcional, no compite con los títulos.

![Specimen tipográfico](assets/style-typography-specimen.png)

La escala tipográfica define tamaños, pesos e interlineado para cada nivel jerárquico:

| Token | Tamaño | Px | Uso típico |
|---|---|---|---|
| `--font-size-6xl` | 3.75rem | 60px | Hero principal de landing |
| `--font-size-5xl` | 3rem | 48px | H1 de sección |
| `--font-size-4xl` | 2.25rem | 36px | H2 de sección |
| `--font-size-3xl` | 1.875rem | 30px | H3 |
| `--font-size-2xl` | 1.5rem | 24px | H4, subtítulos destacados |
| `--font-size-xl` | 1.25rem | 20px | Lead text, taglines |
| `--font-size-lg` | 1.125rem | 18px | Body grande, texto de intro |
| `--font-size-base` | 1rem | 16px | Body estándar |
| `--font-size-sm` | 0.875rem | 14px | UI labels, captions |
| `--font-size-xs` | 0.75rem | 12px | Badges, metadatos |

Los pesos tipográficos disponibles y su uso son:

| Peso | Valor | Uso |
|---|---|---|
| ExtraBold | 800 | Logo wordmark, hero headlines |
| Bold | 700 | H1, H2, énfasis crítico |
| SemiBold | 600 | H3, H4, botones |
| Medium | 500 | Labels, navegación |
| Regular | 400 | Body, texto corrido |

El interlineado varía según el contexto de lectura:

| Token | Valor | Uso |
|---|---|---|
| `tight` (1.2) | 1.2 | Títulos grandes, donde el espacio vertical es limitado |
| `snug` (1.35) | 1.35 | Subtítulos, texto de UI compacto |
| `normal` (1.5) | 1.5 | Body estándar, párrafos de contenido |
| `relaxed` (1.7) | 1.7 | Texto de lectura larga, artículos |

#### Espaciado

El espaciado base sigue la escala de Tailwind (múltiplos de 4px). Adicionalmente, se definen
dos tokens de sección para controlar la separación vertical entre bloques de contenido en la interfaz:

![Escala de espaciado](assets/style-spacing-scale.png)

| Token | Valor | Px | Uso |
|---|---|---|---|
| `--spacing-section` | 6rem | 96px | Separación entre secciones en desktop |
| `--spacing-section-sm` | 4rem | 64px | Separación entre secciones en mobile |

### Web Style Guidelines

#### Border radius

![Border radius tokens de WoodRoute](assets/style-border-radius.png)

El sistema de radios define la personalidad de los componentes. WoodRoute usa radios moderados:
ni completamente cuadrado (frío, técnico) ni completamente redondo (demasiado informal). La
esquina redondeada evoca la madera trabajada y lijada.

| Token | Valor | Uso |
|---|---|---|
| `--radius-sm` | 0.375rem | Badges, chips, tooltips |
| `--radius-md` | 0.5rem | Inputs, botones pequeños |
| `--radius-lg` | 0.75rem | Cards, modales |
| `--radius-xl` | 1rem | Cards destacadas, paneles |
| `--radius-full` | 9999px | Avatares, toggles pill |

#### Sombras

Las sombras usan el color del foreground con opacidad controlada, manteniendo la temperatura
cálida del sistema. Definen la jerarquía de elevación de los elementos en el plano Z:

![Escala de sombras](assets/style-shadow-scale.png)

| Token | Elevación | Uso |
|---|---|---|
| `--shadow-sm` | 1px, 6% opacidad | Inputs en foco, separadores sutiles |
| `--shadow-md` | 4px, 8% opacidad | Cards, dropdowns |
| `--shadow-lg` | 8px, 10% opacidad | Modales, sidebars, popovers |
| `--shadow-xl` | 16px, 12% opacidad | Overlays, drawers, banners flotantes |

#### Diseño responsive

La interfaz sigue la estrategia mobile-first: los estilos base se definen para mobile y se
sobreescriben hacia arriba con media queries. Los breakpoints siguen la escala estándar de
Tailwind CSS:

![Breakpoints responsive](assets/style-responsive-breakpoints.png)

| Breakpoint | Ancho mínimo | Contexto |
|---|---|---|
| `sm` | 640px | Smartphones grandes |
| `md` | 768px | Tablets en portrait |
| `lg` | 1024px | Tablets en landscape, laptops |
| `xl` | 1280px | Desktops |
| `2xl` | 1536px | Pantallas grandes |

Los patrones responsive principales que aplican a la landing y la web app son:

- **Grids**: colapsan de multi-columna a una sola columna por debajo de `md`
- **Navegación**: menú hamburguesa por debajo de `md`, barra horizontal desde `md`
- **Secciones**: `--spacing-section-sm` (4rem) en mobile, `--spacing-section` (6rem) en desktop
- **Tipografía**: escala reducida en mobile (H1 baja de `5xl` a `4xl`, hero de `6xl` a `5xl`)
- **Imágenes**: `max-width: 100%` en todos los elementos `img` y `svg` por defecto

