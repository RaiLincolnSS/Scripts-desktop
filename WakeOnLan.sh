#!/bin/bash

# Scrit para envio de Magic Packet


MAC="d8:5e:d3:f5:fd:0c"

wakeonlan $MAC > /dev/null 
