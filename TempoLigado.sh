#!/bin/bash 

#################################################################
#                                                               #
# Tempo_ligado.sh                                               #
#                                                               #
# Autor: Rai Lincoln                                            #
# Data Criação: 22/11/2023                                      #
#                                                               #
#                                                               #
# Descrição: Script que exibe o tempo que o PC ficou ligado     #
#                                                               #
#                                                               #
# Exemplo de uso: ./Tempo_ligado.sh                             #
#                                                               #
# Alterações                                                    #
#    Versão 1.0 28/12/2023                                      #
#    Dia X - ...                                                #
#    Dia Y - ...                                                #
#                                                               #
#################################################################



TEMPO_LIGADO=$(uptime | awk '{ print $3, $4 }' | tr -d ',')

echo "Seu computador está ligado há $TEMPO_LIGADO"


