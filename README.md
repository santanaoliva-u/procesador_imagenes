# Procesador de Imágenes

Un proyecto para automatizar el procesamiento de imágenes, permitiendo la aplicación de filtros, redimensionamiento, bordes, y anotaciones personalizadas. Este script también incluye opciones para respaldar las imágenes originales y gestionar configuraciones mediante plantillas JSON.

## Estructura del Proyecto

```plaintext
procesador_imagenes/
├── backup                        # Carpeta para respaldos automáticos
├── imagenes                     # Carpeta para imágenes
│   ├── original                 # Copias originales de las imágenes
│   └── procesadas               # Resultado del procesamiento
├── LICENSE                      # Licencia del proyecto
├── plantillas                   # Plantillas JSON para configuraciones predefinidas
│   ├── plantilla_basica.json
│   ├── plantilla_memes.json
│   ├── plantilla_profesional.json
│   ├── plantilla_redes.json
│   └── plantilla_vintage.json
├── README.md                    # Documentación del proyecto
└── scripts                      # Carpeta para scripts
    └── procesador_imagenes.sh   # Script principal del proyecto
```

## Instalación

### Requisitos previos

- **Sistema operativo:** Linux o macOS (compatibilidad con bash).
- **Dependencias:**
  - [ImageMagick](https://imagemagick.org/) para el procesamiento de imágenes.
  - [jq](https://stedolan.github.io/jq/) para manipular archivos JSON.

Instalación de dependencias en sistemas basados en Debian:
```bash
sudo apt update && sudo apt install -y imagemagick jq
```

En sistemas basados en Arch Linux:
```bash
sudo pacman -Syu imagemagick jq
```

### Descarga del Proyecto

Clona el repositorio desde GitHub:
```bash
git clone https://github.com/santanaoliva-u/procesador_imagenes.git
cd procesador_imagenes
```

La estructura del proyecto estará lista tras la clonación.

## Uso del Script

### Ejecución Inicial

Para comenzar, navega a la carpeta `scripts` y otorga permisos de ejecución al script:
```bash
cd scripts
chmod +x procesador_imagenes.sh
```

Ejecuta el script con:
```bash
./procesador_imagenes.sh
```

### Opciones Disponibles

El menú interactivo del script ofrece las siguientes funcionalidades:

1. **Configurar nombre para anotación:** Personaliza el texto que se añadirá a las imágenes.
2. **Configurar filtros:** Aplica un filtro de color y ajusta su intensidad.
3. **Configurar redimensionamiento:** Define el porcentaje de escala para las imágenes.
4. **Configurar bordes:** Ajusta el color y tamaño de los bordes.
5. **Procesar imágenes:** Procesa las imágenes en la carpeta `imagenes/original`.
6. **Configurar respaldo:** Habilita o deshabilita el respaldo automático de imágenes.
7. **Guardar configuración como plantilla:** Almacena la configuración actual en un archivo JSON.
8. **Cargar configuración desde plantilla:** Restaura configuraciones desde plantillas predefinidas.
9. **Mostrar resumen:** Muestra un resumen de la configuración actual.
10. **Salir:** Termina la ejecución del script.

### Procesamiento de Imágenes

Coloca las imágenes que deseas procesar en la carpeta `imagenes/original`. Una vez procesadas, los archivos resultantes se guardarán en `imagenes/procesadas`.

## Plantillas

El proyecto incluye varias plantillas JSON predefinidas ubicadas en la carpeta `plantillas/`:

- **plantilla_basica.json:** Configuración básica.
- **plantilla_memes.json:** Ideal para memes.
- **plantilla_profesional.json:** Configuración para presentaciones formales.
- **plantilla_redes.json:** Configuración optimizada para redes sociales.
- **plantilla_vintage.json:** Estilo retro.

Puedes usar estas plantillas cargándolas desde el menú interactivo.

## Licencia

Este proyecto está licenciado bajo la licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para más información.

---

¡Gracias por usar el procesador de imágenes! Si tienes preguntas o comentarios, no dudes en abrir un issue en el [repositorio del proyecto](https://github.com/santanaoliva-u/procesador_imagenes).


