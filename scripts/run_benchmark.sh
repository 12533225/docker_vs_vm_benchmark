#!/bin/bash

set -e
OUTPUT_DIR=$1
mkdir -p $OUTPUT_DIR

echo "=== Benchmark iniciado para $OUTPUT_DIR ==="

# Lanzar app Node.js en segundo plano
cd ../app-nodejs
npm install
node app.js &

APP_PID=$!
sleep 5

# wrk test
wrk -t4 -c100 -d30s http://localhost:3000/ping | tee ../benchmark/$OUTPUT_DIR/nodejs_wrk.txt

kill $APP_PID
cd ../benchmark
echo "✅ Finalizado benchmark de Node.js"
