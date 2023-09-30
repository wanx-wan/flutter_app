import 'package:flutter/material.dart';
import 'package:ubuapp/widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'UBU App',
        theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)),
        home: MyHomePage(title: 'UBU App'),
      );
}
