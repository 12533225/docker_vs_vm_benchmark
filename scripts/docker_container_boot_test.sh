#!/bin/bash

CONTAINER_NAME="startup-test"
IMAGE_NAME="nginx:alpine"
RESULT_FILE="docker_container_boot_results.txt"

# Crear archivo si no existe
touch $RESULT_FILE

# Eliminar contenedor previo
docker rm -f $CONTAINER_NAME > /dev/null 2>&1

# Iniciar y medir tiempo
echo "🚀 Iniciando contenedor '$CONTAINER_NAME'..."

START=$(date +%s.%N)
docker run -d --name $CONTAINER_NAME $IMAGE_NAME > /dev/null
END=$(date +%s.%N)

RUNTIME=$(echo "$END - $START" | bc)
NOW=$(date '+%Y-%m-%d %H:%M:%S')

# Verificar estado
docker ps --filter "name=$CONTAINER_NAME" --filter "status=running" | grep $CONTAINER_NAME > /dev/null
if [ $? -eq 0 ]; then
  echo "[$NOW] ✅ Contenedor arrancó en $RUNTIME s" | tee -a $RESULT_FILE
else
  echo "[$NOW] ❌ Falló el arranque del contenedor" | tee -a $RESULT_FILE
fi
