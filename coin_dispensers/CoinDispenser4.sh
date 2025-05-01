#!/bin/bash

INO_NAME="CoinDispenser4"
INO_FILE="/tmp/CoinDispenser4/CoinDispenser4.ino"
TMP_DIR="/tmp/CoinDispenser4"
BOARD="arduino:avr:uno"
PORT="/dev/ttyACM0"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cp "./CoinDispenser4.ino" "$INO_FILE"

arduino-cli compile --fqbn "$BOARD" "$TMP_DIR"
arduino-cli upload -p "$PORT" --fqbn "$BOARD" "$TMP_DIR"

if [ $? -eq 0 ]; then
    echo "Upload successful!"
else
    echo "Upload failed!"
fi
