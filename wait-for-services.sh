#!/bin/sh
set -e

# Verificar que las variables estén definidas
if [ -z "$DB_HOST" ]; then
  echo "Error: La variable DB_HOST no está definida."
  exit 1
fi

if [ -z "$RABBITMQ_HOST" ]; then
  echo "Error: La variable RABBITMQ_HOST no está definida."
  exit 1
fi

# Esperar MySQL
echo "Esperando a que MySQL esté disponible en $DB_HOST:3306..."
while ! nc -z "$DB_HOST" 3306; do
  echo "MySQL aún no está listo. Esperando..."
  sleep 2
done
echo "MySQL está disponible."

# Iniciar aplicación
exec "$@"
