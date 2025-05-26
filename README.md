# Comparación de rendimiento: VM vs Docker con Node.js

Este proyecto evalúa el rendimiento de una app Node.js desplegada en:

- Contenedor Docker
- Máquina Virtual

## Instrucciones

1. Ejecuta el benchmark en cada entorno:

```bash
cd benchmark
chmod +x run_benchmark.sh
./run_benchmark.sh benchmark_results_vm
./run_benchmark.sh benchmark_results_docker
```

2. Verás métricas como:

- Requests/sec
- Latencia media

