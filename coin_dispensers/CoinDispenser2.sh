#!/bin/bash

INO_NAME="CoinDispenser2"
INO_FILE="/tmp/CoinDispenser2/CoinDispenser2.ino"
TMP_DIR="/tmp/CoinDispenser2"
BOARD="arduino:avr:uno"
PORT="/dev/ttyACM0"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cp "./CoinDispenser2.ino" "$INO_FILE"

arduino-cli compile --fqbn "$BOARD" "$TMP_DIR"
arduino-cli upload -p "$PORT" --fqbn "$BOARD" "$TMP_DIR"

if [ $? -eq 0 ]; then
    echo "Upload successful!"
else
    echo "Upload failed!"
fi
