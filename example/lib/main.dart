import 'package:example/icons/my_icons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Icon(MyIcons.MyiconChushi),
        ),
        body: Align(
          child: Icon(MyIcons.MyiconZhileng),
        ),
      ),
    );
  }
}
