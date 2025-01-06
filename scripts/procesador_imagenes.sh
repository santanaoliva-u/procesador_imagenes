#!/bin/bash

# Script profesional para procesar imágenes con un menú interactivo

# Configuración de rutas y directorios
directorio_plantillas="./plantillas"
directorio_imagenes_originales="./imagenes/original"
directorio_imagenes_procesadas="./imagenes/procesadas"
directorio_backup="./backup"
plantilla_config="$directorio_plantillas/config_plantilla.json"

# Crear directorios si no existen
mkdir -p "$directorio_plantillas" "$directorio_imagenes_originales" "$directorio_imagenes_procesadas" "$directorio_backup"

# Función para mostrar el menú principal
menu_principal() {
  echo "============================================"
  echo "           Procesador de Imágenes           "
  echo "============================================"
  echo "1. Configurar nombre para anotación"
  echo "2. Configurar filtros (color y cantidad)"
  echo "3. Configurar redimensionamiento"
  echo "4. Configurar bordes (color y tamaño)"
  echo "5. Procesar imágenes"
  echo "6. Configurar respaldo de imágenes originales"
  echo "7. Guardar configuración actual como plantilla"
  echo "8. Cargar configuración desde plantilla"
  echo "9. Mostrar resumen de configuración actual"
  echo "10. Salir"
  echo "============================================"
  echo -n "Seleccione una opción: "
}

# Variables con valores predeterminados
nombre_anotacion="Jesus Uriel Santana Oliva"
filtro_color="rgba(0,0,255,0.2)"
filtro_intensidad=30
redimension=120
borde_color="green"
borde_porcentaje=5
realizar_respaldo=false

# Función para configurar el nombre de anotación
configurar_nombre() {
  echo -n "Ingrese el nombre para la anotación (actual: $nombre_anotacion): "
  read nuevo_nombre
  if [[ -n "$nuevo_nombre" ]]; then
    nombre_anotacion="$nuevo_nombre"
  fi
  echo "Nombre configurado como: $nombre_anotacion"
}

# Función para configurar filtros de color e intensidad
configurar_filtros() {
  echo -n "Ingrese el color del filtro (actual: $filtro_color): "
  read nuevo_color
  if [[ -n "$nuevo_color" ]]; then
    filtro_color="$nuevo_color"
  fi
  echo -n "Ingrese la intensidad del filtro (actual: $filtro_intensidad): "
  read nueva_intensidad
  if [[ -n "$nueva_intensidad" ]]; then
    filtro_intensidad="$nueva_intensidad"
  fi
  echo "Filtro configurado: color=$filtro_color, intensidad=$filtro_intensidad"
}

# Función para configurar el redimensionamiento de imágenes
configurar_redimension() {
  echo -n "Ingrese el porcentaje de redimensionamiento (actual: $redimension%): "
  read nuevo_redimension
  if [[ -n "$nuevo_redimension" ]]; then
    redimension="$nuevo_redimension"
  fi
  echo "Redimensionamiento configurado como: $redimension%"
}

# Función para configurar los bordes de las imágenes
configurar_bordes() {
  echo -n "Ingrese el color del borde (actual: $borde_color): "
  read nuevo_color
  if [[ -n "$nuevo_color" ]]; then
    borde_color="$nuevo_color"
  fi
  echo -n "Ingrese el tamaño del borde en porcentaje (actual: $borde_porcentaje%): "
  read nuevo_porcentaje
  if [[ -n "$nuevo_porcentaje" ]]; then
    borde_porcentaje="$nuevo_porcentaje"
  fi
  echo "Bordes configurados: color=$borde_color, tamaño=$borde_porcentaje%"
}

# Función para configurar si se realizarán respaldos de las imágenes originales
configurar_respaldo() {
  echo -n "¿Desea realizar un respaldo de las imágenes originales? (actual: $realizar_respaldo, s/n): "
  read opcion_respaldo
  if [[ "$opcion_respaldo" == "s" ]]; then
    realizar_respaldo=true
  else
    realizar_respaldo=false
  fi
  echo "Respaldo configurado: $realizar_respaldo"
}

# Función para procesar las imágenes en la carpeta de originales
procesar_imagenes() {
  echo "Procesando imágenes en $directorio_imagenes_originales..."
  for img in "$directorio_imagenes_originales"/*.{png,jpg,jpeg}; do
    if [[ -f "$img" ]]; then
      echo "Procesando: $img"

      # Obtener dimensiones de la imagen
      width=$(identify -format "%w" "$img")
      height=$(identify -format "%h" "$img")

      # Calcular tamaño del borde dinámico
      borde_size=$(((width < height ? width : height) * borde_porcentaje / 100))

      # Realizar respaldo si está habilitado
      if [[ "$realizar_respaldo" == true ]]; then
        cp "$img" "$directorio_backup/$(basename "$img")"
      fi

      # Procesar la imagen
      convert "$img" \
        -bordercolor "$borde_color" -border ${borde_size}x${borde_size} \
        -gravity southeast -pointsize $((borde_size / 2)) -fill white -annotate +${borde_size}+${borde_size} "$nombre_anotacion" \
        -resize "$redimension%" \
        -fill "$filtro_color" -colorize "$filtro_intensidad" \
        "$directorio_imagenes_procesadas/$(basename "$img")"

      echo "Procesada: $img"
    fi
  done
  echo "Todas las imágenes han sido procesadas."
}

# Función para guardar configuración actual en un archivo JSON
guardar_configuracion() {
  cat <<EOF >$plantilla_config
{
    "nombre_anotacion": "$nombre_anotacion",
    "filtro_color": "$filtro_color",
    "filtro_intensidad": $filtro_intensidad,
    "redimension": $redimension,
    "borde_color": "$borde_color",
    "borde_porcentaje": $borde_porcentaje,
    "realizar_respaldo": $realizar_respaldo
}
EOF
  echo "Configuración guardada en $plantilla_config."
}

# Función para cargar configuración desde un archivo JSON
cargar_configuracion() {
  if [[ -f $plantilla_config ]]; then
    nombre_anotacion=$(jq -r '.nombre_anotacion' $plantilla_config)
    filtro_color=$(jq -r '.filtro_color' $plantilla_config)
    filtro_intensidad=$(jq -r '.filtro_intensidad' $plantilla_config)
    redimension=$(jq -r '.redimension' $plantilla_config)
    borde_color=$(jq -r '.borde_color' $plantilla_config)
    borde_porcentaje=$(jq -r '.borde_porcentaje' $plantilla_config)
    realizar_respaldo=$(jq -r '.realizar_respaldo' $plantilla_config)
    echo "Configuración cargada desde $plantilla_config."
  else
    echo "No se encontró el archivo $plantilla_config."
  fi
}

# Función para mostrar el resumen de configuraciones actuales
mostrar_resumen() {
  echo "============================================"
  echo " Resumen de Configuración Actual:"
  echo "============================================"
  echo "Nombre para anotación: $nombre_anotacion"
  echo "Filtro: color=$filtro_color, intensidad=$filtro_intensidad"
  echo "Redimensionamiento: $redimension%"
  echo "Bordes: color=$borde_color, tamaño=$borde_porcentaje%"
  echo "Respaldo habilitado: $realizar_respaldo"
  echo "============================================"
}

# Menú interactivo
while true; do
  menu_principal
  read opcion
  case $opcion in
  1) configurar_nombre ;;
  2) configurar_filtros ;;
  3) configurar_redimension ;;
  4) configurar_bordes ;;
  5) procesar_imagenes ;;
  6) configurar_respaldo ;;
  7) guardar_configuracion ;;
  8) cargar_configuracion ;;
  9) mostrar_resumen ;;
  10)
    echo "Saliendo..."
    break
    ;;
  *) echo "Opción no válida, intente nuevamente." ;;
  esac
done
