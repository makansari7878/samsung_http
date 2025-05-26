import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:samsung_http_proj/http_demo.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HttpDemo()
    );
  }
}*/


main() async{

  isolateFunction(SendPort mainSendPort){
    print('Worker Isolate is running');

    int heavyTask(){
      var sum = 0;
      for (var i = 0; i<100000 ; i++){
        sum = sum + i ;
      }
      return sum;
    }

    mainSendPort.send('Data from worker isolatte');
    var res = heavyTask();
    mainSendPort.send('heavy task res from worker isolate $res');
    mainSendPort.send('done');
  }
  
  final mainReceivePort = ReceivePort();
  print('Main isolate : starting on main isolate');
  
  Isolate.spawn(isolateFunction, mainReceivePort.sendPort);

  mainReceivePort.listen((message){
    print('Received msg from worker isolate on main isolate :  ${message}');

    if(message == 'done'){
      mainReceivePort.close();
    }
  });
  
}


