# IOTAPP

This is a research project tha aims at improving the usability of Internet of Things software as a servive platforms.
The project uses flutter mobile application with firebase backend as a service to sync data with nodemcu IoT board 
This project has two parts:
- The mobile app
- The nodemcu part

### Application part :iphone:
This is a mobile app developed using Flutter Dart hybrid framework that user Firebase to:
- sign up user once after the installation using email and a password that should be minimum of 6 characters
- Display all the user projects on home screen.
- Create a new IoT project.
- Control an IOT project  over the internet.
- share project info with the digital electronics installer.
- signout a user.

To run the application as web or on mobile device use the following commands:
- To install the dependencies :electric_plug:
```
flutter pub get 
```

- To run  :star:
```
flutter run
```

### NodeMCU part :nut_and_bolt:
This is the hardware part where the firmware is installed according to user requirement using the Arduino software
The firmware installed and all the sensor codes and configuration info filled as shared by the user.
The control pins remain the same except if the actuator used needs more control like a servo motor.
Here is a sample code with dht sensor that sends humidity and temperature values to a user smart home project.

```C++
//this example uses a dht sensor and updates humidity and the temperature sensor reading
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif

#include <Firebase_ESP_Client.h>
#include <ArduinoJson.h>

// Provide the token generation process info.
#include <addons/TokenHelper.h>


//if not using DHT sensor remove these 3 example lines
#include "DHT.h"
#define DHTTYPE DHT11 
DHT dht(12, DHTTYPE);


/* 1. Define the WiFi credentials */
#define WIFI_SSID "WIFI_NAME"
#define WIFI_PASSWORD "PASSWORD"



String project_id= "PROJECT_ID"; //put your project id from user

/* 2. Define the API Key */
#define API_KEY "AIzaSyCtlZTb2k02uviGdvOqb7-I4Hq4mTat_0A"

/* 3. Define the project ID */
#define FIREBASE_PROJECT_ID "iot-app-6a68f"

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "junior@email.com"
#define USER_PASSWORD "pass12"

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

bool taskCompleted = false;

unsigned long dataMillis = 0;
int led0=16;
int led1=5;
int led2=4;
int led3=0;
int led4=2;
int led5=14;

//int sesnsor1=12;
int sesnsor2=13;
int sesnsor3=3;
int count=1;

void setup()
{

    Serial.begin(115200);
    pinMode(led0,OUTPUT);
    pinMode(led1,OUTPUT);
    pinMode(led2,OUTPUT);
    pinMode(led3,OUTPUT);
    pinMode(led4,OUTPUT);
    pinMode(led5,OUTPUT);

    dht.begin();//if not using dht sensor remove this line

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;

    /* Assign the user sign in credentials */
    auth.user.email = USER_EMAIL;
    auth.user.password = USER_PASSWORD;

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

#if defined(ESP8266)
    // In ESP8266 required for BearSSL rx/tx buffer for large data handle, increase Rx size as needed.
    fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 */, 2048 /* Tx buffer size in bytes from 512 - 16384 */);
#endif

    // Limit the size of response payload to be collected in FirebaseData
    fbdo.setResponseSize(2048);

    Firebase.begin(&config, &auth);

    Firebase.reconnectWiFi(true);
}

void loop()
{

    // Firebase.ready() should be called repeatedly to handle authentication tasks.

    if (Firebase.ready() && (millis() - dataMillis > 6000 || dataMillis == 0))
    {
        dataMillis = millis();

         FirebaseJson content;

        String documentPath = "projects/"+project_id;

        Serial.print("Get a document... ");

        if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str()))
            updatePins(fbdo.payload());
        else
            Serial.println(fbdo.errorReason());
        
        //remove these two lines and add your sensors code
        float t = dht.readTemperature();
        float h = dht.readHumidity();

       
       
        content.clear();
        content.set("fields/pin6/stringValue", String(t).c_str());
        content.set("fields/pin7/stringValue", String(h).c_str());
        content.set("fields/pin8/stringValue", String("null").c_str());
        if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "" , documentPath.c_str(), content.raw(), "pin6,pin7,pin8"))
            Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
        else
            Serial.println(fbdo.errorReason());
    }
}

void updatePins(String payload){
//  Serial.println(payload);
  DynamicJsonDocument doc(1024);
  deserializeJson(doc,payload);
  String pin0=doc["fields"]["pin0"]["stringValue"];
  String pin1=doc["fields"]["pin1"]["stringValue"];
  String pin2=doc["fields"]["pin2"]["stringValue"];
  String pin3=doc["fields"]["pin3"]["stringValue"];
  String pin4=doc["fields"]["pin4"]["stringValue"];
  String pin5=doc["fields"]["pin5"]["stringValue"];
  if(pin0=="on")
    digitalWrite(led0,HIGH);
  else
    digitalWrite(led0,LOW);
  if(pin2=="on")
  if(pin1=="on")
    digitalWrite(led1,HIGH);
  else
    digitalWrite(led1,LOW);
  if(pin2=="on")
    digitalWrite(led2,HIGH);
  else
    digitalWrite(led2,LOW);
  if(pin3=="on")
    digitalWrite(led3,HIGH);
  else
    digitalWrite(led3,LOW);
  if(pin4=="on")
    digitalWrite(led4,HIGH);
  else
    digitalWrite(led4,LOW);

  if(pin5=="on")
    digitalWrite(led5,HIGH);
  else
    digitalWrite(led5,LOW);
  
}
```
copy this and modify the project_id variable and put the shared project id from the user. :gear:
Add correct wifi ssid and password for the installation router :hammer_and_wrench:
Also connect the items and sensors as per the pinout :tada:

### contributers 	:technologist:
MUCHIRA JUNIOR
https://github.com/muchirajunior
