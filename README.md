# ESP32_comm 
Step 1:- Buy the ESP32 Module from https://robocraze.com/products/nodemcu-32-wifi-bluetooth-esp32-development-board30-pin?_pos=1&_psq=esp32&_ss=e&_v=1.0 Rs. 400     
    
Step 2:- Install Arduino IDE, Setup the IDE for the ESP32 as below.\n\n
2a -> go to File-> Preferences -> Paste this URL http://arduino.esp8266.com/stable/package_esp8266com_index.json,https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json ->ok     
2b -> load the firmware to IDE and download the required modules.    
2c -> Connect the ESP32 dev Board and select the board settings.     
2d -> Compile and check for errors.\n2e -> Upload to ESP32.     


Step 3:-check if led in ESP32 is blinking or not. if the light is blinking, then press the green button in the app.     


Step 4:- write any text on the text box and click on Get data button.     

**Kotlin Source Code**
```
private fun bluetooth(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            var bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
            var bluetoothAdapter: BluetoothAdapter = bluetoothManager.adapter
            val device = bluetoothAdapter.getRemoteDevice("B0:B2:1C:A7:69:62")
            bluetoothGatt = device.connectGatt(this,false,gattCallback)
            Toast.makeText(context,"connected", Toast.LENGTH_SHORT).show()
        }
```
In the above block, the MAC address of the target ESP32 module can be changed depending on the hardware used.

> You can access Flutter files under lib folder in main.dart
https://github.com/shashankssvi/ESP32_comm/blob/main/bluet/lib/main.dart
>
> You can access Kotlin files under Android folder in MainActivity.kt https://github.com/shashankssvi/ESP32_comm/tree/main/bluet/android/app/src/main/kotlin/com/example/bluet
>
> What happens when you connect your Bluetooth Earphone for listening to Music
> 1. Mobile Device will be the listener. BT Earphone will be the broadcaster.   
> 2. Mobile Device will send a Connection Request to BT Earphone
> 3. BT Earphone will accept the Connection Request
> 4. Mobile Device will start sending characters (bytes of data) to BT Earphone
> 5. BT Earphone can send commands asynchronously to Mobile Device (eg Pause, Resume, Next, Previous)

Similarly
> 1. Mobile App will be the listener. ESP32 module will be broadcaster.(GATT server)
```
@SuppressLint("MissingPermission")
private fun bluetooth(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            var bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
            var bluetoothAdapter: BluetoothAdapter = bluetoothManager.adapter
            val device = bluetoothAdapter.getRemoteDevice("B0:B2:1C:A7:69:62")
            bluetoothGatt = device.connectGatt(this,false,gattCallback)
            Toast.makeText(context,"connected", Toast.LENGTH_SHORT).show()
        }
    }
```
> 3. Mobile App will send a Connection Request through the GREEN button Connect. Check for Bluetooth Permission first.
```private fun bluetoothPermission(){
        if(ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_DENIED){
            ActivityCompat.requestPermissions(this,arrayOf(Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_ADMIN),BLUETOOTH_PERMISSION_CODE)
        }
        else{
            Toast.makeText(context,"enabled", Toast.LENGTH_SHORT).show()
        }
    }
```
> 4. ESP32 module will accept the Connection Request.  Mera Vajan is the name given to the BT device.
```
void setup() {

  pinMode(led,OUTPUT);
  Serial.begin(115200);

  BLEDevice::init("Mera Vajan");
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  pService = pServer->createService(SERVICE_UUID);

  pCharacteristic = pService->createCharacteristic(
    CHARACTERISTIC_UUID,
    BLECharacteristic::PROPERTY_READ |
    BLECharacteristic::PROPERTY_WRITE |
    BLECharacteristic::PROPERTY_NOTIFY
  );

  pCharacteristic->addDescriptor(new BLE2902());
  pCharacteristic->setCallbacks(new MyCallbacks());
  pCharacteristic->setValue("Mera Vajan");

  pService->start();
  BLEDevice::startAdvertising();
}
```
> 6. Mobile App will send a string (eg. Good Morning ) to the ESP32 module
```
 private fun sendData(data:String){

        val service = bluetoothGatt?.getService(UUID.fromString(SERVICE_UUID))
        val characteristic = service?.getCharacteristic(UUID.fromString(CHARACTERISTIC_UUID))
        val valueToSend = data.toByteArray(Charsets.UTF_8)

        characteristic?.let {
            val result = bluetoothGatt!!.writeCharacteristic(
                it,
                valueToSend,
                BluetoothGattCharacteristic.WRITE_TYPE_DEFAULT
            )
            if (result != BluetoothStatusCodes.SUCCESS) {
                Log.e("BLE", "Write failed with status: $result")
            }
        }
    }
```
> 8. ESP32 will receive the string and relay it back to the Mobile App
```
class MyCallbacks : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
    value = pCharacteristic->getValue().c_str();
    pCharacteristic->setValue(value);
    pCharacteristic->notify();
    Serial.println(value);
  }
};
```

> 10. We have intentionally introduced a 2-second delay between Receive and Send 
 ```
ElevatedButton(onPressed: (){
              connector("send");
              Timer(Duration(seconds: 2),() => {
                receive()
              },);
```
> The LED in ESP32 will blink ON/OFF every 10 milliseconds
```
void loop() {
  if (deviceConnected) {
    digitalWrite(led, HIGH);
    delay(1000);
  } else {
    digitalWrite(led, millis() / 100 % 2 == 0 ? HIGH : LOW);
  }
}
```

        
