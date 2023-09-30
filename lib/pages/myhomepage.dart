import 'package:flutter/material.dart';
import 'package:ubuapp/pages/loginpage.dart';
import 'package:ubuapp/widgets/coursecard.dart';
import '../mockup/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, this.email}) : super(key: key);

  final String title;
  final String? email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<dynamic> courses = [];
  bool isAdmin = true; // Change this based on authentication

  void _incrementCounter() {
    setState(() {
      _counter++;
      courses.add(randomCourse());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: toLoginPage,
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (BuildContext context, int i) => coursecard(course: courses[i]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void toLoginPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnimateLoginPage()));
  }
}
