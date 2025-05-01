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
        
