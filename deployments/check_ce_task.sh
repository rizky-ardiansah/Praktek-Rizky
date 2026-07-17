#!/bin/bash

set -e

CE_TASK_URL=$(grep ceTaskUrl .scannerwork/report-task.txt | cut -d "=" -f 2-)


for i in $(seq 1 60); do
  RESPONSE=$(curl -s -u "$SONARTOKEN:" "$CE_TASK_URL")

  CE_STATUS=$(echo "$RESPONSE" | jq -r '.task.status')
  echo "Percobaan $i - Status pemrosesan analisis: $CE_STATUS"

  if [ "$CE_STATUS" = "SUCCESS" ]; then
    echo "Analisis selesai!"
    break
  fi

  if [ "$CE_STATUS" = "FAILED" ] || [ "$CE_STATUS" = "CANCELED" ]; then
    echo "Pemrosesan analisis SonarQube gagal di server!"
    exit 1
  fi

  sleep 5
done