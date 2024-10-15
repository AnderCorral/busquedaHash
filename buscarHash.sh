#!/bin/bash

# Preguntar al usuario por la ruta del directorio y el hash
read -p "Introduce la ruta del directorio: " DIRECTORIO
read -p "Introduce el hash MD5 a buscar: " HASH_OBJETIVO

# Comprobar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "El directorio no existe. Por favor, introduce una ruta válida."
    exit 1
fi

# Recorremos cada archivo en el directorio
for archivo in "$DIRECTORIO"/*; do
    # Verificar si el archivo existe (en caso de que el directorio esté vacío)
    if [ ! -e "$archivo" ]; then
        echo "No se encontraron archivos en el directorio especificado."
        exit 1
    fi

    # md5sum devuelve una salida que tiene dos partes: el hash MD5 seguido del nombre del archivo.
    hash_actual=$(md5sum "$archivo" | awk '{print $1}')

    # Se comprueba si el hash coincide con el que tenemos
    if [ "$hash_actual" == "$HASH_OBJETIVO" ]; then
        echo "¡Archivo encontrado! El archivo con el hash es: $archivo"
        # Si solo deseas encontrar uno y luego salir, descomenta la siguiente línea:
        break
    fi
done

echo "Búsqueda completada."
