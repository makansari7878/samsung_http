import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:samsung_http_proj/Dio_Demo.dart';
import 'package:samsung_http_proj/http_demo.dart';
import 'package:flutter/foundation.dart';
import 'package:samsung_http_proj/modal_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DioDemo()
    );
  }
}



