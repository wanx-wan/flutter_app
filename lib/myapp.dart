import 'package:flutter/material.dart';
import '../mockup/data.dart';
import 'package:ubuapp/pages/coursedetail.dart';
import 'package:ubuapp/pages/myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => MyHomePage(title: 'UBU App'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
