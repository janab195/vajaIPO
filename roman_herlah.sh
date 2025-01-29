#!/bin/bash

# Argument za zagon
repeats=$1

# Format datuma
today=$(date +%d_%m_%Y)
filename="${today}.txt"

for ((i=1; i<=repeats; i++)); do
  # Pridobivanje IP naslova
  ip_address=$(ip addr show | grep "inet " | awk '{print $2}' | cut -d'/' -f1 | head -n 1 || echo CONNECTION ERROR)

  if [[ ! -f $filename ]]; then
    # Ustvari datoteko, če ne obstaja
    echo "$(date +%T) - $ip_address - $USER | CPU-USAGE: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%" > $filename
  else
    # Dodaj novo vrstico
    echo "$(date +%T) - $ip_address - $USER | CPU-USAGE: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%" >> $filename
  fi

  # Počakaj 1 minuto, če ni zadnji zagon
  if [[ $i -lt $repeats ]]; then
    sleep 60
  fi

  # Izpiši zadnjih 5 vrstic
  tail -n 5 $filename
done
