#!/bin/bash

########################################################################
#                                                                      #
#                                                                      #
# Script para desligar o computador em um horario especifico           # 
#  O script ira perguntar se tem alguem utilizando o computador        #
#  Caso nao tenha ninguem, ele desliga o computador                    #
#                                                                      #
# Autor: Rai Lincoln                                                   #
# Data Criação: 12/01/2024                                             #
#                                                                      #
#                                                                      #
#                                                                      #
#                                                                      #
#                                                                      #
# Exemplo de uso: ./Desligar_PC.sh                                     #
#                                                                      #
#                                                                      #
# Alterações                                                           #
#    Versão 2.0 29/01/2024                                             #
#    Dia X - ...                                                       #
#    Dia Y - ...                                                       #
#                                                                      #
########################################################################


DATAHORA=$(date +%d-%m-%Y" "%H:%M)
#VERIFICAR_PRESENCA=$(pgrep -l brave)
#LOG=/var/log/desligar_pc.log
LOG=/home/rai/Documentos/Scripts/Desligar_PC.log



if pgrep -x "brave" > /dev/null || pgrep -x "chrome" > /dev/null 
then
    echo "-----------------------------------------------------" >> $LOG
    echo "$DATAHORA            Tem alguem no PC                " >> $LOG     
    echo "-----------------------------------------------------" >> $LOG
else
    echo "-----------------------------------------------------" >> $LOG
    echo -e "$DATAHORA      Não tem ninguem no PC\n                        Desligando...  " >> $LOG
    echo "-----------------------------------------------------" >> $LOG
    shutdown -h now
fi

