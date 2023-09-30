import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:ubuapp/datacourse.dart';

class AnimateLoginPage extends StatelessWidget {
  final _formLogin = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pb = PocketBase('http://127.0.0.1:8090');

  Future<void> _login(BuildContext context) async {
    if (_formLogin.currentState?.validate() == false) return;
    final email = emailController.text, password = passwordController.text;
    if (email == "wancharoen.up.63@ubu.ac.th" && password == "adminubu1234") {
      try {
        if (await pb.admins.authWithPassword(email, password) != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage(title: email)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Form(
      key: _formLogin,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(controller: emailController),
            TextFormField(controller: passwordController, obscureText: true),
            ElevatedButton(onPressed: () => _login(context), child: Text('Submit')),
          ],
        ),
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final courses = <dynamic>[];

  void _incrementCounter() => setState(() => courses.add(randomCourse()));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(widget.title),
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [
        IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AnimateLoginPage())),
        ),
      ],
    ),
    body: Center(
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) => CourseCard(course: courses[index]),
      ),
    ),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(onPressed: _incrementCounter, child: const Icon(Icons.add)),
        IconButton(icon: Icon(Icons.input), onPressed: loaddata),
      ],
    ),
  );
}
