#!/bin/bash

VM_NAME="UbuntuTest"
VM_IP="192.168.56.101"  # Cambia por la IP real de tu VM
TIMEOUT=60             
RESULT_FILE="vm_boot_results.txt"

touch $RESULT_FILE

echo "🔁 Iniciando prueba de arranque de VM '$VM_NAME'..."

# Apagar VM si está corriendo
VBoxManage controlvm "$VM_NAME" poweroff >/dev/null 2>&1
sleep 3

START=$(date +%s.%N)
VBoxManage startvm "$VM_NAME" --type headless >/dev/null

# Esperar hasta que responda al ping (o cambia por ssh si lo prefieres)
for ((i=0; i<$TIMEOUT; i++)); do
  if ping -c 1 "$VM_IP" &>/dev/null; then
    END=$(date +%s.%N)
    RUNTIME=$(echo "$END - $START" | bc)
    NOW=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$NOW] 🟢 VM disponible tras $RUNTIME segundos" | tee -a $RESULT_FILE
    exit 0
  fi
  sleep 1
done

END=$(date +%s.%N)
RUNTIME=$(echo "$END - $START" | bc)
NOW=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$NOW] ❌ VM no respondió en $TIMEOUT s (tiempo medido: $RUNTIME s)" | tee -a $RESULT_FILE
exit 1
