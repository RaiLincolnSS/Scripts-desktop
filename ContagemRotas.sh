#!/bin/bash



CONTROUTE=$(sed -n '/.route/p' $1 | wc -l)

echo "A aplicação flask tem $CONTROUTE rotas"  # O argumento $1 é o nome do arquivo python que contém as rotas


