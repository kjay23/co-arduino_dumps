#!/bin/bash

INO_NAME="CoinDispenser1"
INO_FILE="/tmp/CoinDispenser1/CoinDispenser1.ino"
TMP_DIR="/tmp/CoinDispenser1"
BOARD="arduino:avr:uno"
PORT="/dev/ttyACM0"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cp "./CoinDispenser1.ino" "$INO_FILE"

arduino-cli compile --fqbn "$BOARD" "$TMP_DIR"
arduino-cli upload -p "$PORT" --fqbn "$BOARD" "$TMP_DIR"

if [ $? -eq 0 ]; then
    echo "Upload successful!"
else
    echo "Upload failed!"
fi
