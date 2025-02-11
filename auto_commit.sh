#!/bin/bash
while true; do
    git add .
    git commit -m "Avtomatski commit: $(date)"
    git push origin main
    sleep 60
done
