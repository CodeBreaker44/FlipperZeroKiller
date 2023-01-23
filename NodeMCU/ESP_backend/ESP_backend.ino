#include <Arduino.h>

#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>

#include <ESP8266HTTPClient.h>

#include <WiFiClientSecureBearSSL.h>


// To be fixed
const uint8_t fingerprint[20] = {0x5B,0x43,0x14,0x8B,0x45,0xF8,0xC7,0x4F,0xD6,0xCC,0x4A,0xC9,0xB4,0xFB,0x64,0x4B,0x8D,0x7C,0x1E,0x44};
ESP8266WiFiMulti WiFiMulti;
String status = String("Locked");


ICACHE_RAM_ATTR void DetectDoor()
{
  Serial.println("Door Status Changed");
  if(digitalRead(D2) == 1)
  {
    Serial.println("Door Opened");
    status = "Unlocked";
  }
  else if(digitalRead(D2) == 0)
  {
    Serial.println("Door Closed");
    status = "Locked";
  }
}

void setup() {

  pinMode(D1, OUTPUT);
  pinMode(D3, OUTPUT);
  pinMode(D3,INPUT);
  Serial.begin(115200);

  Serial.println();
  Serial.println();
  Serial.println();

  for (uint8_t t = 1; t > 0; t--) {
    Serial.printf("[SETUP] WAIT %d...\n", t);
    Serial.flush();
    delay(1000);
  }

  WiFi.mode(WIFI_STA);

  // Edit Wifi Creds
  WiFiMulti.addAP("ZainFiber-2.4G-U9c4", "F2n9yTy9");

  attachInterrupt(digitalPinToInterrupt(D2), DetectDoor, CHANGE);
}

void loop() {
  // wait for WiFi connection
  if ((WiFiMulti.run() == WL_CONNECTED)) {

    std::unique_ptr<BearSSL::WiFiClientSecure>client(new BearSSL::WiFiClientSecure);

    client->setFingerprint(fingerprint);
    // Or, if you happy to ignore the SSL certificate, then use the following line instead:
    // client->setInsecure();

    HTTPClient https;

    // Edit this URL 
    if (https.begin(*client, "https://project.silvercryptor.xyz/api/connect")) {  // HTTPS

      https.addHeader("Content-Type", "application/json");
      // Calculate length based on door status
      //String payload = String("{\"status\":") + String("\"") + status + String("\"}");
      String payload = "{\"status\":";
      payload.concat("\"");
      payload.concat(status);
      payload.concat("\"}");
      https.addHeader("Content-Length", String(payload.length()));
      // start connection and send HTTP header
      int httpCode = https.POST(payload);

      // httpCode will be negative on error
      if (httpCode > 0) {
        // HTTP header has been send and Server response header has been handled

        // file found at server
        //if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY) 
        if(1){
          String command = https.getString();
          Serial.println(command);
          // DynamicJsonDocument doc(1024);
          // DeserializationError error = deserializeJson(doc, input);
          // if (error) {
          //   Serial.print(F("deserializeJson() failed: "));
          //   Serial.println(error.f_str());
          // }
          //const char* command = doc["command"];
          
          if(command.charAt(12) == 'U')
          {
            status = "Unlocked";

            digitalWrite(D1,1);
            digitalWrite(D1,0);
          }
          if(command.charAt(12) == 'L')
          {
            status = "Locked";
            digitalWrite(D2,0);
            digitalWrite(D1,1);
            digitalWrite(D1,0);
          }
          Serial.println(status);
        }
      } else {
        Serial.printf("[HTTPS] GET... failed, error: %s\n", https.errorToString(httpCode).c_str());
      }

      https.end();
    } else {
      Serial.printf("[HTTPS] Unable to connect\n");
    }
  }
  delay(1000);
}


