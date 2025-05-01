#define RELAY_PIN 8
#define COIN_SENSOR 2
#define MAX_COINS 5

int coinCount = 0;
bool systemLocked = false;  // Start unlocked immediately
bool lastCoinState = HIGH;

unsigned long lastCoinTime = 0;
const unsigned long coinDebounceDelay = 50;  // Faster debounce

void setup() {
    Serial.begin(9600);
    pinMode(RELAY_PIN, OUTPUT);
    pinMode(COIN_SENSOR, INPUT_PULLUP);

    digitalWrite(RELAY_PIN, HIGH);  // Start the hopper immediately
    Serial.println("System Ready. Dispensing started.");
}

void loop() {
    // If system is not locked, detect coin input
    if (!systemLocked) {
        int coinState = digitalRead(COIN_SENSOR);

        // Only process a falling edge (coin detected) if debounce time has passed
        if (lastCoinState == HIGH && coinState == LOW) {
            unsigned long currentTime = millis();
            if (currentTime - lastCoinTime > coinDebounceDelay) {
                coinCount++;
                lastCoinTime = currentTime;
                Serial.print("Coin Count: ");
                Serial.println(coinCount);
            }
        }

        // Reset the coin state once it's detected as HIGH again
        if (coinState == HIGH) {
            lastCoinState = HIGH;
        } else {
            lastCoinState = LOW;
        }

        // Stop dispensing once the target coin count is reached
        if (coinCount >= MAX_COINS) {
            Serial.println("Target reached. Stopping...");
            digitalWrite(RELAY_PIN, LOW);  // Stop the hopper
            systemLocked = true;
        }
    }
}
