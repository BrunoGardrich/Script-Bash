#!/bin/bash


USO_DISCO=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

LIMITE=80

echo "Uso total do disco: $USO_DISCO"

if [ "$USO_DISCO" -ge "$LIMITE" ]; then

    echo "Alerta: o uso do disco está acima de '$LIMITE'%"
else
    echo "Uso do disco dentro do limite."
fi
