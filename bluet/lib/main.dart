import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    connector("disconnect");
    super.dispose();
  }

  var channel = MethodChannel("com.example.bluet/blue");

  connector(String a)async{
    await channel.invokeMethod(a,{"value":controller.text});
  }

  var data1 = "";

  TextEditingController controller = TextEditingController(text: "12");

  receive()async{
    var data = await channel.invokeMethod("receive");
    setState(() {
      data1 = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("SMVITM ESP32 Connection Module"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Text("User Manual",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                Text("""Step 1:- Buy the ESP32 Module from https://robocraze.com/products/nodemcu-32-wifi-bluetooth-esp32-development-board30-pin?_pos=1&_psq=esp32&_ss=e&_v=1.0 Rs. 400\n\n
    Step 2:- Install Arduino IDE, Setup the IDE for the ESP32 as below.\n\n
    2a -> go to File-> Preferences -> Paste this URL http://arduino.esp8266.com/stable/package_esp8266com_index.json,https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json ->ok 
    2b -> load the firmware to IDE and download the required modules.\n
    2c -> Connect the ESP32 dev Board and select the board settings.\n2d -> Compile and check for errors.\n2e -> Upload to ESP32.\n

    Step 3:-check if led in ESP32 is blinking or not. if the light is blinking, then press the green button in the app.

    Step 4:- write any text on the text box and click on Get data button.""",textAlign: TextAlign.justify,),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              connector("connect");
            }, child: Text("Connect",style: TextStyle(fontSize: 30)),
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),),
            ElevatedButton(onPressed: (){
              connector("disconnect");
            }, child: Text("Disconnect",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight:FontWeight.bold)),
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              connector("send");
              Timer(Duration(seconds: 2),() => {
                receive()
              },);

            }, child: Text("Get data",style: TextStyle(fontSize: 30),)),
            Text("Data received from ESP32 ",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
            Text(data1,style: TextStyle(fontSize: 60),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
