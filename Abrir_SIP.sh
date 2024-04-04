#!/bin/bash 

# Abrir Microsip com o wine

MICROSIP="/home/rai/Documentos/MIcrosip/Microsip/microsip.exe"
LOGFILE="/home/rai/Documentos/MIcrosip/SIP.log"


wine $MICROSIP >> $LOGFILE 2>&1 & 
