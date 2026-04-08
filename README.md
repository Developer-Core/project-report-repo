# project-report-repo

Plantilla mínima para generar el PDF del informe con Pandoc + Eisvogel.

## Construcción del PDF

- Comando real de build: `pandoc --defaults=config/build.yaml`
- Atajo opcional: `make pdf`

> No hace falta pasar los archivos Markdown manualmente: el orden de entrada ya está definido en `config/build.yaml`.

## Configuración

### `config/build.yaml`

Define la ejecución de Pandoc:

- orden de `input-files`,
- archivo de salida,
- template,
- bibliografía y CSL,
- opciones generales como `toc: false` y `number-sections: true`.

### `config/metadata.yaml`

Define los metadatos del documento y variables consumidas por el template:

- título,
- datos institucionales,
- integrantes,
- tipografías,
- `header-includes`.

## Tabla de contenidos

La TOC actual es **manual**: se inyecta desde `report/front-matter/03-toc.md` usando LaTeX (`\tableofcontents`).

Por eso `toc` se mantiene desactivado en la configuración, para evitar una tabla de contenidos duplicada.
