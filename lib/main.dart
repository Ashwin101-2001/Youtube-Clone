import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ytube_search/Wrapper.dart';
import 'Search.dart';
import 'home.dart';


void main() {
  //const oneSec = const Duration(seconds:1);
  //new Timer.periodic(oneSec, (Timer t) => print('hi!'));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes:
        {  'search': (context) => Search(),
          'home':(context) =>Home(),

        }
    );
  }
}
